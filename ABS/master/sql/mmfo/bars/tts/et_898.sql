set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 898
prompt ������������ ��������: 898 - "����" SWIFT ����� Commerzbank
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('898', '898 - "����" SWIFT ����� Commerzbank', 1, '3739401901', 978, '150072188', 978, null, '3739401901', '150072188', '300465', 0, 0, 0, 0, '#(S)-F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,10000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='898', name='898 - "����" SWIFT ����� Commerzbank', dk=1, nlsm='3739401901', kv=978, nlsk='150072188', kvk=978, nlss=null, nlsa='3739401901', nlsb='150072188', mfob='300465', flc=0, fli=0, flv=0, flr=0, s='#(S)-F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,10000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='898';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='898';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='898';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='898';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='898';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='898';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='898';
end;
/
commit;
