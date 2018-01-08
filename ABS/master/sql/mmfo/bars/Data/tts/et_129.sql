set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 129
prompt Наименование операции: 129 Комісія за продаж ДОРОЖНІХ ЧЕКІВ (135)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('129', '129 Комісія за продаж ДОРОЖНІХ ЧЕКІВ (135)', 1, '#(nbs_ob22 (''6510'',''A8''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA), F_TARIF (48, #(KVA), #(NLSA), #(S) ), SYSDATE)', null, null, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='129', name='129 Комісія за продаж ДОРОЖНІХ ЧЕКІВ (135)', dk=1, nlsm='#(nbs_ob22 (''6510'',''A8''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA), F_TARIF (48, #(KVA), #(NLSA), #(S) ), SYSDATE)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='129';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='129';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='129';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='129';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='129';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='129';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='129';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '129');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''129'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
