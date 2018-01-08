set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� TM4
prompt ������������ ��������: TM4 5) # TM4 - ��� �� TMK
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('TM4', 'TM4 5) # TM4 - ��� �� TMK', 0, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, null, null, null, null, 0, 0, 1, 0, 'ROUND(#(S)*(SELECT DECODE(NVL(VES_UN,0),0, VES/31.1034807, VES_UN )FROM V_BANK_METALS_BRANCH B,OPERW W WHERE W.REF=#(REF) AND W.TAG=''N_BMK'' AND W.VALUE=N_BMK(B.KOD)),0)', '(#(S)/100)*(select cena_k from v_bank_metals_branch b, operw w where w.ref=#(REF) and w.tag=''N_BMK'' and w.value=N_BMK(b.kod))', 30, null, '#(nbs_ob22 (''3800'',''09''))', null, '0000100001000000000000000000000000010000000000000000000000010000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='TM4', name='TM4 5) # TM4 - ��� �� TMK', dk=0, nlsm=null, kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='ROUND(#(S)*(SELECT DECODE(NVL(VES_UN,0),0, VES/31.1034807, VES_UN )FROM V_BANK_METALS_BRANCH B,OPERW W WHERE W.REF=#(REF) AND W.TAG=''N_BMK'' AND W.VALUE=N_BMK(B.KOD)),0)', s2='(#(S)/100)*(select cena_k from v_bank_metals_branch b, operw w where w.ref=#(REF) and w.tag=''N_BMK'' and w.value=N_BMK(b.kod))', sk=30, proc=null, s3800='#(nbs_ob22 (''3800'',''09''))', rang=null, flags='0000100001000000000000000000000000010000000000000000000000010000', nazn=null
       where tt='TM4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='TM4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='TM4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='TM4';
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', 'TM4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1001'', ''TM4'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1001', 'TM4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1001'', ''TM4'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', 'TM4', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1002'', ''TM4'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ps_tts(nbs, tt, dk)
    values ('1002', 'TM4', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ps_tts: ''1002'', ''TM4'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='TM4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='TM4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='TM4';
  begin
    insert into folders_tts(idfo, tt)
    values (77, 'TM4');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 77, ''TM4'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
