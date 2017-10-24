

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23CP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_NBU23CP ***

  CREATE OR REPLACE TRIGGER BARS.TAU_NBU23CP 
  INSTEAD OF UPDATE ON "BARS"."NBU23_CP"
  REFERENCING FOR EACH ROW
declare
 kat23_ int ;
 vncrr_ varchar2(4);
 k23_ number;
 ord_   int ;
 fin23_ int ;
 ky_    int ;
 id_  number;
 quot_  int ;
 r_   number;
 d_   number;
 np1_ number;
 np2_ number;
 np3_ number;
 ec_  number;
 cf_  number;
 pv_  number;
BEGIN
 quot_  := :new.quot_sign;
 fin23_ := :new.FIN23;
 vncrr_ := :new.vncrr;
 id_    := :old.id   ;

 If :old.emi in (0,6) then
    update cp_kod set fin23 = fin23_, vncrr = vncrr_, quot_sign = quot_,kat23 =:new.kat23, k23 = :new.k23, dox=:new.dox,IN_BR=:new.IN_BR
    where id = id_;  -- kat23 и k23 добавлено потому, что по новым не было заполнено.
    RETURN;
 end if;
 ------------------------
 If :old.dox = 1 then
--    r_ := nvl(:new.r,0); d_ := nvl(:new.d,0);  ec_:= nvl(:new.ec,0);
    r_  := :new.r         ; d_  := :new.d         ; ec_  := :new.ec;
    np1_:= nvl(:new.np1,0); np2_:= nvl(:new.np2,0); np3_ := nvl(:new.np3,0);

    If r_<= 0 or r_ >1            then raise_application_error(-20000,  :new.CP_ID || '1 >=  r д.б. >0 ' );  end if;
    If d_<= 0 or d_ >1            then raise_application_error(-20000,  :new.CP_ID || '1 >=  d д.б. >0 ' );  end if;
    If np1_<0 or np2_<0 or np3_<0 then raise_application_error(-20000,  :new.CP_ID || 'NP-i д.б >=0 ' );     end if;
    If ec_<=0                     then raise_application_error(-20000,  :new.CP_ID || 'EC д.б > 0 ' );       end if;
 end if;
 --------------------------------------------
 kat23_ := :new.kat23; k23_   := :new.k23  ; ky_    := :old.ky   ;

 If (kat23_ is null or k23_ is null ) and fin23_  is not null then
    If    FIN23_ = 1            then  kat23_ := 1;  k23_ := 0;
    elsIf FIN23_ = 4            then  kat23_ := 5;  k23_ := 1;
    elsif FIN23_ in ( 2,3) and vncrr_ is not null   then
       begin
          select ord into ord_  from CCK_RATING where code = vncrr_;
          If FIN23_  = 2        then
             If KY_ >= 4        then  kat23_ := 2;
                If    ord_ <=11 then                k23_ :=  1/100 ;
                elsIf ord_  =12 then                k23_ := 10/100 ;
                elsIf ord_  =13 then                k23_ := 20/100 ;
                end if;
             else                     kat23_ := 3;
                If    ord_ <=11 then                k23_ := 21/100 ;
                elsIf ord_  =12 then                k23_ := 30/100 ;
                elsIf ord_  =13 then                k23_ := 50/100 ;
                end if;
             end if;

          elsIf FIN23_  = 3     then  kat23_ := 4;
                If    ord_ <=21 then                k23_ := 51/100 ;
                elsIf ord_  =22 then                k23_ := 55/100 ;
                elsIf ord_  =23 then                k23_ := 60/100 ;
                end if;
          end if;
       exception when no_data_found then null;
       end;
    end if;
 end if;

 update cp_kod set fin23 = fin23_, vncrr = vncrr_, kat23 =kat23_, k23 = k23_, quot_sign = quot_,IN_BR=:new.IN_BR where id = id_;

 If :old.dox = 1  and d_ is not null and ec_ is not null and r_ is not null then
    cf_ := d_ * ( NP1_ + np2_ + np3_ ) / ( sign(NP1_) + sign(NP2_) + sign(nP3_) ) ;
    pv_ := ec_*d_      * power((1+r_),-5) +
           cf_*(1-k23_)*(power((1+r_),-1) + power((1+r_),-2) + power((1+r_),-3) + power((1+r_),-4) + power( (1+r_),-5) );
    update cp_koda set r=r_, d=d_, np1=np1_, np2=np2_, np3=np3_, ec=ec_ , pv = pv_ where id = id_;
    if SQL%rowcount = 0 then
       insert into cp_koda (r, d, np1, np2, np3, ec, pv, id) values (r_, d_, np1_, np2_, np3_, ec_, pv_, id_);
    end if;
 end if;


end TAU_NBU23CP;
/
ALTER TRIGGER BARS.TAU_NBU23CP ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_NBU23CP.sql =========*** End ***
PROMPT ===================================================================================== 
