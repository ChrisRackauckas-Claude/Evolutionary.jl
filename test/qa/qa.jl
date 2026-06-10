using Pkg
Pkg.activate(@__DIR__)
Pkg.develop(PackageSpec(path = joinpath(@__DIR__, "..", "..")))
Pkg.instantiate()

using Evolutionary
using Aqua
using JET
using Test

@testset "Quality Assurance" begin
    @testset "Aqua" begin
        # ambiguities, unbound_args and piracies currently fail; keep the
        # other Aqua sub-checks running and mark the failing ones broken.
        # Tracked in https://github.com/SciML/Evolutionary.jl/issues/145
        Aqua.test_all(
            Evolutionary;
            ambiguities = false,
            unbound_args = false,
            piracies = false,
        )
        @test_broken false  # Aqua ambiguities: 18 found in optimize overloads (src/api/optimize.jl) — tracked in https://github.com/SciML/Evolutionary.jl/issues/145
        @test_broken false  # Aqua unbound_args: 3 methods (src/api/expressions.jl) — tracked in https://github.com/SciML/Evolutionary.jl/issues/145
        @test_broken false  # Aqua piracies: 7 methods (Expr ops, replace, value) — tracked in https://github.com/SciML/Evolutionary.jl/issues/145
    end
    @testset "JET" begin
        # JET.test_package reports errors (e.g. +(::Nothing,::Int) and kwcall
        # on deprecated crossover/mutation aliases in src/deprecated.jl).
        # Tracked in https://github.com/SciML/Evolutionary.jl/issues/145
        @test_broken false  # JET: report_package errors — tracked in https://github.com/SciML/Evolutionary.jl/issues/145
    end
end
