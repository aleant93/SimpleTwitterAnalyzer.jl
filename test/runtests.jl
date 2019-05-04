using Test
using DataFrames, PyPlot
using SimpleTwitterAnalyzer

#setup code

@testset "IO" begin
	#A simplified version of some tweets,
	#showing how different kinds of data returned by Twitter
	#are actually represented into the df
	fname = "testdata/io.json"
	loaded_df = loadtweets(fname)
	test_df = DataFrame(
		:created_at => ["Mon Apr 29 15:37:57 +0000 2019", "Mon Apr 29 16:45:43 +0000 2019", "Mon Apr 29 17:18:21 +0000 2019"],
		:entities => [
			Dict{String, Any}("user_mentions" => Any[Dict{String, Any}("screen_name" => "Quedusse")], "hashtags" => Any[Dict{String, Any}("text"=>"GameOfThrones")]),
			Dict{String, Any}("user_mentions" => Any[], "hashtags" => Any[Dict{String,Any}("text"=>"GameOfThrones")]),
			Dict{String, Any}("user_mentions"  => Any[], "hashtags" => Any[Dict{String,Any}("text"=>"NotToday")])
		],
		:id => [1122867622738124801, 1122867622738124802, 1122867622738124803],
		:is_quoted_status => [false, false, true]
	)
	@test test_df.created_at == loaded_df.created_at
	@test test_df.id == loaded_df.id
	@test test_df.entities == loaded_df.entities
	@test test_df.is_quoted_status == loaded_df.is_quote_status
end;

path = "testdata/test.json"
tweets_df = loadtweets(path)

@testset "Analyses" begin
	#lang distribution
	test_df = DataFrame(:lang => ["pt", "en", "es"], :cnt => [3, 9, 1])
	@test cntoccurences(tweets_df, :lang) == test_df

	#entities distribution
	entities_df = cntentities(tweets_df)
	hashtags_df = entities_df[:hashtags]
	mentions_df = entities_df[:mentions]
	domains_df = entities_df[:domains]

	test_hashtagsdf = DataFrame(:hashtags => ["gameofthrones", "nottoday", "aryaforthethrone"],
		:cnt => [5, 2, 1])
	@test first(sort!(hashtags_df, :cnt, rev=true), 3) == test_hashtagsdf

	test_mentionsdf = DataFrame(:mentions => ["oyin_araoye", "OtraPendeja", "thehippienikki"],
		:cnt => [2, 1, 1])
	@test first(sort!(hashtags_df, :cnt, rev=true), 3) == test_hashtagsdf

	test_domainsdf = DataFrame(:domains => ["test1.com", "test.com"], :cnt => [2, 1])
	@test first(sort!(domains_df, :cnt, rev=true), 3) == test_domainsdf

	#activity distribution
	activities_df = cntactivities(tweets_df)
	weekly_df = activities_df[:weekly_activity]
	hourly_df = activities_df[:hourly_activity]

	test_weeklydf = DataFrame(:weekday=>range(1,stop=7), :cnt=>0)
	test_weeklydf[2, :] = 2
	test_weeklydf[1, :] = 11
	@test sort!(weekly_df, :cnt, rev=true).cnt == sort!(test_weeklydf, :cnt, rev=true).cnt

	test_hourlydf = DataFrame(:hour=>range(1,stop=24), :cnt=>0)
	test_hourlydf[14, :] = 11
	test_hourlydf[17, :] = 1
	test_hourlydf[18, :] = 1
	@test sort!(hourly_df, :cnt, rev=true).cnt == sort!(test_hourlydf, :cnt, rev=true).cnt
end;

@testset "Plots" begin
	lang_df = cntoccurences(tweets_df, :lang)
	plotdata(lang_df, :lang, :cnt; ptitle="Lang distribution", xlabels="Languages")
	destpath = string(pwd(), Base.Filesystem.path_separator,
		"testdata", Base.Filesystem.path_separator, "lang.png")
	savefig(destpath)
end;
