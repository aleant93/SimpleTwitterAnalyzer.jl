function plotdata(df::AbstractDataFrame, x::Symbol, y::Symbol, title::AbstractString)
    sort!(df, :cnt, rev=false)
    println(df)
end
