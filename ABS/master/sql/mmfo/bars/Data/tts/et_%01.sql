set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� %01
prompt ������������ ��������: %01 ���������� % ��� ������� (10%) - �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('%01', '%01 ���������� % ��� ������� (10%) - �������', 1, null, null, '74192031501523', 980, null, null, null, null, 0, 0, 1, 0, '0.1 *  #(S)', '0.1 *  gl.p_icurval( #(KVA), #(S), bankdate )', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='%01', name='%01 ���������� % ��� ������� (10%) - �������', dk=1, nlsm=null, kv=null, nlsk='74192031501523', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='0.1 *  #(S)', s2='0.1 *  gl.p_icurval( #(KVA), #(S), bankdate )', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='%01';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='%01';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='%01';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='%01';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='%01';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='%01';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='%01';
end;
/
commit;