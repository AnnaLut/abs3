set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !1E
prompt Наименование операции: !1E Дочірня для 01E(3570/29-6110)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!1E', '!1E Дочірня для 01E(3570/29-6110)', 1, '#(nbs_ob22_RNK(''3570'',''29'',#(NLSA),980))', 980, null, 980, null, '#(nbs_ob22_RNK(''3570'',''29'',#(NLSA),980))', null, null, 0, 0, 0, 0, '#(S)', null, null, null, null, null, '0000000000000000000000000011000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!1E', name='!1E Дочірня для 01E(3570/29-6110)', dk=1, nlsm='#(nbs_ob22_RNK(''3570'',''29'',#(NLSA),980))', kv=980, nlsk=null, kvk=980, nlss=null, nlsa='#(nbs_ob22_RNK(''3570'',''29'',#(NLSA),980))', nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000011000000000000000000000000000000000000', nazn=null
       where tt='!1E';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!1E';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!1E';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!1E';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!1E';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!1E';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!1E';
end;
/
commit;
