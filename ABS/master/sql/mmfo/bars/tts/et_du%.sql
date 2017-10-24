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
    values ('DU8', '+Позасистемний облік депозитних ліній ЮО', 1, '#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', null, '#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', null, null, null, null, null, 0, 0, 0, 0, 'case when dpu.is_line(#(REF)) is null then 0 else #(S) end', null, null, null, null, 0, '0000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU8', name='+Позасистемний облік депозитних ліній ЮО', dk=1, nlsm='#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', kv=null, nlsk='#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='case when dpu.is_line(#(REF)) is null then 0 else #(S) end', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000000000000000000000000000000000000100000000000000000000000000', nazn=null
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
prompt Создание / Обновление операции DU%
prompt Наименование операции: Нарахування відсотків
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DU%', 'Нарахування відсотків', 1, '#(dpu.get_nls4pay(-2,#(NLSA),#(KVA)))', null, null, null, null, null, null, null, 1, 0, 1, 0, null, null, null, null, '#(nbs_ob22_nls(''3800'',''03'',null))', 0, '0000100000000000000000000000000000000100000000000000000000000000', '#{DPU.GET_INTDETAILS(#(NLS),#(KV))} за пер_од з #(DAT1) по #(DAT2) вкл.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU%', name='Нарахування відсотків', dk=1, nlsm='#(dpu.get_nls4pay(-2,#(NLSA),#(KVA)))', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22_nls(''3800'',''03'',null))', rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='#{DPU.GET_INTDETAILS(#(NLS),#(KV))} за пер_од з #(DAT1) по #(DAT2) вкл.'
       where tt='DU%';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='DU%';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='DU%';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DU8', 'DU%', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ttsap: ''DU8'', ''DU%'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='DU%';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='DU%';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='DU%';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='DU%';
  begin
    insert into folders_tts(idfo, tt)
    values (4, 'DU%');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 4, ''DU%'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
