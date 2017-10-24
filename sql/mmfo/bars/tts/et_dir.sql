set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DIR
prompt Наименование операции: DIR Mеморіальний Oрдер (різновалютний)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DIR', 'DIR Mеморіальний Oрдер (різновалютний)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22(''3800'',nvl(F_DOP(gl.aRef,''OB22''),''10'')))', null, '1001100000000000000000000001000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DIR', name='DIR Mеморіальний Oрдер (різновалютний)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22(''3800'',nvl(F_DOP(gl.aRef,''OB22''),''10'')))', rang=null, flags='1001100000000000000000000001000000010100000000000000000000000000', nazn=null
       where tt='DIR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DIR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DIR';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DIR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DIR';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DIR';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DIR', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''DIR'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DIR';
end;
/
commit;
