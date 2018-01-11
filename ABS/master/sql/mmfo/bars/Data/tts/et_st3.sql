set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� ST3
prompt ������������ ��������: ST3 STOP - ���_�=���_�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('ST3', 'ST3 STOP - ���_�=���_�', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP( 3, #(MFOA), '''' , #(MFOB) )', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='ST3', name='ST3 STOP - ���_�=���_�', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP( 3, #(MFOA), '''' , #(MFOB) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='ST3';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='ST3';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='ST3';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='ST3';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='ST3';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='ST3';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='ST3';
end;
/
commit;
