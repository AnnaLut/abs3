set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции K62
prompt Наименование операции: K62 Комiсiя за доставку готiвки "УКРПОШТI"
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K62', 'K62 Комiсiя за доставку готiвки "УКРПОШТI"', 1, '#(nbs_ob22_RNK (''3578'',''09'',#(NLSA),980))', 980, '#(nbs_ob22 (''6119'',''17''))', 980, null, null, null, null, 0, 0, 0, 0, 'case  WHEN #(KVA) = 980 THEN  F_TARIF(62, #(KVA),#(NLSA), #(S))  ELSE 0  END', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K62', name='K62 Комiсiя за доставку готiвки "УКРПОШТI"', dk=1, nlsm='#(nbs_ob22_RNK (''3578'',''09'',#(NLSA),980))', kv=980, nlsk='#(nbs_ob22 (''6119'',''17''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='case  WHEN #(KVA) = 980 THEN  F_TARIF(62, #(KVA),#(NLSA), #(S))  ELSE 0  END', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='K62';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='K62';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='K62';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='K62';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2600', 'K62', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''2600'', ''K62'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='K62';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='K62';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='K62';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K62');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (folders_tts: 2, ''K62'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
