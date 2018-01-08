set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CB4
prompt Наименование операции: (доч.CA4) Комісія агента за прийом переказу для BLIZKO
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CB4', '(доч.CA4) Комісія агента за прийом переказу для BLIZKO', 1, '#(nbs_ob22 (''2909'',''58''))', 980, '#(nbs_ob22 (''2909'',''58''))', 840, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(39,#(KVA),#(NLSA),#(S)),SYSDATE))*(.6)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(39,#(KVA),#(NLSA),#(S)),bankdate))*(.6),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CB4', name='(доч.CA4) Комісія агента за прийом переказу для BLIZKO', dk=1, nlsm='#(nbs_ob22 (''2909'',''58''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''58''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(39,#(KVA),#(NLSA),#(S)),SYSDATE))*(.6)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(39,#(KVA),#(NLSA),#(S)),bankdate))*(.6),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CB4';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CB4';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CB4';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CB4';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CB4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''26  '', ''CB4'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CB4';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CB4';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CB4';
end;
/
commit;
