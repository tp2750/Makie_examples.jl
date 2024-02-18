using DataFrames
using WGLMakie
#using GLMakie
using RDatasets
using CategoricalArrays
using Observables
using StatsBase
using DataFramesMeta


function gen_data(rows=1_000_000)
    DataFrame(x1 = randn(rows), y1 = rand(rows), z1 = sin.(rand(rows)), name = categorical(sample(["A", "B", "C"], rows)))
end

import Base.size
size(df::Observable{DataFrame}, dim::Int64) = size(df[], dim) ## Type pirate!

function plot_genomes(df; use_alpha=true)
    sizer = Observable(10*ones(Int64, size(df,1)))
    alpha = Observable(ones(Float64, size(df,1)))
    # col = @lift collect(zip(levelcode.(df.name), $alpha)) # Not working https://github.com/MakieOrg/Makie.jl/issues/2232
    colors = [:blue, :orange, :green, :magenta, :cyan, :brown, :yellow]
    col = levelcode.(df.name)
    siz = sizer
    if use_alpha
        col = @lift collect(zip(colors[mod1.(levelcode.(df.name), length(colors))], $alpha))
        siz = 10*ones(Int64, size(df,1))
    end
    @info typeof(col[])
    f = Figure()
    ax3 = Axis3(f[1,1],
                xlabel = names(df)[1],
                ylabel = names(df)[2],
                zlabel = names(df)[3],
                )
    scatter!(ax3, df.x1, df.y1, df.z1;
             color = col,
             markersize = siz,
             )
    (;f,ax=ax3, sizer, alpha)

end

function mk_dashboard(fig, ax)
    menu = Menu(fig[2,1], options = zip([levels(df.name); ""], [levels(df.name); ""]), default = "")
    (;fig,ax, menu)
end

C1 = 1_000_000

df = Observable(gen_data(C1)) ## TODO: This needs more work: some preprocessing function to extract size(df,1), names(df), df.name etc and put it in kw arguments. Then the plot function can probably be generic.
fig, ax, sizer, alpha = plot_genomes(df)
_, _, menu = mk_dashboard(fig, ax)

on(menu.selection) do s
    df[] = @subset(df[], contains(s).(:name))
end

fig
