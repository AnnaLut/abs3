

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAYTT_ABS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAYTT_ABS ***

  CREATE OR REPLACE PROCEDURE BARS.PAYTT_ABS 
(flg_ SMALLINT,  -- флаг оплаты
                ref_ INTEGER,   -- референция
               datv_ DATE,      -- дата валютировния
                 tt_ CHAR,      -- тип транзакции
                dk0_ NUMBER,    -- признак дебет-кредит
                kva_ SMALLINT,  -- код валюты А
               nls1_ VARCHAR2,  -- номер счета А
                 sa_ DECIMAL,   -- сумма в валюте А
                kvb_ SMALLINT,  -- код валюты Б
               nls2_ VARCHAR2,  -- номер счета Б
                 sb_ DECIMAL    -- сумма в валюте Б
) IS

--***************************************************************--
--             Точка пользователя для программы оплаты
--                    Version 03/11/2005)
--                    Для ОщадБанка
--                      c авто-маржой на сч ВП с типом счета = 'SPM'
--                      с авто-овердрафтом
--                      без Расчетного Центра Клиентов
--                      без НСМЭП
--***************************************************************--

-- Общие переменные
   flv_   SMALLINT;
   kv_    SMALLINT;

   NLSM_  VARCHAR2(55);
   NLSK_  VARCHAR2(55);

   kvk_   SMALLINT;
   nlsa_  VARCHAR2(15);
   nlsb_  VARCHAR2(15);
   flg21_ CHAR(1); flg22_ CHAR(1);
   flg23_ CHAR(1); flg24_ CHAR(1);
   nls_k_ VARCHAR2(15);
   ss_    DECIMAL(24);
   nbsd_  CHAR(4);
   rnk_   INTEGER;
   isp_   SMALLINT;
   nms_   VARCHAR2(70);
   nmk_   VARCHAR2(70);
   acc_   INTEGER;
   tmp_   NUMBER;
   grp_   NUMBER;
   dk_    BINARY_INTEGER;
   suf_   VARCHAR2(3);
   mfo_   VARCHAR2(12) DEFAULT NULL;
   ern    CONSTANT POSITIVE := 203;
   erm    VARCHAR2(80);
   err    EXCEPTION;

-- SPM:переменные для расчета SPOT-результата
   tip38_ varchar2(3); -- тип счета ВП
   KVD1_ int;     -- покупаемая валюта
   KVK1_ int;     -- продаваемая валюта
   SD_   number;  -- сумма покупки
   SK_   number;  -- сумма продажм
   MM_   number;   -- сумма маржи
-- OVR:переменные для овердрафта
   OVR_SUM_ number  ;
   OVR_NS8_ varchar2(15);
   l_cntDk1 number;
   l_cntDk0 number;

--------------
FUNCTION f_GetNSC (p_nazn IN VARCHAR2) RETURN VARCHAR2
IS
    tmp_   VARCHAR2(200);
    L_     NUMBER;
    NSC_   VARCHAR2(200);
BEGIN
    L_      := instr (p_nazn, ';');
    tmp_    := substr(p_nazn, L_+1,200);

    L_      := instr (tmp_, ';');
    NSC_    := substr(tmp_, 1, L_-1);

    RETURN NSC_;
END f_GetNSC;
---------------
FUNCTION f_GetDBCODE (p_nazn IN VARCHAR2) RETURN VARCHAR2
IS
    tmp_     VARCHAR2(200);
    L_       NUMBER;
    DBCODE_  VARCHAR2(200);
