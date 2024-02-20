# IceFlow.jl

[![Build Status](https://github.com/Unil-SGC/IceFlow.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Unil-SGC/IceFlow.jl/actions/workflows/CI.yml?query=branch%3Amain)

## Overview
`IceFlow.jl` is a Julia package for simulating and visualising ice flow dynamics. It offers tools for setting up grid-based simulations, running numerical solvers, and visualising the results.

## Features
- **Grid Setup**: Define spatial grids for simulations.
- **Data Handling**: Manage ice flow parameters and synthetic data.
- **Simulation**: Numerically simulate ice dynamics over a grid.
- **Visualization**: Visualise simulation results.

## Installation
To install `IceFlow.jl`, use the Julia package manager:
```julia
using Pkg
Pkg.add("https://github.com/Unil-SGC/IceFlow.jl")
```

## Usage
The [`run_example.jl`](run_example.jl) script provides an example on how to run `IceFlow.jl`:

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

## Documentation
For more detailed documentation, query the help from within the REPL:
```julia-repl
julia> ?

help?> IceFlow

help?> IceFlow
search: IceFlow

  module IceFlow

  # [...]
```

## Contributing
Contributions to `IceFlow.jl` are welcome!

## License
`IceFlow.jl` is licensed under MIT License.

## Authors
- [Ludovic Räss](https://github.com/luraess)
