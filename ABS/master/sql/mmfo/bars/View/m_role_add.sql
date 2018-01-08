

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_ADD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_ADD ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_ADD ("RESOURCE_TYPE_ID", "RES_CODE", "RES_NAME", "RESOURCE_ID", "RES_SEM", "GRANTEE_TYPE_ID", "GRANTEE_ID") AS 
  SELECT a.RESOURCE_TYPE_ID,                              -- Числ.код~Ресурсу
       x.RESOURCE_CODE  RES_CODE, 
       x.RESOURCE_NAME  RES_NAME,
       a.RESOURCE_ID,
       pul.get('RES_SEM') RES_SEM,
       a.GRANTEE_TYPE_ID,                             -- Тип ресурсу~"РОЛЬ"
       a.GRANTEE_ID                                        -- Числ.код~Ролі
  FROM STAFF_ROLE r,
      (select * from ADM_RESOURCE where GRANTEE_TYPE_ID = resource_utl.get_resource_type_id ('STAFF_ROLE') and RESOURCE_ID = pul.get ('RES_IX') ) a, 
      (SELECT * FROM ADM_RESOURCE_TYPE WHERE id              = pul.get ('RES_ID') ) x
  WHERE x.id = a.RESOURCE_TYPE_ID   and a.GRANTEE_ID = r.ID;

PROMPT *** Create  grants  M_ROLE_ADD ***
grant SELECT                                                                 on M_ROLE_ADD      to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_ADD.sql =========*** End *** ===
PROMPT ===================================================================================== 
