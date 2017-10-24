set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� D9A
prompt ������������ ��������: D9A - %% �� ������� �� ������ 90% (90%-D90)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D9A', 'D9A - %% �� ������� �� ������ 90% (90%-D90)', 1, null, null, null, null, null, null, null, '300465', 0, 0, 0, 0, '#(S)*0.9', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='D9A', name='D9A - %% �� ������� �� ������ 90% (90%-D90)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob='300465', flc=0, fli=0, flv=0, flr=0, s='#(S)*0.9', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='D9A';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='D9A';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='D9A';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='D9A';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='D9A';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='D9A';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='D9A';
end;
/
commit;
