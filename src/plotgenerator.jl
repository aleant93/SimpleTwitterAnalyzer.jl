function yelphistogram(data::Array{T,1} where T <: Real, bins::Int, ptitle::AbstractString)
    clf()
    title(ptitle)

    return PyPlot.plt.hist(data, bins=bins)
end

function yelphbarchart_topn(data::Dict{Symbol,Int64}, ptitle::AbstractString, howmany::Int=length(data))
    #sort data and get most frequent occurences
    sorted = sort(collect(data), by=x->x.second, rev=true)
    toplot = sorted[1:min(howmany, length(sorted))]

    indexes = collect(keys(toplot))
    labels = [elem.first for elem in toplot]

    values = [elem.second for elem in toplot]

    clf()
    title(ptitle)
    #xticks(indexes, labels, rotation="vertical")
    #return  bar(collect(1:length(keys(toplot))),collect(values(toplot)))
    return bar(indexes, values, tick_label=labels)
end

function yelphbarchart(data::Dict{Symbol,Int64}, elemtoplot::Int=length(data);
        ptitle::AbstractString="", x_label::AbstractString="", y_label::AbstractString="")
    #sort data and get most frequent occurences
    sorted = sort(collect(data), by=x->x.second, rev=true)
    toplot = sorted[1:min(elemtoplot, length(sorted))]

    ckeys = collect(keys(data)) #collect all keys

    indexes = Int[]
    labels = String[]
    for k in toplot
        i = findall(x->x==k.first, ckeys)
        push!(indexes, i[1])
        push!(labels, String(ckeys[i[1]]))
    end

    clf()
    title(ptitle)
    xlabel(x_label)
    ylabel(y_label,labelpad=15)
    xticks(indexes, labels, fontweight="demibold", rotation=-20)
    return  bar(collect(1:length(keys(data))),collect(values(data)))
end

function generatehistogramdata(model::Model, source::Symbol, field::Symbol, func::Union{Function, Nothing}=nothing)
    data = Float64[]
    for elem in values(getfield(model, source))
        if func == nothing
            push!(data, getfield(elem, field))
        else
            push!(data, func(getfield(elem, field)))
        end
    end
    data
end

function generatebarchartdata(model::Model, source::Symbol, field::Symbol)
    data = Dict{Symbol,Int64}()
    for elem in values(getfield(model, source))
        fielddata = getfield(elem, field)
        if fielddata isa Array
            for e in unique(fielddata)
                n = get(data, e, 0)
                push!(data, e=>(n+1))
            end
        else
            n = get(data, getfield(elem, field), 0)
            push!(data, getfield(elem, field)=>(n+1))
        end
    end
    data
end
