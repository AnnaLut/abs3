set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� %36
prompt ������������ ��������: %36 d`(%%2) ����������� ������� (�i���� ���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('%36', '%36 d`(%%2) ����������� ������� (�i���� ���)', 1, null, null, '#(NBS_OB22(''3622'',''51''))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND (  #(S) / 6 , 0 ) ', 'ROUND (  #(S2) / 6 , 0) ', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='%36', name='%36 d`(%%2) ����������� ������� (�i���� ���)', dk=1, nlsm=null, kv=null, nlsk='#(NBS_OB22(''3622'',''51''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND (  #(S) / 6 , 0 ) ', s2='ROUND (  #(S2) / 6 , 0) ', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='%36';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='%36';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='%36';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='%36';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='%36';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='%36';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='%36';
end;
/
commit;
