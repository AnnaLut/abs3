set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KCT
prompt ������������ ��������: KCT = ��� �� KC1. ������ ���� ����� SG 
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KCT', 'KCT = ��� �� KC1. ������ ���� ����� SG ', 1, '#( to_char ( RAZ_KOM_PDV ( #(NLSB), 7 ) ) )', null, null, null, null, null, null, null, 0, 0, 0, 0, null, null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KCT', name='KCT = ��� �� KC1. ������ ���� ����� SG ', dk=1, nlsm='#( to_char ( RAZ_KOM_PDV ( #(NLSB), 7 ) ) )', kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s=null, s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KCT';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KCT';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KCT';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KCT';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KCT';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KCT';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KCT';
end;
/
commit;
