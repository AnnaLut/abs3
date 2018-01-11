set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VPJ
prompt Наименование операции: VPJ d: Викуп нерозмінної частини USD (S2) валюти по курсу купівлі
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VPJ', 'VPJ d: Викуп нерозмінної частини USD (S2) валюти по курсу купівлі', 1, null, 840, null, 980, null, '#(tobopack.GetToboCASH)', '#(tobopack.GetToboCASH)', null, 0, 0, 1, 0, 'DECODE(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500))', 'eqv_obs(#(KVB),decode(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500)),
BANKDATE,1)', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000010000000000000010100000000000000000000000000', 'Викуп нерозмінної частини валюти по курсу купівлі');
  exception
    when dup_val_on_index then 
      update tts
         set tt='VPJ', name='VPJ d: Викуп нерозмінної частини USD (S2) валюти по курсу купівлі', dk=1, nlsm=null, kv=840, nlsk=null, kvk=980, nlss=null, nlsa='#(tobopack.GetToboCASH)', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=1, flr=0, s='DECODE(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500))', s2='eqv_obs(#(KVB),decode(#(KVB),980,0,840, MOD(#(S2),100), MOD(#(S2),500)),
BANKDATE,1)', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000010000000000000010100000000000000000000000000', nazn='Викуп нерозмінної частини валюти по курсу купівлі'
       where tt='VPJ';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VPJ';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', 'VPJ', 'O', 0, null, '261', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#73 '', ''VPJ'', ''O'', 0, null, ''261'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VPJ';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VPJ';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VPJ';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VPJ';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VPJ';
end;
/
commit;
