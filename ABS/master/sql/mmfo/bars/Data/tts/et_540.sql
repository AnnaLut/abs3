set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 540
prompt ������������ ��������: 540 STOP-�������. ��������� ������ 150 ���.��� - 540 ����.���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('540', '540 STOP-�������. ��������� ������ 150 ���.��� - 540 ����.���', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(540,#(KVA),#(NLSA),0,#(REF))', null, null, null, null, 0, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='540', name='540 STOP-�������. ��������� ������ 150 ���.��� - 540 ����.���', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(540,#(KVA),#(NLSA),0,#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='540';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='540';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='540';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='540';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='540';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='540';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='540';
  begin
    insert into folders_tts(idfo, tt)
    values (1, '540');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''540'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
