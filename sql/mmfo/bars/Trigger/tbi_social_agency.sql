

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TBI_SOCIAL_AGENCY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBI_SOCIAL_AGENCY ***

  CREATE OR REPLACE TRIGGER BARS.TBI_SOCIAL_AGENCY 
BEFORE INSERT ON BARS.SOCIAL_AGENCY FOR EACH ROW
BEGIN

    --
    -- Триггер контроля изменений данных offline-отделений
    --
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

  IF (:new.agency_id IS NULL) OR (:new.agency_id = 0) THEN
     SELECT get_id_ddb(bars_sqnc.get_nextval('s_social_agency')) INTO :new.agency_id FROM dual;
  END IF;

END tbi_social_agency; 




/
ALTER TRIGGER BARS.TBI_SOCIAL_AGENCY ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TBI_SOCIAL_AGENCY.sql =========*** E
PROMPT ===================================================================================== 
