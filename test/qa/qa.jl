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
        Aqua.test_all(Evolutionary)
    end
    @testset "JET" begin
        JET.test_package(Evolutionary; target_defined_modules = true)
    end
end
