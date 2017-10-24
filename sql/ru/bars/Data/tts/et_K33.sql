set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K33
prompt Наименование операции: d Комісія за ІНКАСО (025)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K33', 'd Комісія за ІНКАСО (025)', 1, '#(nbs_ob22 (''6114'',''10''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_SUMQ( 91, #(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0100100001000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K33', name='d Комісія за ІНКАСО (025)', dk=1, nlsm='#(nbs_ob22 (''6114'',''10''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_SUMQ( 91, #(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0100100001000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K33';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K33';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K33';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K33';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K33';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K33';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K33';
end;
/
commit;
