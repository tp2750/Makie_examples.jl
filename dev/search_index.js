var documenterSearchIndex = {"docs":
[{"location":"sudoku/#Sudoku","page":"Sudoku","title":"Sudoku","text":"","category":"section"},{"location":"sudoku/","page":"Sudoku","title":"Sudoku","text":"A sodoku grid made with major and minor grid-lines.","category":"page"},{"location":"sudoku/","page":"Sudoku","title":"Sudoku","text":"function mk_axis(ax)\nAxis(ax,     aspect = DataAspect(),\n     xgridcolor = :black,\n     ygridcolor = :black,\n     xgridwidth = 3,\n     ygridwidth = 3,\n     xminorgridcolor = :black,\n     yminorgridcolor = :black,\n     xminorgridvisible = true,\n     yminorgridvisible = true,\n     xminorticks = IntervalsBetween(3),\n     yminorticks = IntervalsBetween(3),\n     xticksvisible = false,\n     xticklabelsize = 0.0, \n     yticklabelsize = 0.0, \n     yticksvisible = false,\n     )\nend\n\nfunction plot_mat!(ax,mat)\n  i, j = size(mat)\n  text!(ax,\n        vec(Point2f.(Tuple.(CartesianIndices(mat)))) .- repeat([[0.5, 0.5]], i*j ),\n        text = vec(string.(rotr90(mat))), \n        align = (:center,:center),\n        )\n  xlims!(0,i)\n  ylims!(0,j)\nend\n\nmat = reshape(collect(1:81), 9,9)\nf = Figure()\nax1 = mk_axis(f[1,1])\nplot_mat!(ax1,mat)\nf\n","category":"page"},{"location":"sudoku/","page":"Sudoku","title":"Sudoku","text":"(Image: sudoku1)","category":"page"},{"location":"plot3d/#Plot-3D","page":"plot3d","title":"Plot 3D","text":"","category":"section"},{"location":"plot3d/","page":"plot3d","title":"plot3d","text":"3D plot with color variable.","category":"page"},{"location":"plot3d/","page":"plot3d","title":"plot3d","text":"using GLMakie\nusing DataFrames\nusing RDatasets\nusing CategoricalArrays\n\n\niris = dataset(\"datasets\", \"iris\")\n\n\nfunction plot3d(df; x_var=:x , y_var=:y, z_var=:z, color_var=:color)\n    x_dat = df[:,x_var]\n    y_dat = df[:,y_var]\n    z_dat = df[:,z_var]\n    color_dat = df[:,color_var]\n    color_levels = unique(color_dat)\n    fig = Figure()\n    ax = Axis3(fig[1,1], xlabel = string(x_var), ylabel = string(y_var), zlabel=string(z_var))\n    for c in color_levels\n        scatter!(ax, x_dat[color_dat .== c], y_dat[color_dat .== c], z_dat[color_dat .== c], label = c)\n    end\n    axislegend()\n    (;fig,ax)\nend\n\nfig, ax = plot3d(iris, x_var = :SepalLength, y_var = :SepalWidth, z_var = :PetalLength, color_var = :Species)\n\nfig\n","category":"page"},{"location":"plot3d/","page":"plot3d","title":"plot3d","text":"(Image: plot3d)","category":"page"},{"location":"plot3d/","page":"plot3d","title":"plot3d","text":"Saving plot:","category":"page"},{"location":"plot3d/","page":"plot3d","title":"plot3d","text":"save(\"plot3d.png\", fig)","category":"page"},{"location":"interactive_histogram/#Interactive-Histogram","page":"Interactive Histogram","title":"Interactive Histogram","text":"","category":"section"},{"location":"interactive_histogram/#Purpose","page":"Interactive Histogram","title":"Purpose","text":"","category":"section"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"Build an interactive histogram from a static one.","category":"page"},{"location":"interactive_histogram/#Static-Histogram","page":"Interactive Histogram","title":"Static Histogram","text":"","category":"section"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"f = Figure()\no_data = randn(1000);\no_bins = 10;\nhist!(Axis(f[1,1]), o_data, bins = o_bins) ","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"(Image: hist1)","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"Saving the histogram is done by","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"julia> save(\"hist1.png\", f)","category":"page"},{"location":"interactive_histogram/#Dynamic-bins","page":"Interactive Histogram","title":"Dynamic bins","text":"","category":"section"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"The slider has it's value as an observable as the value slot. Note that the call to hist! is un-changed.","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"f = Figure()\nsl1 = Makie.Slider(f[2,1], range = 1:100, startvalue = 5)\no_bins = sl1.value\no_data = randn(1000);\nhist!(Axis(f[1,1]), o_data, bins = o_bins) ","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"(Image: hist 2)","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"Generating the animation is done using the record function and forcing the slider using set_close_to:","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"force = [5:95; 95:-1:5]\nrecord(f, \"hist2.gif\", force; framerate = 20) do b\n  set_close_to!(sl1, b) \nend","category":"page"},{"location":"interactive_histogram/#Annotated-sliders","page":"Interactive Histogram","title":"Annotated sliders","text":"","category":"section"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"If we use SliderGrid, we get multiple sliders, and annotation of name and value:","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"f = Figure()\nsg = SliderGrid(f[2,1],\n                (label = \"bins\", range = 1:100, startvalue=5),\n                (label = \"points\", range = 100:1:1000, startvalue=500),\n                )\no_bins = sg.sliders[1].value\no_data = @lift randn($(sg.sliders[2].value))\nhist!(Axis(f[1,1]), o_data, bins = o_bins) ","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"(Image: hist 3)","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"Note, the call to hist!() is still the same.","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"We can animate both using zip","category":"page"},{"location":"interactive_histogram/","page":"Interactive Histogram","title":"Interactive Histogram","text":"force1 = [5:95; 95:-1:5]\nforce2 = [100:10:1000; 1000:-10:100]\nforce = zip(force1, force2)\nrecord(f, \"hist3.gif\", force; framerate = 20) do b\n  set_close_to!(sg.sliders[1], b[1]) \n  set_close_to!(sg.sliders[2], b[2]) \nend","category":"page"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = Makie_examples","category":"page"},{"location":"#Makie_examples","page":"Home","title":"Makie_examples","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"Documentation for Makie_examples.","category":"page"},{"location":"","page":"Home","title":"Home","text":"","category":"page"},{"location":"","page":"Home","title":"Home","text":"Modules = [Makie_examples]","category":"page"}]
}
