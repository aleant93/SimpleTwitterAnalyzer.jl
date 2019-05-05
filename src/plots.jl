function plotdata(df::AbstractDataFrame, x::Symbol, y::Symbol;
        ptitle::AbstractString="A title",
        x_label::AbstractString="",
        y_label::AbstractString="Number of instances",
        x_ticks::AbstractArray=[])
    sorted_df = sort(df, y, rev=false)

    #PyPlot.plt.tight_layout()

    clf()
    title(ptitle)

    xticks(rotation=45)
    if !isempty(x_ticks)
        xticks(sorted_df[x], x_ticks, rotation=45)
    end

    xlabel(x_label, labelpad=25)
    ylabel(y_label, labelpad = 35)

    PyPlot.plt.bar(sorted_df[x], sorted_df[y])
end
