CREATE OR REPLACE FORCE VIEW BARS.V_DOPPARAM_MSFZ AS
   SELECT TO_NUMBER (pul.Get_Mas_Ini_Val ('ND')) ND,  t.TAG,  t.name,   (SELECT txt  FROM nd_txt   WHERE tag = t.tag AND nd = pul.Get_Mas_Ini_Val ('ND'))   VAL
    FROM cc_tag t    WHERE t.tag IN ('BUS_MOD',  'SPPI',  'IFRS', 'INTRT');
 
GRANT SELECT ON bars.V_DOPPARAM_MSFZ  TO BARS_ACCESS_DEFROLE;