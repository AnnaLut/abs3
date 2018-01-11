set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции TO2
prompt Наименование операции: TO2 d: Прийом готівки (доч до TO3)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TO2', 'TO2 d: Прийом готівки (доч до TO3)', 1, '#(nbs_ob22 (''2902'',''01''))', 980, null, 980, null, null, null, null, 0, 0, 0, 0, null, null, 12, null, null, null, '0000100001000000000001000000000000000100000000000000000000000000', 'Приймання бюджетних платежів від фізичних осіб');
  exception
    when dup_val_on_index then 
      update tts
         set tt='TO2', name='TO2 d: Прийом готівки (доч до TO3)', dk=1, nlsm='#(nbs_ob22 (''2902'',''01''))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=12, proc=null, s3800=null, rang=null, flags='0000100001000000000001000000000000000100000000000000000000000000', nazn='Приймання бюджетних платежів від фізичних осіб'
       where tt='TO2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='TO2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='TO2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='TO2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='TO2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='TO2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='TO2';
end;
/
commit;
