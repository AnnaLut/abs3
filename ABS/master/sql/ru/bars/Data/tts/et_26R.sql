set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 26R
prompt ������������ ��������: ����������� �� ��/��� 2603 ��� �����������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('26R', '����������� �� ��/��� 2603 ��� �����������', 1, '������ �������', null, '#(DECODE(SUBSTR(#(NLSB),1,4),''1602'',''1919'',''2600'',''2603'',''2650'', ''2603'', ''2610'', ''2622'', SUBSTR(#(NLSB),1,4))||''??????????'')', null, null, null, null, null, 0, 0, 0, 0, '#(S)', null, null, null, null, null, '0000100000000000000000080000000000010100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='26R', name='����������� �� ��/��� 2603 ��� �����������', dk=1, nlsm='������ �������', kv=null, nlsk='#(DECODE(SUBSTR(#(NLSB),1,4),''1602'',''1919'',''2600'',''2603'',''2650'', ''2603'', ''2610'', ''2622'', SUBSTR(#(NLSB),1,4))||''??????????'')', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000080000000000010100000000000010000000000000', nazn=null
       where tt='26R';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='26R';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='26R';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='26R';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='26R';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='26R';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='26R';
end;
/
commit;
