set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции BMC
prompt Наименование операции: d Реалізація ЮМ (платіжні) на суму номінальної вартості
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BMC', 'd Реалізація ЮМ (платіжні) на суму номінальної вартості', 1, '#(NBS_OB22(''2909'',''23''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'BMY ( 1 )', null, 61, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BMC', name='d Реалізація ЮМ (платіжні) на суму номінальної вартості', dk=1, nlsm='#(NBS_OB22(''2909'',''23''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BMY ( 1 )', s2=null, sk=61, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BMC';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='BMC';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='BMC';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='BMC';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='BMC';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='BMC';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='BMC';
end;
/
commit;
