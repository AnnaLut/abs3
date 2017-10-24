set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� IMM
prompt ������������ ��������: ����������� ��������� �� ������(6110/28)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('IMM', '����������� ��������� �� ������(6110/28)', 0, '#(get_611028(#(REF)))', 980, null, null, null, null, null, null, 0, 0, 1, 0, 'GL.P_ICURVAL(#(KVA), #(S), GL.BD)', null, null, null, '#(nbs_ob22 (''3800'',''03''))', 1000, '1000100000000000000000000000000000000100000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='IMM', name='����������� ��������� �� ������(6110/28)', dk=0, nlsm='#(get_611028(#(REF)))', kv=980, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=1, flr=0, s='GL.P_ICURVAL(#(KVA), #(S), GL.BD)', s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''03''))', rang=1000, flags='1000100000000000000000000000000000000100000000000000000000000000', nazn=null
       where tt='IMM';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='IMM';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='IMM';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='IMM';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='IMM';
  begin
    insert into tts_vob(vob, tt, ord)
    values (6, 'IMM', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 6, ''IMM'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='IMM';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='IMM';
end;
/
commit;
