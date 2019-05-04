function plotdata(df::AbstractDataFrame, x::Symbol, y::Symbol;
        ptitle::AbstractString="", xlabels::AbstractString="", ylabels::AbstractString="Number of instances")
    sorted_df = sort(df, y, rev=false)

    PyPlot.plt.tight_layout()

    clf()
    title(ptitle)

    xlabel(xlabels, labelpad=25)
    ylabel(ylabels, labelpad = 35)
    xticks(rotation=45)

    PyPlot.plt.bar(sorted_df[x], sorted_df[y])
end
