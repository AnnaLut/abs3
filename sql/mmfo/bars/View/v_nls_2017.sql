create or replace view  v_NLS_2017 as 
 select a.branch, a.acc, a.kv, a.nls, a.ob22, a.nms, a.daos, a.ostc/100 ostc, a.rnk, a.tip , a.nlsalt, t.r020_new, t.ob_new,
        (select nls_new from nls_2017 where nls_old = a.nls and kf = a.kf ) nls_new
 from (select * from accounts      where dazs is null ) a , 
      (select * from TRANSFER_2017 where r020_old <> r020_new OR ob_old<> ob_new )  t 
 where a.nbs = t.r020_old and a.ob22 = t.ob_old; 

GRANT SELECT ON BARS.v_NLS_2017  TO BARS_ACCESS_DEFROLE;