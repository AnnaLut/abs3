set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K0N
prompt Наименование операции: K0N Нарах.комiсiї за внесення гот. на рах.акред.нотаріуса
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K0N', 'K0N Нарах.комiсiї за внесення гот. на рах.акред.нотаріуса', 0, '#(nbs_ob22_RNK (''3570'',''34'',#(NLSA),980))', 980, '#(NAL_NOT_6110(F_DOP(#(REF),''VIDBZ''))) ', 980, null, null, null, null, 0, 0, 0, 0, '0.2*#(S)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K0N', name='K0N Нарах.комiсiї за внесення гот. на рах.акред.нотаріуса', dk=0, nlsm='#(nbs_ob22_RNK (''3570'',''34'',#(NLSA),980))', kv=980, nlsk='#(NAL_NOT_6110(F_DOP(#(REF),''VIDBZ''))) ', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='0.2*#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K0N';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K0N';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K0N';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K0N';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K0N';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K0N';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K0N';
end;
/
commit;
