create or replace type t_core_company_owner_person force as object
(
       -- прізвище, ім’я, по батькові фізичної особи (структура fio)
       lastname         varchar2(100 char),
       firstname        varchar2(100 char),
       middlename       varchar2(100 char),
       isrez            varchar2(5 char),               -- true – якщо особа є резидентом; false – якщо особа не є резидентом
       inn              varchar2(20 char),              -- ідентифікаційний код
       countrycod       varchar2(3 char),               -- код країни місця реєстрації
       perсent          number(9, 6)                    -- частка власника істотної участі
);
/
create or replace type t_core_company_owner_persons force as table of t_core_company_owner_person;
/
