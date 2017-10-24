

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SEND_OTC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SEND_OTC ***

  CREATE OR REPLACE PROCEDURE BARS.SEND_OTC IS 
   L_TXT VARCHAR2(250) ;
   L_TYPE_KLF NUMBER;
   L_TYPE_ROL NUMBER;
   L_TYPE_USR NUMBER;
BEGIN
 if nvl ( getglobaloption ('BMS') ,  '0')  <>  '1'  then RETURN; END IF;
 
 -- BMS Признак: 1-установлена рассылка сообщений
    
 L_TYPE_ROL  := resource_utl.get_resource_type_id('STAFF_ROLE')  ;
 L_TYPE_KLF  := resource_utl.get_resource_type_id('KLF')  ;
 L_TYPE_USR  := resource_utl.get_resource_type_id('STAFF_USER')  ;
 
 L_TXT := 'АБС готова до формування файлу #01 за банківську дату '||  to_char ( DAT_NEXT_U (gl.bdate,-1 ) , 'dd.mm.yyyy') ;
   
 -- НАЙТИ ВСЕХ ПОЛЬЗОВАТЕЛЕЙ КОТОРЫЕ ИМЕЮТ ЭТИ  РОЛИ : 
 -- НАЙТИ ВСЕ РОЛИ, КОТОРЫЕ ИМЕЮТ РЕСУРС = ОТЧЕТНОСТЬ 
 FOR U IN ( SELECT  DISTINCT GRANTEE_ID USR 
            FROM ADM_RESOURCE 
            WHERE GRANTEE_TYPE_ID = L_TYPE_USR AND RESOURCE_TYPE_ID = L_TYPE_ROL    
              AND RESOURCE_ID IN ( SELECT  GRANTEE_ID FROM ADM_RESOURCE WHERE GRANTEE_TYPE_ID =  L_TYPE_ROL AND RESOURCE_TYPE_ID = L_TYPE_KLF )
          )
 LOOP   bms.enqueue_msg( L_TXT, dbms_aq.no_delay, dbms_aq.never, U.USR ); END LOOP;
 
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SEND_OTC.sql =========*** End *** 
PROMPT ===================================================================================== 
