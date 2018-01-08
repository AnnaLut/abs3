set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CDM
prompt Наименование операции: CDM (доч.CDH) Комісія банку за прийом переказу  WU/ЄС/ком(Терміновий)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDM', 'CDM (доч.CDH) Комісія банку за прийом переказу  WU/ЄС/ком(Терміновий)', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''6510'',''75''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.776*(GL.P_ICURVAL(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),SYSDATE)))', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDM', name='CDM (доч.CDH) Комісія банку за прийом переказу  WU/ЄС/ком(Терміновий)', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''75''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.776*(GL.P_ICURVAL(#(KVA),F_TARIF(135,#(KVA),#(NLSA),#(S)),SYSDATE)))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDM';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CDM';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CDM';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CDM';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CDM';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CDM';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CDM', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CDM'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CDM', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CDM'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CDM';
end;
/
commit;
