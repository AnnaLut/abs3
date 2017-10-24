
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/caf_kom.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CAF_KOM 
 ( p_TT oper.tt%type, -- код доч.операции
   p_kv oper.kv%type, -- код валюты осн.операции
   p_s  oper.s%type   -- сумма в "коп" осн.операции
 )
 RETURN NUMBER is

 k_175    int := 17500000; -- константа дл€ вычислени€ тарифа
 k_3500   int := 350000  ;
 k_komv   int := 131300  ;
 l_Ret  oper.s%type;

 --- l_s    oper.s%type :=
 ---       GL.P_ICURVAL( p_kv,
 ---                     F_TARIF( IIF_N ( p_S, k_175, 82,83,83 ),
 ---                              p_kv,
 ---                              '',
 ---                              p_S
 ---                             ),
 ---                     SYSDATE
 ---                    );

 l_s    oper.s%type :=
                    F_TARIF( IIF_N ( p_S, k_175, 82,83,83 ),p_kv,'',p_S);


begin

 If    p_TT ='K57'       then l_Ret :=  GL.P_ICURVAL( p_kv,F_TARIF( IIF_N ( p_S, k_175, 82,83,83 ),p_kv,'',p_S),SYSDATE);

 elsIf p_TT ='CCF'       then

       --If p_s < k_175 then l_Ret := round(GL.P_ICURVAL( p_kv,F_TARIF( IIF_N ( p_S, k_175, 82,83,83 ),p_kv,'',p_S),SYSDATE) * (0.375));
	   If p_s < k_175 then l_Ret :=  GL.P_ICURVAL( p_kv,F_TARIF( IIF_N ( p_S, k_175, 82,83,83 ),p_kv,'',p_S),SYSDATE) -  GL.P_ICURVAL(p_kv,(round(l_s * (0.625))), sysdate);
       else                l_Ret := round(GL.P_ICURVAL( p_kv,(l_s-round(l_s * (0.625))),SYSDATE) ) - gl.p_icurval(p_kv,218700,SYSDATE );
	   --else                l_Ret := round(GL.P_ICURVAL( p_kv,F_TARIF( IIF_N ( p_S, k_175, 82,83,83 ),p_kv,'',p_S),SYSDATE) * (0.375)) - gl.p_icurval(p_kv,218700,SYSDATE );
       end if;

 elsIf p_TT ='CDF'       then

       If p_s < k_175 then l_Ret := round(l_s * (0.625));
       else                   l_Ret := gl.p_icurval(p_kv,218700,SYSDATE );
       end if;

 else                         l_Ret := 0 ;
 end if;

 RETURN l_Ret;

end CAF_KOM;
/
 show err;
 
PROMPT *** Create  grants  CAF_KOM ***
grant EXECUTE                                                                on CAF_KOM         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CAF_KOM         to BARS_CONNECT;
grant EXECUTE                                                                on CAF_KOM         to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/caf_kom.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 