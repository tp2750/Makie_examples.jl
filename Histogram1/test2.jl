using GLMakie
using Observables


# Static
f = Figure()
o_data = randn(1000)
o_bins = 10
hist!(Axis(f[1,1]), o_data, bins = o_bins) 

# Dynamic bins
f = Figure()
sl1 = Makie.Slider(f[2,1], range = 1:100, startvalue = 5)
o_bins = sl1.value
o_data = randn(1000)
hist!(Axis(f[1,1]), o_data, bins = o_bins) 

# Dynamic points
f = Figure()
sl1 = Makie.Slider(f[2,1], range = 1:100, startvalue = 5)
sl2 = Makie.Slider(f[3,1], range = 100:100:1000, startvalue = 100)
o_bins = sl1.value
o_data = @lift(randn($(sl2.value)))
hist!(Axis(f[1,1]), o_data, bins = o_bins) 

# Annotate using SliderGrid
f = Figure()
sg = SliderGrid(f[2,1],
                (label = "bins", range = 1:100, startvalue=5),
                (label = "points", range = 100:10:1000, startvalue=500),
                )
o_bins = sg.sliders[1].value
o_data = @lift randn($(sg.sliders[2].value))
hist!(Axis(f[1,1]), o_data, bins = o_bins) 

