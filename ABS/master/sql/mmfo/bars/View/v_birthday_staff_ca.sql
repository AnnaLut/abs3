

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BIRTHDAY_STAFF_CA.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BIRTHDAY_STAFF_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BIRTHDAY_STAFF_CA ("OKPO", "BIRTHDAY", "FIO", "AGE") AS 
  SELECT UNIQUE c1.okpo,
          TRUNC (p.bday),
          --c.birthday,
          --c.fio,
          INITCAP (c1.nmk),
          --EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM birthday)
          EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM p.bday)
     FROM                                                        -- ca_staff c
         customer c1, person p, customerw c2
    WHERE     c1.date_off IS NULL
          AND c1.rnk = c2.rnk
          AND c2.rnk = p.rnk
          AND c2.tag = 'WORK'
          AND LOWER (c2.VALUE) LIKE '%ощад%'
          AND SUBSTR (TO_CHAR (p.bday                             /*birthday*/
                                     , 'dd/mm/yyyy'), 1, 5) =
                 SUBSTR (TO_CHAR (TRUNC (SYSDATE), 'dd/mm/yyyy'), 1, 5);

PROMPT *** Create  grants  V_BIRTHDAY_STAFF_CA ***
grant SELECT                                                                 on V_BIRTHDAY_STAFF_CA to BARSREADER_ROLE;
grant SELECT                                                                 on V_BIRTHDAY_STAFF_CA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BIRTHDAY_STAFF_CA.sql =========*** En
PROMPT ===================================================================================== 
