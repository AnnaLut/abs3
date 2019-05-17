set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� SM8
prompt ������������ ��������: �������� ���� ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SM8', '�������� ���� ��', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 1, 0, 0, null, null, null, null, '0', null, '0300000000000000000000000000000000000000000000000000000000000000', '�������� ���� ��');
  exception
    when dup_val_on_index then 
      update tts
         set tt='SM8', name='�������� ���� ��', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800='0', rang=null, flags='0300000000000000000000000000000000000000000000000000000000000000', nazn='�������� ���� ��'
       where tt='SM8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='SM8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='SM8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='SM8';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='SM8';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SM8', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''SM8'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='SM8';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'SM8', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 11, ''SM8'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='SM8';
end;
/
commit;
