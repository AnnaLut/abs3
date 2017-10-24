set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 812
prompt Наименование операции: 812 - Сума екв
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('812', '812 - Сума екв', 1, '29003', 980, null, 980, null, null, null, null, 0, 0, 0, 0, '#(S2)', '#(S2)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='812', name='812 - Сума екв', dk=1, nlsm='29003', kv=980, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S2)', s2='#(S2)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='812';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='812';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='812';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='812';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='812';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='812';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='812';
end;
/
commit;
