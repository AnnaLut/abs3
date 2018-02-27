PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAD_SALDOA.sql =========*** Run *** 
PROMPT ===================================================================================== 

PROMPT *** Create  trigger TAD_SALDOA ***

create or replace trigger BARS.TAD_SALDOA
after delete on saldoa
for each row
--
-- Удаленные из SALDOA записи переносим в SALDOA_DEL_ROWS
--
begin
    --
    insert
      into saldoa_del_rows(acc, fdat)
    values (:old.acc, :old.fdat);
    --
    BARS_AUDIT.ERROR( SubStr($$PLSQL_UNIT||': '||dbms_utility.format_call_stack(),1,4000) );
    --
end tad_saldoa;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAD_SALDOA.sql =========*** End *** 
PROMPT ===================================================================================== 
