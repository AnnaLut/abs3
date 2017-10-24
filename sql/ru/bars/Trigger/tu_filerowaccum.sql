

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_FILEROWACCUM.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_FILEROWACCUM ***

  CREATE OR REPLACE TRIGGER BARS.TU_FILEROWACCUM 
 after update
 ON BARS.DPT_FILE_ROW_ACCUM  for each row
declare
l_rowcount dpt_file_header.info_length%type;
l_sum dpt_file_header.sum%type;
begin
    --
    -- Триггер контроля изменений данных offline-отделений
    --
    if (dbms_mview.i_am_a_refresh = true or dbms_reputil.from_remote = true) then
       return;
    end if;

    select info_length, sum
    into l_rowcount, l_sum
    from dpt_file_header
    where header_id = :new.header_id;

    if (l_rowcount is not null and l_rowcount < :new.info_length) then
        bars_error.raise_nerror('SOC', 'BF_INFO_LENGTH',to_char(:new.filename),to_char(:new.dat));
    end if;

    if (l_sum is not null and l_sum < :new.sum) then
        bars_error.raise_nerror('SOC', 'BF_SUM',to_char(:new.filename),to_char(:new.dat));
    end if;
end; 
/
ALTER TRIGGER BARS.TU_FILEROWACCUM ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_FILEROWACCUM.sql =========*** End
PROMPT ===================================================================================== 
