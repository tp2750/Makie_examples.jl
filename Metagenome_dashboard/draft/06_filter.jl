using DataFrames
using WGLMakie
#using GLMakie
using RDatasets
using CategoricalArrays
using Observables
using StatsBase
using DataFramesMeta

C1 = 1_000_000

df = Observable(gen_data(C1)) ## TODO: This needs more work: some preprocessing function to extract size(df,1), names(df), df.name etc and put it in kw arguments. Then the plot function can probably be generic.
fig, ax, sizer, alpha = plot_genomes(df)
_, _, menu = mk_dashboard(fig, ax)

on(menu.selection) do s
    df[] = @subset(df[], contains(s).(:name))
end

fig
