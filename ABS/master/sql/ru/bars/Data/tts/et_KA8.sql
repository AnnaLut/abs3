set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KA8
prompt ������������ ��������: (���. �20) ����� 3570(03)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KA8', '(���. �20) ����� 3570(03)', 1, '#(nbs_ob22_RNK (''3570'',''03'',#(NLSA),980))', null, '#( to_char ( RAZ_KOM_PDV ( #(NLSB), 3 ) ) )', null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KA8', name='(���. �20) ����� 3570(03)', dk=1, nlsm='#(nbs_ob22_RNK (''3570'',''03'',#(NLSA),980))', kv=null, nlsk='#( to_char ( RAZ_KOM_PDV ( #(NLSB), 3 ) ) )', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KA8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KA8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KA8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KA8';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KA8';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KA8';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KA8';
end;
/
commit;
