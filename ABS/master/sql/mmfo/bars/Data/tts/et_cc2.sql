set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CC2
prompt ������������ ��������: (���.CA2) ����� ����� �� ������ �������� ��� MIGOM
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CC2', '(���.CA2) ����� ����� �� ������ �������� ��� MIGOM', 1, '#(nbs_ob22 (''2909'',''40''))', 980, '#(nbs_ob22 (''6110'',''72''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_OP(5, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CC2', name='(���.CA2) ����� ����� �� ������ �������� ��� MIGOM', dk=1, nlsm='#(nbs_ob22 (''2909'',''40''))', kv=980, nlsk='#(nbs_ob22 (''6110'',''72''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_OP(5, 37, #(KVA), #(S), #(NLSA),''CA2'', 0.635)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CC2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CC2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CC2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CC2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CC2';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CC2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CC2', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CC2'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CC2', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CC2'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CC2';
end;
/
commit;
