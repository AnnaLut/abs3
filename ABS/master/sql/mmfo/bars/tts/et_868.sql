set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 878
prompt ������������ ��������: 878 - ����� "����" SWIFT
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('878', '878 - ����� "����" SWIFT', 1, null, null, '61147010106521', 980, null, null, '61147010106521', '300465', 0, 0, 1, 0, 'F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', 'gl.p_icurval( #(KVA),F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4, 4, 5),#(KVA),#(NLSA),#(S)),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='878', name='878 - ����� "����" SWIFT', dk=1, nlsm=null, kv=null, nlsk='61147010106521', kvk=980, nlss=null, nlsa=null, nlsb='61147010106521', mfob='300465', flc=0, fli=0, flv=1, flr=0, s='F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', s2='gl.p_icurval( #(KVA),F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4, 4, 5),#(KVA),#(NLSA),#(S)),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='878';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='878';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='878';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='878';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='878';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='878';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='878';
end;
/
prompt �������� / ���������� �������� 898
prompt ������������ ��������: 898 - "����" SWIFT ����� Commerzbank
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('898', '898 - "����" SWIFT ����� Commerzbank', 1, '3739401901', 978, '150072188', 978, null, '3739401901', '150072188', '300465', 0, 0, 0, 0, '#(S)-F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,10000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='898', name='898 - "����" SWIFT ����� Commerzbank', dk=1, nlsm='3739401901', kv=978, nlsk='150072188', kvk=978, nlss=null, nlsa='3739401901', nlsb='150072188', mfob='300465', flc=0, fli=0, flv=0, flr=0, s='#(S)-F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,10000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='898';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='898';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='898';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='898';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='898';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='898';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='898';
end;
/
prompt �������� / ���������� �������� 868
prompt ������������ ��������: 868-(�� 068) "����" SWIFT(� ���) �� Commerzbank
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('868', '868-(�� 068) "����" SWIFT(� ���) �� Commerzbank', 0, '3739401901', 978, '1500420171', 978, null, '3739401901', '1500420171', '300465', 1, 2, 0, 0, null, null, null, null, null, null, '1001000000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='868', name='868-(�� 068) "����" SWIFT(� ���) �� Commerzbank', dk=0, nlsm='3739401901', kv=978, nlsk='1500420171', kvk=978, nlss=null, nlsa='3739401901', nlsb='1500420171', mfob='300465', flc=1, fli=2, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='1001000000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='868';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='868';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('57   ', '868', 'M', 1, 4, '-1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''57   '', ''868'', ''M'', 1, 4, ''-1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('59   ', '868', 'O', 1, 5, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''59   '', ''868'', ''O'', 1, 5, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('70   ', '868', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''70   '', ''868'', ''O'', 1, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('71   ', '868', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''71   '', ''868'', ''O'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_K', '868', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ASP_K'', ''868'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_N', '868', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ASP_N'', ''868'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ASP_S', '868', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ASP_S'', ''868'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', '868', 'O', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_B'', ''868'', ''O'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', '868', 'M', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_G'', ''868'', ''M'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', '868', 'M', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_N'', ''868'', ''M'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='868';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('878', '868', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''878'', ''868'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('898', '868', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''898'', ''868'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='868';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1500', '868', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1500'', ''868'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='868';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, '868', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''868'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='868';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, '868', 4, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''868'', 4, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '868', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''868'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (7, '868', 2, null, 'f_cim_visa_condition(dk, kv, nlsa, nlsb) is not null and mfob=300465 and substr(nlsb,1,4) in (''2513'',''2525'',''2600'',''2602'',''2603'',''2604'',''2650'',''2650'',''2620'',''2909'') and kv<>980', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 7, ''868'', 2, null, ''f_cim_visa_condition(dk, kv, nlsa, nlsb) is not null and mfob=300465 and substr(nlsb,1,4) in (''''2513'''',''''2525'''',''''2600'''',''''2602'''',''''2603'''',''''2604'''',''''2650'''',''''2650'''',''''2620'''',''''2909'''') and kv<>980'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='868';
  begin
    insert into folders_tts(idfo, tt)
    values (72, '868');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 72, ''868'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
