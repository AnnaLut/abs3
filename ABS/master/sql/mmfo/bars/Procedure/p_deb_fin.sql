

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DEB_FIN.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DEB_FIN ***

  CREATE OR REPLACE PROCEDURE BARS.P_DEB_FIN (dat01_ DATE )  IS

dat31_ date;
fl_    number;

begin
   dat31_ := Dat_last ( dat01_ -4, dat01_-1 ) ;
   begin
     select 1 into fl_ from rez_protocol where dat= dat31_ and rownum=1;
   EXCEPTION WHEN NO_DATA_FOUND THEN
     raise_application_error(-20000,
          'Звіт слід виконувати після формування проводок!
           Виконайте проводки по резерву за '|| to_char(DAT01_,'dd.mm.yyyy')
                            );

   END;
   delete from deb_fin;
   insert into deb_fin (nbs,kv,kat,rez,rezq,bv,bvq,rezf,rezqf)
   select nbs,kv,fin,sum(rez) rez,sum(rezq) rezq ,sum(bv) bv,sum(bvq) bvq,
          sum(rez) rezf,sum(rezq) rezqf
   from nbu23_rez where fdat=dat01_ and id like 'DEBF%' and dat_mi is null
   group by nbs,kv,fin
   order by nbs,kv,fin;
end;
/
show err;

PROMPT *** Create  grants  P_DEB_FIN ***
grant EXECUTE                                                                on P_DEB_FIN       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_DEB_FIN       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DEB_FIN.sql =========*** End ***
PROMPT ===================================================================================== 
