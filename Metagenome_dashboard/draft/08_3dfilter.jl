## idea for color legend:
## loop over color levels and lot

using GLMakie
using DataFrames
using RDatasets
using CategoricalArrays
using DataFramesMeta
using Observables

iris = dataset("datasets", "iris")
iris_o = Observable(iris)


function plot3d(df; x_var=:x , y_var=:y, z_var=:z, color_var=:color)
    x_dat = df[:,x_var]
    y_dat = df[:,y_var]
    z_dat = df[:,z_var]
    color_dat = df[:,color_var]
    color_levels = unique(color_dat)
    fig = Figure()
    ax = Axis3(fig[1,1], xlabel = string(x_var), ylabel = string(y_var), zlabel=string(z_var))
    for c in color_levels
        scatter!(ax, x_dat[color_dat .== c], y_dat[color_dat .== c], z_dat[color_dat .== c], label = c)
    end
    axislegend()
    (;fig,ax)
end

plot3d_obs(df::Observable{DataFrame}; x_var=:x , y_var=:y, z_var=:z, color_var=:color) = plot3d(df[]; x_var, y_var, z_var, color_var)

function dashboard3d(df::Observable{DataFrame}; x_var=:x , y_var=:y, z_var=:z, color_var=:color, filter_var = :filter)
    filter_levels = levels(df[][:,filter_var])
    fig, ax = plot3d_obs(df;  x_var, y_var, z_var, color_var)
    menu = Menu(fig[2,1], options = zip([filter_levels; ""], [filter_levels; ""]), default = "")
    (;fig,ax, menu, filter_var)
end



## fig, ax = plot3d_obs(iris_o, x_var = :SepalLength, y_var = :SepalWidth, z_var = :PetalLength, color_var = :Species)
fig, ax, menu, filter_var = dashboard3d(iris_o, x_var = :SepalLength, y_var = :SepalWidth, z_var = :PetalLength, color_var = :Species, filter_var = :Species)

on(menu.selection) do s
    iris_o[] = subset(iris_o[], filter_var => ByRow(x-> contains(string(x),s)))
end


fig
