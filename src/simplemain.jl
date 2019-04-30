using SimpleTwitterAnalyzer

path = "./data/3rd_ep_gotstreaming2.txt"

df = load_tweets(path, 10)
println(df.user[2])
