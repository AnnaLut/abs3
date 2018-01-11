set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K61
prompt Наименование операции: K61 Комісія за виплату переказів із-за кордону в ІВ готівкою
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K61', 'K61 Комісія за виплату переказів із-за кордону в ІВ готівкою', 0, '#(nbs_ob22 (''6514'',''15''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(61,#(KVA),#(NLSA),#(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', 'Комісія за виплату переказів із-за кордону в ІВ готівкою');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K61', name='K61 Комісія за виплату переказів із-за кордону в ІВ готівкою', dk=0, nlsm='#(nbs_ob22 (''6514'',''15''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(61,#(KVA),#(NLSA),#(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='Комісія за виплату переказів із-за кордону в ІВ готівкою'
       where tt='K61';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K61';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K61';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K61';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K61';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K61';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K61';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K61');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K61'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
