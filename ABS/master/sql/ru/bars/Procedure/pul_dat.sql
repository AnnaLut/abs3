

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PUL_DAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PUL_DAT ***

  CREATE OR REPLACE PROCEDURE BARS.PUL_DAT 
( sFdat1 varchar2,
  sFdat2 varchar2
 ) is

/*
 25.04.2013 01 число месяца за sFdat1. + Ид єтой даты
 11-01-2013 Дата корр оборотыв
 21-01-2011 если пар = пусто
                  если в переменных пусто, то = bank-дате
                  иначе                       = перепеннаЯ

*/

l_dat varchar2(35);

dat01_  date;
dat01m  date;
dat31_  date;

zFdat1_ varchar2(20);
mFdat1_ varchar2(20);
mDI_    number;

/*

Пусть sFdat1 , dat01_ = 01.04.2013  -- отчетная дата
Тогда zFdat1 , dat31_ = 29.03.2013  -- посл.раб.дата отчетного периода
      mFdat1 , dat01m = 01.03.2013  -- 01 число отчетного месца ( идентификатор месяца)
      mDI_   , Z23.DI_              -- числовой идентификатор  отч.месяца

*/

begin

if sFdat1 is null then   l_dat := pul.Get_Mas_Ini_Val('sFdat1');
  If l_dat is null then
     PUL.Set_Mas_Ini( 'sFdat1', to_char(gl.bdate,'dd.mm.yyyy'), 'sар.sFdat1' );
  end if;
else                     PUL.Set_Mas_Ini( 'sFdat1', sFdat1, 'Пар.sFdat1' );
end if;

---------- 01.04.2013 ------------------------------------------
dat01_  := to_date(pul.Get_Mas_Ini_Val('sFdat1'), 'dd.mm.yyyy');

---------- 01.03.2013 ------------------------------------------
dat01m  := add_months(DAT01_ , -1);
mFdat1_ := to_char   (dat01m , 'dd.mm.yyyy') ;
mDI_    := to_number (to_char( DAT01m,'J'  ) ) - 2447892 ;
PUL.Set_Mas_Ini( 'mFdat1', mFdat1_, 'Пар.mFdat1' );
PUL.Set_Mas_Ini( 'mDI', to_char(mDI_), 'Пар.mDI' );

Z23.DI_ := mDI_;
z23.DAT_BEG := DAT01_ ;

---------- 29.03.2013 ------------------------------------------
dat31_  := Dat_last ( dat01_ - 4 , dat01_-1 );
zFdat1_ := to_char (dat31_ , 'dd.mm.yyyy');
PUL.Set_Mas_Ini( 'zFdat1', zFdat1_, 'Пар.zFdat1' );
z23.DAT_END := dat31_ ;

----------------------------------------------------------------


if sFdat2 is null then   l_dat := pul.Get_Mas_Ini_Val('sFdat2');
  If l_dat is null then
     PUL.Set_Mas_Ini( 'sFdat2', to_char(gl.bdate,'dd.mm.yyyy'), 'sар.sFdat2' );
  end if;
else                     PUL.Set_Mas_Ini( 'sFdat2', sFdat2, 'Пар.sFdat2' );
end if;
-------------------------------------------------------------------------


end PUL_DAT;
/
show err;

PROMPT *** Create  grants  PUL_DAT ***
grant EXECUTE                                                                on PUL_DAT         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PUL_DAT         to RPBN001;
grant EXECUTE                                                                on PUL_DAT         to SALGL;
grant EXECUTE                                                                on PUL_DAT         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PUL_DAT.sql =========*** End *** =
PROMPT ===================================================================================== 
