

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_CPVREPO.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_CPVREPO ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_CPVREPO 
  INSTEAD OF INSERT OR DELETE OR UPDATE ON "BARS"."CP_V_REPO"
  REFERENCING FOR EACH ROW
  declare
   ern          CONSTANT POSITIVE := 746;    -- Trigger err code
   err          EXCEPTION;
   erm          VARCHAR2(80) := 'No INSERT allowed';
begin

    if inserting then  NULL;
       raise err;
    elsif updating then
    -- ¦õ¯-¸ ¦+¦+
        if :new.ref_repo = :old.ref_repo then NULL;
--        logger.trace('CP_REPO ref='||:old.ref||' sos='||:old.sos||' new=old ref_repo='||:new.ref_repo);
        elsif :new.ref_repo is NULL and :old.sos<0 then
        update CP_arch set
            ref_repo        = :new.ref_repo
        where ref=:old.ref;
        logger.trace('CP_REPO ref='||:old.ref||' sos='||:old.sos||' old ref_repo='||:old.ref_repo);
        else NULL;
--        logger.trace('CP_REPO ref='||:old.ref||' OLD='||:old.ref_repo||' new='||:new.ref_repo||' ! NO update '||' sos='||:old.sos);
        end if;

    elsif deleting then NULL;
        erm:='No DELETE allowed';
        raise err;
    end if;
EXCEPTION
   WHEN err THEN
        raise_application_error(-(20000+ern),erm,TRUE);
end;



/
ALTER TRIGGER BARS.TIUD_CPVREPO ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_CPVREPO.sql =========*** End **
PROMPT ===================================================================================== 
