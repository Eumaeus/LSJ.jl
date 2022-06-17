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

#Checks contents of #passageInput for a valid Cite2Urn; if there is one, activate button #querySubmit
callback!(
    app, 
    Output("querySubmit", "disabled"), 
    Input("passageInput", "value"),
    prevent_initial_call=true) do input_value

    trialUrn = getUrn(input_value)

    if (trialUrn == Nothing) true
    else false
    end
end

#TESTING update the URL
callback!(
        app,
        Output("thisUrl", "search"),
        Input("passageInput", "value"),
        prevent_initial_call=true) do input_value

    if (input_value == Nothing) "?urn="
    else
            trialUrn = getUrn(input_value)

            if (trialUrn == Nothing) "?urn="
            else "?urn=$input_value"
            end
        end

end

callback!(
   app,
   Output("urlDisplay", "children"),
   Input("thisUrl", "search")) do input_value

   input_value
end


#If there is a valid URN in #passageInput, change the text of button #querySubmit
callback!(
    app, 
    Output("querySubmit", "children"), 
    Input("querySubmit", "disabled"),
    prevent_initial_call=true) do input_value

    if (input_value) # == "disabled; true"
        "Enter a valid URN"
    else
        "Look up entry for URN"
    end

end