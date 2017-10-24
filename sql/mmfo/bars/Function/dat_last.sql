
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_last.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_LAST (from_dat date, to_dat date DEFAULT NULL)
   return date is
-- last bankdate in month
-- последний рабочий день в указанном периоде (в пределах месяца)
-- при актуальном состоянии календаря (табл.Holiday)
 DAT_ date;  DAT1_ date;
 i_ int; k_max int;
k int; k1 int;
datr date; datf_ date; datl_ date;
e_dat date; b_dat date;
last_hol date;
ern         CONSTANT POSITIVE := 208;
err         EXCEPTION;  erm         VARCHAR2(80);
      BEGIN
 last_hol:=NULL;
 b_dat:=from_dat;
  if to_dat is NULL or to_dat=''then
     e_dat:=last_day(from_dat);
  else e_dat:=to_dat;
  end if;
 datr:=b_dat;
 datl_:=b_dat;
      k_max:=0;
  for l in
    (select holiday hol from holiday where holiday>=b_dat and holiday<=e_dat and kv = 980 order by holiday  )
  loop
--      deb.trace( ern,'','holiday='|| l.hol);

   k1:=k_max+1;
   for k in k1..31
   loop
     last_hol:=l.hol;
   if datr<l.hol then

--      deb.trace( ern,'','datr='|| datr||' '||l.hol);
      k_max:=k; datl_:=datr;
      datr:=datr+1;
      elsif datr=l.hol then
      datr:=datr+1; k_max:=k;
      exit;
      else
      k_max:=k;
      exit;
      end if;
   end loop;
  end loop;


  if last_hol<e_dat or last_hol is NULL then
  while datl_<e_dat LOOP
	datl_:=datl_+1;
  end loop;
  end if;

  return datl_;
end dat_last ;
/
 show err;
 
PROMPT *** Create  grants  DAT_LAST ***
grant EXECUTE                                                                on DAT_LAST        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DAT_LAST        to ELT;
grant EXECUTE                                                                on DAT_LAST        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_last.sql =========*** End *** =
 PROMPT ===================================================================================== 
 