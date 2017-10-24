
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_elt_dt.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ELT_DT (NLS_ varchar2, KV_ int default 980) return char is
ND_ varchar2(10);
-- Определение даты договора на ELT   !! по счету абонплаты 3600/3570
-- *** V1.4 27/02-14
BEGIN
 begin
   select DT into ND_ from
   (select to_char(sdate,'DD/MM/YY') DT
          from e_deal
          where nls36=NLS_ and kv36=KV_ and sos!=15 order by acc26 desc)
   where rownum=1;
   EXCEPTION WHEN NO_DATA_FOUND THEN ND_:='';
 end;
return ND_;
end f_elt_dt;
/
 show err;
 
PROMPT *** Create  grants  F_ELT_DT ***
grant EXECUTE                                                                on F_ELT_DT        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ELT_DT        to ELT;
grant EXECUTE                                                                on F_ELT_DT        to START1;
grant EXECUTE                                                                on F_ELT_DT        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_elt_dt.sql =========*** End *** =
 PROMPT ===================================================================================== 
 