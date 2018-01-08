

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS_PROC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ACCOUNTS_PROC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ACCOUNTS_PROC ("ACC", "NLS", "NLSALT", "KV", "NBS", "NBS2", "DAOS", "DAPP", "ISP", "NMS", "LIM", "OSTB", "OSTC", "OSTF", "OSTQ", "DOS", "KOS", "DOSQ", "KOSQ", "PAP", "TIP", "VID", "TRCN", "MDATE", "DAZS", "SEC", "ACCC", "BLKD", "BLKK", "POS", "SECI", "SECO", "GRP", "OSTX", "RNK", "TOBO", "KF", "P_TIP") AS 
  select accounts."ACC", accounts."NLS", accounts."NLSALT", accounts."KV",
          accounts."NBS", accounts."NBS2", accounts."DAOS", accounts."DAPP",
          accounts."ISP", accounts."NMS", accounts."LIM", accounts."OSTB",
          accounts."OSTC", accounts."OSTF", accounts."OSTQ", accounts."DOS",
          accounts."KOS", accounts."DOSQ", accounts."KOSQ", accounts."PAP",
          accounts."TIP", accounts."VID", accounts."TRCN", accounts."MDATE",
          accounts."DAZS", accounts."SEC", accounts."ACCC", accounts."BLKD",
          accounts."BLKK", accounts."POS", accounts."SECI", accounts."SECO",
          accounts."GRP", accounts."OSTX", accounts."RNK", accounts."TOBO",
          accounts."KF",
          case
             when tip in
                    ('N00', 'L00', 'L01', 'T00', 'T0D', 'TNB',
                     'TND', 'L99', 'N99', 'TUR', 'TUD', '902',
                     '90D')
                then tip
             else null
          end as p_tip
     from accounts
    where case
             when tip in
                    ('N00', 'L00', 'L01', 'T00', 'T0D', 'TNB', 'TND', 'L99',
                     'N99', 'TUR', 'TUD', '902', '90D')
                then tip
             else null
          end is not null
 ;

PROMPT *** Create  grants  V_ACCOUNTS_PROC ***
grant SELECT                                                                 on V_ACCOUNTS_PROC to BARS014;
grant SELECT                                                                 on V_ACCOUNTS_PROC to BARSREADER_ROLE;
grant SELECT                                                                 on V_ACCOUNTS_PROC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ACCOUNTS_PROC to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_ACCOUNTS_PROC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ACCOUNTS_PROC.sql =========*** End **
PROMPT ===================================================================================== 
