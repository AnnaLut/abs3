set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� A22
prompt ������������ ��������: d: ����� �� ����������� ��������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('A22', 'd: ����� �� ����������� ��������� �����', 1, '#(tobopack.GetToboParam(''CASH''))', 980, '#(nbs_ob22 (''6114'',''34''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='A22', name='d: ����� �� ����������� ��������� �����', dk=1, nlsm='#(tobopack.GetToboParam(''CASH''))', kv=980, nlsk='#(nbs_ob22 (''6114'',''34''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='A22';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='A22';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='A22';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='A22';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='A22';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='A22';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='A22';
end;
/
commit;
