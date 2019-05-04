using SimpleTwitterAnalyzer

path = "./data/tweets.txt"

df = loadtweets(path, 10)

#placesdf = cntplaces(df)

# langdf = cntoccurences(df, :lang)
# plotdata(langdf, :lang, :cnt, "Lang distribution")

# sourcedf = cntoccurences(df, :source)
#
# println(langdf)
# println(sourcedf)

#hashtag_df, mentions_df, domains_df = cntentities(df)
# println(hashtag_df)
# println(mentions_df)
# println(domains_df)

# w, h = activityfrequency(df)
#
# println(w)
# println(h)
