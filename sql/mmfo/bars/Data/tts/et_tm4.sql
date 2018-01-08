set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции TM4
prompt Наименование операции: TM4 5) # TM4 - доч до TMK
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TM4', 'TM4 5) # TM4 - доч до TMK', 0, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(#(S)*(SELECT DECODE(NVL(VES_UN,0),0, VES/31.1034807, VES_UN )FROM V_BANK_METALS_BRANCH B,OPERW W WHERE W.REF=#(REF) AND W.TAG=''N_BMK'' AND W.VALUE=N_BMK(B.KOD)),0)', '(#(S)/100)*(select cena_k from v_bank_metals_branch b, operw w where w.ref=#(REF) and w.tag=''N_BMK'' and w.value=N_BMK(b.kod))', 30, null, '#(nbs_ob22 (''3800'',''09''))', null, '0000100001000000000000000000000000010000000000000000000000010000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='TM4', name='TM4 5) # TM4 - доч до TMK', dk=0, nlsm=null, kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(#(S)*(SELECT DECODE(NVL(VES_UN,0),0, VES/31.1034807, VES_UN )FROM V_BANK_METALS_BRANCH B,OPERW W WHERE W.REF=#(REF) AND W.TAG=''N_BMK'' AND W.VALUE=N_BMK(B.KOD)),0)', s2='(#(S)/100)*(select cena_k from v_bank_metals_branch b, operw w where w.ref=#(REF) and w.tag=''N_BMK'' and w.value=N_BMK(b.kod))', sk=30, proc=null, s3800='#(nbs_ob22 (''3800'',''09''))', rang=null, flags='0000100001000000000000000000000000010000000000000000000000010000', nazn=null
       where tt='TM4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='TM4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='TM4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='TM4';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', 'TM4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1001'', ''TM4'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', 'TM4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1001'', ''TM4'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', 'TM4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1002'', ''TM4'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', 'TM4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''1002'', ''TM4'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='TM4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='TM4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='TM4';
  begin
    insert into folders_tts(idfo, tt)
    values (77, 'TM4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 77, ''TM4'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
