set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции SM6
prompt Наименование операции: SM6-Сплата комісії за перерахування платежів з оплати комунальних послуг
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SM6', 'Сплата комісії за перерахування платежів з оплати ком.послуг', 1, '#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', 'Сплата комісії за перерахування платежів з оплати ком.послуг');
  exception
    when dup_val_on_index then 
      update tts
         set tt='SM6', name='Сплата комісії за перерахування платежів з оплати ком.послуг', dk=1, nlsm='#(bpk_get_transit(''20'',#(NLSB),#(NLSA),#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn='Сплата комісії за перерахування платежів з оплати ком.послуг'
       where tt='SM6';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='SM6';  
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='SM6';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='SM6';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3570', 'SM6', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3570'', ''SM6'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;  
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'SM6', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2620'', ''SM6'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;    
  begin
    insert into ps_tts(nbs, tt, dk, ob22)
    values ('2924', 'SM6', 1, '23');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2924'', ''SM6'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='SM6';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SM6', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''SM6'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='SM6';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (30, 'SM6', 3, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 30, ''SM6'', 3, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'SM6', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (chklist_tts: 11, ''SM6'', 3, null, null, null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='SM6';
  
end;
/
commit;

MERGE INTO BARS.OW_MSGCODE A USING
 (SELECT
  'PAYCOM' as MSGCODE,
  0 as DK,
  'PZBACA' as SYNTHCODE
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
  '20' as TRAN_TYPE,
  'SM6' as TT,
  0 as DK,
  'PAYCOM' as W4_MSGCODE,
  0 as PAY_FLAG
  FROM DUAL) B
ON (A.TT = B.TT and A.DK = B.DK)
WHEN NOT MATCHED THEN 
INSERT (
  TRAN_TYPE, TT, DK, W4_MSGCODE, PAY_FLAG)
VALUES (
  B.TRAN_TYPE, B.TT, B.DK, B.W4_MSGCODE, B.PAY_FLAG);

COMMIT;