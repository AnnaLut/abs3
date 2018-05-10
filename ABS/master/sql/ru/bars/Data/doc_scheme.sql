exec bc.home;
begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_CREATE_DEPOSIT', '������ ��� ²������� �������� ����� ���� 24/7', 0, null, null,null, null, null, 1, 'WB_CREATE_DEPOSIT.frx');
exception when dup_val_on_index then 
  update doc_scheme set NAME='������ ��� ²������� �������� ����� ���� 24/7',PRINT_ON_BLANK=0, TEMPLATE=null, HEADER=null, FOOTER=null, HEADER_EX=null, D_CLOSE=null, FR=1, FILE_NAME='WB_CREATE_DEPOSIT.frx' where id ='WB_CREATE_DEPOSIT';
end; 
/

begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_DENY_AUTOLONGATION', '������ ��� ²����� ²� ����������ί ����������ֲ� �������� ����� ���� 24/7', 0, null, null,null, null, null, 1, 'WB_DENY_AUTOLONGATION.frx');
exception when dup_val_on_index then 
 update doc_scheme set NAME='������ ��� ²����� ²� ����������ί ����������ֲ� �������� ����� ���� 24/7',PRINT_ON_BLANK=0, TEMPLATE=null, HEADER=null, FOOTER=null, HEADER_EX=null, D_CLOSE=null, FR=1, FILE_NAME='WB_DENY_AUTOLONGATION.frx' where id ='WB_DENY_AUTOLONGATION';
end; 
/

begin 
 insert into doc_scheme (ID, NAME, PRINT_ON_BLANK, TEMPLATE, HEADER, FOOTER, HEADER_EX, D_CLOSE, FR, FILE_NAME)
 values ('WB_CHANGE_ACCOUNT', '������ ��� �̲�� ������� ������� Ҳ�� �� ²����ʲ� �� �������� ����� ���� 24/7', 0, null, null,null, null, null, 1, 'WB_CHANGE_ACCOUNT.frx');
exception when dup_val_on_index then 
    update doc_scheme set NAME='������ ��� �̲�� ������� ������� Ҳ�� �� ²����ʲ� �� �������� ����� ���� 24/7',PRINT_ON_BLANK=0, TEMPLATE=null, HEADER=null, FOOTER=null, HEADER_EX=null, D_CLOSE=null, FR=1, FILE_NAME='WB_CHANGE_ACCOUNT.frx' where id ='WB_CHANGE_ACCOUNT';
end; 
/
commit;
/


BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_FRX' , '���. ����� ��� �볺���' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ��� �볺���',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX' , '���. ����� ��� �볺��� (������ �������)' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ��� �볺��� (������ �������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_DKBO_KK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_KKU_FRX' , '���. ����� ��� �볺��� ������ ���� (�������)' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_KKU_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ��� �볺��� ������ ���� (�������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_KKU_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_KKU_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_NK_FRX' , '���. ����� �������� ��� �볺���' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_NK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� �������� ��� �볺���',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_NK_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_NK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_1_BPK_ZAYAVA_NEW_PENS_FRX' , '���. ����� ��� �볺��� (��������)' , 0 , 1 , 'ACC_1_BPK_ZAYAVA_NEW_PENS_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ��� �볺��� (��������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_1_BPK_ZAYAVA_NEW_PENS_FRX.FRX' 
             WHERE ID = 'ACC_1_BPK_ZAYAVA_NEW_PENS_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_FRX' , '���. ����� ���� �볺���' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ���� �볺���',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX' , '���. ����� ���� �볺��� (������ �������)' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ���� �볺��� (������ �������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_DKBO_KK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_KKU_FRX' , '���. ����� ���� �볺��� ������ ���� (�������)' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_KKU_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ���� �볺��� ������ ���� (�������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_KKU_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_KKU_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_NK_FRX' , '���. ����� �������� ���� �볺���' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_NK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� �������� ���� �볺���',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_NK_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_NK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_2_BPK_ZAYAVA_NEW_PENS_FRX' , '���. ����� ���� �볺��� (��������)' , 0 , 1 , 'ACC_2_BPK_ZAYAVA_NEW_PENS_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ���� �볺��� (��������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_2_BPK_ZAYAVA_NEW_PENS_FRX.FRX' 
             WHERE ID = 'ACC_2_BPK_ZAYAVA_NEW_PENS_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX' , '���. ����� ��� �볺��� (��� �������)' , 0 , 1 , 'ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ��� �볺��� (��� �������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX.FRX' 
             WHERE ID = 'ACC_3_BPK_ZAYAVA_NEW_VAL_1_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX' , '���. ����� ���� �볺��� (��� �������)' , 0 , 1 , 'ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ���� �볺��� (��� �������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX.FRX' 
             WHERE ID = 'ACC_3_BPK_ZAYAVA_NEW_VAL_2_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_4_BPK_ZAYAVA_NEW_PK1_FRX' , '���. ����� ��� �볺��� (�������� �볺��; ��� ������)' , 0 , 1 , 'ACC_4_BPK_ZAYAVA_NEW_PK1_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ��� �볺��� (�������� �볺��; ��� ������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_4_BPK_ZAYAVA_NEW_PK1_FRX.FRX' 
             WHERE ID = 'ACC_4_BPK_ZAYAVA_NEW_PK1_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_4_BPK_ZAYAVA_NEW_PK2_FRX' , '���. ����� ���� �볺��� (�������� �볺��; ��� ������)' , 0 , 1 , 'ACC_4_BPK_ZAYAVA_NEW_PK2_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� ���� �볺��� (�������� �볺��; ��� ������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_4_BPK_ZAYAVA_NEW_PK2_FRX.FRX' 
             WHERE ID = 'ACC_4_BPK_ZAYAVA_NEW_PK2_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_5_BPK_ZAYAVA_KRED_FRX' , '���. ����� �� ������������ �������' , 0 , 1 , 'ACC_5_BPK_ZAYAVA_KRED_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� �� ������������ �������',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_5_BPK_ZAYAVA_KRED_FRX.FRX' 
             WHERE ID = 'ACC_5_BPK_ZAYAVA_KRED_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_5_BPK_ZAYAVA_KRED_PENS_FRX' , '���. ����� �� ������������ ������� (���������)' , 0 , 1 , 'ACC_5_BPK_ZAYAVA_KRED_PENS_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� �� ������������ ������� (���������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_5_BPK_ZAYAVA_KRED_PENS_FRX.FRX' 
             WHERE ID = 'ACC_5_BPK_ZAYAVA_KRED_PENS_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX' , '���. ����� �� ������������ ������� (�������� �볺��; ��� ������)' , 0 , 1 , 'ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '���. ����� �� ������������ ������� (�������� �볺��; ��� ������)',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX.FRX' 
             WHERE ID = 'ACC_5_BPK_ZAYAVA_KRED_PK_MK_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA10_ADDCARD_FRX' , '����.����� ���� ����������� ������� ������ �� ����� �����' , 0 , 1 , 'DKBOEA10_ADDCARD_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '����.����� ���� ����������� ������� ������ �� ����� �����',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA10_ADDCARD_FRX.FRX' 
             WHERE ID = 'DKBOEA10_ADDCARD_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA12_CARDHOLDER_CLAIM_FRX' , '����.����� ��������� - Cardholder Statement of Claim' , 0 , 1 , 'DKBOEA12_CARDHOLDER_CLAIM_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '����.����� ��������� - Cardholder Statement of Claim',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA12_CARDHOLDER_CLAIM_FRX.FRX' 
             WHERE ID = 'DKBOEA12_CARDHOLDER_CLAIM_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA12A_DODCLIENTS_CLAIM_FRX' , '����.����� �볺��� - Client�s Statement of Claim' , 0 , 1 , 'DKBOEA12A_DODCLIENTS_CLAIM_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '����.����� �볺��� - Client�s Statement of Claim',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA12A_DODCLIENTS_CLAIM_FRX.FRX' 
             WHERE ID = 'DKBOEA12A_DODCLIENTS_CLAIM_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA25_DODCARD_FRX' , '����.����� ��� ������ ��������� ������' , 0 , 1 , 'DKBOEA25_DODCARD_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '����.����� ��� ������ ��������� ������',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA25_DODCARD_FRX.FRX' 
             WHERE ID = 'DKBOEA25_DODCARD_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA26_CANCEL_FRX' , '����.����� ��� ���������' , 0 , 1 , 'DKBOEA26_CANCEL_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '����.����� ��� ���������',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA26_CANCEL_FRX.FRX' 
             WHERE ID = 'DKBOEA26_CANCEL_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA27_CHLOAN_SCHED_CRED_FRX' , '����.����� �� ���� ������� ��������� �������' , 0 , 1 , 'DKBOEA27_CHLOAN_SCHED_CRED_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '����.����� �� ���� ������� ��������� �������',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA27_CHLOAN_SCHED_CRED_FRX.FRX' 
             WHERE ID = 'DKBOEA27_CHLOAN_SCHED_CRED_FRX';
END;
/
BEGIN
    INSERT INTO BARS.DOC_SCHEME (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
                         VALUES ('DKBOEA_DELTICKET_FRX' , '�� �� ��������� �����' , 0 , 1 , 'DKBOEA_DELTICKET_FRX.FRX');
EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            UPDATE BARS.DOC_SCHEME
               SET NAME = '�� �� ��������� �����',
                   PRINT_ON_BLANK = 0,
                   FR = 1,
                   FILE_NAME = 'DKBOEA_DELTICKET_FRX.FRX' 
             WHERE ID = 'DKBOEA_DELTICKET_FRX';
END;
/
COMMIT;
/