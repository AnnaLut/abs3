

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/EAD_DOCS_SIGN.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  trigger EAD_DOCS_SIGN ***

  CREATE OR REPLACE TRIGGER BARS.EAD_DOCS_SIGN 
AFTER UPDATE
OF SIGN_DATE
ON BARS.EAD_DOCS
for each row
  WHEN (
new.SIGN_DATE is not null
      ) DECLARE
tmp_count number;
/******************************************************************************
   NAME:
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        05/02/2014      a.yurchenko       1. Created this trigger.
   1.1        05/08/2014      a.yurchenko       2. Update this trigge(added: update dpt_deposit set status=0).

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:
      Sysdate:         05/02/2014
      Date and Time:   05/02/2014, 10:36:38, and 05/02/2014 10:36:38
      Username:        a.yurchenko (set in TOAD Options, Proc Templates)
      Table Name:      EAD_DOCS (set in the "New PL/SQL Object" dialog)
      Trigger Options:  (при подписании документа он автоматически добавляется в очередь на синхр. с ЕА если его там еще не было)
******************************************************************************/
BEGIN

--встановлення статусу підписано на договорі
if  (:NEW.EA_STRUCT_ID = 212)  then
            update dpt_deposit
            set status = 0
            where deposit_id = :NEW.AGR_ID;
end if;

select count(*) into tmp_count from ead_sync_queue where type_id = 'DOC' and obj_id = :NEW.id;
if tmp_count = 0 then
INSERT  into ead_sync_queue   (id,
                       crt_date,
                       type_id,
                       obj_id,
                       status_id)
               VALUES (bars_sqnc.get_nextval('s_eadsyncqueue'),
                       SYSDATE,
                       'DOC',
                       :NEW.id,
                       'NEW');
                       end if;


   /*EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;*/
END;
/
show errors

--ALTER TRIGGER BARS.EAD_DOCS_SIGN DISABLE;
-- 04.01.2018 дропаем ацкий триггер, но оставляем в назидание археологам скрипт
DROP TRIGGER BARS.EAD_DOCS_SIGN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/EAD_DOCS_SIGN.sql =========*** End *
PROMPT ===================================================================================== 
