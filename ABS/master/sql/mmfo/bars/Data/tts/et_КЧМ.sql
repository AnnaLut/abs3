set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции КЧМ
prompt Наименование операции: КЧМ Комісія за ЧЕК (монети)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('КЧМ', 'КЧМ Комісія за ЧЕК (монети)', 1, null, 980, '#(nbs_ob22 (''6110'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'f_monet_tar(111,F_DOP(#(REF), (''M_1'')),F_DOP(#(REF), (''M_2'')),F_DOP(#(REF), (''M_5'')),F_DOP(#(REF), (''M_10'')),F_DOP(#(REF), (''M_25'')),F_DOP(#(REF), (''M_50'')))', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', ' Комісія за виплату монет по чеку ЮО');
  exception
    when dup_val_on_index then 
      update tts
         set tt='КЧМ', name='КЧМ Комісія за ЧЕК (монети)', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6110'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_monet_tar(111,F_DOP(#(REF), (''M_1'')),F_DOP(#(REF), (''M_2'')),F_DOP(#(REF), (''M_5'')),F_DOP(#(REF), (''M_10'')),F_DOP(#(REF), (''M_25'')),F_DOP(#(REF), (''M_50'')))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=' Комісія за виплату монет по чеку ЮО'
       where tt='КЧМ';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='КЧМ';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='КЧМ';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='КЧМ';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='КЧМ';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, 'КЧМ', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 23, ''КЧМ'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='КЧМ';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='КЧМ';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'КЧМ');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''КЧМ'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
