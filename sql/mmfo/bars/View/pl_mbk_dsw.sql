

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PL_MBK_DSW.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view PL_MBK_DSW ***

  CREATE OR REPLACE FORCE VIEW BARS.PL_MBK_DSW ("ZDAT", "ZAG1", "NAME", "KV", "DAT1", "DAT2", "NMK", "NLS", "ND", "NTIK", "S", "IR") AS 
  SELECT NVL (TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'), 'dd.mm.yyyy'), gl.bd)
             ZDAT,
          zag1,
          name,
          kv,
          TO_CHAR (dat1, 'dd/mm/yyyy') AS dat1,
          TO_CHAR (dat2, 'dd/mm/yyyy') AS dat2,
          NVL (nmk, 'Всього по ' || NVL (name, zag1)) AS nmk,
          nls,
          nd,
          ntik,
          s,
          ir
     FROM (  SELECT MAX (zag1) AS zag1,
                    (name) AS name,
                    kv,
                    dat1,
                    dat2,
                    nmk,
                    nls,
                    nd,
                    ntik,
                    SUM (s) AS s,
                    ROUND (
                       NVL (
                          (ir),
                          CASE
                             WHEN SUM (sss) <> 0 THEN (SUM (sss) / SUM (s))
                             ELSE 0
                          END),
                       2)
                       AS ir,
                    SUM (sss) AS sss
               FROM (SELECT    DECODE (w.MB,
                                       1, 'МБ:ДЕП/КРД',
                                       ' ДЕПО-СВОП')
                            || ' '
                            || DECODE (w.tipd,
                                       2, ' Залучено ',
                                       'Розміщено')
                            || ' ('
                            || w.KV
                            || ')'
                               ZAG1,
                            w.KV,                                       -- заг
                            n.NAME || ' (' || kv || ')' AS name,  -- для итога
                            w.DAT1,
                            w.DAT2,
                            c.NMK,
                            w.nls,
                            w.ND,
                            w.ntik,
                            w.S,
                            w.IR                                     -- строка
                                ,
                            ROUND (w.S * w.IR) AS sss
                       FROM (SELECT m.ND,
                                    m.cc_id ntik,
                                    1 MB,
                                    m.tipd,
                                    k.id,
                                    m.sdate DAT1,
                                    m.wdate DAT2,
                                    m.rnk,
                                    a.kv,
                                    m.S,
                                    m.IR,
                                    a.nls
                               FROM (SELECT d.nd,
                                            d.cc_id,
                                            d.sdate,
                                            d.wdate,
                                            d.rnk,
                                            v.tipd,
                                            ad.accs,
                                              ABS (
                                                 fost (
                                                    ad.accs,
                                                    NVL (
                                                       TO_DATE (
                                                          pul.Get_Mas_Ini_Val (
                                                             'sFdat1'),
                                                          'dd.mm.yyyy'),
                                                       gl.bd)))
                                            / 100
                                               S,
                                            acrn.fprocn (ad.accs,
                                                         (v.tipd - 1),
                                                         d.sdate)
                                               IR
                                       FROM cc_deal d, cc_add ad, CC_VIDD v
                                      WHERE     d.sdate <=
                                                   NVL (
                                                      TO_DATE (
                                                         pul.Get_Mas_Ini_Val (
                                                            'sFdat1'),
                                                         'dd.mm.yyyy'),
                                                      gl.bd)
                                            AND d.wdate >
                                                   NVL (
                                                      TO_DATE (
                                                         pul.Get_Mas_Ini_Val (
                                                            'sFdat1'),
                                                         'dd.mm.yyyy'),
                                                      gl.bd)
                                            AND d.nd = ad.nd
                                            AND ad.adds = 0
                                            AND d.vidd = v.vidd
                                            AND fost (
                                                   ad.accs,
                                                   NVL (
                                                      TO_DATE (
                                                         pul.Get_Mas_Ini_Val (
                                                            'sFdat1'),
                                                         'dd.mm.yyyy'),
                                                      gl.bd)) <> 0) m,
                                    accounts a,
                                    ani331 k
                              WHERE     a.acc = m.accs
                                    AND SUBSTR (a.nls, 1, 4) = k.nbs
                                    AND k.id NOT IN (3, 6)
                             UNION ALL
                             SELECT r.tag1 ND,
                                    x1.ntik,
                                    2 MB,
                                    2 TIPD,
                                    DECODE (
                                       forex.get_forextype (x2.dat,
                                                            x2.dat_a,
                                                            x2.dat_b),
                                       'TOD', 21,
                                       'TOM', 21,
                                       22)
                                       ID,
                                    x1.dat_a,
                                    x2.dat_b,
                                    x1.rnk,
                                    x1.kva,
                                    x1.suma / 100,
                                    acrn.fprocn (x2.ACC9b, 1, x2.dat_b),
                                    ''
                               FROM (  SELECT swap_tag TAG1,
                                              MIN (deal_tag) tag2,
                                              COUNT (*)
                                         FROM fx_deal
                                        WHERE     swap_tag > 0
                                              AND swap_tag <> deal_tag
                                     --    and dat >= NVL( to_date(pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy') , gl.bd)
                                     GROUP BY swap_tag
                                       HAVING COUNT (*) > 1) r,
                                    (SELECT f.*
                                       FROM fx_deal f, oper o
                                      WHERE f.REF = o.REF AND o.sos > 0) x1,
                                    (SELECT f.*
                                       FROM fx_deal f, oper o
                                      WHERE f.REF = o.REF AND o.sos > 0) x2
                              WHERE     x1.deal_tag = r.tag1
                                    AND x2.deal_tag = r.tag2
                                    AND x1.dat_a <=
                                           NVL (
                                              TO_DATE (
                                                 pul.Get_Mas_Ini_Val ('sFdat1'),
                                                 'dd.mm.yyyy'),
                                              gl.bd)
                                    AND x2.dat_b >
                                           NVL (
                                              TO_DATE (
                                                 pul.Get_Mas_Ini_Val ('sFdat1'),
                                                 'dd.mm.yyyy'),
                                              gl.bd)
                             UNION ALL
                             SELECT r.tag1 ND,
                                    x1.ntik,
                                    2,
                                    1,
                                    DECODE (
                                       forex.get_forextype (x2.dat,
                                                            x2.dat_b,
                                                            x2.dat_a),
                                       'TOD', 24,
                                       'TOM', 24,
                                       25),
                                    x1.dat_b,
                                    x2.dat_a,
                                    x1.rnk,
                                    x1.kvb,
                                    x1.sumb / 100,
                                    acrn.fprocn (x2.ACC9a, 0, x2.dat_a),
                                    ''
                               FROM (  SELECT swap_tag TAG1,
                                              MIN (deal_tag) tag2,
                                              COUNT (*)
                                         FROM fx_deal
                                        WHERE     swap_tag > 0
                                              AND swap_tag <> deal_tag
                                     --and dat >=  NVL( to_date(pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy') , gl.bd)
                                     GROUP BY swap_tag
                                       HAVING COUNT (*) > 1) r,
                                    (SELECT f.*
                                       FROM fx_deal f, oper o
                                      WHERE f.REF = o.REF AND o.sos > 0) x1,
                                    (SELECT f.*
                                       FROM fx_deal f, oper o
                                      WHERE f.REF = o.REF AND o.sos > 0) x2
                              WHERE     x1.deal_tag = r.tag1
                                    AND x2.deal_tag = r.tag2
                                    AND x1.dat_b <=
                                           NVL (
                                              TO_DATE (
                                                 pul.Get_Mas_Ini_Val ('sFdat1'),
                                                 'dd.mm.yyyy'),
                                              gl.bd)
                                    AND x2.dat_a >
                                           NVL (
                                              TO_DATE (
                                                 pul.Get_Mas_Ini_Val ('sFdat1'),
                                                 'dd.mm.yyyy'),
                                              gl.bd)) w,
                            customer c,
                            ani33 n
                      WHERE w.rnk = c.rnk AND n.id = w.id)
           GROUP BY GROUPING SETS ( (zag1,
                                     name,
                                     kv,
                                     dat1,
                                     dat2,
                                     nmk,
                                     nls,
                                     nd,
                                     ntik,
                                     ir),
                                   (zag1, name, kv),
                                   (zag1, kv)));

PROMPT *** Create  grants  PL_MBK_DSW ***
grant SELECT                                                                 on PL_MBK_DSW      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PL_MBK_DSW      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PL_MBK_DSW.sql =========*** End *** ===
PROMPT ===================================================================================== 
