prompt ####################################################################################
prompt ... Âşøêè-ãëÿäåëêè  D:\K\MMFO\kwt_2924\Sql\View\ATM_vie.sql 
prompt ..........................................

CREATE OR REPLACE FORCE VIEW BARS.V_ATMREF2N AS
SELECT p1.ACC, p1.DK DK1,  p1.FDAT FDAT1,  p1.REF REF1,  p1.s/100 s1, 
               p2.DK DK2,  p2.FDAT FDAT2,  p2.REF REF2,  p2.s/100 s2, 
       pul.GET ('ATM_NLS') || '-->' || DECODE (pul.GET ('ATM_NLS'), o2.nlsa, o2.nlsb, o2.nlsa) nlsK,    
       o2.tt || '*' || o2.nazn NAZN2
 FROM oper o2, opldok p2, 
     (SELECT * FROM opldok WHERe REF = TO_NUMBER(pul.GET('ATM_R1')) and acc= TO_NUMBER(pul.GET('ATM_ACC')) and dk= TO_NUMBER(pul.GET('ATM_DK')) AND ROWNUM=1 AND sos=5 ) p1
 WHERE o2.REF= p2.REF AND p2.sos= 5  AND p2.acc= p1.acc  AND p2.dk = 1 - p1.dk  AND p2.fdat >= p1.fdat   and p2.s <= p1.s  AND NOT EXISTS   (SELECT 1  FROM ATM_REF2   WHERE ref2 = o2.REF);

grant select  on bars.v_ATMREF2n  TO BARS_ACCESS_DEFROLE;
--------------------------------
