set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� C5B
prompt ������������ ��������: (���.CH5) ����� ������ �� ������ �������� ��� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('C5B', '(���.CH5) ����� ������ �� ������ �������� ��� �����', 1, '#(nbs_ob22 (''2909'',''73''))', 980, '#(nbs_ob22 (''2909'',''73''))', 978, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),SYSDATE))*(.5533)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),bankdate))*(.5533),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='C5B', name='(���.CH5) ����� ������ �� ������ �������� ��� �����', dk=1, nlsm='#(nbs_ob22 (''2909'',''73''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''73''))', kvk=978, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),SYSDATE))*(.5533)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(89,#(KVA),#(NLSA),#(S)),bankdate))*(.5533),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='C5B';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='C5B';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='C5B';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='C5B';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'C5B', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''C5B'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='C5B';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='C5B';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='C5B';
end;
/
commit;
