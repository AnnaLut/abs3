create or replace type t_core_person_address force as object
(
       codregion           varchar2(2 char),       -- код рег≥ону
       area                varchar2(100 char),     -- район
       zip                 varchar2(10 char),      -- поштовий ≥ндекс
       city                varchar2(254 char),     -- назва населеного пункту 
       streetaddress       varchar2(254 char),     -- вулиц€
       houseno             varchar2(50 char),      -- будинок
       adrkorp             varchar2(10 char),      -- корпус (споруда)
       flatno              varchar2(10 char)       -- квартира
);
/
create or replace type t_core_person_addresses force as table of t_core_person_address;
/
