using IceFlow
using CairoMakie

# physics
β      = 0.01                  # mass-balance slope
c      = 2.0                   # mass-balance limiter
a1     = 1.9e-24 * ρg^3 * s2yr # ice flow parameter
a2     = 5.7e-20 * ρg^3 * s2yr # ice flow parameter

# numerics
resol  = 256
nt     = 1e4                 # number of time steps
dt     = 0.1                 # time step [yr]
nout   = 1e3                 # visu and error checking interval
ϵ      = 1e-4                # steady state tolerance
grid   = Grid(resol, resol)
data   = Data(β, c, a1, a2, grid)

# run and visualise the results
visualise(solver(data, grid, nt, dt, nout, ϵ)...)
