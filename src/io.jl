function load_tweets(path::AbstractString, lines::Int = typemax(Int))
    counter = 0
    data = Array{Dict{String, Any}, 1}()

    io = open(path, "r")

    while counter < lines && !eof(io)
        line = readline(io)
        json_line = JSON.parse(line)

        push!(data, json_line)

        counter += 1
    end

    #reduce(vcat, DataFrame.(data)) -> uniform columns
    vcat(DataFrame.(data)..., cols=:union)

end
