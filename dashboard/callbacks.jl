# Translates typed BetaCode into Unicode, putting it in #greekOutput
callback!(app, Output("greekOutput", "children"), Input("greekInput", "value")) do input_value
        "$(BetaReader.transcodeGreek(input_value))"
end

# Responds to a click on the alphabet-list (on the left), by loading words in #volumeList
callback!(
    app, 
    Output("volumeList", "options"), 
    Input("alphaList", "value"),
    prevent_initial_call=true) do input_value

    filteredLexIdx = filterLexIndex(input_value, lsj_keys)

    newOptions = begin
        if (input_value == "") vec([])
        else lexIndexToOptions(filteredLexIdx)
        end 
    end

    newOptions
end

