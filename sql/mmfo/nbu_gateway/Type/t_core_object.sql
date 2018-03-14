create or replace type t_core_object force as object
(
       core_object_kf varchar2(6 char),
       core_object_id number(38),
       reported_object_id number(38),
       external_object_id varchar2(4000 byte),

       member function equals(
           p_core_object in t_core_object)
       return boolean,

       member procedure perform_check(
           p_is_valid out boolean,
           p_validation_message out varchar2),

       member function get_json
       return clob
) not final;
/
create or replace type t_core_objects as table of t_core_object;
/
