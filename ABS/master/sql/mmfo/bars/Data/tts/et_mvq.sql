set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� MVQ
prompt ������������ ��������: MVQ ����� ������.������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('MVQ', 'MVQ ����� ������.������', 1, '#(tobopack.GetToboCASH)', null, '#(tobopack.GetToboCASH)', 980, null, '#(tobopack.GetToboCASH)', '#(tobopack.GetToboCASH)', null, 0, 0, 1, 0, 'f_buy_some(F_CHECK_PAYMENT(#(REF),1), #(KVA))', 'f_buy_some(F_CHECK_PAYMENT(#(REF),1), #(KVA),''E'')', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='MVQ', name='MVQ ����� ������.������', dk=1, nlsm='#(tobopack.GetToboCASH)', kv=null, nlsk='#(tobopack.GetToboCASH)', kvk=980, nlss=null, nlsa='#(tobopack.GetToboCASH)', nlsb='#(tobopack.GetToboCASH)', mfob=null, flc=0, fli=0, flv=1, flr=0, s='f_buy_some(F_CHECK_PAYMENT(#(REF),1), #(KVA))', s2='f_buy_some(F_CHECK_PAYMENT(#(REF),1), #(KVA),''E'')', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='MVQ';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='MVQ';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='MVQ';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='MVQ';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='MVQ';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='MVQ';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='MVQ';
end;
/
commit;
