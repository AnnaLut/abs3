set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DO2
prompt Наименование операции: DO2 ПДВ із суми нарах.доходів Банку від оренди (приміщень,POS-термінал
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DO2', 'DO2 ПДВ із суми нарах.доходів Банку від оренди (приміщень,POS-термінал', 1, null, 980, '#(nbs_ob22 (''3622'',''51''))', 980, null, null, null, null, 0, 0, 0, 0, 'round(#(S)/6)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DO2', name='DO2 ПДВ із суми нарах.доходів Банку від оренди (приміщень,POS-термінал', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''3622'',''51''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='round(#(S)/6)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DO2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DO2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DO2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DO2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DO2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DO2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DO2';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'DO2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''DO2'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
