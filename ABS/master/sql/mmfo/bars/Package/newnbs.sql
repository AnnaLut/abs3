CREATE OR REPLACE PACKAGE "BARS"."NEWNBS" is

  -- Author  : VITALII.KHOMIDA
  -- Created : 08.11.2017 14:00:57
  -- Purpose : 

  -- перехідн на новий план рахунків 1 - включено, 0 - відлключено
  g_state constant number := 1;
  
  function get_state return number;
  
end newnbs;
/
  GRANT EXECUTE ON "BARS"."NEWNBS" TO PUBLIC;
  
CREATE OR REPLACE PACKAGE BODY "BARS"."NEWNBS" is

  function get_state return number is
  begin
    return g_state;
  end;
  
end newnbs;
/
