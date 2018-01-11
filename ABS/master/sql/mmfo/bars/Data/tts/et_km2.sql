set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KM2
prompt ������������ ��������: KM2 d: ����� �� ���� ����������� ������ �� ������� ����� �� ���� 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KM2', 'KM2 d: ����� �� ���� ����������� ������ �� ������� ����� �� ���� ', 1, '#(get_nls_tt(''KM2'',''NLSM''))', 980, '#(nbs_ob22 (''6510'',''B8''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF(129, #(KVA), #(NLSA), #(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '����� �� ���� ����������� ������ �� ������� ����� �� ���� "���������"');
  exception
    when dup_val_on_index then 
      update tts
         set tt='KM2', name='KM2 d: ����� �� ���� ����������� ������ �� ������� ����� �� ���� ', dk=1, nlsm='#(get_nls_tt(''KM2'',''NLSM''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''B8''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(129, #(KVA), #(NLSA), #(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='����� �� ���� ����������� ������ �� ������� ����� �� ���� "���������"'
       where tt='KM2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KM2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KM2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KM2';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KM2';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KM2';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KM2';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'KM2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''KM2'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
