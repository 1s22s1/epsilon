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
                currentNodes = epsilonTransition(currentNodes, arrows)
            end

            currentNodes = transition(currentNodes, arrows, targetChar)

            if isempty(currentNodes)
                return break
            end
        end

        for currentNode ∈ currentNodes
            if currentNode ∈ acceptedNode
                return true
            end
        end

        false
    end

    function transition(currentNodes, arrows, targetChar)
        indexs = findall(arrow->currentNodes ∈ arrow.fromNode && arrow.value == targetChar, arrows)
        nextNodes = []

        for index ∈ indexs
            push!(nextNodes, arrows[index].toNode)
        end

        nextNodes
    end

    needEpsilonTransition(currentNodes, arrows) = !isempty(findall(arrow->arrow.fromNode ∈ currentNodes && arrow.value == "ϵ", arrows))
    epsilonTransition(currentNodes, arrows) = transition(currentNodes, arrows, "ϵ")
end

if abspath(PROGRAM_FILE) == @__FILE__
    using .Epsilon

    Epsilon.main()
end
