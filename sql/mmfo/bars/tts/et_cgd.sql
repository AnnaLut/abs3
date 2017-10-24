set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CGD
prompt ������������ ��������: (���.CG3) ����� ������ �� ������ �������� �� ������ "MoneyGram"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CGD', '(���.CG3) ����� ������ �� ������ �������� �� ������ "MoneyGram"', 1, '#(nbs_ob22 (''2909'',''70''))', 980, '#(nbs_ob22 (''2909'',''70''))', 840, null, null, null, null, 0, 0, 1, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(86,#(KVA),#(NLSA),#(S)),SYSDATE))*(.75)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(86,#(KVA),#(NLSA),#(S)),bankdate))*(.75),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CGD', name='(���.CG3) ����� ������ �� ������ �������� �� ������ "MoneyGram"', dk=1, nlsm='#(nbs_ob22 (''2909'',''70''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''70''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(86,#(KVA),#(NLSA),#(S)),SYSDATE))*(.75)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(86,#(KVA),#(NLSA),#(S)),bankdate))*(.75),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CGD';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CGD';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CGD';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CGD';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CGD', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CGD'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CGD';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CGD';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CGD';
end;
/
commit;
