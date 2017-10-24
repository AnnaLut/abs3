set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CB6
prompt ������������ ��������: (���.CA6) ����� ������ �� ������ �������� ��� BLIZKO
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CB6', '(���.CA6) ����� ������ �� ������ �������� ��� BLIZKO', 1, '#(nbs_ob22 (''2909'',''58''))', 980, '#(nbs_ob22 (''2909'',''58''))', 643, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(41,#(KVA),#(NLSA),#(S))*(.6),SYSDATE))', 'F_TARIF(41,#(KVA),#(NLSA),#(S))*(.6)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CB6', name='(���.CA6) ����� ������ �� ������ �������� ��� BLIZKO', dk=1, nlsm='#(nbs_ob22 (''2909'',''58''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''58''))', kvk=643, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(41,#(KVA),#(NLSA),#(S))*(.6),SYSDATE))', s2='F_TARIF(41,#(KVA),#(NLSA),#(S))*(.6)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CB6';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CB6';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CB6';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CB6';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CB6', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CB6'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CB6';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CB6';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CB6';
end;
/
commit;
