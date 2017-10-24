set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции BK8
prompt Наименование операции: BK8 доч до BMF D2900-K3400
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BK8', 'BK8 доч до BMF D2900-K3400', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_3400'',0))', null, null, null, null, null, 0, 0, 0, 0, '(FORM_MON(#(REF),''NBU'',''B_MZP'')*COUNT_MON(#(REF),#(S)))/1.2', null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BK8', name='BK8 доч до BMF D2900-K3400', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_2900'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''BM_3400'',0))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(FORM_MON(#(REF),''NBU'',''B_MZP'')*COUNT_MON(#(REF),#(S)))/1.2', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BK8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='BK8';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='BK8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='BK8';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='BK8';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='BK8';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='BK8';
end;
/
commit;
