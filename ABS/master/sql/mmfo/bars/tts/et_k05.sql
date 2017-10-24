set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K05
prompt Наименование операции: К05 Комiсiя за приймання готiвки
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K05', 'К05 Комiсiя за приймання готiвки', 0, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', 980, '#(nbs_ob22 (''6110'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(Case WHEN #(S)<=500000 THEN 31 Else 331 END,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K05', name='К05 Комiсiя за приймання готiвки', dk=0, nlsm='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),980))', kv=980, nlsk='#(nbs_ob22 (''6110'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(Case WHEN #(S)<=500000 THEN 31 Else 331 END,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K05';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K05';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K05';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K05';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K05';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K05';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K05';
end;
/
commit;
