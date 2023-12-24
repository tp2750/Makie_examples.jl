using GLMakie

f = Figure()
ax1 = Axis(f[1,1], )

f, ax, hm = heatmap(randn(9, 9), colormap = :Blues, colorrange = (-2, 8),
  axis = (;
    aspect = DataAspect(),
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
#    xmajorticks = IntervalsBetween(4),
#    ymajorticks = IntervalsBetween(4),
  ))
translate!(hm, -0.5, -0.5, -100)
xlims!(0,9)
ylims!(0,9)
text!(ax, (1:9) .- 0.5, (1:9) .- 0.5, text = string.(1:9), align = (:center,:center))
f

mat = reshape(collect(1:81), 9,9)
text!(ax, vec(Point2f.(Tuple.(CartesianIndices(mat)))) .- repeat([[0.5, 0.5]],81), text = vec(string.(mat)), align = (:center,:center))


f = Figure()
ax = Axis(f[1,1],     aspect = DataAspect(),
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

mat = reshape(collect(1:81), 9,9)
plot_mat!(ax,mat)


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

f = Figure()
ax1 = mk_axis(f[1,1])
plot_mat!(ax1,mat)
ax2 = mk_axis(f[2,1])
plot_mat!(ax2,mat)
ax3 = mk_axis(f[1,2])
plot_mat!(ax3,mat)
ax4 = mk_axis(f[2,2])
plot_mat!(ax4,mat)
