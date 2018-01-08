

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Trigger/TD_OPER_MODID.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TD_OPER_MODID ***

  CREATE OR REPLACE TRIGGER FINMON.TD_OPER_MODID 
after delete ON FINMON.OPER for each row
begin

    if (dbms_reputil.from_remote = false and dbms_snapshot.i_am_a_refresh = false) then

        update bars.finmon_que
           set status='B'
         where ref = :old.new_oper_nom;

    end if;

end;
/
ALTER TRIGGER FINMON.TD_OPER_MODID DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Trigger/TD_OPER_MODID.sql =========*** End
PROMPT ===================================================================================== 
