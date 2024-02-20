using Test
using IceFlow

@testset "average" begin

    mat = [1 2 3; 7 9 11; 2 4 6]

    @test IceFlow.av(mat) == [4.75 6.25; 5.5 7.5]
    @test IceFlow.avx(mat) == [4.0 5.5 7.0; 4.5 6.5 8.5]
    @test IceFlow.avy(mat) == [ 1.5 2.5; 8.0 10.0; 3.0 5.0]
end

@testset "grid" begin

    grid = Grid(5, 6)

    @test grid.lx == 250000.0
    @test grid.ly == 200000.0
    @test grid.dx == 50000.0
    @test isapprox(grid.dy, 33333.3; atol = 1e-1)
    @test grid.xc == [-100000.0, -50000.0, 0.0, 50000.0, 100000.0]
    @test isapprox(grid.yc, [-83333.3, -50000.0, -16666.6, 16666.6, 50000.0, 83333.3]; atol = 1)
end

@testset "data" begin

    grid = Grid(5, 6)

    β_t = 0.1
    c_t = 0.5
    a1_t = 1e-18
    a2_t = 1e-20

    β, c, a1, a2 = β_t, c_t, a1_t, a2_t

    data = Data(β, c, a1, a2, grid)

    @test data.β == β_t
    @test data.c == c_t
    @test data.a1 == a1_t
    @test data.a2 == a2_t

    @test isapprox(data.B[3,3], 5593.31; atol = 1e-1)
    @test isapprox(data.ELA[3, :], [1794.69, 1929.52, 2075.17, 2224.83, 2370.48, 2505.31]; atol = 1e-1)
end
