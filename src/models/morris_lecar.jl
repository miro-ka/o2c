module MorrisLecar

using DifferentialEquations

"""
    morris_lecar!(du, u, p, t)

Defines the Morris-Lecar system of ODEs.

# Arguments
- `du`: Array to store derivatives (updated in place).
- `u`: Array of current states `[V, w]`.
- `p`: Parameters of the model.
- `t`: Time.

# Returns
None. Updates `du` with derivatives for the system.
"""
function morris_lecar!(du, u, p, t)
    # Unpack
    V, w = u
    I_ext, g_Ca, g_K, g_L, V_Ca, V_K, V_L, phi, V1, V2, V3, V4, C_m = p

    # Steady-state gating variables
    m_inf = 0.5 * (1 + tanh((V - V1) / V2))  # Calcium activation
    w_inf = 0.5 * (1 + tanh((V - V3) / V4))  # Potassium activation

    # Time constant for w
    τ_w = 1 / cosh((V - V3) / (2 * V4))

    # Ionic currents
    I_Ca = g_Ca * m_inf * (V - V_Ca)
    I_K = g_K * w * (V - V_K)
    I_L = g_L * (V - V_L)

    # Membrane potential derivative
    du[1] = (I_ext - I_Ca - I_K - I_L) / C_m

    # Recovery variable derivative
    return du[2] = phi * (w_inf - w) / τ_w
end

end # module MorrisLecar
