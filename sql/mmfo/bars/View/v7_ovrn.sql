CREATE OR REPLACE FORCE VIEW BARS.V7_OVRN AS
   SELECT d.REF, d.ACC,  d.datm, o.ND, o.VDAT,   o.S/100 s, o.tt, o.NAZN ,
          decode(o.dk ,1,o.ID_A, o.ID_b) id_a,   decode (o.dk, 1, o.NAM_A,o.NAM_B) NAM_A,   decode(o.dk,1,o.NLSA,o.NLSB) NLSA,   decode(o.dk,1,o.MFOA,o.MFOB) MFOA , 
          decode(o.dk ,0,o.ID_A, o.ID_b) id_b,   decode (o.dk, 0, o.NAM_A,o.NAM_B) NAM_b,   decode(o.dk,0,o.NLSA,o.NLSB) NLSb,   decode(o.dk,0,o.MFOA,o.MFOB) MFOb 
    FROM OVR_CHKO_DET d, oper o  WHERE  d.REF= o.REF  AND acc = PUL.get ('ACC26') AND d.datm = TO_DATE (pul.get ('DATM01'), 'dd.mm.yyyy');

GRANT SELECT ON BARS.V7_OVRN TO BARS_ACCESS_DEFROLE;
