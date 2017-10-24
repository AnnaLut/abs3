
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_elt_dtw.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ELT_DTW (NLS_ varchar2, KV_ int default 980) return char is
ND_ varchar2(20);
-- Определение даты договора на ELT
-- Должна возвращать обязательно символьные данные (под макросы)
-- Выборка из нового допрек-та клиента ELT_D

BEGIN
 begin
   select distinct RTRIM(LTRIM(substr(w.value,1,20))) into ND_
          from customerw w, cust_acc s, accounts a
          where a.acc=s.acc and w.rnk=s.rnk and w.tag='ELT_D'
                and a.nls=NLS_ and a.kv=KV_;
   EXCEPTION WHEN NO_DATA_FOUND THEN ND_:='';
 end;
return ND_;
end f_elt_dtw;
 
/
 show err;
 
PROMPT *** Create  grants  F_ELT_DTW ***
grant EXECUTE                                                                on F_ELT_DTW       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ELT_DTW       to START1;
grant EXECUTE                                                                on F_ELT_DTW       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_elt_dtw.sql =========*** End *** 
 PROMPT ===================================================================================== 
 