begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('CUST_RKO_DOD_BANK AGREEMENT_UO', '����_���.���.�� ���.���._��', 0, 1, 'CUST_RKO_DOD_BANK AGREEMENT_UO.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = '����_���.���.�� ���.���._��',
            print_on_blank = 0,
            fr = 1,
            FILE_NAME = 'CUST_RKO_DOD_BANK AGREEMENT_UO.frx'
    where id = 'CUST_RKO_DOD_BANK AGREEMENT_UO';
end;
/

begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('CUST_RKO_DOD1_BANK AGREEMENT_UO', '����_���.���.�� ���_�������_��', 0, 1, 'CUST_RKO_DOD1_BANK AGREEMENT_UO.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = '����_���.���.�� ���_�������_��',
            print_on_blank = 0,
            fr = 1,
            FILE_NAME = 'CUST_RKO_DOD1_BANK AGREEMENT_UO.frx'
    where id = 'CUST_RKO_DOD1_BANK AGREEMENT_UO';
end;
/

begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('CUST_RKO_DOD_BANK AGREEMENT_SPD', '����_���.���.�� ���.���._���', 0, 1, 'CUST_RKO_DOD_BANK AGREEMENT_SPD.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = '����_���.���.�� ���.���._���',
            print_on_blank = 0,
            fr = 1,
            FILE_NAME = 'CUST_RKO_DOD_BANK AGREEMENT_SPD.frx'
    where id = 'CUST_RKO_DOD_BANK AGREEMENT_SPD';
end;
/

begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('CUST_RKO_DOD1_BANK AGREEMENT_SPD', '����_���.���.�� ���_�������_���', 0, 1, 'CUST_RKO_DOD1_BANK AGREEMENT_SPD.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = '����_���.���.�� ���_�������_���',
            print_on_blank = 0,
            fr = 0,
            FILE_NAME = 'CUST_RKO_DOD1_BANK AGREEMENT_SPD.frx'
    where id = 'CUST_RKO_DOD1_BANK AGREEMENT_SPD';
end;
/

commit;
