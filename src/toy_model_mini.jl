function load_toy_model_mini()
    S = 
    [
        #|  v1   |  v2   |  
            1.0     -1.0;   # |  S
    ]
    rxns = [  "v1"  ,  "v2" ]
    c    = [  0.0   ,  1.0   ]
    xl   = [  -100.0   ,  -100.0 ]
    xu   = [  100.0   ,  100.0 ]
    mets = [  "S"  ]
    b    = [  0.0  ]


    return CoreModel(S, b, c, xl, xu, rxns, mets)
end