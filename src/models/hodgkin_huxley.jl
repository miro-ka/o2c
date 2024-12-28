module HodgkinHuxley

using DifferentialEquations

"""
    hodgkin_huxley!(du, u, p, t)

Defines the Hodgkin-Huxley system of ODEs.

# Arguments
- `du`: Array to store derivatives (updated in place).
- `u`: Array of current states `[V, m, h, n]`.
- `p`: Tuple of parameters `(g_Na, g_K, g_L, E_Na, E_K, E_L, C_m, I_ext)`.
- `t`: Time (not used in the equations but passed by the ODE solver).

# Returns
None. Updates `du` with derivatives for the system.

# Examples
```julia
u0 = [-65.0, 0.0529, 0.5961, 0.3177]
p = (120.0, 36.0, 0.3, 50.0, -77.0, -54.387, 1.0, 10.0)
du = similar(u0)
hodgkin_huxley!(du, u0, p, 0.0)
"""

function hodgkin_huxley!(du, u, p, t)
    # Unpack variables
    V, m, h, n = u
    g_Na, g_K, g_L, E_Na, E_K, E_L, C_m, I_ext = p

    # Ionic currents
    I_Na = g_Na * m^3 * h * (V - E_Na)
    I_K = g_K * n^4 * (V - E_K)
    I_L = g_L * (V - E_L)
    du[1] = (I_ext - I_Na - I_K - I_L) / C_m

    # Shifting the voltage by +65 for gating rates (original formulas assume V=0 at rest)
    Vshift = V + 65.0

    α_m = 0.1 * (25.0 - Vshift) / (exp((25.0 - Vshift) / 10.0) - 1.0)
    β_m = 4.0 * exp(-Vshift / 18.0)
    α_h = 0.07 * exp(-Vshift / 20.0)
    β_h = 1.0 / (exp((30.0 - Vshift) / 10.0) + 1.0)
    α_n = 0.01 * (10.0 - Vshift) / (exp((10.0 - Vshift) / 10.0) - 1.0)
    β_n = 0.125 * exp(-Vshift / 80.0)

    du[2] = α_m * (1.0 - m) - β_m * m
    du[3] = α_h * (1.0 - h) - β_h * h
    return du[4] = α_n * (1.0 - n) - β_n * n
end

end # module HodgkinHuxley
