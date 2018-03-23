

CREATE OR REPLACE FUNCTION BARS.F_Tarif_DPV (p_ref    INTEGER,  -- oper.REF
                                             p_kv     INTEGER,  -- oper.KV
                                             p_nls    VARCHAR2, -- oper.NLSA
                                             p_s      NUMERIC)  -- oper.S
----------------------------------------------------------------------------
--  Ф-я расчета комиссии за операцию DPV ( = сумма доч.комис. KD1)
----------------------------------------------------------------------------
   RETURN NUMERIC
IS

   sk_        NUMERIC;         ---  расчетная сумма комиссии
   acc_       NUMERIC;
   ostc_      NUMERIC;  ---  остаток на счете в p_KV
   ostc_980   NUMERIC;  ---  остаток на счете в грн-экв.
   smin_840   NUMERIC;  ---  min сумма тарифа 20 (она в USD)
   smin_980   NUMERIC;  ---  min сумма тарифа 20 в грн-экв.

BEGIN

   ---  Остаток на счете-Дт (oper.NLSA):

   Select ACC, OSTC into acc_, ostc_
   From   Accounts
   where  NLS = p_nls  and  KV = p_kv ;


   Begin     ---  Ищем вначале инд.тариф 20 по счету 

     Select SMIN into smin_840 
     From   ACC_TARIF 
     where  KOD = 20 and ACC = acc_ ;

   EXCEPTION WHEN NO_DATA_FOUND THEN

     Select nvl(SMIN,0) into smin_840 
     From   TARIF 
     where  KOD = 20 ;

   End;


   sk_ :=  EQV_OBS ( p_kv, F_TARIF(20,p_KV,p_NLS,p_S), SYSDATE);

   IF smin_840 > 0 then

      ostc_980 := GL.P_ICURVAL (p_kv, ostc_   , SYSDATE); -- остаток на счете в грн-экв.
      smin_980 := GL.P_ICURVAL (840 , smin_840, SYSDATE); -- грн-экв. 5 USD

      if ostc_980 <  smin_980  then

         sk_ := ostc_980 ;

      end if;

   END IF;

   RETURN sk_;

END F_Tarif_DPV;
/
grant execute on F_Tarif_CAA to START1;
grant execute on F_Tarif_CAA to bars_access_defrole;


