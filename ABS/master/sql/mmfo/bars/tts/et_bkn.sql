set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции BKN
prompt Наименование операции: BKN доч до BKY D2909/23-K1919/06
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BKN', 'BKN доч до BKY D2909/23-K1919/06', 1, '#(NBS_OB22(''2909'',''23''))', null, '#(NBS_OB22(''1919'',''06''))', null, null, null, null, null, 0, 0, 0, 0, 'BMY (6 )', null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BKN', name='BKN доч до BKY D2909/23-K1919/06', dk=1, nlsm='#(NBS_OB22(''2909'',''23''))', kv=null, nlsk='#(NBS_OB22(''1919'',''06''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BMY (6 )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BKN';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='BKN';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='BKN';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='BKN';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='BKN';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='BKN';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='BKN';
end;
/
commit;
