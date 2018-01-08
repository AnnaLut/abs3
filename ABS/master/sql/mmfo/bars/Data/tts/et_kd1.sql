set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� KD1
prompt ������������ ��������: KD1 ����� �� ������� ���� �����.
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('KD1', 'KD1 ����� �� ������� ���� �����.', 1, '#(tobopack.GetToboCASH)', 980, '#(nbs_ob22 (''6110'',''96''))', 980, null, '#(tobopack.GetToboCASH)', '#(nbs_ob22 (''6110'',''96''))', null, 0, 0, 0, 0, 'EQV_OBS ( #(KVA),F_TARIF(20, #(KVA),#(NLSA), #(S)),SYSDATE)', null, 5, null, null, null, '0000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='KD1', name='KD1 ����� �� ������� ���� �����.', dk=1, nlsm='#(tobopack.GetToboCASH)', kv=980, nlsk='#(nbs_ob22 (''6110'',''96''))', kvk=980, nlss=null, nlsa='#(tobopack.GetToboCASH)', nlsb='#(nbs_ob22 (''6110'',''96''))', mfob=null, flc=0, fli=0, flv=0, flr=0, s='EQV_OBS ( #(KVA),F_TARIF(20, #(KVA),#(NLSA), #(S)),SYSDATE)', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='KD1';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='KD1';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('SK   ', 'KD1', 'M', 0, null, '32', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''SK   '', ''KD1'', ''M'', 0, null, ''32'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='KD1';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='KD1';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='KD1';
  begin
    insert into tts_vob(vob, tt, ord)
    values (111, 'KD1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 111, ''KD1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='KD1';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='KD1';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'KD1');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''KD1'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
