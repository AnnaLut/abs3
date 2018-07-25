begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_DEPOZIT_ENG',
         '"МІЙ ДЕПОЗИТ" на ім’я (з поповненням та капіталізацією)  на англ. мові',
         0,
         1,
         'NV_MY_DEPOZIT_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_DEPOZIT_KOR_ENG',
         '"МІЙ ДЕПОЗИТ" на користь (з поповненням та капіталізацією) на англ. мові',
         0,
         1,
         'NV_MY_DEPOZIT_KOR_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_DEPOZIT_KOR_MIS_ENG',
         '"МІЙ ДЕПОЗИТ" на користь (з поповненням та щомісячною виплатою процентів) на англ. мові',
         0,
         1,
         'NV_MY_DEPOZIT_KOR_MIS_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_DEPOZIT_MIS_ENG',
         '"МІЙ ДЕПОЗИТ" на ім’я (з поповненням та щомісячною виплатою процентів) на англ. мові',
         0,
         1,
         'NV_MY_DEPOZIT_MIS_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_PREM_DEPOZIT_ENG',
         '"МІЙ ПРЕМІАЛЬНИЙ ДЕПОЗИТ" на ім’я (з поповненням та капіталізацією)  на англ. мові',
         0,
         1,
         'NV_MY_PREM_DEPOZIT_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_PREM_DEPOZIT_KOR_ENG',
         '"МІЙ ПРЕМІАЛЬНИЙ ДЕПОЗИТ" на користь (з поповненням та капіталізацією) на англ. мові',
         0,
         1,
         'NV_MY_PREM_DEPOZIT_KOR_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_PREM_DEPOZIT_KOR_MIS_ENG',
         '"МІЙ ПРЕМІАЛЬНИЙ ДЕПОЗИТ" на користь (з поповненням та щомісячною виплатою процентів) на англ. мові',
         0,
         1,
         'NV_MY_PREM_DEPOZIT_KOR_MIS_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_PREM_DEPOZIT_MIS_ENG',
         '"МІЙ ПРЕМІАЛЬНИЙ ДЕПОЗИТ" на ім’я (з поповненням та щомісячною виплатою процентів)  на англ. мові',
         0,
         1,
         'NV_MY_PREM_DEPOZIT_MIS_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_PROGRES_DEPOZIT_ENG',
         '"Мій прогресивний депозит" на ім’я  на англ. мові',
         0,
         1,
         'NV_MY_PROGRES_DEPOZIT_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
begin
    Insert into BARS.DOC_SCHEME
        (ID, NAME, PRINT_ON_BLANK, FR, FILE_NAME)
    Values
        ('NV_MY_PROGRES_DEPOZIT_KOR_ENG',
         '"Мій прогресивний депозит" на користь на англ. мові',
         0,
         1,
         'NV_MY_PROGRES_DEPOZIT_KOR_ENG.frx');
    commit;
exception
    when others then
        null;
end;
/
