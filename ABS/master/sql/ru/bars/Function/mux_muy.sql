
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/mux_muy.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.MUX_MUY (p_tt tts.tt%type) RETURN number IS
 oo     oper%ROWtype;
 l_s    number ;
 l_e150 number := 14999999;
 l_n150 number ;
 l_n    number :=0 ;
begin
  begin
    select * into oo from oper where ref=gl.aref;
    l_n150 := gl.p_Ncurval( oo.kv, l_e150 , gl.bdate);
    l_S    := least ( round(oo.s), l_n150 );

    If    p_tt in('MUX','MVX' )   then l_n := l_S;                      -- 2909/75 - 1002 - Для виплати (екв <150 тис)
    elsIf p_tt in('MUY','MVY')   then l_n := greatest ( 0,oo.s-l_n150); --2909/75 - 2900/01 Для обов.продажу  (екв ,>=150 тис)
    elsIf p_tt In('MUQ','MVQ','QQQ')   then                                 -- Викуп нерозм.монети
       If    oo.kv = 980 then l_n := 0             ;           -- 980
       elsIf oo.kv = 978 then l_n := MOD(l_s, 500) ;           -- 978
       elsIf oo.kv = 643 then l_n := MOD(l_s, 500) ;           -- 643
       elsIf oo.kv = 826 then l_n := MOD(l_s, 500) ;           -- 826
       elsIf oo.kv = 124 then l_n := MOD(l_s, 500) ;           -- 124
       elsIf oo.kv = 756 then l_n := MOD(l_s,1000) ;           -- 756
       else                   l_n := MOD(l_s, 100) ;           -- ***
       end if;
       If p_Tt = 'QQQ'   then l_n := eqv_obs(oo.KV, l_n , SYSDATE, 1 );
       end if;
    end if;

  EXCEPTION  WHEN NO_DATA_FOUND THEN null;
  end;

  Return l_n;


end MUX_MUY;
/
 show err;
 
PROMPT *** Create  grants  MUX_MUY ***
grant EXECUTE                                                                on MUX_MUY         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MUX_MUY         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/mux_muy.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 