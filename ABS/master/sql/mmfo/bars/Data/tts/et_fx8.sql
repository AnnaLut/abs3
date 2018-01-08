set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� FX8
prompt ������������ ��������: �� I��.��./IH�.���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('FX8', '�� I��.��./IH�.���', null, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='FX8', name='�� I��.��./IH�.���', dk=null, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='FX8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='FX8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='FX8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='FX8';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='FX8';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='FX8';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'FX8', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''FX8'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'FX8', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''FX8'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='FX8';
end;
/
commit;
