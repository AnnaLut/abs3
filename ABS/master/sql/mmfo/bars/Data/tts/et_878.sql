set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 878
prompt ������������ ��������: 878 - ����� "����" SWIFT
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('878', '878 - ����� "����" SWIFT', 1, null, null, '61147010106521', 980, null, null, '61147010106521', '300465', 0, 0, 1, 0, 'F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', 'gl.p_icurval( #(KVA),F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4, 4, 5),#(KVA),#(NLSA),#(S)),bankdate)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='878', name='878 - ����� "����" SWIFT', dk=1, nlsm=null, kv=null, nlsk='61147010106521', kvk=980, nlss=null, nlsa=null, nlsb='61147010106521', mfob='300465', flc=0, fli=0, flv=1, flr=0, s='F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4,4, 5),#(KVA),#(NLSA),#(S))', s2='gl.p_icurval( #(KVA),F_TARIF(IIF_N(gl.p_Icurval(#(KVA),#(S),bankdate),gl.p_Icurval( 840,20000,bankdate), 4, 4, 5),#(KVA),#(NLSA),#(S)),bankdate)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='878';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='878';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='878';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='878';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='878';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='878';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='878';
end;
/
commit;
