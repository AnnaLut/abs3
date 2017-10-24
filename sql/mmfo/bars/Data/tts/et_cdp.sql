set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CDP
prompt ������������ ��������: (���.CAP) ����� ������ �� ������ �������� �� ����."RIA"(���� �����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDP', '(���.CAP) ����� ������ �� ������ �������� �� ����."RIA"(���� �����)', 1, '#(nbs_ob22 (''2909'',''65''))', 980, '#(nbs_ob22 (''2909'',''65''))', 840, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),SYSDATE))*(.7)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),bankdate))*(.7),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDP', name='(���.CAP) ����� ������ �� ������ �������� �� ����."RIA"(���� �����)', dk=1, nlsm='#(nbs_ob22 (''2909'',''65''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''65''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),SYSDATE))*(.7)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(66,#(KVA),#(NLSA),#(S)),bankdate))*(.7),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDP';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CDP';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CDP';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CDP';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CDP', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CDP'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CDP';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CDP';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CDP';
end;
/
commit;
