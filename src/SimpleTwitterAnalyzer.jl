"""
A simple tool to analyzer Twitter data.
"""
module SimpleTwitterAnalyzer

using CSV
using JSON
using Dates
using PyPlot
using Printf
using CSVFiles
using DataFrames
using URIParser

export loadtweets
export cntoccurences, cntentities, cntplaces, cntactivities
export plotdata
export runallstats, savestats, plotstats

include("io.jl")
include("analyzer.jl")
include("plots.jl")
include("utils.jl")


end # module
