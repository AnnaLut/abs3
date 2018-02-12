

set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !97
prompt Наименование операции: STOP-правило для 097
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!97', 'STOP-правило для 097', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP_097(#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='!97', name='STOP-правило для 097', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP_097(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!97';
  end;
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='!97';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!97';
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!97';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='!97';
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!97';
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='!97';
  
  
end;
/

prompt Создание / Обновление операции 097
prompt Наименование операции: 097  Коригуючі за Рік
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('097', '097  Коригуючі за Рік', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22(''3800'',''03''))', null, '1101100000000000000000000000000000010000000000000000000000030000', null);
  exception
    when dup_val_on_index then
      update tts set
        tt='097', name='097  Коригуючі за Рік', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22(''3800'',''03''))', rang=null, flags='1101100000000000000000000000000000010000000000000000000000030000', nazn=null
       where tt='097';
  end;
  dbms_output.put_line('Не забудьте указать ваши маржинальные счета доходов и расходов для операции: 097 ');
  
  --------------------------------
  ---------- Реквизиты -----------
  --------------------------------
  delete from op_rules where tt='097';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KODDZ', '097', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KODDZ'', ''097'', ''O'', 1, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('OB22 ', '097', 'O', 1, 0, '03', null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''OB22 '', ''097'', ''O'', 1, 0, ''03'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='097';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!97', '097', 0);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''!97'', ''097'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='097';
  
  --------------------------------
  ------- Виды документов --------
  --------------------------------
  delete from tts_vob where tt='097';
  begin
    insert into tts_vob(vob, tt)
    values (99, '097');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 99, ''097'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='097';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '097', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''097'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  --------------------------------
  ------------ Папки -------------
  --------------------------------
  delete from folders_tts where tt='097';
  begin
    insert into folders_tts(idfo, tt)
    values (28, '097');
  exception
    when dup_val_on_index then null;
    when others then 
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 28, ''097'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  
  
end;
/


commit;

-------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION BARS.f_stop_097(p_ref oper.ref%type)
   RETURN NUMERIC
IS
   --------------------------------------
   ern   CONSTANT POSITIVE := 803;
   err            EXCEPTION;
   erm            VARCHAR2 (250);
   --------------------------------------
BEGIN

   IF not (to_char(gl.BDATE,'mmdd')>='0125' and  to_char(gl.BDATE,'mmdd')<='0331')  THEN

      erm :=
         '      Річні корегуючі проводки можна вводити тільки з 25.01 по 31.03 ! ' ;
      RAISE err;
   END IF;

   RETURN 0;

EXCEPTION WHEN err THEN
      raise_application_error (- (20000 + ern), '\' || erm, TRUE);
   WHEN OTHERS THEN
      raise_application_error (
         - (20000 + ern),
            DBMS_UTILITY.format_error_stack ()
         || CHR (10)
         || DBMS_UTILITY.format_error_backtrace (),
         TRUE);
END;
/


grant execute on f_stop_097 to START1;
