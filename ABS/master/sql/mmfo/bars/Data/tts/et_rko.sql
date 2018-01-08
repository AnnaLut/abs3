set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции RKO
prompt Наименование операции: RKO p) RKO - Плата за РКО
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('RKO', 'RKO p) RKO - Плата за РКО', 1, null, 980, '#(nbs_ob22 (''6510'',''74''))', 980, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='RKO', name='RKO p) RKO - Плата за РКО', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6510'',''74''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000010000000000000', nazn=null
       where tt='RKO';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='RKO';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='RKO';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='RKO';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='RKO';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'RKO', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (tts_vob: 6, ''RKO'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='RKO';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='RKO';
end;
/
commit;
