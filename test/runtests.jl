using Evolutionary
using Test
using Random
using LinearAlgebra
using Statistics
using StableRNGs

const GROUP = get(ENV, "GROUP", "All")

# Any group other than "QA" runs the full functional suite (the matrix splits
# Core across version/OS cells only; the suite itself is the same).
if GROUP != "QA"
    # Guard against accidental piracy from `import`
    @test Evolutionary.contains !== Base.contains

    for tests in [
            "types.jl",
            "objective.jl",
            "interface.jl",
            "selections.jl",
            "recombinations.jl",
            "mutations.jl",
            "sphere.jl",
            "rosenbrock.jl",
            "schwefel.jl",
            "rastrigin.jl",
            "n-queens.jl",
            "knapsack.jl",
            "onemax.jl",
            "moea.jl",
            "regression.jl",
            "gp.jl",
        ]
        include(tests)
    end
end

if GROUP == "QA"
    include(joinpath(@__DIR__, "qa", "qa.jl"))
end
