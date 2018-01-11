set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K32
prompt Наименование операции: K32 d: Комісія за ІНКАСО (A16)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K32', 'K32 d: Комісія за ІНКАСО (A16)', 1, '#(nbs_ob22 (''6514'',''10''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_SUMQ(95, #(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0000100001000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K32', name='K32 d: Комісія за ІНКАСО (A16)', dk=1, nlsm='#(nbs_ob22 (''6514'',''10''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_SUMQ(95, #(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100001000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K32';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K32';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K32';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K32';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K32';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K32';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K32';
end;
/
commit;
