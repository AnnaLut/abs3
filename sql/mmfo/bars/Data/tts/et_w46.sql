set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции W46
prompt Наименование операции: W46 дочірня для W4O (міжбанк)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W46', 'W46 дочірня для W4O (міжбанк)', 1, null, null, '#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='W46', name='W46 дочірня для W4O (міжбанк)', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''20'',(get_proc_nls(''T00'',#(KVA))),#(NLSA),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='W46';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='W46';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='W46';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='W46';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='W46';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='W46';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='W46';
end;
/
commit;
