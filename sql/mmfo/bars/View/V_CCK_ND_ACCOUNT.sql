begin

for r in (select 1 from dba_procedures
where object_name = 'CCK_UI'
  and procedure_name = 'TIP_NDG')
loop
  execute immediate 'CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ND_ACCOUNT
(
   ORD,
   ND,
   RNK,
   OPN,
   ACC,
   TIP,
   OB22,
   NMS,
   KV,
   OSTC,
   OSTB,
   OSTF,
   DOS,
   KOS,
   DAPP,
   DAOS,
   DAZS,
   MDATE,
   ISP,
   IR,
   BASEY,
   TT,
   NLS
)
AS
   SELECT DECODE (x.tip,
                  ''LIM'', 0,
                  ''SS '', 3,
                  ''SN '', 8,
                  ''SP '', 7,
                  ''SPN'', 9,
                  ''SDI'', 6,
                  ''SPI'', 5,
                  ''S36'', 16,
                  ''SNA'', 17,
                  ''SK0'', 18,
                  ''SK9'', 19,
                  ''SG '', 20,
                  ''ISG'', 21,
                  ''SNO'', 10,
                  ''CR9'', 30,
                  90)
             ORD,
       ND,
       rnk,
       OPN,
       ACC,
       TIP,
       OB22,
       NMS,
       KV,
       OSTC,
       OSTB,
       OSTF,
       DOS,
       KOS,
       dapp,
       daos,
       dazs,
       mdate,
       isp,
       decode(IR, 0, null, IR) IR,
       CASE
         WHEN x.IR > 0 THEN
          (select basey
             from int_accn
            where id = 0
              and acc = x.acc)
         else
          to_number(null)
       END BASEY,
       cck_ui.URL_TIP(x.SOS,
                      x.DAZS,
                      x.nd,
                      x.cc_id,
                      x.sdate,
                      x.tip,
                      x.nls,
                      x.KV,
                      x.Lim,
                      x.ostc,
                      x.mfob,
                      x.nlsB,
                      x.okpo,
                      x.nmk) TT,
       cck_ui.NA_NLS(x.NLS,
                     to_number(pul.Get_Mas_Ini_Val(''ACCC'')),
                     x.TIP,
                     x.PROD) NLS
  from (select d.sos,
               d.prod,
               n.ND,
               a.rnk,
               1 OPN,
               a.ACC,
               a.TIP,
               a.OB22,
               a.NLS,
               a.NMS,
               a.KV,
               acrN.fprocN(a.acc, 0) IR,
               a.ostc / 100 OSTC,
               a.ostb / 100 OSTB,
               a.ostf / 100 OSTF,
               a.dos / 100 DOS,
               a.kos / 100 KOS,
               a.dapp,
               a.daos,
               a.dazs,
               a.mdate,
               a.isp,
               c.ACCKRED nlsb,
               c.MFOKRED mfob,
               u.okpo,
               u.nmk,
               d.cc_id,
               d.sdate,
               c.s lim
          FROM accounts a, nd_acc n, cc_add c, customer u, cc_deal d
         where d.nd = TO_NUMBER(pul.Get_Mas_Ini_Val(''ND''))
           and d.nd = c.nd
           and c.adds = 0
           and c.nd = n.nd
           and n.acc = a.acc
           and u.rnk = a.rnk
        union all
        select 0 sos,
               d.prod,
               d.ND,
               d.RNK,
               0 OPN,
               to_number(null) ACC,
               t.TIP,
               '''' OB22,
               ''N/A'' NLS,
               t.name,
               CASE
                 WHEN d.VIDD in (3, 13) or t.tip in (''SN8'', ''SK0'', ''SK9'') THEN
                  to_number(null)
                 else
                  (select a1.KV
                     from accounts a1, nd_acc n1
                    where a1.tip = ''LIM''
                      and a1.acc = n1.acc
                      and n1.nd = d.nd)
               END KV,
               to_number(null) IR,
               to_number(null) OSTC,
               to_number(null) OSTB,
               to_number(null) OSTF,
               to_number(null) DOS,
               to_number(null) KOS,
               to_date(null) dapp,
               to_date(null) daos,
               to_date(null) dazs,
               d.wdate mdate,
               to_number(null) isp,
               '''',
               '''',
               u.okpo,
               u.nmk,
               d.cc_id,
               d.sdate,
                  NULL
             FROM (SELECT *
                     FROM cc_deal
                    WHERE sos < 14 AND nd = TO_NUMBER (pul.Get (''ND''))) d,
                  (SELECT *
                     FROM tips
                    WHERE tip NOT IN (''LIM'',
                                      ''SD '',
                                      ''SL '',
                                      ''SLK'',
                                      ''SLN'',
                                      ''ISG'')) t,
                  vidd_tip v,
               customer u,
                  (select * from TABLE(CCK_UI.TIP_NDG(TO_NUMBER (pul.Get (''ND''))))) d1
            WHERE     d.vidd = v.vidd
                  AND d.rnk = u.rnk
                  AND v.tip = t.tip
                  AND NOT EXISTS
                             (SELECT 1
                                FROM accounts a2, nd_acc n2
                               WHERE     a2.acc = n2.acc
                                     AND n2.nd = d.nd
                                     AND a2.tip = t.tip 
                                     AND a2.tip not in  (''SNO'',''ODB'',''SG ''))
                  AND  t.tip IN d1.l_tips) x';
end loop;
end;
/


GRANT SELECT ON BARS.V_CCK_ND_ACCOUNT TO BARSREADER_ROLE;

GRANT SELECT ON BARS.V_CCK_ND_ACCOUNT TO BARS_ACCESS_DEFROLE;