using GLMakie
f = Figure()
ax=Axis(f[1,1])
msa = reshape(repeat(string.('A':'Z'),2),26,2)

