set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CVF
prompt ������������ ��������: CVF ��������� ����.��� ������-��� � ��.���������� 6204 (�������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CVF', 'CVF ��������� ����.��� ������-��� � ��.���������� 6204 (�������)', 1, null, null, null, null, null, null, null, null, 0, 0, 1, 0, null, null, null, null, '#( VP_FX ( #(KVA)  )  )', null, '1000100000000000000000000000000000010000000000000000000000010000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CVF', name='CVF ��������� ����.��� ������-��� � ��.���������� 6204 (�������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#( VP_FX ( #(KVA)  )  )', rang=null, flags='1000100000000000000000000000000000010000000000000000000000010000', nazn=null
       where tt='CVF';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CVF';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CVF';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CVF';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CVF';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CVF';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (17, 'CVF', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 17, ''CVF'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CVF';
end;
/
commit;
