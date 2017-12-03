

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/MBK_DEAL.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view MBK_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.MBK_DEAL ("USERID", "ND", "CC_ID", "VIDD", "VIDD_NAME", "S_PR", "TIPD", "DATE_B", "DATE_U", "DATE_V", "DATE_END", "S", "A_NLS", "A_OSTC", "A_OSTB", "A_OSTF", "A_MDATE", "A_ACC", "A_ACCC", "A_KV", "A_GRP", "A_TIP", "B_NLS", "B_OSTC", "B_OSTB", "B_OSTF", "B_MDATE", "MFOKRED", "B_ACC", "B_ACCC", "B_KV", "B_GRP", "RNK", "MFOPERC", "NMK", "NMKK", "OKPO", "COUNTRY", "NUM_ND", "KPROLOG", "DAT_ND", "MFO", "KOD_B", "BIC", "ACCKRED", "ACCPERC", "REFP", "SWI_ACC", "SWI_BIC", "SWI_REF", "SWO_ACC", "SWO_BIC", "SWO_REF", "ALT_PARTYB", "INTERM_B", "FIELD_58D", "INT_PARTYA", "INT_PARTYB", "INT_INTERMA", "INT_INTERMB", "INT_AMOUNT", "RAT", "ACRB", "ACR_DAT", "BASEY", "NLS_1819") AS 
  SELECT d.user_id  USERID , d.nd    ND     , d.cc_id       CC_ID  , d.vidd     VIDD   , v.name    VIDD_NAME,  acrn.fproc (a.acc, gl.bd)   S_PR, 
       v.tipd     TIPD   , d.sdate DATE_B , ad.bdate      DATE_U , ad.wdate   DATE_V , d.wdate   DATE_END ,  ad.s S,    
       a.nls      A_NLS  , a.ostc  A_OSTC , a.ostb+a.ostf A_OSTB , a.ostf     A_OSTF , a.mdate   A_MDATE  , 
       a.acc      A_ACC  , a.accc  A_ACCC , a.kv          A_KV   , a.grp      A_GRP  , a.tip     A_TIP    ,       
       b.nls      B_NLS  , b.ostc  B_OSTC , b.ostb+b.ostf B_OSTB , b.ostf     B_OSTF , b.mdate   B_MDATE  , ad.mfokred MFOKRED ,      
       b.acc      B_ACC  , b.accc  B_ACCC , b.kv          B_KV   , b.grp      B_GRP  , c.rnk     RNK      , ad.mfoperc MFOPERC , 
       c.nmk      NMK    , c.nmkk  NMKK   , c.okpo        OKPO   , c.country  COUNTRY, cb.num_nd  NUM_ND  , d.kprolog  KPROLOG ,            
       cb.dat_nd  DAT_ND , cb.mfo  MFO    , cb.kod_b      KOD_B  , cb.bic     BIC    , ad.acckred ACCKRED , ad.accperc ACCPERC , ad.refp REFP,   
       ad.SWI_ACC, ad.SWI_BIC, ad.SWI_REF , ad.SWO_ACC,   ad.SWO_BIC, ad.SWO_REF ,           
       ad.ALT_PARTYB , ad.INTERM_B , ad.FIELD_58D , ad.INT_PARTYA, ad.INT_PARTYB, ad.INT_INTERMA, ad.INT_INTERMB, ad.INT_AMOUNT,  
       TO_CHAR (acrn.fproc (a.acc)) RAT,    NVL (i.acrb, 0) ACRB,         i.ACR_DAT,     i.BASEY,   ad.NLS_1819     
FROM cc_deal d,  cc_add ad, cc_vidd v, accounts a, accounts b, int_accn i, customer c, custbank cb
WHERE d.nd   = ad.nd  AND  d.vidd = v.vidd  AND v.custtype = 1  AND LENGTH(v.vidd)= 4  AND ad.accs = a.acc  AND c.custtype =1  AND ad.adds =0 
  AND  a.acc = i.acc  AND i.id = v.tipd-1   AND a.dazs IS NULL  AND b.acc = i.acra     AND d.rnk  = c.rnk   AND c.rnk = cb.rnk 
  AND (   a.ostc  <> 0 
       OR a.dapp   = gl.bd
       OR d.sdate  = gl.bd   
       OR d.wdate >= gl.bd
      )
  AND d.wdate = nvl(a.mdate , to_date('31/12/2050','dd-mm-yyyy') )    


