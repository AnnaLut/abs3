set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� @DI
prompt ������������ ��������: @DI - ������� ������-����� � ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('@DI', '@DI - ������� ������-����� � ��', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0200000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='@DI', name='@DI - ������� ������-����� � ��', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0200000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='@DI';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='@DI';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='@DI';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='@DI';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='@DI';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '@DI', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''@DI'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='@DI';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='@DI';
end;
/
commit;
