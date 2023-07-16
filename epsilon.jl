module Epsilon
    struct Arrow
        fromNode::Int
        toNode::Int
        value::String
    end

    function isaccept(arrows, string)
        currentNode = 0

        for char ∈ split(string, "")
            if needEpsilonTransition(currentNode, arrows)
            end
        end

        return true
    end

    needEpsilonTransition(currentNode, arrows) = !isempty(findall(arrow->arrow.fromNode == currentNode && arrow.value == "ϵ", arrows))
end