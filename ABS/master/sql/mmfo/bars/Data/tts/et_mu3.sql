set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции MU3
prompt Наименование операции: --Комісія*24% * 70%
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU3', '--Комісія*24% * 70%', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.70,0)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU3', name='--Комісія*24% * 70%', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.70,0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU3';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='MU3';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='MU3';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='MU3';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='MU3';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='MU3';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='MU3';
end;
/
commit;
