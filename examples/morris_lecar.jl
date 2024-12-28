using o2c
using DifferentialEquations
using Plots

# Parameters for the Morris-Lecar model
I_ext = 80.0            # External current (µA/cm²), increased for spiking
g_Ca = 4.4              # Calcium conductance (mS/cm²)
g_K = 8.0               # Potassium conductance (mS/cm²)
g_L = 2.0               # Leak conductance (mS/cm²)
V_Ca = 120.0            # Calcium reversal potential (mV)
V_K = -84.0             # Potassium reversal potential (mV)
V_L = -60.0             # Leak reversal potential adjusted close to -65 mV for realistic resting potential
phi = 0.04              # Scaling factor for recovery variable dynamics
V1 = -1.2               # Adjusted half-activation for m_inf (mV) for more sensitivity
V2 = 18.0               # Slope factor for m_inf (mV), broadened for smoother activation
V3 = 12.0               # Half-activation for w_inf (mV), adjusted for realistic gating dynamics
V4 = 17.4               # Slope factor for w_inf (mV), broadened to adjust the recovery dynamics
C_m = 20.0              # Membrane capacitance (µF/cm²)

p = (I_ext, g_Ca, g_K, g_L, V_Ca, V_K, V_L, phi, V1, V2, V3, V4, C_m)
# Initial conditions: [V, w]
u0 = [-60.0, 0.0]  # Start from typical resting potential
# Time span
tspan = (0.0, 300.0)

prob = ODEProblem(o2c.morris_lecar!, u0, tspan, p)
sol = solve(prob, Rodas5(); abstol=1e-9, reltol=1e-6)

plot(
    sol;
    idxs=(0, 1),
    xlabel="Time (ms)",
    ylabel="Membrane Potential (mV)",
    title="Morris-Lecar Spiking Behavior",
)
