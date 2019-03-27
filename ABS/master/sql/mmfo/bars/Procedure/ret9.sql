CREATE OR REPLACE PROCEDURE BARS.RET9 IS
BEGIN
 FOR K IN (SELECT N.ND, COUNT (*) KOL , MIN(A.ACC) MIN_ACC 
           FROM ACCOUNTS A, ND_ACC N WHERE A.TIP ='SNA'  AND A.NBS LIKE '___9' AND A.ACC = N.ACC   -- AND A.DAZS IS NULL -- AND DAOS != GL.BD  
           GROUP BY N.ND 
           HAVING COUNT(*) > 1
           )
  LOOP 
    FOR K1 IN (SELECT A.*  
               FROM ACCOUNTS A, ND_ACC N WHERE A.TIP ='SNA'  AND A.NBS LIKE '___9' AND A.ACC = N.ACC  AND N.ND = K.ND AND A.ACC <> K.MIN_ACC )
    LOOP UPDATE ACCOUNTS SET TIP='XNA' WHERE ACC = K1.ACC; END LOOP;
  END LOOP;
END RET9;
/

show err;

PROMPT *** Create  grants SNA_SDI_ADD ***
grant EXECUTE       on RET9       to BARS_ACCESS_DEFROLE;
grant EXECUTE       on RET9       to RCC_DEAL;
grant EXECUTE       on RET9       to START1;