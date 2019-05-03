using Test
using HypergraphsYelp
using SimpleHypergraphs
using LightGraphs
using PyPlot

println("Loading data ..")
@time model = load_data("./data",100)
destdir = "./plots"

##
#
#plotting histograms
#
##

data = [:users, :businesses]

#field => (function to compute on the raw data to plot, plotmetadata)
histfields = [[:reviewcount=>Dict("func"=>nothing, "bins"=>50, "title"=>"Review cnt distribution"), #users
    :friends=>Dict("func"=>length, "bins"=>50, "title"=>"Friends cnt distribution"),
    :totcompliment=>Dict("func"=>nothing, "bins"=>50, "title"=>"Compliments cnt distribution"),
    :avgstars=>Dict("func"=>nothing, "bins"=>10, "title"=>"User stars distribution")],
    [:stars=>Dict("func"=>nothing, "bins"=>10, "title"=>"Business stars distribution")] #business
]
histdata = zip(data, histfields)

for d in zip(data, histfields)
    for field in d[2]
        data = generatehistogramdata(model, d[1], field[1], field[2]["func"])
        yelphistogram(data, field[2]["bins"], string(field[2]["title"], ", bins=", field[2]["bins"]))
        destpath = string(destdir, string(Base.Filesystem.path_separator, String(field[1]),".png"))
        savefig(destpath)
    end
end

println("Histograms generated into ", destdir)

##
#
#plotting bar charts
#
##

data = [:businesses]

#field => plotmetadata
plotfields = [[:categories=>Dict("title"=>"Business categories distribution", "ylabel"=>"Number of businesses"],
    :city=>Dict("title"=>"Business cities distribution", "ylabel"=>"Number of businesses"),
    :state=>Dict("title"=>"Business states distribution", "ylabel"=>"Number of businesses")]
    ] #business

for d in zip(data, histfields)
    for field in d[2]
        data = generatebarchartdata(model, d[1], field[1])
        howmany = 3
        #yelphbarchart_topn(data, string(field[2]["title"], ", top", howmany), howmany)
        yelphbarchart(data, howmany,
            ptitle=string(field[2]["title"], ", top", howmany),
            y_label=field[2]["ylabel"])
        savefig(string(destdir, string(Base.Filesystem.path_separator, String(field[1]),".png")))
    end
end

println("Bar charts generated into ", destdir)
