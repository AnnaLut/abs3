CREATE OR REPLACE FORCE VIEW BARS.V_REPLACEMENT_ASSET
(
   ID,
   NAME
   
)
AS
   SELECT '5' ID, 'заміна активу внаслідок реструктуризації' FROM DUAL
   UNION ALL
   SELECT '6' ID, 'заміна активу , не повязана з реструктуризацією' FROM DUAL;




GRANT SELECT ON BARS.V_REPLACEMENT_ASSET TO BARS_ACCESS_DEFROLE;

GRANT SELECT ON BARS.V_REPLACEMENT_ASSET TO START1;