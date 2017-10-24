set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K00
prompt ������������ ��������: �00 ����� �� ���� ��������� ��������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K00', '�00 ����� �� ���� ��������� ��������', 0, null, null, '#(nbs_ob22 (''6110'',''06''))', 980, null, null, null, null, 0, 0, 0, 0, 'DECODE(SIGN(TO_CHAR(SYSDATE,''HH24MI'')-1500),1,F_TARIF(99,#(KVA),#(NLSA),#(S)),0)', null, null, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', '����� �� �������� ��������� ���� 15:00 (0,5% �� ����)');
  exception
    when dup_val_on_index then 
      update tts
         set tt='K00', name='�00 ����� �� ���� ��������� ��������', dk=0, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6110'',''06''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='DECODE(SIGN(TO_CHAR(SYSDATE,''HH24MI'')-1500),1,F_TARIF(99,#(KVA),#(NLSA),#(S)),0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn='����� �� �������� ��������� ���� 15:00 (0,5% �� ����)'
       where tt='K00';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K00';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K00';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K00';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K00';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K00';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K00';
end;
/
commit;
