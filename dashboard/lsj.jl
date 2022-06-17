using Pkg
Pkg.activate(joinpath(pwd(), "dashboard"))
Pkg.resolve()
Pkg.instantiate()

assetsfolder = joinpath(pwd(), "dashboard", "assets")

using Dash
using Downloads
using CitableBase
using CitableCollection
using CitableObject
using Tables
using Unicode
using BetaReader

include("components.jl")
include("functions.jl")


# Default port!
DEFAULT_PORT = 8054

# CSS and Javascript


#Download content of `url` and read it into a string value."
function string_dl(url)
	Downloads.download(url) |> read |> String
end

#Load file from local"
function string_load(path)
    read(path) |> String
end

# Load data from Github into a CiteCollection
function load_data()
    #lsj_gh_url = "https://raw.githubusercontent.com/Eumaeus/cite_lsj_cex/master/lsj_chicago.cex"
    #lsj_data = string_dl(lsj_gh_url)
    lsj_path = joinpath(assetsfolder, "lexicon.cex")
    lsj_data = string_load(lsj_path)
    #=
    lsj_data = begin
        f = open(lsj_path, "r")
        s = read(f, String)
        close(f)
        s
    end 
    =#
    lsj_coll = fromcex(lsj_data, RawDataCollection, delimiter = "#")[2]
    lsj_index = begin
       map( lsj_coll.data ) do item 
         alpha = filter( c -> Unicode.isletter(c), item.key)
         (Unicode.normalize(alpha, stripmark=true), item.key, item.urn)
       end
    end
    (lsj_index, lsj_coll)
end

# lsj_index = (stripped_lemma, urn)

# Get both an index (keys) and the whole LSJ (lexicon) as a tuple
(lsj_keys, lexicon) = load_data()
println("loaded: $(length(lsj_keys)) keys")
println("loaded: $(length(lexicon.data)) entries")
println("example: $(lsj_keys[200]): $(typeof(lsj_keys[200]))")


external_stylesheets = ["application.css"]
 

# This will make it easy to install in Houston
app = if haskey(ENV, "URLBASE")
    dash(assets_folder = assetsfolder, include_assets_files=true, url_base_pathname = ENV["URLBASE"], external_stylesheets = external_stylesheets)
else
    dash(assets_folder = assetsfolder, include_assets_files = true, external_stylesheets = external_stylesheets)
end

#=
    !!! WebPage Here !!!
=#
app.layout = html_div(className = "w3-container") do 

    html_header() do 
        dcc_markdown("*A Greek-English Lexicon*, Henry George Liddell, Robert Scott, revised and augmented throughout by Sir Henry Stuart Jones with the assistance of Roderick McKenzie (Oxford: Clarendon Press. 1940)."),
        html_span(id="app_header_versionInfo", "CITE (Julia) version 0.1.0"),
        html_div(id = "main_message", className = "app_message app_hidden default") do 
            dcc_markdown("""
                Loaded $(length(lexicon)) characters of lexical data.
            """)
        end
    end,
    html_article( id = "main_Container") do 
        dcc_markdown( 
            id = "menu",
            """[The Lewis &amp; Short Latin /Dictionary](http://folio2.furman.edu/lewis-short/index.html) | [The CITE Architecture](http://cite-architecture.github.io) | [About this project](https://eumaeus.github.io/2018/10/30/lsj.html)"""
        ),
        alphaMenu,
        html_ul( id = "volumeList", className = "greekFont"),
        #volumeList,
        html_div( id = "lexiconDiv") do 
            html_div() do
                searchDiv,
                searchEnglishDiv,
                passageInputDiv
            end,
            resultsList,
            entryDiv
        end
    end,
    html_div( className = "push", " "),
    html_div( className = "smallPrint") do 
      bottomSmallPrint 
    end


end

# Debug stuff
#println(alphaList.options)

# Callback here

include("callbacks.jl")



run_server(app, "0.0.0.0", DEFAULT_PORT, debug=true)
    

