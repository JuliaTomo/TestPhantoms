include("./spheres.jl")

angles = 0:0.1:pi 
height=128
width=196
centers = Array([0.0 0 0; 20 20 40]')
radii = [30.0, 10]
p = gen_spheres(centers, radii, angles, height, width)

using Plots
ani = @animate for ang=1:length(angles)
    plot(Gray.(p[ang,:,:] ./ maximum(p[ang,:,:])), title="ang: $(angles[ang])")
end

gif(ani, "~/Desktop/test_spheres.gif", fps=4)
