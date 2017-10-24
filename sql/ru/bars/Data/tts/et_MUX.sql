set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MUX
prompt Наименование операции: 2909/75 - 1002 - Для виплати (екв <150 тис)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MUX', '2909/75 - 1002 - Для виплати (екв <150 тис)', 1, '#(nbs_ob22 (''2909'',''75''))', null, ' #(tobopack.GetToboCASH)', null, null, '#(nbs_ob22 (''2909'',''75''))', '#(tobopack.GetToboCASH)', null, 0, 0, 0, 0, 'F_CHECK_PAYMENT(#(REF),1)', 'F_CHECK_PAYMENT(#(REF),1)', null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MUX', name='2909/75 - 1002 - Для виплати (екв <150 тис)', dk=1, nlsm='#(nbs_ob22 (''2909'',''75''))', kv=null, nlsk=' #(tobopack.GetToboCASH)', kvk=null, nlss=null, nlsa='#(nbs_ob22 (''2909'',''75''))', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_CHECK_PAYMENT(#(REF),1)', s2='F_CHECK_PAYMENT(#(REF),1)', sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MUX';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MUX';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MUX';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MUX';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MUX';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MUX';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MUX';
end;
/
commit;
