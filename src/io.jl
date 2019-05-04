"""
    loadtweets(fname::AbstractString, ntweets::Int = typemax(Int))

Load `ntweets` tweets from a file `fname`.
Return a `DataFrame` where each column represents a tweet field.
"""
function loadtweets(fname::AbstractString, ntweets::Int = typemax(Int))
    open(io -> loadtweets(io, ntweets), fname, "r")
end

"""
    loadtweets(io::IO, ntweets::Int = typemax(Int))

Load `ntweets` tweets from a stream `io`.
Return a `DataFrame` where each column represents a tweet field.
"""
function loadtweets(io::IO, ntweets::Int = typemax(Int))
    counter = 0
    data = Array{Dict{String, Any}, 1}()

    while counter < ntweets && !eof(io)
        tweet = JSON.parse(readline(io))
        push!(data, tweet)
        counter += 1
    end
    
    vcat(DataFrame.(data)..., cols=:union) #non uniform columns
    #reduce(vcat, DataFrame.(data)) -> uniform columns
    #reduce(vcat, DataFrame.(a), cols=:union) -> near future
    #try append instead of vcat - Performance tips
end
