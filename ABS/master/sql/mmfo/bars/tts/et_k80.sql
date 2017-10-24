set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K80
prompt Наименование операции: d: Комісія за миттєве ІНКАСО (150)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K80', 'd: Комісія за миттєве ІНКАСО (150)', 0, null, 980, '#(nbs_ob22 (''6114'',''10''))', 980, null, null, null, null, 0, 0, 1, 0, 'F_TARIF(96,980,#(NLSA),GL.P_ICURVAL(#(KVA),#(S),SYSDATE)) ', null, 5, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K80', name='d: Комісія за миттєве ІНКАСО (150)', dk=0, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6114'',''10''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='F_TARIF(96,980,#(NLSA),GL.P_ICURVAL(#(KVA),#(S),SYSDATE)) ', s2=null, sk=5, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='K80';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K80';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K80';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K80';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K80';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K80';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K80';
end;
/
commit;
