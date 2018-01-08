

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_ARMW.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_ARMW ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_ARMW ("ROL", "GRANTEE_TYPE_ID", "GRANTEE_ID", "RESOURCE_TYPE_ID", "RESOURCE_ID", "REF", "FUN", "REP") AS 
  select substr(PUL.GET('ROLE'),1,100) ROL, b.GRANTEE_TYPE_ID, b.GRANTEE_ID, b.RESOURCE_TYPE_ID, b.RESOURCE_ID, d.ref, d.fun, d.rep 
from (select * from ADM_RESOURCE where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('STAFF_ROLE') 
                                   and GRANTEE_ID       = to_number( PUL.GET('RI')) 
                                   and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('ARM_WEB'   )
     ) b,
     (select y.GRANTEE_ID, sum(decode (x.RESOURCE_CODE, 'DIRECTORIES' , 1, 0 ) ) REF,
                           sum(decode (x.RESOURCE_CODE, 'FUNCTION_WEB', 1, 0 ) ) FUN,
                           sum(decode (x.RESOURCE_CODE, 'REPORTS'     , 1, 0 ) ) REP
      from (select * from ADM_RESOURCE      where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('ARM_WEB') ) y, 
           (select * from ADM_RESOURCE_TYPE where RESOURCE_CODE in ('FUNCTION_WEB', 'DIRECTORIES', 'REPORTS' )    ) x
      where    y.RESOURCE_TYPE_ID = x.ID
      group by y.GRANTEE_ID   
     ) d
where b.RESOURCE_ID  = d.GRANTEE_ID (+);

PROMPT *** Create  grants  M_ROLE_ARMW ***
grant SELECT                                                                 on M_ROLE_ARMW     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_ARMW     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_ARMW.sql =========*** End *** ==
PROMPT ===================================================================================== 
