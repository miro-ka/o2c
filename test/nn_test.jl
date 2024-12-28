using Test
using DifferentialEquations
using o2c

@testset "Hodgkin-Huxley System" begin
    g_Na = 120.0
    g_K = 36.0
    g_L = 0.3
    E_Na = 50.0
    E_K = -77.0
    E_L = -54.387
    C_m = 1.0
    I_ext = 10.0
    p = (g_Na, g_K, g_L, E_Na, E_K, E_L, C_m, I_ext)

    # Initial conditions: [V, m, h, n]
    u0 = [-65.0, 0.0529, 0.5961, 0.3177]
    t = 0.0

    du = similar(u0)
    o2c.hodgkin_huxley(du, u0, p, t)

    # Expected output for du[1] (membrane potential derivative)
    expected_du1 =
        (
            I_ext - (g_Na * u0[2]^3 * u0[3] * (u0[1] - E_Na)) -
            (g_K * u0[4]^4 * (u0[1] - E_K)) - (g_L * (u0[1] - E_L))
        ) / C_m

    @test isapprox(du[1], expected_du1; atol=1e-8)

    Vshift = u0[1] + 65.0
    α_m = 0.1 * (25.0 - Vshift) / (exp((25.0 - Vshift) / 10.0) - 1.0)
    β_m = 4.0 * exp(-Vshift / 18.0)
    α_h = 0.07 * exp(-Vshift / 20.0)
    β_h = 1.0 / (exp((30.0 - Vshift) / 10.0) + 1.0)
    α_n = 0.01 * (10.0 - Vshift) / (exp((10.0 - Vshift) / 10.0) - 1.0)
    β_n = 0.125 * exp(-Vshift / 80.0)

    expected_du2 = α_m * (1.0 - u0[2]) - β_m * u0[2]
    expected_du3 = α_h * (1.0 - u0[3]) - β_h * u0[3]
    expected_du4 = α_n * (1.0 - u0[4]) - β_n * u0[4]

    @test isapprox(du[2], expected_du2; atol=1e-8)
    @test isapprox(du[3], expected_du3; atol=1e-8)
    @test isapprox(du[4], expected_du4; atol=1e-8)
end
