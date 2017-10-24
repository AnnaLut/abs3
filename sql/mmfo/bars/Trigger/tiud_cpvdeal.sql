

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_CPVDEAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_CPVDEAL ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_CPVDEAL 
  INSTEAD OF INSERT OR DELETE OR UPDATE ON "BARS"."CP_V_DEAL"
  REFERENCING FOR EACH ROW
  declare
    l_acc8		accounts.acc%type;
   ern          CONSTANT POSITIVE := 746;    -- Trigger err code
   err          EXCEPTION;
   erm          VARCHAR2(80) := 'No INSERT allowed';
begin
	if inserting or updating then  NULL;    end if;

    if inserting then  NULL;
       raise err;
    elsif updating then
    -- ефективна ставка денна
        if round(:new.erat,15) != round(:old.erat,15)
           and :new.erat is not NULL then
    	update CP_deal set
            erat        = :new.erat
        where ref=:old.ref;
        logger.info('CP_V_DEAL: CP_ID='||:OLD.cp_id||' ref='||:OLD.ref
                    ||' ERAT NEW='||:NEW.erat||' OLD='||:OLD.erat);
        end if;
    -- OSTF - купон на пакет для розр-ку
        if :new.ostr_f != :old.ostr_f  and :new.ostr_f is not NULL then
    	update Accounts set
            OSTF        = :new.ostr_f*100
        where acc=:old.accr;
        logger.info('CP_V_DEAL: CP_ID='||:OLD.cp_id||' ref='||:OLD.ref
                    ||' Купон NEW='||:NEW.ostr_f||' OLD='||:OLD.ostr_f);
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
ALTER TRIGGER BARS.TIUD_CPVDEAL ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_CPVDEAL.sql =========*** End **
PROMPT ===================================================================================== 
