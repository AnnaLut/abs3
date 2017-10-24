begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('CUST_RKO_DOD_BANK AGREEMENT_UO', 'ММСБ_Дод.дог.до Дог.рах._ЮО', 0, 1, 'CUST_RKO_DOD_BANK AGREEMENT_UO.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = 'ММСБ_Дод.дог.до Дог.рах._ЮО',
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
        ('CUST_RKO_DOD1_BANK AGREEMENT_UO', 'ММСБ_Дод.дог.до ДБО_виручка_ЮО', 0, 1, 'CUST_RKO_DOD1_BANK AGREEMENT_UO.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = 'ММСБ_Дод.дог.до ДБО_виручка_ЮО',
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
        ('CUST_RKO_DOD_BANK AGREEMENT_SPD', 'ММСБ_Дод.дог.до Дог.рах._ФОП', 0, 1, 'CUST_RKO_DOD_BANK AGREEMENT_SPD.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = 'ММСБ_Дод.дог.до Дог.рах._ФОП',
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
        ('CUST_RKO_DOD1_BANK AGREEMENT_SPD', 'ММСБ_Дод.дог.до ДБО_виручка_ФОП', 0, 1, 'CUST_RKO_DOD1_BANK AGREEMENT_SPD.frx');
    exception when dup_val_on_index then
    update bars.doc_scheme
        set name = 'ММСБ_Дод.дог.до ДБО_виручка_ФОП',
            print_on_blank = 0,
            fr = 0,
            FILE_NAME = 'CUST_RKO_DOD1_BANK AGREEMENT_SPD.frx'
    where id = 'CUST_RKO_DOD1_BANK AGREEMENT_SPD';
end;
/

commit;
