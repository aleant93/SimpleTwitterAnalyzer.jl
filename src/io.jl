function load_tweets(path::AbstractString, lines::Int = typemax(Int))
    io = open(path, "r")
    counter = 0
    while counter < lines && !eof(io)
        line = readline(io)
        json_line = JSON.parse(line)

        println(typeof(json_line))

        counter += 1
    end
end
