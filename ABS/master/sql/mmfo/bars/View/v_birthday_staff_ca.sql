

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BIRTHDAY_STAFF_CA.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BIRTHDAY_STAFF_CA ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BIRTHDAY_STAFF_CA ("BIRTHDAY", "FIO", "AGE") AS 
  SELECT p.bday,
          --c.birthday,
          --c.fio,
          INITCAP (c1.nmk),
          --EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM birthday)
          EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM p.bday)
     FROM                                                        -- ca_staff c
         customer c1, person p, customerw c2
    WHERE     c1.date_off is null
          AND c1.rnk = c2.rnk
          AND c2.rnk = p.rnk
          AND c2.tag = 'WORK'
          AND LOWER (c2.VALUE) LIKE '%ощадбанк%'
          AND SUBSTR (TO_CHAR (p.bday                             /*birthday*/
                                     , 'dd/mm/yyyy'), 1, 5) =
                 SUBSTR (TO_CHAR (TRUNC (SYSDATE), 'dd/mm/yyyy'), 1, 5);



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BIRTHDAY_STAFF_CA.sql =========*** En
PROMPT ===================================================================================== 
