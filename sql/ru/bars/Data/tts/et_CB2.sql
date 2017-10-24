set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� CB2
prompt ������������ ��������: CB2 ������� ������ (���) �� �볺�� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('CB2', 'CB2 ������� ������ (���) �� �볺�� �����', 1, '#(nbs_ob22 (''2909'',''27''))', null, '#(nbs_ob22 (''2909'',''27''))', null, null, null, null, null, 0, 0, 0, 0, '(GL.P_ICURVAL(#(KVA),F_TARIF(36,#(KVA),#(NLSA),#(S)),BANKDATE))*(.775)', 'gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(36,#(KVA),#(NLSA),#(S)),bankdate))*(.775),bankdate)', null, null, null, null, '0001100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='CB2', name='CB2 ������� ������ (���) �� �볺�� �����', dk=1, nlsm='#(nbs_ob22 (''2909'',''27''))', kv=null, nlsk='#(nbs_ob22 (''2909'',''27''))', kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='(GL.P_ICURVAL(#(KVA),F_TARIF(36,#(KVA),#(NLSA),#(S)),BANKDATE))*(.775)', s2='gl.p_ncurval(#(KVA),(gl.p_icurval(#(KVA),F_TARIF(36,#(KVA),#(NLSA),#(S)),bankdate))*(.775),bankdate)', sk=null, proc=null, s3800=null, rang=null, flags='0001100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='CB2';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='CB2';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='CB2';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='CB2';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('26  ', 'CB2', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''26  '', ''CB2'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='CB2';
  begin
    insert into tts_vob(vob, tt, ord)
    values (1, 'CB2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 1, ''CB2'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'CB2', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''CB2'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='CB2';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, 'CB2', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''CB2'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='CB2';
  begin
    insert into folders_tts(idfo, tt)
    values (25, 'CB2');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 25, ''CB2'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
