set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K98
prompt Наименование операции: K98 Комісія за РКО Центра зайнятості
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K98', 'K98 Комісія за РКО Центра зайнятості', 1, null, null, null, null, null, null, '#(tobopack.GetTOBOParam(''SOC_098''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000100000000000000000', 'Плата за розрахунково-касове обслуговування Центру зайнятості. Без ПДВ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K98', name='K98 Комісія за РКО Центра зайнятості', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='#(tobopack.GetTOBOParam(''SOC_098''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000100000000000000000', nazn='Плата за розрахунково-касове обслуговування Центру зайнятості. Без ПДВ'
       where tt='K98';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K98';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K98';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K98';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K98';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K98';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K98';
end;
/
commit;
