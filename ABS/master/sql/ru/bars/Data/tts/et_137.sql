set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 137
prompt ������������ ��������: 137 ���������� ������� �� �����. ������� ����� EUR
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('137', '137 ���������� ������� �� �����. ������� ����� EUR', 1, '#(nbs_ob22 (''2622'',''01''))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, '#(nbs_ob22 (''2622'',''01''))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA), F_TARIF(56, #(KVA), #(NLSA), #(S) ), BANKDATE)', null, 61, null, null, null, '0000100000000000000000000000000000010000000000100000000000000000', '���������� ������� �� ����������� ������� �����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='137', name='137 ���������� ������� �� �����. ������� ����� EUR', dk=1, nlsm='#(nbs_ob22 (''2622'',''01''))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa='#(nbs_ob22 (''2622'',''01''))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA), F_TARIF(56, #(KVA), #(NLSA), #(S) ), BANKDATE)', s2=null, sk=61, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000010000000000100000000000000000', nazn='���������� ������� �� ����������� ������� �����'
       where tt='137';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='137';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='137';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='137';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='137';
  begin
    insert into tts_vob(vob, tt, ord)
    values (22, '137', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 22, ''137'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (24, '137', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 24, ''137'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='137';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '137', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''137'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '137', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''137'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='137';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '137');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''137'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
