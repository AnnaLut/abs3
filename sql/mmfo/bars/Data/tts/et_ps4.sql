set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PS4
prompt ������������ ��������: PS4 �/PS3 ���������� �������������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PS4', 'PS4 �/PS3 ���������� �������������', 1, null, 980, '#(get_proc_nls(''T00'',#(KVA)))', 980, null, null, null, null, 0, 1, 0, 0, '#(S)-F_TARIF(46, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0200100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PS4', name='PS4 �/PS3 ���������� �������������', dk=1, nlsm=null, kv=980, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s='#(S)-F_TARIF(46, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0200100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='PS4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PS4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PS4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PS4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PS4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PS4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PS4';
end;
/
commit;
