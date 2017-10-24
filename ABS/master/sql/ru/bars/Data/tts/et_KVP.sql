set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции KVP
prompt Наименование операции: (доч.CVS,CVO,CVB,CFS,CFO,CFB)Ком.за пр.гот.перек.SWIFT(VIP)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KVP', '(доч.CVS,CVO,CVB,CFS,CFO,CFB)Ком.за пр.гот.перек.SWIFT(VIP)', 0, '#(nbs_ob22 (''6114'',''14''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_VIP(#(REF),300,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KVP', name='(доч.CVS,CVO,CVB,CFS,CFO,CFB)Ком.за пр.гот.перек.SWIFT(VIP)', dk=0, nlsm='#(nbs_ob22 (''6114'',''14''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_VIP(#(REF),300,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KVP';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='KVP';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='KVP';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KVP';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='KVP';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='KVP';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='KVP';
end;
/
commit;
