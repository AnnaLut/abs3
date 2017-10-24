
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/elpay.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ELPAY AS
/**
*
* Пакет elpay - содержит процедуры для работы
* интерфейсного модуля для программы клиент-банк
* ElPay  http://www.elpay.com
*
* @author SERG
* @creation date: 5-SEP-2001
*
* v 1.0.2 * 11-OCT-2002
*         p_lic_elpay():
*					ревизия ошибки OKPO_A=OKPO_B
*
* v 1.0.1 * 19-FEB-2002
*         p_lic_elpay():
*					correct some child transaction features
*
* v 1.0.0 * 12-SEP-2001
*         basic functionality implementation
*
*/


-- вставка документа ElPay в KLP
PROCEDURE indoc_elpay
  (
		 -- реквизиты отправителя
		 p_mfo_a   VARCHAR2,
		 p_nls_a   VARCHAR2,
		 p_okpo_a  VARCHAR2,
		 p_nam_a   VARCHAR2,
		 -- реквизиты получателя
 		 p_mfo_b   VARCHAR2,
		 p_nls_b   VARCHAR2,
		 p_okpo_b  VARCHAR2,
		 p_nam_b   VARCHAR2,
		 -- финансовые реквизиты
		 p_sum	   NUMBER,
		 p_dk	   NUMBER,
		 p_kv      NUMBER,
		 p_nd      VARCHAR2,
     	 p_koper   NUMBER,
		 p_vob	   NUMBER,
		 p_status  NUMBER,
		 p_valdate DATE,
		 p_date	   DATE,
		 p_nazn    VARCHAR2,
     	 p_dop_rec VARCHAR2,
		 p_elpayid NUMBER);

-- выгрузка платежей на ElPay
PROCEDURE p_lic_elpay (id_ 				SMALLINT,
											 dt1_ 			DATE,
											 dt2_ 			DATE,
											 maskasab_ 	VARCHAR2,
                    	 kvz_ 			SMALLINT,
											 maskanls_ 	VARCHAR2);

-- население временной таблицы сальдо счетов
PROCEDURE make_saldo(nSTMT NUMBER, dtStartDate DATE, dtFinishDate DATE);

END elpay;
/
CREATE OR REPLACE PACKAGE BODY BARS.ELPAY AS

/**
* PROCEDURE indoc_elpay - вставка документа ElPay в KLP
* SERG: 12-SEP-2001
* Код процедуры: 101
* Возможные коды возвращаемых ошибок:
* '9901 - MFO_A must be equal to '||m_mfo;
* '9902 - RNK not found for OKPO='||p_okpo_a||' and NLS='||p_nls_a;
* '9903 - Field customer.sab is NULL. You must define it.';
* '9904 - Field accounts.isp is NULL. You must define it.';
* '9905 - Duplicate document with ElPayID(POND)='||p_elpayid;
*/
PROCEDURE indoc_elpay (
   -- реквизиты отправителя
   p_mfo_a   VARCHAR2,  -- МФО
   p_nls_a   VARCHAR2,  -- номер счета
   p_okpo_a  VARCHAR2,  -- код ОКПО
   p_nam_a   VARCHAR2,  -- наименование
   -- реквизиты получателя
   p_mfo_b   VARCHAR2,  -- МФО
   p_nls_b   VARCHAR2,  -- номер счета
   p_okpo_b  VARCHAR2,  -- код ОКПО
   p_nam_b   VARCHAR2,  -- наименование
   -- финансовые реквизиты
   p_sum     NUMBER,    -- сумма документа
   p_dk      NUMBER,    -- признак дебет/кредит (0/1)
   p_kv      NUMBER,    -- код валюты
   p_nd      VARCHAR2,  -- номер документа
   p_koper   NUMBER,    -- код операции
   p_vob     NUMBER,    -- вид документа (тип проводки)
   p_status  NUMBER,    -- статус документа
   p_valdate DATE,      -- желаемая дата проплаты
   p_date    DATE,      -- дата создания документа
   p_nazn    VARCHAR2,  -- назначение платежа
   p_dop_rec VARCHAR2,  -- вспомогательные реквизиты
   p_elpayid NUMBER     -- идентификатор документа в ElPay
   )
