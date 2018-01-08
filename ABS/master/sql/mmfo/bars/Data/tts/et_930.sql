set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 930
prompt Наименование операции: 930d (дочірня до операції 430)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('930', '930d (дочірня до операції 430)', 1, '#(get_nls_tt(''930'',''NLSM'',p_nlsb=>#(NLSB),p_kvb=>#(KVB)))', null, '#(nbs_ob22 (''9910'',''01''))', null, null, null, null, null, 0, 0, 0, 1, null, null, null, null, null, null, '0101100000000000000000000000000000010000000000000000000000000000', 'Списання безнадійної заборгованості за кредитними операціями  за рахунок спец.резерву');
  exception
    when dup_val_on_index then 
      update tts
         set tt='930', name='930d (дочірня до операції 430)', dk=1, nlsm='#(get_nls_tt(''930'',''NLSM'',p_nlsb=>#(NLSB),p_kvb=>#(KVB)))', kv=null, nlsk='#(nbs_ob22 (''9910'',''01''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101100000000000000000000000000000010000000000000000000000000000', nazn='Списання безнадійної заборгованості за кредитними операціями  за рахунок спец.резерву'
       where tt='930';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='930';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='930';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='930';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='930';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='930';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='930';
end;
/
commit;
