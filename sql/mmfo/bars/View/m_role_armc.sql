

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_ARMC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_ARMC ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_ARMC ("ROL", "RI", "ID", "CODEAPP", "NAME", "REF", "FUN", "REP") AS 
  select substr(PUL.GET('ROLE'),1,100) ROL, to_number(PUL.GET('RI') ) RI, 
       b.RESOURCE_ID id, a.codeapp, Substr(a.name,1,100) name, d.ref, d.fun, d.rep 
from (select * from applist where nvl(frontend,0) = 0
      )  a,       
     (select * from ADM_RESOURCE where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('STAFF_ROLE'  ) and GRANTEE_ID = to_number( PUL.GET('RI') ) 
                                   and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('ARM_CENTURA' )
     ) b,
     (select y.GRANTEE_ID, sum(decode (x.RESOURCE_CODE, 'DIRECTORIES'     , 1, 0 ) ) REF,
                           sum(decode (x.RESOURCE_CODE, 'FUNCTION_CENTURA', 1, 0 ) ) FUN,
                           sum(decode (x.RESOURCE_CODE, 'REPORTS'         , 1, 0 ) ) REP
      from (select * from ADM_RESOURCE      where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('ARM_CENTURA' ) ) y, 
           (select * from ADM_RESOURCE_TYPE where RESOURCE_CODE in ('FUNCTION_CENTURA', 'DIRECTORIES', 'REPORTS' )     ) x
      where    y.RESOURCE_TYPE_ID = x.ID
      group by y.GRANTEE_ID   
     ) d
where b.RESOURCE_ID = a.id (+)   and b.RESOURCE_ID = d.GRANTEE_ID (+);

PROMPT *** Create  grants  M_ROLE_ARMC ***
grant SELECT                                                                 on M_ROLE_ARMC     to BARSREADER_ROLE;
grant SELECT                                                                 on M_ROLE_ARMC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE_ARMC     to START1;
grant SELECT                                                                 on M_ROLE_ARMC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_ARMC.sql =========*** End *** ==
PROMPT ===================================================================================== 
