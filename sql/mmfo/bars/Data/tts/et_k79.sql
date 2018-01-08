set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K79
prompt Наименование операции: K79 Комісія за виплату переказів від "Claims conference ceef"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K79', 'K79 Комісія за виплату переказів від "Claims conference ceef"', 0, '#(nbs_ob22 (''6514'',''26''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(79,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', 'Комісія за виплату переказів із-за кордону в ІВ готівкою');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K79', name='K79 Комісія за виплату переказів від "Claims conference ceef"', dk=0, nlsm='#(nbs_ob22 (''6514'',''26''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(79,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='Комісія за виплату переказів із-за кордону в ІВ готівкою'
       where tt='K79';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K79';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K79';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K79';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K79';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K79';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K79';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K79');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K79'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
