create or replace type t_core_person_document force as object
(
    typed                 number(1),                               -- тип документа (1 - загальний паспорт, 2 - закордонний паспорт, 3 - ID картка, 4 - ≥нше)
    seriya                varchar2(20 char),                       -- сер≥€ документа. якщо тип документа ID картка (typeD = 3), зазначаЇтьс€ ун≥кальний номер запису
                                                                   -- в ™диному державному демограф≥чному реЇстр≥
    nomerd                varchar2(20 char),                       -- номер документа
    dtd                   date                                     -- дата видач≥ документа
);
/
create or replace type t_core_person_documents force is table of t_core_person_document;
/
