set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции T2P
prompt Наименование операции: T2P:ПДВ до TMP
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('T2P', 'T2P:ПДВ до TMP', 1, '#( nbs_vp (''3800'',''09'',#(KVA)) )', 980, '#( nbs_ob22 (''3622'',''51'') )', 980, null, null, null, null, 0, 0, 0, 0, '#(BM__K)*ROUND(#(BM__R)*100/6)*#(PDV)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', '#(BM__K)*ROUND(#(BM__R)*100/6)*#(BMPDV)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='T2P', name='T2P:ПДВ до TMP', dk=1, nlsm='#( nbs_vp (''3800'',''09'',#(KVA)) )', kv=980, nlsk='#( nbs_ob22 (''3622'',''51'') )', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(BM__K)*ROUND(#(BM__R)*100/6)*#(PDV)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='#(BM__K)*ROUND(#(BM__R)*100/6)*#(BMPDV)'
       where tt='T2P';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='T2P';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='T2P';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='T2P';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='T2P';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='T2P';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='T2P';
end;
/
commit;
