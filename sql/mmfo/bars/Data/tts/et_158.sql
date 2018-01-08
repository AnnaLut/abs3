set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 158
prompt Наименование операции: 158 Комісія за прийом іменних чеків EUR
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('158', '158 Комісія за прийом іменних чеків EUR', 1, '#(nbs_ob22 (''6510'',''B0''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(90,#(KVA),#(NLSA),#(S))', null, 5, null, '#(tobopack.GetTOBOParam(''VP_10''))', null, '0100100000000000000000000000000000000000000000000000000000000000', 'Комісія по сплаті іменних чеків');
  exception
    when dup_val_on_index then 
      update tts
         set tt='158', name='158 Комісія за прийом іменних чеків EUR', dk=1, nlsm='#(nbs_ob22 (''6510'',''B0''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(90,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800='#(tobopack.GetTOBOParam(''VP_10''))', rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn='Комісія по сплаті іменних чеків'
       where tt='158';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='158';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='158';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='158';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', '158', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1001'', ''158'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', '158', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1002'', ''158'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6110', '158', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6110'', ''158'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('6510', '158', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''6510'', ''158'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='158';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='158';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='158';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '158');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''158'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
