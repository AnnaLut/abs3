set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции G0H
prompt Наименование операции: G0H Погаш.нарах.комiсiї за ЧЕК
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G0H', 'G0H Погаш.нарах.комiсiї за ЧЕК', 1, '#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G0H', name='G0H Погаш.нарах.комiсiї за ЧЕК', dk=1, nlsm='#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='G0H';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='G0H';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='G0H';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='G0H';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='G0H';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='G0H';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='G0H';
end;
/
commit;
