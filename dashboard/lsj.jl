using Pkg
Pkg.activate(joinpath(pwd(), "dashboard"))
Pkg.resolve()
Pkg.instantiate()

assets = joinpath(pwd(), "dashboard", "assets")

using Dash
using Downloads

# Default port!
DEFAULT_PORT = 8080

"Download content of `url` and read it into a string value."
function string_dl(url)
	Downloads.download(url) |> read |> String
end

# Load data from Github
lsj_gh_url = "https://raw.githubusercontent.com/Eumaeus/cite_lsj_cex/master/lsj_chicago.cex"
lsj_data = string_dl(lsj_gh_url)

# This will make it easy to install in Houston
app = if haskey(ENV, "URLBASE")
    dash(assets_folder = assets, url_base_pathname = ENV["URLBASE"])
else
    dash(assets_folder = assets)
end

app.layout = html_div(className = "w3-container") do 
    dcc_markdown("# LSJ Lexicon"),
    dcc_markdown("""
        Loaded $(length(lsj_data)) characters of lexical data.
    """)
end

run_server(app, "0.0.0.0", DEFAULT_PORT, debug=true)
    

