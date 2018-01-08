CREATE OR REPLACE FORCE VIEW BARS.OPLDOV
(
   REF,
   TT,
   DK,
   ACC,
   FDAT,
   S,
   SQ,
   TXT,
   STMT,
   SOS
)
AS
   SELECT o.REF,
          o.TT,
          o.DK,
          o.ACC,
          o.FDAT,
          o.S,
          o.SQ,
          o.TXT,
          o.STMT,
          o.SOS
     FROM opldok o, accounts a
    WHERE o.acc = a.acc AND a.nbs IS NOT NULL
   UNION ALL
   SELECT o.REF,
          o.TT,
          o.DK,
          a.ACCC,
          o.FDAT,
          o.S,
          o.SQ,
          o.TXT,
          o.STMT,
          o.SOS
     FROM opldok o, accounts a
    WHERE o.acc = a.acc AND a.nbs IS NULL AND a.accc IS NOT NULL;


GRANT DELETE,
      INSERT,
      SELECT,
      UPDATE,
      FLASHBACK
   ON BARS.OPLDOV
   TO bars_Access_defrole;

GRANT DELETE,
      INSERT,
      SELECT,
      UPDATE,
      FLASHBACK
   ON BARS.OPLDOV
   TO WR_ALL_RIGHTS;