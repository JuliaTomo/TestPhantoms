function proj_sphere(y, x, center, r, theta)
    t1 = r^2 - (y-center[3])^2 - (x - center[1]*cos(theta)-center[2]*sin(theta))^2 
    if t1 < 0
        return 0
    else
        return 2*sqrt(t1)
    end
end


@doc raw"""
    gen_sphers(centers, radii)

Generate 3D sinogram given the array centers [3 x N] and radii [N].

``p(\theta, a, b) = 2\sqrt{ r^2 - (a - z_0)^2 - (b - x_0 \cos\theta - y_0\sin\theta)^2 }``

# Args

- centers
- radii
- angles
- height : size of detector height
- width : size of detector width
"""
function gen_spheres(centers, radii, angles, height, width)
    
    nobj = size(centers, 2)
    p = zeros(length(angles), height, width)

    aa = (1:1.0:height) .- 0.5 .- (height / 2)
    bb = (1:1.0:width) .- 0.5 .- (width / 2)

    AA = repeat(aa, 1, length(bb))
    BB = repeat(bb', length(aa), 1)

    for iobj=1:nobj
        for iang=1:length(angles)
            p[iang, :, :] += map((y,x) -> proj_sphere(y,x,centers[:,iobj],radii[iobj],angles[iang]), AA, BB)
        end
    end

    return p
end
