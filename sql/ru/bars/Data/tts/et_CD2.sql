set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt Создание / Обновление операции CD2
prompt Наименование операции: (доч.CDD) Комісія агента за прийом переказу WU/СНД/ком(Терміновий)
declare
  cnt_  number;
begin
  --------------------------------
  -- Основные свойства операции --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CD2', '(доч.CDD) Комісія агента за прийом переказу WU/СНД/ком(Терміновий)', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''2909'',''27''))', 840, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(29,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(29,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CD2', name='(доч.CDD) Комісія агента за прийом переказу WU/СНД/ком(Терміновий)', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''27''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(29,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(29,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CD2';
  end;
  --------------------------------
  ----------- Реквизиты ----------
  --------------------------------
  delete from op_rules where tt='CD2';
  --------------------------------
  ------ Связанные операции ------
  --------------------------------
  delete from ttsap where tt='CD2';
  --------------------------------
  ------- Балансовые счета -------
  --------------------------------
  delete from ps_tts where tt='CD2';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CD2', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('Не удалось добавить запись (ps_tts: ''26  '', ''CD2'', 0) - первичный ключ не найден!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- Виды документов -------
  --------------------------------
  delete from tts_vob where tt='CD2';
  --------------------------------
  -------- Группы контроля -------
  --------------------------------
  delete from chklist_tts where tt='CD2';
  --------------------------------
  ------------- Папки ------------
  --------------------------------
  delete from folders_tts where tt='CD2';
end;
/
commit;
