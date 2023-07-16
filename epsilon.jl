module Epsilon
    struct Arrow
        fromNode::Int
        toNode::Int
        value::String
    end

    function isaccept(arrows, string)
        currentNodes = [0]

        for char ∈ split(string, "")
            while needEpsilonTransition(currentNodes, arrows)
                currentNodes = epsilonTransition(currentNodes, arrows)
            end
        end

        return true
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
