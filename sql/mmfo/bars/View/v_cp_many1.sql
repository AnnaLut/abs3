

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_MANY1.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_MANY1 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_MANY1 ("B", "BRANCH", "NLS", "RNK", "CP_ID", "QUOT_SIGN", "ID", "DOX", "KV", "DAT_EM", "DATP", "EMI", "DCP", "FIN23", "VNCRR", "KAT23", "K23", "REF", "DATD", "NOMD", "BV", "PV", "COST", "NBS", "IRR0", "REZ23", "PEREOC") AS 
  SELECT b   , tobo, nls  , RNK  , cp_id , quot_sign   , id , dox , kv  , dat_em, DATp,
          emi , dcp , FIN23, VNCRR, KAT23 , K23         , REF, datD, nomD, BV    , PV  ,
          cost, SUBSTR (nls, 1, 4) NBS    , DECODE (dox , 1  , TO_NUMBER (NULL), erat) IRR0,
          FR23_CP (dox,emi,datp,ACCS,BV,PV,K23,quot_sign,nls , ref,b) REZ23,
          ost_korr (accs, z, NULL, SUBSTR (nls, 1, 4)) / 100 PEREOC
     FROM (SELECT x.tobo, x.nls , k.RNK , k.cp_id  , k.quot_sign, k.id   , k.dox, k.kv , k.dat_em,
                  k.DATp, k.emi , k.dcp , k.FIN23  , k.VNCRR    , nvl(k.KAT23,5) KAT23 , nvl(k.K23,1) K23,
                  x.REF , x.accs, o.datD, o.nD nomD, ROUND (x.erat, 4) ERAT , x.BV, x.B, x.Z, o.s / 100 cost,
                  NVL (DECODE (k.dox,1,
                      (SELECT pv FROM cp_koda WHERE id = k.id),
                      (SELECT ROUND (SUM ((SS1 + SN2) / POWER (1 + (x.erat) / 100, (FDAT - x.B) / 365)),2)
                       FROM cp_many WHERE REF = x.REF AND fdat >= x.B)), 0) PV
           FROM oper o, (SELECT * FROM cp_kod  WHERE tip = 1) k,
                        (SELECT v.B,v.Z,d.id,d.REF,d.erat,a.nls,a.tobo,d.accs,
                                -SUM (ost_korr (aa.acc,v.z,NULL,SUBSTR (aa.nls, 1, 4)))/100 BV
                         FROM cp_deal d,V_SFDAT v,accounts a,accounts aa,CP_KOD KK
                         WHERE D.ID = KK.ID AND (d.acc = a.acc AND KK.DOX > 1 OR d.accp = a.acc
                               AND KK.DOX = 1 AND aa.nls NOT LIKE '8%')
                               AND ost_korr (aa.acc,v.z,NULL,SUBSTR (aa.nls, 1, 4)) <> 0
                               AND aa.acc IN (d.acc, NVL (d.accd, d.acc), NVL (d.accp, d.acc),
                                   NVL (d.accr, d.acc), NVL (d.accr2  , d.acc), NVL (d.accr3   , d.acc),
                                   NVL (d.accs, d.acc), NVL (d.accexpr, d.acc), NVL (d.accunrec, d.acc))
                         GROUP BY v.B,v.Z,d.id,d.REF,d.erat,a.nls,a.tobo,d.accs) x
          WHERE k.id = x.id AND x.REF = o.REF AND o.sos = 5)
   where substr(nls,1,4)<>3541;

PROMPT *** Create  grants  V_CP_MANY1 ***
grant SELECT                                                                 on V_CP_MANY1      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_MANY1      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_MANY1.sql =========*** End *** ===
PROMPT ===================================================================================== 
