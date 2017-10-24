set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� ���
prompt ������������ ��������: ��� ����� �� ��� (������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('���', '��� ����� �� ��� (������)', 1, null, 980, '#(nbs_ob22 (''6110'',''43''))', 980, null, null, null, null, 0, 0, 0, 0, 'f_monet_tar(111,F_DOP(#(REF), (''M_1'')),F_DOP(#(REF), (''M_2'')),F_DOP(#(REF), (''M_5'')),F_DOP(#(REF), (''M_10'')),F_DOP(#(REF), (''M_25'')),F_DOP(#(REF), (''M_50'')))', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', ' ����� �� ������� ����� �� ���� ��');
  exception
    when dup_val_on_index then 
      update tts
         set tt='���', name='��� ����� �� ��� (������)', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6110'',''43''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_monet_tar(111,F_DOP(#(REF), (''M_1'')),F_DOP(#(REF), (''M_2'')),F_DOP(#(REF), (''M_5'')),F_DOP(#(REF), (''M_10'')),F_DOP(#(REF), (''M_25'')),F_DOP(#(REF), (''M_50'')))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=' ����� �� ������� ����� �� ���� ��'
       where tt='���';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='���';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='���';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='���';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='���';
  begin
    insert into tts_vob(vob, tt, ord)
    values (23, '���', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 23, ''���'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='���';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='���';
  begin
    insert into folders_tts(idfo, tt)
    values (2, '���');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''���'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
