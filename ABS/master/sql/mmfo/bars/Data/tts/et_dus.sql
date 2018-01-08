set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DU8
prompt Наименование операции: +Позасистемний облік депозитних ліній ЮО
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DU8', '+Позасистемний облік депозитних ліній ЮО', 1, '#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', null, '#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', null, null, null, null, null, 0, 0, 0, 0, 'case when dpu.is_line(#(REF)) is null then 0 else #(S) end', null, null, null, null, 0, '1000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU8', name='+Позасистемний облік депозитних ліній ЮО', dk=1, nlsm='#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', kv=null, nlsk='#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='case when dpu.is_line(#(REF)) is null then 0 else #(S) end', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='1000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DU8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DU8';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DU8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DU8';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('8   ', 'DU8', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''8   '', ''DU8'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('8   ', 'DU8', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''8   '', ''DU8'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DU8';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DU8';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DU8';
end;
/
prompt Создание / Обновление операции DUS
prompt Наименование операции: DUS Стягнення штрафу за дострокове розірвання договору
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DUS', 'DUS Стягнення штрафу за дострокове розірвання договору', 1, null, null, null, null, null, null, null, null, 1, 0, 1, 0, null, null, null, null, '#(nbs_ob22_nls(''3800'',''03'',null))', 9, '0000100000000000000000000000000000010000000000000000000000000000', 'Повернення нарахованих відсотків по депозиту при достроковому розірванні  #{DPU.F_NAZN(''U_D'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DUS', name='DUS Стягнення штрафу за дострокове розірвання договору', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22_nls(''3800'',''03'',null))', rang=9, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn='Повернення нарахованих відсотків по депозиту при достроковому розірванні  #{DPU.F_NAZN(''U_D'',#(ND))}'
       where tt='DUS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DUS';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DUS', 'O', 0, 2, '5', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''DUS'', ''O'', 0, 2, ''5'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ND   ', 'DUS', 'M', 0, 1, '0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''ND   '', ''DUS'', ''M'', 0, 1, ''0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DUS';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DU8', 'DUS', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''DU8'', ''DUS'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DUS';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DUS';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DUS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''DUS'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'DUS', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 16, ''DUS'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DUS';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DUS', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''DUS'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DUS';
  begin
    insert into folders_tts(idfo, tt)
    values (4, 'DUS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 4, ''DUS'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
