

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SEC_ATTR_JOURNAL.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SEC_ATTR_JOURNAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SEC_ATTR_JOURNAL ("ID_GRANT", "NAME_GRANT", "DATE_GRANT", "ACTION", "ATTR_NAME", "ATTR_VALUE", "USER_ID", "USER_NAME") AS 
  select j.who_grant, s.fio, j.date_grant, t.semantic,
       a.attr_name, j.attr_value, u.id, u.fio
  from sec_attr_journal j, staff s, sec_attributes a, staff u, sec_action t
 where j.who_grant = s.id
   and j.attr_id = a.attr_id
   and j.user_id = u.id
   and j.action = t.id;

PROMPT *** Create  grants  V_SEC_ATTR_JOURNAL ***
grant SELECT                                                                 on V_SEC_ATTR_JOURNAL to ABS_ADMIN;
grant SELECT                                                                 on V_SEC_ATTR_JOURNAL to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SEC_ATTR_JOURNAL.sql =========*** End
PROMPT ===================================================================================== 
