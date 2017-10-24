set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции !20
prompt Наименование операции: !20 Нарах.ПДФО на суму безн.заборгов.за кредит. відшкод.за рах. резерв
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!20', '!20 Нарах.ПДФО на суму безн.заборгов.за кредит. відшкод.за рах. резерв', 1, '#(nbs_ob22 (''7399'',''08''))', null, '#(nbs_ob22 (''3622'',''23''))', null, null, '#(nbs_ob22 (''7399'',''08''))', '#(nbs_ob22 (''3622'',''23''))', null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!20', name='!20 Нарах.ПДФО на суму безн.заборгов.за кредит. відшкод.за рах. резерв', dk=1, nlsm='#(nbs_ob22 (''7399'',''08''))', kv=null, nlsk='#(nbs_ob22 (''3622'',''23''))', kvk=null, nlss=null, nlsa='#(nbs_ob22 (''7399'',''08''))', nlsb='#(nbs_ob22 (''3622'',''23''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!20';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='!20';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='!20';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='!20';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3622', '!20', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''3622'', ''!20'', 1) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('7399', '!20', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''7399'', ''!20'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='!20';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='!20';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='!20';
end;
/
commit;
