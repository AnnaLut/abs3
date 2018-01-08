set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� G0F
prompt ������������ ��������: G0F �����.�����.���i�i� �� ���.�� �i���������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G0F', 'G0F �����.�����.���i�i� �� ���.�� �i���������', 1, '#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_00F( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G0F', name='G0F �����.�����.���i�i� �� ���.�� �i���������', dk=1, nlsm='#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_00F( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='G0F';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='G0F';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G0F';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G0F';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='G0F';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G0F';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='G0F';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'G0F');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''G0F'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
