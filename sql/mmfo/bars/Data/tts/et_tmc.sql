set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� TMC
prompt ������������ ��������: TMC 5) # TMP/STOP-������� ��� ����/��� ��.��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TMC', 'TMC 5) # TMP/STOP-������� ��� ����/��� ��.��', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_BMP(#(REF),#(S),#(KVA)) ', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='TMC', name='TMC 5) # TMP/STOP-������� ��� ����/��� ��.��', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_BMP(#(REF),#(S),#(KVA)) ', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='TMC';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='TMC';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='TMC';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='TMC';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='TMC';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='TMC';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='TMC';
  begin
    insert into folders_tts(idfo, tt)
    values (77, 'TMC');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 77, ''TMC'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