/* Formatted on 17/09/2015 12:57:33 (QP5 v5.269.14213.34746) 
CREATE OR REPLACE FORCE VIEW BARS.MBK_DEAL
(
   USERID,
   ND,
   CC_ID,
   VIDD,
   VIDD_NAME,
   TIPD,
   DATE_B,
   DATE_U,
   DATE_V,
   DATE_END,
   S,
   S_PR,
   A_NLS,
   A_OSTC,
   A_OSTB,
   A_OSTF,
   A_MDATE,
   A_ACC,
   A_ACCC,
   A_KV,
   A_GRP,
   A_TIP,
   B_NLS,
   B_OSTC,
   B_OSTB,
   B_OSTF,
   B_MDATE,
   B_ACC,
   B_ACCC,
   B_KV,
   B_GRP,
   RNK,
   NMK,
   NMKK,
   OKPO,
   COUNTRY,
   NUM_ND,
   DAT_ND,
   MFO,
   KOD_B,
   BIC,
   ACCKRED,
   ACCPERC,
   MFOKRED,
   MFOPERC,
   REFP,
   KPROLOG,
   SWI_ACC,
   SWI_BIC,
   SWI_REF,
   SWO_ACC,
   SWO_BIC,
   SWO_REF,
   ALT_PARTYB,
   INTERM_B,
   FIELD_58D,
   INT_PARTYA,
   INT_PARTYB,
   INT_INTERMA,
   INT_INTERMB,
   INT_AMOUNT,
   RAT,
   ACRB,
   ACR_DAT,
   BASEY,
   NLS_1819
)
AS
   SELECT d.user_id,
          d.nd nd,
          d.cc_id,
          d.vidd,
          v.name,
          v.tipd,
          d.sdate date_bd,
          ad.bdate date_u,
          ad.wdate date_v,
          d.wdate date_end,
          ad.s,
          acrn.fproc (a.acc, bankdate) s_pr,
          a.nls a_nls,
          a.ostc a_ostc,
          a.ostb + a.ostf a_ostb,
          a.ostf a_ostf,
          a.mdate a_mdate,
          a.acc a_acc,
          a.accc a_accc,
          a.kv,
          a.grp,
          a.tip,
          b.nls b_nls,
          b.ostc b_ostc,
          b.ostb + b.ostf b_ostb,
          b.ostf b_ostf,
          b.mdate b_mdate,
          b.acc b_acc,
          b.accc b_accc,
          b.kv,
          b.grp,
          c.rnk,
          c.nmk,
          c.nmkk,
          c.okpo,
          c.country,
          cb.num_nd,
          cb.dat_nd,
          cb.mfo,
          cb.kod_b,
          cb.bic,
          ad.acckred,
          ad.accperc,
          ad.mfokred,
          ad.mfoperc,
          ad.refp,
          d.kprolog,
          ad.swi_acc,
          ad.swi_bic,
          ad.swi_ref,
          ad.swo_acc,
          ad.swo_bic,
          ad.swo_ref,
          ad.alt_partyb,
          ad.interm_b,
          ad.field_58d,
          ad.int_partya,
          ad.int_partyb,
          ad.int_interma,
          ad.int_intermb,
          ad.int_amount,
          TO_CHAR (acrn.fproc (a.acc)) rat,
          NVL (i.acrb, 0) acrb,
          i.acr_dat,
          i.basey,
          ad.nls_1819
     FROM cc_deal d,
          cc_add ad,
          cc_vidd v,
          accounts a,
          accounts b,
          int_accn i,
          customer c,
          custbank cb
    WHERE     d.nd = ad.nd
          AND d.vidd = v.vidd
          AND v.custtype = 1
          AND LENGTH (v.vidd) = 4
          AND ad.accs = a.acc
          AND d.wdate = a.mdate
          AND a.acc = i.acc
          AND i.id = v.tipd - 1
          AND a.dazs IS NULL
          AND b.acc = i.acra
          AND d.rnk = c.rnk
          AND c.custtype = 1
          AND c.rnk = cb.rnk
          AND ad.adds = 0
          AND (       a.ostc <> 0
                  AND (   d.wdate >= bankdate
                       OR a.ostc <> 0
                       OR i.acr_dat IS NULL
                       OR i.acr_dat < d.wdate - 1)
               OR (a.ostc = 0 AND a.dapp = bankdate)
               OR (a.ostc = 0 AND a.dapp < bankdate AND d.sdate = bankdate)
               OR (a.ostc = 0 AND d.wdate >= bankdate));

*/;

PROMPT *** Create  grants  MBK_DEAL ***
grant SELECT                                                                 on MBK_DEAL        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MBK_DEAL        to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/MBK_DEAL.sql =========*** End *** =====
PROMPT ===================================================================================== 
