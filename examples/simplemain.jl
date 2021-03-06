using SimpleTwitterAnalyzer, PyPlot

path = "./data/tweets.txt"
df = loadtweets(path, 10)

#Getting some results..
lang_df = cntoccurences(df, :lang)
source_df = cntoccurences(df, :source)

entities = cntentities(df)
hashtags_df = entities[:hashtags]
mentions_df = entities[:mentions]
domains_df = entities[:domains]

activities_df = cntactivities(df)
weekly_df = activities_df[:weekly_activity]
hourly_df = activities_df[:hourly_activity]

#Plot and save something..
destdir = "./results"
plotdata(lang_df, :lang, :cnt; ptitle="Lang distribution", x_label="Languages")
destpath = string(destdir, string(Base.Filesystem.path_separator, "lang.png"))
savefig(destpath)
