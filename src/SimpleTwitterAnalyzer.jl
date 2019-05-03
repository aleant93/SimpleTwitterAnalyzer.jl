module SimpleTwitterAnalyzer

using JSON
using Dates
using PyPlot
using DataFrames
using URIParser

export load_tweets
export cntoccurences, cntentities, activityfrequency, cntplaces
export plotdata

include("io.jl")
include("analyzer.jl")
include("plots.jl")


end # module
