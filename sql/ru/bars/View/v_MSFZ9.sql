create or replace view bars.v_MSFZ9 as 
select X.* , NVL( (select txt from nd_txt where nd = x.nd and tag ='I_CR9'), '0') I_CR9 ---    Востанавл=0, НеВостанавл CR9=1)
FROM 
(select Z.vidd, Z.nd , Z.sdate, Z.wdate, Z.sos, Z.rnk, Z.cc_id,  NULL KV, NULL kol ,
        sum (Z.SS ) SS ,  sum ( gl.p_icurval(Z.kv, Z.SS1 *100, gl.bd) ) / 100 SS1  ,     
        sum (Z.SX ) SX ,
        sum (Z.SN ) SN ,  sum ( gl.p_icurval(Z.kv, Z.SN1 *100, gl.bd) ) / 100 SN1  ,     
        sum (Z.SP ) SP ,  sum ( gl.p_icurval(Z.kv, Z.SP1 *100, gl.bd) ) / 100 SP1  ,     
        sum (Z.SDI) SDI,  sum ( gl.p_icurval(Z.kv, Z.SDI1*100, gl.bd) ) / 100 SDI1 ,     
        sum (Z.SPN) SPN,  sum ( gl.p_icurval(Z.kv, Z.SPN1*100, gl.bd) ) / 100 SPN1 ,     
        sum (Z.SNA) SNA,  sum ( gl.p_icurval(Z.kv, Z.SNA1*100, gl.bd) ) / 100 SNA1 ,     
        sum (Z.SNO) SNO,  sum ( gl.p_icurval(Z.kv, Z.SNO1*100, gl.bd) ) / 100 SNO1 ,     
        sum (Z.S36) S36,  sum ( gl.p_icurval(Z.kv, Z.S361*100, gl.bd) ) / 100 S361 ,     
        sum (Z.ISG) ISG,  sum ( gl.p_icurval(Z.kv, Z.ISG1*100, gl.bd) ) / 100 ISG1 ,     
        sum ( Z.SG)  SG,  sum ( gl.p_icurval(Z.kv, Z.SG1 *100, gl.bd) ) / 100  SG1      
 from bars.v_MSFZ91 Z 
 group by Z.vidd, Z.nd,  Z.sdate, Z.wdate , Z.sos,  Z.rnk, Z.cc_id --HAVING ( sum (Z.SS ) > 1  or sum (Z.SP ) > 1    or sum (Z.SN ) > 1       or sum (Z.SDI) > 1 or sum (Z.SPN) > 1       or sum (Z.SNA) > 1   )    
) X
WHERE ( X.SS1 + X.SP1 <> 0  or x.SS > 0 or x.SX > 0  );

GRANT SELECT ON bars.v_MSFZ9  TO BARS_ACCESS_DEFROLE;