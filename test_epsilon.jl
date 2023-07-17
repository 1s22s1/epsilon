module TestEpsilon
    using Test
    include("epsilon.jl")

    function main()
        arrows = []
        push!(arrows, Epsilon.Arrow(0, 1, "ϵ"))
        push!(arrows, Epsilon.Arrow(0, 2, "ϵ"))
        push!(arrows, Epsilon.Arrow(1, 3, "0"))
        push!(arrows, Epsilon.Arrow(2, 4, "1"))
        push!(arrows, Epsilon.Arrow(3, 5, "ϵ"))
        push!(arrows, Epsilon.Arrow(4, 5, "ϵ"))

        @testset "ϵ遷移の判定について" begin
            @test Epsilon.needEpsilonTransition([0], arrows) == true
            @test Epsilon.needEpsilonTransition([1, 2], arrows) == false
            @test Epsilon.needEpsilonTransition([3], arrows) == true
            @test Epsilon.needEpsilonTransition([4], arrows) == true
        end

        @testset "遷移について" begin
            @test Epsilon.transition([0], arrows, "ϵ") == [1, 2]
            @test Epsilon.transition([1, 2], arrows, "0") == [3]
            @test Epsilon.transition([1, 2], arrows, "1") == [4]
            @test Epsilon.transition([1, 2], arrows, "2") == []
            @test Epsilon.transition([3], arrows, "ϵ") == [5]
            @test Epsilon.transition([4], arrows, "ϵ") == [5]
        end

        @testset "選択の場合" begin
            # @test Epsilon.isaccept(arrows, [5], "0") == true
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    using. TestEpsilon

    TestEpsilon.main()
end