

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/AZZZ.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure AZZZ ***

  CREATE OR REPLACE PROCEDURE BARS.AZZZ as

  CC_ID_   cc_deal.CC_ID%type;
  DAT1_    cc_deal.SDATE%type;
  nRet_    int               ;
  sRet_    varchar2(256)     ;
  rnk_     accounts.RNK%type ;
  nS_      number            ; -- Сумма текущего платежа
  nS1_     number            ; -- Сумма окончательного платежа
  NMK_     operw.value%type  ;
  OKPO_    customer.OKPO%type; -- OKPO         клиента
  ADRES_   operw.value%type  ;
  KV_      accounts.KV%type  ;
  LCV_     tabval.LCV%type   ;  -- ISO валюты   КД
  NAMEV_   tabval.NAME%type  ; -- валютa       КД
  UNIT_    tabval.UNIT%type  ; -- коп.валюты   КД
  GENDER_  tabval.GENDER%type; -- пол валюты   КД
  nSS_     number            ; -- Тек.Сумма осн.долга
  DAT4_    cc_deal.WDATE%type; --\ дата завершения КД
  nSS1_    number            ; --/ Оконч.Сумма осн.долга
  DAT_SN_  date              ; --\ По какую дату нач %
  nSN_     number            ; --/ Сумма нач %
  nSN1_    number            ;-- | Оконч.Сумма проц.долга
  DAT_SK_  date              ; --\ По какую дату нач ком
  nSK_     number            ; --/ сумма уже начисленной комиссии
  nSK1_    number            ; --| Оконч.Сумма комис.долга
  KV_KOM_  int               ; -- Вал комиссии
  DAT_SP_  date              ; -- По какую дату нач пеня
  nSP_     number            ; -- сумма уже начисленной пени
  NLS_8008 accounts.NLS%type ; --\
  NLS_8006 accounts.NLS%type ; --/ счета начисления пени
  MFOK_    oper.MFOB%type    ; --\
  nls_2909 accounts.NLS%type ; --/ счет гашения
--
ref_ int; S_ number;
begin
 S_:=50000;
 CC_ID_ :='IRR';
 DAT1_  := to_date('02-10-2008','dd-mm-yyyy');
 cck.GET_INFO( CC_ID_, DAT1_, nRet_, sRet_, rnk_,
  nS_    , -- Сумма текущего платежа
  nS1_   , -- Сумма окончательного платежа
  NMK_   , OKPO_, ADRES_, KV_, LCV_, NAMEV_, UNIT_, GENDER_,
  nSS_   , -- Тек.Сумма осн.долга в целых
  DAT4_  ,
  nSS1_  , -- Оконч.Сумма осн.долгав целых
  DAT_SN_,
  nSN_   , -- Сумма нач % в целых
  nSN1_  , -- Оконч.Сумма проц.долгав целых
  DAT_SK_,
  nSK_   , -- сумма уже начисленной комиссии в целых
  nSK1_  , -- Оконч.Сумма комис.долга в целых
  KV_KOM_,
  DAT_SP_,
  nSP_   , -- сумма уже начисленной пени
  NLS_8008, NLS_8006, MFOK_, nls_2909
);


 GL.REF (REF_);

 GL.IN_DOC3( REF_,'CCK',6,REF_,SYSDATE,GL.BDATE,1,
  KV_,S_,KV_,S_,  null,GL.BDATE,GL.BDATE,
 'касса' ,'10012' ,gl.AMFO,
 'сч.гаш',nls_2909,gl.AMFO,
 'тест-гаш',NULL, OKPO_,OKPO_, null,null, 0, null,gl.auid);

  INSERT INTO operw (ref,tag,value) VALUES (REF_,'CC_ID','IRR' );


-- ref_:= 12571331;
-- GL.REF (REF_);
 PAYTT(0,REF_,GL.BDATE,'CCK',0,KV_,nls_2909,S_,KV_,'10012',S_);

end;
/
show err;

PROMPT *** Create  grants  AZZZ ***
grant EXECUTE                                                                on AZZZ            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/AZZZ.sql =========*** End *** ====
PROMPT ===================================================================================== 
