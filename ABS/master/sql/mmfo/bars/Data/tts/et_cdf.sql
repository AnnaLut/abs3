set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CDF
prompt ������������ ��������: CDF (���.CAF) ����� ������ �� ������ �������� �� ����."Contact" (���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDF', 'CDF (���.CAF) ����� ������ �� ������ �������� �� ����."Contact" (���', 1, '#(nbs_ob22 (''2909'',''64''))', 980, '#(nbs_ob22 (''2909'',''64''))', null, null, null, null, null, 0, 0, 1, 0, 'gl.p_icurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)', 'CAF_KOM (''CDF'',#(KVA), #(S) )', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', 'gl.p_ncurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDF', name='CDF (���.CAF) ����� ������ �� ������ �������� �� ����."Contact" (���', dk=1, nlsm='#(nbs_ob22 (''2909'',''64''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''64''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='gl.p_icurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)', s2='CAF_KOM (''CDF'',#(KVA), #(S) )', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn='gl.p_ncurval(#(KVA),CAF_KOM (''CDF'',#(KVA), #(S) ),SYSDATE)'
       where tt='CDF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CDF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CDF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CDF';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CDF', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CDF'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CDF';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CDF';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CDF';
end;
/
commit;
