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
end
