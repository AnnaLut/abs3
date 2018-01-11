set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MU1
prompt Наименование операции: MU1 --Комісія в грн 100%
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU1', 'MU1 --Комісія в грн 100%', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(F_TARIF_MGE(#(S)),0)', null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU1', name='MU1 --Комісія в грн 100%', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(F_TARIF_MGE(#(S)),0)', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU1';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MU1';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MU1';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MU1';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MU1';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MU1';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MU1';
  begin
    insert into folders_tts(idfo, tt)
    values (11, 'MU1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 11, ''MU1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
prompt Создание / Обновление операции MU2
prompt Наименование операции: MU2 --Комісія 76%2902(ГРН)-2902(ВАЛ)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU2', 'MU2 --Комісія 76%2902(ГРН)-2902(ВАЛ)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(F_TARIF_MGE(#(S)),0)*0.76', null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU2', name='MU2 --Комісія 76%2902(ГРН)-2902(ВАЛ)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(F_TARIF_MGE(#(S)),0)*0.76', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MU2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MU2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MU2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MU2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MU2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MU2';
end;
/
prompt Создание / Обновление операции MU3
prompt Наименование операции: MU3 --Комісія*24% * 70%
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU3', 'MU3 --Комісія*24% * 70%', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.70,0)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU3', name='MU3 --Комісія*24% * 70%', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.70,0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MU3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MU3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MU3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MU3';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MU3';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MU3';
end;
/
prompt Создание / Обновление операции MU4
prompt Наименование операции: MU4 --Комісія*24% * 30% Головного офісу
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU4', 'MU4 --Комісія*24% * 30% Головного офісу', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.30,0)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU4', name='MU4 --Комісія*24% * 30% Головного офісу', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.30,0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MU4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MU4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MU4';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MU4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MU4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MU4';
end;
/
prompt Создание / Обновление операции MU0
prompt Наименование операции: MU0 --Прийом готівки
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU0', 'MU0 --Прийом готівки', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', 978, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU0', name='MU0 --Прийом готівки', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', kvk=978, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU0';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MU0';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MU0';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU1', 'MU0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''MU1'', ''MU0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU2', 'MU0', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''MU2'', ''MU0'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU3', 'MU0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''MU3'', ''MU0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU4', 'MU0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''MU4'', ''MU0'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MU0';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MU0';
  begin
    insert into tts_vob(vob, tt, ord)
    values (300, 'MU0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 300, ''MU0'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MU0';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'MU0', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''MU0'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MU0';
  begin
    insert into folders_tts(idfo, tt)
    values (11, 'MU0');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 11, ''MU0'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
