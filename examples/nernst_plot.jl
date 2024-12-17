using o2c
using Plots
using o2c.Constants  # Import the Constants module

# Fixed temperature
T = 310.15  # Temperature in Kelvin

# Range of extracellular concentrations
C_out_values = collect(1.0:5.0:200.0)

# Nernst potential for different ions
E_K = [
    o2c.nernst_potential(C_out, Constants.C_in_K, T, Constants.z_K) for
    C_out in C_out_values
]     # Potassium (K⁺)
E_Na = [
    o2c.nernst_potential(C_out, Constants.C_in_Na, T, Constants.z_Na) for
    C_out in C_out_values
] # Sodium (Na⁺)
E_Cl = [
    o2c.nernst_potential(C_out, Constants.C_in_Cl, T, Constants.z_Cl) for
    C_out in C_out_values
] # Chloride (Cl⁻)

# Plot the results
plot(C_out_values, E_K; label="Potassium (K⁺)", linewidth=2)
plot!(C_out_values, E_Na; label="Sodium (Na⁺)", linewidth=2)
plot!(C_out_values, E_Cl; label="Chloride (Cl⁻)", linewidth=2)

# Plot settings
plot!(;
    xlabel="Extracellular Concentration (mol/L)",
    ylabel="Nernst Potential (V)",
    title="Nernst Potential for Different Ions",
    legend=:topleft,
)
