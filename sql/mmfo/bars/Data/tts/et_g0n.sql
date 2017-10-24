set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции G0N
prompt Наименование операции: Погаш.комiсiї за внесення гот. на рах.акред.нотаріуса
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G0N', 'Погаш.комiсiї за внесення гот. на рах.акред.нотаріуса', 1, null, 980, '#(nbs_ob22_RNK (''3570'',''34'',#(NLSA),980))', 980, null, null, null, null, 0, 0, 0, 0, '0.2*#(S)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G0N', name='Погаш.комiсiї за внесення гот. на рах.акред.нотаріуса', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22_RNK (''3570'',''34'',#(NLSA),980))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='0.2*#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='G0N';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='G0N';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='G0N';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='G0N';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='G0N';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='G0N';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='G0N';
end;
/
commit;
