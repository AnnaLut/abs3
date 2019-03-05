---========================================================================================

CREATE OR REPLACE FUNCTION BARS.KOMIS_DP2_OVDP
                 ( 
                   p_S         NUMERIC,   
                   p_NLSA      VARCHAR2,    
                   p_NLSB      VARCHAR2,     
                   p_VOVDP     VARCHAR2      
                 )       
----------------------------------------------------------------------------------------
--
--                  Функция расчета суммы комиссионной операции KD8
--
--  KD8 - дочерняя для DP2.  Она взимает комиссию, если операцией DP2 выполняется перечисление  
--  с 2620/39 на преобретение ОВДП:   Дт 2620/39 - Кт 2901   
--  Тогда KD8:  Дт 2620/39 - Кт 6510/H6
--           
----------------------------------------------------------------------------------------

RETURN NUMERIC IS           
  sk_       NUMERIC ;             --  Cумма комиссии  (в КОП)
  ob22_A    accounts.ob22%type ;
  ob22_B    accounts.ob22%type ;
  ern       CONSTANT POSITIVE := 803;
BEGIN


  Begin
     select OB22 into ob22_A From Accounts Where NLS = p_NLSA  and KV = 980 ; 
     select OB22 into ob22_B From Accounts Where NLS = p_NLSB  and KV = 980 ; 
  Exception when NO_DATA_FOUND then
     Return 0;
  End;

      
  If substr(p_NLSA,1,4)='2620' and ob22_A='39'  and  substr(p_NLSB,1,4)='2901' and ob22_B='02'  Then 

     If     trim(p_VOVDP) ='0' then

         raise_application_error (- (20000 + ern), '\9999   Введіть доп.реквізит <Валюта ОВДП>: 1 - грн, 2 - вал', TRUE);
                       
     ElsIf  trim(p_VOVDP) ='1' then

        sk_ := F_TARIF(165,980,p_NLSA,p_S);

     ElsIf  trim(p_VOVDP) ='2' then

        sk_ := F_TARIF(166,980,p_NLSA,p_S);

     Else

       raise_application_error (- (20000 + ern),  '\9999   Значення доп.реквізиту <Валюта ОВДП> має бути 1 або 2', TRUE);

     End If;

  Else 

    sk_ := 0 ;

  End If;
 

  RETURN sk_ ;   
          
END KOMIS_DP2_OVDP;
/

grant execute on KOMIS_DP2_OVDP to START1;

