set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CB8
prompt ������������ ��������: CB8 (���.CA8) ����� ������ �� ������ �������� ��� �COINSTAR�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CB8', 'CB8 (���.CA8) ����� ������ �� ������ �������� ��� �COINSTAR�', 1, '#(nbs_ob22 (''2909'',''46''))', 980, '#(nbs_ob22 (''2909'',''46''))', 978, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CB8', name='CB8 (���.CA8) ����� ������ �� ������ �������� ��� �COINSTAR�', dk=1, nlsm='#(nbs_ob22 (''2909'',''46''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''46''))', kvk=978, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE))*(.776)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),bankdate))*(.776),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CB8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CB8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CB8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CB8';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CB8', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CB8'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CB8';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CB8';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CB8';
end;
/
commit;
