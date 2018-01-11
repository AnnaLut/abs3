

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_PERSON.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_PERSON ***

  CREATE OR REPLACE FORCE VIEW BARS.V_PERSON ("RNK", "SEX", "PASSP", "SER", "NUMDOC", "PDATE", "ORGAN", "BDAY", "BPLACE", "TELD", "TELW", "CELLPHONE", "CELLPHONE_CONFIRMED") AS 
  SELECT p.RNK,
          p.SEX,
          p.PASSP,
          p.SER,
          p.NUMDOC,
          p.PDATE,
          p.ORGAN,
          p.BDAY,
          p.BPLACE,
          p.TELD,
          p.TELW,
          p.CELLPHONE,
          p.CELLPHONE_CONFIRMED
     FROM person p
   UNION ALL
   SELECT cp.RNK,
          cp.SEX,
          cp.PASSP,
          cp.SER,
          cp.NUMDOC,
          cp.PDATE,
          cp.ORGAN,
          cp.BDAY,
          cp.BPLACE,
          cp.TELD,
          cp.TELW,
          NULL CELLPHONE,
          NULL CELLPHONE_CONFIRMED
     FROM clv_person cp, clv_request q
    WHERE cp.rnk = q.rnk AND q.req_type IN (0, 2);

PROMPT *** Create  grants  V_PERSON ***
grant SELECT                                                                 on V_PERSON        to BARSREADER_ROLE;
grant SELECT                                                                 on V_PERSON        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_PERSON        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_PERSON.sql =========*** End *** =====
PROMPT ===================================================================================== 
