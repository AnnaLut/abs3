CREATE OR REPLACE FORCE VIEW BARS.V2_OVRN AS
SELECT x.ND, x.cc_id, x.sdate, x.wdate, x.kv, x.RNK, x.sos, x.nls, x.RNK1, x.mdate, x.IRA, x.IRP, x.IRB, x.NMK1, x.okpo, x.DATVZ, x.TERM,
       x.DATSP, x.SP, x.SPN, x.RLIM, x.PK, x.DONOR, x.NK, x.OSTC, x.OST_free, x.accc, x.acc, '¬вести' TARIF, '¬вести' ACC_ADD,
       DECODE (x.sos,0, (SELECT lim/100 FROM ovr_lim WHERE acc=x.acc AND fdat = (SELECT MIN (fdat) FROM ovr_lim  WHERE acc = x.acc)), x.lim)  LIM 
FROM (SELECT d.ND, d.cc_id, d.sdate, d.wdate, a.kv, d.RNK, d.sos, a.nls, a.rnk RNK1, a.mdate, a.accc, a.acc, C.NMK NMK1, C.okpo, acrn.fprocn (a.acc, 0, gl.bd) IRA, --       acrn.fprocn (a.accc,1, gl.bd) IR1,
             acrn.fprocn (a.acc,1,gl.bd)       IRP, 
             acrn.fprocn (a.acc,1,(d.sdate-1)) IRB, 
             OVRN.SP (7, d.nd, a.rnk)          SP, 
             OVRN.SP (9, d.nd, a.rnk) SPN,
             a.lim/100 lim,        a.ostc/100  OSTC,
            (A.lim+A.ostc)/100                 OST_free, 
            (SELECT MAX (fdat)       FROM saldoa       WHERE acc = a.acc AND ostf>= 0 AND ostf-dos+kos<0 AND a.ostc<0)  DATVZ,
            (SELECT TO_NUMBER(VALUE) FROM accountsw    WHERE acc = a.acc AND tag = ovrn.TAG                          )  TERM,
            (SELECT MIN (DATSP)      FROM OVR_TERM_TRZ WHERE acc = a.acc                                             )  DATSP,
            (SELECT MIN (fdat)       FROM ovr_lim      WHERE acc = a.acc AND fdat > gl.bd                            )  RLIM,
            (SELECT TO_NUMBER(VALUE) FROM accountsw    WHERE acc = a.acc AND tag = ovrn.TAGC                         )  PK,
            (SELECT TO_NUMBER(VALUE) FROM accountsw    WHERE acc = a.acc AND tag = ovrn.TAGN                         )  DONOR,
            (SELECT TO_NUMBER(VALUE) FROM accountsw    WHERE acc = a.acc AND tag = ovrn.TAGK                         )  NK
       FROM (SELECT *  FROM cc_deal  WHERE nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND'))  AND vidd = ovrn.vidd ) d,
            (SELECT *  FROM nd_acc   WHERE nd = TO_NUMBER (pul.Get_Mas_Ini_Val ('ND'))                       ) n,
            accounts a,  CUSTOMER C
       WHERE  d.nd = n.nd AND n.acc = a.acc AND a.tip <> ovrn.tip AND accc IS NOT NULL AND a.nbs IN ('2600','2650','2602','2603','2604') AND A.RNK = C.RNK
       ) x;


GRANT SELECT ON BARS.V2_OVRN TO BARS_ACCESS_DEFROLE;
