BEGIN
    BEGIN
        EXECUTE IMMEDIATE
            'insert into branch_tags (tag, name) values (''BEK_BOSS_FIO'', ''���: ���� ����� �� ��������� ����� ϲ� �������� ���-�����'')';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            NULL;
    END;

    BEGIN
        EXECUTE IMMEDIATE
            'insert into branch_tags (tag, name) values (''BEK_BOSS_POS'', ''���: ���� ����� �� ��������� ����� ������ �������� ���-�����'')';
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX
        THEN
            NULL;
    END;

    COMMIT;
END;
/