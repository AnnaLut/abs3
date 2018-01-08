

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE ("ID", "CODE", "NAME", "ACC", "ARMC", "ARMW", "CHK", "OTC", "TTS", "STA") AS 
  select r.ID , substr(r.ROLE_CODE,1,100) code, substr(r.ROLE_NAME,1,100) name, 
       NVL(d.ACC , 0 ) ACC , 
       NVL(d.ARMC, 0 ) ARMC, 
       NVL(d.ARMW, 0 ) ARMW,
       NVL(d.CHK , 0 ) CHK ,
       NVL(d.OTC , 0 ) OTC ,
       NVL(d.TTS , 0 ) TTS ,
          (select count(*) from ADM_RESOURCE 
           where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('STAFF_USER') 
              and RESOURCE_TYPE_ID = resource_utl.get_resource_type_id('STAFF_ROLE') 
              and RESOURCE_ID = r.ID 
           )  STA
from  STAFF_ROLE r , 
      (select y.GRANTEE_ID, sum(decode ( x.RESOURCE_CODE, 'ARM_CENTURA'  , 1, 0 ) )  ARMC,
                            sum(decode ( x.RESOURCE_CODE, 'ARM_WEB'      , 1, 0 ) )  ARMW,
                            sum(decode ( x.RESOURCE_CODE, 'ACCOUNT_GROUP', 1, 0 ) )  ACC ,
                            sum(decode ( x.RESOURCE_CODE, 'CHKLIST'      , 1, 0 ) )  CHK ,
                            sum(decode ( x.RESOURCE_CODE, 'KLF'          , 1, 0 ) )  OTC,
                            sum(decode ( x.RESOURCE_CODE, 'TTS'          , 1, 0 ) )  TTS
        from (select * from ADM_RESOURCE      where GRANTEE_TYPE_ID  = resource_utl.get_resource_type_id('STAFF_ROLE')                      ) y, 
             (select * from ADM_RESOURCE_TYPE where RESOURCE_CODE in ('ARM_CENTURA', 'ARM_WEB', 'ACCOUNT_GROUP',  'CHKLIST', 'KLF', 'TTS' ) ) x
       where    y.RESOURCE_TYPE_ID = x.ID
       group by y.GRANTEE_ID   
      ) d 
where  r.id = d.GRANTEE_ID (+);

PROMPT *** Create  grants  M_ROLE ***
grant SELECT                                                                 on M_ROLE          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on M_ROLE          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE.sql =========*** End *** =======
PROMPT ===================================================================================== 
