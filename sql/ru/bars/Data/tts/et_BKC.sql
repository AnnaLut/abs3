set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� BKC
prompt ������������ ��������: BKC ��� �� BKY D3522/51-K2909/23
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BKC', 'BKC ��� �� BKY D3522/51-K2909/23', 1, '#(NBS_OB22(''3522'',''51''))', null, '#(NBS_OB22(''2909'',''23''))', null, null, null, null, null, 0, 0, 0, 0, 'BKY (7 )', null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BKC', name='BKC ��� �� BKY D3522/51-K2909/23', dk=1, nlsm='#(NBS_OB22(''3522'',''51''))', kv=null, nlsk='#(NBS_OB22(''2909'',''23''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BKY (7 )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BKC';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='BKC';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='BKC';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='BKC';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='BKC';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='BKC';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='BKC';
end;
/
commit;
