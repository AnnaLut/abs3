set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 128
prompt Наименование операции: 128  Комісія за купівлю ДОРОЖНІХ ЧЕКІВ (устан.Ощадбанку)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('128', '128  Комісія за купівлю ДОРОЖНІХ ЧЕКІВ (устан.Ощадбанку)', 0, '#(tobopack.GetToboParam(''CASH''))', 980, '#(nbs_ob22 (''6510'',''A9''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(35,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='128', name='128  Комісія за купівлю ДОРОЖНІХ ЧЕКІВ (устан.Ощадбанку)', dk=0, nlsm='#(tobopack.GetToboParam(''CASH''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''A9''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(35,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='128';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='128';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='128';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='128';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='128';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='128';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='128';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '128');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''128'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
