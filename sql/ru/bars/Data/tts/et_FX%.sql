set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� FX%
prompt ������������ ��������: ��: �����.������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FX%', '��: �����.������', 1, null, null, null, 980, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000000000000000000000000000000000010000000000000000000000000000', '#{BARS.F_NAZN_FX(''CP'',''#(NLS)'',''#(KV)'',''#(NLSA)'',''#(KVA)'')} � #(DAT1) �� #(DAT2) ���.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='FX%', name='��: �����.������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000000000000000000000000000000000010000000000000000000000000000', nazn='#{BARS.F_NAZN_FX(''CP'',''#(NLS)'',''#(KV)'',''#(NLSA)'',''#(KVA)'')} � #(DAT1) �� #(DAT2) ���.'
       where tt='FX%';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='FX%';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='FX%';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='FX%';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='FX%';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='FX%';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='FX%';
end;
/
commit;
