CREATE OR REPLACE VIEW V_COUNTRY (COUNTRY, NAME) AS 
  select COUNTRY, NAME
  from country
  order by name
  with read only
;
  GRANT SELECT ON V_COUNTRY TO BARS_ACCESS_DEFROLE;