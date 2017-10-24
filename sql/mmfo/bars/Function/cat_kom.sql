
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cat_kom.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CAT_KOM 
 ( p_TT oper.tt%type, -- код доч.операции
   p_kv oper.kv%type, -- код валюты осн.операции
   p_s  oper.s%type   -- сумма в "коп" осн.операции
 )
 RETURN NUMBER is

 k_495000 int := 495000; -- константа дл€ вычислени€ тарифа
 k_3713   int := 3713  ;
 l_Ret  oper.s%type;

 l_s    oper.s%type :=
        GL.P_ICURVAL( p_kv,
                      F_TARIF( IIF_N ( p_S, k_495000, 71,73,73 ),
                               p_kv,
                               '',
                               p_S
                              ),
                      SYSDATE
                     );



begin

 If    p_TT ='K56'       then l_Ret := l_s;

 elsIf p_TT ='CCT'       then

       If p_s < k_495000 then l_Ret := round(l_s * (0.375));
       else                   l_Ret := gl.p_icurval(p_kv,k_3713,SYSDATE );
       end if;

 elsIf p_TT ='CDT'       then

       If p_s < k_495000 then l_Ret := l_s - round(l_s * (0.375));
       else                   l_Ret := l_s - gl.p_icurval(p_kv,k_3713,SYSDATE);
       end if;

 else                         l_Ret := 0 ;
 end if;

 RETURN l_Ret;

end CAT_KOM;
/
 show err;
 
PROMPT *** Create  grants  CAT_KOM ***
grant EXECUTE                                                                on CAT_KOM         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CAT_KOM         to BARS_CONNECT;
grant EXECUTE                                                                on CAT_KOM         to PYOD001;
grant EXECUTE                                                                on CAT_KOM         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cat_kom.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 