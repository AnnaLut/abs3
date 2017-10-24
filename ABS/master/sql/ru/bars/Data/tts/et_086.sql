set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 086
prompt ������������ ��������: 086d �������� ���� �����������  � �������������� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('086', '086d �������� ���� �����������  � �������������� �������', 1, '#(nbs_ob22 (''9910'',''01''))', 980, '#(nbs_ob22 (''9760'',''23''))', 980, null, null, null, null, 0, 0, 0, 1, null, null, null, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='086', name='086d �������� ���� �����������  � �������������� �������', dk=1, nlsm='#(nbs_ob22 (''9910'',''01''))', kv=980, nlsk='#(nbs_ob22 (''9760'',''23''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=1, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='086';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='086';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='086';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='086';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9760', '086', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9760'', ''086'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('9910', '086', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''9910'', ''086'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='086';
  begin
    insert into tts_vob(vob, tt, ord)
    values (4, '086', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 4, ''086'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='086';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='086';
  begin
    insert into folders_tts(idfo, tt)
    values (92, '086');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 92, ''086'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into folders_tts(idfo, tt)
    values (18, '086');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 18, ''086'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
