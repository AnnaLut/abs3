set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K13
prompt Наименование операции: K13/VPS (д) Комісія за (CFB)Вал. Закорд.переказ(зг тар 30)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K13', 'K13/VPS (д) Комісія за (CFB)Вал. Закорд.переказ(зг тар 30)', 1, null, null, '#(nbs_ob22 (''6114'',''06''))', 980, null, null, null, null, 0, 0, 1, 0, 'F_TARIF(30,#(KVA),#(NLSA),#(NOM))', null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000100000000100000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K13', name='K13/VPS (д) Комісія за (CFB)Вал. Закорд.переказ(зг тар 30)', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6114'',''06''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='F_TARIF(30,#(KVA),#(NLSA),#(NOM))', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000100000000100000000000000000', nazn=null
       where tt='K13';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K13';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K13';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K13';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K13';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K13';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K13';
end;
/
commit;
