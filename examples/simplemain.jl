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

#Plot and save something..
destdir = "./results"
plotdata(lang_df, :lang, :cnt; ptitle="Lang distribution", xlabels="Languages")
destpath = string(destdir, string(Base.Filesystem.path_separator, "lang.png"))
savefig(destpath)
