"""
    module IceFlow

A Julia module for simulating and visualizing ice flow dynamics.

The `IceFlow` module provides a set of tools for modeling the dynamics of ice flow over a two-dimensional grid.
It includes functionality for defining the grid and ice flow parameters, performing numerical simulations, and visualizing the results.

# Exports
- `Grid`: A struct for defining the spatial grid properties.
- `Data`: A struct for encapsulating ice flow parameters and synthetic data generation.
- `solver`: A function for simulating ice flow dynamics.
- `visualise`: A function for visualizing simulation results.

# Usage
To use `IceFlow`, import the module and set up your simulation environment,
perform simulations, and visualize the results.

```julia
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
```
"""
module IceFlow

export Grid, Data
export solver, visualise
export s2yr, ρg

using Printf, UnPack
using CairoMakie

# constants
const s2yr = 31557600     # seconds to years
const ρg   = 910.0 * 9.81 # ice density x gravity

include("grid_data.jl")
include("solvers.jl")
include("synthetic_data.jl")
include("utils.jl")

end # module IceFlow
