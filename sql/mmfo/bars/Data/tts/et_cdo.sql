set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CDO
prompt ������������ ��������: (���.CDA) ����� ����� �� ������ ��������  WU/��/���(���������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CDO', '(���.CDA) ����� ����� �� ������ ��������  WU/��/���(���������)', 1, '#(nbs_ob22 (''2909'',''27''))', 980, '#(nbs_ob22 (''6110'',''75''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(134,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.776*(GL.P_ICURVAL(#(KVA),F_TARIF(134,#(KVA),#(NLSA),#(S)),SYSDATE)))', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CDO', name='(���.CDA) ����� ����� �� ������ ��������  WU/��/���(���������)', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=980, nlsk='#(nbs_ob22 (''6110'',''75''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(134,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.776*(GL.P_ICURVAL(#(KVA),F_TARIF(134,#(KVA),#(NLSA),#(S)),SYSDATE)))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CDO';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CDO';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CDO';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CDO';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CDO';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CDO';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CDO', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CDO'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CDO', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CDO'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CDO';
end;
/
commit;
