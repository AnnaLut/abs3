set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KD3
prompt Наименование операции: Комiсiя за перерахування суми вкладу за товари та послуги
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD3', 'Комiсiя за перерахування суми вкладу за товари та послуги', 1, null, null, '#(nbs_ob22 (''6510'',''10''))', null, null, null, '#(nbs_ob22 (''6510'',''10''))', null, 0, 0, 0, 0, 'F_TARIF(3, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KD3', name='Комiсiя за перерахування суми вкладу за товари та послуги', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6510'',''10''))', kvk=null, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''6510'',''10''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(3, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KD3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KD3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KD3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KD3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KD3';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KD3';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KD3';
end;
/
commit;
