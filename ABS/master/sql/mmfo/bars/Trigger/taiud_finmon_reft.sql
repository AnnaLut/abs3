

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINMON_REFT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_FINMON_REFT ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_FINMON_REFT 
after insert or update or delete on finmon_reft for each row
--
-- Триггер для актуализации таблицы словоформ finmon_reft_wf
--
begin
  if deleting then
    delete from finmon_reft_wf where c1=:old.c1;
  elsif updating then
    delete from finmon_reft_wf where c1=:old.c1;
    insert into finmon_reft_wf(c1, word_form)
        select :new.c1, t.column_value word_form
        from table(select cast(f_get_namearray(f_translate_kmu(
                               :new.c6||' '||:new.c7||' '||:new.c8||' '||:new.c9))
                               as t_finmon_table)
                   from dual) t;
  elsif inserting then
    insert into finmon_reft_wf(c1, word_form)
        select :new.c1, t.column_value word_form
        from table(select cast(f_get_namearray(f_translate_kmu(
                               :new.c6||' '||:new.c7||' '||:new.c8||' '||:new.c9))
                               as t_finmon_table)
                   from dual) t;
  end if;
end;



/
ALTER TRIGGER BARS.TAIUD_FINMON_REFT ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINMON_REFT.sql =========*** E
PROMPT ===================================================================================== 
