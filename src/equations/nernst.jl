module Nernst

using ..Constants

"""
    nernst_potential(C_out::Real, C_in::Real, T::Real, z::Int)::Float64

Compute the Nernst potential for an ion.

# Arguments
- `C_out`: Extracellular concentration of the ion (mol/L).
- `C_in`: Intracellular concentration of the ion (mol/L).
- `T`: Absolute temperature (K).
- `z`: Valence (charge) of the ion.

# Returns
The Nernst potential in volts (V).
"""
function nernst_potential(C_out::Real, C_in::Real, T::Real, z::Int)::Float64
    @assert C_out > 0 "Extracellular concentration (C_out) must be positive."
    @assert C_in > 0 "Intracellular concentration (C_in) must be positive."
    @assert T > 0 "Temperature (T) must be positive."
    @assert z ≠ 0 "Valence (z) must be non-zero."

    return (Constants.R * T) / (z * Constants.F) * log(C_out / C_in)
end

end # module Nernst
