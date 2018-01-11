

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALDO_VV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view SALDO_VV ***

  CREATE OR REPLACE FORCE VIEW BARS.SALDO_VV ("KF", "ACC", "FDAT", "KV", "NLS", "NBS", "OB22", "DOS", "KOS", "POS", "OST_IN", "OST_OUT", "OSTQ_IN", "OSTQ_OUT") AS 
  SELECT KF,
          acc,
          dat_alt,
          kv,
          nls,
          NBS,
          ob22,
          DECODE (SIGN (fost (acc, dat_alt - 1) / 100), -1, -fost (acc, dat_alt - 1) / 100, 0) dOS,
          DECODE (SIGN (fost (acc, dat_alt - 1) / 100), 1, fost (acc, dat_alt - 1) / 100, 0) kOS,
          'NEW' POS,
          0,
          ABS(fost (acc, dat_alt - 1) / 100),
          0,
          ABS(fostQ (acc, dat_alt - 1) / 100)
     FROM accounts
     where dat_alt is not null
   UNION ALL
   SELECT KF,
          acc,
          dat_alt,
          kv,
          NLSALT,
          SUBSTR (nlsalt, 1, 4),
          T2017.OB22_old (NBS, OB22, SUBSTR (nlsalt, 1, 4)),
          DECODE (SIGN (fost (acc, dat_alt - 1) / 100), 1, fost (acc, dat_alt - 1) / 100, 0),
          DECODE (SIGN (fost (acc, dat_alt - 1) / 100), -1, -fost (acc, dat_alt - 1) / 100, 0),
          'OLD',
          ABS(fost (acc, dat_alt - 1) / 100),
          0,
          ABS(fostQ (acc, dat_alt - 1) / 100),
          0
     FROM ACCOUNTS
      where dat_alt is not null;

PROMPT *** Create  grants  SALDO_VV ***
grant SELECT                                                                 on SALDO_VV        to BARS_ACCESS_DEFROLE;
grant FLASHBACK,SELECT                                                       on SALDO_VV        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALDO_VV.sql =========*** End *** =====
PROMPT ===================================================================================== 
