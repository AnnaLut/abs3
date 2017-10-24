
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/fr23_cp.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.FR23_CP 
( p_dox  int   ,
  p_emi  int   ,
  p_datp date  ,
  p_accs number,
  p_BV   number,
  p_PV   number,
  p_K23  number,
  p_quot int   ,
  p_nls  varchar2,
  p_ref  number,
  p_dat  date
 ) return  number is

  l_rez number := 0;  l_dat01 date := to_date ( pul.Get_Mas_Ini_Val('sFdat1'),'dd.mm.yyyy');
  dat31_ date  := to_date ( pul.Get_Mas_Ini_Val('zFdat1'),'dd.mm.yyyy');

begin
-- з корр
  If    p_emi in (0,6)          or
        p_nls like '30%'        or
        p_nls like '140%'       or
        p_emi =10 and p_dox=1      then L_REZ := 0     ;
  ElsIf p_datp <  l_dat01          then l_REZ := p_BV  ;
  elsIf p_quot = 1                 then l_rez := f_cp_pereoc(p_ref, p_dat,0); --ost_korr(p_accs, dat31_,null,'3114' )/100 ;
        If  l_rez >0               then l_rez := l_REZ ;
        else                            l_rez := 0     ;
        end if;
  else                                  l_REZ := round( greatest(  (p_BV - p_PV*(1-p_K23)),0),2);
  end if;
  RETURN l_REZ;
end FR23_CP;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/fr23_cp.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 