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
			(label = "Σς", value = "σ"),
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
    labelStyle = Dict("display" => "flex"), # or inline-block?
		options = []
	)
end

selectedUrnDiv = html_div( id = "selectedUrnDiv") do 
	html_p( id = "selectedUrnP", className = "app_hidden", "Urn goes here")
end

searchDiv = html_div( id = "searchDiv" ) do 
	html_label( className="inputLabel", htmlFor="greekInput", "Search Greek:"),
	dcc_input( className="inputLabel", id="greekInput", debounce = false, autoComplete="false", type="text", size="30", value=""),
	html_span( id="greekOutput", "Nothing typed")
end

searchEnglishDiv = html_div( id = "searchEnglishDiv") do 
	html_label( className="inputLabel", htmlFor="englishInput", "Search All Text:"),
	dcc_input( className="inputLabel", id="englishInput", type="text", size="30", value=""),
	html_button( id="searchButton", "Search All Text", disabled = true)
end

passageInputDiv = html_div( id = "passageInputDiv" ) do 
	html_label( className="invalidPassage inputLabel", htmlFor="passageInput", "Retrieve by URN:"),
	dcc_input( className="inputLabel", id="passageInput", type="text", size="30", placeholder = "urn:cite2:hmt:lsj.chicago_md:n147"),
	html_button( id="querySubmit", disabled=true, value = "",  "Enter a valid URN")
end

resultsList = dcc_radioitems(
		id = "resultsList",
		className = "greekFont",
    labelStyle = Dict("display" => "inline-block"), # or inline-block?
		options = []
	)

entryDiv = html_div(id = "entryDiv", className = "greekFont") do
	html_div(id = "lexEntryDiv", className = "greekFont") do
		html_p( id = "lexEntryLinkP", className = "lexEntryLinkP") do 
			html_span( id = "lexEntryLink", className = "lexEntryLink", "")
		end,
		html_p( id = "lexEntryUrnP", className = "lexEntryUrnP") do 
			html_span( id = "lexEntryUrn", className = "lexEntryUrn", ""),
			dcc_clipboard( id = "copyUrn", className = "app_hidden", target_id = "lexEntryUrn")
		end,
		html_p( id = "lexEntryLabel", className = "lexEntryLabel", ""),
		html_div( id = "lexEntry", className = "lexEntry")
	end
end

#=
<div id="entryDiv" class="greekFont">
			<div id="lexEntryContainerDiv_urn:cite2:hmt:lsj.chicago_md:n8870" class="lexEntryDiv">
						<p class="lexEntryLinkP"><span class="lexEntryLink" id="entryLink_urn:cite2:hmt:lsj.chicago_md:n8870">
			<a href="http://folio2.furman.edu/lsj/?urn=urn:cite2:hmt:lsj.chicago_md:n8870">Link</a>
		</span>
						</p>
						<p class="lexEntryUrnP"><span class="lexEntryUrn" id="entryUrn_urn:cite2:hmt:lsj.chicago_md:n8870">
			<a> urn:cite2:hmt:lsj.chicago_md:n8870 </a></span></p>
						<p class="lexEntryLabel">ἀνθρωπο-βορία</p>
						<p class="lexEntry" id="lexEntry_urn:cite2:hmt:lsj.chicago_md:n8870"><strong>ἀνθρωποβορία</strong>, ἡ, <code>A</code> <strong>cannibalism</strong>, Zeno Stoic. 1.59 (pl.). 
</p>
					</div>
		</div>
	
=#


bottomSmallPrint = dcc_markdown("""*A Greek-English Lexicon*, Henry George Liddell, Robert Scott, revised and augmented throughout by Sir Henry Stuart Jones with the assistance of Roderick McKenzie (Oxford: Clarendon Press. 1940). Text provided by Perseus Digital Library, with funding from The National Endowment for the Humanities. Substantial additions to the original Perseus data are courtesy of the hard work of Helma Dik and Giuseppe Celano. Original version available for viewing and download at <http://www.perseus.tufts.edu/>. This application is ©2022, Christopher W. Blackwell, licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). CITE/CTS is ©2002–2022 Neel Smith and Christopher Blackwell. The implementations of the [CITE](http://cite-architecture.github.io) were written by Neel Smith and Christopher Blackwell using Julia and Dash.jl. Licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). Sourcecode on [GitHub](https://github.com/Eumaeus/LSJ.jl). Report bugs by [filing issues on GitHub](https://github.com/Eumaeus/LSJ.jl/issues).""")

