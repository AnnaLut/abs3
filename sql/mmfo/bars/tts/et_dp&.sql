set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� DP&
prompt ������������ ��������: +D: STOP-������� �� ��������� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('DP&', '+D: STOP-������� �� ��������� ������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'BARS.F_DPT_STOP(0,#(KVA),#(NLSA),#(S),BANKDATE)', null, null, null, null, 0, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='DP&', name='+D: STOP-������� �� ��������� ������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='BARS.F_DPT_STOP(0,#(KVA),#(NLSA),#(S),BANKDATE)', s2=null, sk=null, proc=null, s3800=null, rang=0, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='DP&';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='DP&';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='DP&';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='DP&';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='DP&';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='DP&';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='DP&';
  begin
    insert into folders_tts(idfo, tt)
    values (1, 'DP&');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 1, ''DP&'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
