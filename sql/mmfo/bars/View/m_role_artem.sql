

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_ARTEM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_ARTEM ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_ARTEM ("NPP", "GT", "GTS", "GI", "GIK", "GIS", "RT", "RTS", "RI", "RIK", "RIS", "USER1", "FIO1", "TIME1", "MODE1", "USER2", "FIO2", "TIME2", "MODE2", "COMM2") AS 
  select a.id npp,
 a.grantee_type_id  GT, substr(gt.resource_name,1,100)  GTS, a.grantee_id          GI , 
   substr(resource_utl.get_resource_code(a.grantee_type_id , a.grantee_id ),1,100) GIK, 
   substr(resource_utl.get_resource_name(a.grantee_type_id , a.grantee_id ),1,100) GIS,
 a.resource_type_id RT, substr(rt.resource_name,1,100)  RTS, a.resource_id         RI , 
   substr(resource_utl.get_resource_code(a.resource_type_id, a.resource_id),1,100) RIK,
   substr(resource_utl.get_resource_name(a.resource_type_id, a.resource_id),1,100) RIS,
 a.action_user_id     USER1, u1.fio FIO1, to_char(a.action_time,    'dd.mm.yyyy HH24:mi:ss') TIME1, 
   substr(list_utl.get_item_name(r.access_mode_list_id, a.access_mode_id),1,100) MODE1, 
 a.resolution_user_id USER2, u2.fio FIO2, to_char(a.resolution_time,'dd.mm.yyyy HH24:mi:ss') TIME2, 
   decode(a.resolution_type_id,1,'Підтверджено',2,'Відхилено',3,'Замінено',null) MODE2, 
   substr(a.resolution_comment,1,100) COMM2  
from adm_resource_activity a, adm_resource_type gt,  adm_resource_type rt, adm_resource_type_relation r,       staff$base u1 , staff$base u2 
where gt.id = a.grantee_type_id 
  and rt.id = a.resource_type_id
  and r.grantee_type_id = a.grantee_type_id and r.resource_type_id = a.resource_type_id
  and a.action_user_id = u1.id (+) 
  and a.resolution_user_id = u2.id (+);

PROMPT *** Create  grants  M_ROLE_ARTEM ***
grant SELECT                                                                 on M_ROLE_ARTEM    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_ARTEM.sql =========*** End *** =
PROMPT ===================================================================================== 
