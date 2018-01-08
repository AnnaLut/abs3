set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CDK
prompt Наименование операции: CDK (доч.CDH) Комісія агента за прийом переказу WU/ЄС/ком(Терміновий)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDK', 'CDK (доч.CDH) Комісія агента за прийом переказу WU/ЄС/ком(Терміновий)', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''2909'',''27''))', 978, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', 5, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDK', name='CDK (доч.CDH) Комісія агента за прийом переказу WU/ЄС/ком(Терміновий)', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''27''))', kvk=978, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', sk=5, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDK';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CDK';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CDK';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CDK';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CDK';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CDK';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CDK';
end;
/
commit;
