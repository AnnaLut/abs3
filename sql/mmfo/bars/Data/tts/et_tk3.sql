set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� TK3
prompt ������������ ��������: TK3 ������� ��� ��� �������������� ������ �� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TK3', 'TK3 ������� ��� ��� �������������� ������ �� �������', 1, null, null, null, null, null, null, '2906301301', null, 0, 0, 0, 0, null, null, null, null, null, null, '0000000000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='TK3', name='TK3 ������� ��� ��� �������������� ������ �� �������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb='2906301301', mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='TK3';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='TK3';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='TK3';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='TK3';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='TK3';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'TK3', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''TK3'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='TK3';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='TK3';
end;
/
commit;
