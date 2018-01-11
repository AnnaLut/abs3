set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции BKB
prompt Наименование операции: BKB d Дохід від реалізації ювiлейних монет
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BKB', 'BKB d Дохід від реалізації ювiлейних монет', 1, '#(NBS_OB22(''2909'',''23''))', 980, '#(NBS_OB22(''6399'',''14''))', 980, null, null, null, null, 0, 0, 0, 0, 'BMY (8 )', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BKB', name='BKB d Дохід від реалізації ювiлейних монет', dk=1, nlsm='#(NBS_OB22(''2909'',''23''))', kv=980, nlsk='#(NBS_OB22(''6399'',''14''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BMY (8 )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BKB';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='BKB';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='BKB';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='BKB';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='BKB';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='BKB';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='BKB';
end;
/
commit;
