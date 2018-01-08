set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K0H
prompt Наименование операции: K0H Нарах. 3570 комiсiї за ЧЕК 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K0H', 'K0H Нарах. 3570 комiсiї за ЧЕК ', 1, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22 (''6110'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K0H', name='K0H Нарах. 3570 комiсiї за ЧЕК ', dk=1, nlsm='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22 (''6110'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA),  F_DOP(#(REF),''PR068'')*#(S)/100,  SYSDATE )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K0H';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K0H';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K0H';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K0H';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'K0H', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''K0H'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K0H';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K0H';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K0H';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K0H');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K0H'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
