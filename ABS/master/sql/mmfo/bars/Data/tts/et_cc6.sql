set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CC6
prompt Наименование операции: CC6 (доч.CA6) Комісія банку за прийом переказу для BLIZKO
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CC6', 'CC6 (доч.CA6) Комісія банку за прийом переказу для BLIZKO', 1, '#(nbs_ob22 (''2909'',''58''))', 980, '#(nbs_ob22 (''6510'',''A2''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(41,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND((GL.P_ICURVAL(#(KVA),F_TARIF(41,#(KVA),#(NLSA),#(S))*0.6,SYSDATE)))', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CC6', name='CC6 (доч.CA6) Комісія банку за прийом переказу для BLIZKO', dk=1, nlsm='#(nbs_ob22 (''2909'',''58''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''A2''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(41,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND((GL.P_ICURVAL(#(KVA),F_TARIF(41,#(KVA),#(NLSA),#(S))*0.6,SYSDATE)))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CC6';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CC6';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CC6';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CC6';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CC6';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CC6';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CC6', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CC6'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CC6', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CC6'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CC6';
end;
/
commit;
