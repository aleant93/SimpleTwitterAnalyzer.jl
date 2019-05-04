# SimpleTwitterAnalyzer.jl

*A quick and simple Twitter analyzer Tool.*

| **Documentation** | **Build Status** |
|---------------|--------------|
| <!-- [![][docs-stable-img]][docs-stable-url] <br/> --> [![][docs-latest-img]][docs-dev-url] | [![Build Status][travis-img]][travis-url]  [![Coverage Status][codecov-img]][codecov-url] <br/> Linux and macOS |

## Documentation
<!-- - [**STABLE**][docs-stable-url] &mdash; **documentation of the most recently tagged version.** -->
- [**DEV**][docs-dev-url] &mdash; **documentation of the development version.**

[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-dev-url]: https://aleant93.github.io/SimpleTwitterAnalyzer.jl/dev
[docs-stable-url]: https://aleant93.github.io/SimpleTwitterAnalyzer.jl/stable

[travis-img]: https://travis-ci.org/aleant93/SimpleTwitterAnalyzer.jl.svg?branch=master
[travis-url]: https://travis-ci.org/aleant93/SimpleTwitterAnalyzer.jl

[codecov-img]: https://coveralls.io/repos/github/aleant93/SimpleTwitterAnalyzer.jl/badge.svg?branch=master&service=github
[codecov-url]: https://coveralls.io/github/aleant93/SimpleTwitterAnalyzer.jl?branch=master

## Description
Need a quick Julia-based solution to analyze your tweet? This tool may be the answer your looking for!

This tool - based on the Python library [tweets_analyzer.py](https://github.com/x0rz/tweets_analyzer/blob/master/tweets_analyzer.py) - allows you to:
1. run some basic statistics on the tweets you provide, such as find the most used hashtags and the language distribution of your data set;
2. save your stats in a csv format;
3. plot and save your stats.

### TODOs
- Improving the plotting of some stats
- Handle in a better way the source field
- Adding a crawling component able to download tweets directly from Twitter
