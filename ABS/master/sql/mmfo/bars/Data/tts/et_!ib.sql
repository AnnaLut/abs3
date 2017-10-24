set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !IB
prompt ������������ ��������: !IB STOP ������� �� 2603 �� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!IB', '!IB STOP ������� �� 2603 �� ������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'ib_stop_2603(''2603'',''05'',#(NLSA),#(NLSB),#(KVA),0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!IB', name='!IB STOP ������� �� 2603 �� ������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ib_stop_2603(''2603'',''05'',#(NLSA),#(NLSB),#(KVA),0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!IB';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!IB';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!IB';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!IB';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!IB';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!IB';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!IB';
end;
/
commit;
