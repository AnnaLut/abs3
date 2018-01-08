set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt —оздание / ќбновление операции KM1
prompt Ќаименование операции: KM1 d: ком≥с≥€ за поповненн€ електронного гаманц€ гот≥вкою по систем≥ 
declare
  cnt_  number;
begin
  --------------------------------
  -- ќсновные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KM1', 'KM1 d: ком≥с≥€ за поповненн€ електронного гаманц€ гот≥вкою по систем≥ ', 1, '#(get_nls_tt(''KM1'',''NLSM''))', 980, '#(nbs_ob22 (''6510'',''B8''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(128, #(KVA), #(NLSA), #(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', ' ом≥с≥€ за поповненн€ електронного гаманц€ гот≥вкою по систем≥ "√лобалћан≥"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KM1', name='KM1 d: ком≥с≥€ за поповненн€ електронного гаманц€ гот≥вкою по систем≥ ', dk=1, nlsm='#(get_nls_tt(''KM1'',''NLSM''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B8''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(128, #(KVA), #(NLSA), #(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=' ом≥с≥€ за поповненн€ електронного гаманц€ гот≥вкою по систем≥ "√лобалћан≥"'
       where tt='KM1';
  end;
  --------------------------------
  ----------- –еквизиты ----------
  --------------------------------
  delete from op_rules where tt='KM1';
  --------------------------------
  ------ —в€занные операции ------
  --------------------------------
  delete from ttsap where tt='KM1';
  --------------------------------
  ------- Ѕалансовые счета -------
  --------------------------------
  delete from ps_tts where tt='KM1';
  --------------------------------
  -------- ¬иды документов -------
  --------------------------------
  delete from tts_vob where tt='KM1';
  --------------------------------
  -------- √руппы контрол€ -------
  --------------------------------
  delete from chklist_tts where tt='KM1';
  --------------------------------
  ------------- ѕапки ------------
  --------------------------------
  delete from folders_tts where tt='KM1';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'KM1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Ќе удалось добавить запись (folders_tts: 2, ''KM1'') - первичный ключ не найден!');
      else raise;
      end if;
  end;
end;
/
commit;
