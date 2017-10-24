set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CDP
prompt Наименование операции: (доч.CAP) Комісія агента за прийом переказу по сист."RIA"(Інші країни)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDP', '(доч.CAP) Комісія агента за прийом переказу по сист."RIA"(Інші країни)', 1, '#(nbs_ob22 (''2909'',''65''))', 980, '#(nbs_ob22 (''2909'',''65''))', 840, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),SYSDATE))*(.7)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),bankdate))*(.7),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDP', name='(доч.CAP) Комісія агента за прийом переказу по сист."RIA"(Інші країни)', dk=1, nlsm='#(nbs_ob22 (''2909'',''65''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''65''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),SYSDATE))*(.7)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),bankdate))*(.7),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDP';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CDP';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CDP';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CDP';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CDP', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''26  '', ''CDP'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CDP';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CDP';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CDP';
end;
/
commit;
