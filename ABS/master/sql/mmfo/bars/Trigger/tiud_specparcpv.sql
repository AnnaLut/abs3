

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_SPECPARCPV.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_SPECPARCPV ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_SPECPARCPV 
instead of insert or update or delete ON SPECPARAM_CP_V for each row
declare
   ern          CONSTANT POSITIVE := 746;    -- Trigger err code
   err          EXCEPTION;
   erm          VARCHAR2(80) := 'No INSERT allowed';
begin
    if inserting or updating then  NULL;    end if;

    if inserting then  NULL;
       raise err;
    elsif updating then
    -- initiator
        if :new.initiator != :old.initiator and :new.initiator is not NULL
            or (:old.initiator is NULL and :new.initiator is not NULL  )
            or (:new.initiator is NULL and :old.initiator is not NULL  )  then
        update SPECPARAM_CP_OB set
               initiator = :new.initiator
        where acc=:old.acc;
        logger.trace('SPECPARAM_CP_V: acc='||:OLD.acc
                    ||' init NEW='||:NEW.initiator||' OLD='||:OLD.initiator);
        end if;
    -- market
       if :new.market != :old.market   and :new.market is not NULL
          or (:old.market is NULL and :new.market is not NULL)
          or (:new.market is NULL and :old.market is not NULL) then
        update SPECPARAM_CP_OB set
               market = :new.market
        where acc=:old.acc;
        logger.trace('SPECPARAM_CP_V: acc='||:OLD.acc
                    ||' market NEW='||:NEW.market||' OLD='||:OLD.market);
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
ALTER TRIGGER BARS.TIUD_SPECPARCPV ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_SPECPARCPV.sql =========*** End
PROMPT ===================================================================================== 
