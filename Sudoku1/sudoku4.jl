using GLMakie
using Observables
using IterTools: chain

const base = 3
const width = base*base
const entries = width*width*width
const dims = (width, width, width)
const nr, nc, nf = dims
const vals = "123456789"[1:width]

squares = reshape(1:entries, dims...)
rows = [squares[i, j, :] for i in 1:dims[1] for j in 1:dims[2]]
cols = [squares[i, :, k] for i in 1:dims[1] for k in 1:dims[3]]
fils = [squares[:, j, k] for j in 1:dims[2] for k in 1:dims[3]]

span(i) = base*(i-1)+1:base*i
subs = vcat(
    [vec(squares[span(i), span(j), k]) for i in 1:base for j in 1:base for k in 1:width] ,
    [vec(squares[span(i), j, span(k)]) for i in 1:base for j in 1:width for k in 1:base] ,
    [vec(squares[i, span(j), span(k)]) for i in 1:width for j in 1:base for k in 1:base] )
unitlist = collect(chain(rows, cols, fils, subs))

units = [filter(u -> s in u, unitlist) for s in squares]
peers = [Set(vcat(map(collect, units[s])...)) for s in squares]
for (i, p) in enumerate(peers)
    pop!(p, i)
end

function plot_mat!(ax,mat)
  dims = @lift size($mat)
  i = @lift $dims[1]; j = @lift $dims[2];

  text!(ax,
        (@lift vec(Point2f.(Tuple.(CartesianIndices($mat)))) .- repeat([[0.5, 0.5]], $i*$j )),
        text = (@lift vec(string.(rotr90($mat)))), 
        align = (:center,:center),
        )
  xlims!(0,i[])
  ylims!(0,j[])
#  hidexdecorations!(ax)
end

function color_mat!(ax, mat)
    dims = @lift size($mat)
    i = @lift $dims[1]; j = @lift $dims[2];

    color_mat = @lift rotr90($mat) 
    hm = heatmap!(ax, color_mat, colormap = tuple.([:white, :green, :blue], 0.25), colorrange = (0,2),  inspectable = false)
    # hm = heatmap!(ax, color_mat) #, color_map = tuple.([:white]), alpha = 0.5, inspectable = false)
    translate!(hm, -0.5, -0.5, -1.0)
end

function mk_axis(ax)
Axis(ax,     aspect = DataAspect(),
    xgridcolor = :black,
    ygridcolor = :black,
    xgridwidth = 3,
    ygridwidth = 3,
    xminorgridcolor = :black,
    yminorgridcolor = :black,
    xminorgridvisible = true,
    yminorgridvisible = true,
    xminorticks = IntervalsBetween(base),
    yminorticks = IntervalsBetween(base),
    xticksvisible = false,
    xticklabelsize = 0.0, 
    #xticks = ([0, 2, 4], ["", "", ""]),
#    xticks = ([0, 2, 4]),
    yticksvisible = false,
    yticklabelsize = 0.0, 
    #yticks = ([0,2,4], ["", "", ""]),
#    yticks = ([0,2,4])
                  )
end


function plot_3d_mat!(fig, mat, colors)
    axs = []
    n = size(mat[])[end]
    dim = Int(sqrt(n))
    ix = reshape(1:n, dim, dim)
    for (idx, val) in pairs(ix) 
        ax = mk_axis(f[Tuple(idx)...])
        push!(axs, ax)
        plot_mat!(ax, (@lift $mat[:,:,val]))
        color_mat!(ax, (@lift $colors[:,:,val]))

        deactivate_interaction!(ax, :rectanglezoom)
        register_interaction!(ax, :my_interaction) do event::MouseEvent, axis ## click on a sequence https://docs.makie.org/stable/reference/blocks/axis/#registering_and_deregistering_interactions
            if event.type === MouseEventTypes.leftclick
                pos = event.data
                row = (width+1) - Int(ceil(pos[2]))
                col = Int(ceil(pos[1]))
                println("Graph axis position: $pos. row: $row, col = $col, ix = $(ix[idx]), value: $(mat[][row, col, ix[idx]])")
                cur_idx[] = (row, col, ix[idx])
            end
        end

    end
end

sudoku = Observable(reshape(collect(1:entries), dims...))
cur_idx = Observable((1, 1, 1))
color_sudoku = Observable(reshape([[1, 2]; repeat([0], entries-2)], dims...))
cur_threats = @lift peers[squares[$cur_idx...]]
color_sudoku = @lift reshape([if i == squares[$cur_idx...]
                                1
                              elseif i in $cur_threats
                                2
                              else 
                                0
                              end
                              for i in 1:entries], dims...)

f = Figure()
plot_3d_mat!(f, sudoku, color_sudoku)

f
