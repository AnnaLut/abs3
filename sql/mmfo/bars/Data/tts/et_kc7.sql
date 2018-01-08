set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KC7
prompt Наименование операции: KC7 d: розрахунки за виплачені вклади згідно реєстру ФГВФО
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KC7', 'KC7 d: розрахунки за виплачені вклади згідно реєстру ФГВФО', 1, '#(nbs_ob22 (''3739'',''08''))', 980, '#(nbs_ob22 (''2809'',''24''))', 980, null, null, null, null, 0, 0, 0, 0, null, null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', 'розрахунки за виплачені вклади згідно реєстру ФГВФО');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KC7', name='KC7 d: розрахунки за виплачені вклади згідно реєстру ФГВФО', dk=1, nlsm='#(nbs_ob22 (''3739'',''08''))', kv=980, nlsk='#(nbs_ob22 (''2809'',''24''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='розрахунки за виплачені вклади згідно реєстру ФГВФО'
       where tt='KC7';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KC7';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KC7';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KC7';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KC7';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KC7';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KC7';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'KC7');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''KC7'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
