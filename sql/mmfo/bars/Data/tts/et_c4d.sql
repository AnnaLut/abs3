set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции C4D
prompt Наименование операции: C4D(доч.CN4) Конвертація на суму комісії прийнятої у клієнтів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C4D', 'C4D(доч.CN4) Конвертація на суму комісії прийнятої у клієнтів', 1, '#(swi_get_acc(''2909'',''2809''))', null, '#(swi_get_acc(''2809''))', 980, null, null, null, null, 0, 0, 1, 0, 'f_swi_sum(3)', 'f_swi_sum(2)', null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C4D', name='C4D(доч.CN4) Конвертація на суму комісії прийнятої у клієнтів', dk=1, nlsm='#(swi_get_acc(''2909'',''2809''))', kv=null, nlsk='#(swi_get_acc(''2809''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='f_swi_sum(3)', s2='f_swi_sum(2)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C4D';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='C4D';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='C4D';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='C4D';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='C4D';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='C4D';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='C4D';
end;
/
commit;
