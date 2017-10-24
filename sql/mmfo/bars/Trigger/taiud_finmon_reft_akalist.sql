

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINMON_REFT_AKALIST.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAIUD_FINMON_REFT_AKALIST ***

  CREATE OR REPLACE TRIGGER BARS.TAIUD_FINMON_REFT_AKALIST 
after insert or update or delete on finmon_reft_akalist for each row
--
-- Триггер для актуализации таблицы словоформ finmon_reft_akl_wf
--
begin
  if deleting then
    delete from finmon_reft_akl_wf where id=:old.id;
  elsif updating then
    delete from finmon_reft_akl_wf where id=:old.id;
    insert into finmon_reft_akl_wf(id, c1, word_form)
        select :new.id, :new.c1, t.column_value word_form
        from table(select cast(f_get_namearray(f_translate_kmu(
                               :new.c6||' '||:new.c7||' '||:new.c8||' '||:new.c9))
                               as t_finmon_table)
                   from dual) t;
  elsif inserting then
    insert into finmon_reft_akl_wf(id, c1, word_form)
        select :new.id, :new.c1, t.column_value word_form
        from table(select cast(f_get_namearray(f_translate_kmu(
                               :new.c6||' '||:new.c7||' '||:new.c8||' '||:new.c9))
                               as t_finmon_table)
                   from dual) t;
  end if;
end;



/
ALTER TRIGGER BARS.TAIUD_FINMON_REFT_AKALIST ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAIUD_FINMON_REFT_AKALIST.sql ======
PROMPT ===================================================================================== 
