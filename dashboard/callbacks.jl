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

# If a urn is submitted from #querySubmit, go ahead and cancel any selection in #volumeList
callback!(
    app, 
    Output("volumeList", "value"), 
    Input("querySubmit", "n_clicks"),
    State("querySubmit", "value"),
    prevent_initial_call=true) do input_value, input_state

    ""
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

#Checks contents of #passageInput for a valid Cite2Urn; if there is one, add that URN to the @value of button #querySubmit
callback!(
    app, 
    Output("querySubmit", "value"), 
    Input("passageInput", "value"),
    prevent_initial_call=true) do input_value

    trialUrn = getUrn(input_value)

    newValue::String = begin
        if (trialUrn == Nothing) ""
        else string(trialUrn)
        end
    end

    newValue
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

#= 
    A Switcher callback. Alas, one of several.
    Activated from #volumeList, from #passageInput, or from #resultsList
    Delivers results to #selectedUrnP
=#

callback!(
    app,
    Output("selectedUrnP", "children"),
    Input("querySubmit", "n_clicks"),
    Input("volumeList", "value"),
    State("querySubmit", "value"),
    prevent_initial_call = true) do qValue, vValue, qState

    # querySubmit.n_clicks
    # volumeList.value

    ctx = callback_context()
    trigger_id = ctx.triggered[1].prop_id

    if (trigger_id == "volumeList.value")
        return vValue
    elseif (trigger_id == "querySubmit.n_clicks")
        return qState
    else
        return ""
    end

    #return string(ctx) * " *** " * trigger_id

end


# When #selectedUrnP changes, get an entry and put it in #entryDiv as Markdown
callback!(
    app,
    Output("lexEntry", "children"),
    Input("selectedUrnP", "children"),
    prevent_initial_call = true
    ) do input_value

    if (input_value == Nothing) ""
    else
        trialUrn = getUrn(input_value)

        if (trialUrn == Nothing) PreventUpdate()
        else
            lexEntry::String = lookupUrnEntry(trialUrn)
            return dcc_markdown(lexEntry)
        end
    end
end

# When #selectedUrnP changes, get an entry's .key and put it in #lexEntryLabel
callback!(
    app,
    Output("lexEntryLabel", "children"),
    Input("selectedUrnP", "children"),
    prevent_initial_call = true
    ) do input_value

    if (input_value == Nothing) ""
    else
        trialUrn = getUrn(input_value)

        if (trialUrn == Nothing) PreventUpdate()
        else
            lexKey::String = lookupUrnKey(trialUrn)
            return dcc_markdown(lexKey)
        end
    end
end

# When #selectedUrnP changes, update #alphaList
callback!(
    app, 
    Output("alphaList", "value"), 
    Input("selectedUrnP", "children"),
    prevent_initial_call=true) do input_value

    if (input_value == Nothing) PreventUpdate()
    else
        trialUrn = getUrn(input_value)

        if (trialUrn == Nothing) PreventUpdate()
        else
            firstLetter::String = firstLetterForUrn(trialUrn)
            if (firstLetter == "") PreventUpdate()
            else transcodeGreek(firstLetter)
            end
        end
    end
end

# When #volumeList is updated, zero the value of #passageInput
callback!(
    app,
    Output("passageInput", "value"),
    Input("volumeList", "value"),
    prevent_initial_call = true
    ) do input_value

    ""

end

#= When #selectedUrnP changes update #volumeList
=#


# When #resultsList changes, update #selecteUrnP

# When #resultsList changes, update #alphaList

# When #resultsList changes, update #volumeList

# When #selectedUrnP changes, update #lexEntryLink
callback!(
    app,
    Output("lexEntryLink", "children"),
    Input("selectedUrnP", "children"),
    prevent_initial_call = true
    ) do input_value

    if (input_value == Nothing) PreventUpdate()
    else
        trialUrn = getUrn(input_value)

        if (trialUrn == Nothing) PreventUpdate()
        else
            linkUrl = "?urn=$(string(trialUrn))"
            html_a( href=linkUrl, "Link")            
        end
    end

end

# When #selectedUrnP changes, update #lexEntryUrn
callback!(
    app,
    Output("lexEntryUrn", "children"),
    Input("selectedUrnP", "children"),
    prevent_initial_call = true
    ) do input_value

    if (input_value == Nothing) PreventUpdate()
    else
        trialUrn = getUrn(input_value)

        if (trialUrn == Nothing) PreventUpdate()
        else
            html_a(string(trialUrn))            
        end
    end

end

# When #lexEntryUrn is populated, change the .class of #copyUrn
callback!(
    app,
    Output("copyUrn", "className"),
    Input("lexEntryUrn", "children"),
    prevent_initial_call = true
    ) do entry_value

        if (entry_value == "") PreventUpdate()
        else "app_visible"
        end

end

# When something is typed and transformed into #greekOutput, update #resultsList options
callback!(
    app,
    Output("resultsList", "options"),
    Input("greekInput", "value"),
    prevent_initial_call = true) do input_value

    sl = length(input_value)

    if (sl == 0) return []
    elseif (sl < 3) 
        le = lemmaEquals(input_value)
        allFound = cat(le, dims=1)
        entryFindsToOptions(allFound) |> unique
    elseif (sl < 4)
        le = lemmaEquals(input_value)
        lbw = lemmaBeginsWith(input_value)
        ec = entryContains(input_value)
        #allFound = cat(le, lbw, lc, ec, dims=1) |> unique
        allFound = cat(le, lbw, lc, ec, dims=1)
        entryFindsToOptions(allFound) |> unique
    elseif( sl < 5 )
        le = lemmaEquals(input_value)
        lbw = lemmaBeginsWith(input_value)
        lc = lemmaContains(input_value)
        ec = entryContains(input_value)
        #allFound = cat(le, lbw, lc, ec, dims=1) |> unique
        allFound = cat(le, lbw, lc, ec, dims=1)
        entryFindsToOptions(allFound) |> unique
    else
        le = lemmaEquals(input_value)
        lbw = lemmaBeginsWith(input_value)
        lc = lemmaContains(input_value)
        ec = entryContains(input_value)
        #allFound = cat(le, lbw, lc, ec, dims=1) |> unique
        allFound = cat(le, lbw, lc, ec, dims=1)
        entryFindsToOptions(allFound) |> unique
    end

end 
