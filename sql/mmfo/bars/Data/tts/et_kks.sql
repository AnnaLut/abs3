set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KKS
prompt ������������ ��������: KKS --KKS/��. STOP-������� �� ������������ ˲̲��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KKS', 'KKS --KKS/��. STOP-������� �� ������������ ˲̲��', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'STOP_KK ( #(REF) )', null, null, null, null, null, '0000100000000000000000000000000000000000000000100000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KKS', name='KKS --KKS/��. STOP-������� �� ������������ ˲̲��', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='STOP_KK ( #(REF) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000100000000000000000', nazn=null
       where tt='KKS';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KKS';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KKS';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KKS';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KKS';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KKS';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KKS';
  begin
    insert into folders_tts(idfo, tt)
    values (7, 'KKS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 7, ''KKS'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
