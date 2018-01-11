

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TU_CBIREP_QUERIES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TU_CBIREP_QUERIES ***

  CREATE OR REPLACE TRIGGER BARS.TU_CBIREP_QUERIES 
BEFORE INSERT ON BARS.CBIREP_QUERIES for each row
begin
  raise_application_error(-20000, 'Сервіс друку тимчасово недоступний', true);
end;
/
ALTER TRIGGER BARS.TU_CBIREP_QUERIES DISABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TU_CBIREP_QUERIES.sql =========*** E
PROMPT ===================================================================================== 
