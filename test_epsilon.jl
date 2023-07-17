module TestEpsilon
    using Test
    include("epsilon.jl")

    function main()
        @testset "選択の場合" begin
            arrows = []
            push!(arrows, Epsilon.Arrow(0, 1, "ϵ"))
            push!(arrows, Epsilon.Arrow(0, 2, "ϵ"))
            push!(arrows, Epsilon.Arrow(1, 3, "0"))
            push!(arrows, Epsilon.Arrow(2, 4, "1"))
            push!(arrows, Epsilon.Arrow(3, 5, "ϵ"))
            push!(arrows, Epsilon.Arrow(4, 5, "ϵ"))

            # @test Epsilon.isaccept(arrows, [5], "0") == true
        end

        @testset "遷移について" begin
            arrows1 = []
            push!(arrows1, Epsilon.Arrow(1, 3, "0"))

            # @test Epsilon.transition(1, arrows1, "0") == [3]
        end

        @testset "ϵ遷移の判定について" begin
            arrows = []
            push!(arrows, Epsilon.Arrow(0, 1, "ϵ"))
            push!(arrows, Epsilon.Arrow(1, 2, "1"))

            @test Epsilon.needEpsilonTransition(0, arrows) == true
            @test Epsilon.needEpsilonTransition(1, arrows) == false
        end

        @testset "ϵ遷移について" begin
            arrows = []
            push!(arrows, Epsilon.Arrow(0, 1, "ϵ"))
            push!(arrows, Epsilon.Arrow(0, 2, "ϵ"))

            # @test Epsilon.epsilonTransition(0, arrows) == [1, 2]
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    using. TestEpsilon

    TestEpsilon.main()
end