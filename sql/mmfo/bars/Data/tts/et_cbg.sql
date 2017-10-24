set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CBG
prompt ������������ ��������: (���.CAG) ����� ������ �� ������ �������� ��� MIGOM
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CBG', '(���.CAG) ����� ������ �� ������ �������� ��� MIGOM', 1, '#(nbs_ob22 (''2909'',''40''))', 980, '#(nbs_ob22 (''2909'',''40''))', 978, null, null, null, null, 0, 0, 1, 0, 'F_TARIF_OP(4, 49, #(KVA), #(S), #(NLSA),''CAG'', 0.635)', 'F_TARIF_OP(3, 49, #(KVA), #(S), #(NLSA),''CAG'', 0.635)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CBG', name='(���.CAG) ����� ������ �� ������ �������� ��� MIGOM', dk=1, nlsm='#(nbs_ob22 (''2909'',''40''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''40''))', kvk=978, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='F_TARIF_OP(4, 49, #(KVA), #(S), #(NLSA),''CAG'', 0.635)', s2='F_TARIF_OP(3, 49, #(KVA), #(S), #(NLSA),''CAG'', 0.635)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CBG';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CBG';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CBG';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CBG';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CBG', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CBG'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CBG';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CBG';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CBG';
end;
/
commit;
