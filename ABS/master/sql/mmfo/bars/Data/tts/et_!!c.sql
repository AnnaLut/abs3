set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !!C
prompt ������������ ��������: STOP-������� ��� 00�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!C', 'STOP-������� ��� 00�', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(541,#(KVA),#(NLSA),#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!C', name='STOP-������� ��� 00�', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(541,#(KVA),#(NLSA),#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!C';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!!C';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!C';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!C';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!!C';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!C';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!!C';
end;
/
commit;
