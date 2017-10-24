set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CDB
prompt ������������ ��������: (���.CD1) ����� ������ �� ������ �������� ��� ������� ����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDB', '(���.CD1) ����� ������ �� ������ �������� ��� ������� ����', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''2909'',''27''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(47,#(KVA),#(NLSA),#(S))*(.775)', 'F_TARIF(47,#(KVA),#(NLSA),#(S))*(.775)', null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDB', name='(���.CD1) ����� ������ �� ������ �������� ��� ������� ����', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''2909'',''27''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(47,#(KVA),#(NLSA),#(S))*(.775)', s2='F_TARIF(47,#(KVA),#(NLSA),#(S))*(.775)', sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDB';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CDB';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CDB';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CDB';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CDB', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CDB'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CDB';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CDB';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CDB';
end;
/
commit;
