begin
    bars.branch_attribute_utl.add_new_attribute('NBU_601_CORE_DATA_REQUEST_MODE',
                                                '����� ����� ������ ��� ���������� ���� 601 (CENTRALIZED - ������ �� ���������� ����� ��������� � ��, DECENTRALIZED - ��� ��������� ��)',
                                                'C');

    bars.branch_attribute_utl.set_attribute_value('/', 'NBU_601_CORE_DATA_REQUEST_MODE', 'CENTRALIZED');

    commit;
end;
/
