set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� NLE
prompt ������������ ��������: ³�������.����� �� ��������������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('NLE', '³�������.����� �� ��������������', null, '#(get_proc_nls(''T00'',#(KVA)))', null, '#( vkrzn( substr(f_ourmfo,1,5), ''3739_05'') )', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='NLE', name='³�������.����� �� ��������������', dk=null, nlsm='#(get_proc_nls(''T00'',#(KVA)))', kv=null, nlsk='#( vkrzn( substr(f_ourmfo,1,5), ''3739_05'') )', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='NLE';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='NLE';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='NLE';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='NLE';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='NLE';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='NLE';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='NLE';
end;
/
commit;
