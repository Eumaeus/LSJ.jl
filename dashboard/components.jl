alphaMenu = begin 
	dcc_radioitems( 
		id = "alphaList", 
		className = "greekFont",
    labelStyle = Dict("display" => "flex"),
		options = [		
			(label = "Αα", value = "α"),
			(label = "Ββ", value = "β"),
			(label = "Γγ", value = "γ"),
			(label = "Δδ", value = "δ"),
			(label = "Εε", value = "ε"),
			(label = "Ζζ", value = "ζ"),
			(label = "Ηη", value = "η"),
			(label = "Θθ", value = "θ"),
			(label = "Ιι", value = "ι"),
			(label = "Κκ", value = "κ"),
			(label = "Λλ", value = "λ"),
			(label = "Μμ", value = "μ"),
			(label = "Νν", value = "ν"),
			(label = "Ξξ", value = "ξ"),
			(label = "Οο", value = "ο"),
			(label = "Ππ", value = "π"),
			(label = "Ρρ", value = "ρ"),
			(label = "Σς", value = "ς"),
			(label = "Ττ", value = "τ"),
			(label = "Υυ", value = "υ"),
			(label = "Φφ", value = "φ"),
			(label = "Χχ", value = "χ"),
			(label = "Ψψ", value = "ψ"),
			(label = "Ωω", value = "ω")
		])
end

volumeList = begin
	dcc_radioitems(
		id = "volumeList",
		className = "greekFont",
		options = []
	)
end

searchDiv = html_div( id = "searchDiv" ) do 
	html_label( className="inputLabel", htmlFor="greekInput", "Search Greek:"),
	dcc_input( className="inputLabel", id="greekInput", autoComplete="false", type="text", size="30", value=""),
	html_span( id="greekOutput", "Nothing typed")
end

searchEnglishDiv = html_div( id = "searchEnglishDiv") do 
	html_label( className="inputLabel", htmlFor="englishInput", "Search All Text:"),
	dcc_input( className="inputLabel", id="englishInput", type="text", size="30", value=""),
	html_button( id="searchButton", "Search All Text")
end

passageInputDiv = html_div( id = "passageInputDiv" ) do 
	html_label( className="invalidPassage inputLabel", htmlFor="passageInput", "Retrieve by URN:"),
	dcc_input( className="inputLabel", id="passageInput", type="text", size="30", placeholder = "urn:cite2:hmt:lsj.chicago_md:n147"),
	html_button( id="querySubmit", disabled=true,  "Enter a valid URN")
end

resultsList = html_ul( id = "resultsList")

entryDiv = html_div(id = "entryDiv", className = "greekFont")

#=
<ul id="resultsList">
</ul>

<div id="entryDiv" class="greekFont">
	
=#


bottomSmallPrint = dcc_markdown("""A Greek-English Lexicon*, Henry George Liddell, Robert Scott, revised and augmented throughout by Sir Henry Stuart Jones with the assistance of Roderick McKenzie (Oxford: Clarendon Press. 1940). Text provided by Perseus Digital Library, with funding from The National Endowment for the Humanities. Original version available for viewing and download at <http://www.perseus.tufts.edu/>. This application is ©2022, Christopher W. Blackwell, licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). CITE/CTS is ©2002–2022 Neel Smith and Christopher Blackwell. The implementations of the [CITE](http://cite-architecture.github.io) were written by Neel Smith and Christopher Blackwell using Julia and Dash.jl. Licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). Sourcecode on [GitHub](https://github.com/Eumaeus/LSJ.jl). Report bugs by [filing issues on GitHub](https://github.com/Eumaeus/LSJ.jl/issues).""")

