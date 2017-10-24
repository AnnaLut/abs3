set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� SIF
prompt ������������ ��������: ����������� � ���������� ��������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SIF', '����������� � ���������� ��������', 3, null, null, null, null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0300000000000000000000000001000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SIF', name='����������� � ���������� ��������', dk=3, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0300000000000000000000000001000000000100000000000000000000000000', nazn=null
       where tt='SIF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='SIF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='SIF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='SIF';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='SIF';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SIF', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''SIF'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='SIF';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='SIF';
  begin
    insert into folders_tts(idfo, tt)
    values (72, 'SIF');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 72, ''SIF'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
