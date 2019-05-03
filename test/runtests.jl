using Test, DataFrames
using SimpleTwitterAnalyzer

#setup code
path = "testdata/test.json"
tweetsdf = load_tweets(path)

# @testset "IO" begin
#
# end;

@testset "Analyses" begin
	#lang distribution
	testdf = DataFrame(:lang => ["pt", "en", "es"], :cnt => [3, 9, 1])
	@test cntoccurences(tweetsdf, :lang) == testdf

	#source distribution
	#testdf = DataFrame(:source => ["<a href="http://twitter.com/download/iphone" rel="nofollow">Twitter for iPhone</a>"])
	#@test_throws DomainError (-1)^0.5
end;
