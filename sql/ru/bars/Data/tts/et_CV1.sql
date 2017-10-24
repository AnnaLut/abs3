set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CV1
prompt ������������ ��������: d1 ����������� ������. ���. USD<>EUR
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CV1', 'd1 ����������� ������. ���. USD<>EUR', 1, null, 840, '#(nbs_ob22 (''3800'',''20''))', 840, null, null, null, null, 0, 0, 0, 0, '#(S)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CV1', name='d1 ����������� ������. ���. USD<>EUR', dk=1, nlsm=null, kv=840, nlsk='#(nbs_ob22 (''3800'',''20''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CV1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CV1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CV1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CV1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CV1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CV1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CV1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CV1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CV1';
  begin
    insert into folders_tts(idfo, tt)
    values (3, 'CV1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 3, ''CV1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
