set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KD3
prompt ������������ ��������: ���i�i� �� ������������� ���� ������ �� ������ �� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD3', '���i�i� �� ������������� ���� ������ �� ������ �� �������', 1, null, null, '61103010122561 ', null, null, null, '61103010122561 ', null, 0, 0, 0, 0, 'F_TARIF(3, #(KVA),#(NLSA), #(S))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KD3', name='���i�i� �� ������������� ���� ������ �� ������ �� �������', dk=1, nlsm=null, kv=null, nlsk='61103010122561 ', kvk=null, nlss=null, nlsa=null, nlsb='61103010122561 ', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(3, #(KVA),#(NLSA), #(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KD3';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KD3';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KD3';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KD3';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KD3';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KD3';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KD3';
end;
/
commit;
