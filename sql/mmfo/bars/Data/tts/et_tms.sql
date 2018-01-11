set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции TMS
prompt Наименование операции: TMS 5) # TMK/STOP-правило для прод/пок БМ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TMS', 'TMS 5) # TMK/STOP-правило для прод/пок БМ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_BMK(#(REF),#(S),#(KVA)) ', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='TMS', name='TMS 5) # TMK/STOP-правило для прод/пок БМ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_BMK(#(REF),#(S),#(KVA)) ', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='TMS';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='TMS';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='TMS';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='TMS';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='TMS';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='TMS';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='TMS';
  begin
    insert into folders_tts(idfo, tt)
    values (77, 'TMS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 77, ''TMS'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
