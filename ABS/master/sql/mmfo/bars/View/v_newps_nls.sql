CREATE OR REPLACE VIEW v_newps_nls
AS
SELECT KF ,
           dat_alt,
           kv,
           nbs,
           nls ,  
           ob22,
           substr(nlsalt,1,4) old_nbs,       
           nlsalt old_nls,
           T2017.OB22_old (NBS, OB22, SUBSTR (nlsalt, 1, 4))old_ob22,
           fost (acc, dat_alt - 1)/100 ost,
           --fostq (acc, dat_alt-1)/100 ostq,
           gl.p_icurval(kv, ostc, dat_alt-1)/100 as ostq
 FROM accounts
 WHERE     dat_alt IS NOT NULL
          AND nlsalt IS NOT NULL
          AND fost (acc, dat_alt - 1) <> 0;
          
GRANT SELECT ON v_newps_nls TO bars_access_defrole;