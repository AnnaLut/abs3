set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !DV
prompt ������������ ��������: !DV !����-������� ����.160  03 ������� 2015 � (15 ��� � ��� ��� ���. �
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!DV', '!DV !����-������� ����.160  03 ������� 2015 � (15 ��� � ��� ��� ���. �', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(160,#(KVA),#(NLSA),#(S), #(REF))', null, null, null, null, 0, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!DV', name='!DV !����-������� ����.160  03 ������� 2015 � (15 ��� � ��� ��� ���. �', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(160,#(KVA),#(NLSA),#(S), #(REF))', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='!DV';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!DV';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!DV';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!DV';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!DV';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!DV';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!DV';
  begin
    insert into folders_tts(idfo, tt)
    values (1, '!DV');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''!DV'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
