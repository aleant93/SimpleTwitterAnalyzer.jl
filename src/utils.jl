#run all stats
function runallstats(df::AbstractDataFrame)
    toreturn = Dict{Symbol, Union{AbstractDataFrame, AbstractString, Int}}()

    toreturn[:lang] = cntoccurences(df, :lang)
    toreturn[:source_df] = cntoccurences(df, :source)

    entities = cntentities(df)
    toreturn[:hashtags] = entities[:hashtags]
    toreturn[:mentions] = entities[:mentions]
    toreturn[:domains] = entities[:domains]

    toreturn
end

function savestats(stats::AbstractDict, destpath::AbstractString; append_output::Bool=false)
    output_path = mkpath(string(destpath, Base.Filesystem.path_separator, "stats"))
    for feature in keys(stats)
        if stats[feature] isa AbstractDataFrame
            destfile = string(output_path, string(Base.Filesystem.path_separator, String(feature),".csv"))
            CSV.write(destfile, stats[feature]; append=append_output)
        end
    end
end

function plotstats(stats::AbstractDict, destpath::AbstractString)
    output_path = mkpath(string(destpath, Base.Filesystem.path_separator, "plots"))
    for feature in keys(stats)
        if stats[feature] isa AbstractDataFrame
            destfile = string(output_path, string(Base.Filesystem.path_separator, String(feature),".png"))
            colnames = names(stats[feature])
            plotdata(stats[feature], colnames[1], colnames[2];
                ptitle=string(colnames[1], " distribution"), xlabels=string(colnames[1]))
            savefig(destfile)
        end
    end
end
