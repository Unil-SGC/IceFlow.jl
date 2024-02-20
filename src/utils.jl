"""
    av(A)

Compute the average in `x` and `y` dimension.
"""
@views av(A) = 0.25 .* (A[1:end-1, 1:end-1] .+ A[1:end-1, 2:end] .+ A[2:end, 1:end-1] .+ A[2:end, 2:end])

"""
    avx(A)

Compute the average in `x` dimension.
"""
@views avx(A) = 0.5 .* (A[1:end-1, :] .+ A[2:end, :])

"""
    avy(A)

Compute the average in `y` dimension.
"""
@views avy(A) = 0.5 .* (A[:, 1:end-1] .+ A[:, 2:end])

"""
    visualise(S, H, B, grid) -> Figure

Visualise the ice flow simulation results over a specified grid.

# Arguments
- `S`: A matrix representing the surface elevation of the ice.
- `H`: A matrix representing the ice thickness.
- `B`: A matrix representing the bedrock elevation.
- `grid`: A `Grid` object containing the grid properties and coordinates.

# Description
This function creates a 2.5D visualisation of the ice flow simulation results. It displays the bedrock elevation and the surface elevation where ice thickness is greater than a minimal threshold (here 0.01 meters).
"""
@views function visualise(S, H, B, grid)
    S_v = fill(NaN, size(S))
    S_v .= S; S_v[H .<= 0.01] .= NaN
    fig = Figure(; size=(1000, 450), fontsize=20)
    axs = Axis3(fig[1, 1][1, 1]; xlabel="x [km]", ylabel="y [km]", zlabel="elevation [m]", zlabeloffset = 70, aspect=(4, 4, 1), azimuth=pi / 4)
    plt = (p1=surface!(axs, grid.xc ./ 1e3, grid.yc ./ 1e3, B, colormap=Reverse(:cork)),
           p2=surface!(axs, grid.xc ./ 1e3, grid.yc ./ 1e3, S_v, colormap=:davos),
    )
    subgrid = GridLayout(fig[1, 1][1, 2], tellheight=false)
    Label(subgrid[1, 1], "H ice [m]")
    Colorbar(subgrid[2, 1], plt.p2; halign=:center)
    resize_to_layout!(fig)
    return display(fig)
end
