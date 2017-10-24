set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции R03
prompt Наименование операции: p) R03 - Процессинг ( фаза B ) КР (БПК)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('R03', 'p) R03 - Процессинг ( фаза B ) КР (БПК)', 1, null, null, '#(bpk_get_transit5(''1B'',#(NLSB),#(KVB)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='R03', name='p) R03 - Процессинг ( фаза B ) КР (БПК)', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit5(''1B'',#(NLSB),#(KVB)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010100000000000010000000000000', nazn=null
       where tt='R03';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='R03';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='R03';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='R03';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='R03';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='R03';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='R03';
end;
/
commit;
