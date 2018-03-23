/* formatted on 05.10.2017 12:00:03 (qp5 v5.269.14213.34746) */

-- 225 ������������� ����� ��� ���������� ����., ���. �� ������.��������: -	������ ��������� ��� �2� ��������, ��� �11� ������;
begin
    delete from chklist_tts
    where idchk = 2 and tt = '225';

    commit;
end;
/

begin
    insert into bars.chklist_tts (tt, idchk, priority, f_in_charge)
    values ('225', 11, 2, 0);

    commit;
exception
    when dup_val_on_index then
         null;
end;
/

-- 428 �������� ���� (�� ������ ������� ����): -	��������� ������� �� ������� ������� 1001, 1002 �������� �������� ����������� ������ ��22 �01�;
-- 429 ������� ���� (�� ������ ������� ����): -	��������� ������� �� �������� ������� 1001, 1002 �������� �������� ����������� ������ ��22 �01�;
begin
    delete ps_tts
    where tt in ('428', '429') and nbs in ('1001', '1002') and ob22 = '01';

    commit;
end;
/

-- 225 ������������� ����� ��� ���������� �������, ��������� �� �������������� ��������:-	������ �������� �������� � ����� 26 ������������������ ��������� �� ������ � ����� 16 ����� ��������
begin
    update folders_tts
    set    idfo = '16'
    where  tt = '225';

    commit;
end;
/

-- OW4 �������� � ��� ����� ����� (�������������): -	��������� ������� ������ �� �������� ������� 2600, 3578.
begin
    insert into bars.ps_tts (tt, nbs, dk)
    values ('OW4', '2600', 1);

    commit;
exception
    when dup_val_on_index then
         null;
end;
/

begin
    insert into bars.ps_tts (tt, nbs, dk)
    values ('OW4', '3578', 1);

    commit;
exception
    when dup_val_on_index then
         null;
end;
/

