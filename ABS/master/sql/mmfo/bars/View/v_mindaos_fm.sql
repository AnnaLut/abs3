

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MINDAOS_FM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MINDAOS_FM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MINDAOS_FM ("RNK", "FDAOS") AS 
  select RNK1, FDAOS
FROM(
SELECT C.RNK RNK1, (
                               case when (length(cw.value) = 7 and ( cw.value like '__/____' or cw.value like '__.____' or cw.value like '__,____'))
                                                 then  to_char( to_date(replace(replace(value, '/','.'),',','/'),'mm.yyyy'), 'mm.yyyy')
                                    when (length(trim(cw.value)) = 10 and  (cw.value like '__/__/____' or cw.value like '__.__.____' or cw.value like '__,__,____'))
                                                 then to_char( to_date(replace(replace(value, '.','/'),',','/'),'dd/mm/yyyy'), 'mm.yyyy')
                                    else  (SELECT to_char((MIN(DAOS)), 'mm.yyyy') FROM ACCOUNTS WHERE RNK = C.RNK)
                               end
                               ) AS FDAOS
 FROM CUSTOMER C, CUSTOMERW CW
 WHERE C.RNK = CW.RNK(+)
 AND CW.TAG(+) = 'DATVR');

PROMPT *** Create  grants  V_MINDAOS_FM ***
grant SELECT                                                                 on V_MINDAOS_FM    to BARSREADER_ROLE;
grant SELECT                                                                 on V_MINDAOS_FM    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MINDAOS_FM.sql =========*** End *** =
PROMPT ===================================================================================== 
