
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rnk_ostb.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RNK_OSTB (rnk_ NUMBER) RETURN NUMBER IS
nn_ number;
BEGIN
 select -sum(gl.p_icurval(a.kv, a.ostb, bankdate)) into nn_
 from cust_acc cu, accounts a
 where a.ostc < 0 AND
       a.nbs<5000 and a.acc=cu.acc and cu.rnk=rnk_;
 return nn_;
 EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN 0;
END rnk_ostb;
/
 show err;
 
PROMPT *** Create  grants  RNK_OSTB ***
grant EXECUTE                                                                on RNK_OSTB        to ABS_ADMIN;
grant EXECUTE                                                                on RNK_OSTB        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RNK_OSTB        to FOREX;
grant EXECUTE                                                                on RNK_OSTB        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rnk_ostb.sql =========*** End *** =
 PROMPT ===================================================================================== 
 