
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_month_lit.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_MONTH_LIT ( dat_ DATE,p1 int DEFAULT 0,p2 int DEFAULT 0)
RETURN VARCHAR2 IS
-- возвращает полностью или составл€ющие (дд,мес€ц,yyyy) входной даты
sDAT_     VARCHAR2(40);
dd_       VARCHAR2(2);
mm_       VARCHAR2(2);
yyyy_     VARCHAR2(4);

BEGIN
   SELECT to_char(to_date(dat_),'dd'),
          to_number(to_char(to_date(dat_),'mm')),
          to_char(to_date(dat_),'yyyy' )
   INTO dd_, mm_, yyyy_
   FROM dual;

   if p1=0 then
   SELECT m.name_from INTO sDAT_
   FROM meta_month m
   WHERE m.n=to_number(mm_);
   else
   SELECT m.name_plain INTO sDAT_
   FROM meta_month m
   WHERE m.n=to_number(mm_);
   end if;
   if p2=0 then
   sDat_:='"'||dd_||'"'||' '||sDat_||' '||yyyy_||' р.';
   elsif p2=1 then
   sDat_:='"'||dd_||'"';
   elsif p2=2 then
   sDat_:=sDat_;
   elsif p2=3 then
   sDat_:=yyyy_||' р.';
   elsif p2=4 then
   sDat_:=sDat_||' '||yyyy_||' р.';
   end if;
   RETURN sDAT_;
END F_Month_lit;
/
 show err;
 
PROMPT *** Create  grants  F_MONTH_LIT ***
grant EXECUTE                                                                on F_MONTH_LIT     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_MONTH_LIT     to START1;
grant EXECUTE                                                                on F_MONTH_LIT     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_month_lit.sql =========*** End **
 PROMPT ===================================================================================== 
 