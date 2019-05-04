"""
    cntoccurences(df::AbstractDataFrame, col)

Count the occurences of different values of the column `col` in the dataframe `df`.
Return a new dataframe with a column `col` representing an instance
and a column `cnt` indicating its occurences.

Suitable for :lang and :source tweet attributes.
"""
function cntoccurences(df::AbstractDataFrame, col::Symbol, skipmissing=false)
    newdf = by(df[[col]], col, nrow)
    rename!(newdf, :x1 => :cnt)
    newdf
end

"""
    cntentities(df::AbstractDataFrame)

Count the occurences of hashtags, mentions and domains in the dataframe `df`
and store the computed frequencies into three different dataframes.
Return a dict where each entry is associated with the corresponding frequency dataframe.
"""
function cntentities(df::AbstractDataFrame)
    hashtags = Dict{String, Int}()
    mentions = Dict{String, Int}()
    domains = Dict{String, Int}()

    map(r -> collectmetadata!(r.entities, hashtags, mentions, domains), eachrow(df))

    hashtags_df = DataFrame(:hashtags => collect(keys(hashtags)), :cnt => collect(values(hashtags)))
    mentions_df = DataFrame(:mentions => collect(keys(mentions)), :cnt => collect(values(mentions)))
    domains_df = DataFrame(:domains => collect(keys(domains)), :cnt => collect(values(domains)))

    Dict{Symbol, DataFrame}(:hashtags => hashtags_df,
        :mentions => mentions_df,
        :domains => domains_df)
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
function activityfrequency(df::AbstractDataFrame)
    activity_weekly = Dict{Int, Int}(i => 0 for i = 1:7)
    activity_hourly = Dict{Int, Int}(i => 0 for i = 0:23)
    #mindate, maxdate

    map(r -> collecttiming!(r.created_at, activity_weekly, activity_hourly), eachrow(df))
    #mydate = Dates.parse(DateTime, df.created_at[1], dateformat"e u d H:M:S +s Y")

    # println(activity_weekly)
    # println(activity_hourly)

    weekly_df = DataFrame(:weekday => collect((keys(activity_weekly))), :cnt => collect(values(activity_weekly)))
    hourly_df = DataFrame(:hour => collect((keys(activity_hourly))), :cnt => collect(values(activity_hourly)))

    weekly_df, hourly_df
end

"""

"""
function collecttiming!(date::AbstractString, activity_weekly::AbstractDict, activity_hourly::AbstractDict)
    tweetdate = Dates.parse(DateTime, date, dateformat"e u d H:M:S +s Y")

    activity_weekly[Dates.dayofweek(tweetdate)] = activity_weekly[Dates.dayofweek(tweetdate)] + 1
    activity_hourly[Dates.hour(tweetdate)] = activity_hourly[Dates.hour(tweetdate)] + 1
end


"""

"""
function cntplaces(df::AbstractDataFrame)
    places = Dict{String, Int}()

    for row in eachrow(df)
        println(row)
    end
end
