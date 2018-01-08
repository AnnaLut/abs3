set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции D3I
prompt Наименование операции: D: Визнання доходу на суму нестачі готівки в IВ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D3I', 'D: Визнання доходу на суму нестачі готівки в IВ', 1, '#(nbs_ob22 (''3552'',''01''))', null, '#(nbs_ob22 (''6399'',''D2''))', 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', 'Визнання доходу на суму нестачі готівки в IВ ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='D3I', name='D: Визнання доходу на суму нестачі готівки в IВ', dk=1, nlsm='#(nbs_ob22 (''3552'',''01''))', kv=null, nlsk='#(nbs_ob22 (''6399'',''D2''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='Визнання доходу на суму нестачі готівки в IВ '
       where tt='D3I';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='D3I';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='D3I';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='D3I';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='D3I';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='D3I';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='D3I';
end;
/
commit;
