-- ���������� �� ������

--SWIFT. ������ ������ ���������	begin BARS_SWIFT.PUT_NOS_VISA; end;
--����������� ������� �� �������	begin dpt_execute_job('JOB_INTX', null); end;
--#5) �� F13: ���i����� ����������� %% �� ��� ���. � �� ��	begin bars.p_interest_cck(NULL,7, gl.bd); end;
--�� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��	begin cck_sber('2', '5', null); end;
--�� S42: ����������� %% �� �������� �����. ����� � �� ��	begin bars.p_interest_cck(NULL,6, gl.bd); end;
--��������� ������.�� ��: �� 2600 - �� 3570,3579	begin rko_finis(gl.bd); end;
--�������������� �������� SNAP �� ����	begin draps(gl.bd); end;
--#2) �� S38: ������-�� �� �����. ���. ����� ��� � ���� ����� ��	begin cck_sber('3', '4', null); end;
--Start/ ����-��������� ������� ����� SS - ��	begin cck.cc_asp(-11, 1); end;

delete from tms_task where id in (202,124,161,265,165,110,138,130,89);
commit;


-- ���������  - ������������ ��������� ASG
update tms_task set state_id = 1 where id = 371;
commit;
