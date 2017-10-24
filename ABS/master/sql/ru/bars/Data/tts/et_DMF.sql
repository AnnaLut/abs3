set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции DMF
prompt Наименование операции: +Викуп нерозмінної частини Банківських металів
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DMF', '+Викуп нерозмінної частини Банківських металів', 1, null, null, null, 980, null, '#(tobopack.GetTOBOParam(''CASH11''))', '#(tobopack.GetToboCASH)', null, 0, 0, 1, 0, 'round(MOD(#(S),DECODE(#(KVA),959,20/31.1034807*1000,961,100/31.1034807*1000,1)))', 'eqv_obs(#(KVA),round(MOD(#(S),DECODE(#(KVA),959,20/31.1034807*1000,961,100/31.1034807*1000,0))),BANKDATE,0)', 56, null, '#(nbs_ob22 (''3800'',''09''))', 0, '0000100001010000000000000000000000010000000000000000000000000000', 'Викуп нерозмінного залишку при поверненні коштів згідно договору #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DMF', name='+Викуп нерозмінної частини Банківських металів', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa='#(tobopack.GetTOBOParam(''CASH11''))', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=1, flr=0, s='round(MOD(#(S),DECODE(#(KVA),959,20/31.1034807*1000,961,100/31.1034807*1000,1)))', s2='eqv_obs(#(KVA),round(MOD(#(S),DECODE(#(KVA),959,20/31.1034807*1000,961,100/31.1034807*1000,0))),BANKDATE,0)', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''09''))', rang=0, flags='0000100001010000000000000000000000010000000000000000000000000000', nazn='Викуп нерозмінного залишку при поверненні коштів згідно договору #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='DMF';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DMF';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DMF', 'O', 0, 11, '7', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''DPTOP'', ''DMF'', ''O'', 0, 11, ''7'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', 'DMF', 'O', 0, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''FIO  '', ''DMF'', ''O'', 0, 1, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KURS ', 'DMF', 'O', 0, 10, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''KURS '', ''DMF'', ''O'', 0, 10, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('POKPO', 'DMF', 'O', 0, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''POKPO'', ''DMF'', ''O'', 0, 4, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DMF';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DMF';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DMF';
  begin
    insert into tts_vob(vob, tt, ord)
    values (231, 'DMF', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 231, ''DMF'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DMF';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DMF';
end;
/
commit;
