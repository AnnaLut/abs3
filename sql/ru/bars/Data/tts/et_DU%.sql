set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DU%
prompt Наименование операции: DU% Нарахування відсотків
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DU%', 'DU% Нарахування відсотків', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', 0, '0000100000000000000000000000000000000100000000000000000000000000', 'Нарахування відсотків по депозиту згідно #{DPU.GET_INTDETAILS(#(NLS),#(KV))} за період з #(DAT1) по #(DAT2) вкл.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU%', name='DU% Нарахування відсотків', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='Нарахування відсотків по депозиту згідно #{DPU.GET_INTDETAILS(#(NLS),#(KV))} за період з #(DAT1) по #(DAT2) вкл.'
       where tt='DU%';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DU%';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DU%';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DU%';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DU%';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DU%';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DU%';
  begin
    insert into folders_tts(idfo, tt)
    values (4, 'DU%');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 4, ''DU%'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
