## ------------------------------------------------------------------
# Utils
function extract_rxnid(line::AbstractString)
    rxn_id_reg = r"ν[A-Za-z0-9]+\s*\(.+\)"
    m = match(rxn_id_reg, line)
    return isnothing(m) ? "" : m.match
end

function extract_metid(word::AbstractString)
    met_id_reg = r"[A-Za-z][A-Za-z0-9]+"
    m = match(met_id_reg, word)
    return isnothing(m) ? "" : m.match
end

function extract_stoi_coe(word::AbstractString)
    reg = r"^[0-9]+$"
    m = match(reg, word)
    return isnothing(m) ? "" : m.match
end

function extract_arrow(word::AbstractString)
    reg = r"^→$"
    m = match(reg, word)
    return isnothing(m) ? "" : m.match
end


function is_match(reg::Regex, w::String)
    m = match(reg, w)
    return !isnothing(m)
end

# ------------------------------------------------------------------
# The string was extracted from 
# Massucci et al., “Energy Metabolism and Glutamate-Glutamine Cycle in the Brain.”
# Supplementary materials

const MASSUCCI_NETWORK_STR = """
1 νGLC(c) → GLCc
2 νGLC(c → a) GLCc → GLCa
3 νGLC(c → e) GLCc → GLCe
4 νGLC(e → a) GLCe → GLCa
5 νGLC(e → n) GLCe → GLCn
6 νO2(c) → O2c
7 νO2(c → a) O2c → O2a
8 νO2(c → n) O2c → O2n
9 νLAC(c) LACc →
10 νLAC(e → c) LACe → LACc
11 νLAC(a → c) LACa → LACc
12 νLAC(e → a) LACe → LACa
13 νLAC(a → e) LACa → LACe
14 νLAC(e → n) LACe → LACn
15 νLAC(n → e) LACn → LACe
16 νCKf (n) ATPn + Crn → ADPn + PCrn
17 νCKr(n) ADPn + PCrn → ATPn + Crn
18 νCKf (a) ATPa + Cra → ADPa + PCra
19 νCKr(a) ADPa + PCra → ATPa + Cra
20 νAKf (n) 2 ADPn → AMPn + ATPn
21 νAKr(n) AMPn + ATPn → 2 ADPn
22 νAKf (a) 2 ADPa → AMPa + ATPa
23 νAKr(a) AMPa + ATPa → 2 ADPa
24 νPPP(n) 3 G6Pn + 6 NADPn → 2 F6Pn + GAPn + 6 NADPHn
25 νPPP(a) 3 G6Pa + 6 NADPa → 2 F6Pa + GAPa + 6 NADPHa
26 νNAK(n) ATPn + 2 Ke + 3 Nan → ADPn + 2 Kn + 3 Nae
27 νNAK(a) ATPa + 2 Ke + 3 Naa → ADPa + 2 Ka + 3 Nae
28 νNKCC(a) Ke + Nae → Ka + Naa
29 νNa(n) Nae → Nan
30 νK(n) Kn → Ke
31 νGR1(n) GSSGn + NADPHn → GSHn + NADPn
32 νGR2(n) GSSGn + NADPHnm → GSHn + NADPnm
33 νDHAR(n) DHAn + GSHn → ASCn + GSSGn
34 νAPX(n) ASCn + ROSn → DHAn
35 νGR1(a) GSSGa + NADPHa → GSHa + NADPa
36 νGR2(a) GSSGa + NADPHam → GSHa + NADPam
37 νDHAR(a) DHAa + GSHa → ASCa + GSSGa
38 νAPX(a) ASCa + ROSa → DHAa
39 νGSH(a) → GSHa
40 νGSH(a → e) GSHa → GSHe
41 νGSH(e → n) GSHe → GSHn
42 νDHA(n → e) DHAn → DHAe
43 νDHA(e → n) DHAe → DHAn
44 νDHA(e → a) DHAe → DHAa
45 νDHA(a → e) DHAa → DHAe
46 νASC(a → e) ASCa → ASCe
47 νASC(e → a) ASCe → ASCa
48 νASC(e → n) ASCe + 2 Nae → ASCn + 2 Nan
49 νGLU(e → a) GLUe + Ka + 3 Nae → GLUac + Ke + 3 Naa
50 νGS(a) ATPa + GLUac → ADPa + GLNa
51 νGLN(a → n) GLNa → GLNn
52 νPAG(n) GLNn → GLUnc
53 νGLU(n) ATPn + GLUnc → ADPn + GLUnv
54 νNT(n → e) GLUnv → GLUe
55 νHK(n) ATPn + GLCn → ADPn + G6Pn
56 νPFK(n) ATPn + G6Pn → ADPn + 2 GAPn
57 νGAPDHf (n) GAPn + NADnc → BPGn + NADHnc
58 νGAPDHr(n) BPGn + NADHnc → GAPn + NADnc
59 νPGKf (n) ADPn + BPGn → ATPn + PEPn
60 νPGKr(n) ATPn + PEPn → ADPn + BPGn
61 νPK(n) ADPn + PEPn → ATPn + PYRnc
62 νLDHf (n) NADHnc + PYRnc → LACn + NADnc
63 νLDHr(n) LACn + NADnc → NADHnc + PYRnc
64 νHK(a) ATPa + GLCa → ADPa + G6Pa
65 νPFK(a) ATPa + G6Pa → ADPa + 2 GAPa
66 νGAPDHf (a) GAPa + NADac → BPGa + NADHac
67 νGAPDHr(a) BPGa + NADHac → GAPa + NADac
68 νPGKf (a) ADPa + BPGa → ATPa + PEPa
69 νPGKr(a) ATPa + PEPa → ADPa + BPGa
70 νPK(a) ADPa + PEPa → ATPa + PYRac
71 νLDHf (a) NADHac + PYRac → LACa + NADac
72 νLDHr(a) LACa + NADac → NADHac + PYRac
73 νPYRf (n) PYRnc → PYRnm
74 νPYRr(n) PYRnm → PYRnc
75 νPYRf (a) PYRac → PYRam
76 νPYRr(a) PYRam → PYRac
77 νOP(n) 5 ADPn + 2 NADHnm + O2n → 5 ATPn + 2 NADnm + 0.01 ROSn
78 νOP(a) 5 ADPa + 2 NADHam + O2a → 5 ATPa + 2 NADam + 0.01 ROSa
79 νNAD(n) NADHnm + NADPnm → NADPHnm + NADnm
80 νNAD(a) NADHam + NADPam → NADPHam + NADam    
81 νPC(a) ATPa + PYRam → ADPa + OAAam
82 νcME(n) MALnc + NADPn → NADPHnc + PYRnc
83 νmME(n) MALnm + NADPnm → NADPHnm + PYRnm
84 νcME(a) MALac + NADPa → NADPHac + PYRac
85 νmME(a) MALam + NADPam → NADPHam + PYRam
86 νPDH(n) CoAn + NADnm + PYRnm → ACoAn + NADHnm
87 νCS(n) ACoAn + OAAnm → CITn + CoAn
88 νIDH1(n) CITn + NADnm → AKGnm + NADHnm
89 νIDH2(n) CITn + NADPnm → AKGnm + NADPHnm
90 νIDH3(n) CITn + NADPn → AKGnc + NADPHn
91 νAKGDH(n) AKGnm + CoAn + NADnm → NADHnm + SCoAn
92 νSCoATKf (n) ADPn + SCoAn → ATPn + SUCn
93 νSCoATKr(n) ATPn + SUCn → ADPn + SCoAn
94 νSDHf (n) 1.50 ADPn + 0.10 O2n + 3 SUCn → 1.50 ATPn + 3 FUMn
95 νSDHr(n) 1.50 ATPn + 3 FUMn → 1.50 ADPn + 0.10 O2n + 3 SUCn
96 νFUMf (n) FUMn → MALnm
97 νFUMr(n) MALnm → FUMn
98 νmMDH(n) MALnm + NADnm → NADHnm + OAAnm
99 νPDH(a) CoAa + NADam + PYRam → ACoAa + NADHam
100 νCS(a) ACoAa + OAAam → CITa + CoAa
101 νIDH1(a) CITa + NADam → AKGam + NADHam
102 νIDH2(a) CITa + NADPam → AKGam + NADPHam
103 νIDH3(a) CITa + NADPa → AKGac + NADPHa
104 νAKGDH(a) AKGam + CoAa + NADam → NADHam + SCoAa
105 νSCoATKf (a) ADPa + SCoAa → ATPa + SUCa
106 νSCoATKr(a) ATPa + SUCa → ADPa + SCoAa
107 νSDHf (a) 1.50 ADPa + 0.10 O2a + 3 SUCa → 1.50 ATPa + 3 FUMa
108 νSDHr(a) 1.50 ATPa + 3 FUMa → 1.50 ADPa + 0.10 O2a + 3 SUCa
109 νFUMf (a) FUMa → MALam
110 νFUMr(a) MALam → FUMa
111 νmMDH(a) MALam + NADam → NADHam + OAAam
112 νG3PS(n) 1.50 ADPn + 3 NADHnc + 0.10 O2n → 1.50 ATPn + 3 NADnc
113 νG3PS(a) 1.50 ADPa + 3 NADHac + 0.10 O2a → 1.50 ATPa + 3 NADac
114 νcMDH(n) NADHnc + OAAnc → MALnc + NADnc
115 νOGC(n) AKGnm + MALnc → AKGnc + MALnm
116 νAGC(n) ASPnm + GLUnc → ASPnc + GLUnm
117 νcMDH(a) NADHac + OAAac → MALac + NADac
118 νOGC(a) AKGam + MALac → AKGac + MALam
119 νAGC(a) ASPam + GLUac → ASPac + GLUam
120 νcAATf (n) AKGnc + ASPnc → GLUnc + OAAnc
121 νcAATr(n) GLUnc + OAAnc → AKGnc + ASPnc
122 νmAATf (n) AKGnm + ASPnm → GLUnm + OAAnm
123 νmAATr(n) GLUnm + OAAnm → AKGnm + ASPnm
124 νcAATf (a) AKGac + ASPac → GLUac + OAAac
125 νcAATr(a) GLUac + OAAac → AKGac + ASPac
126 νmAATf (a) AKGam + ASPam → GLUam + OAAam
127 νmAATr(a) GLUam + OAAam → AKGam + ASPam
128 νASPf (n → a) ASPnc → ASPac
129 νASPr(n → a) ASPac → ASPnc
130 νASPf (n) ASPnc → ASPnm
131 νASPr(n) ASPnm → ASPnc
132 νASPf (a) ASPac → ASPam
133 νASPr(a) ASPam → ASPac
134 νGDHf (n) GLUnm + NADPnm → AKGnm + NADPHnm
135 νGDHr(n) AKGnm + NADPHnm → GLUnm + NADPnm
136 νGDHf (a) GLUam + NADPam → AKGam + NADPHam
137 νGDHr(a) AKGam + NADPHam → GLUam + NADPam
138 νATP(n) ATPn → ADPn
139 νATP(a) ATPa → ADPa
"""
    
