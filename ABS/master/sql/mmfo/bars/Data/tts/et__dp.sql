set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� _DP
prompt ������������ ��������: ������� �� DP2,3,I,J(2630/2635-2909(19)-2630/2635)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('_DP', '������� �� DP2,3,I,J(2630/2635-2909(19)-2630/2635)', 1, null, null, '#(dpt_get_transit(#(NLSA),#(NLSB),#(KVA)))', null, null, null, null, null, 0, 0, 0, 0, '(dpt_get_s_transit(#(NLSA),#(NLSB),#(KVA),#(S)))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='_DP', name='������� �� DP2,3,I,J(2630/2635-2909(19)-2630/2635)', dk=1, nlsm=null, kv=null, nlsk='#(dpt_get_transit(#(NLSA),#(NLSB),#(KVA)))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(dpt_get_s_transit(#(NLSA),#(NLSB),#(KVA),#(S)))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='_DP';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='_DP';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='_DP';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='_DP';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='_DP';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='_DP';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='_DP';
end;
/
commit;
