set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� W4V
prompt ������������ ��������: W4. ����������� �� �����������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('W4V', 'W4. ����������� �� �����������', 1, null, null, '#(bpk_get_transit('''',#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0000100000000000000000000001000000000100000000000000000000000000', '����������� ��  �����������');
  exception
    when dup_val_on_index then 
      update tts
         set tt='W4V', name='W4. ����������� �� �����������', dk=1, nlsm=null, kv=null, nlsk='#(bpk_get_transit('''',#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000001000000000100000000000000000000000000', nazn='����������� ��  �����������'
       where tt='W4V';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='W4V';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='W4V';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='W4V';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='W4V';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'W4V', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''W4V'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='W4V';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='W4V';
end;
/
commit;
