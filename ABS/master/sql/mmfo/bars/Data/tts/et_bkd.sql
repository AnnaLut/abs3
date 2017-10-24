set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� BKD
prompt ������������ ��������: BKD ��� �� BKY D9910-K9819/G9
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BKD', 'BKD ��� �� BKY D9910-K9819/G9', 1, '#(NBS_OB22(''9910'',''01''))', null, '#(NBS_OB22(''9819'',''G9''))', null, null, null, null, null, 0, 0, 0, 0, '#(BM__Y) *100', '#(BM__Y)*100', null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BKD', name='BKD ��� �� BKY D9910-K9819/G9', dk=1, nlsm='#(NBS_OB22(''9910'',''01''))', kv=null, nlsk='#(NBS_OB22(''9819'',''G9''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(BM__Y) *100', s2='#(BM__Y)*100', sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BKD';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='BKD';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='BKD';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='BKD';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='BKD';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='BKD';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='BKD';
end;
/
commit;
