---========================================================================================

CREATE OR REPLACE FUNCTION BARS.KOMIS_DP1_VIP
                 ( 
                   p_S         NUMERIC,   
                   p_NLSA      VARCHAR2,    
                   p_KV        INTEGER,
                   p_KMVIP     VARCHAR2      
                 )       
----------------------------------------------------------------------------------------
--
--   Функция расчета суммы комиссионной операции KD9  (KD9 - комиссионная к DP1)
--
--  Она взимает комиссию, если операцией DP1 выдаются нал. со счета 2620 VIP-клиента 
--  (сегмент 'Прайвет' или 'Преміум') и операционист проставил допреквизит  KMVIP = 1
--  "Списати комісію з VIP-клієнта (1-Так,2-Ні)" 
--
--  Комиссия:   Дт 2620 - Кт 6510/28
----------------------------------------------------------------------------------------

RETURN NUMERIC IS           
   sk_        NUMERIC ;             --  Cумма комиссии  (в КОП)
   rnk_       accounts.RNK%type ;
   vip_       NUMERIC ;
   ern        CONSTANT POSITIVE := 803;
BEGIN

  vip_ := 0;

  Begin

     SELECT RNK  into  rnk_ 
     From   Accounts 
     Where  NLS = p_NLSA  and KV = p_KV ; 

     SELECT  1  into vip_
     FROM  V_CUSTOMER_SEGMENTS
     WHERE RNK = rnk_
       AND CUSTOMER_SEGMENT_FINANCIAL IN ('Прайвет','Преміум')
       AND ROWNUM = 1;

  Exception when NO_DATA_FOUND then

     Return 0;

  End;

      
  If substr(p_NLSA,1,4)='2620' and  vip_ = 1  Then    ---  Это VIP-клієнт !

     If     trim(p_KMVIP) ='0' then

    ----    raise_application_error (- (20000 + ern), '\9999   Це VIP-клієнт. Введіть доп.реквізит < Списати комісію з VIP (1-Так,2-Ні) >.  Комісія не береться: при виплаті переказів, відправлених фіз.особами з іншої установи АТ "Ощадбанк",  виплаті переказів від юр.осіб з якими укладені відповідні договори (на виплату заробітної плати, пенсій) ', TRUE);
        raise_application_error (- (20000 + ern), '\9999   Це VIP-клієнт. Введіть доп.реквізит "Списати комісію з VIP (1-Так,2-Ні)" на безготівкове списання комісії (1%, мiн.=20 грн) з рах.клієнта.', TRUE);
                       
     ElsIf  trim(p_KMVIP) ='1' then

        sk_ := F_TARIF(151,980,p_NLSA,p_S);

     ElsIf  trim(p_KMVIP) ='2' then

        sk_ := 0;

     Else

        raise_application_error (- (20000 + ern),  '\9999   Значення доп.реквізиту "Списати комісію з VIP" має бути 1 або 2', TRUE);

     End If;

  Else 

    sk_ := 0 ;

  End If;
 

  RETURN sk_ ;   
          
END KOMIS_DP1_VIP;
/

grant execute on KOMIS_DP1_VIP to START1;

