
function indexToWordUrn(idx::Vector{Tuple{String, String, Cite2Urn}} = lsj_keys)::Vector{Tuple{String, Cite2Urn}}
    map(idx) do item
        (item[2], item[3])
    end
end

function makeOption( l::String, v::String )::NamedTuple{(:label, :value), Tuple{String, String}}
    (label = l, value = v)
end 

function makeOption( l::String, u::Cite2Urn )::NamedTuple{(:label, :value), Tuple{String, String}}
    (label = l, value = "$u")
end 

function wordUrnToOption(wu::Vector{Tuple{String, Cite2Urn}})::NamedTuple{(:label, :value), Tuple{String, String}}
    map(wu) do item
        makeOption(item[1], item[2])
    end
end

function filterLexIndex(greekString::String , idx::Vector{Tuple{String, String, Cite2Urn}} = lsj_keys)::Vector{Tuple{String, String, Cite2Urn}}

    filter(idx) do item
        startswith(item[1], greekString)
    end
    
end





# Functions for searching and retrieving

#=
    dcc_dropdown(
        id = "articles"
    ),
    dcc_input(
        id = "word_search"
    ),
    html_div( id = "display")
=#

#=
function article_menu( search_term, lex_keys, lex )
    if length(search_term) < 3
       [(label = "Type more!", value = "")] 
    else
        equals_index = findall(st -> st == search_term, lex_keys)
        starts_with_index = findall(st -> startswith(st, search_term), lex_keys)
        contains_index = findall(st -> contains(st, search_term), lex_keys)
        findindex = vcat(equals_index, starts_with_index, contains_index) |> unique
        found_tups = map( findindex ) do index_num
            (label = "$(lex.data[index_num].key):$(lex.data[index_num].urn)", value = index_num)
        end
        found_tups
    end
end

function get_article(index_num, lexicon)
    lexicon.data[index_num].entry |> dcc_markdown
end

callback!(
    app,
    Output("articles", "options"),
    Input("word_search", "value"),
    prevent_initial_call=true
) do ws
    article_menu(ws, lsj_keys, lexicon)
end

callback!(
    app,
    Output("display", "children"),
    Input( "articles", "value" ),
    prevent_initial_call=true
) do index_num
    get_article(index_num, lexicon)
end

=#