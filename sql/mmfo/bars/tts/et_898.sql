set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 898
prompt Наименование операции: 898 - "ФОНД" SWIFT через Commerzbank
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('898', '898 - "ФОНД" SWIFT через Commerzbank', 1, '3739401901', 978, '150072188', 978, null, '3739401901', '150072188', '300465', 0, 0, 0, 0, '#(S)-F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,10000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='898', name='898 - "ФОНД" SWIFT через Commerzbank', dk=1, nlsm='3739401901', kv=978, nlsk='150072188', kvk=978, nlss=null, nlsa='3739401901', nlsb='150072188', mfob='300465', flc=0, fli=0, flv=0, flr=0, s='#(S)-F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,10000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='898';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='898';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='898';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='898';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='898';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='898';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='898';
end;
/
commit;
