using GLMakie

function plot_mat!(ax,mat)
  i, j = size(mat)
  text!(ax,
        vec(Point2f.(Tuple.(CartesianIndices(mat)))) .- repeat([[0.5, 0.5]], i*j ),
        text = vec(string.(rotr90(mat))), 
        align = (:center,:center),
        )
  xlims!(0,i)
  ylims!(0,j)
#  hidexdecorations!(ax)
end

function mk_axis(ax)
Axis(ax,     aspect = DataAspect(),
    xgridcolor = :black,
    ygridcolor = :black,
    xgridwidth = 2,
    ygridwidth = 2,
    xminorgridcolor = :black,
    yminorgridcolor = :black,
    xminorgridvisible = true,
    yminorgridvisible = true,
    xminorticks = IntervalsBetween(3),
    yminorticks = IntervalsBetween(3),
                  )
end

mat = reshape(collect(1:81), 9,9)

f = Figure()
ax1 = mk_axis(f[1,1])
plot_mat!(ax1,mat)
ax2 = mk_axis(f[2,1])
plot_mat!(ax2,mat)
ax3 = mk_axis(f[1,2])
plot_mat!(ax3,mat)
ax4 = mk_axis(f[2,2])
plot_mat!(ax4,mat)

f

deactivate_interaction!(ax1, :rectanglezoom)
register_interaction!(ax1, :my_interaction) do event, axis ## click on a sequence https://docs.makie.org/stable/reference/blocks/axis/#registering_and_deregistering_interactions
    if event.type === MouseEventTypes.leftclick
        pos = event.data
        row = 10 - Int(ceil(pos[2]))
        col = Int(ceil(pos[1]))
        println("Graph axis position: $pos. row: $row, col = $col")
    end
end
