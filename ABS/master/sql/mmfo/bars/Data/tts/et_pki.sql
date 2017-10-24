set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PKI
prompt ������������ ��������: p) �-���������� % �� ������� �� ���������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PKI', 'p) �-���������� % �� ������� �� ���������', 0, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000010100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='PKI', name='p) �-���������� % �� ������� �� ���������', dk=0, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010100000000000000000000000000', nazn=null
       where tt='PKI';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PKI';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PKI';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PKI';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PKI';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PKI', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''PKI'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PKI';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PKI';
  begin
    insert into folders_tts(idfo, tt)
    values (27, 'PKI');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 27, ''PKI'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
