set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 05K
prompt Наименование операции: 05K Комісія при купівлі/продажу валюти 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('05K', '05K Комісія при купівлі/продажу валюти ', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''2902'',''09''))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(0.02*(#(S2)))', null, 12, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', 'Відрахування до ПФ 2.0% від суми продажу валюти');
  exception
    when dup_val_on_index then 
      update tts
         set tt='05K', name='05K Комісія при купівлі/продажу валюти ', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''2902'',''09''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(0.02*(#(S2)))', s2=null, sk=12, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='Відрахування до ПФ 2.0% від суми продажу валюти'
       where tt='05K';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='05K';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='05K';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='05K';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='05K';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='05K';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='05K';
  begin
    insert into folders_tts(idfo, tt)
    values (2, '05K');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''05K'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
