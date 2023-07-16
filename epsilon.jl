module Epsilon
    struct Arrow
        fromNode::Int
        toNode::Int
        value::String
    end

    function isaccept(arrows, string)
        currentNodes = [0]

        for char ∈ split(string, "")
            if needEpsilonTransition(currentNodes, arrows)
            end
        end

        return true
    end

    needEpsilonTransition(currentNodes, arrows) = !isempty(findall(arrow->arrow.fromNode ∈ currentNodes && arrow.value == "ϵ", arrows))

    function epsilonTransition(currentNodes, arrows)
        indexs = findall(arrow->currentNodes ∈ arrow.fromNode && arrow.value == "ϵ", arrows)
        nextNodes = []

        for index ∈ indexs
            push!(nextNodes, arrows[index].toNode)
        end

        nextNodes
    end
end
