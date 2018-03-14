create or replace type t_core_person_workplace force as object
(
       typew      number(1),                   -- тип роботодавц€ (1 Ц роботодавець Ц юридична особа, 2 Ц ф≥зична особа Ц субТЇкт п≥дприЇмницькоњ д≥€льност≥.)
       codedrpou  varchar2(20 char),
       namew      varchar2(254 char)
);
/

create or replace type t_core_person_workplaces force as table of t_core_person_workplace;
/
