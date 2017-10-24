

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_INFO_UPB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_INFO_UPB ***

  CREATE OR REPLACE PROCEDURE BARS.GET_INFO_UPB /*  для получения инф по КД */
 ( CC_ID_  IN  varchar2, -- идентификатор   КД
   DAT1_   IN  date    , -- дата ввода      КД
   nRet_   OUT int     , -- Код возврата: =1 не найден, Найден =0
   sRet_   OUT varchar2, -- Текст ошибки (?)
   RNK_    OUT int     , -- Рег № заемщика
   nS_     OUT number  , -- Сумма текущего платежа
   nS1_    OUT number  , -- Сумма окончательного платежа
   NMK_    OUT varchar2, -- наименованик клиента
   OKPO_   OUT varchar2, -- OKPO         клиента
   ADRES_  OUT varchar2, -- адрес        клиента
   KV_     IN OUT int  , -- код валюты   КД
   LCV_    OUT varchar2, -- ISO валюты   КД
   NAMEV_  OUT varchar2, -- валютa       КД
   UNIT_   OUT varchar2, -- коп.валюты   КД
   GENDER_ OUT varchar2, -- пол валюты   КД
   nSS_    OUT number  , -- Тек.Сумма осн.долга
   DAT4_   OUT date    , --\ дата завершения КД
   nSS1_   OUT number  , --/ Оконч.Сумма осн.долга
   DAT_SN_ OUT date    , --\ По какую дату нач %
   nSN_    OUT number  , --/ Сумма нач %
   nSN1_   OUT number  ,-- | Оконч.Сумма проц.долга
   DAT_SK_ OUT date    , --\ По какую дату нач ком
   nSK_    OUT number  , --/ сумма уже начисленной комиссии
   nSK1_   OUT number  , --| Оконч.Сумма комис.долга
   KV_KOM_ OUT int     , -- Вал комиссии
   DAT_SP_ OUT date    , -- По какую дату нач пеня
   nSP_    OUT number  , -- сумма уже начисленной пени
   SN8_NLS OUT varchar2, --\
   SD8_NLS OUT varchar2, --/ счета начисления пени
   MFOK_   OUT varchar2, --\
   NLSK_   out varchar2  --/ счет гашения

--   DAT_och OUT date    ,  -- Очередная дата платежа
--   SUM_och OUT number     -- Очередная сумма платежа
) IS


/*
   01-04-2009 Весь текст программы перенесен в процедуру get_info_upb_ext
   23-02-09 Более одного SPN
   06-01-09 Двойной поиск с кодом вал.
            Аналог процедуры cck.GET_INFO,  но с особенностями УПБ - Маршавина
*/

   nSSP_    number; --\ сумма просроченного тела
   nSSPN_   number; --\ сумма просроченных процентов
   nSSPK_   number; --\ сумма  просроченной комиссии
   KV_SN8   varchar2(3);
   Mess_    Varchar2(4000);

begin

get_info_upb_ext (CC_ID_,DAT1_,nRet_,sRet_,RNK_,nS_,nS1_,NMK_,OKPO_,ADRES_,
                  KV_,LCV_,NAMEV_,UNIT_,GENDER_,nSS_,DAT4_,nSS1_,DAT_SN_,nSN_,
                  nSN1_,DAT_SK_,nSK_,nSK1_,KV_KOM_,DAT_SP_,nSP_,KV_SN8,SN8_NLS,SD8_NLS,
                  MFOK_,NLSK_,nSSP_,nSSPN_,nSSPK_,Mess_
                  );


END GET_INFO_UPB;
/
show err;

PROMPT *** Create  grants  GET_INFO_UPB ***
grant EXECUTE                                                                on GET_INFO_UPB    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_INFO_UPB    to WR_ALL_RIGHTS;
grant EXECUTE                                                                on GET_INFO_UPB    to WR_CREDIT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_INFO_UPB.sql =========*** End 
PROMPT ===================================================================================== 
