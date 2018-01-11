set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 8K2
prompt Наименование операции: 8K2 d: Комісія за приймання бюджетних платежів від фізичних осіб
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('8K2', '8K2 d: Комісія за приймання бюджетних платежів від фізичних осіб', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(nbs_ob22 (''6510'',''24''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(50, #(KVA),#(NLSA), #(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='8K2', name='8K2 d: Комісія за приймання бюджетних платежів від фізичних осіб', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(nbs_ob22 (''6510'',''24''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(50, #(KVA),#(NLSA), #(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='8K2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='8K2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='8K2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='8K2';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='8K2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='8K2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='8K2';
end;
/
commit;
