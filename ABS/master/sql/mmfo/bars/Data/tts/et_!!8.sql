set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !!8
prompt ������������ ��������: !!8  STOP-������� �� �������.������ ���  ���. <=1500000 ���.
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!8', '!!8  STOP-������� �� �������.������ ���  ���. <=1500000 ���.', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(80000,#(REF),'''',0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!8', name='!!8  STOP-������� �� �������.������ ���  ���. <=1500000 ���.', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(80000,#(REF),'''',0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!!8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!8';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!!8';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!8';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!!8';
end;
/
commit;
