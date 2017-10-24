

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TD_BANK_UFILE_MODID.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_BANK_UFILE_MODID ***

  CREATE OR REPLACE TRIGGER FINMON.TD_BANK_UFILE_MODID 
before insert ON FINMON.BANK_UFILE for each row
declare

    newid    number;
begin

    if (dbms_reputil.from_remote = false and dbms_snapshot.i_am_a_refresh = false) then

        --update bars.finmon_que
        --   set status='B'
        -- where ref = :old.opr_nom;

		select s_bank_ufile.nextval into newid from dual;

		:new.id := newid;

    end if;

end;
/
ALTER TRIGGER FINMON.TD_BANK_UFILE_MODID ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TD_BANK_UFILE_MODID.sql =========*
PROMPT ===================================================================================== 
