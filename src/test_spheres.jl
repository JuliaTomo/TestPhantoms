include("../src/analytic/spheres.jl")
using Plots
using NPZ, BSON
using BSON: @save
    
function save_spheres(ddata="../data/sphere/")
    
    nangles = 30
    angles = 0:pi/nangles:pi
    angles = collect(angles)[1:end-1]
    height=64
    width=64

    centers = Array([10.0 5.0 0]')
    radii = [10.0]
    p = gen_spheres(centers, radii, angles, height, width)

    #ani = @animate 
    for ang=1:length(angles)
        plot(Gray.(p[ang,:,:] ./ maximum(p[ang,:,:])), title="ang: $(angles[ang])")
    end

    p ./= height

    # gif(ani, "~/Desktop/test_spheres.gif", fps=4)

    # save result
    ddata = "../data/sphere/"
    mkpath(ddata)
    fproj = "$ddata/sinogram.npy"
    NPZ.npzwrite(fproj, p)

    proj_geom = Dict(:type=>"parallel3d",:ProjectionAngles=>angles,
                    :DetectorRowCount=>height, :DetectorColCount=>width,
                    :DetectorSpacingX=>2/height, :DetectorSpacingY=>2/width)

    @save "$ddata/proj_geom.bson" proj_geom
    # @save "$ddata/proj_geom.bson" proj_geom
    # @save fproj p

end
