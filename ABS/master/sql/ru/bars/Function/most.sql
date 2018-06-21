CREATE OR REPLACE FUNCTION BARS.MOST(P_FDAT DATE , p_TA int,  P_ND NUMBER, P_TIP VARCHAR2, P_KV INT ) RETURN NUMBER IS
L_OST NUMBER := 0;
BEGIN 
 If p_tip ='REZ' then
   sELECT NVL(SUM(rez*100) ,0) 
   INTO L_OST 
   FROM nbu23_rez  
   WHERE FDAT = P_FDAT and nd = p_nd and kv = p_kv  and tipa = p_TA ;
else
   sELECT NVL(SUM(M.ost-M.crdos+M.crkos) ,0) 
   INTO L_OST 
   FROM ACCOUNTS A, ND_ACC N, AGG_MONBALS9 M 
   WHERE A.KV = P_KV AND A.TIP= P_TIP  AND M.KF=A.KF AND M.ACC=A.ACC AND A.ACC= N.ACC AND ND=P_ND AND M.FDAT = add_months (P_FDAT , - 1 );
end if;
  
 RETURN L_OST ;
END ;
/
