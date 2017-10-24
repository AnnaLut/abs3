set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KL6
prompt Наименование операции: Зарахування по даті валютування
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KL6', 'Зарахування по даті валютування', 1, '#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_klf2', null, null, null, null, 0, '0000000000000000000000100000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KL6', name='Зарахування по даті валютування', dk=1, nlsm='#(bpk_get_transit5(''19'',#(NLSB),#(KVB),#(REF)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_klf2', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000000000000000000000100000000000000000000000000000000000000000', nazn=null
       where tt='KL6';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KL6';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KL6';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KL6';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KL6';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KL6';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KL6';
end;
/
commit;
