set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� PPF
prompt ������������ ��������: PPF ����������� ������� �� �� (������� ��������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('PPF', 'PPF ����������� ������� �� �� (������� ��������)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''10''))', 0, '0000100000000000000000000000000000010100000000000000000000000000', '��������� ������������ ������� � ������ ���������� ��������� �������� ��������� � �������� ���.�������� #{DPT_WEB.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='PPF', name='PPF ����������� ������� �� �� (������� ��������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=0, flags='0000100000000000000000000000000000010100000000000000000000000000', nazn='��������� ������������ ������� � ������ ���������� ��������� �������� ��������� � �������� ���.�������� #{DPT_WEB.F_NAZN(''U'',#(ND))}'
       where tt='PPF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='PPF';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('HERIT', 'PPF', 'O', 0, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''HERIT'', ''PPF'', ''O'', 0, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='PPF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='PPF';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2620', 'PPF', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2620'', ''PPF'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2630', 'PPF', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2630'', ''PPF'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('2635', 'PPF', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''2635'', ''PPF'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('3622', 'PPF', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''3622'', ''PPF'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='PPF';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'PPF', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''PPF'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='PPF';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='PPF';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'PPF');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''PPF'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
