set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 448
prompt ������������ ��������: 448 �� ���� ����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('448', '448 �� ���� ����', 1, '#(#(NLSB))', 980, '#( nbs_ob22 (''6519'',''24'') )', 980, null, null, null, null, 0, 0, 0, 0, '#(S)*5/6', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='448', name='448 �� ���� ����', dk=1, nlsm='#(#(NLSB))', kv=980, nlsk='#( nbs_ob22 (''6519'',''24'') )', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)*5/6', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='448';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='448';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='448';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='448';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='448';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='448';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='448';
end;
/
commit;
