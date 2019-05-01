function load_tweets(path::AbstractString, lines::Int = typemax(Int))
    counter = 0
    data = Array{Dict{String, Any}, 1}()

    io = open(path, "r")

    while counter < lines && !eof(io)
        tweet = JSON.parse(readline(io))
        push!(data, tweet)
        counter += 1
    end

    #reduce(vcat, DataFrame.(data)) -> uniform columns
    vcat(DataFrame.(data)..., cols=:union) #non uniform columns

    #can we use append instead of vcat? Performance tips
end
