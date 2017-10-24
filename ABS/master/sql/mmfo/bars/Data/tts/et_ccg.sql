set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CCG
prompt ������������ ��������: (���.CAG) ����� ����� �� ������ �������� ��� MIGOM
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CCG', '(���.CAG) ����� ����� �� ������ �������� ��� MIGOM', 1, '#(nbs_ob22 (''2909'',''40''))', 980, '#(nbs_ob22 (''6110'',''72''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_OP(5, 49, #(KVA), #(S), #(NLSA),''CAG'', 0.635)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CCG', name='(���.CAG) ����� ����� �� ������ �������� ��� MIGOM', dk=1, nlsm='#(nbs_ob22 (''2909'',''40''))', kv=980, nlsk='#(nbs_ob22 (''6110'',''72''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_OP(5, 49, #(KVA), #(S), #(NLSA),''CAG'', 0.635)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CCG';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CCG';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CCG';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CCG';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CCG';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CCG';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CCG', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CCG'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CCG', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CCG'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CCG';
end;
/
commit;
