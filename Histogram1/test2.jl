using GLMakie

# Static
f = Figure()
o_data = randn(1000);
o_bins = 10;
hist!(Axis(f[1,1]), o_data, bins = o_bins) 

# Dynamic bins
f = Figure()
sl1 = Makie.Slider(f[2,1], range = 1:100, startvalue = 5)
o_bins = sl1.value
o_data = randn(1000);
hist!(Axis(f[1,1]), o_data, bins = o_bins) 

# Record animation
force = [5:95; 95:-1:5]
record(f, "hist2.mp4", force; framerate = 20) do b
  set_close_to!(sl1, b) 
end

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
                (label = "points", range = 100:1:1000, startvalue=500),
                )
o_bins = sg.sliders[1].value
o_data = @lift randn($(sg.sliders[2].value))
hist!(Axis(f[1,1]), o_data, bins = o_bins) 

# Record animation
force1 = [5:95; 95:-1:5]
force2 = [100:10:1000; 1000:-10:100]
force = zip(force1, force2)
record(f, "hist3.gif", force; framerate = 20) do b
  set_close_to!(sl1, b[1]) 
  set_close_to!(sl2, b[2]) 
end
