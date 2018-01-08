set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции W45
prompt Наименование операции: Дочерняя оплата PKO
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W45', 'Дочерняя оплата PKO', 1, '#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000010000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='W45', name='Дочерняя оплата PKO', dk=1, nlsm='#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000010000000000000000000000000', nazn=null
       where tt='W45';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='W45';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='W45';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='W45';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='W45';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='W45';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='W45';
end;
/
commit;
