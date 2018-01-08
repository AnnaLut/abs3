set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции 8K5
prompt Наименование операции: :d Загр.перевод /ВАЛ ФЛ с ком в ВАЛ
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('8K5', ':d Загр.перевод /ВАЛ ФЛ с ком в ВАЛ', 1, null, null, '61107101229', 980, null, null, null, null, 0, 0, 1, 0, 'F_TARIF(15,#(KVA),#(NLSA),#(S))', 'gl.p_icurval( #(KVA), F_TARIF(15,#(KVA),#(NLSA),#(S)), bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='8K5', name=':d Загр.перевод /ВАЛ ФЛ с ком в ВАЛ', dk=1, nlsm=null, kv=null, nlsk='61107101229', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='F_TARIF(15,#(KVA),#(NLSA),#(S))', s2='gl.p_icurval( #(KVA), F_TARIF(15,#(KVA),#(NLSA),#(S)), bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='8K5';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='8K5';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='8K5';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='8K5';
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='8K5';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='8K5';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='8K5';
end;
/
commit;