IS
   erm         VARCHAR2          ( 80 );
   ern         CONSTANT POSITIVE        := 101; -- indoc_elpay error code
   err         EXCEPTION;
   mod_num     CONSTANT POSITIVE        :=   1; -- номер процедуры
   m_duplicate NUMBER;                          -- признак дублирования док.
   m_fname     VARCHAR2          ( 13 );        -- имя псевдо-файла
   m_isp       NUMBER;                          -- код исполнителя счета
   m_mfo       VARCHAR2          ( 12 );        -- наше МФО
   m_pond      VARCHAR2          ( 10 );        -- ElPayID
   m_rnk       NUMBER;                          -- регистрационный номер
                                                -- клиента (RNK)
   m_sab       CHAR              (  4 );        -- SAB клиента
   sberbank_   VARCHAR2          ( 50 );        -- Для сбербанка: старый
                                                -- клиент-банк+ElPay
   stmt_type   NUMBER;                          -- тип (номер) эл. клиента банка
                                                -- для ElPay
BEGIN
   IF deb.debug THEN
      deb.trace ( mod_num, 'Start elpay.indoc_elpay()', 0 );
   END IF;
   BEGIN
      SELECT
         val
      INTO
         sberbank_
      FROM
         params
      WHERE
         par =      'KL_BOB' AND
         val IS NOT NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            sberbank_ := '0';
   END;
   IF sberbank_ <> '1' THEN
      sberbank_ := '0';
   END IF;
   -- ========================================================================
   -- получение необходимых данных + всевозможные проверки
   -- проверка: МФО_А равно нашему ?
   m_mfo := gl.aMFO;
   IF m_mfo <> p_mfo_a THEN
      erm := '9901 - MFO_A must be equal to ' || m_mfo;
      RAISE err;
   END IF;
   -- определяем номер (тип) эл. клиента для ElPay
   BEGIN
      SELECT
         TO_NUMBER ( val )
      INTO
         stmt_type
      FROM
         params
      WHERE
         par =      'EPSTMT' AND
         val IS NOT NULL;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            erm :=
               '9910 - Parameter EPSTMT not found in table PARAMS or is empty';
            RAISE err;
   END;
   IF deb.debug THEN
      deb.trace ( mod_num, 'EPSTMT: ', stmt_type );
   END IF;
   -- получаем регистрационный номер клиента (RNK) + SAB
   BEGIN
      SELECT
         c.rnk,
         c.sab,
         a.isp
      INTO
         m_rnk,
         m_sab,
         m_isp
      FROM
         accounts a,
         customer c,
         cust_acc c_a
      WHERE
         a.NLS   = p_nls_a   AND
         a.KV    = p_kv      AND
         a.ACC   = c_a.ACC   AND
         c_a.RNK = c.RNK     AND
         c.OKPO  = p_okpo_a;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            erm :=
               '9902 - RNK not found for OKPO=' || p_okpo_a || ' and NLS=' || p_nls_a;
         RAISE err;
   END;
   IF m_sab IS NULL THEN
      -- эл. код клиента должен быть определен!!
      erm := '9903 - Field customer.sab is NULL. You must define it.';
      RAISE err;
   END IF;
   IF m_isp IS NULL THEN
      -- исполнитель счета не проставлен?
      erm := '9904 - Field accounts.isp is NULL. You must define it.';
      RAISE err;
   END IF;
   -- проверяем на повторный прием документа
   -- закладываемся на их ElPayID(наш klp.pond)
   -- если прут одинаковые документы с разными ElPayID ==> их проблема
   m_duplicate := 1; -- предполагаем, что есть дубликат
   BEGIN
      SELECT
         pond
      INTO
         m_pond
      FROM
         klp
      WHERE
         pond    = p_elpayid AND
         cl_type = stmt_type;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            m_duplicate := 0; -- док. с таким ElPayID не найден
   END;
   IF m_duplicate <> 0 THEN
      erm := '9905 - Duplicate document with ElPayID(POND)=' || p_elpayid;
      RAISE err;
   END IF;
   -- составляем имя псевдо-файла, в котором якобы пришел документ
   IF sberbank_ = '1' THEN
      m_fname :=
         '@A12345' || SUBSTR ( m_sab, 1, 1 ) || '.' || SUBSTR ( m_sab, 2, 3 );
   ELSE
      m_fname := '@A' || m_sab || '12.345';
   END IF;
   IF deb.debug THEN
      deb.trace ( mod_num, 'm_rnk = ', m_rnk );
      deb.trace ( mod_num, 'm_sab = ', m_sab );
      deb.trace ( mod_num, 'm_isp = ', m_isp );
      deb.trace ( mod_num, 'm_fname = ', m_fname );
   END IF;
   -- ========================================================================
   -- вставляем данные в таблицу KLP
   INSERT INTO klp (
      dop,
      eom,
      naex,
      vob,
      nd,
      datad,
      nls,
      mfo,
      naimp,
      nlsp,
      s,
      text1,
      isp,
      kokb,
      koka,
      koko,
      prwo,
      pdp1,
      fl,
      pond,
      rowidd,
      kv,
      cl_type
      )
   VALUES (
      0,
      m_isp,
      m_fname,
      p_vob,
      p_nd,
      p_date,
      p_nls_a,
      p_mfo_b,
      p_nam_b,
      p_nls_b,
      p_sum,
      p_nazn,
      m_isp,
      p_okpo_b,
      p_okpo_a,
      NULL,
      NULL,
      NULL,
      0,
      p_elpayid,
      NULL,
      p_kv,
      stmt_type
      );
      EXCEPTION
         WHEN err THEN
            IF deb.debug THEN
               deb.trace (
                  mod_num, 'Application error in elpay.indoc_elpay', ern );
            END IF;
            RAISE_APPLICATION_ERROR ( - ( 20000 + ern ), '\' || erm, TRUE );
         WHEN OTHERS THEN
            IF deb.debug THEN
               deb.trace ( mod_num, 'General error in elpay.indoc_elpay', ern );
            END IF;
            RAISE_APPLICATION_ERROR ( - ( 20000 + ern ), SQLERRM, TRUE );
END indoc_elpay;


/**
* PROCEDURE p_lic_elpay - выгрузка проводок на ElPay
* Код процедуры: 102
* Возможные коды возвращаемых ошибок:
* Bugs list:
* 11-OCT-2002  ревизия ошибки OKPO_A=OKPO_B
*/
PROCEDURE p_lic_elpay(
   id_       SMALLINT,      -- идентификатор пользователя, формирующего выписку
   dt1_      DATE,          -- дата начала выписки
   dt2_      DATE,          -- дата окончания выписки
   maskasab_ VARCHAR2,      -- маска для SAB(эл. адрес) клиента
                            -- в наст. время все клиенты ElPay ДОЛЖНЫ иметь sab = 'E000' !!
                            -- соотв. maskasab_= 'E000'
   kvz_      SMALLINT,      -- код валюты (980 - грн.)
   maskanls_ VARCHAR2) IS   -- маска по номеру счета (не используется)
-- объявляем немеряно всяких переменных
dk_        int;
s1_        int;
k14_       varchar2(15);
n38_       varchar2(38);
acc_       SMALLINT;
fdat_      DATE;
dapp_      DATE;
datd_      DATE;
ostf_      DECIMAL(24);
dos_       DECIMAL(24);
kos_       DECIMAL(24);
nls_       varchar2(15);
kv_        SMALLINT;
ref_       SMALLINT;
tip_       char(3);
tt_        char(3);
tto_       char(3);
s_         DECIMAL(24);
vdat_      DATE;
pdat_      DATE;
nd_        char(10);
mfoa_      varchar2(12);
nlsa_      varchar2(15);
txt_       varchar2(160);
nama_      varchar2(38);
mfob_      varchar2(12);
nlsb_      varchar2(15);
namb_      varchar2(38);
nazn_      varchar2(160);
nazn1      varchar2(160);
userid_    SMALLINT;
sk_        SMALLINT;
kvs_       SMALLINT;
isp_       SMALLINT;
nms_       varchar2(38);
pond_      varchar2(10);
filename_  varchar2(12);
kokb_      varchar2(14);
koka_      varchar2(14);
id_a_      varchar2(14);
vob_       SMALLINT;
nazns_     VARCHAR2(2);
bis_       NUMBER;
naznk_     VARCHAR2(3);
d_rec_     VARCHAR2(80);
fn_a_      VARCHAR2(12);
amfo_      varchar2(12);
sosa_      SMALLINT;
rec_       int;
nb_a_      VARCHAR2(38);
nb_b_      VARCHAR2(38);
opl_sos_   SMALLINT;
opldok_id_ NUMBER;
record_id_ VARCHAR2(128);

mod_num    CONSTANT POSITIVE := 2;    -- номер процедуры

ern        CONSTANT POSITIVE := 102;  -- p_lic_elpay error code
err        EXCEPTION;
erm        VARCHAR2(80);

stmt_type  NUMBER;                    -- тип(номер) эл. клиента банка для ElPay

-- обявления курсоров:

-- курсор по счетам электронных клиентов
CURSOR SALDOA0 IS
   SELECT
      s.acc,
      s.fdat,
      s.ostf,
      s.dos,
      s.kos,
      a.nls,
      a.kv,
      s.pdat,
      a.isp,
      substr(a.nms,1,38),
      c.okpo
   FROM
      saldoa   s,
      accounts a,
      customer c,
      cust_acc cu,
      acc_clb  a_c,  /* мульти-клиент-банк */
      cust_clb c_l
   WHERE  c_l.clbid = stmt_type
      and c_l.rnk   = c.rnk
      and c_l.clbid = a_c.clbid
      and a.acc = s.acc
      and a.acc = a_c.acc
      and s.fdat    >=     dt1_
      and s.fdat    <=     dt2_
      and a.acc  = cu.acc
      and cu.rnk = c.rnk
     and a.tip     NOT IN ('N99','L99','N00','T00','T0D','TNB','TND','TUR','TUD','L00');

-- курсор по проводкам
-- оплаченных док.
CURSOR OPLDOK1 IS
   SELECT
      id,
      dk,
      s,
      ref,
      tt,
      ABS(s*(2*dk-1)),
      txt,
      sos
   FROM
      opldok
   WHERE
      acc  = acc_  AND
      fdat = fdat_ AND
      sos  = 5
   UNION
   SELECT
      id,
      o.dk,
      o.s,
      o.ref,
      o.tt,
      ABS(o.s*(2*o.dk-1)),
      o.txt,
      p.sos
   FROM
      opldok_back o,
      oper        p
   WHERE
      o.acc             =  acc_       AND
      o.fdat            =  fdat_      AND
      o.ref             =  p.ref      AND
      (p.sos            =  -2         AND
      o.tt              <> 'BAK'      OR
      p.sos             =  -1         AND
      SUBSTR(o.txt,0,6) <> 'СТОРНО');
-- курсор по документам
CURSOR OPER1 IS
   SELECT
      tt,
      vdat,
      pdat,
      nd,
      mfoa,
      nlsa,
      nam_a,
      mfob,
      nlsb,
      nam_b,
      nazn,
      userid,
      sk,
      kv,
      vob,
      datd
   FROM
      oper
   WHERE
      ref = ref_;

BEGIN

   IF deb.debug THEN
      deb.trace(mod_num,'Start elpay.p_lic_elpay()', 0);
   END IF;
   -- определяем номер(тип) эл. клиента для ElPay
   BEGIN
      SELECT
         TO_NUMBER(val)
      INTO
         stmt_type
      FROM
         params
      WHERE
         par='EPSTMT';
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         erm := '9910 - Parameter EPSTMT not found in table params';
      RAISE err;
   END;
   IF deb.debug THEN
      deb.trace(mod_num,'EPSTMT:', stmt_type);
   END IF;

   -- чистим временную таблицу
   DELETE
   FROM
      tmp_lics_elpay
   WHERE
      id = id_;

   amfo_:=gl.amfo;

   -- получаем наименование нашего банка
   BEGIN
      SELECT
         nb
      INTO
         nb_a_
      FROM
         banks
      WHERE
         mfo = TO_CHAR(f_ourmfo);
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
         nb_a_ := 'Банк не найден';
   END;
   -- открываем курсоры
   OPEN SALDOA0;
   LOOP
      FETCH SALDOA0 INTO
         acc_,
         fdat_,
         ostf_,
         dos_,
         kos_,
         nls_,
         kv_,
         dapp_,
         isp_,
         nms_,
         koka_;
      EXIT WHEN SALDOA0%NOTFOUND;
      IF deb.debug THEN
         deb.trace(mod_num,'SALDOA cursor: acc='||acc_||', fdat='||fdat_, 0);
      END IF;
      OPEN OPLDOK1;
      LOOP
         FETCH OPLDOK1 INTO
            opldok_id_,
            dk_,
            s1_,
            ref_,
            tt_,
            s_,
            txt_,
            opl_sos_;
         EXIT WHEN OPLDOK1%NOTFOUND;
         IF deb.debug THEN
            deb.trace(mod_num,'OPLDOK cursor: ref='||ref_||', tt_='||tt_, 0);
            deb.trace(mod_num,'               s='||s_||', txt='||txt_, 0);
         END IF;
         OPEN OPER1;
         LOOP
            FETCH OPER1 INTO
               tto_,
               vdat_,
               pdat_,
               nd_,
               mfoa_,
               nlsa_,
               nama_,
               mfob_,
               nlsb_,
               namb_,
               nazn_,
               userid_,
               sk_,
               kvs_,
               vob_,
               datd_;
            EXIT WHEN OPER1%NOTFOUND;
            IF deb.debug THEN
               deb.trace(mod_num,'OPER cursor: ref='||ref_||', tto='||tto_, 0);
            END IF;
            sosa_ := NULL;
            kokb_ := NULL;
            IF tt_<>tto_ THEN    -- транзакция не материнская (т.е. дочерняя)?
               IF deb.debug THEN
                  deb.trace(mod_num,'Child transaction'||' dk='||dk_, 0);
               END IF;
               -- половина данных для нее отсутствуют
               pond_    :='';
               filename_:='';
               nazns_   :='';
               bis_     :=null;
               naznk_   :='';
               d_rec_   :='';
               fn_a_    :='';
               rec_     :=null;
               mfob_    :='';
               mfoa_    :='';
               sk_      :=null;
               nazn_    :=txt_;
               BEGIN
                  -- ищем номер счета и его наименование по действительным проводкам
                  SELECT
                     a.nls,
                     substr(a.nms,1,38)
                  INTO
                     k14_,
                     n38_
                  FROM
                     opldok   o,
                     accounts a
                  WHERE
                     rownum < 2                  AND
                     a.kv   = kv_ /* 980 */      AND
                     o.ref  = ref_               AND
                     o.tt   = tt_                AND
                     o.s    = s1_                AND
                     o.acc  = a.acc              AND
                     o.dk   = decode(dk_,1,0,1);
                  EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                     -- не нашли ==> возможно бух. модель откатывали
                     -- ищем среди удаленных проводок
                  BEGIN
                     SELECT
                        a.nls,
                        substr(a.nms,1,38)
                     INTO
                        k14_,
                        n38_
                     FROM
                        opldok_back o,
                        accounts    a
                     WHERE
                        rownum < 2                  AND
                        a.kv   = kv_ /* 980 */      AND
                        o.ref  = ref_               AND
                        o.tt   = tt_                AND
                        o.s    = s1_                AND
                        o.acc  = a.acc              AND
                        o.dk   = decode(dk_,1,0,1);
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        k14_:=null;
                     n38_:=null;
                  END;
               END;
               IF deb.debug THEN
                  deb.trace(mod_num,'n38 = '||n38_ , 0);
               END IF;
            ELSE   -- транзакция материнская
               IF deb.debug THEN
                  deb.trace(mod_num,'Parent transaction'||' dk='||dk_, 0);
               END IF;
               BEGIN
                  SELECT
                     k1.pond,
                     k1.filename,
                     DECODE(dk_,0,k2.kokb,1,k2.koka,NULL)
                  INTO
                     pond_,
                     filename_,
                     kokb_
                  FROM
                     klpond k1,
                     klp    k2
                  WHERE
                     rownum  < 2        AND
                     k1.ref  = ref_     AND
                     k1.pond = k2.pond;
                  --and substr(k2.naex,8,1) || substr(k2.naex,10,3)=maskasab_;
                  IF deb.debug THEN
                     deb.trace(mod_num,'Parent transaction: pond='||pond_||', okpo_b='||kokb_, 0);
                  END IF;
                  EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                     pond_:='';
                  filename_:='';
                  IF deb.debug THEN
                     deb.trace(mod_num,'Fetching "pond" exception, ref='||ref_, 0);
                  END IF;
               END;
               BEGIN
                  SELECT
                     nazns,
                     bis,
                     naznk,
                     d_rec,
                     fn_a,
                     id_a,
                     sos,
                     rec
                  INTO
                     nazns_,
                     bis_,
                     naznk_,
                     d_rec_,
                     fn_a_,
                     id_a_,
                     sosa_,
                     rec_
                  FROM
                     arc_rrp
                  WHERE
                     ref = ref_;
                  EXCEPTION
                     WHEN NO_DATA_FOUND THEN
                     nazns_:='';
                  bis_  :=null;
                  naznk_:='';
                  d_rec_:='';
                  fn_a_ :='';
                  id_a_ :=null;
                  rec_  :=null;
               END;
               IF id_a_ IS NOT NULL THEN
                  kokb_ :=id_a_;
               ELSE
                  kokb_ :=99999;
               END IF;
            END IF;
            IF deb.debug THEN
               deb.trace(mod_num,'okpoa = '|| koka_||', okpob = '||kokb_, 0);
            END IF;
            IF nls_=nlsa_ and kv_=kvs_ THEN
               IF tt_<>tto_ THEN     -- транз. дочерняя
                  IF k14_ is not null THEN
                     nlsb_:=k14_;
                  END IF;
                  IF n38_ is not null THEN
                     namb_:=n38_;
                  END IF;
               END IF;
               IF deb.debug THEN
                  deb.trace(mod_num,'okpoa = '|| koka_||', okpob = '||kokb_, 0);
               END IF;
               IF (kokb_ is null or kokb_=99999) and (mfob_=amfo_ or mfob_ is null) THEN
                  BEGIN
                     SELECT
                        c.okpo
                     INTO
                        kokb_
                     FROM
                        customer c,
                        accounts a,
                        cust_acc cu
                     WHERE
                        a.nls  = nlsb_  AND
                        a.kv   = kv_    AND
                        a.acc  = cu.acc AND
                        cu.rnk = c.rnk;
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        /*kokb_:=kokb_;*/
                        kokb_:=99999;
                  END;
               END IF;
               IF deb.debug THEN
                  deb.trace(mod_num,'okpoa = '|| koka_||', okpob = '||kokb_, 0);
               END IF;
               IF (kokb_ IS NULL OR kokb_=99999) THEN
                  BEGIN
                     SELECT
                        id_b
                     INTO
                        kokb_
                     FROM
                        oper
                     WHERE
                        ref = ref_;
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        kokb_:=99999;
                  END;
               END IF;
               IF deb.debug THEN
                  deb.trace(mod_num,'okpoa = '|| koka_||', okpob = '||kokb_, 0);
               END IF;
               /*
               IF koka_=kokb_ then
                  kokb_:=null;
               END IF;
               */
               IF /*sosa_ is null or sosa_>3*/ TRUE THEN
                  -- получаем наименование банка контрагента
                  BEGIN
                     SELECT
                        nb
                     INTO
                        nb_b_
                     FROM
                        banks
                     WHERE
                        mfo=DECODE(mfob_,NULL,TO_CHAR(f_ourmfo),mfob_);
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        nb_b_ := 'Банк не найден';
                  END;
                  -- вычисляем уникальный номер записи
                  IF tt_=tto_ AND           -- транзакция основная
                     pond_ IS NOT NULL AND  -- для нее есть ELPayID
                     dk_=0                  -- и она(половинка проводки) дебетовая
                     THEN                   -- значит "основная"
                     record_id_ := ref_;    -- оставить REF
                  ELSE
                     record_id_ := ref_ ||'_'||opldok_id_;
                  END IF;
                  IF deb.debug THEN
                     deb.trace(mod_num,'namb(namb_) = '|| namb_, 0);
                     deb.trace(mod_num,'okpoa = '|| koka_||', okpob = '||kokb_, 0);
                     deb.trace(mod_num,'Insert row (1): ref='||ref_||', tt='||tt_, 0);
                  END IF;
                  INSERT INTO tmp_lics_elpay(
                     id,
                     daopl,
                     acc,
                     s,
                     nd,
                     mfob,
                     nazn,
                     isp,
                     nlsa,
                     kv,
                     nama,
                     nlsb,
                     namb,
                     ref,
                     tt,
                     iost,
                     dos,
                     kos,
                     vdat,
                     pdat,
                     sk,
                     dapp,
                     okpoa,
                     okpob,
                     dk,
                     vob,
                     pond,
                     namefilea,
                     kodirowka,
                     nazns,
                     bis,
                     naznk,
                     d_rec,
                     fn_a,
                     rec,
                     datd,
                     nb_a,
                     nb_b,
                     sos,
                     opldok_id,
                     record_id)
                  VALUES(
                     id_,
                     fdat_,
                     acc_,
                     s_,
                     nd_,
                     DECODE(mfob_,NULL,TO_CHAR(f_ourmfo),mfob_),
                     nazn_,
                     isp_,
                     nls_,
                     kv_,
                     nms_,
                     nlsb_,
                     namb_,
                     ref_,
                     tt_,
                     ostf_,
                     dos_,
                     kos_,
                     vdat_,
                     pdat_,
                     sk_,
                     dapp_,
                     koka_,
                     kokb_,
                     dk_,
                     vob_,
                     pond_,
                     filename_,
                     0,
                     nazns_,
                     bis_,
                     naznk_,
                     d_rec_,
                     fn_a_,
                     rec_,
                     datd_,
                     nb_a_,
                     nb_b_,
                     opl_sos_,
                     opldok_id_,
                     record_id_);
               END IF;
            ELSE
               IF tt_<>tto_ THEN
                  IF k14_ is not null THEN
                     nlsa_:=k14_;
                  END IF;
                  IF n38_ is not null THEN
                     nama_:=n38_;
                  END IF;
               END IF;
               IF kokb_ is null and (mfoa_=amfo_ or mfoa_ is null) THEN
                  BEGIN
                     SELECT
                        c.okpo
                     INTO
                        kokb_
                     FROM
                        customer c,
                        accounts a,
                        cust_acc cu
                     WHERE
                        a.nls  = nlsa_  AND
                        a.kv   = kv_    AND
                        a.acc  = cu.acc AND
                        cu.rnk = c.rnk;
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        /*kokb_:=kokb_;*/
                        kokb_:=99999;
                  END;
               END IF;
               /*
               IF koka_=kokb_ THEN
                  kokb_:=null;
               END IF;
               */
               IF /*sosa_ is null or sosa_>3*/ TRUE THEN
                  -- получаем наименование банка контрагента
                  BEGIN
                     SELECT
                        nb
                     INTO
                        nb_b_
                     FROM
                        banks
                     WHERE
                        mfo = mfoa_;
                     EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                        nb_b_ := 'Банк не найден';
                  END;
                  -- вычисляем уникальный номер записи
                  IF tt_=tto_ AND          -- транзакция основная
                     pond_ IS NOT NULL AND -- для нее есть ELPayID
                     dk_=0                 -- и она(половинка проводки) дебетовая
                     THEN                  -- значит "основная"
                     record_id_ := ref_;       -- оставить REF
                  ELSE
                     record_id_ := ref_ ||'_'||opldok_id_;
                  END IF;
                  IF deb.debug THEN
                     deb.trace(mod_num,'namb(nama_) = '|| nama_, 0);
                     deb.trace(mod_num,'okpoa = '|| koka_||', okpob = '||kokb_, 0);
                     deb.trace(mod_num,'Insert row (2): ref='||ref_||', tt='||tt_, 0);
                  END IF;
                  INSERT INTO tmp_lics_elpay(
                     id,
                     daopl,
                     acc,
                     s,
                     nd,
                     mfob,
                     nazn,
                     isp,
                     nlsa,
                     kv,
                     nama,
                     nlsb,
                     namb,
                     ref,
                     tt,
                     iost,
                     dos,
                     kos,
                     vdat,
                     pdat,
                     sk,
                     dapp,
                     okpoa,
                     okpob,
                     dk,
                     vob,
                     pond,
                     namefilea,
                     kodirowka,
                     nazns,
                     bis,
                     naznk,
                     d_rec,
                     fn_a,
                     rec,
                     datd,
                     nb_a,
                     nb_b,
                     sos,
                     opldok_id,
                     record_id)
                  VALUES(
                     id_,
                     fdat_,
                     acc_,
                     s_,
                     nd_,
                     mfoa_,
                     nazn_,
                     isp_,
                     nls_,
                     kv_,
                     nms_,
                     nlsa_,
                     nama_,
                     ref_,
                     tt_,
                     ostf_,
                     dos_,
                     kos_,
                     vdat_,
                     pdat_,
                     sk_,
                     dapp_,
                     koka_,
                     kokb_,
                     dk_,
                     vob_,
                     pond_,
                     filename_,
                     0,
                     nazns_,
                     bis_,
                     naznk_,
                     d_rec_,
                     fn_a_,
                     rec_,
                     datd_,
                     nb_a_,
                     nb_b_,
                     opl_sos_,
                     opldok_id_,
                     record_id_);
               END IF;
            END IF;
         END LOOP;
         CLOSE OPER1;
      END LOOP;
      CLOSE OPLDOK1;
   END LOOP;
   CLOSE SALDOA0;
   EXCEPTION
      WHEN err THEN
      IF deb.debug THEN
         deb.trace(mod_num,'Application error in elpay.p_lic_elpay',ern);
      END IF;
      raise_application_error(-(20000+ern),'\'||erm,TRUE);
      WHEN OTHERS THEN
      IF deb.debug THEN
         deb.trace(mod_num,'General error in elpay.p_lic_elpay',ern);
      END IF;
      raise_application_error(-(20000+ern),SQLERRM,TRUE);
END p_lic_elpay;

-- население временной таблицы сальдо счетов
PROCEDURE make_saldo(
   nSTMT        NUMBER,
   dtStartDate  DATE,
   dtFinishDate DATE) IS
BEGIN
   DELETE
   FROM
      saldo_elpay;
   INSERT INTO saldo_elpay(
      nls,
      kv,
      pap,
      pdat,
      fdat,
      ost_start,
      ost_finish,
      dos,
      kos,
      ost_start_ex,
      ost_finish_ex,
      dos_ex,
      kos_ex,
      red_saldo,
      overdraft)
   SELECT
      a.nls,
      a.kv,
      a.pap,
      s.pdat,
      s.fdat,
      s.ostf                                                      ost_start,
      s.ostf+s.kos-s.dos                                          ost_finish,
      s.dos,
      s.kos,
      gl.p_icurval(a.kv, s.ostf, s.fdat)                          ost_start_ex,
      gl.p_icurval(a.kv, s.ostf+s.kos-s.dos, s.fdat)              ost_finish_ex,
      gl.p_icurval(a.kv, s.dos, s.fdat)                           dos_ex,
      gl.p_icurval(a.kv, s.kos, s.fdat)                           kos_ex,
      DECODE(a.pap,1,DECODE(SIGN(s.ostf+s.kos-s.dos),-1,0,1,1,0),
             2,DECODE(SIGN(s.ostf+s.kos-s.dos),-1,1,1,0,0),0)     red_saldo,
      0                                                           overdraft
   FROM
      accounts a,
      saldoa   s,
      customer c,
      cust_acc c_a,
      acc_clb  a_c,  /* мульти-клиент-банк - порождение сбербанка */
      cust_clb c_l
   WHERE
      c_l.clbid = nSTMT
      and c_l.rnk   = c.rnk
      and c_l.clbid = a_c.clbid
      and a.acc = s.acc
      and a_c.acc = a.acc
      and
      c.rnk       =  c_a.rnk                AND
      c_a.acc     =  a.acc                  AND
      dtStartDate <= s.fdat                 AND
      s.fdat      <= dtFinishDate           AND
      NOT EXISTS (SELECT acc6 FROM v862 WHERE acc6=a.acc)
   UNION ALL
   SELECT
      a.nls,
      a.kv,
      a.pap,
      s.pdat,
      s.fdat,
      s.ostf                                                      ost_start,
      s.ostf+s.kos-s.dos                                          ost_finish,
      s.dos,
      s.kos,
      gl.p_icurval(a.kv, s.ostf, s.fdat)                          ost_start_ex,
      gl.p_icurval(a.kv, s.ostf+s.kos-s.dos, s.fdat)              ost_finish_ex,
      gl.p_icurval(a.kv, s.dos, s.fdat)                           dos_ex,
      gl.p_icurval(a.kv, s.kos, s.fdat)                           kos_ex,
      DECODE(a.pap,1,DECODE(SIGN(s.ostf+s.kos-s.dos),-1,0,1,1,0),
             2,DECODE(SIGN(s.ostf+s.kos-s.dos),-1,1,1,0,0),0)     red_saldo,
      0                                                           overdraft
   FROM
      accounts a,
      saldoa   s,
      customer c,
      cust_acc c_a,
      v862     v,
      saldoa   s8,
      acc_clb  a_c,  /* мульти-клиент-банк */
      cust_clb c_l
   WHERE
      c_l.clbid = nSTMT
      and c_l.rnk   = c.rnk
      and c_l.clbid = a_c.clbid
      and a.acc = s.acc
      and a_c.acc = a.acc
      and
      c.rnk       =  c_a.rnk                AND
      c_a.acc     =  a.acc                  AND
      dtStartDate <= s.fdat                 AND
      s.fdat      <= dtFinishDate           AND
      a.acc       =  v.acc6                 AND
      s8.acc      =  v.acc8                 AND
      (NOT EXISTS (SELECT fdat FROM saldoa WHERE acc=v.acc8 AND fdat<=s.fdat))
   UNION ALL
   SELECT
      a.nls,
      a.kv,
      a.pap,
      s.pdat,
      s.fdat,
      s.ostf                                                      ost_start,
      s.ostf+s.kos-s.dos                                          ost_finish,
      s.dos,
      s.kos,
      gl.p_icurval(a.kv, s.ostf, s.fdat)                          ost_start_ex,
      gl.p_icurval(a.kv, s.ostf+s.kos-s.dos, s.fdat)              ost_finish_ex,
      gl.p_icurval(a.kv, s.dos, s.fdat)                           dos_ex,
      gl.p_icurval(a.kv, s.kos, s.fdat)                           kos_ex,
      DECODE(a.pap,1,DECODE(SIGN(s.ostf+s.kos-s.dos),-1,0,1,1,0),
             2,DECODE(SIGN(s.ostf+s.kos-s.dos),-1,1,1,0,0),0)     red_saldo,
      s8.ostf+s8.kos-s8.dos                                       overdraft
   FROM
      accounts a,
      saldoa   s,
      customer c,
      cust_acc c_a,
      v862     v,
      saldoa   s8,
      acc_clb  a_c,  /* мульти-клиент-банк */
      cust_clb c_l
   WHERE
      c_l.clbid = nSTMT
      and c_l.rnk   = c.rnk
      and c_l.clbid = a_c.clbid
      and a.acc = s.acc
      and a_c.acc = a.acc
      and
      c.rnk       =  c_a.rnk                AND
      c_a.acc     =  a.acc                  AND
      dtStartDate <= s.fdat                 AND
      s.fdat      <= dtFinishDate           AND
      a.acc       =  v.acc6                 AND
      s8.acc      =  v.acc8                 AND
      (s8.fdat=(SELECT max(fdat) FROM saldoa WHERE acc=v.acc8 AND fdat<=s.fdat));

END make_saldo;

END elpay;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/elpay.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 