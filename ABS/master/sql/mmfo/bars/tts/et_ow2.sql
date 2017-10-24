set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� OW2
prompt ������������ ��������: OpenWay: ��������������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('OW2', 'OpenWay: ��������������', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '38005003010', null, '0100100000000000000000000000000000000110000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='OW2', name='OpenWay: ��������������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='38005003010', rang=null, flags='0100100000000000000000000000000000000110000000000000000000000000', nazn=null
       where tt='OW2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='OW2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='OW2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='OW2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='OW2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (16, 'OW2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 16, ''OW2'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='OW2';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='OW2';
end;
/
commit;
