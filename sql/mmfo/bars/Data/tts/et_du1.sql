set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DU8
prompt ������������ ��������: +������������� ���� ���������� ���� ��
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DU8', '+������������� ���� ���������� ���� ��', 1, '#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', null, '#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', null, null, null, null, null, 0, 0, 0, 0, 'case when dpu.is_line(#(REF)) is null then 0 else #(S) end', null, null, null, null, 0, '1000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU8', name='+������������� ���� ���������� ���� ��', dk=1, nlsm='#(dpu.get_nls4pay(#(REF),#(NLSA),#(KVA)))', kv=null, nlsk='#(dpu.get_nls4pay(#(REF),#(NLSB),#(KVB)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='case when dpu.is_line(#(REF)) is null then 0 else #(S) end', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='1000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DU8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DU8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DU8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DU8';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('8   ', 'DU8', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''8   '', ''DU8'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('8   ', 'DU8', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''8   '', ''DU8'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DU8';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DU8';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DU8';
end;
/
prompt �������� / ���������� �������� DU1
prompt ������������ ��������: DU1 ������� ������� (�����.)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DU1', 'DU1 ������� ������� (�����.)', 1, null, null, null, null, null, null, null, null, 1, 0, 0, 0, null, null, null, null, null, 9, '0000100000000000000000000000000000010000000000000000000000000000', '³������ �� �������� ����� #{DPU.F_NAZN(''U'',#(ND))}');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU1', name='DU1 ������� ������� (�����.)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=1, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=9, flags='0000100000000000000000000000000000010000000000000000000000000000', nazn='³������ �� �������� ����� #{DPU.F_NAZN(''U'',#(ND))}'
       where tt='DU1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DU1';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DPTOP', 'DU1', 'O', 0, 2, '4', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DPTOP'', ''DU1'', ''O'', 0, 2, ''4'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ND   ', 'DU1', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ND   '', ''DU1'', ''M'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DU1';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('DU8', 'DU1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''DU8'', ''DU1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DU1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DU1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'DU1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''DU1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DU1';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'DU1', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''DU1'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DU1';
  begin
    insert into folders_tts(idfo, tt)
    values (4, 'DU1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 4, ''DU1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
