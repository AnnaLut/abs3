

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TIU_DPTFILEROW.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TIU_DPTFILEROW ***

  CREATE OR REPLACE TRIGGER BARS.TIU_DPTFILEROW 
 after insert or delete or update of sum
 ON BARS.DPT_FILE_ROW  for each row
declare
begin
    --
    -- Триггер контроля изменений данных offline-отделений
    --
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

  if (updating) then
      update dpt_file_row_accum
      set sum = sum - nvl(:old.sum,0) + nvl(:new.sum,0)
      where header_id = :new.header_id;
  elsif (inserting) then
      update dpt_file_row_accum
      set sum = sum + nvl(:new.sum,0), info_length = info_length + 1
      where header_id = :new.header_id;
  elsif (deleting) then
      update dpt_file_row_accum
      set sum = sum - nvl(:old.sum,0), info_length = info_length - 1
      where header_id = :old.header_id;
  end if;

end; 




/
ALTER TRIGGER BARS.TIU_DPTFILEROW ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TIU_DPTFILEROW.sql =========*** End 
PROMPT ===================================================================================== 
