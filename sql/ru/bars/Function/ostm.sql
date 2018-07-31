create or replace FUNCTION OSTM ( p_acc number, -- ACC счета
                p_dat date   -- ЋюЅјя дата отч мес€ца MM.YYYY  (  от 01.MM.YYYY до    31.MM.YYYY )
               )  return number  is  l_OSTM number ;  z_Dat date := TRUNC ( p_dat, 'MM'); 
-- получение остатки по мес€чному снимку данной даты или (при отсутствии снимка ) - на заданную датуостатка
BEGIN
    begin  select ost + CRkos-CRdos   into l_OSTM    From  AGG_MONBALS    where acc = p_ACC and fdat = z_Dat ;
    EXCEPTION WHEN NO_DATA_FOUND THEN      l_OSTM := Fost( p_ACC , p_Dat);
    End;
    RETURN l_OSTM ;
END          OSTM ;
/
 show err;
 
PROMPT *** Create  grants OSTM ***
grant EXECUTE   on OSTM        to BARS_ACCESS_DEFROLE;
grant EXECUTE   on OSTM        to START1;

-----------------------

