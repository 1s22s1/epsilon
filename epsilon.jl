module Epsilon
    using Printf

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

        isaccept(arrows, [5], "0", true)
    end

    function isaccept(arrows, acceptedNode, string, debug = false)
        beginDebug(debug)

        currentNodes = [0]

        for targetChar ∈ split(string, "")
            while needEpsilonTransition(currentNodes, arrows)
                currentNodes = transition(currentNodes, arrows, "ϵ")
            end

            currentNodes = transition(currentNodes, arrows, targetChar, debug)

            if isempty(currentNodes)
                return false
            end
        end

        while needEpsilonTransition(currentNodes, arrows)
            currentNodes = transition(currentNodes, arrows, "ϵ", debug)
        end

        endDebug(debug)

        !isempty(currentNodes ∩ acceptedNode)
    end

    function transition(currentNodes, arrows, targetChar, debug = false)
        if debug
            @printf("遷移します。currentNodes=%s。targetChar=%s\n", string(currentNodes), targetChar)
        end

        nextNodes = []

        for currentNode ∈ currentNodes
            for index ∈ findall(arrow->currentNode ∈ arrow.fromNode && arrow.value == targetChar, arrows)
                push!(nextNodes, arrows[index].toNode)
            end
        end

        if debug
            @printf("遷移の結果です。nextNodes=%s。\n", string(nextNodes))
        end

        nextNodes
    end

    needEpsilonTransition(currentNodes, arrows) = !isempty(findall(arrow-> !isempty(arrow.fromNode ∩ currentNodes) && arrow.value == "ϵ", arrows))

    function beginDebug(debug)
        if debug
            @printf("デバッグモードを開始します。\n")
        end
    end

    function endDebug(debug)
        if debug
            @printf("デバッグモードを終了します。\n")
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    using .Epsilon

    Epsilon.main()
end
