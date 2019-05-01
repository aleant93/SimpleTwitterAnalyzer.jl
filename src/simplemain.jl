using SimpleTwitterAnalyzer

path = "./data/tweets.txt"

df = load_tweets(path, 10)

# langdf = cntoccurences(df, :lang)
# sourcedf = cntoccurences(df, :source)
#
# println(langdf)
# println(sourcedf)

#hashtag_df, mentions_df, domains_df = cntentities(df)
# println(hashtag_df)
# println(mentions_df)
# println(domains_df)
