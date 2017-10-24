set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K2K
prompt Наименование операции: K2K:Чиста комiсiя зг.вибраного тарифу.(доч K20,K21,KC0)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K2K', 'K2K:Чиста комiсiя зг.вибраного тарифу.(доч K20,K21,KC0)', 1, '#( to_char ( RAZ_KOM_PDV ((tobopack.GetTOBOParam(''TR3739_03'')), 3 ) ) )', null, null, null, null, null, null, null, 0, 0, 0, 0, 'RAZ_KOM_PDV ( ''0'',2  ) ', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K2K', name='K2K:Чиста комiсiя зг.вибраного тарифу.(доч K20,K21,KC0)', dk=1, nlsm='#( to_char ( RAZ_KOM_PDV ((tobopack.GetTOBOParam(''TR3739_03'')), 3 ) ) )', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='RAZ_KOM_PDV ( ''0'',2  ) ', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K2K';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K2K';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K2K';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K2K';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K2K';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K2K';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K2K';
end;
/
commit;
