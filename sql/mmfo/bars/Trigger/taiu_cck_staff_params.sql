

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCK_STAFF_PARAMS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIU_CCK_STAFF_PARAMS ***

  CREATE OR REPLACE TRIGGER BARS.TAIU_CCK_STAFF_PARAMS 
BEFORE INSERT OR UPDATE OF kf ON cck_staff_params
FOR EACH ROW
BEGIN
   select kf into :new.kf from  staff  where id=:new.user_id;
END TAIU_CCK_STAFF_PARAMS;



/
ALTER TRIGGER BARS.TAIU_CCK_STAFF_PARAMS ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIU_CCK_STAFF_PARAMS.sql =========*
PROMPT ===================================================================================== 
