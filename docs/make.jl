using Makie_examples
using Documenter

DocMeta.setdocmeta!(Makie_examples, :DocTestSetup, :(using Makie_examples); recursive=true)

makedocs(;
    modules=[Makie_examples],
    authors="Thomas Poulsen <ta.poulsen@gmail.com> and contributors",
    repo="https://github.com/tp2750/Makie_examples.jl/blob/{commit}{path}#{line}",
    sitename="Makie_examples.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://tp2750.github.io/Makie_examples.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/tp2750/Makie_examples.jl",
    devbranch="main",
)
