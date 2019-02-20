set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� SM3
prompt ������������ ��������: SM3 ���������� ��������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('SM3', 'SM3 ���������� ��������� �����', 1, null, null, '#(get_proc_nls(''T00'', NVL ( #(KVA), 980 ) ) )', null, null, null, null, null, 1, 1, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='SM3', name='SM3 ���������� ��������� �����', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'', NVL ( #(KVA), 980 ) ) )', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=1, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='SM3';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='SM3';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='SM3';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='SM3';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='SM3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'SM3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''SM3'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='SM3';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (11, 'SM3', 1, null, null, 3);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''SM3'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='SM3';
end;
/
commit;
