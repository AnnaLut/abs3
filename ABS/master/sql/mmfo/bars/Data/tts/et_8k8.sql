set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 8K8
prompt Наименование операции: 8K8 d: Комісія за переказ гот. з ФО за пог.кред. в ін. уст. ОБ(доч до 
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('8K8', '8K8 d: Комісія за переказ гот. з ФО за пог.кред. в ін. уст. ОБ(доч до ', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''6510'',''26''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(140, #(KVA),#(NLSA), #(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='8K8', name='8K8 d: Комісія за переказ гот. з ФО за пог.кред. в ін. уст. ОБ(доч до ', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''6510'',''26''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(140, #(KVA),#(NLSA), #(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='8K8';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='8K8';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='8K8';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='8K8';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='8K8';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='8K8';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='8K8';
  begin
    insert into folders_tts(idfo, tt)
    values (2, '8K8');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''8K8'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
