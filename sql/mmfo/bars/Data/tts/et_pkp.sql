set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции PKP
prompt Наименование операции: д) Операції з БПК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PKP', 'д) Операції з БПК', 1, '#(bpk_get_transit(#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, null, null, 0, 0, 0, 0, 'CASE WHEN SUBSTR(TO_CHAR(#(NLSA)),1,4)=''2924'' THEN 0 WHEN SUBSTR(TO_CHAR(#(NLSB)),1,4)=''2924'' THEN 0 ELSE #(S) END', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PKP', name='д) Операції з БПК', dk=1, nlsm='#(bpk_get_transit(#(NLSA),#(NLSB),#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CASE WHEN SUBSTR(TO_CHAR(#(NLSA)),1,4)=''2924'' THEN 0 WHEN SUBSTR(TO_CHAR(#(NLSB)),1,4)=''2924'' THEN 0 ELSE #(S) END', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='PKP';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='PKP';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='PKP';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='PKP';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='PKP';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='PKP';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='PKP';
end;
/
commit;
