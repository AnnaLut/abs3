set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SM4
prompt Наименование операции: SM4-Відшкодування за надані субсидіантам послуги згідно реєстру
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SM4', 'Відшкодування за надані субсидіантам послуги згідно реєстру', 1, null, null, '#(bpk_get_transit(''10'',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '1000100000000000000000000001000000010000000000000000000000000000', 'Відшкодування за надані субсидіантам послуги згідно реєстру');
  exception
    when dup_val_on_index then 
      update tts
         set tt='SM4', name='Відшкодування за надані субсидіантам послуги згідно реєстру', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit(''10'',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1000100000000000000000000001000000010000000000000000000000000000', nazn='Відшкодування за надані субсидіантам послуги згідно реєстру'
       where tt='SM4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SM4';
  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SM4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SM4';
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2600', 'SM4', 1, '14');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''SM4'', 1, ''14'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2560', 'SM4', 0, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2560'', ''SM4'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2924', 'SM4', 0, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2924'', ''SM4'', 0, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2924', 'SM4', 1, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2924'', ''SM4'', 1, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SM4';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SM4', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SM4'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SM4';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'SM4', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 5, ''SM4'', 1, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'SM4', 2, null, 'bpk_visa30(ref, 1)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''SM4'', 2, null, ''bpk_visa30(ref, 1)=1'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SM4';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'SM4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 27, ''SM4'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;

MERGE INTO BARS.OW_MSGCODE A USING
 (SELECT
  'PAYVID' as MSGCODE,
  1 as DK,
  'PXBACA' as SYNTHCODE
  FROM DUAL) B
ON (A.MSGCODE = B.MSGCODE)
WHEN NOT MATCHED THEN 
INSERT (
  MSGCODE, DK, SYNTHCODE)
VALUES (
  B.MSGCODE, B.DK, B.SYNTHCODE);

COMMIT;

MERGE INTO BARS.OBPC_TRANS_OUT A USING
 (SELECT
  '10' as TRAN_TYPE,
  'SM4' as TT,
  1 as DK,
  'PAYVID' as W4_MSGCODE,
  0 as PAY_FLAG
  FROM DUAL) B
ON (A.TT = B.TT and A.DK = B.DK)
WHEN NOT MATCHED THEN 
INSERT (
  TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
VALUES (
  B.TRAN_TYPE, B.TT, B.DK, B.W4_MSGCODE, B.PAY_FLAG);

COMMIT;