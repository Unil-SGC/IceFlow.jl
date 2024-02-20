"""
    compute_D!(D, H, S, dSdx, dSdy, Snorm, a1, a2, dx, dy)

Compute the effective nonlinear diffusion coefficient `D` for SIA model.
"""
@views function compute_D!(D, H, S, dSdx, dSdy, Snorm, a1, a2, dx, dy)
    dSdx  .= diff(S, dims=1) ./ dx
    dSdy  .= diff(S, dims=2) ./ dy
    Snorm .= ((avy(dSdx) .^ 2) .+ (avx(dSdy) .^ 2)) .^ 0.5
    D     .= ((a1 .* av(H) .^ 5) .+ (a2 .* av(H) .^ 3)) .* Snorm .^ 2
    return
end

"""
    solver(data::Data, grid::Grid, nt, dt, nout, ϵ) -> Tuple

Simulate ice flow dynamics over a given grid using specified parameters.

# Arguments
- `data::Data`: A `Data` object containing the parameters `B0`, `β`, `c`, `B`, and `ELA`.
- `grid::Grid`: A `Grid` object defining the spatial domain and grid properties.
- `nt`: The number of time steps for the simulation.
- `dt`: Time step size.
- `nout`: Output frequency for logging and error checking.
- `ϵ`: Convergence criterion for the iterative process.

# Returns
A tuple containing:
- `S`: Surface elevation.
- `H`: Ice thickness.
- `B`: Bedrock elevation.
- `grid`: The `Grid` object.
"""
@views function solver(data, grid, nt, dt, nout, ϵ)
    @unpack β, c, a1, a2, B, ELA = data
    dx, dy = grid.dx, grid.dy
    nx, ny = size(B)
    # initialise
    S      = zeros(nx  , ny  )
    dSdx   = zeros(nx-1, ny  )
    dSdy   = zeros(nx  , ny-1)
    Snorm  = zeros(nx-1, ny-1)
    D      = zeros(nx-1, ny-1)
    qx     = zeros(nx-1, ny-2)
    qy     = zeros(nx-2, ny-1)
    H      = zeros(nx  , ny  )
    M      = zeros(nx  , ny  )
    H0     = zeros(nx  , ny  )
    # time loop
    for it = 1:nt
        H0 .= H
        S  .= B .+ H
        M  .= min.(β .* (S .- ELA), c)
        compute_D!(D, H, S, dSdx, dSdy, Snorm, a1, a2, dx, dy)
        qx .= avy(D) .* diff(S[:, 2:end-1], dims=1) ./ dx
        qy .= avx(D) .* diff(S[2:end-1, :], dims=2) ./ dy
        H[2:end-1, 2:end-1] .= max.(H[2:end-1, 2:end-1] .+ dt .* (diff(qx, dims=1) + diff(qy, dims=2) + M[2:end-1, 2:end-1]), 0.0)
        if mod(it, nout) == 0
            # error checking
            err = maximum(abs.(H .- H0))
            @printf("it = %d, err = %1.3e \n", it, err)
            (err < ϵ) && break
        end
    end
    return (S, H, B, grid)
end
