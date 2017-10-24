set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CC8
prompt Наименование операции: Погашення пені готівкою
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CC8', 'Погашення пені готівкою', 1, '#(nbs_ob22 (''2909'',''46''))', 980, '#(nbs_ob22 (''6110'',''85''))', 980, null, null, null, null, 0, 0, 1, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.78*(GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)))', null, 14, null, null, null, '0000100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CC8', name='Погашення пені готівкою', dk=1, nlsm='#(nbs_ob22 (''2909'',''46''))', kv=980, nlsk='#(nbs_ob22 (''6110'',''85''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.78*(GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)))', s2=null, sk=14, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='CC8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CC8';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SN8  ', 'CC8', 'O', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''SN8  '', ''CC8'', ''O'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CC8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CC8';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CC8';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CC8';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CC8', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 2, ''CC8'', 2, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CC8', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''CC8'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CC8';
end;
/
commit;
