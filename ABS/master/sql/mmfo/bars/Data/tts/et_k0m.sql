set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K0M
prompt Наименование операции: K0M Нар.комiсії за пререрах.коштів на рах.акредит.нотаріуса
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K0M', 'K0M Нар.комiсії за пререрах.коштів на рах.акредит.нотаріуса', 1, '#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', 980, '#(BEZN_NOT_6110(#(NLSA))) ', 980, null, null, null, null, 0, 0, 0, 0, '0.2*#(S)', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K0M', name='K0M Нар.комiсії за пререрах.коштів на рах.акредит.нотаріуса', dk=1, nlsm='#(nbs_ob22_RNK (''3570'',''34'',#(NLSB),980))', kv=980, nlsk='#(BEZN_NOT_6110(#(NLSA))) ', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='0.2*#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K0M';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K0M';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K0M';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K0M';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K0M';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K0M';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K0M';
end;
/
commit;
