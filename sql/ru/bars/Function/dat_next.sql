
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_next.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_NEXT (next_ int) return date is
DAT_ date;  DAT1_ date;  KOL_   int;  i_ int; DATB_ date;
ern         CONSTANT POSITIVE := 208;
err         EXCEPTION;  erm         VARCHAR2(80);
BEGIN
 DATB_:=bankdate; DAT_:=DATB_ + next_;
 select count(*) into KOL_ from holiday
 where kv=980 and holiday>DATB_ and holiday<=DAT_;
 if KOL_=0 then  return(DAT_); end if;
 for i_ in 1..10
 LOOP
 BEGIN
   DAT_:=DAT_ + 1;
   select holiday into DAT1_ from holiday where kv=980 and holiday=DAT_;
   KOL_:=KOL_+1;
   exception when NO_DATA_FOUND THEN
   begin
    if DAT_-DATB_ = next_ + kol_  then return (DAT_);   end if;
   end;
 END;
 END LOOP;
end dat_next ;
/
 show err;
 
PROMPT *** Create  grants  DAT_NEXT ***
grant EXECUTE                                                                on DAT_NEXT        to ABS_ADMIN;
grant EXECUTE                                                                on DAT_NEXT        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DAT_NEXT        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_next.sql =========*** End *** =
 PROMPT ===================================================================================== 
 