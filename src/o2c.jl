module o2c

export nernst_potential, hodgkin_huxley!

include("constants.jl")
include("models/nernst.jl")
include("models/hodgkin_huxley.jl")

using .Constants
using .Nernst: nernst_potential
using .HodgkinHuxley: hodgkin_huxley!

end # module o2c
