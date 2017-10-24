set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K97
prompt Наименование операции: K97 Комісія за РКО Фонда соц.страху
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K97', 'K97 Комісія за РКО Фонда соц.страху', 1, null, null, null, null, null, null, '#(tobopack.GetTOBOParam(''SOC_097''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000100000000000000000', 'Плата за розрахунково-касове обслуговування Фонду соціального страхування. Без ПДВ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K97', name='K97 Комісія за РКО Фонда соц.страху', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='#(tobopack.GetTOBOParam(''SOC_097''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000100000000000000000', nazn='Плата за розрахунково-касове обслуговування Фонду соціального страхування. Без ПДВ'
       where tt='K97';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K97';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K97';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K97';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K97';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K97';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K97';
end;
/
commit;
