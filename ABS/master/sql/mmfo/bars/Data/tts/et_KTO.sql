set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KTO
prompt ������������ ��������: KTO d: ����� �� ��������� ��������� ������� �� �������� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KTO', 'KTO d: ����� �� ��������� ��������� ������� �� �������� ���', 1, '#(nbs_ob22 (''6510'',''24''))', 980, '#(nbs_ob22 (''2902'',''01''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(50, #(KVA),#(NLSA), #(S))', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KTO', name='KTO d: ����� �� ��������� ��������� ������� �� �������� ���', dk=1, nlsm='#(nbs_ob22 (''6510'',''24''))', kv=980, nlsk='#(nbs_ob22 (''2902'',''01''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(50, #(KVA),#(NLSA), #(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='KTO';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KTO';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KTO';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KTO';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KTO';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KTO';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KTO';
end;
/
commit;
