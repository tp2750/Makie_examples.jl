using DataFrames
#using WGLMakie
using GLMakie
using RDatasets
using CategoricalArrays
using Observables
using StatsBase

C1 = 1_000_000
df = DataFrame(x1 = randn(C1), y1 = rand(C1), z1 = sin.(rand(C1)), name = categorical(sample(["A", "B", "C"], C1)))

sizer = Observable(10*ones(Int64, size(df,1)))

f = Figure()
ax3 = Axis3(f[1,1])
scatter!(ax3, df.x1, df.y1, df.z1; color = levelcode.(df.name), markersize = sizer)

menu1 = Menu(f[2,1], options = zip([levels(df.name); " "], [levels(df.name); " "]))

on(menu1.selection) do s
    sizer[] = [i == s ? 20 : 10 for i in df.name]
end
