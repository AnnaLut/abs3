

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/Trigger/TBIU_UPLTAGLISTS_OPFIELD.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TBIU_UPLTAGLISTS_OPFIELD ***

  CREATE OR REPLACE TRIGGER BARSUPL.TBIU_UPLTAGLISTS_OPFIELD 
BEFORE INSERT OR UPDATE
OF TAG
ON UPL_TAG_LISTS
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
BEGIN

    if length(:new.tag) < 5 and upper(:new.tag_table)='OP_FIELD' then
        :new.tag := rpad(:new.tag,5,' ');
    end if;

END ;
/
ALTER TRIGGER BARSUPL.TBIU_UPLTAGLISTS_OPFIELD ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/Trigger/TBIU_UPLTAGLISTS_OPFIELD.sql ====
PROMPT ===================================================================================== 
