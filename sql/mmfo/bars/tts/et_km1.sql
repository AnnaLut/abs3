set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KM1
prompt ������������ ��������: d: ����� �� ���������� ������������ ������� ������� �� ������ "��"
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KM1', 'd: ����� �� ���������� ������������ ������� ������� �� ������ "��"', 1, null, 980, '#(nbs_ob22 (''6110'',''B8''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(128, #(KVA), #(NLSA), #(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '����� �� ���������� ������������ ������� ������� �� ������ "���������"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KM1', name='d: ����� �� ���������� ������������ ������� ������� �� ������ "��"', dk=1, nlsm=null, kv=980, nlsk='#(nbs_ob22 (''6110'',''B8''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(128, #(KVA), #(NLSA), #(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='����� �� ���������� ������������ ������� ������� �� ������ "���������"'
       where tt='KM1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KM1';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KM1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KM1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KM1';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KM1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KM1';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'KM1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''KM1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
