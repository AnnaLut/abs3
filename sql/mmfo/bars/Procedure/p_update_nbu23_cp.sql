

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_UPDATE_NBU23_CP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_UPDATE_NBU23_CP ***

  CREATE OR REPLACE PROCEDURE BARS.P_UPDATE_NBU23_CP (
   p_quot     IN INT,
   p_fin23    IN INT,
   p_kat23    IN INT,
   p_k23      IN NUMBER,
   p_vncrr    IN VARCHAR2,
   p_emi      IN NUMBER,
   p_id       IN NUMBER,
   p_dox      IN INT,
   p_in_br    IN INT,
   p_r        IN NUMBER,
   p_d        IN NUMBER,
   p_ec       IN NUMBER,
   p_np1      IN NUMBER,
   p_np2      IN NUMBER,
   p_np3      IN NUMBER,
   p_cp_id    IN VARCHAR2,
   p_ky       IN NUMBER
 )
IS

 l_np1   number; l_np2   number; l_np3   number;  l_ord   int;
 l_k23   number; l_cf    number; l_pv    number;  l_kat23 int;

BEGIN

 If p_emi in (0,6) then
    update cp_kod set fin23 = p_fin23, vncrr = p_vncrr, quot_sign = p_quot, kat23 = p_kat23, k23 = p_k23, dox = p_dox, IN_BR = p_IN_BR
    where id = p_id;  -- kat23 и k23 добавлено потому, что по новым не было заполнено.
    RETURN;
 end if;
 ------------------------
 If p_dox = 1 then

    l_np1 := nvl(p_np1,0); l_np2 := nvl(p_np2,0); l_np3 := nvl(p_np3,0);

    If p_r  <= 0 or p_r  >1             then raise_application_error(-20000,  p_CP_ID || '1 >=  r д.б. >0 ' );  end if;
    If p_d  <= 0 or p_d  >1             then raise_application_error(-20000,  p_CP_ID || '1 >=  d д.б. >0 ' );  end if;
    If l_np1<  0 or l_np2<0 or l_np3<0  then raise_application_error(-20000,  p_CP_ID || 'NP-i д.б >=0 '    );  end if;
    If p_ec <= 0                        then raise_application_error(-20000,  p_CP_ID || 'EC д.б > 0 '      );  end if;
 end if;
 --------------------------------------------
 l_kat23 := p_kat23; l_k23   := p_k23  ;

 If (p_kat23 is null or p_k23 is null ) and p_fin23  is not null then
    If    p_FIN23 = 1            then  l_kat23 := 1;  l_k23 := 0;
    elsIf p_FIN23 = 4            then  l_kat23 := 5;  l_k23 := 1;
    elsif p_FIN23 in ( 2,3) and p_vncrr is not null   then
       begin
          select ord into l_ord  from CCK_RATING where code = p_vncrr;
          If p_FIN23  = 2        then
             If p_KY >= 4        then  l_kat23 := 2;
                If    l_ord <=11 then  l_k23   :=  1/100 ;
                elsIf l_ord  =12 then  l_k23   := 10/100 ;
                elsIf l_ord  =13 then  l_k23   := 20/100 ;
                end if;
             else                      l_kat23 := 3;
                If    l_ord <=11 then  l_k23   := 21/100 ;
                elsIf l_ord  =12 then  l_k23   := 30/100 ;
                elsIf l_ord  =13 then  l_k23   := 50/100 ;
                end if;
             end if;

          elsIf p_FIN23  = 3     then  l_kat23 := 4;
                If    l_ord <=21 then  l_k23   := 51/100 ;
                elsIf l_ord  =22 then  l_k23   := 55/100 ;
                elsIf l_ord  =23 then  l_k23   := 60/100 ;
                end if;
          end if;
       exception when no_data_found then null;
       end;
    end if;
 end if;

 update cp_kod set fin23 = p_fin23, vncrr = p_vncrr, kat23 = l_kat23, k23 = l_k23, quot_sign = p_quot, IN_BR = p_IN_BR where id = p_id;

 If p_dox = 1  and p_d is not null and p_ec is not null and p_r is not null then
    l_cf := p_d  * ( l_NP1  + l_np2 + l_np3 )   / ( sign(l_NP1)     + sign(l_NP2)       + sign(l_nP3) ) ;
    l_pv := p_ec *  p_d     * power((1+p_r),-5) +
            l_cf * (1-l_k23)*(power((1+p_r),-1) + power((1+p_r),-2) + power((1+p_r),-3) + power((1+p_r),-4) + power( (1+p_r),-5) );
    update cp_koda set r = p_r, d = P_d, np1 = l_np1, np2 = l_np2, np3 = l_np3, ec = p_ec, pv = l_pv where id = p_id;
    if SQL%rowcount = 0 then
       insert into cp_koda (r, d, np1, np2, np3, ec, pv, id) values (p_r, p_d, l_np1, l_np2, l_np3, p_ec, l_pv, p_id);
    end if;
 end if;

end;
/
show err;

PROMPT *** Create  grants  P_UPDATE_NBU23_CP ***
grant EXECUTE                                                                on P_UPDATE_NBU23_CP to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_UPDATE_NBU23_CP to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_UPDATE_NBU23_CP.sql =========***
PROMPT ===================================================================================== 
