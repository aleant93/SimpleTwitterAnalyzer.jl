using SimpleTwitterAnalyzer

path = "./data/tweets.txt"
df = loadtweets(path, 10)

lang_df = cntoccurences(df, :lang)
source_df = cntoccurences(df, :source)

entities = cntentities(df)
hashtags_df = entities[:hashtags]
mentions_df = entities[:mentions]
domains_df = entities[:domains]

# plotdata(langdf, :lang, :cnt, "Lang distribution")

#placesdf = cntplaces(df)


# w, h = activityfrequency(df)
#
# println(w)
# println(h)
