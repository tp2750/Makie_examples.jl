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
  deactivate_interaction!(ax, :rectanglezoom)
#  hidexdecorations!(ax)
  register_interaction!(ax1, :my_interaction) do event::MouseEvent, axis ## click on a sequence https://docs.makie.org/stable/reference/blocks/axis/#registering_and_deregistering_interactions
    if event.type === MouseEventTypes.leftclick
        pos = event.data
        row = 10 - Int(ceil(pos[2]))
        col = Int(ceil(pos[1]))
        println("Graph axis position: $pos. row: $row, col = $col")
    end
  end
end

function color_mat!(ax, mat)
  i, j = size(mat)
  color_mat = rotr90(mat) 
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
     xminorticks = IntervalsBetween(3),
     yminorticks = IntervalsBetween(3),
     xticksvisible = false,
     xticks = ([0,3,6,9], ["","","",""]),
     yticksvisible = false,
     yticks = ([0,3,6,9], ["","","",""]),
     )
end

mat = reshape(collect(1:81), 9,9)
mat2 = reshape([[1, 2]; repeat([0],79)], 9,9)
f = Figure()
ax1 = mk_axis(f[1,1])
plot_mat!(ax1,mat)
color_mat!(ax1, mat2)


f
