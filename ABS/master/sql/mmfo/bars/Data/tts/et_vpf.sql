set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции VPF
prompt Наименование операции: VPF d: Викуп нерозмiнної частини (S) валюти по курсу купiвлi
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('VPF', 'VPF d: Викуп нерозмiнної частини (S) валюти по курсу купiвлi', 1, null, null, null, 980, null, '#(tobopack.GetToboCASH)', '#(tobopack.GetToboCASH)', null, 0, 0, 1, 0, 'case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end', 'eqv_obs(#(KVA),case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end ,SYSDATE,1)', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000110000000000000010000000000000000100000000000000000000000000', 'Викуп нерозмiнної частини валюти по курсу купiвлi');
  exception
    when dup_val_on_index then 
      update tts
         set tt='VPF', name='VPF d: Викуп нерозмiнної частини (S) валюти по курсу купiвлi', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa='#(tobopack.GetToboCASH)', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=1, flr=0, s='case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end', s2='eqv_obs(#(KVA),case when #(KVA)=980 then 0 when #(KVA)=978 then MOD(#(S),500) when #(KVA)=643 then MOD(#(S),500) when #(KVA)=826 then MOD(#(S),500) when #(KVA)=124 then MOD(#(S),500) when #(KVA)=756 then MOD(#(S),1000) else MOD(#(S),100) end ,SYSDATE,1)', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000110000000000000010000000000000000100000000000000000000000000', nazn='Викуп нерозмiнної частини валюти по курсу купiвлi'
       where tt='VPF';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='VPF';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='VPF';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='VPF';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='VPF';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='VPF';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='VPF';
end;
/
commit;
