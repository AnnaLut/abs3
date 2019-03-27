set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� K72
prompt ������������ ��������: K72 �����. 3570 ���i�i� �� ��� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('K72', 'K72 �����. 3570 ���i�i� �� ��� ������', 1, '#(get_nls_tt(''K72'',''NLSM'',p_nlsa=>#(NLSA)))', 980, '#(nbs_ob22 (''6510'',''99''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CEK( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', null, null, null, null, null, '0000000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='K72', name='K72 �����. 3570 ���i�i� �� ��� ������', dk=1, nlsm='#(get_nls_tt(''K72'',''NLSM'',p_nlsa=>#(NLSA)))', kv=980, nlsk='#(nbs_ob22 (''6510'',''99''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CEK( F_DOP(#(REF),''Z_CEK''), #(KVA),#(NLSA),#(S) )', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0000000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='K72';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='K72';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='K72';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='K72';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='K72';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='K72';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='K72';
  begin
    insert into folders_tts(idfo, tt)
    values (2, 'K72');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 2, ''K72'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;