using DataFrames
using GLMakie #  WGLMakie
using RDatasets
using CategoricalArrays

iris = dataset("datasets", "iris")

f = Figure()
ax3 = Axis3(f[1,1])
scatter!(ax3, iris.SepalLength, iris.SepalWidth, iris.PetalLength; color = levelcode.(iris.Species), label = levels(iris.Species)) # , colormap = cgrad(:viridis; categorical=true)) string.(iris.Species) levels(iris.Species)

#scatter!(ax3, iris.SepalLength, iris.SepalWidth, iris.PetalLength; color = levelcode.(iris.Species), label = string.(iris.Species)) # , colormap = cgrad(:viridis; categorical=true)) string.(iris.Species) levels(iris.Species)

DataInspector(f)
#axislegend()

# f[1, 2] = Legend(f, ax3, "Species", framevisible = false)

cbar = Colorbar(f[1,2])
cbar.ticks = ([0, 0.5, 1], levels(iris.Species))
