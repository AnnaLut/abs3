set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KD4
prompt ������������ ��������: ���i�i� �� ������� �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD4', '���i�i� �� ������� �������', 1, null, null, '#(nbs_ob22 (''6110'',''09''))', null, null, null, '#(nbs_ob22 (''6110'',''09''))', null, 0, 0, 0, 0, 'F_TARIF(23, #(KVA),#(NLSA), #(NOM))', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KD4', name='���i�i� �� ������� �������', dk=1, nlsm=null, kv=null, nlsk='#(nbs_ob22 (''6110'',''09''))', kvk=null, nlss=null, nlsa=null, nlsb='#(nbs_ob22 (''6110'',''09''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF(23, #(KVA),#(NLSA), #(NOM))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='KD4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KD4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KD4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KD4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KD4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KD4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KD4';
end;
/
commit;
