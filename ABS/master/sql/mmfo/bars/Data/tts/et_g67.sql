set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� G67
prompt ������������ ��������: G67 �����.�����.���i�i� �� ���
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('G67', 'G67 �����.�����.���i�i� �� ���', 1, '#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', 980, '#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', 980, null, null, null, null, 0, 0, 0, 0, 'Case When #(KVA)=980 Then F_TARIF(32,#(KVA),#(NLSA),#(S)) Else F_TARIF_00F(0,#(KVA),#(NLSA),#(S)) End', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='G67', name='G67 �����.�����.���i�i� �� ���', dk=1, nlsm='#(nbs_ob22_RKO (''2600'',''01'',#(NLSA),#(KVA)))', kv=980, nlsk='#(nbs_ob22_3570 (''3570'',''03'',#(NLSA),#(KVA)))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='Case When #(KVA)=980 Then F_TARIF(32,#(KVA),#(NLSA),#(S)) Else F_TARIF_00F(0,#(KVA),#(NLSA),#(S)) End', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='G67';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='G67';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='G67';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='G67';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='G67';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='G67';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='G67';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'G67');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''G67'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
