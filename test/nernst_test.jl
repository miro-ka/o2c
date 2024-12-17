using Test
using o2c

@testset "Nernst Potential Tests" begin
    C_out = 150.0
    C_in = 15.0
    T = 310.15
    z = 1

    E = o2c.nernst_potential(C_out, C_in, T, z)
    @test isapprox(E, 0.061, atol=1e-3)
end
