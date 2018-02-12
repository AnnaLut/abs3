set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !!D
prompt Наименование операции: STOP правило на перевірку поповнення депозиту за період
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!D', 'STOP правило на поповн деп за період', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(''1478'',#(KVA),#(NLSB),#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!D', name='STOP правило на поповн деп за період', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(''1478'',#(KVA),#(NLSB),#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!D';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!!D';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!!D';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!!D';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!!D';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!!D';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!!D';
end;
/
commit;
