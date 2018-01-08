set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CC0
prompt Наименование операции: CC0 (доч.CA0) Комісія банку за прийом переказу для “INTEREXPRESS”
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CC0', 'CC0 (доч.CA0) Комісія банку за прийом переказу для “INTEREXPRESS”', 1, '#(nbs_ob22 (''2909'',''42''))', 980, '#(nbs_ob22 (''6510'',''82''))', 980, null, null, null, null, 0, 0, 0, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(45,#(KVA),#(NLSA),#(S)),SYSDATE))/3', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CC0', name='CC0 (доч.CA0) Комісія банку за прийом переказу для “INTEREXPRESS”', dk=1, nlsm='#(nbs_ob22 (''2909'',''42''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''82''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(45,#(KVA),#(NLSA),#(S)),SYSDATE))/3', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CC0';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CC0';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CC0';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CC0';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CC0';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CC0';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CC0', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CC0'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CC0', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CC0'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CC0';
end;
/
commit;
