callback!(app, Output("greekOutput", "children"), Input("greekInput", "value")) do input_value
        "$(BetaReader.transcodeGreek(input_value))"
end

