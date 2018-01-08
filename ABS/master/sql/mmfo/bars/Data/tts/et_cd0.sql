set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CD0
prompt Наименование операции: CD0 (доч.CDS) Комісія агента за прийом переказу WU/РФ/ком(12 годин)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CD0', 'CD0 (доч.CDS) Комісія агента за прийом переказу WU/РФ/ком(12 годин)', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''2909'',''27''))', 643, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(133,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(133,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', 5, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CD0', name='CD0 (доч.CDS) Комісія агента за прийом переказу WU/РФ/ком(12 годин)', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''27''))', kvk=643, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(133,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(133,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', sk=5, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CD0';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CD0';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CD0';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CD0';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CD0';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CD0';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CD0';
end;
/
commit;
