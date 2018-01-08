

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KWT_2924.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KWT_2924 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KWT_2924 ("ACC", "BRANCH", "NLS", "KV", "OB22", "DAOS", "DAPP", "DATVZ", "DAT_KWT", "IXD", "IXK", "KF", "KOL", "TXT") AS 
  select aa."ACC",aa."BRANCH",aa."NLS",aa."KV",aa."OB22",aa."DAOS",aa."DAPP",aa."DATVZ",aa."DAT_KWT",aa."IXD",aa."IXK",aa."KF",  tt.kol, ( SELECT SUBSTR (txt,1,100) FROM bars.sb_ob22 WHERE r020 = '2924' AND ob22 = aa.ob22) TXT
FROM bars.kwt_a_2924 aa ,
    (select acc, count(*) kol from bars.kwt_t_2924  group by acc ) tt
where aa.acc = tt.acc (+);

PROMPT *** Create  grants  V_KWT_2924 ***
grant SELECT                                                                 on V_KWT_2924      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_KWT_2924      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KWT_2924      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KWT_2924.sql =========*** End *** ===
PROMPT ===================================================================================== 
