set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 120
prompt Наименование операции: 120  Комісія за купівлю ДОРОЖНІХ ЧЕКІВ 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('120', '120  Комісія за купівлю ДОРОЖНІХ ЧЕКІВ ', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''6510'',''A9''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(34,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='120', name='120  Комісія за купівлю ДОРОЖНІХ ЧЕКІВ ', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''6510'',''A9''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(34,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='120';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='120';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='120';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='120';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='120';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='120';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='120';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '120');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 21, ''120'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
