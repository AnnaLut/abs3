set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� @DE
prompt ������������ ��������: @DE - ������� ������-����� �� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('@DE', '@DE - ������� ������-����� �� ���', 1, null, null, '37397011', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, null, null, '0200000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='@DE', name='@DE - ������� ������-����� �� ���', dk=1, nlsm=null, kv=null, nlsk='37397011', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0200000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='@DE';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='@DE';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='@DE';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='@DE';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='@DE';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '@DE', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''@DE'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='@DE';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='@DE';
end;
/
commit;
