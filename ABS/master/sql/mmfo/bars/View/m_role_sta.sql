

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_STA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_STA ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_STA ("GRANTEE_TYPE_ID", "GRANTEE_ID", "RESOURCE_TYPE_ID", "RESOURCE_ID", "FIO", "LOGNAME", "CLSID", "BRANCH", "PROFILE", "KRO") AS 
  select  b.GRANTEE_TYPE_ID,  b.GRANTEE_ID, b.RESOURCE_TYPE_ID, b.RESOURCE_ID ,
         a.FIO, a.LOGNAME, a.CLSID,a.BRANCH, nvl(a.PROFILE, a.WEB_PROFILE) PROFILE, (select count(*) from M_ROLE_USE where GRANTEE_ID=a.ID ) KRO
from STAFF$BASE a ,
     (select * from ADM_RESOURCE where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('STAFF_USER') 
                                   and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('STAFF_ROLE') and RESOURCE_ID = to_number( PUL.GET('RI') ) 
     ) b
where b.GRANTEE_ID = a.id (+);

PROMPT *** Create  grants  M_ROLE_STA ***
grant SELECT                                                                 on M_ROLE_STA      to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_STA      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_STA      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_STA.sql =========*** End *** ===
PROMPT ===================================================================================== 
