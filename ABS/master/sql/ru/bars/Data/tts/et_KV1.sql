set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KV1
prompt ������������ ��������: KV1  ����. ������� ( �������� )
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KV1', 'KV1  ����. ������� ( �������� )', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0101100000000000000000000001000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KV1', name='KV1  ����. ������� ( �������� )', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0101100000000000000000000001000000010000000000000000000000000000', nazn=null
       where tt='KV1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KV1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KV1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KV1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KV1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'KV1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''KV1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KV1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'KV1', 2, null, 'nvl(BRANCH_USR.GET_BRANCH_PARAM(''NOT2VISA''),0) = 0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''KV1'', 2, null, ''nvl(BRANCH_USR.GET_BRANCH_PARAM(''''NOT2VISA''''),0) = 0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KV1';
end;
/
commit;
