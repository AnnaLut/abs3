set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CD8
prompt ������������ ��������: (���.CA8) ����� ����� �� ������ �������� ��� �COINSTAR�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CD8', '(���.CA8) ����� ����� �� ������ �������� ��� �COINSTAR�', 1, '#(nbs_ob22 (''2909'',''46''))', 980, '#(nbs_ob22 (''6110'',''85''))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.776*(GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)))', null, null, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CD8', name='(���.CA8) ����� ����� �� ������ �������� ��� �COINSTAR�', dk=1, nlsm='#(nbs_ob22 (''2909'',''46''))', kv=980, nlsk='#(nbs_ob22 (''6110'',''85''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)-ROUND(0.776*(GL.P_ICURVAL(#(KVA),F_TARIF(43,#(KVA),#(NLSA),#(S)),SYSDATE)))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CD8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CD8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CD8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CD8';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CD8';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CD8';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (2, 'CD8', 2, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 2, ''CD8'', 2, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CD8', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CD8'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CD8';
end;
/
commit;
