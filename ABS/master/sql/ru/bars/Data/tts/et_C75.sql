set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции C75
prompt Наименование операции: C75(доч.CN4) Комісія за прийом переказу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C75', 'C75(доч.CN4) Комісія за прийом переказу', 1, '#(swi_get_acc(''2809''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'f_swi_sum(0)', 'f_swi_sum(0)', 61, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C75', name='C75(доч.CN4) Комісія за прийом переказу', dk=1, nlsm='#(swi_get_acc(''2809''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_swi_sum(0)', s2='f_swi_sum(0)', sk=61, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C75';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='C75';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='C75';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='C75';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='C75';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='C75';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='C75';
end;
/
commit;
