using SimpleTwitterAnalyzer

fname = "./data/tweets.txt"
destdir = "./results"

df = loadtweets(fname, 10)
stats = runallstats(df)
savestats(stats, destdir)
plotstats(stats, destdir)