BEGIN
    L_      := instr (p_nazn, ';');
    tmp_    := substr(p_nazn, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    tmp_    := substr(tmp_, L_+1,200);

    L_      := instr (tmp_, ';');
    DBCODE_ := substr(tmp_, 1, L_-1);

    RETURN  DBCODE_;
END f_GetDBCODE;
----------------------

PROCEDURE auto_op (flg_ CHAR,nls_  VARCHAR2,kv_  NUMBER,
                             nls0_ VARCHAR2,kv0_ NUMBER) IS
--Чья это процедура ? Необходимо Вынести !
BEGIN
   SELECT acc INTO acc_
     FROM accounts WHERE nls=nls_ AND kv=kv_ AND DAZS IS NULL;
EXCEPTION WHEN NO_DATA_FOUND THEN -- AutoOpening
   BEGIN
      BEGIN
         SELECT u.rnk,a.isp,a.nms,a.grp,c.nmk
         INTO   rnk_, isp_, nms_, grp_, nmk_
         FROM accounts a, cust_acc u, customer c
         WHERE a.nls=nls0_ AND a.kv=kv0_ AND
               a.acc=u.acc AND u.rnk=c.rnk;
      EXCEPTION WHEN NO_DATA_FOUND THEN RETURN;
      END;
      IF flg_='2' THEN nms_:=nmk_; END IF;
      OP_REG(99,0,0,grp_,tmp_,rnk_,nls_,kv_,nms_,'ODB',isp_,acc_);
   EXCEPTION  WHEN OTHERS THEN
      erm := '9356 - Unable to open acc #'||nls_||'('||kv_||')';
      RAISE err;
   END;
END;

BEGIN

  If gl.aMFO  ='300465' and tt_='TK ' and  dk0_=1
     and nls1_='2906401'  /* счет картотеки, его тип = NLA */  THEN
     --  перехват операций по разработке
     --  картотеки кредиторов по поверненню Компенсац.виплат
     --  для проверки и синхронного сворачивания по DB_LINK
     --  в депoзитной системе
     declare
         p_ND     oper.nd%type  ; -- он же реф первичного документа
         p_REF    oper.ref%type ; --
         p_nazn   oper.nazn%type; -- новое назнач.платежа

         tmp_  varchar2(200);
         L_    int;

         p_DBCODE varchar2(11); -- код клиента          в БД по DB_LINK
         L_DBCODE int;          -- реальная длина кодa клиента

         p_NSC    varchar(19) ; -- № счета (сберкнижки) в БД по DB_LINK
         L_NSC    int;          -- реальная длина № счета (сберкнижки)

     begin
        select nd, nazn into p_ND, p_nazn from oper where ref= ref_;
        begin
           p_REF :=p_ND;
        EXCEPTION  WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20001, 'Ош.№ док(не число) ='|| p_ND);
        end;

        p_NSC   := f_GetNSC(p_nazn);
        L_NSC   := length(p_NSC);
        p_DBCODE:= f_GetDBCODE(p_nazn);
        L_DBCODE:= length(p_DBCODE);

        If L_DBCODE <1 or L_NSC <1 then
           RAISE_APPLICATION_ERROR (-20001, 'Ош.назн пл.');
        end if;

        -- обращение к процедуре БД ЦентДепоСистемы
        begin
           --   USSR_PAYOFF.payoff_back@DEPDB(p_REF,p_DBCODE,p_NSC );
         tmp_:='USSR_PAYOFF.payoff_back@DEPDB('||
                                              p_REF ||' , '''||
                                                    p_DBCODE ||''', '''||
                                                             p_NSC     || ''')';
         EXECUTE IMMEDIATE tmp_;
        EXCEPTION  WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR (-20001, 'Проблемы в БД ЦентрДепоСистемы' );
        end;
     end;

  end if;
--/////////////////////////////

  -- Подмена переменной dk_ перед всеми проводками
  dk_  := dk0_;

   BEGIN
      SELECT flv, kv, nlsm, kvk, nlsk,
             SUBSTR(flags,21,1), SUBSTR(flags,22,1),
             SUBSTR(flags,23,1), SUBSTR(flags,24,1)
        INTO flv_,kv_,nlsm_,kvk_,nlsk_,flg21_,flg22_,flg23_,flg24_
        FROM tts WHERE tt=tt_;
   EXCEPTION
      WHEN NO_DATA_FOUND THEN
         erm := '9350 - No '||tt_||' operation defined';
         RAISE err;
   END;

   kv_  := NVL(kv_, kva_);
   kvk_ := NVL(kvk_,kvb_);

   IF flg21_='1' THEN nlsa_:=nls2_; ELSE nlsa_:=nls1_; END IF;
   IF flg22_='1' THEN nlsb_:=nls1_; ELSE nlsb_:=nls2_; END IF;

-- A Side -----------------------------------------------------------------

   IF nlsm_ IS NULL THEN
      nlsm_ := nlsa_;
   ELSE
      IF FALSE THEN NULL;

      ELSIF tt_ IN ('K2X','K2B','K01','K02','K03','K04')
         OR tt_ IN ('028')
      THEN
         BEGIN
            SELECT u.rnk,a.isp,a.nms,a.grp,k.nmk,b.mfo
              INTO   rnk_, isp_, nms_, grp_, nmk_, mfo_
              FROM accounts a, cust_acc u, customer k,bank_acc b
             WHERE a.nls=nlsa_ AND a.kv=kva_ AND
                   a.acc=u.acc AND u.rnk=k.rnk AND a.acc=b.acc(+);
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
            erm := '9354 - No account found #'||nlsa_;
            RAISE err;
         END;
-----------------
         nlsm_ := sb_acc(nlsm_,nlsa_);
         IF SUBSTR(tt_,1,2)='K2' THEN
            suf_ := 'K2';

         ELSIF SUBSTR(tt_,1,2)='K0' THEN
            suf_ := 'PO';

         ELSE
            suf_ := tt_;
         END IF;
         nlsm_:=VKRZN(SUBSTR(gl.aMFO,1,5),nlsm_);

         BEGIN
            SELECT acc INTO acc_ FROM accounts WHERE nls=nlsm_ AND kv=kva_ AND dazs IS NULL;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            IF mfo_ IS NULL THEN
               OP_REG(99,0,0,grp_,tmp_,rnk_,nlsm_,kva_,
                      TRIM(SUBSTR(suf_||': '||nmk_,1,70)),'ODB',isp_,acc_);
            ELSE
               OP_REG(5,mfo_,0,grp_,tmp_,rnk_,nlsm_,kva_,
                      TRIM(SUBSTR(suf_||': '||nmk_,1,70)),'ODB',isp_,acc_);
               END IF;
         END;

      ELSIF tt_='1KZ' THEN

         nlsm_ := sb_acc(nlsm_,nlsb_);

      ELSIF tt_='PK%' OR tt_='PK^' THEN --для процессинга
         IF SUBSTR(nlsa_,1,4)='2625' THEN

            --  Физ.лица  делаем соответствие : 17.08.2007 Хихлуха Дмитрий
            -- Карт.сч(Пасс)  -> Тех.овр(Актив)
            -- 2625K50xxxxxxx -> 2625K58xxxxxxx
            -- 2625K51xxxxxxx -> 2625K59xxxxxxx
            -- 2625K52xxxxxxx -> 2625K57xxxxxxx
            -- 2625K53xxxxxxx -> 2625K56xxxxxxx
            -- 2625K54xxxxxxx -> 2625K55xxxxxxx
           If    SUBSTR(nlsa_,6,2) = '51' then nlsm_:= '59';
           ElsIf SUBSTR(nlsa_,6,2) = '52' then nlsm_:= '57';
           ElsIf SUBSTR(nlsa_,6,2) = '53' then nlsm_:= '56';
           ElsIf SUBSTR(nlsa_,6,2) = '54' then nlsm_:= '55';
           Else                                nlsm_:= '58';
           end if;
           nlsm_:=VKRZN(Substr(gl.aMFO,1,5),
                        Substr(NLSA_,1,5)||nlsm_ ||Substr(NLSA_,8,7));

           SELECT a.isp, a.grp, a.nms, c.rnk
           INTO  isp_,  grp_,  nmk_,  rnk_
           FROM accounts a, cust_acc c
           WHERE a.acc=c.acc AND a.nls=nlsa_ AND a.kv=kva_;

           OP_REG(99,0,0,grp_,tmp_,rnk_,nlsm_,kva_,
           'Счет тех. овр. для '||nmk_,'ODB',isp_,acc_);

           UPDATE ACCOUNTS SET PAP=1 WHERE ACC=acc_;

           PK_SET_SPARAM_2625K58( acc_, nlsm_, kva_ );
         ELSE
           nlsm_ := sb_acc(nlsm_,nlsa_);
         END IF;
      ELSE
         nlsm_ := sb_acc(nlsm_,nlsa_);
      END IF;
   END IF;

-- B Side -----------------------------------------------------------------

   IF nlsk_ IS NULL THEN
      nlsk_ := nlsb_;
   ELSE
      IF FALSE THEN NULL;
      ELSIF tt_='OVD'
      THEN
         BEGIN
            SELECT b.nls INTO nlsk_
              FROM accounts b WHERE b.acc =
           (SELECT o.acco FROM acc_over o,accounts a
             WHERE a.nls=nlsa_ AND a.kv=kva_ AND a.acc=o.acc);
         EXCEPTION WHEN NO_DATA_FOUND THEN
            erm := '9357 - No OVERDRAFT account found for #'||nlsa_;
            RAISE err;
         END;
      ELSE
         nlsk_ := sb_acc(nlsk_,nlsb_);
      END IF;
   END IF;

   IF flv_=1 THEN
      ss_ := NVL( sb_, gl.p_iCurval(KV_, SA_, gl.BDATE ) ) ;
   ELSE
      ss_ := sa_;
     kvk_ := kv_;
   END IF;
    select count(*) into l_cntDk1 from dual
    where exists
       (select 1 from acc_over_nbs where nbs2600 = substr(nlsm_,1,4));
    select count(*) into l_cntDk0 from dual
    where exists
       (select 1 from acc_over_nbs where nbs2600 = substr(nlsk_,1,4));

   if (DK_=1 and (substr(NLSM_,1,4) = '2600' or l_cntDk1 > 0)) or
      (DK_=0 and (substr(NLSK_,1,4) = '2600' or l_cntDk0 > 0)) then
      --блок овердрафта с учетом разн?х DK_
      BEGIN
         SELECT least(a.lim+least(a.ostb,0), SA_-greaTEST(a.ostb,0)) ,
                a8.nls
         into OVR_SUM_, OVR_NS8_
         from accounts a, acc_over o, accounts a8
         where SA_>a.ostb and a.lim+a.ostb>0 and
               a.kv=KV_  and a.nls=decode(DK_,1,NLSM_,NLSK_) and
               a.acc=o.acc and a.acc=o.acco and a8.acc=o.acc_8000;
      EXCEPTION WHEN NO_DATA_FOUND THEN OVR_SUM_:=0;
      end;
      if OVR_SUM_ >0 then
         gl.payv(flg_,ref_,datv_,tt_,dk_,kv_,OVR_NS8_,OVR_SUM_,kv_,OVR_NS8_,OVR_SUM_);
      end if;
   end if;

--
  IF flg23_ IN ('1','2') THEN auto_op(flg23_,nlsm_,kv_, nlsa_,kva_); END IF;
  IF flg24_ IN ('1','2') THEN auto_op(flg24_,nlsk_,kvk_,nlsb_,kvb_); END IF;
-------


--
/* ************************************************************** */

declare
  VDAT_ date   ;
  NBS2_ char(4);
begin
  VDAT_ := datv_;
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

   gl.payv(
     flg_,ref_, VDAT_, tt_,dk_,kv_,nlsm_,sa_,kvk_,nlsk_,ss_);

end;

/* ************************************************************** */


-- новый SPM = (старый SPM  +  старый SPO)
-- если ЭТО продажа вал или конверсия
-- расчет реализованного результата  на сч ВП с типом счета ='SPM'

if kv_ <> kvk_ AND substr(nlsa_,1,1)<>'9' AND substr(nlsb_,1,1)<>'9' AND
  (kv_ <>gl.baseval and dk_= 0  or kvk_<>gl.baseval and dk_= 1     ) then
declare
  PUL_3800 varchar2(55);  nls_3800 varchar2(15); acc_3800 int;
  f1_ varchar2(155)    ;  c1_ int; i1_ int;
begin

  --найти счет ВАЛ ПОЗ
  select ltrim(rtrim(s3800)) into PUL_3800 from tts where tt= tt_  ;

  if substr(PUL_3800,1,2)='#(' then -- Dynamic account number present
     begin
       -- из формулы
       f1_:='SELECT '||SUBSTR(PUL_3800,3,LENGTH(PUL_3800)-3)||' FROM DUAL';
       c1_:=DBMS_SQL.OPEN_CURSOR;                 --открыть курсор
       DBMS_SQL.PARSE(c1_, f1_, DBMS_SQL.NATIVE); --приготовить дин.SQL
       DBMS_SQL.DEFINE_COLUMN(c1_,1,nls_3800,15 ) ; --установить знач колонки в SELECT
       i1_:=DBMS_SQL.EXECUTE(c1_);           --выполнить приготовленный SQL
       IF DBMS_SQL.FETCH_ROWS(c1_)>0 THEN      --прочитать
          DBMS_SQL.COLUMN_VALUE(c1_,1,nls_3800);  --снять результирующую переменную
       end if;
       DBMS_SQL.CLOSE_CURSOR(c1_);           -- закрыть курсор
     EXCEPTION  WHEN OTHERS THEN
       erm := 'SPM - 1.Не вычислили счет по формуле '||PUL_3800;
       RAISE err;
     END;
  else
     nls_3800:=PUL_3800;
  end if;

  if dk_=0 then KVK1_:=kv_ ; SK_:= sa_; SD_:=gl.p_icurval(kvk_,ss_,datv_);
  else          KVK1_:=kvk_; SK_:= ss_; SD_:=gl.p_icurval(kv_ ,sa_,datv_);
  end if;

  select tip,acc into tip38_,acc_3800
  from accounts where nls=nls_3800 AND kv=KVK1_;

  if tip38_='SPM' then
     If SD_ = 0 then
        SD_:= gl.p_icurval(KVK1_, SK_, datv_ );
     end if;
     BEGIN
       SELECT s.RATE_SPOT  INTO tmp_  FROM spot s
       WHERE  s.kv=KVK1_  and s.acc in (acc_3800,0) and
            (s.kv,s.acc,s.vdate)=
          (SELECT kv,acc,max(vdate) FROM spot
           WHERE kv = s.KV and acc=s.acc and vdate<datv_
           GROUP BY kv, acc);
     EXCEPTION  WHEN NO_DATA_FOUND THEN
       erm:='SPM - 2.НЕТ курса SPOT для #'||KVK1_||'/'||NLS_3800;
       RAISE err;
     END;
     MM_:=round(SD_ - (SK_ * tmp_), 0); --маржа
     if MM_ <>0 then
        BEGIN
          select rrd.nls  ,rrS.nls  into nlsm_,nlsk_
          from accounts a38, vp_list v, accounts rrD, accounts rrS
          where a38.acc=acc_3800   AND  a38.acc = v.acc3800  AND
              rrS.acc = v.acc_rrS  AND  rrS.kv  = gl.baseval AND
              rrD.kv  = gl.baseval AND  rrD.acc = v.acc_rrD ;
        EXCEPTION  WHEN NO_DATA_FOUND THEN
            erm:='SPM - 3.Ош.VP_LIST для #'||KVK1_;
            RAISE err;
        END;
        if MM_<0 THEN DK_:=0;
        ELSE          DK_:=1;
        END IF;
        MM_:=abs(MM_);
        gl.payv(flg_,ref_,datv_,'SPM',DK_,gl.baseval,nlsm_,MM_,
                                          gl.baseval,nlsk_,MM_);
     end if;
  end if;
EXCEPTION  WHEN NO_DATA_FOUND THEN
   erm := 'SPM - 4.Не нашли счет вал позиции для операции'||TT_;
   RAISE err;
end;

end if;

-- конец блока расчет реализ.результата на  на сч ВП с типом счета ='SPM'


/* ************************ Конец блока КАСКИБ *************************** */



EXCEPTION
   WHEN err THEN
      raise_application_error(-(20000+ern),'\' ||erm,TRUE);
--   WHEN OTHERS THEN
--      raise_application_error(-(20000+ern),SQLERRM,TRUE);
END;
/
show err;

PROMPT *** Create  grants  PAYTT_ABS ***
grant EXECUTE                                                                on PAYTT_ABS       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAYTT_ABS.sql =========*** End ***
PROMPT ===================================================================================== 
