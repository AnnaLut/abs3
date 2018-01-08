set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 046
prompt Наименование операции: 046 d: Викуп нерозмiнної частини (S2) валюти по курсу купiвлi
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('046', '046 d: Викуп нерозмiнної частини (S2) валюти по курсу купiвлi', 1, null, 980, null, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 0, 0, 1, 0, 'EQV_OBS(#(KVB),case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end,BANKDATE,1)', 'case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000010100000000000000000000000000', 'Викуп нерозмiнної частини (S2) валюти по курсу купiвлi');
  exception
    when dup_val_on_index then 
      update tts
         set tt='046', name='046 d: Викуп нерозмiнної частини (S2) валюти по курсу купiвлi', dk=1, nlsm=null, kv=980, nlsk=null, kvk=null, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=0, fli=0, flv=1, flr=0, s='EQV_OBS(#(KVB),case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end,BANKDATE,1)', s2='case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000010100000000000000000000000000', nazn='Викуп нерозмiнної частини (S2) валюти по курсу купiвлi'
       where tt='046';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='046';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '046', 'O', 0, null, '261', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (op_rules: ''D#73 '', ''046'', ''O'', 0, null, ''261'', null) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='046';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='046';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='046';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='046';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='046';
end;
/
commit;