# ------------------------------------------------------------------
function massucci_network()
    
    # Parse
    dig = filter(!isempty, strip.(split(MASSUCCI_NETWORK_STR, "\n"; keepempty = false)))

    rxn_ids = extract_rxnid.(dig)
    
    dig = replace.(dig, rxn_ids .=> "")
    dig = replace.(dig, r"^[0-9]+" .=> "")
    dig = strip.(dig)

    # Cosmetics
    rxn_ids .= replace.(rxn_ids, r"\s" => "")
    
    S_dict = Dict()
    met_ids = []
    stoi = nothing
    sense = -1
    for (rxni, (rxn_id, met_line)) in enumerate(zip(rxn_ids, dig))
        words = strip.(split(met_line; keepempty = false))
        # parse
        for w in words
            # test stoi coe
            stoi_str = extract_stoi_coe(w)
            if !isempty(stoi_str)
                stoi = parse(Int, stoi_str)
                continue
            end

            # test arrow
            arrow_str = extract_arrow(w)
            if !isempty(arrow_str)
                sense *= -1
                continue
            end

            # test metid 
            met_id = extract_metid(w)
            if !isempty(met_id)
                # I found a metabolite
                stoi = isnothing(stoi) ? 1 * sense : stoi * sense

                # store
                S_dict[(met_id, rxn_id)] = stoi
                push!(met_ids, met_id)
                
                # @info("Entry", rxni, rxn_id, met_id, stoi)
                
                stoi = nothing
                continue
            end

        end # for w

        stoi = nothing
        sense = -1

    end # for rxni

    unique!(met_ids)

    M = length(met_ids)
    N = length(rxn_ids)
    
    S = spzeros(M, N)
    # S = zeros(M, N)
    for (meti, met_id) in enumerate(met_ids)
        for (rxni, rxn_id) in enumerate(rxn_ids)
            S[meti, rxni] = get(S_dict, (met_id, rxn_id), 0.0)
        end
    end
    
    lb = zeros(N)
    ub = zeros(N) .+ 1000.0

    # TODO: create a COBREXA Model

    # return model
    
end