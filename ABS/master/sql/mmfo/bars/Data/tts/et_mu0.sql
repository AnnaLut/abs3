set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MU1
prompt ������������ ��������: MU1 --����� � ��� 100%
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU1', 'MU1 --����� � ��� 100%', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(F_TARIF_MGE(#(S)),0)', null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU1', name='MU1 --����� � ��� 100%', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(F_TARIF_MGE(#(S)),0)', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MU1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MU1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MU1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MU1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MU1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MU1';
  begin
    insert into folders_tts(idfo, tt)
    values (11, 'MU1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 11, ''MU1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
prompt �������� / ���������� �������� MU2
prompt ������������ ��������: MU2 --����� 76%2902(���)-2902(���)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU2', 'MU2 --����� 76%2902(���)-2902(���)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(F_TARIF_MGE(#(S)),0)*0.76', null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU2', name='MU2 --����� 76%2902(���)-2902(���)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(F_TARIF_MGE(#(S)),0)*0.76', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MU2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MU2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MU2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MU2';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MU2';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MU2';
end;
/
prompt �������� / ���������� �������� MU3
prompt ������������ ��������: MU3 --�����*24% * 70%
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU3', 'MU3 --�����*24% * 70%', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.70,0)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU3', name='MU3 --�����*24% * 70%', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.70,0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU3';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MU3';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MU3';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MU3';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MU3';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MU3';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MU3';
end;
/
prompt �������� / ���������� �������� MU4
prompt ������������ ��������: MU4 --�����*24% * 30% ��������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU4', 'MU4 --�����*24% * 30% ��������� �����', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.30,0)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU4', name='MU4 --�����*24% * 30% ��������� �����', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''DEP_S5'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DOH2909'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='ROUND(GL.P_ICURVAL(978,F_TARIF_MGE(#(S)), SYSDATE) *0.24 * 0.30,0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MU4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MU4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MU4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MU4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MU4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MU4';
end;
/
prompt �������� / ���������� �������� MU0
prompt ������������ ��������: MU0 --������ ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MU0', 'MU0 --������ ������', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 978, '#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', 978, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', null, 1, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MU0', name='MU0 --������ ������', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=978, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', kvk=978, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''PKV2900'',0))', mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MU0';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MU0';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MU0';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU1', 'MU0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''MU1'', ''MU0'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU2', 'MU0', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''MU2'', ''MU0'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU3', 'MU0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''MU3'', ''MU0'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('MU4', 'MU0', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''MU4'', ''MU0'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MU0';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MU0';
  begin
    insert into tts_vob(vob, tt, ord)
    values (300, 'MU0', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 300, ''MU0'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MU0';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'MU0', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''MU0'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MU0';
  begin
    insert into folders_tts(idfo, tt)
    values (11, 'MU0');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 11, ''MU0'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
