set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CLD
prompt ������������ ��������: SWT->VPS ������� �� �������� �� Claims Conferens
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CLD', 'SWT->VPS ������� �� �������� �� Claims Conferens', 1, null, null, '#(get_proc_nls(''T00'',#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, '#(S)+225', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', '�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����');
  exception
    when dup_val_on_index then 
      update tts
         set tt='CLD', name='SWT->VPS ������� �� �������� �� Claims Conferens', dk=1, nlsm=null, kv=null, nlsk='#(get_proc_nls(''T00'',#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='#(S)+225', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn='�������� ������� � ������������ ���� �����-���. CITI/London � ��� 2,25 ����'
       where tt='CLD';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CLD';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CLD';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CLD';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CLD';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CLD';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CLD';
  begin
    insert into folders_tts(idfo, tt)
    values (70, 'CLD');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 70, ''CLD'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
