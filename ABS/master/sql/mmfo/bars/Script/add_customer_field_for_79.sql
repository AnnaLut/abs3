exec bc.home;

SET DEFINE OFF;
delete from DBF_IMP_TABS where TABNAME = 'KOD_K021';
Insert into DBF_IMP_TABS
   (TABNAME, IMPMOD)
 Values
   ('KOD_K021', NULL);
COMMIT;

grant select on kod_k021 to start1;

begin
    Insert into CUSTOMER_FIELD
       (TAG, NAME, B, U, F, 
        TABNAME, BYISP, TYPE, OPT, TABCOLUMN_CHECK, 
        SQLVAL, CODE, NOT_TO_EDIT, HIST, PARID, 
        U_NREZ, F_NREZ, F_SPD)
     Values
       ('K021', 'Ознака ідентифікаційного коду (K021)', 1, 1, 1, 
        'KOD_K021', NULL, 'S', 1, 'K021', 
        NULL, 'OTHERS', 0, 1, NULL, 
        1, 1, 1);
    COMMIT;
exception
    when others then
        null;
end;
/            
