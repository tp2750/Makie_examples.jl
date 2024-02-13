using DataFrames
#using WGLMakie
using GLMakie
using RDatasets
using CategoricalArrays
using Observables

iris = dataset("datasets", "iris")

sizer = Observable(10*ones(Int64, size(iris,1))) # ones(Int64, size(iris,1))

f = Figure()
ax3 = Axis3(f[1,1], xlabel = "Sepal Length", ylabel = "Sepal Width", zlabel = "Petal Length")
scatter!(ax3, iris.SepalLength, iris.SepalWidth, iris.PetalLength; color = levelcode.(iris.Species), markersize = sizer)

menu1 = Menu(f[2,1], options = zip(levels(iris.Species),levels(iris.Species)))

on(menu1.selection) do s
    sizer[] = [i == s ? 20 : 10 for i in iris.Species]
end
