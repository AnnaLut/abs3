set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� G01
prompt ������������ ��������: G01 ���� ����� 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G01', 'G01 ���� ����� ', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, '0', null, '0001100000000000000000000000000000110100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G01', name='G01 ���� ����� ', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0001100000000000000000000000000000110100000000000000000000000000', nazn=null
       where tt='G01';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='G01';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G01';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G01';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('100 ', 'G01', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''100 '', ''G01'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('290 ', 'G01', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''290 '', ''G01'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='G01';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'G01', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''G01'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G01';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='G01';
end;
/
commit;
