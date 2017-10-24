

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIUD_ETARND.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIUD_ETARND ***

  CREATE OR REPLACE TRIGGER BARS.TIUD_ETARND 
after insert or update or delete of ND,ID,DAT_BEG,SUMT
ON BARS.E_TAR_ND for each row
 WHEN (
new.nd!=old.nd or new.id!=old.id
      or new.dat_beg!=old.dat_beg or new.sumt!=old.sumt
      or (new.sumt is not NULL and old.sumt is NULL)
      ) begin
    IF INSERTING THEN
    logger.info('E_TAR_ND: ND='||:NEW.nd||',ID='||:NEW.id||' inserting');
    ELSIF UPDATING THEN
    logger.info('E_TAR_ND: ND='||:NEW.nd||',ID='||:NEW.id
               ||',дата='||:NEW.dat_beg||',інд.сума='||:NEW.sumt||' updating');
    else
    logger.info('E_TAR_ND: ND='||:OLD.nd||',OLD.id='||:OLD.id||' deleting');
      end if;
end;
/
ALTER TRIGGER BARS.TIUD_ETARND ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIUD_ETARND.sql =========*** End ***
PROMPT ===================================================================================== 
