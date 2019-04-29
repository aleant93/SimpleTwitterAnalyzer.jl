using Documenter
using SimpleTwitterAnalyzer

makedocs(
    sitename = "SimpleTwitterAnalyzer",
    format = Documenter.HTML(),
    modules = [SimpleTwitterAnalyzer]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#
deploydocs(
    repo = "github.com/aleant93/SimpleTwitterAnalyzer.jl.git",
    target = "build"
)
