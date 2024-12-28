module o2c

export nernst_potential, hodgkin_huxley!

include("constants.jl")
include("models/nernst.jl")
include("models/hodgkin_huxley.jl")
include("models/morris_lecar.jl")

using .Constants
using .Nernst: nernst_potential
using .HodgkinHuxley: hodgkin_huxley!
using .MorrisLecar: morris_lecar!

end # module o2c
