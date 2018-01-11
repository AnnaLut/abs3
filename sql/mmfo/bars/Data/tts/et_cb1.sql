set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CB1
prompt ������������ ��������: CB1 (���.CA1) ����� ������ �� ������ �������� ��� ������� ����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CB1', 'CB1 (���.CA1) ����� ������ �� ������ �������� ��� ������� ����', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''2909'',''27''))', 840, null, null, null, null, 0, 0, 1, 0, 'F_TARIF_OP(4, 36, #(KVA), #(S), #(NLSA),''CA1'', 0.776)', 'F_TARIF_OP(3, 36, #(KVA), #(S), #(NLSA),''CA1'', 0.776)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CB1', name='CB1 (���.CA1) ����� ������ �� ������ �������� ��� ������� ����', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''27''))', kvk=840, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='F_TARIF_OP(4, 36, #(KVA), #(S), #(NLSA),''CA1'', 0.776)', s2='F_TARIF_OP(3, 36, #(KVA), #(S), #(NLSA),''CA1'', 0.776)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CB1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CB1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CB1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CB1';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CB1', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CB1'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CB1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CB1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CB1';
end;
/
commit;
