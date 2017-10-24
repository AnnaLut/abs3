set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PSK
prompt Наименование операции: Д/PS3 КОМИСИЯ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PSK', 'Д/PS3 КОМИСИЯ', 1, null, null, '#(nbs_ob22 (''6110'',''06''))', null, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(46, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PSK', name='Д/PS3 КОМИСИЯ', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6110'',''06''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(46, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='PSK';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PSK';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PSK';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PSK';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PSK';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PSK';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PSK';
end;
/
commit;
