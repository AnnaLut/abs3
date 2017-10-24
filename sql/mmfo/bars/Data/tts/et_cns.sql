set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CNS
prompt Наименование операции: (доч CN1) Облік благодійного внеску
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CNS', '(доч CN1) Облік благодійного внеску', 1, null, 980, null, 980, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', '#(swi_get_acc(''2909''))', null, 0, 0, 0, 0, '#(DSUM)*100', null, 32, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CNS', name='(доч CN1) Облік благодійного внеску', dk=1, nlsm=null, kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', nlsb='#(swi_get_acc(''2909''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(DSUM)*100', s2=null, sk=32, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CNS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CNS';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CNS';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CNS';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CNS';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CNS';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CNS';
end;
/
commit;
