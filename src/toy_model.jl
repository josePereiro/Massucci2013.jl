function load_toy_model()
    S = 
    [
        #|  us   |  ua   |  ul   |  vg   |  va   |  vr   |  vf   |   z   | 
            1.0     0.0     0.0    -1.0     0.0     0.0     0.0     0.0     # |  S
            0.0     0.0     0.0     1.0     1.0    -1.0    -1.0     0.0     # |  P
            0.0     0.0     0.0     1.0     0.0     1.0     0.0    -1.0     # |  E
            0.0     1.0     0.0     0.0    -1.0     0.0     0.0    -1.0     # |  A
            0.0     0.0     1.0     0.0     0.0     0.0     1.0     0.0     # |  W
    ]
    rxns = [  "us"  ,  "ua"  ,  "ul"  ,  "vg"  ,  "va"  ,  "vr"  ,  "vf"  ,  "z"   ]
    c    = [  0.0   ,  0.0   ,  0.0   ,  0.0   ,  0.0   ,  0.0   ,  0.0   ,  1.0   ]
    xl   = [  0.0   ,  0.0   , -100.0 ,  0.0   ,  0.0   ,  0.0   ,  0.0   ,  0.0   ]
    xu   = [  1.0   ,  100.0 ,  0.0   ,  100.0 ,  100.0 ,  100.0 ,  100.0 ,  100.0 ]
    mets = [  "S"   ,   "P"  ,   "E"  ,   "A"  , "W"   ]
    b    = [  0.0   ,  0.0   ,  0.0   ,  0.0   ,  0.0  ]


    return CoreModel(S, b, c, xl, xu, rxns, mets)
end