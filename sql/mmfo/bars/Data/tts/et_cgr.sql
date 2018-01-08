set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CGR
prompt Наименование операции: CGR (доч.CG6) Комісія банку за прийом переказу по системі "MoneyGram"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CGR', 'CGR (доч.CG6) Комісія банку за прийом переказу по системі "MoneyGram"', 1, '#(nbs_ob22 (''2909'',''70''))', 980, '#(nbs_ob22 (''6510'',''B7''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(87,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.75*(GL.P_ICURVAL(#(KVA),F_TARIF(87,#(KVA),#(NLSA),#(S)),SYSDATE)))', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CGR', name='CGR (доч.CG6) Комісія банку за прийом переказу по системі "MoneyGram"', dk=1, nlsm='#(nbs_ob22 (''2909'',''70''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B7''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(87,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.75*(GL.P_ICURVAL(#(KVA),F_TARIF(87,#(KVA),#(NLSA),#(S)),SYSDATE)))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CGR';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CGR';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CGR';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CGR';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CGR';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CGR';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CGR', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CGR'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CGR', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CGR'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CGR';
end;
/
commit;
