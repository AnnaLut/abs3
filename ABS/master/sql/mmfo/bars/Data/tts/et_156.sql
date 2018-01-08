set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� 156
prompt ������������ ��������: d: ����� �� ������ �� AmericanExpress (153)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('156', 'd: ����� �� ������ �� AmericanExpress (153)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', 980, '#(BRANCH_USR.GET_BRANCH_PARAM2(''DOR_KOMIS'',0))', 980, null, null, null, null, 0, 0, 0, 0, 'GL.P_ICURVAL( #(KVA), F_TARIF (31, #(KVA), #(NLSA), #(S) ), SYSDATE)', null, 5, null, null, null, '0100100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='156', name='d: ����� �� ������ �� AmericanExpress (153)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=980, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''DOR_KOMIS'',0))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='GL.P_ICURVAL( #(KVA), F_TARIF (31, #(KVA), #(NLSA), #(S) ), SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0100100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='156';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='156';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('73156', '156', 'O', 0, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''73156'', ''156'', ''O'', 0, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='156';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='156';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='156';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='156';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='156';
  begin
    insert into folders_tts(idfo, tt)
    values (21, '156');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 21, ''156'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
