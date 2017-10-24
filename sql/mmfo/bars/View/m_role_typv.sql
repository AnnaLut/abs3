

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/M_ROLE_TYPV.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view M_ROLE_TYPV ***

  CREATE OR REPLACE FORCE VIEW BARS.M_ROLE_TYPV ("ID", "XXX", "IX", "CODE", "NAME", "TABNAME", "NPP", "SEM", "MLT") AS 
  select x."ID",x."XXX",x."IX",x."CODE",x."NAME",x."TABNAME",x."NPP",   SEM_ROLE (IX,tabname ) sem,
       case when XXX in ('ACC', 'ARM', 'CHK','OTC','TTS') and x.IX is not null  then '<=> декілька ролей '
            else null 
            end  MLT
from ( select ID, XXX,  
              to_number( PUL.GET( XXX) )   IX,
              substr(RESOURCE_CODE,1,20)   code,  
              substr(RESOURCE_NAME, 1,100) name, 
              SUBSTR(decode(XXX, 'ACC','GROUPS'       , 'ARM','APPLIST1', 'CHK','CHKLIST' , 'REF','TYPEREF'   , 'FUN','OPERLIST1',
                                 'OTC','KL_F00$GLOBAL', 'TTS','TTS'     , 'REP','REPORTSF', 'ROL','STAFF_ROLE', 'STA','STAFF$BASE', null),1,20) 
                                           tabname,  
               decode(XXX, 'ROL',11, 'ARM',2, 'FUN',3, 'REP',4,  'REF',5, 'ACC',6 , 'CHK',7, 'OTC',8, 'TTS',9, 'STA',10, 99 ) 
                                           npp                
       From ( select ID, RESOURCE_CODE, RESOURCE_NAME, 
                     decode(RESOURCE_CODE, 'ACCOUNT_GROUP','ACC',  'ARM_WEB','ARM',   'CHKLIST'   ,'CHK', 
                                           'DIRECTORIES'  ,'REF',  'KLF'    ,'OTC',   'REPORTS'   ,'REP', 
                                           'FUNCTION_WEB' ,'FUN',  'TTS'    ,'TTS',   'STAFF_ROLE','ROL', 
                                           'STAFF_USER'   ,'STA',   null) XXX
             from ADM_RESOURCE_TYPE
             )
       where XXX is not null 
     ) x;

PROMPT *** Create  grants  M_ROLE_TYPV ***
grant SELECT                                                                 on M_ROLE_TYPV     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/M_ROLE_TYPV.sql =========*** End *** ==
PROMPT ===================================================================================== 
