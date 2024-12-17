module o2c

export nernst_potential

include("constants.jl")
include("equations/nernst.jl")

using .Constants
using .Nernst: nernst_potential

end # module o2c
