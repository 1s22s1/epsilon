module Epsilon
    struct Arrow
        fromNode::Int
        toNode::Int
        value::String
    end

    function main()
        arrows = []
        push!(arrows, Arrow(0, 1, "ϵ"))
        push!(arrows, Arrow(0, 2, "ϵ"))
        push!(arrows, Arrow(1, 3, "0"))
        push!(arrows, Arrow(2, 4, "1"))
        push!(arrows, Arrow(3, 5, "ϵ"))
        push!(arrows, Arrow(4, 5, "ϵ"))

        isaccept(arrows, [5], "0")
    end

    function isaccept(arrows, acceptedNode, string)
        currentNodes = [0]

        for targetChar ∈ split(string, "")
            while needEpsilonTransition(currentNodes, arrows)
                currentNodes = transition(currentNodes, arrows, "ϵ")
            end

            currentNodes = transition(currentNodes, arrows, targetChar)

            if isempty(currentNodes)
                return false
            end
        end

        !isempty(intersect(currentNodes, acceptedNode))
    end

    function transition(currentNodes, arrows, targetChar)
        nextNodes = []

        for currentNode ∈ currentNodes
            for index ∈ findall(arrow->currentNode ∈ arrow.fromNode && arrow.value == targetChar, arrows)
                push!(nextNodes, arrows[index].toNode)
            end
        end

        nextNodes
    end

    needEpsilonTransition(currentNodes, arrows) = !isempty(findall(arrow-> !isempty(intersect(arrow.fromNode, currentNodes)) && arrow.value == "ϵ", arrows))
end

if abspath(PROGRAM_FILE) == @__FILE__
    using .Epsilon

    Epsilon.main()
end
