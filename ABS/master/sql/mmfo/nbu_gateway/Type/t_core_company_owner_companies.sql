create or replace type t_core_company_owner_company force as object
(
       nameoj           varchar2(254 char),             -- найменування особи
       isrezoj          varchar2(5 char),               -- резидентність особи (true – якщо особа є резидентом; false – якщо особа не є резидентом)
       codedrpouoj      varchar2(20 char),              -- код ЄДРПОУ
       registrydayoj    date,                           -- дата державної реєстрації
       numberregistryoj varchar2(32 char),              -- номер державної реєстрації
       countrycodoj     varchar2(3 char),               -- код країни – місця реєстрації нерезидента
       perсentoj        number(9, 6)                    -- частка власника істотної участі
);
/

create or replace type t_core_company_owner_companies force as table of t_core_company_owner_company;
/
