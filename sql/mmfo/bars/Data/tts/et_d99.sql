set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� D99
prompt ������������ ��������: D99 - %% �� ������� �� ������ 10% - ������� (10%-D90)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('D99', 'D99 - %% �� ������� �� ������ 10% - ������� (10%-D90)', 1, '74192031501501', 980, null, null, null, null, null, null, 0, 0, 1, 0, '0.1  *  gl.p_icurval( #(KVA), #(S), bankdate )', '0.1 * #(S)', null, null, '#(nbs_ob22 (''3800'',''03''))', null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='D99', name='D99 - %% �� ������� �� ������ 10% - ������� (10%-D90)', dk=1, nlsm='74192031501501', kv=980, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='0.1  *  gl.p_icurval( #(KVA), #(S), bankdate )', s2='0.1 * #(S)', sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='D99';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='D99';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='D99';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='D99';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='D99';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='D99';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='D99';
end;
/
commit;
