set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KTO
prompt Наименование операции: KTO d: Комісія за приймання бюджетних платежів від фізичних осіб
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KTO', 'KTO d: Комісія за приймання бюджетних платежів від фізичних осіб', 1, '#(nbs_ob22 (''6510'',''24''))', 980, '#(nbs_ob22 (''2902'',''01''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(50, #(KVA),#(NLSA), #(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KTO', name='KTO d: Комісія за приймання бюджетних платежів від фізичних осіб', dk=1, nlsm='#(nbs_ob22 (''6510'',''24''))', kv=980, nlsk='#(nbs_ob22 (''2902'',''01''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(50, #(KVA),#(NLSA), #(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='KTO';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KTO';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KTO';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KTO';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KTO';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KTO';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KTO';
end;
/
commit;
