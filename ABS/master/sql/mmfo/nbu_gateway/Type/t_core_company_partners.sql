create or replace type t_core_company_partner force as object
(
       isrezpr          varchar2(5 char),              -- true Ц €кщо особа Ї резидентом; false Ц €кщо особа не Ї резидентом
       codedrpoupr      varchar2(20 char),              -- код ™ƒ–ѕќ”
       nameurpr         varchar2(254 char),             -- найменуванн€ особи
       countrycodpr     varchar2(3 char)                -- код крањни м≥сц€ реЇстрац≥њ (зазначаЇтьс€ дл€ особи-нерезидента)
);
/

create or replace type t_core_company_partners force as table of t_core_company_partner;
/
