set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� $VZ
prompt ������������ ��������: ³������� ��� �� ��������� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('$VZ', '³������� ��� �� ��������� ������', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0)) ', 980, '#(get_nls_tt(''$VZ'',''NLSK''))', 980, null, null, null, null, 0, 0, 0, 0, 'round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', 'round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', 12, null, '0', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='$VZ', name='³������� ��� �� ��������� ������', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0)) ', kv=980, nlsk='#(get_nls_tt(''$VZ'',''NLSK''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', s2='round( gl.p_icurval(#(KVA), #(S_KUT)*100, gl.bd) * #(S_KIL) *0.015)', sk=12, proc=null, s3800='0', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='$VZ';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='$VZ';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='$VZ';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='$VZ';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='$VZ';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='$VZ';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='$VZ';
end;
/
commit;
