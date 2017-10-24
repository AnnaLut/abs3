begin
    execute immediate 'Insert into BARS.DOC_SCHEME
   (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
 Values
   (''NV_MY_DEPOZIT_MIS_ENG'', ''"МІЙ ДЕПОЗИТ" на ім’я (з поповненням та щомісячною виплатою процентів) на англійскій мові'', 0, 1, ''MY_DEPOSIT_NA_KOR_ENG.frx'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'Insert into BARS.DOC_SCHEME
   (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
 Values
   (''NV_MY_DEPOZIT_ENG'', ''"МІЙ ДЕПОЗИТ" на ім’я (з поповненням та капіталізацією) на аншлійскій мові'', 0, 1, ''MY_DEPOSIT_NA_KOR_ENG.frx'')';
 exception when others then 
    if sqlcode = -1 then null; else raise; 
    end if; 
end;
/ 

COMMIT;
