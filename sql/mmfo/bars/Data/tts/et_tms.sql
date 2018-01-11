set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� TMS
prompt ������������ ��������: TMS 5) # TMK/STOP-������� ��� ����/��� ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TMS', 'TMS 5) # TMK/STOP-������� ��� ����/��� ��', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_BMK(#(REF),#(S),#(KVA)) ', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='TMS', name='TMS 5) # TMK/STOP-������� ��� ����/��� ��', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_BMK(#(REF),#(S),#(KVA)) ', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='TMS';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='TMS';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='TMS';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='TMS';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='TMS';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='TMS';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='TMS';
  begin
    insert into folders_tts(idfo, tt)
    values (77, 'TMS');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 77, ''TMS'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
