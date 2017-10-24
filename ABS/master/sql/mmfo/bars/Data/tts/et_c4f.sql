set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции C4F
prompt Наименование операции: C4F(доч.CN4) Комісія системи, що належить до повернення клієнту 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C4F', 'C4F(доч.CN4) Комісія системи, що належить до повернення клієнту ', 1, '#(swi_get_acc(''2909''))', 980, '#(swi_get_acc(''2809''))', 980, null, null, null, null, 0, 0, 1, 0, 'f_swi_sum_ret(f_swi_sum(4))', 'f_swi_sum_ret(f_swi_sum(4))', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C4F', name='C4F(доч.CN4) Комісія системи, що належить до повернення клієнту ', dk=1, nlsm='#(swi_get_acc(''2909''))', kv=980, nlsk='#(swi_get_acc(''2809''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='f_swi_sum_ret(f_swi_sum(4))', s2='f_swi_sum_ret(f_swi_sum(4))', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C4F';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='C4F';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='C4F';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='C4F';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='C4F';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='C4F';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='C4F';
end;
/
commit;
