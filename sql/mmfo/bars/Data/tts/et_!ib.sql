set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !IB
prompt Наименование операции: !IB STOP правило на 2603 дл¤ валюти
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!IB', '!IB STOP правило на 2603 дл¤ валюти', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'ib_stop_2603(''2603'',''05'',#(NLSA),#(NLSB),#(KVA),0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!IB', name='!IB STOP правило на 2603 дл¤ валюти', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ib_stop_2603(''2603'',''05'',#(NLSA),#(NLSB),#(KVA),0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!IB';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!IB';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!IB';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!IB';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!IB';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!IB';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!IB';
end;
/
commit;
