alphaMenu = begin 
	html_ul( id = "alphaList", className = "greekFont") do 
		html_li( id="alpha_Αα", "Αα"),
		html_li(id = "alpha_Ββ", "Ββ"),
		html_li(id = "alpha_Γγ", "Γγ"),
		html_li(id = "alpha_Δδ", "Δδ"),
		html_li(id = "alpha_Εε", "Εε"),
		html_li(id = "alpha_Ζζ", "Ζζ"),
		html_li(id = "alpha_Ηη", "Ηη"),
		html_li(id = "alpha_Θθ", "Θθ"),
		html_li(id = "alpha_Ιι", "Ιι"),
		html_li(id = "alpha_Κκ", "Κκ"),
		html_li(id = "alpha_Λλ", "Λλ"),
		html_li(id = "alpha_Μμ", "Μμ"),
		html_li(id = "alpha_Νν", "Νν"),
		html_li(id = "alpha_Ξξ", "Ξξ"),
		html_li(id = "alpha_Οο", "Οο"),
		html_li(id = "alpha_Ππ", "Ππ"),
		html_li(id = "alpha_Ρρ", "Ρρ"),
		html_li(id = "alpha_Σς", "Σς"),
		html_li(id = "alpha_Ττ", "Ττ"),
		html_li(id = "alpha_Υυ", "Υυ"),
		html_li(id = "alpha_Φφ", "Φφ"),
		html_li(id = "alpha_Χχ", "Χχ"),
		html_li(id = "alpha_Ψψ", "Ψψ"),
		html_li(id = "alpha_Ωω", "Ωω")
	end
end

searchDiv = html_div( id = "searchDiv" , "search")

searchEnglishDiv = html_div( id = "searchEnglishDiv", "search english")

passageInputDiv = html_div( id = "passageInputDiv", "urn input")

bottomSmallPrint = dcc_markdown("""A Greek-English Lexicon*, Henry George Liddell, Robert Scott, revised and augmented throughout by Sir Henry Stuart Jones with the assistance of Roderick McKenzie (Oxford: Clarendon Press. 1940). Text provided by Perseus Digital Library, with funding from The National Endowment for the Humanities. Original version available for viewing and download at <http://www.perseus.tufts.edu/>. This application is ©2022, Christopher W. Blackwell, licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). CITE/CTS is ©2002–2022 Neel Smith and Christopher Blackwell. The implementations of the [CITE](http://cite-architecture.github.io) were written by Neel Smith and Christopher Blackwell using Julia and Dash.jl. Licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). Sourcecode on [GitHub](https://github.com/Eumaeus/LSJ.jl). Report bugs by [filing issues on GitHub](https://github.com/Eumaeus/LSJ.jl/issues).""")

#=
<div id="searchDiv">
	<label class="inputLabel" for="greekInput">Search Greek: </label>
	<input class="greekInputField" id="greekInput" size="30">	
	<span id="greekOutput"></span>
</div>

<div id="searchEnglishDiv">
	<label class="inputLabel" for="englishInput">Search All Text: </label>
	<input class="greekInputField" id="englishInput" size="30">	
	<button id="searchButton">Search All Text</button>
</div>

<div id="passageInputDiv">
	<label for="passageInput" class="invalidPassage inputLabel"> Retrieve by URN: </label>
	<input id="passageInput" type="text" size="30" placeholder="urn:cite2:hmt:lsj.chicago_md:n147" class="invalidPassage">
	<button id="querySubmit" disabled="">Enter a valid URN</button>
</div>

<ul id="resultsList">
</ul>

<div id="entryDiv" class="greekFont">
	
</div>


*A Greek-English Lexicon*, Henry George Liddell, Robert Scott, revised and augmented throughout by Sir Henry Stuart Jones with the assistance of Roderick McKenzie (Oxford: Clarendon Press. 1940). Text provided by Perseus Digital Library, with funding from The National Endowment for the Humanities. Original version available for viewing and download at <http://www.perseus.tufts.edu/>. This application is ©2022, Christopher W. Blackwell, licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). CITE/CTS is ©2002–2022 Neel Smith and Christopher Blackwell. The implementations of the [CITE](http://cite-architecture.github.io) were written by Neel Smith and Christopher Blackwell using Julia and Dash.jl. Licensed under the [GPL 3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). Sourcecode on [GitHub](https://github.com/Eumaeus/LSJ.jl). Report bugs by [filing issues on GitHub](https://github.com/Eumaeus/LSJ.jl/issues). =#