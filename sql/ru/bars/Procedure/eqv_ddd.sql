

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/EQV_DDD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure EQV_DDD ***

  CREATE OR REPLACE PROCEDURE BARS.EQV_DDD (dat01_ date) IS

   TYPE D354 IS RECORD (ddd char(3) );    
   TYPE M354 IS TABLE  OF D354 INDEX BY varchar2(1);  
   t35  M354;
   Rez_  number;    
   Rezq_ number; 
   BVQ_  NUMBER;
   PVQ_  NUMBER;
   r012_ varchar2(1);  
   dd_   char(1) ;  

  --общие переменные
  DAT31_ DATE ;
  TYPE DDDR IS RECORD (r020 char(4), ddd char(3) );
  TYPE DDDM IS TABLE  OF DDDR INDEX BY varchar2(4);
  tmp  DDDM   ;
  ddd_ NBU23_REZ.DDD%type;


begin
   --Справочник - в массив
   tmp.DELETE;
   for k in (select r020, ddd, r012 from kl_f3_29 where kf='1B')
   loop
      If k.r020  = '3548' then t35(k.r012).ddd := k.DDD ;  else        tmp(k.r020).ddd := k.ddd ;      end if;
   end loop;
   -------------------
   dat31_ := Dat_last (dat01_ - 4, dat01_-1 ) ;  -- последний рабочий день месяца
   for k in (select rowid RI, rez, KV, BV, substr(nls,1,4) NBS, nd, rnk, DD, pv from NBU23_REZ where fdat= dat01_) 
   loop
      Rez_   := greatest(0, k.rez);
      If k.kv = 980 then rezq_ := rez_ ;    BVQ_ := K.BV ;    PVQ_ := K.PV ;
      else               rezq_ := gl.p_icurval(k.kv, rez_*100, dat31_) /100;  
                          BVQ_ := gl.p_icurval(k.kv, K.BV*100, dat31_) /100;
                          PVQ_ := gl.p_icurval(k.kv, K.PV*100, dat31_) /100;
      end if;
      
      ddd_ := null;     dd_ := null;
      If k.nbs = '3548' then
          begin
            select r011 into   r012_ from specparam where acc = k.nd ;
            if t35.EXISTS(r012_) then        ddd_ := t35(r012_).ddd  ; end if;
          EXCEPTION WHEN NO_DATA_FOUND THEN  null;
          end;
       else
          if tmp.EXISTS(k.nbs) then   ddd_ := tmp(k.nbs).ddd  ;   end if;
       end if;

      If k.nbs like '9%' and k.dd is null then
         begin
            select decode(custtype,1,2,2,2,3) into dd_ from customer where rnk = k.rnk;
         EXCEPTION WHEN NO_DATA_FOUND THEN  null;
         end;
      else dd_ := k.dd ;
      end if;

      update NBU23_REZ set rez = rez_, rezq = rezq_,  BVQ = BVQ_, PVQ = PVQ_, ddd = ddd_, dd  = dd_  where rowid=k.RI;

   end loop;

end eqv_ddd; 
/
show err;

PROMPT *** Create  grants  EQV_DDD ***
grant EXECUTE                                                                on EQV_DDD         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on EQV_DDD         to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/EQV_DDD.sql =========*** End *** =
PROMPT ===================================================================================== 
