"""
    struct Grid

Represents a two-dimensional grid with uniform spacing in both x and y directions.

# Fields
- `lx::Float64`: The total length of the grid in the x-direction.
- `ly::Float64`: The total length of the grid in the y-direction.
- `dx::Float64`: The spacing between grid points in the x-direction.
- `dy::Float64`: The spacing between grid points in the y-direction.
- `xc::Vector{Float64}`: A vector of x-coordinates for the center of each grid cell.
- `yc::Vector{Float64}`: A vector of y-coordinates for the center of each grid cell.
- `Xc::Matrix{Float64}`: A matrix containing the x-coordinates of all grid cell centers.
- `Yc::Matrix{Float64}`: A matrix containing the y-coordinates of all grid cell centers.

The grid is constructed such that the coordinates represent the centers of grid cells.

# Constructor
    Grid(nx::Int, ny::Int)

Creates a `Grid` object with specified dimensions and number of cells.

# Arguments
- `nx::Int`: Number of grid cells along the x-direction.
- `ny::Int`: Number of grid cells along the y-direction.
"""
struct Grid
    lx::Float64  # Length in x-direction
    ly::Float64  # Length in y-direction
    dx::Float64  # Grid spacing in x-direction
    dy::Float64  # Grid spacing in y-direction
    xc::Vector{Float64}  # x-coordinates of grid cell centers
    yc::Vector{Float64}  # y-coordinates of grid cell centers
    Xc::Matrix{Float64}  # Matrix of x-coordinates for grid centers
    Yc::Matrix{Float64}  # Matrix of y-coordinates for grid centers
end

function Grid(nx::Int, ny::Int)
    @assert nx > 0 && ny > 0 "Number of grid cells must be positive"

    lx, ly = 250000.0, 200000.0  # domain size [m]
    dx, dy = lx / nx, ly / ny
    xc = LinRange(-lx / 2 + dx / 2, lx / 2 - dx / 2, nx)
    yc = LinRange(-ly / 2 + dy / 2, ly / 2 - dy / 2, ny)
    Xc, Yc = [x for x = xc, _ = yc], [y for _ = xc, y = yc]
    Grid(lx, ly, dx, dy, xc, yc, Xc, Yc)
end
