using o2c
using Plots
using DifferentialEquations

# Parameters
g_Na = 120.0   # Sodium conductance (mS/cm^2)
g_K = 36.0     # Potassium conductance (mS/cm^2)
g_L = 0.3      # Leak conductance (mS/cm^2)
E_Na = 50.0    # Sodium reversal potential (mV)
E_K = -77.0    # Potassium reversal potential (mV)
E_L = -54.387  # Leak reversal potential (mV)
C_m = 1.0      # Membrane capacitance (µF/cm^2)
I_ext = 10.0   # External current (µA/cm^2)

# Initial conditions: [ V, m, h, n ]
u0 = [-65.0, 0.0529, 0.5961, 0.3177]  # Resting potential & gating variables

# Time span
tspan = (0.0, 50.0)  # ms

# Bundle parameters
p = (g_Na, g_K, g_L, E_Na, E_K, E_L, C_m, I_ext)

# Solve Hodgkin–Huxley ODE
prob = ODEProblem(o2c.hodgkin_huxley, u0, tspan, p)
sol = solve(prob)

# Extracting solution components
t = sol.t
V = sol[1, :]
m = sol[2, :]
h = sol[3, :]
n = sol[4, :]

# CFraction of open channels or instantaneous conductances
# Sodium channels open fraction ~ m^3 * h
open_fraction_Na = m .^ 3 .* h
# Potassium channels open fraction ~ n^4
open_fraction_K = n .^ 4

# Instantaneous conductances
gNa_t = g_Na .* open_fraction_Na
gK_t = g_K .* open_fraction_K
gL_t = fill(g_L, length(t))  # constant

# PLOTTING
# Membrane potential
plt_V = plot(
    t,
    V;
    label="V (mV)",
    xlabel="Time (ms)",
    ylabel="Membrane Potential",
    title="Hodgkin-Huxley: Membrane Potential",
    legend=:topright,
)

# Gating variables (m, h, n)
plt_gates = plot(
    plot(
        t, m; label="m", xlabel="Time (ms)", ylabel="m", title="Gating variables (m, h, n)"
    ),
    plot(t, h; label="h", xlabel="Time (ms)", ylabel="h"),
    plot(t, n; label="n", xlabel="Time (ms)", ylabel="n");
    layout=(3, 1),
    size=(600, 800),
)

plt_open_fracs = plot(
    plot(
        t,
        open_fraction_Na;
        label="Na open fraction (m^3h)",
        xlabel="Time (ms)",
        ylabel="Fraction",
        title="Open fractions Na, K",
    ),
    plot(
        t,
        open_fraction_K;
        label="K open fraction (n^4)",
        xlabel="Time (ms)",
        ylabel="Fraction",
    );
    layout=(2, 1),
    size=(600, 600),
)

plot(plt_V, plt_gates, plt_open_fracs; layout=@layout([a; b b]), size=(800, 900))
