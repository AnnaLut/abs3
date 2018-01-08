set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции МГД
prompt Наименование операции: Ребранчинг(дочірня)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('МГД', 'Ребранчинг(дочірня)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='МГД', name='Ребранчинг(дочірня)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH02'',0))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='МГД';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='МГД';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='МГД';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='МГД';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='МГД';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='МГД';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='МГД';
end;
/
commit;
