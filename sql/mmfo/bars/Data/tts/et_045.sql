set lines 1000
set trimspool on
set serveroutput on size 1000000

prompt �������� / ���������� �������� !!4
prompt ������������ ��������: STOP-������� �� ���� ����������� (��� >150000���.)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!4', 'STOP-������� �� ���� ����������� (��� >150000���.)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(80045,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!4', name='STOP-������� �� ���� ����������� (��� >150000���.)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(80045,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!4';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!!4';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!4';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!4';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!!4';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!4';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!!4';
end;
/
prompt �������� / ���������� �������� !!8
prompt ������������ ��������: !!8  STOP-������� �� �������.������ ���  ���. <=1500000 ���.
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!8', '!!8  STOP-������� �� �������.������ ���  ���. <=1500000 ���.', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(80000,#(REF),'''',0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!8', name='!!8  STOP-������� �� �������.������ ���  ���. <=1500000 ���.', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(80000,#(REF),'''',0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!8';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!!8';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!8';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!8';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!!8';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!8';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!!8';
end;
/
prompt �������� / ���������� �������� !!W
prompt ������������ ��������: !!W STOP-������� (����>50���.���.) ����������� ��������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!!W', '!!W STOP-������� (����>50���.���.) ����������� ��������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(80001,#(REF),'''',0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!!W', name='!!W STOP-������� (����>50���.���.) ����������� ��������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(80001,#(REF),'''',0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!!W';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!!W';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!!W';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!!W';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!!W';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!!W';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!!W';
end;
/
prompt �������� / ���������� �������� !1G
prompt ������������ ��������: !1G ������ 1 �����(������)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!1G', '!1G ������ 1 �����(������)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(988,#(KVB),#(KVA),0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!1G', name='!1G ������ 1 �����(������)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(988,#(KVB),#(KVA),0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!1G';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!1G';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!1G';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!1G';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!1G';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!1G';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!1G';
end;
/
prompt �������� / ���������� �������� !38
prompt ������������ ��������: !38 STOP-�������. �������� ���������� ϲ�
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!38', '!38 STOP-�������. �������� ���������� ϲ�', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(153,#(KVA),'''',#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!38', name='!38 STOP-�������. �������� ���������� ϲ�', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(153,#(KVA),'''',#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!38';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!38';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!38';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!38';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!38';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!38';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!38';
end;
/
prompt �������� / ���������� �������� !39
prompt ������������ ��������: !39 STOP-�������. �������� ��������� ������� � �����. �����. �������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!39', '!39 STOP-�������. �������� ��������� ������� � �����. �����. �������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'CHECK_DESTRUCT_PASSP_VIZA(#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!39', name='!39 STOP-�������. �������� ��������� ������� � �����. �����. �������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='CHECK_DESTRUCT_PASSP_VIZA(#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!39';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!39';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!39';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!39';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!39';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!39';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!39';
end;
/
prompt �������� / ���������� �������� !45
prompt ������������ ��������: !45 STOP-������� �� ����� �����������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!45', '!45 STOP-������� �� ����� �����������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(100,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!45', name='!45 STOP-������� �� ����� �����������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(100,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!45';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!45';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!45';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!45';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!45';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!45';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!45';
end;
/
prompt �������� / ���������� �������� !AA
prompt ������������ ��������: !AA STOP-������� �� ������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AA', '!AA STOP-������� �� ������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(100,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000010000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AA', name='!AA STOP-������� �� ������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(100,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000010000000000000000000000000000000000000000000', nazn=null
       where tt='!AA';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!AA';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!AA';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!AA';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!AA';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!AA';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!AA';
end;
/
prompt �������� / ���������� �������� !AB
prompt ������������ ��������: !AB STOP-������� �� ������/������ �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AB', '!AB STOP-������� �� ������/������ �����', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(980,#(KVA),'''',#(S))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AB', name='!AB STOP-������� �� ������/������ �����', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(980,#(KVA),'''',#(S))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!AB';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!AB';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!AB';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!AB';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!AB';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!AB';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!AB';
end;
/
prompt �������� / ���������� �������� !AG
prompt ������������ ��������: !AG STOP-������� �������� ��� �� ������ ���������
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!AG', '!AG STOP-������� �������� ��� �� ������ ���������', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(151,#(KVA),'''',#(S),#(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!AG', name='!AG STOP-������� �������� ��� �� ������ ���������', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(151,#(KVA),'''',#(S),#(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!AG';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!AG';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!AG';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!AG';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!AG';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!AG';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!AG';
end;
/
prompt �������� / ���������� �������� !PA
prompt ������������ ��������: !PA ���������� ���.��������(ID-PASP)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!PA', '!PA ���������� ���.��������(ID-PASP)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'f_check_tag(#(REF),''PASP'')', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!PA', name='!PA ���������� ���.��������(ID-PASP)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='f_check_tag(#(REF),''PASP'')', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!PA';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!PA';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!PA';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!PA';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!PA';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!PA';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!PA';
end;
/
prompt �������� / ���������� �������� !UM
prompt ������������ ��������: !UM STOP-������� �� ���� ������� �������� (��� <50000���.)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('!UM', '!UM STOP-������� �� ���� ������� �������� (��� <50000���.)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(80102,#(KVA),'''',#(S), #(REF))', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='!UM', name='!UM STOP-������� �� ���� ������� �������� (��� <50000���.)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(80102,#(KVA),'''',#(S), #(REF))', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='!UM';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='!UM';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='!UM';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='!UM';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='!UM';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='!UM';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='!UM';
end;
/
prompt �������� / ���������� �������� 046
prompt ������������ ��������: 046 d: ����� ������i��� ������� (S2) ������ �� ����� ���i��i
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('046', '046 d: ����� ������i��� ������� (S2) ������ �� ����� ���i��i', 1, null, 980, null, null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 0, 0, 1, 0, 'EQV_OBS(#(KVB),case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end,BANKDATE,1)', 'case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end', 56, null, '#(nbs_ob22 (''3800'',''10''))', null, '0000100000000000000000000000000000010100000000000000000000000000', '����� ������i��� ������� (S2) ������ �� ����� ���i��i');
  exception
    when dup_val_on_index then 
      update tts
         set tt='046', name='046 d: ����� ������i��� ������� (S2) ������ �� ����� ���i��i', dk=1, nlsm=null, kv=980, nlsk=null, kvk=null, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=0, fli=0, flv=1, flr=0, s='EQV_OBS(#(KVB),case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end,BANKDATE,1)', s2='case when #(KVB)=840 then MOD(#(S2),100) when #(KVB) in (978,826,124) then MOD(#(S2),500) when #(KVB) in (756,643,985) then MOD(#(S2),1000) else 0 end', sk=56, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='0000100000000000000000000000000000010100000000000000000000000000', nazn='����� ������i��� ������� (S2) ������ �� ����� ���i��i'
       where tt='046';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='046';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '046', 'O', 0, null, '261', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#73 '', ''046'', ''O'', 0, null, ''261'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='046';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='046';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='046';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='046';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='046';
end;
/
prompt �������� / ���������� �������� 45!
prompt ������������ ��������: 45! ������ 1 �����(�����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('45!', '45! ������ 1 �����(�����)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(988,#(KVA),#(KVB),0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='45!', name='45! ������ 1 �����(�����)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(988,#(KVA),#(KVB),0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='45!';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='45!';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='45!';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='45!';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='45!';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='45!';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='45!';
end;
/
prompt �������� / ���������� �������� 46!
prompt ������������ ��������: 46! �����������(��� �� ����)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('46!', '46! �����������(��� �� ����)', 1, null, null, null, null, null, null, null, null, 0, 0, 0, 0, 'F_STOP(989,#(KVA),#(KVB),0)', null, null, null, null, null, '0100000000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='46!', name='46! �����������(��� �� ����)', dk=1, nlsm=null, kv=null, nlsk=null, kvk=null, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_STOP(989,#(KVA),#(KVB),0)', s2=null, sk=null, proc=null, s3800=null, rang=null, flags='0100000000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='46!';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='46!';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='46!';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='46!';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='46!';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='46!';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='46!';
end;
/
prompt �������� / ���������� �������� A22
prompt ������������ ��������: A22 d: ����� �� ����������� ��������� �����
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('A22', 'A22 d: ����� �� ����������� ��������� �����', 1, '#(tobopack.GetToboParam(''CASH''))', 980, '#(nbs_ob22 (''6514'',''34''))', 980, null, null, null, null, 0, 0, 0, 0, 'F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))', null, 5, null, null, null, '0000100000000000000000000000000000000000000000000000000000000000', null);
  exception
    when dup_val_on_index then 
      update tts
         set tt='A22', name='A22 d: ����� �� ����������� ��������� �����', dk=1, nlsm='#(tobopack.GetToboParam(''CASH''))', kv=980, nlsk='#(nbs_ob22 (''6514'',''34''))', kvk=980, nlss=null, nlsa=null, nlsb=null, mfob=null, flc=0, fli=0, flv=0, flr=0, s='F_TARIF_CONV(122,#(KVA),#(NLSA),#(S))', s2=null, sk=5, proc=null, s3800=null, rang=null, flags='0000100000000000000000000000000000000000000000000000000000000000', nazn=null
       where tt='A22';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='A22';
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='A22';
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='A22';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='A22';
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='A22';
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='A22';
end;
/
prompt �������� / ���������� �������� 045
prompt ������������ ��������: 045  ���������i� ���. ���. (� ���i�i��)
declare
  cnt_  number;
begin
  --------------------------------
  -- �������� �������� �������� --
  --------------------------------
  begin
    insert into tts(tt, name, dk, nlsm, kv, nlsk, kvk, nlss, nlsa, nlsb, mfob, flc, fli, flv, flr, s, s2, sk, proc, s3800, rang, flags, nazn)
    values ('045', '045  ���������i� ���. ���. (� ���i�i��)', 1, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, null, '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', '#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', null, 1, 0, 1, 0, null, null, null, null, '#(nbs_ob22 (''3800'',''10''))', null, '1000110000010000000000000000000000010000000000000000000000000000', '���������i� �������� ������ ');
  exception
    when dup_val_on_index then 
      update tts
         set tt='045', name='045  ���������i� ���. ���. (� ���i�i��)', dk=1, nlsm='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kv=null, nlsk='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', kvk=null, nlss=null, nlsa='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', nlsb='#(BRANCH_USR.GET_BRANCH_PARAM2(''CASH'',0))', mfob=null, flc=1, fli=0, flv=1, flr=0, s=null, s2=null, sk=null, proc=null, s3800='#(nbs_ob22 (''3800'',''10''))', rang=null, flags='1000110000010000000000000000000000010000000000000000000000000000', nazn='���������i� �������� ������ '
       where tt='045';
  end;
  --------------------------------
  ----------- ��������� ----------
  --------------------------------
  delete from op_rules where tt='045';
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('73046', '045', 'M', 0, 41, '261', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''73046'', ''045'', ''M'', 0, 41, ''261'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ADRES', '045', 'O', 1, 7, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ADRES'', ''045'', ''O'', 1, 7, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('ATRT ', '045', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''ATRT '', ''045'', ''O'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('BPLAC', '045', 'O', 1, 31, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''BPLAC'', ''045'', ''O'', 1, 31, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('D#73 ', '045', 'M', 0, 41, '270', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''D#73 '', ''045'', ''M'', 0, 41, ''270'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DJER ', '045', 'O', 1, 40, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DJER '', ''045'', ''O'', 1, 40, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('DT_R ', '045', 'O', 1, 8, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''DT_R '', ''045'', ''O'', 1, 8, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FIO  ', '045', 'M', 1, 1, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FIO  '', ''045'', ''M'', 1, 1, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('FSVSN', '045', 'O', 1, 39, '����������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''FSVSN'', ''045'', ''O'', 1, 39, ''����������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('IDDO ', '045', 'O', 1, 19, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''IDDO '', ''045'', ''O'', 1, 19, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_B', '045', 'O', 0, 9, '276', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_B'', ''045'', ''O'', 0, 9, ''276'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_G', '045', 'M', 1, 10, '804', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_G'', ''045'', ''M'', 1, 10, ''804'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KOD_N', '045', 'M', 0, 11, '2343003', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KOD_N'', ''045'', ''M'', 0, 11, ''2343003'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('KURS ', '045', 'M', 0, 12, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''KURS '', ''045'', ''M'', 0, 12, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('NATIO', '045', 'O', 1, 32, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''NATIO'', ''045'', ''O'', 1, 32, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('O_REP', '045', 'O', 1, 36, '���������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''O_REP'', ''045'', ''O'', 1, 36, ''���������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASP ', '045', 'O', 1, 2, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASP '', ''045'', ''O'', 1, 2, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PASPN', '045', 'O', 1, 3, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PASPN'', ''045'', ''O'', 1, 3, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PHONE', '045', 'O', 1, 34, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PHONE'', ''045'', ''O'', 1, 34, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PHONW', '045', 'O', 1, 35, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PHONW'', ''045'', ''O'', 1, 35, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('PUBLP', '045', 'O', 1, 38, 'ͳ', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''PUBLP'', ''045'', ''O'', 1, 38, ''ͳ'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('REZID', '045', 'O', 1, 6, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''REZID'', ''045'', ''O'', 1, 6, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('RIZIK', '045', 'O', 1, 37, '�������', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''RIZIK'', ''045'', ''O'', 1, 37, ''�������'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('RNOKP', '045', 'O', 1, 4, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''RNOKP'', ''045'', ''O'', 1, 4, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into op_rules(TAG, TT, OPT, USED4INPUT, ORD, VAL, NOMODIFY)
    values ('WORK ', '045', 'O', 1, 33, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (op_rules: ''WORK '', ''045'', ''O'', 1, 33, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------ ��������� �������� ------
  --------------------------------
  delete from ttsap where tt='045';
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!4', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!!4'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!8', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!!8'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!!W', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!!W'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!1G', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!1G'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!38', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!38'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!39', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!39'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!45', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!45'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!AA', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!AA'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!AB', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!AB'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!AG', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!AG'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!PA', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!PA'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('!UM', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''!UM'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('046', '045', 1);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''046'', ''045'', 1) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('45!', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''45!'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('46!', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''46!'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into ttsap(ttap, tt, dk)
    values ('A22', '045', 0);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (ttsap: ''A22'', ''045'', 0) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------- ���������� ����� -------
  --------------------------------
  delete from ps_tts where tt='045';
  --------------------------------
  -------- ���� ���������� -------
  --------------------------------
  delete from tts_vob where tt='045';
  begin
    insert into tts_vob(vob, tt, ord)
    values (90, '045', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (tts_vob: 90, ''045'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  -------- ������ �������� -------
  --------------------------------
  delete from chklist_tts where tt='045';
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (1, '045', 2, null, 'f_universal_box2(USERID)=1', null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 1, ''045'', 2, null, ''f_universal_box2(USERID)=1'', null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  begin
    insert into chklist_tts(idchk, tt, priority, f_big_amount, sqlval, f_in_charge)
    values (5, '045', 1, null, null, null);
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (chklist_tts: 5, ''045'', 1, null, null, null) - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
  --------------------------------
  ------------- ����� ------------
  --------------------------------
  delete from folders_tts where tt='045';
  begin
    insert into folders_tts(idfo, tt)
    values (12, '045');
  exception
    when dup_val_on_index then null;
    when others then
      if ( sqlcode = -02291 ) then
        dbms_output.put_line('�� ������� �������� ������ (folders_tts: 12, ''045'') - ��������� ���� �� ������!');
      else raise;
      end if;
  end;
end;
/
commit;
