using Test
using DifferentialEquations
using o2c

@testset "Morris–Lecar Model Tests" begin
    # 1. Define parameters
    I_ext = 20.0
    g_Ca = 4.0
    g_K = 8.0
    g_L = 2.0
    V_Ca = 120.0
    V_K = -84.0
    V_L = -60.0
    phi = 0.04
    V1 = -1.2
    V2 = 18.0
    V3 = 12.0
    V4 = 17.5
    C_m = 20.0

    p = (I_ext, g_Ca, g_K, g_L, V_Ca, V_K, V_L, phi, V1, V2, V3, V4, C_m)

    # 2. Initial condition and timespan
    u0 = [-60.0, 0.0]
    tspan = (0.0, 50.0)

    # 3. Define and solve ODE problem
    prob = ODEProblem(o2c.morris_lecar!, u0, tspan, p)
    sol = solve(prob, Tsit5(); abstol=1e-9, reltol=1e-6)

    # 4. Tests:

    # (a) Check solver success
    # Option A: check it matches the enum-like ReturnCode:
    @test sol.retcode === SciMLBase.ReturnCode.Success

    # or Option B: treat retcode as a Symbol:
    # @test sol.retcode == :Success

    # (b) Ensure no NaNs in the solution states
    # Flatten all states into a single vector and check for any NaNs:
    states_flat = vcat(sol.u...)  # concatenates each [V, w] into one vector
    @test !any(isnan, states_flat)

    # (c) Optionally test that the final V is in a plausible range
    final_V, final_w = sol[end]
    @test final_V > -80 && final_V < 50
    @test 0.0 ≤ final_w ≤ 1.0
end
