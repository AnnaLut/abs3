

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NBU23_CP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view NBU23_CP ***

  CREATE OR REPLACE FORCE VIEW BARS.NBU23_CP ("B", "KY", "VNCRR", "RNK", "CP_ID", "ID", "DOX", "KV", "DAT_EM", "DATP", "EMI", "DCP", "FIN23", "KAT23", "K23", "KOL", "QUOT_SIGN", "R", "D", "EC", "NP1", "NP2", "NP3", "IN_BR") AS 
  SELECT TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') b,
          k.KY,
          k.VNCRR,
          k.RNK,
          k.cp_id,
          k.id,
          k.dox,
          k.kv,
          k.dat_em,
          k.DATp,
          k.emi,
          k.dcp,
          k.fin23,
          k.KAT23,
          k.k23,
          (x.nom / 100 / k.cena) kol,
          k.quot_sign,
          y.R,
          y.D,
          y.EC,
          y.NP1,
          y.NP2,
          y.NP3,
          k.IN_BR
     FROM (SELECT *
             FROM cp_kod
            WHERE tip = 1) k,
          cp_koda y,
          (  SELECT id,
                    -SUM (
                        rez1.ostc96 (
                           acc,
                           TO_DATE (pul.get_mas_ini_val ('zFdat1'),
                                    'dd.mm.yyyy')))
                       nom
               FROM cp_deal
              WHERE rez1.ostc96 (
                       acc,
                       TO_DATE (pul.get_mas_ini_val ('zFdat1'), 'dd.mm.yyyy')) <
                       0
           GROUP BY id) x
    WHERE k.id = x.id AND k.id = y.id(+);

PROMPT *** Create  grants  NBU23_CP ***
grant SELECT                                                                 on NBU23_CP        to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on NBU23_CP        to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on NBU23_CP        to START1;
grant SELECT                                                                 on NBU23_CP        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NBU23_CP.sql =========*** End *** =====
PROMPT ===================================================================================== 
