CREATE OR REPLACE FORCE VIEW BARS.SALDO_VV
(
   KF,
   ACC,
   FDAT,
   KV,
   NLS,
   NBS,
   OB22,
   DOS,
   KOS,
   POS,
   ost_in,
   ost_out,
   ostQ_in,
   ostQ_out
)
AS
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

grant select on SALDO_VV to bars_access_defrole;


