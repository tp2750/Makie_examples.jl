using DataFrames
using WGLMakie
#using GLMakie
using RDatasets
using CategoricalArrays
using Observables
using StatsBase

C1 = 1_000_000

df = gen_data(C1)
fig, ax, sizer, alpha = plot_genomes(df)
_, _, menu = mk_dashboard(fig, ax)

on(menu.selection) do s
    sizer[] = [i == s ? 20 : 10 for i in df.name]
    alpha[] = [i == s ? 1. : 0.1 for i in df.name]
end

fig
