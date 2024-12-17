module Constants

# Physical constants
const R = 8.314          # Ideal gas constant (J/(mol·K))
const F = 96485.33212    # Faraday constant (C/mol)

# Ion concentrations (mM)
# Source: https://www.ncbi.nlm.nih.gov/books/NBK21668/ (Table of ionic concentrations)

# Potassium (K⁺)
const C_in_K = 140.0     # Intracellular K⁺ concentration (mM)
const C_out_K = 5.0      # Extracellular K⁺ concentration (mM)
const z_K = 1            # Valence of K⁺

# Sodium (Na⁺)
const C_in_Na = 15.0     # Intracellular Na⁺ concentration (mM)
const C_out_Na = 145.0   # Extracellular Na⁺ concentration (mM)
const z_Na = 1           # Valence of Na⁺

# Chloride (Cl⁻)
const C_in_Cl = 10.0     # Intracellular Cl⁻ concentration (mM)
const C_out_Cl = 120.0   # Extracellular Cl⁻ concentration (mM)
const z_Cl = -1          # Valence of Cl⁻ (negative charge)

end # module Constants
