exec bc.home;
begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_CREATE_DEPOSIT', 'ЗАЯВКА ПРО ВІДКРИТТЯ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 0, null, null,null, null, null, 1, 'WB_CREATE_DEPOSIT.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='ЗАЯВКА ПРО ВІДКРИТТЯ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7',PRINT_ON_BLANK=0, TEMPLATE=null, HEADER=null, FOOTER=null, HEADER_EX=null, D_CLOSE=null, FR=1, FILE_NAME='WB_CREATE_DEPOSIT.frx' where id ='WB_CREATE_DEPOSIT';
end; 
/

begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_DENY_AUTOLONGATION', 'ЗАЯВКА ПРО ВІДМОВУ ВІД АВТОМАТИЧНОЇ ПРОГОЛОНГАЦІЇ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 0, null, null,null, null, null, 1, 'WB_DENY_AUTOLONGATION.frx');
exception when dup_val_on_index then 
 update doc_scheme set NAME='ЗАЯВКА ПРО ВІДМОВУ ВІД АВТОМАТИЧНОЇ ПРОГОЛОНГАЦІЇ ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7',PRINT_ON_BLANK=0, TEMPLATE=null, HEADER=null, FOOTER=null, HEADER_EX=null, D_CLOSE=null, FR=1, FILE_NAME='WB_DENY_AUTOLONGATION.frx' where id ='WB_DENY_AUTOLONGATION';
end; 
/

begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_CHANGE_ACCOUNT', 'ЗАЯВКА ПРО ЗМІНУ РАХУНКУ ВИПЛАТИ ТІЛА ТА ВІДСОТКІВ ПО ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7', 0, null, null,null, null, null, 1, 'WB_CHANGE_ACCOUNT.frx');
exception when dup_val_on_index then 
    update doc_scheme set NAME='ЗАЯВКА ПРО ЗМІНУ РАХУНКУ ВИПЛАТИ ТІЛА ТА ВІДСОТКІВ ПО ДЕПОЗИТУ ЧЕРЕЗ ОЩАД 24/7',PRINT_ON_BLANK=0, TEMPLATE=null, HEADER=null, FOOTER=null, HEADER_EX=null, D_CLOSE=null, FR=1, FILE_NAME='WB_CHANGE_ACCOUNT.frx' where id ='WB_CHANGE_ACCOUNT';
end; 
/
commit;
/


BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_FRX' , 'БПК. Заява нові клієнти' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нові клієнти',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX' , 'БПК. Заява нові клієнти (Картка Киянина)' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нові клієнти (Картка Киянина)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_KKU_FRX' , 'БПК. Заява нові клієнти картка учня (киянина)' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_KKU_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нові клієнти картка учня (киянина)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_KKU_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_KKU_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_NK_FRX' , 'БПК. Заява нацкарта нові клієнти' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_NK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нацкарта нові клієнти',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_NK_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_NK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_PENS_FRX' , 'БПК. Заява нові клієнти (пенсійний)' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_PENS_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нові клієнти (пенсійний)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_PENS_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_PENS_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_FRX' , 'БПК. Заява діючі клієнти' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява діючі клієнти',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX' , 'БПК. Заява діючі клієнти (Картка Киянина)' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява діючі клієнти (Картка Киянина)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_KKU_FRX' , 'БПК. Заява діючі клієнти картка учня (киянина)' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_KKU_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява діючі клієнти картка учня (киянина)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_KKU_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_KKU_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_NK_FRX' , 'БПК. Заява нацкарта діючі клієнти' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_NK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нацкарта діючі клієнти',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_NK_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_NK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_PENS_FRX' , 'БПК. Заява діючі клієнти (пенсійний)' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_PENS_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява діючі клієнти (пенсійний)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_PENS_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_PENS_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX' , 'БПК. Заява нові клієнти (без кредиту)' , 0 , 1 , 'ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нові клієнти (без кредиту)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX.FRX' 
             WHERE ID = 'ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX' , 'БПК. Заява діючі клієнти (без кредиту)' , 0 , 1 , 'ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява діючі клієнти (без кредиту)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX.FRX' 
             WHERE ID = 'ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_4_BPK_ZAYAVA_NEW_PK1_FRX' , 'БПК. Заява нові клієнти (постійний клієнт; моя картка)' , 0 , 1 , 'ACC_4_BPK_ZAYAVA_NEW_PK1_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява нові клієнти (постійний клієнт; моя картка)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_4_BPK_ZAYAVA_NEW_PK1_FRX.FRX' 
             WHERE ID = 'ACC_4_BPK_ZAYAVA_NEW_PK1_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_4_BPK_ZAYAVA_NEW_PK2_FRX' , 'БПК. Заява діючі клієнти (постійний клієнт; моя картка)' , 0 , 1 , 'ACC_4_BPK_ZAYAVA_NEW_PK2_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява діючі клієнти (постійний клієнт; моя картка)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_4_BPK_ZAYAVA_NEW_PK2_FRX.FRX' 
             WHERE ID = 'ACC_4_BPK_ZAYAVA_NEW_PK2_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_5_BPK_ZAYAVA_KRED_FRX' , 'БПК. Заява на встановлення кредиту' , 0 , 1 , 'ACC_5_BPK_ZAYAVA_KRED_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява на встановлення кредиту',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_5_BPK_ZAYAVA_KRED_FRX.FRX' 
             WHERE ID = 'ACC_5_BPK_ZAYAVA_KRED_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_5_BPK_ZAYAVA_KRED_PENS_FRX' , 'БПК. Заява на встановлення кредиту (Пенсіонери)' , 0 , 1 , 'ACC_5_BPK_ZAYAVA_KRED_PENS_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява на встановлення кредиту (Пенсіонери)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_5_BPK_ZAYAVA_KRED_PENS_FRX.FRX' 
             WHERE ID = 'ACC_5_BPK_ZAYAVA_KRED_PENS_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX' , 'БПК. Заява на встановлення кредиту (постійний клієнт; моя картка)' , 0 , 1 , 'ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'БПК. Заява на встановлення кредиту (постійний клієнт; моя картка)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX.FRX' 
             WHERE ID = 'ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA10_ADDCARD_FRX' , 'ДКБО.Заява щодо перевипуску платіжної картки на новий строк' , 0 , 1 , 'DKBOEA10_ADDCARD_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'ДКБО.Заява щодо перевипуску платіжної картки на новий строк',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA10_ADDCARD_FRX.FRX' 
             WHERE ID = 'DKBOEA10_ADDCARD_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA12_CARDHOLDER_CLAIM_FRX' , 'ДКБО.Заява держателя - Cardholder Statement of Claim' , 0 , 1 , 'DKBOEA12_CARDHOLDER_CLAIM_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'ДКБО.Заява держателя - Cardholder Statement of Claim',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA12_CARDHOLDER_CLAIM_FRX.FRX' 
             WHERE ID = 'DKBOEA12_CARDHOLDER_CLAIM_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA12A_DODCLIENTS_CLAIM_FRX' , 'ДКБО.Заява клієнта - Client’s Statement of Claim' , 0 , 1 , 'DKBOEA12A_DODCLIENTS_CLAIM_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'ДКБО.Заява клієнта - Client’s Statement of Claim',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA12A_DODCLIENTS_CLAIM_FRX.FRX' 
             WHERE ID = 'DKBOEA12A_DODCLIENTS_CLAIM_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA25_DODCARD_FRX' , 'ДКБО.Заява про випуск додаткової картки' , 0 , 1 , 'DKBOEA25_DODCARD_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'ДКБО.Заява про випуск додаткової картки',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA25_DODCARD_FRX.FRX' 
             WHERE ID = 'DKBOEA25_DODCARD_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA26_CANCEL_FRX' , 'ДКБО.Заява про розірвання' , 0 , 1 , 'DKBOEA26_CANCEL_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'ДКБО.Заява про розірвання',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA26_CANCEL_FRX.FRX' 
             WHERE ID = 'DKBOEA26_CANCEL_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA27_CHLOAN_SCHED_CRED_FRX' , 'ДКБО.Заява на зміну графіку погашення Кредиту' , 0 , 1 , 'DKBOEA27_CHLOAN_SCHED_CRED_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'ДКБО.Заява на зміну графіку погашення Кредиту',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA27_CHLOAN_SCHED_CRED_FRX.FRX' 
             WHERE ID = 'DKBOEA27_CHLOAN_SCHED_CRED_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA_DELTICKET_FRX' , 'СЗ на видалення тікету' , 0 , 1 , 'DKBOEA_DELTICKET_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = 'СЗ на видалення тікету',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA_DELTICKET_FRX.FRX' 
             WHERE ID = 'DKBOEA_DELTICKET_FRX';
END;
/
COMMIT;
/