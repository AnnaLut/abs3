set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� P2C
prompt ������������ ��������: ������� �� P2S   Internet_Banking ������ 2620-2620
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('P2C', '������� �� P2S   Internet_Banking ������ 2620-2620', 1, '#(GetGlobalOption(''NLS_373914_LOCPAY''))', null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='P2C', name='������� �� P2S   Internet_Banking ������ 2620-2620', dk=1, nlsm='#(GetGlobalOption(''NLS_373914_LOCPAY''))', kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='P2C';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='P2C';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='P2C';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='P2C';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='P2C';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='P2C';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='P2C';
end;
/
commit;
