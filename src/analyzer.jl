"""
    cntoccurences(df::AbstractDataFrame, col)

 Count the occurences of different values
 of the column `col` of the dataframe `df`.
 Return a new dataframe with a column `col`
 representing the instance and a column `cnt`
 indicating its occurences.

  Suitable for :lang and :source tweet attributes.
"""
function cntoccurences(df::AbstractDataFrame, col, skipmissing=false)
    newdf = by(df[[col]], col, nrow)
    rename!(newdf, :x1 => :cnt)
    newdf
end

"""

"""
function cntentities(df::AbstractDataFrame)
    hashtags = Dict{String, Int}()
    mentions = Dict{String, Int}()
    domains = Dict{String, Int}()

    map(r -> collectmetadata!(r.entities, hashtags, mentions, domains), eachrow(df))

    hashtags_df = DataFrame(:hashtags => collect(keys(hashtags)), :cnt => collect(values(hashtags)))
    mentions_df = DataFrame(:mentions => collect(keys(mentions)), :cnt => collect(values(mentions)))
    domains_df = DataFrame(:domains => collect(keys(domains)), :cnt => collect(values(domains)))

    hashtags_df, mentions_df, domains_df
end

function collectmetadata!(row::AbstractDict, hashtags::AbstractDict,
        mentions::AbstractDict, domains::AbstractDict)

    #check hashtags
    if !isempty(row["hashtags"])
        for hashtag in row["hashtags"]
            key = lowercase(hashtag["text"])
            hashtags[key] = get(hashtags, key, 0) + 1
        end
    end

    #check user_mentions
    if !isempty(row["user_mentions"])
        for mention in row["user_mentions"]
            key = mention["screen_name"]
            mentions[key] = get(mentions, key, 0) + 1
        end
    end

    #check domains
    if !isempty(row["urls"])
        for url in row["urls"]
            url_host = URI(url["expanded_url"]).host
            if url_host != "twitter.com"
                domains[url_host] = get(domains, url_host, 0) + 1
            end
        end
    end
end


"""

"""
function activityfrequency(df)
    activity_weekly = Dict{Int, Int}(i => 0 for i = 1:7)
    activity_hourly = Dict{Int, Int}(i => 0 for i = 0:23)
    #mindate, maxdate

    map(r -> collectdatedata(r, activity_weekly, activity_hourly), eachrow(df))
    #mydate = Dates.parse(DateTime, df.created_at[1], dateformat"e u d H:M:S +s Y")
end

function collectdatedata()

end
