set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 26E
prompt ������������ ��������: 26E ����������� �� ��/��� 2603/05
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('26E', '26E ����������� �� ��/��� 2603/05', 1, '#(T902nls(779,#(KVA),#(DK),''26E''))', null, '#(nbs_ob22_nls_rnk(''2603'',''05'',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, '#(S)', null, null, null, null, null, '0000100000000000000000080000000000010100000000000010000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='26E', name='26E ����������� �� ��/��� 2603/05', dk=1, nlsm='#(T902nls(779,#(KVA),#(DK),''26E''))', kv=null, nlsk='#(nbs_ob22_nls_rnk(''2603'',''05'',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000080000000000010100000000000010000000000000', nazn=null
       where tt='26E';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='26E';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='26E';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='26E';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='26E';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='26E';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='26E';
end;
/
commit;
