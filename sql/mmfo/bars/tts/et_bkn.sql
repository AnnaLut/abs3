set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� BKN
prompt ������������ ��������: BKN ��� �� BKY D2909/23-K1919/06
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('BKN', 'BKN ��� �� BKY D2909/23-K1919/06', 1, '#(NBS_OB22(''2909'',''23''))', null, '#(NBS_OB22(''1919'',''06''))', null, null, null, null, null, 0, 0, 0, 0, 'BMY (6 )', null, null, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='BKN', name='BKN ��� �� BKY D2909/23-K1919/06', dk=1, nlsm='#(NBS_OB22(''2909'',''23''))', kv=null, nlsk='#(NBS_OB22(''1919'',''06''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BMY (6 )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='BKN';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='BKN';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='BKN';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='BKN';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='BKN';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='BKN';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='BKN';
end;
/
commit;
