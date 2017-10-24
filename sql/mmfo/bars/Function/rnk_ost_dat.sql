
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rnk_ost_dat.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RNK_OST_DAT (rnk_ NUMBER,dat_ date ) RETURN NUMBER IS
nn_ number;
BEGIN
 select -sum(gl.p_icurval(a.kv, a.ost, a.fdat)) into nn_
 from cust_acc cu,sal a
 where a.ost < 0 AND
       a.nbs<5000 and a.fdat=dat_ and a.acc=cu.acc and cu.rnk=rnk_;
 return nn_;
 EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN 0;
END rnk_ost_dat;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rnk_ost_dat.sql =========*** End **
 PROMPT ===================================================================================== 
 