set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 128
prompt ������������ ��������: 128  ����� �� ������ �����Ͳ� ��ʲ� (�����.���������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('128', '128  ����� �� ������ �����Ͳ� ��ʲ� (�����.���������)', 0, '#(tobopack.GetToboParam(''CASH''))', 980, '#(nbs_ob22 (''6510'',''A9''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(35,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0100100000000000000000000000000000010000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='128', name='128  ����� �� ������ �����Ͳ� ��ʲ� (�����.���������)', dk=0, nlsm='#(tobopack.GetToboParam(''CASH''))', kv=980, nlsk='#(nbs_ob22 (''6510'',''A9''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(35,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000010000000000000000000000000000', nazn=null
       where tt='128';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='128';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='128';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='128';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='128';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='128';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='128';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '128');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''128'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
