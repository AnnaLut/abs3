set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PKL
prompt Наименование операции: д) Списання-поповнення картрахунку
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PKL', 'д) Списання-поповнення картрахунку', 1, '#(bpk_get_transit(''20'',''2625'',#(NLSA),#(KVA)))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PKL', name='д) Списання-поповнення картрахунку', dk=1, nlsm='#(bpk_get_transit(''20'',''2625'',#(NLSA),#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010100000000000000000000000000', nazn=null
       where tt='PKL';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PKL';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PKL';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PKL';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PKL';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PKL';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PKL';
end;
/
commit;
