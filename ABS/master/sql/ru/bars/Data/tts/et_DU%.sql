set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DU%
prompt ������������ ��������: DU% ����������� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DU%', 'DU% ����������� �������', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''03''))', 0, '0000100000000000000000000000000000000100000000000000000000000000', '����������� ������� �� �������� ����� #{DPU.GET_INTDETAILS(#(NLS),#(KV))} �� ����� � #(DAT1) �� #(DAT2) ���.');
  exception
    when dup_val_on_index then 
      update tts
         set tt='DU%', name='DU% ����������� �������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='����������� ������� �� �������� ����� #{DPU.GET_INTDETAILS(#(NLS),#(KV))} �� ����� � #(DAT1) �� #(DAT2) ���.'
       where tt='DU%';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DU%';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DU%';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DU%';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DU%';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DU%';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DU%';
  begin
    insert into folders_tts(idfo, tt)
    values (4, 'DU%');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 4, ''DU%'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
