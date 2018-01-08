set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CDJ
prompt Наименование операции: CDJ (доч.CAJ) Комісія агента за прийом переказу по сист."CONTACT"(Даль
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDJ', 'CDJ (доч.CAJ) Комісія агента за прийом переказу по сист."CONTACT"(Даль', 1, '#(nbs_ob22 (''2909'',''64''))', 980, '#(nbs_ob22 (''2909'',''64''))', 840, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(68,#(KVA),#(NLSA),#(S)),SYSDATE))*(2/3)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(68,#(KVA),#(NLSA),#(S)),bankdate))*(2/3),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDJ', name='CDJ (доч.CAJ) Комісія агента за прийом переказу по сист."CONTACT"(Даль', dk=1, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''64''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(68,#(KVA),#(NLSA),#(S)),SYSDATE))*(2/3)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(68,#(KVA),#(NLSA),#(S)),bankdate))*(2/3),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDJ';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CDJ';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CDJ';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CDJ';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CDJ';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CDJ';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CDJ';
end;
/
commit;
