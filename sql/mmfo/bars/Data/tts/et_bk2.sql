set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции BK2
prompt Наименование операции: BK2 доч до BMU D2900-K3622
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BK2', 'BK2 доч до BMU D2900-K3622', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_3622'',0))', null, null, null, null, null, 0, 0, 0, 0, '#(S)/6', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BK2', name='BK2 доч до BMU D2900-K3622', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_3622'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BK2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='BK2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='BK2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='BK2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='BK2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='BK2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='BK2';
end;
/
commit;
