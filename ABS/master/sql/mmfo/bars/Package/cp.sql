
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cp.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
CREATE OR REPLACE PACKAGE CP IS

   -------------------------------------------------------
   --
   --  НБУ. Работа с ценными бумагами
   --
   -------------------------------------------------------

   G_HEADER_VERSION    constant varchar2(64) := 'v.1.14.6  16.02.2018';
                                              

   CP_PAY_   char(1):='0'; --1) 0=Конс-сист., Угоди-несист, 1=Конс-несист., Угоди-сист
   CP_AMORT_ char(1):='0'; --2) 0=ТП Амотр всегда, 1=ТП не аморт
                           --3) Переоцiнка
   CP_RT_    char(1):='0'; --3.1) 0=Сумма переоц не вкл в торг.рез., 1= вкл
   CP_CUR_   char(1):='0'; --3.2) 0=Переоц через разницу, 1= с полным откатом
   CP_RATES_ char(1):='0'; --3.3) 0=по чистiй цiнi, 1=грязнi цiнi
   CP_R_KUP_ char(1):='0'; --3.3.1) 0=купон за gl.BDATE, 1=купон за DAT_

   CP_R_R2_  char(1):='0'; -- '0'  Забрать все из начисленного (по умолчанию)
                           -- '1'  Забрать из начисленного в уд.весе

   CP_nls8_  varchar2(15):=VKRZN(substr(gl.aMFO,1,5), '89980');
             --сч 8.кл для учета номинала акций (недолговые ЦБ)
   NBUBNK_   varchar2(1);  -- ознака НБУ/КБ


   FXB_ char(3) DEFAULT 'FXB'; --для оп FXB из PARAMS
   FXZ_ char(3) DEFAULT 'FXZ'; --резерв по ЦП
   T1_ varchar2(20); -- код ЦП
   T2_ int;          -- ном 1 шт
   T3_ int;          -- колво
   T4_ varchar2(70); -- емитент
   IO_ int;

   sNOMINAL  VARCHAR(70);      -- для OPLDOK.txt
   sNOMINAL_EXP  VARCHAR(70);
   sDISKONT  VARCHAR(70);
   sPREMIA   VARCHAR(70);
   sKUPON    VARCHAR(70);
   sKUPON2   VARCHAR(70);
   sKUPON3   VARCHAR(70);
   sKUPONo   VARCHAR(70);
   sKUPON9   VARCHAR(70);
   sZABORK   VARCHAR(70);
   sZABORD   VARCHAR(70);
   sPEREOP   VARCHAR(70);
   sPEREOV   VARCHAR(70);
   sTORGP    VARCHAR(70);
   sTORGV    VARCHAR(70);
   sKOMIS    VARCHAR(70);
   sKOMISA   VARCHAR(70);
   sKOMISN   VARCHAR(70);
   sKOMISK   VARCHAR(70);
   sKOMISD   VARCHAR(70);
   sAMORT    VARCHAR(70);
   sSOBIVN   VARCHAR(70);
   sVNEB1    VARCHAR(70);
   sVNEB2    VARCHAR(70);
   sVNEB3    VARCHAR(70);
   sVNEB4    VARCHAR(70);
   tip_cp    int;
   DP_slovo varchar2(10);
   l_exist_mon number :=0;
   l_exist_mon_user  NUMBER  := 0;
   l_user int;
   l_mon int :=0;   -- наявн_сть пакета  MONITOR_USER
   l_mdl varchar2(5); -- код модуля
   l_reg int; l_trace varchar2(50);
   l_lev varchar2(10); l_vkl int;

   ern  CONSTANT POSITIVE := 021;
   erm  VARCHAR2(80);
   err  EXCEPTION;

   -----------------------------------------------------------------
   -- HEADER_VERSION()
   --
   --     Функция возвращает строку с версией заголовка пакета
   --
   --
   --
   function header_version return varchar2;


   -----------------------------------------------------------------
   -- BODY_VERSION()
   --
   --     Функция возвращает строку с версией тела пакета
   --
   --
   --

   function body_version return varchar2;

procedure CP_POG_NOM2 (p_Z int, p_Id number, p_NOM100 number) ;   -- 02.08.2017 Sta частичное (или полное) погашения номинала

----------------------------------------------------------------------
PROCEDURE cp_set_tag
         (p_ref   IN number,            -- реф-с пакета
          p_tag   IN cp_tag.tag%TYPE,   -- TAG додпар-ра
          p_value IN varchar2,          -- значення
          p_type  in number);             -- тип

----------------------------------------------------------------------
PROCEDURE diu_many
(p_mode int,
 p_ref  cp_many.REF%type,
 p_fdat cp_many.fdat%type,
 p_SS1  cp_many.SS1%type,
 p_SDP  cp_many.SDP%type,
 p_SN2  cp_many.SN2%type
);

---
PROCEDURE PAY_FORW(p_DAT date);
--   nam_ operlist.NAME%type    := 'Оплата форвардних продаж ЦП';
-----------------------------------------------------------------------
-- Досрочное частичное погашение номинала
PROCEDURE CP_DEL_NOM
 (p_ID cp_dat.ID%type, -- ID ЦБ
  p_DOK cp_dat.dok%type -- Дата досроч.пог.
 );
----------------------------------------------------------------------
-- MODI_CENA
-- Ежедневное обновление (вернее, на дату P_DAT)
-- справочника    CP_KOD.CENA  - Поточна Номiнальна вартiсть ЦП
-- по справочнику CP_DAT.nom   - Графiки погашення купону та НОМIНАЛУ
-- Рекомедовано выполнять на старте дня P_DAT

  procedure MODI_CENA (p_dat date);

   -----------------------------------------------------------------
   --    INSERT_PAYDATE()
   --
   --    Встаивть информацию по дате оплаты по ценной бумагe ( Оплата по типу: купон или номинал)
   --
   --    p_cpid -  Идентификатор ценной бумаги
   --    p_date -  Дата оплаты
   --    p_sum  -  сумма купона (номинала)
   --    p_npp  -  Номер выплаты по-порядку
   --    p_type -  тип - купон
   --
   procedure insert_paydate(p_cpid varchar2,
                            p_date date,
							p_sum  number,
							p_npp  number,
							p_type number);

  -----------------------------------------------------------------
   --    INSERT_CUPON_PAYDATE()
   --
   --    Встаивть информацию по дате оплаты купона по ценной бумаге
   --
   --    p_cpid -  Идентификатор ценной бумаги
   --    p_date -  Дата оплаты
   --    p_sum  -  сумма купона
   --    p_npp  -  Номер выплаты по-порядку
   --
  procedure insert_cupon_paydate(p_cpid varchar2, p_date date, p_sum number, p_npp number);

  procedure update_cupon_info(p_dummy date);

  procedure insert_cp_kod(p_emi     number,     -- вид эмитента
                          p_dox     number,     -- вид прибыльности
                          p_cpid    varchar2,   -- код ценной бумаги    PK
                          p_kv      number,     -- валюта эмиссии
                          p_name    varchar2,   -- название эмитента
                          p_country number,     -- страна эмитент
                          p_datem   date,       -- дата выпуска         PK
                          p_ir      number,     -- % купона
                          p_datp    date,       -- дата погашения
                          p_cena    number,     -- номинал 1-ой ценной бумаги
                          p_tip     number,     -- тип ценной бумаги
                          p_amort   number,     -- 1-аморт.стоимость,0-наст. стоимость
                          p_dcp     number,     -- 1-есть в депозитарии,0-нет
                          p_basey   number,     -- % база, возможные значения: 0 - Факт/Факт, 1 - 365/Факт, 2 - 360/30, 3 - 360/Факт
                          p_cenacup number,     -- цена купона 1 ЦБ (в целых с коп 10.55)
                          p_io      number);    -- -- Нарахування %% на залишок. Можливi значення (0/1/null)

   -----------

FUNCTION KUPON1
( p_ID   IN cp_kod.ID%type , -- Ид ЦБ
  P_dat  IN DATE           , -- дата,
                             -- на какую расчитать купон по графуку куп.пл.
                             -- если сделка планируется в эту дату
  p_DATE IN cp_kod.DAT_EM%type  DEFAULT null,
  p_DATP IN cp_kod.DATP%type    DEFAULT null,
  p_PR1  IN cp_kod.PR1_KUP%type DEFAULT null
 )
 RETURN NUMBER ;


FUNCTION GEO_RATE_Y
 ( NOM_  in NUMBER,  -- Номинал
   ID_   in int   ,  -- Ид ЦБ
   Y_    in NUMBER,  -- собственно коеф
   dat_  in DATE  ,  -- дата, на какую расчитать денежную стоимость
   MODE_ in int      -- 0 = расчитать накопл.купон
                     -- 1 = расчитать чистую  стоимость
                     -- 2 = расчитать грязную стоимость  ( 2 = 0 + 1)
  ) RETURN NUMBER;
-------------------
FUNCTION F_VDAT_ZO ( DAT_ date) return date ;
--Получение последней раб даты в пред.месяце
-------------------
FUNCTION UFORMULA01 (
	VALUE_ 		  IN	   NUMBER,	  -- Номинал
	TYPE_		  IN	   VARCHAR2,  -- Тип
	DATEP_		  IN	   DATE,	  -- Дата погашения
	DATEC_		  IN	   DATE,	  -- Дата текущая
	BASEY_		  IN	   NUMBER,	  -- Код базового года
	K_			  IN	   NUMBER	  -- %% коефициент
) RETURN NUMBER;
---------------
FUNCTION UFORMULA_D2Y (
	K_			  IN	   NUMBER,	  -- %% коефициент
	DATEP_		  IN	   DATE,	  -- Дата погашения
	DATEC_		  IN	   DATE,	  -- Дата текущая
	BASEY_		  IN	   NUMBER 	  -- Код базового года

        ) RETURN NUMBER;

------------------------------------------------------------------------------
FUNCTION UFORMULA_Y2D (
	K_			  IN	   NUMBER,	  -- %% коефициент
	DATEP_		  IN	   DATE,	  -- Дата погашения
	DATEC_		  IN	   DATE,	  -- Дата текущая
	BASEY_		  IN	   NUMBER 	  -- Код базового года

        ) RETURN NUMBER;

------------------------------------------------------------------------------
-- PROCEDURE CP_FORV_KUP()
-- Пересмотр форв.купона по ЦБ
------------------------------------------------------------------------------
PROCEDURE CP_FORV_KUP (nId_ IN INT);


------------------------------------------------------------------------------
-- PROCEDURE RMany_dat()
-- НАПОЛНЕНИЕ очереди для модификации потоков
------------------------------------------------------------------------------
PROCEDURE RMany_dat (REF1_   IN cp_deal.ref%type,
                     REF2_   IN cp_deal.ref%type,
                     VDAT_   IN DATE,
                     N_      IN NUMBER,
                     R_      IN NUMBER);


PROCEDURE RMany
(p_REF1 number,
 p_REF2 number,
 p_VDAT date,
 p_N number ,
 p_R number ,
 p_out out varchar2);
-- 21/05-13     пар-ри p_ref1, p_ref2
-- 21/11-11     пар-р p_out
-- 28-01-10 Sta Анулирование старых ден.потоков  и
--              Построение новых при частичной продаже/перемещении пакета ЦБ.
-- 08/08-17 Diver враховує якщо за один день декілька угод продажу по тій же угоді купівлі

PROCEDURE RMany_all  (DAT_ date) ;
-- модификация потоков всех сделок из очереди. Очистка очереди.

PROCEDURE DOK_DNK (DAT_ date);
PROCEDURE Cp_DEL(REF_ int);
PROCEDURE Cp_Nomin(ACC_ int);
----------------
PROCEDURE Cp_reg_ex (mod_    IN     INTEGER,
                     p1_     IN     INTEGER,
                     p2_     IN     INTEGER,
                     p3_     IN     INTEGER,
                     p4_     IN OUT INTEGER,
                     rnk_    IN     INTEGER,
                     nls_    IN OUT VARCHAR2,
                     kv_     IN     SMALLINT,
                     nms_    IN     VARCHAR2,
                     tip_    IN     CHAR,
                     isp_    IN     SMALLINT,
                     accR_      OUT INTEGER);

------------------------
PROCEDURE CP_BASEY (ACC_ number, DAT_ date);
--переустановка базового года
-----------------

PROCEDURE CP_REE2 (CP_ID_ varchar2, sErr OUT varchar2);
-- синхронизация пл.инструкций депозитария
-----------------
PROCEDURE FXB(KV_     IN  cur_rates.kv%type,
              TIPD_   IN  cp_kod.tip%type);
-- определение глобальных переменных пакеджа
-----------------
PROCEDURE F_REF(ref_ int, sREF1 varchar2, sREF2 OUT varchar2);
-- цепочка ref
--------------------------------------------------
-- процедура разноски уплаченного купона
PROCEDURE CP_KUPON
 ( TIPD_  int,
   VOB_   int,
   GRP_   int,
   nID_   int,
   nRYN_  int,
   nVIDD_ int,
   SUMK   number,
   SK_  out number,
   B_4621 varchar2,
   sREF OUT varchar2,
   sErr OUT varchar2,
   REF_MAIN OUT int );

   -- процедура перемещения между портфелями
PROCEDURE CP_MOVE
 ( GRP_     int, VOB_ int,
   nID_     int,
   nRYN1_   int,
   nNBS1_   int,
   nRYN2_   int,
   nNBS2_   int,
   SUMN     number,
   nREF_    int,
   NAZN_    varchar2,
   B_4621   varchar2,
   sREF OUT varchar2,
   sErr OUT varchar2,
   REF_MAIN OUT int );


------------------------------------------------------------------------
 /*PROCEDURE CP_PROD*/
  -- продажи ранее купленных чужих (TIP=1)
  -- отправка эмитенту (погашение эмитентом TIP=1)
  -- процедура первичной продажи своих (TIP=2)
------------------------------------------------------------------------
PROCEDURE CP_PROD (TIPD_       IN     cp_kod.tip%type,      -- 1 акт (чужие), 2 пас (свои)
                   VOB_        IN     oper.vob%type,        -- вид банковского документа
                   GRP_        IN     INT,                  -- группа доступа по счетам
                   nID_        IN     cp_kod.id%type,       -- код ЦБ
                   nNBS_       IN     cp_accc.vidd%type,    -- БАЛ счет
                   nRYN_       IN     cp_accc.ryn%type,     -- субпортфель
                   DAT_UG      IN     DATE,                 -- дата сделки
                   DAT_OPL     IN     DATE,                 -- дата поставки
                   DAT_ROZ     IN     DATE,                 -- дата расчетов
                   DAT_KOM     IN     DATE,                 -- дата опл комис
                   SUMBN       IN     NUMBER,               -- сумма номинала (в грн)
                   SUMB        IN     NUMBER,               -- сумма сделки
                   SUMBK       IN     NUMBER,               -- сумма комиссии
                   RR_         IN     NUMBER,               -- сумма заявленного купона
                   NAZN_       IN     oper.nazn%type,       -- назначение платежа
                   NLS9        IN     accounts.nls%type,    -- счет резерва
                   REF_REPO_   IN     VARCHAR2,             -- реф сделки покупки для РЕПО , или null
                   sFREE       IN     VARCHAR2,             -- резерв -- нигде не используется?
                   B_4621      IN     accounts.nls%type,    -- счет транзита
                   B_1819      IN     accounts.nls%type,    -- форвард-номинал с 1819 на 4621 (дата поставки < дата расчетов)
                   B_1919      IN     accounts.nls%type,    -- форвард-номинал с 1919 на 4621 (дата поставки < дата расчетов)
                   sREF           OUT cp_arch.str_ref%type, -- список референсов сделки
                   sErr           OUT VARCHAR2,             -- сообщение об ошибке
                   REF_MAIN    IN OUT INT);                 -- референс основной сделки

-- процедура амортизации
PROCEDURE CP_AMOR
( ref1_ INT,
  ID_   int,
  GRP_  int,
  aDAT_ date,
  sErr OUT varchar2 );

-- процедура покупки чужих или выкупа (погашения) своих
PROCEDURE CP_KUP (p_CP_AI    IN     VARCHAR2,   -- '1'= регулювання лiквiдностi,  '0' = з акцiонерами
                  TIPD_      IN     INT,
                  VOB_       IN     INT,
                  GRP_       IN     INT,
                  nID_       IN     INT,
                  nNBS_      IN     INT,
                  nRYN_      IN     INT,
                  DAT_UG     IN     DATE,
                  DAT_OPL    IN     DATE,
                  DAT_ROZ    IN     DATE,
                  DAT_KOM    IN     DATE,
                  SUMBN      IN     NUMBER,     -- номинал
                  SUMB       IN     NUMBER,     -- вартисть пакета (в грн. НЕ в коп)
                  RR_        IN     NUMBER,     -- для акций =% от капитала, для долговых=накоп.купон
                  SUMBK      IN     NUMBER,     -- сумма комиссии
                  NAZN_      IN     VARCHAR2,
                  NLS9       IN     VARCHAR2,
                  rNls_         OUT VARCHAR2,   -- счет, по которому сделана комиссия
                  B_4621     IN     VARCHAR2,
                  B_1819     IN     VARCHAR2,
                  B_1919     IN     VARCHAR2,
                  sREF          OUT VARCHAR2,
                  sErr          OUT VARCHAR2,
                  REF_MAIN      OUT INT);

-- процедура переоценки
PROCEDURE CP_cur (REF1_   IN     cp_deal.ref%type,
                  ID_     IN     cp_kod.id%type,        -- идентификатор ЦБ в системе cp_kod.id
                  GRP_    IN     INT,
                  PF_     IN     INT,
                  DAT_    IN     DATE,
                  s6300   IN     accounts.nls%type,     -- номер счета 6300 "Дох_д у вигляд_ дивiдендiв"
                  s4621   IN     accounts.nls%type,     -- номер транзитного счета в валюте ЦБ
                  sErr       OUT VARCHAR2);             -- флаг ошибки
------------------------------------------------------------------------
-- процедура внебаланса
PROCEDURE CP_vneb (DK_       IN     oper.dk%type,
                   KV_       IN     accounts.kv%type,
                   nNBS_     IN     cp_vidd.vidd%type,
                   nRYN_     IN     cp_accc.ryn%type,
                   EMI_      IN     cp_vidd.emi%type,
                   p_SN_     IN     NUMBER,            -- номинал сделки в коп
                   p_SA_     IN     NUMBER,            -- сумма  сделки  в коп
                   CP_ID_    IN     cp_kod.cp_id%type,
                   DAT_UG    IN     DATE,
                   DAT_OPL   IN     DATE,
                   DAT_ROZ   IN     DATE,
                   DAT_KOM   IN     DATE,
                   NAZN_     IN     oper.nazn%type,
                   REF_      IN     oper.ref%type,
                   NLS9      IN     accounts.nls%type, -- счет резерва
                   sREF      IN OUT VARCHAR2,
                   sErr         OUT VARCHAR2);
------------------------------------------------------------------------
-- формирование резерва
procedure rez_pay
(dat_ date         -- дата расчета резерва
);

--------------------------
function chek_rekv(p_ID IN cp_kod.ID%type, p_mod IN int default 1)
   return varchar2;
--------------------------
procedure chek_dubl_cp_id(p_dat date);
------------------------
procedure LOG(p_info char, p_lev char default 'TRACE', p_reg int default 0);
------------------------
--FUNCTION f_exist_mon_user (p_user int)
--      RETURN NUMBER;
-----------------------------------------------------------------------
-- Функция возвращает дату реального изменения остатка при начислении.
-- Параметр p_dat - дата "Начислено по" (int_accn.acr_dat)
-----------------------------------------------------------------------
FUNCTION cp_real_intdate (p_acc NUMBER, p_dat DATE, p_TIPD INT)
   RETURN NUMBER;
----------------------------------
PROCEDURE awry_period (p_id       IN     cp_kod.id%TYPE,
                       p_npp         OUT cp_dat.npp%TYPE,   -- номер текущего купонного периода
                       p_normal      OUT INT,               -- количество дней в НОРМАЛЬНОМ купонном периоде
                       p_awry        OUT INT,               -- признак наличия укороченного купонного периода
                       p_awry_first  OUT INT,               -- количество дней в укороченном первом купонном периоде
                       p_awry_last   OUT INT);              -- количество дней в укороченном последнем купонном периоде

-- Сумирует общее количество Ценных бумаг по Контрагентам в рамках Пакета (Функа ЦП (14) )
  function get_from_cp_zal_kolz(p_ref number, p_dat date) return number;
  function get_from_cp_zal_dat(p_ref number, p_dat date) return date;

  --Процедура на БМД ЦП (14) - редагування заставної інформації в розрізі контрагентів
  procedure cp_zal_change(p_ref          cp_zal.ref%type,
                          p_rnk          cp_zal.rnk%type,
                          p_id_cp_zal    cp_zal.id_cp_zal%type,
                          p_id           cp_zal.id%type,
                          p_kol_zal      cp_zal.kolz%type,
                          p_zal_from     cp_zal.datz_from%type,
                          p_zal_to       cp_zal.datz_to%type,
                          p_mode         int); --для функи ЦП (14)
                          
  procedure cp_inherit_specparam(p_acc   IN number,
                                 p_accc  IN int,               -- рах-ку консол-ї
                                 p_mode  in number default 0); -- резерв                          

END CP;
/
CREATE OR REPLACE PACKAGE body CP IS
----------------------------------------------------------------------
--
--  Пакет пр-р CP. Работа с цінними паперами
--  Версія для КБ пізніше 05/2016
----------------------------------------------------------------------
    G_BODY_VERSION      constant varchar2(64) := 'v.2.91.0  13/06/2018';
    G_TRACE             constant varchar2(20) := 'cp.';  -- 'v.2.90.4'
    G_MODULE            constant varchar2(20) := 'CPN';
    G_PAY_CUPON         constant number(1):= 1;
    G_PAY_NOMINAL       constant number(1):= 2;
----------------------------------------------------------------------
    kk                  cp_kod%rowtype;
    RI_CPACCC           cp_accc%rowtype;
    NLS_                varchar2(20);
    s8_                 varchar2(9);
    l_MFOP              varchar2(9) := Nvl(GetGlobalOption('MFOP'),'0');
    l_MFOU              varchar2(9);
    l_cp_mvrat          varchar(1);
    l_CP_TRANS_DK       varchar(1);
    l_CP_METOD          varchar(1);
----------------------------------------------------------------------
    type t_cp_warrantyrec is record (REF_    cp_deal.ref%type,
                                     PAWN    CC_PAWN.pawn%type,
                                     NLS     accounts.nls%type,
                                     KV      accounts.kv%type,
                                     acc     cc_accp.acc%type,
                                     accs    cc_accp.accs%type,
                                     S       oper.s%type,
                                     IDZ     pawn_acc.idz%type,
                                     CC_IDZ  pawn_acc.cc_idz%type,
                                     SDATZ   DATE,
                                     RNK     customer.rnk%type,
                                     CP_WAR  varchar2(200),
                                     ob22    accounts.ob22%type);
    l_cp_warrantyrec        t_cp_warrantyrec;
    type t_cp_warrantyset   is table of t_cp_warrantyrec;
    l_cp_warrantyset        t_cp_warrantyset;
----------------------------------------------------------------------
/*****
 02/08-17 Sta добавлена процедура частичного (или полного) погашения номинала procedure CP_POG_NOM2
 20/04-17 Спецпар-ри рах-в в момент відкриття
 20/04-16 Modified CP_MOVE, CP_MANY_ALL
 22/02-16 Заповнення додпар-ра. Пр-ра CP_SET_TAG
 25/12    CP_PROD Відновив логіку для datpm.
 22/12    CP_KUP. Ринк. курс - розгалуження алгоритму по NBUBNK_
          Для КБ - бухмодель для акціонерів теж згортання на реальний Д/П.
 09/12    добавлена обработка кривого купона в cp_kup (при покупке), cp_kupon (при погашении)
 09/12    процедура определения кривого купона (длительность укороченного периода) awry_period
 04/12    Появление cp_accounts, cp_payments для связки открываемых счетов к сделкам и проводок к сделкам
  2/11    CP_MOVE Новi складовi пакета: accexpN, accexpR
 29/10    CP_MOVE  Враховано вимоги Заявки CNBUSUP-101
 30/07    Пр-ра DOK_DNK уточнення щодо OSTF (залишив т?льки для metr=4)
 30/06    cp_prod в процедуру добавлен пересмотр гарантии от третьих лиц на пакет
 22/06    F_KUPON1  Exception щодо відсутності графіка сплати купонів
 17/06-15 Исправлена cp_real_intdate как разница остатка на счете купона - сумма новых начислений
 10/06-15 Добавлена функция  cp_real_intdate  Функция возвращает дату реального изменения остатка при начислении.
      Параметр p_dat - дата "Начислено по" (int_accn.acr_dat)
  9/06    Уточнено вичитку по PROC_DR + деталі проводки для переоцінки
 22/05    CP_MOVE вставка cp.RMany_DAT(REF_,ref_,VDAT_,SN_,0) після запису в CP_DEAL
          DAT_BAY for OP=3
 21/05    Замість l_mfop беремо l_mfou
 19/05    Уточнено ISIN в формулу назви рахунків залежно від МФО
          RMANY Аналіз l_fl=3 - наслідування еф. ставки
          аналіз l_mfop
 12/05    KDI CP_MOVE уточнено щодо metr=4
 27/03-15 inga исправлена процедура DOK_DNK (R + R2) и возможность смены купонного периода при непогашенном (R + R2)
 25/03-15 inga внесено явное проставление acr_dat в проц. карточку при открытии счетов в процедуре
          cp_kup, cp_move,cp_prod
 17/03-15 повторно metr=4 можливе тільки для МФО 300465
          аналіз  NBUBNK_ = 1  щодо NLSS5, NLSS6
 25/02-15 Нові реквізити в CP_DEAL для сумісності версій
          active, initial_ref, dat_bay
          RMANY_ALL: CP_DEAL.active  0 -> 1 для op in (1,3)
          CP_MOVE  initial_ref
 17/10-14 Влючено фрагмент 08.10.14 Сухова.
          Торговый рез от продажи - это сальдо торгового счета B_4621 для этой сделки.
 26/09-14 KDI Аналіз ситуації коли DATP=holiday для продажу/погашеня ЦП
  6/08-14 KDI ОВДП - нарах-ня завжди з PROC_DR.io (без аналізу CP_KOD.io)
  3/06-14 KDI актуальність kk.rnk=RNK1_  для глобальної та локальної стр-ри kk,
              metr=4 можливе тільки для МФО 300465
 28/05-14     Повернуто фрагмент врегулювання суми купона при продажу
 14/05-14 KDI Фіксація проводок продажу в журнал моніторингу по пр-рі LOG
 13/05-14 KDI Відновлено операцію FX8 -> FXP, де потрібно.
              Зроблено НЕзалежний аналіз accs, accs6, accs5
 12/05-14 KDI Ще раз заповнення ТР в архів + уточнено деталі деяких проводок
 12/05-14 Sta Коефф по реф продажи и сч номинала
              + вычитка переоценки для ТР
 22/04-14 KDI Включено зміни в пр-ру CP.insert_cp_kod  від Лут А.
 07.04-14 STA Пр-ра PAY_FORW
              Перевод IO с PROC_DR -> cp_kod     nvl( cp_kod.io, NVL(PROC_DR.io,0) )
              В архив - екв торг рез
  3/04-14 STA CP_PROD знову пропорції часткових продаж з CP_FORW
  2/04-14 KDI CP_PROD kk:=cpk; kk - задіяна в FXB
 11/01-14 KDI CP_PROD Уточнення dk_ для списання з k.accs6
 11/12-13 KDI UPDATE_CUPON_INFO Уточнення  and nvl(dok,to_date('01.01.2000',.... ) !=
              Проявлялась проблемка для 1-го куп. періода
 06.12.13     CP_PROD пропорции
 02.12.13 Sta PUL.Set_Mas_Ini( 'CP_REF', sRef, 'Реф.поточної угоди ЦП' )
 25-29/13 правка CP_prod, CP_KUP
 22.11.13 Sta PROCEDURE diu_many
 19.11.13 Sta 5121-6300 при перемещении с учетом замечаний от Ларисы
             Переоценка и Форвард-продажи.
          1. Делать переоценку только форвард-остатка. PROCEDURE CP_cur.
          2. При форвард-продаже генерировать форвард-проводку по номиналу и ПЕРЕОЦЕНКЕ !
          3. Исключить возмозность изменения номинала при наступлении даты валютирования.
             Рассматривать такую добавку,  как новую самостоятельную сделку.

 14-11-13 Sta CP_PROD  cp_kod.io = 'Нарах.% по вх/вих залишку' - тільки для ЦП власної емісії
          KDI пр-ра Insert_cp_kod  basey=0 для ДС при прийомі з ДЦП
 13-11.13 Sta CP_Move (От Ларисы Д)
 12.11.12 Sta Замість зафіксованих в коді портфелів (4,6,7) аналізувати ознаку вказану в полі CP_PF.no_a = 1
 30.10.13 Sta Коды операций в архиве сделок  cp_arch.op =
              1 - покупка чужих ЦБ
             -2 - продажа чужой ЦБ в будущем
              2 - Продажа чужих ЦБ (с заменой -2 на 2)
              3 - перемещение в портфелях чужих ЦБ
              4 - купон-погашение по чужим ЦБ

              2 - Продажа своих ЦБ
              4 - купон-выплата по своим ЦБ
             20 -  Выкупить(т.е. только погасть) свои Б

 15/10-13 KDI CP_PROD Списання залишків НР 6300, навіть якщо зал-к на 1305 = 0
 10.10.13 Sta Построение потоков PROCEDURE RMany/ Вызов из библиотеки
 29/07-13 KDI Оптимізація update_cupon_info. Прибрав зайві оновлення    щоб НЕ засмічувати CP_KOD_UPDATE.
  4/06-13 KDI Дод-й контроль конс-х рах-в при умові формування VD/VP
          STA Фіксація залишку по рах-ку accs6 в МОМЕНТ вводу Форвард-продажу
 31/05-13 KDI CP_PROD Згорт-ня екв-та пер-ки з доч. рах-ку 6 класу - на зал-к по DAT_UG
 30.05.13 STA УЧЕТ FORWARD-ПРОДАЖА ЭКВ ПЕРЕОЦЕНКИ
          KDI Дата курсу для екв-та амортизації VD/VP   та згортання VD/VP при продажу.
              зміни від Лут А. щодо прийому даних з ДЦП
 24.05.13 Sta Вирт дисконт-проем - экв пр начальному курсу
 23/05-13 STA Продаж частини пакету ЦП. Еф. ставку - НЕ перераховуємо
              В архів фіксуємо торг. рез-т по угоді продажу.
 16/05-13 STA Пропорция для переоценки НЕ-проданной части пакета ЦБ по сделке с ФОРВАРД-продажей
 14.05.13 Sta комиссия посреднику - в валюте ЦБ. Транзитний рах-к для проводки по сумі комісії  4621/2746
 08.05.13 Sta Форвард-продажа. Счет переоц брать не тек ост, ост на дату заключения сделки
          KDI Уточнено рах-к для комісії nls_ -> l_nls_dp
              Для угод по ДС в архіві повернув op=2 (викуп/погашення)
 29.04.13 Sta Переоценку делаем от остатков текущего дня ( в т.ч. будет Защита от повторной переоценки)
 18.04.13 Sta
   1. При переоценке, не учитывать частичную сумму по сделке, которая заложена в будущем на продажу.
   2. Заложить в ПО параметр, который будет давать возможность, для сделок, которые участвуют в форвардных продажах, выбора переоценивать их или нет.
   3. Во время оплаты в день валютирования сделок по форвардным продажам, списывать сумму со счетов переоценки актива и доходов, в процентном соотношении суммы которые были на момент ввода операции, а не на дату валютирования. Между датой операции и датой валютирования на эти счета будут зачислены суммы переоценки на остаток, который остается после продажи.

 16/04-13 STA Розгортання Вал-х VD/VP при купівлі через рах-ки 5120/6499...
 11/04-13 KDI Згортання Вал-х VD/VP при продажу через оп. FXF.
              Уточнення коду операції для ВАЛ-х ОВДП (не ОЗДП)
 29.03.13 Sta Для угод по ДС в архіві записи продажу та погашення показані як продаж (op=20, ,было 2)

 18-03-13 STA Внесистемный счет по 5 и 6-му классу открывать датой ввода сделки, а не датой оплаты сделки.

 15/03-13 KDI Різні доповнення для КБ реалізовані в УПБ
  9/01-13 KDI Вал. 980 для дочірніх рах-в 5121 6300
  9/01-13 KDI Окремий транз. рах-к для погашення купону (глоб.пар-р)
          Для реестра ЦП - переходимо FOREX_ALIEN -> CP_ALIEN
  5/01-13 KDI Торг. рез-т для купону R2 < 0  (уточнення по SR_)
 04.01.13 STA Продажа ЦБ по постановке от Ларисы
          Переміщення Переоцінки на переоцінку завжди для МФО 300465   4/09-12
  1/01-13 KDI Уточнення при продажу R2 < 0
 Ниже - см в СС

********/

-----------------------------------------------------------------
-- HEADER_VERSION()
--
--     Функция возвращает строку с версией заголовка пакета
--
--
--
function header_version return varchar2
is
begin
   return 'package header CP: ' || G_HEADER_VERSION;
end header_version;


-----------------------------------------------------------------
-- BODY_VERSION()
--
--     Функция возвращает строку с версией тела пакета
--
--
--
function body_version return varchar2
is
begin
   return 'package body CP: ' || G_BODY_VERSION || chr(10);
end body_version;


----------------------------------------------------------------------
PROCEDURE cp_inherit_specparam
         (p_acc   IN number,            --
          p_accc  IN int,               -- рах-ку консол-ї
        --  p_tag   IN sparam_list.tag%TYPE,   -- TAG спецпар-ра
          p_mode  in number default 0)       -- резерв
IS
l_tag   sparam_list.name%TYPE;
l_ob22  sb_ob22.ob22%type;
l_val   varchar2(10);
BEGIN

 for k in (select 'R011' tag from dual union all select 'R012' from dual
           union all select 'R013' from dual union all select 'R016' from dual
           union all select 'S080' from dual union all select 'S130' from dual
           union all select 'S180' from dual union all select 'S580' from dual
           union all select 'OB22' from dual
          )
 loop

    begin

  if k.tag='OB22' then
     select F_GET_OB22(kv,nls) into l_ob22 from accounts where acc=p_accc;
     Accreg.setAccountSParam( p_acc, k.tag, l_ob22);
  else
     l_val:= F_GET_SPECPARAM(k.tag,'',p_accc,gl.bd);
     Accreg.setAccountSParam( p_acc, k.tag, l_val);
  end if;

    end;

 end loop;

end;


----------------------------------------------------------------------
PROCEDURE cp_set_tag
         (p_ref   IN number,            -- реф-с пакета
          p_tag   IN cp_tag.tag%TYPE,   -- TAG додпар-ра
          p_value IN varchar2,          -- значення
          p_type  in number)            -- тип
IS
BEGIN
    if p_type = 1 then
       begin
       insert into cp_emiw (rnk,tag,value) values (p_ref,p_tag,p_value);
       exception when dup_val_on_index then null;
       update cp_emiw set value=p_value where rnk=p_ref and tag=p_tag and value is null;
       end;
    elsif p_type = 2 then
       begin
       insert into cp_kodw (id,tag,value) values (p_ref,p_tag,p_value);
       exception when dup_val_on_index then null;
       update cp_kodw set value=p_value where id=p_ref and tag=p_tag and value is null;
       end;
    elsif p_type = 3 then
       begin
       insert into cp_refw (ref,tag,value) values (p_ref,p_tag,p_value);
       exception when dup_val_on_index then null;
       update cp_refw set value=p_value where ref=p_ref and tag=p_tag and value is null;
       end;
    end if;
end;

----------------------------------------------------------------------
PROCEDURE move_potok (p_ref1   IN cp_many.REF%TYPE, -- сделка, потоки которой переносятся
                      p_ref2   IN cp_many.REF%TYPE, -- сделка, потоки в которую переносятся
                      p_datm   IN DATE)             -- дата переноса сделки из пакета в пакет
IS
BEGIN

  logger.trace('CP.MOVE_POTOK: '|| 'Start with params: '
                        ||p_ref1 || ', ' || p_ref2 || ', ' ||p_datm);

   BEGIN
      INSERT INTO CP_MANY (REF,FDAT,SS1,SDP,SN2)
         SELECT p_ref2,
                FDAT,
                SS1,
                SDP,
                SN2
           FROM cp_many
          WHERE REF = p_REF1
            AND fdat <= p_datm;
--   EXCEPTION
--      WHEN DUP_VAL_ON_INDEX
--      THEN bars_audit.trace('%s: move_potok Для данной сделки %s в дату %s уже есть данные в Истории изменений денежных потоков.',
--                            G_MODULE,
--                            to_char(p_ref2),
--                            to_char(p_datm, 'dd/mm/yyyy'));
   END;
 logger.trace('%s: move_potok - finish.',G_MODULE);
END move_potok;
----------------------------------------------------------------------
PROCEDURE diu_many (p_mode   IN INT,
                    p_ref    IN cp_many.REF%TYPE,
                    p_fdat   IN cp_many.fdat%TYPE,
                    p_SS1    IN cp_many.SS1%TYPE,
                    p_SDP    IN cp_many.SDP%TYPE,
                    p_SN2    IN cp_many.SN2%TYPE)
IS
   dat_    DATE;
   irr_    NUMBER;
   ire_    NUMBER;
   l_ref   cp_many.REF%TYPE;
BEGIN
   IF p_ref IS NOT NULL
   THEN
      PUL.Set_Mas_Ini ('CP_REF', TO_CHAR (p_ref), 'Реф.поточної угоди ЦП');
   END IF;
   bars_audit.info('CP.diu_many:Start with params: '
                        || ', p_mode => ' || p_mode
                        || ', p_ref => ' || p_ref
                        || ', p_fdat => ' || p_fdat
                        || ', Mas_Ini(CP_REF)=>'||pul.Get_Mas_Ini_Val ('CP_REF'));


   IF        p_mode = 0
    THEN    DELETE FROM cp_many WHERE REF = p_ref AND fdat = p_fdat;

   ELSIF    p_mode = 1
    THEN
            BEGIN
                INSERT INTO cp_many (REF,fdat,SS1,SDP,SN2)
                VALUES (p_ref,p_fdat,p_SS1,p_SDP,p_SN2);
            EXCEPTION WHEN DUP_VAL_ON_INDEX
                      THEN bars_audit.trace('%s:diu_many Для данной сделки %s в дату %s уже есть данные в Истории изменений денежных потоков.',
                                              G_MODULE,
                                              to_char(p_ref),
                                              to_char(p_fdat, 'dd/mm/yyyy'));
            END;

   ELSIF    p_mode = 2
    THEN
            BEGIN
              UPDATE cp_many
                 SET SS1 = p_SS1,
                     SDP = p_SDP,
                     SN2 = p_SN2
               WHERE REF = p_ref
                 AND fdat = p_fdat;
            EXCEPTION WHEN DUP_VAL_ON_INDEX
                      THEN bars_audit.trace('%s:diu_many Для данной сделки %s в дату %s уже есть данные в Истории изменений денежных потоков.',
                                           G_MODULE,
                                           to_char(p_ref),
                                           to_char(p_fdat, 'dd/mm/yyyy'));
            END;

   ELSIF    p_mode = 10
    THEN
      l_ref :=NVL (p_ref,TO_NUMBER (pul.Get_Mas_Ini_Val ('CP_REF')));

      SELECT MIN (fdat)
        INTO dat_
        FROM cp_many
       WHERE REF = l_ref;

      IF dat_ IS NULL
        THEN  RETURN;
      END IF;

      -- Врем.табл для IRR ( в коп)
      DELETE FROM TMP_IRR;

      INSERT INTO TMP_IRR (n, s)
         SELECT (fdat - dat_) + 1, (SS1 + SN2 + SDP) * 100
           FROM cp_many
          WHERE REF = l_ref;

      Irr_ := xIRR (10) * 100;                         --| єфф ставка реальная

      DELETE FROM TMP_IRR;

      INSERT INTO TMP_IRR (n, s)
         SELECT (fdat - dat_) + 1, (SS1 + SN2) * 100
           FROM cp_many
          WHERE REF = l_ref;

      Ire_ := xIRR (10) * 100;                         --| єфф ставка эталонная.

      UPDATE cp_deal
         SET erat = IRR_, erate = IRE_
       WHERE REF = l_REF;                              --| Сохранить ставки
   END IF;
END diu_many;
--------------------------------------------------------------------------------
/*  Оплата форвардних продаж ЦП */
--------------------------------------------------------------------------------
PROCEDURE PAY_FORW (p_DAT IN DATE)
IS
--   nam_ operlist.NAME%type    := 'Оплата форвардних продаж ЦП';
BEGIN
   FOR k IN (SELECT *
               FROM oper o
              WHERE EXISTS
                       (SELECT 1
                          FROM opldok
                         WHERE REF = o.REF
                          AND fdat <= gl.bdate
                          AND sos = 3)
                AND tt LIKE 'FX_')
   LOOP
      gl.pay (2, k.REF, gl.bdate);
   END LOOP;
END PAY_FORW;
-----------------------------------------------------------------------
-- Функция возвращает сумму начислений по дату, независимо от даты проводки
-- Параметр p_dat - дата "Начислено по" (int_accn.acr_dat)
-----------------------------------------------------------------------
FUNCTION CP_REAL_INTDATE (p_acc NUMBER, p_dat DATE, p_TIPD INT)
   RETURN NUMBER
IS
   l_int_sum   NUMBER := 0;
   l_new_int   NUMBER := 0;
   L_MOVED     NUMBER := 0;
   l_acc       NUMBER := 0; -- локальная переменная АСС счета тела ЦП пакета, при обнаружении перемещения, ей присваивается АСС счета тела предыдущего пакета ("из которого") и в котором начисление было сделано
   l_title constant varchar2(20) := 'CP.CP_REAL_INTDATE:';
BEGIN
   BARS_AUDIT.TRACE('%s Старт с параметрами: p_acc = %s на дату = %s',L_TITLE,TO_CHAR(P_ACC),TO_CHAR(P_DAT,'dd.mm.yyyy'));
   -- проверим, было ли начисление в новом купонном периоде при непогашенном купоне прошлого периода
   BEGIN
      SELECT CASE WHEN (acr_dat > p_dat OR acr_dat IS NULL) THEN 1 ELSE 0 END
        INTO l_new_int
        FROM int_accn
       WHERE acc = p_acc
         AND id = 0;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
          BEGIN
          SELECT CASE WHEN (acr_dat > p_dat OR acr_dat IS NULL) THEN 1 ELSE 0 END
            INTO l_new_int
            FROM int_accn
           WHERE acc = p_acc
             AND ID = 1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
            l_new_int := 0;
          END;
   END;
   IF L_NEW_INT = 0
    THEN BARS_AUDIT.TRACE('%s Начисления после смены купонного периода не было', l_title);
    ELSE BARS_AUDIT.TRACE('%s Начисления после смены купонного периода были (или перемещение в пакет)', l_title);
   END IF;

   -- проверим, было ли перемещение из пакета в пакет
   BEGIN
      SELECT REF_MAIN
        INTO L_MOVED
        FROM CP_DEAL CD, CP_ARCH CA
       WHERE CA.OP = 3 AND CA.REF = CD.REF AND CD.ACC = p_acc;
       BARS_AUDIT.TRACE('%s Перемещение в пакет (из пакета %s)', l_title, to_char(L_MOVED));
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         L_MOVED := 0;
         BARS_AUDIT.TRACE('%s Перемещения не было ', l_title);
   END;

   IF L_MOVED > 0
   THEN
    BEGIN
       SELECT ACC
         INTO L_ACC
         FROM CP_DEAL
        WHERE REF = L_MOVED;
        BARS_AUDIT.TRACE ('%s АСС счета предыдущего пакета = %s', l_title, to_char(L_ACC));
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          L_ACC := P_ACC;
          BARS_AUDIT.TRACE ('%s АСС счета предыдущего пакета не найден ', l_title);
    END;
   ELSE L_ACC := P_ACC;
   END IF;

   -- если начисление было в новом купонном периоде, считаем, сколько было начислено до окончания предыдущего купонного периода
   IF l_new_int > 0
   THEN
      BEGIN
         SELECT - (abs(sum(fost(i.acra, p_dat-1)))- nvl(SUM (t.s),0))
           INTO L_INT_SUM
           FROM (SELECT ad.acc,
                        ad.int_date d1,
                        COALESCE (
                           LEAD (ad.int_date)
                              OVER (ORDER BY ad.acc, ad.id, int_date),
                           p_dat-1)
                           d2,
                        ad.int_ref,
                        o.s
                   FROM acr_docs ad, oper o
                  WHERE ad.acc = l_acc AND sos = 5 and o.REF = ad.int_ref AND o.dk = 1 and tt = 'FX%') t,
                int_accn i,
                accounts a
          WHERE     i.acc = t.acc
                AND i.id = 0
                AND a.acc = i.acc
                AND d2 >= p_dat-1;
         BARS_AUDIT.TRACE('%s Сумма начисления = (%s) до %s', l_title, to_char(L_INT_SUM), to_char(p_dat,'dd.mm.yyyy'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
          BEGIN
            SELECT a.ostc
              INTO l_int_sum
              FROM accounts a, cp_deal cd
             WHERE a.acc = cd.accr
               AND cd.acc = p_acc;
             BARS_AUDIT.TRACE('%s Сумма начисления не найдена, берем сумму остатка = (%s) до %s', l_title, to_char(L_INT_SUM), to_char(p_dat,'dd.mm.yyyy'));
          EXCEPTION WHEN NO_DATA_FOUND THEN l_int_sum:=0;
          END;
      END;
   ELSE
    -- если начисления в новом купонном периоде не было, тогда берем в проводку чистый остаток
    BEGIN
        SELECT a.ostc
          INTO l_int_sum
          FROM accounts a, cp_deal cd
         WHERE a.acc = cd.accr
           AND cd.acc = p_acc;
     BARS_AUDIT.TRACE('%s Берем сумму остатка = (%s) до %s', l_title, to_char(L_INT_SUM), to_char(p_dat,'dd.mm.yyyy'));
    EXCEPTION WHEN NO_DATA_FOUND THEN l_int_sum:=0;
    END;
   END IF;

   RETURN l_int_sum;
END;
-----------------------------------------------------------------------
-- часткове погашення номинала
/*PROCEDURE CP_DEL_NOM (p_ID  IN cp_dat.ID%TYPE,      -- ID ЦБ
                      p_DOK IN cp_dat.dok%TYPE)     -- Дата досроч.пог.*/
-----------------------------------------------------------------------
    /* На старте дня для ЦБ у которых в графике купонных выплат поле
     "Частичное погашение 1 шт  номинала ЦБ" <> 0
    1. Меняем стоимость в CP_KOD, у которых в портфеле отсутствуют сделки
    2. Блокируем внесистемные счета номила  для ЦБ, у которых имеются открытые сделки в портфеле и не меняем стоимость в CP_KOD.
    ----------------
    Запуском функции "Частичное погашение номинала":

    3.Разблокируем внесистемные счета.
    4.Погашеем частично номинал выбранной бумаги.
    5.Меняем в CP_KOD стоимость ЦБ.

    С уважением, Довбня Лариса!

    Отдел технологического сопровождения.
    т. 253-14-38
    larysa@bank.gov.ua
    ---
    Выполняется из приложения "Проспект эм"
    1. Выбираем ЦББ кот эмитент объявил на досроч пог
    2. Кнопка открывается, если дата уплаты купона CP_Dat.DOK = gl.BD and CP_Dat.NOM > 0
    См.пример дата = 01-08-2011. Ид.ЦП = 1041 */
-----------------------------------------------------------------------
PROCEDURE CP_DEL_NOM (p_ID  IN cp_dat.ID%TYPE,      -- ID ЦБ
                      p_DOK IN cp_dat.dok%TYPE)     -- Дата досроч.пог.
IS
   l_cena_old   NUMBER;             -- предыдущая цена
   l_cena_new   NUMBER;             -- будущая цена
   l_cena_STR   NUMBER;             -- стартовая цена
   l_nom        NUMBER;             -- дельта цены
   l_ost        NUMBER;
   l_naz1       VARCHAR2 (60);
   l_nazn       VARCHAR2 (160);
   l_kol        INT;
   l_kv         INT;
   l_vdat       DATE;
   l_vob        INT;
   l_sREF       VARCHAR2 (20);
   l_sErr       VARCHAR2 (200);
   l_REF_MAIN   INT;
   l_cp_id      cp_kod.cp_id%TYPE;
   l_nlsG       accounts.nls%TYPE;
   l_nmsG       oper.nam_a%TYPE;
   B_4621       accounts.nls%TYPE   := SUBSTR (GetGlobalOption ('CP_4621'), 1, 14);
   S_4621       accounts.nms%TYPE;
  --kk cp_kod%rowtype ;
begin

  l_sErr := '\9356 ЦП № '|| p_ID || ' ';

  select nvl(sum( nvl(nom,0)),0)
    into l_nom
    from cp_dat
   where id = p_id
     and dok <= p_DOK;

  If l_nom <= 0
  then l_sErr := l_sErr  || 'НЕМАЄ зниження ном';
       raise_application_error(  -20203,l_sErr, TRUE);
  end if;

  BEGIN
     select k.cp_id, k.cena,     k.cena_start,  k.KV, substr(nvl(c.nmk,k.name),1,60)
       into l_cp_id, l_cena_old, l_cena_STR,    l_kv, l_naz1
       from cp_kod k, customer c
      where k.id  = p_ID
        and k.rnk = c.rnk (+);
  EXCEPTION WHEN NO_DATA_FOUND
            THEN l_sErr := l_sErr  || 'НЕ знайдено в CP_kod';
                 raise_application_error(  -20203,l_sErr, TRUE);
  END;

  BEGIN
    select substr(nms,1,38)
      into S_4621
      from accounts
     where kv = l_kv
       and nls = B_4621
       and dazs is null;
  EXCEPTION WHEN NO_DATA_FOUND
            THEN l_sErr := l_sErr || l_kv|| ' НЕ знайдено рах '|| nvl(B_4621,'4221');
                 raise_application_error(  -20203,l_sErr, TRUE);
  END;


  l_cena_new := l_cena_STR  - l_nom ;

  If l_cena_new >= l_cena_old
  then  l_sErr := l_sErr  || 'Цiну ном уже врегулювано';
        raise_application_error(-20203,l_sErr, TRUE);
  end if;

  select *
    into kk
    from cp_kod
   where id = p_id;

  cp.FXB(l_KV, 1);

  If to_char(p_DOK,'YYYYMM') < to_char(gl.bdate,'YYYYMM')
  then l_vob    := 96;
       l_VDAT   := cp.F_VDAT_ZO( add_months(gl.bdate, -1));
  else l_vob    := 6;
       l_VDAT   := gl.bdate;
  end if;

  -- текущее снижение 1 штуки
  l_nom := l_cena_old -  l_cena_new;

  -- проверить наличие таких сделок
  for k in (select d.ref, a.acc, d.accr, d.accr2, a.accc, a.nls, a.ostc, a.ostb, o.nd, o.datd, x.str_ref
              from cp_deal d, accounts a, oper o, cp_arch x
             where d.id =  p_ID
               and d.acc = a.acc
               and o.ref = d.ref
               and d.DAZS is null
               and a.ostc < 0
               and d.ref = x.ref
            )
  loop
    If k.ostc <> k.ostb
    then    l_sErr := l_sErr||'реф = '||k.ref||' план.зал НОМ НЕ=факт.зал';
            raise_application_error(-20203,l_sErr, TRUE);
    end if;

    If k.accR is not null
    then
        select ostc
          into l_ost
          from accounts
         where acc = k.accR;

       If l_ost <> 0
        then    l_sErr := l_sErr|| 'реф = '||k.ref ||' зал нар.купона НЕ=0';
                raise_application_error(-20203,l_sErr, TRUE);
       end if;
    end if;

    If k.accR2 is not null
    then
        select ostc
          into l_ost
          from accounts
         where acc = k.accR2;

        If l_ost <> 0
        then     l_sErr:= l_sErr || 'реф = '||k.ref ||' зал нак.купона НЕ=0';
                 raise_application_error(-20203,l_sErr, TRUE);
        end if;
    end if;

    BEGIN
        select NLS, substr(nms,1,38)
          into l_nlsG, l_nmsG
          from accounts
         where acc = k.ACCC;
    EXCEPTION WHEN NO_DATA_FOUND
              THEN  l_sErr := l_sErr  || 'реф = '||k.ref || ' нет счета ФУ для номинала';
                    raise_application_error(  -20203,l_sErr, TRUE);
    END;

    l_kol  := - (k.ostc / 100) / l_cena_old; -- количество  в пакете

    declare
      l_ref  CP_ARCH.ref%type;
      l_sref CP_ARCH.str_ref%type   := k.str_ref ;
      l_s    oper.s%type            := l_kol * l_nom * 100 ; -- к погаш номинал пакета
    begin
      --3.Разблокируем внесистем  сч ном этой сделки.
      update accounts set blkd =0 , blkk =0  where acc = k.acc;

      --4.Погашеем частично номинал выбранной бумаги.
      GL.REF ( l_REF) ;
      F_REF  ( l_REF, l_sREF, l_sREF );
       begin
         insert into cp_payments(cp_ref, op_ref)
         values (k.ref, l_REF);
       exception when others then null;
       end;

      l_nazn := substr(   l_naz1  ||
               '.Часткове погаш емiтентом номiналу'||
               '.Договiр '|| k.ND ||
               ' вiд '    || to_char(k.datd,'dd.mm.yyyy')
               , 1, 160 );

        BEGIN
           INSERT INTO oper (REF,    tt,     vob,    nd,     dk,
                             PDAT,   VDAT,   DATD,  DATP,
                             nam_a,  nlsa,   mfoa,  kv,     s,
                             nam_b,  nlsb,   mfob,  kv2,    s2,
                             nazn,   userid, id_a,  id_b)
                VALUES (     l_ref,  FXB_,   l_VOB,  SUBSTR (TO_CHAR (l_ref), -10),0,
                             SYSDATE,l_VDAT, gl.bDATE,gl.bDATE,
                             l_NMSG, l_NLSG, gl.AMFO, l_KV, l_s,
                             S_4621, B_4621, gl.AMFO, l_KV, l_s,
                             l_nazn, gl.aUid,gl.aOKPO,gl.aOKPO);

           payTT (0,    l_ref,  l_VDAT,   FXB_, 0,
                  l_kv, k.NLS,  l_s,
                  l_kv, B_4621, l_s);
        EXCEPTION
           WHEN OTHERS
           THEN
              raise_application_error (-20000, SQLERRM);
        END;
    END;
  END LOOP;

  -- 5.Меняем в CP_KOD стоимость ЦБ.
  update cp_kod
     set cena = l_cena_new
   where id = p_id;

end CP_DEL_NOM;
-----------------------------------------------------------------------
    -- MODI_CENA
    /* На старте дня для ЦБ у которых в графике купонных выплат поле
     "Частичное погашение 1 шт  номинала ЦБ" <> 0
    1. Меняем стоимость в CP_KOD, у которых в портфеле отсутствуют сделки
    2. Блокируем внесистемные счета номила  для ЦБ, у которых имеются открытые сделки в портфеле и не меняем стоимость в CP_KOD.
    ----------------
    Запуском функции "Частичное погашение номинала":

    3.Разблокируем внесистемные счета.
    4.Погашеем частично номинал выбранной бумаги.
    5.Меняем в CP_KOD стоимость ЦБ.

    С уважением, Довбня Лариса!

    Отдел технологического сопровождения.
    т. 253-14-38
    larysa@bank.gov.ua */
-----------------------------------------------------------------------
PROCEDURE MODI_CENA (p_dat IN DATE)
IS
   l_kol   INT;
BEGIN
   -- цикл по всем ЦБ, у кот обнаружено снижение цены

   FOR k IN (SELECT id, cena, CENA_NEW
               FROM (SELECT ID,
                            CENA,
                            (SELECT NVL (i.cena_start, i.cena) - NVL (SUM (NVL (d.nom, 0)), 0)
                               FROM cp_dat d
                              WHERE d.id = i.id AND d.dok <= p_dat)
                               CENA_NEW
                       FROM cp_kod i
                      WHERE i.DATP > p_dat)
              WHERE CENA_NEW < CENA)
   LOOP
      -- цикл по открытым сделкам
      l_kol := 0;

      FOR p
         IN (SELECT a.acc
               FROM accounts a, cp_deal d
              WHERE     (a.ostb < 0 OR a.ostc < 0)
                    AND a.acc = d.acc
                    AND d.id = k.ID)
      LOOP
         --2. Блокируем внес.счета ном, у кот открытые сделки в портфеле
         --   !!! хотя аж просится сделать тут же сброс номинала !
         --   но Лариса не согласилась. . . .

         l_kol := l_kol + 1;

         UPDATE accounts
            SET blkd = 99, blkk = 99
          WHERE acc = p.ACC;
      END LOOP;

      IF l_kol = 0
      THEN
         --1. Меняем стоимость в CP_KOD, у кот  отсутствуют сделки
         UPDATE cp_kod
            SET cena = k.CENA_NEW
          WHERE id = k.id;

         LOGGER.financial ('№ ЦП='|| k.id|| ' Угоди вiдсутнi.'|| 'Змiна цiни ном '|| k.cena|| ' -> '|| k.cena_new);
      END IF;
   END LOOP;
END MODI_CENA;

--------------------------------------------------------------------------
--  Ф-ія перевірки критичних реквізитів ЦП в момент вводу угоди купівлі
--  Повертає пусто або повідомлення
--------------------------------------------------------------------------
FUNCTION chek_rekv (p_ID    IN cp_kod.ID%TYPE,  -- Iд ЦП
                    p_mod   IN INT DEFAULT 1)   -- режим 0/1 (exception/текст повідомлення)
   RETURN VARCHAR2
IS
   l_ret   VARCHAR2 (400) := NULL;
   l_KOD   cp_kod%ROWTYPE;
BEGIN
   LOG ('Старт chek_rekv ID=' || p_id, 'INFO');

   BEGIN
      SELECT *
        INTO l_KOD
        FROM cp_kod
       WHERE id = p_id;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         IF p_mod = 0
         THEN   raise_application_error (- (20000 + 444), l_RET);
         ELSE   l_RET := 'Не знайдено ЦП з № = ' || p_id;
                LOG ('chek_rekv ' || l_ret, 'INFO');
         END IF;
   END;

   IF l_KOD.pr_akt != 1
   THEN
      IF p_mod = 0
      THEN  raise_application_error (- (20000 + 444), l_RET);
      ELSE  l_ret := 'ЦП ISIN=' || l_KOD.cp_id || ' з №=' || p_id || ' Не актуалiзований';
            LOG ('chek_rekv ' || l_ret, 'INFO');
      END IF;
   END IF;

   --------------
   IF NVL (l_KOD.ir, 0) <> 0
      AND (   l_KOD.amort IS NULL
           OR l_KOD.dcp   IS NULL
           OR l_KOD.dNK   IS NULL AND l_KOD.cena_kup0 IS NULL)
   THEN
      l_ret := 'ЦП ' || l_KOD.cp_id || ' баз.рiк ' || l_KOD.basey || ' наст.виплат ' || l_KOD.dnk || ' аморт.варт.'|| l_KOD.amort|| ' $P '|| l_KOD.dcp;
   ELSIF NVL (l_KOD.ir, 0) = 0
         AND (   l_KOD.amort  IS NULL
              OR l_KOD.pr_amr IS NULL
            --OR l_KOD.dcp    IS NULL
              )
   THEN
      l_ret := 'ЦП ' || l_KOD.cp_id || ' аморт.варт.' || l_KOD.amort || ' pr_amr=' || l_KOD.pr_amr || ' $P ' || l_KOD.dcp;
   END IF;

   IF l_ret IS NOT NULL
   THEN
      IF p_mod = 0
      THEN raise_application_error (- (20000 + 444), l_ret);
      ELSE l_ret := l_ret || ' ' || ' НEкоректнi обов.рекв';
           LOG ('chek_rekv ' || l_ret, 'INFO');
      END IF;
   END IF;

--  <<EX1>>
--   NULL;
--   LOG ('chek_rekv ' || l_ret, 'INFO');
   RETURN l_ret;
END chek_rekv;
----------

-----------------------------------------------------------------
--    UPDATE_CUPON_INFO()
--
--    На основании вставленной информации о графиках погашения купонов,
--    собрать информацию по каждому купону
--    и обновить таблицу-справочник купонов CP_KOD
--
--    Данная процедура также будет выполняться в сентуре.
--
procedure update_cupon_info(p_dummy IN date)
is
  l_year    char(4);
  l_cnt     number;
  l_mindat  date;
  l_maxdat  date;
  l_pr_amr  int     :=5;
  l_fl      int     :=1;
begin
   if user_id != 1 then
   LOG(' ЦП CP.UPDATE_CUPON_INFO - started','INFO',0);
   end if;

     for c in (select k.id, k.cp_id,
                      dat_em, datp,
                      k.dok, k.dnk,
                      kv, k.ir, npp,
                      d.dok DOK_GR
                 from cp_dat d, cp_kod k
                where k.id = d.id(+)
                  and k.country = 804
                      and (d.npp = 1 or d.npp is null)
                      and sysdate >= dat_em
                      and sysdate <= datp
                      and pr_akt = 1)
      loop
          l_mindat := NULL;
          l_maxdat := NULL;

          begin
            select unique id
              into l_fl
              from cp_v
             where id=c.id
               and (ostr!=0 or ostr2!=0);
          exception when NO_DATA_FOUND
                    then l_fl := 0;
          end;

          if l_fl!=0
           then goto EX;
          end if;

          if c.npp is null
          then
             update cp_kod
                set amort = nvl(amort,0),
                    pr_amr = nvl(pr_amr,l_pr_amr)
              where id = c.id
                and (amort != nvl(amort,0)
                     or pr_amr != nvl(pr_amr,l_pr_amr));

             goto EX;
          else
              -- аналіз графіка купонів
              -- кол-во выплат в год
              select max(ky)
                into l_cnt
                from (select to_char(d.dok,'yyyy'), count(*) ky
                        from cp_dat d
                       where id = c.id
                       group by to_char(d.dok,'yyyy'));

              -- дата останнього купону (попередня виплата)
              -- относительно банковской даты
              select nvl(max(dok),c.dat_em)
                into l_maxdat
                from cp_dat d
               where id = c.id
                 and dok <= gl.bd;

              -- дата наступного купону (наступна виплата)
              select min(dok)
                into l_mindat
                from cp_dat d
               where id = c.id
                 and dok > gl.bd;
          end if;  -- npp

         if l_mindat is not NULL
           and l_maxdat is not NULL
           and (c.dnk is null or c.dnk <= gl.bd)
           -- and l_fl=0
         then
              update cp_kod
                 set ky  = l_cnt,      -- кол-во купонов в год
                     dok = l_maxdat,   -- дата останнього купону (попередня виплата)
                     dnk = l_mindat,   -- дата наступного купону (наступна виплата)
                     amort = nvl(amort,0),
                     pr_amr = nvl(pr_amr,l_pr_amr)
               where id = c.id
                 and nvl(dok,to_date('01.01.2000','dd.mm.yyyy')) != l_maxdat;

            LOG(' ЦП CP.UPDATE_CUPON_INFO '
                      ||c.cp_id
                      ||' '
                      ||c.id
                      ||' - зміна купонного періоду '
                      ||l_maxdat
                      ||' '
                      ||l_mindat,'INFO',0);
         else
              update cp_kod
                 set amort = nvl(amort,0),
                     pr_amr = nvl(pr_amr,l_pr_amr)
               where id = c.id
                 and (amort != nvl(amort,0) or pr_amr != nvl(pr_amr,l_pr_amr));
         end if;

      <<EX>> NULL;
      end loop;

   if user_id != 1 then
   LOG(' ЦП CP.UPDATE_CUPON_INFO - ended','INFO',0);
   end if;
  -- chek_dubl_cp_id(bankdate);
end;

-----------------------------------------------------------------
--    INSERT_CP_KOD()
--
--    Вставить информацию о новом коде (ЦБ)
--
--    p_cpid -  Идентификатор ценной бумаги
--    p_date -  Дата оплаты
--    p_sum  -  сумма купона
--
procedure insert_cp_kod(  p_emi     IN  number,     -- вид эмитента
                          p_dox     IN  number,     -- вид прибыльности
                          p_cpid    IN  varchar2,   -- код ценной бумаги    PK
                          p_kv      IN  number,     -- валюта эмиссии
                          p_name    IN  varchar2,   -- название эмитента
                          p_country IN  number,     -- страна эмитент
                          p_datem   IN  date,       -- дата выпуска         PK
                          p_ir      IN  number,     -- % купона
                          p_datp    IN  date,       -- дата погашения
                          p_cena    IN  number,     -- номинал 1-ой ценной бумаги
                          p_tip     IN  number,     -- тип ценной бумаги
                          p_amort   IN  number,     -- 1-аморт.стоимость,0-наст. стоимость
                          p_dcp     IN  number,     -- 1-есть в депозитарии,0-нет
                          p_basey   IN  number,     -- % база, возможные значения: 0 - Факт/Факт, 1 - 365/Факт, 2 - 360/30, 3 - 360/Факт
                          p_cenacup IN  number,     -- цена купона 1 ЦБ (в целых с коп 10.55)
                          p_io      IN  number)     -- Нарахування %% на залишок Можливi значення (0/1/null)

is
  l_trace   varchar2(1000):= G_TRACE||'insert_cp_kod: ';
  l_dcp     int           := 0;
  l_akt     int           := 0;
  l_basey   int;
  l_cpid    cp_kod.cp_id%type;

begin
  bars_audit.info(l_trace||'Вставка нового кода: '||p_cpid||', дата эмисс:'||to_char(p_datem, 'dd/mm/yyyy hh24:mi:ss'));

  if   (p_kv =980 and p_emi=1 and p_tip=1 and p_name like 'Міністерство фінансів України')
    OR (p_kv!=980 and p_emi=1 and p_tip=1 and p_country = 804 )
  then l_dcp := 1;
  end if;

  if      p_kv = 980 and p_emi = 1 and p_tip = 1 -- and p_name like 'Міністерство фінансів України'
  then
          l_basey := 4;
          l_akt   := 0;
  elsif   p_kv = 980 and p_emi = 3 and p_tip = 2
  then
          l_basey := 0;
          l_akt   := 1;
  elsif   p_kv !=980 and p_country = 804 and p_tip = 1 and p_ir > 0
  then
          l_basey := 4;    -- l_akt:=1;
  end if;

  begin
       select max(cp_id)
         into l_cpid
         from cp_kod
        where cp_id = p_cpid;

   if l_cpid is null
   then
      insert into cp_kod
      ( emi, dox, cp_id, kv, name, country, dat_em, datp, ir,
       cena, tip, amort, dcp, basey, cena_kup, pr1_kup, pr_amr, pr_akt, io)
      values
      (p_emi,  p_dox, p_cpid,p_kv  ,p_name,p_country,  trunc(p_datem), trunc(p_datp), p_ir,
       p_cena, p_tip, decode(p_tip,2,1,null), l_dcp, l_basey, p_cenacup,2, null, l_akt, p_io);
      LOG(' ISIN='||p_cpid||' - Новий ЦП дата емісії='||p_datem,'INFO',1);
   end if;
  exception when dup_val_on_index
            then null;
                 LOG(' ISIN='||p_cpid||' - внесений в довідник раніше');
                 bars_audit.info(l_trace||'Код: '||p_cpid||', дата эмисс:'||to_char(p_datem, 'dd/mm/yyyy hh24:mi:ss')||' уже был принят');
  end;
end;
-----------------------------------------------------------------
--    INSERT_PAYDATE()
--
--    Встаивть информацию по дате оплаты по ценной бумагe ( Оплата по типу: купон или номинал)
--
--    p_cpid -  Идентификатор ценной бумаги
--    p_date -  Дата оплаты
--    p_sum  -  сумма купона (номинала)
--    p_npp  -  Номер выплаты по-порядку
--    p_type -  тип - купон
--
procedure insert_paydate(p_cpid IN varchar2,
                        p_date IN date,
                        p_sum  IN number,
                        p_npp  IN number,
                        p_type IN number)
is
  l_row     cp_dat%rowtype;
  l_sum     cp_dat.kup%type;
  l_trace   varchar2(1000):= G_TRACE||'insert_cupon_paydate: ';
begin

  if p_type <> G_PAY_CUPON and p_type <> G_PAY_NOMINAL then
     bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_PAYTYPE', to_char(p_type));
  end if;

  bars_audit.info(l_trace||'внесение даты оплаты по '||case when p_type =  G_PAY_CUPON then 'купону' else 'номиналу' end||' ЦБ: '||p_cpid||', дата '||to_char(p_date, 'dd/mm/yyyy')||', сумма '||p_sum||', № выплаты по порядку '||p_npp);
  l_sum := p_sum/100;

  begin
     select id into l_row.id    from cp_kod    where cp_id = p_cpid;
  exception when no_data_found then    bars_error.raise_nerror(G_MODULE, 'NO_SUCH_IDCP', p_cpid);
  end;

  begin
     -- если уже такой номер по порядку оплаты по этой ЦБ?
     select *
       into l_row
       from cp_dat
      where id = l_row.id
        and npp = p_npp;

     -- если есть и данные не совпадают
     if    (case when p_type =  G_PAY_CUPON then l_row.kup  else l_row.nom end) <> l_sum
        or l_row.dok <> trunc(p_date) then
        begin
           update cp_dat
              set kup = (case when p_type =  G_PAY_CUPON then l_sum  else kup   end),
                  nom = (case when p_type =  G_PAY_CUPON then nom    else l_sum end),
                  dok = trunc(p_date)
            where id = l_row.id
              and npp = p_npp;
           bars_audit.info(l_trace||'Обновление суммы и(или) даты на: сумма-'||l_sum||' дата-'||to_char(p_date,'dd/mm/yyyy'));
        exception when dup_val_on_index
                  then
                       select npp
                         into l_row.npp
                         from cp_dat
                        where id = l_row.id
                          and dok = trunc(p_date);
           bars_error.raise_nerror(G_MODULE, 'DATE_WAS_USED', p_cpid, to_date(p_date, 'dd/mm/yyyy'), to_char(l_row.npp));
        end;
     end if;
  exception when no_data_found
   then
     -- Такого номера по порядку для такого типа ЦП - нету - делаем вставку
     -- сначала проверим, а есть ли предидущий
     if p_npp > 1 then
        begin
           select npp
             into l_row.npp
             from cp_dat
            where id = l_row.id
              and npp = p_npp - 1;
        exception when no_data_found then
           bars_error.raise_nerror(G_MODULE, 'NO_PREVIOUS_NPP', p_cpid, to_char(p_npp-1),to_char(p_npp));
        end;
     end if;

     begin
        insert into cp_dat(id, npp, dok, kup, nom)
        values(l_row.id, p_npp, trunc(p_date),
                  case when p_type =  G_PAY_CUPON then l_sum else 0     end,
                  case when p_type =  G_PAY_CUPON then 0     else l_sum end);
        bars_audit.info(l_trace||'вставка нового периода');
     exception when dup_val_on_index then
        begin
           -- если такая дата по данной ЦБ уже есть в каком-то номере пп
           select npp
             into l_row.npp
             from cp_dat
            where id = l_row.id
              and dok = trunc(p_date);
           -- попытка вставить новый номер ПП с такой же датой
           bars_error.raise_nerror(G_MODULE, 'SUCH_DATE_INOTHERNPP', p_cpid, to_char(p_npp), to_char(p_date, 'dd/mm/yyyy') ,l_row.npp);
        exception when no_data_found then
           -- значит сработал primary ked(id, npp) - тогда просто обновим сумму
           update cp_dat
              set kup = (case when p_type =  G_PAY_CUPON then l_sum  else kup   end),
                  nom = (case when p_type =  G_PAY_CUPON then nom    else l_sum end)
            where id = l_row.id
              and npp = p_npp
              and dok = p_date;
           bars_audit.info(l_trace||'Обновление суммы на: '||l_sum);
        end;
     end;
  end;
end;

-----------------------------------------------------------------
--    INSERT_CUPON_PAYDATE()
--
--    Встаивть информацию по дате оплаты купона по ценной бумаге
--
--    p_cpid -  Идентификатор ценной бумаги
--    p_date -  Дата оплаты
--    p_sum  -  сумма купона
--    p_npp  -  Номер выплаты по-порядку
--
PROCEDURE insert_cupon_paydate (p_cpid   IN VARCHAR2,
                                p_date   IN DATE,
                                p_sum    IN NUMBER,
                                p_npp    IN NUMBER)
IS
BEGIN
   insert_paydate (p_cpid   => p_cpid,
                   p_date   => p_date,
                   p_sum    => p_sum,
                   p_npp    => p_npp,
                   p_type   => G_PAY_CUPON);
END;
-----------------------------------------------------------------
--    KUPON1()
--
--
FUNCTION KUPON1 (p_ID     IN cp_kod.ID%TYPE,    -- Ид ЦБ
                 P_dat    IN DATE,              -- дата, на какую расчитать купон по графуку куп.пл.,если сделка планируется в эту дату
                 p_DATE   IN cp_kod.DAT_EM%TYPE  DEFAULT NULL,
                 p_DATP   IN cp_kod.DATP%TYPE    DEFAULT NULL,
                 p_PR1    IN cp_kod.PR1_KUP%TYPE DEFAULT NULL)
   RETURN NUMBER
IS
   title    constant varchar2(11) := 'CP.KUPON1:';
   DATE_    DATE;
   DATP_    DATE;
   PR1_     INT;
   dDok1_   DATE;
   dDok2_   DATE;
   nKolD_   INT;
   KUP_     NUMBER;
   nKup1_   NUMBER := 0;

    /* обработка кривого купона при покупке */
    l_has_awry_period int := 0; -- есть ли "кривой" купон для бумаги - при наличии укороченного 1го или последнего купонного периода
    l_npp             int;
    l_normal          int;
    l_awry_first      int;
    l_awry_last       int;
BEGIN
   bars_audit.trace(title|| 'start with params: p_ID=>'|| p_ID|| ',P_dat=>'||to_char(P_dat,'dd.mm.yyyy')
                                                      ||',p_DATE=>'|| to_char(p_DATE,'dd.mm.yyyy')
                                                      ||',p_DATP=>'||to_char(p_DATP, 'dd.mm.yyyy')
                                                      ||',p_PR1=>'||p_PR1);
   IF p_DATE IS NULL OR p_DATP IS NULL OR p_PR1 IS NULL
   THEN
      BEGIN
         SELECT dat_em, datp, NVL (PR1_KUP, DECODE (kv, gl.baseval, 2, 1))
           INTO DATE_, DATP_, PR1_
           FROM cp_kod
          WHERE id = P_Id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN nKup1_;
      END;
   ELSE
      DATE_ := p_DATE;
      DATP_ := p_DATP;
   END IF;
   bars_audit.trace(title|| '1.DATE_='|| to_char(DATE_,'dd.mm.yyyy')||', DATP_='||to_char(DATP_,'dd.mm.yyyy')||', PR1_='||PR1_);
   IF p_DAT = DATE_
   THEN
      RETURN 0;
   END IF;

 -----------------------------------------------------------------------------
   -- Найти дату пред купона
   SELECT NVL (MAX (dok), DATE_)
     INTO dDok1_
     FROM cp_dat
    WHERE id = p_ID
      AND dok < p_DAT;
   bars_audit.trace(title|| '2.Дата предыдущего купона = dDok1_ ='||to_char(dDok1_,'dd.mm.yyyy'));
   -- Найти дату след купона
   SELECT NVL (MIN (dok), DATP_)
     INTO dDok2_
     FROM cp_dat
    WHERE id = p_ID
      AND dok >= p_DAT;
  bars_audit.trace(title|| '2.Дата следующего купона = dDok2_ ='||to_char(dDok2_,'dd.mm.yyyy'));
   -- Найти сумму  след купона
   BEGIN
      SELECT kup * 100
        INTO KUP_
        FROM cp_dat
       WHERE id = P_ID AND dok = dDok2_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         KUP_ := 0;
         RETURN 0;
   END;
  bars_audit.trace(title|| '3.Сумма следующего купона = KUP_='||KUP_);
  /*проверка на кривой купон*/
  awry_period(p_id          => p_ID,                -- IN код ценной бумаги
              p_npp         => l_npp,               -- OUT текущий купонный период
              p_normal      => l_normal,            -- OUT количество дней в нормальном купонном периоде (втором)
              p_awry        => l_has_awry_period,   -- OUT признак наличия укороченного купонного периода 1/0
              p_awry_first  => l_awry_first,        -- OUT количество дней в первом купонном периоде
              p_awry_last   => l_awry_last);        -- OUT количество дней в последнем купонном периоде

   SELECT NVL (MIN (npp), l_npp)
     INTO l_npp
     FROM cp_dat
    WHERE id = p_ID
      AND dok > p_DAT;

   bars_audit.trace(title||'4.l_has_awry_period='|| to_char(l_has_awry_period)||',dDok2_ - dDok1_ = '||to_char(dDok2_ - dDok1_)||'(l_normal-l_awry_first)='||(l_normal-l_awry_first));
   -- Кол-во дней в периоде
   if l_npp = 1 and l_has_awry_period = 1
   then   nKolD_ := l_normal;
          dDok1_ := DATE_-(l_normal-l_awry_first);
   else   nKolD_ := dDok2_ - dDok1_;
   end if;

   bars_audit.trace(title||'5.l_has_awry_period='|| to_char(l_has_awry_period)||', nKolD_ = '||nKolD_||' ,dDok1_='|| to_char(dDok1_,'dd.mm.yyyy')|| ', DATE_ = '||to_char(DATE_,'dd.mm.yyyy'));

   /*
   Округление для вычисления "нарахованого купонного доходу на пакет"
   производится следующим образом:
    [ (Купон на одну ЦБ) / (Количество дней  в текущем купон.периоде) ] *
    [ (Кол-во дней в отчетном периоде) ]

   полученное значение округляем до двух знаков.
   Результат округления умножаем на количество ЦБ в пакете.
   Пример: купон=47,5;
   кол-во дней в купонном периоде=182;
   кол-во дней в отчетном периоде
   (кол-во дней с момента последней выплаты купотна
    на момент начисления купонного дохода)=19;
    кол-во ЦБ=10000

   ОКРУГЛ((47,5/182*19);2)=4,96
   4,96*10000= 49600    */

   bars_audit.trace(title||'6. (p_DAT - dDok1_)=' ||(p_DAT - dDok1_));
   IF KUP_ > 0 AND nKolD_ > 0
   THEN
      -- Цена купона фиксированная, ( HE  по % ставке, по-честному)
      IF PR1_ = 2
      THEN
         nKup1_ := ROUND ( (KUP_ / nKolD_) * (p_DAT - dDok1_), 0);
      ELSE
         nKup1_ := (KUP_ / nKolD_) * (p_DAT - dDok1_);
      END IF;
   END IF;
   bars_audit.trace(title||'Finish return 7.nKup1_=' ||nKup1_);
   RETURN (nKup1_);

END KUPON1;

--------------

FUNCTION GEO_RATE_Y (NOM_    IN NUMBER,   -- Номинал
                     ID_     IN INT,      -- Ид ЦБ
                     Y_      IN NUMBER,   -- собственно коеф
                     dat_    IN DATE,     -- дата, на какую расчитать денежную стоимость
                     MODE_   IN INT)      -- 0 = расчитать накопл.купон
                                          -- 1 = расчитать чистую  стоимость
                                          -- 2 = расчитать грязную стоимость  ( 2 = 0 + 1)
   RETURN NUMBER
IS
   ir_      NUMBER;         -- Из справ: "годовая" % стака купона/100
   KY_      INT;            -- количество в?плат купона в "году"
   DOK_     DATE;           -- Дата выплаты ПРЕДЫДУЩЕГО Купона
   DNK_     DATE;           -- Дата выплаты СЛЕДУЮЩЕГО  Купона
   datp_    DATE;           -- дата погашения
   BASEY_   INT;            -- Код процентной базы (Базовый "год")
   kol_     INT;            -- Переменные: количество дней в "году"
   T_       NUMBER;
   N_       NUMBER;
   R_       NUMBER := 0;
   K_       NUMBER;
   i_       INT := 0;
   CP_      NUMBER(24, 10); -- расчетная текущая ГРЯЗНАЯ стоимость
BEGIN
   BEGIN
      SELECT DATP,  IR / 100,   BASEY,  KY,     NVL (DOK, DAT_EM),  DNK
        INTO DATP_, IR_,        BASEY_, KY_,    DOK_,               DNK_
        FROM CP_KOD
       WHERE ID = ID_;

      IF    DATP_  IS NULL
         OR IR_    IS NULL
         OR BASEY_ IS NULL
         OR KY_    IS NULL
         OR DOK_   IS NULL
         OR DNK_   IS NULL
      THEN
         erm := '9351 - NOT parametr in CP_KOD: №' || ID_;
         RAISE err;
      --     return to_number(null);
      END IF;

      IF BASEY_ = 0
      THEN
         -- 0 Факт/Факт
         KOL_ :=
              TO_DATE ('31-12-' || TO_CHAR (DAT_, 'YYYY'), 'DD-MM-YYYY')
            - TO_DATE ('01-01-' || TO_CHAR (DAT_, 'YYYY'), 'DD-MM-YYYY')
            + 1;
      ELSIF BASEY_ = 1
      THEN
         -- 1 365 /Факт
         KOL_ := 365;
      ELSE
         -- 2 360 /30
         -- 3 360 /Факт
         KOL_ := 360;
      END IF;

      K_ := IR_ / KY_;

      IF MODE_ = 0
      THEN
         CP_ := (DAT_ - DOK_) * K_ / (DNK_ - DOK_);
      ELSE
         t_ := (DNK_ - DAT_) / (DNK_ - DOK_);
         n_ := ROUND ( (DATP_ - DOK_) * KY_ / kol_, 0) - 1;
         CP_ := 1 / POWER (1 + Y_ / KY_, t_ + n_);

         FOR i_ IN 0 .. n_
         LOOP
            R_ := R_ + 1 / POWER (1 + Y_ / KY_, t_ + i_);
         END LOOP;

         cp_ := CP_ + K_ * R_;

         IF MODE_ = 1
         THEN
            CP_ := CP_ - (DAT_ - DOK_) * K_ / (DNK_ - DOK_);
         END IF;
      END IF;

      RETURN NOM_ * CP_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         RETURN TO_NUMBER (NULL);
   END;
EXCEPTION
   WHEN err
   THEN
      raise_application_error (- (20000 + ern), '\' || erm, TRUE);
END GEO_RATE_Y;
------------------------------------------------------------------------
-- FUNCTION F_VDAT_ZO (DAT_ IN DATE)
-- возвращает дату последнего рабочего дня месяца
------------------------------------------------------------------------
FUNCTION F_VDAT_ZO (DAT_ IN DATE)
   RETURN DATE
IS
   VDAT_   DATE := DAT_;
BEGIN
   BEGIN
      SELECT NVL(MAX(FDAT), DAT_)
        INTO VDAT_
        FROM FDAT
       WHERE TO_CHAR (FDAT, 'YYYYMM') = TO_CHAR (DAT_, 'YYYYMM');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN VDAT_ := DAT_;
   END;
   RETURN VDAT_;
END F_VDAT_ZO;
------------------------------------------------------------------------

FUNCTION UFORMULA01 (
    VALUE_        IN       NUMBER,    -- Номинал
    TYPE_         IN       VARCHAR2,  -- Тип
    DATEP_        IN       DATE,      -- Дата погашения
    DATEC_        IN       DATE,      -- Дата текущая
    BASEY_        IN       NUMBER,    -- Код базового года
    K_            IN       NUMBER     -- %% коефициент
) RETURN NUMBER
--
-- Пользовательская формула
-- Вычисление суммы по ЦБ, НБ Грузии
--
IS
    DaysInYear_     NUMBER;
    DaysInPeriod_   NUMBER;
    YearBegin_      DATE;
    YearEnd_        DATE;
    Result_         NUMBER;
BEGIN

    YearBegin_ := TRUNC( DATEC_, 'YEAR');
    YearEnd_   := LAST_DAY( YearBegin_ + 360 );

    IF    BASEY_ = 0 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := YearEnd_ - YearBegin_;
    ELSIF BASEY_ = 1 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := 365;
    ELSIF BASEY_ = 2 THEN
        DaysInPeriod_ := (EXTRACT(MONTH FROM DATEP_) - EXTRACT(MONTH FROM DATEC_) - 1) * 30;
        DaysInPeriod_ := DaysInPeriod_ + EXTRACT(DAY FROM DATEP_);
        DaysInPeriod_ := DaysInPeriod_ + (30 - EXTRACT(DAY FROM DATEC_));
        DaysInYear_   := 360;
    ELSIF BASEY_ = 3 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := 360;
    ELSE
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := YearEnd_ - YearBegin_;
    END IF;
--грузия
    IF Substr(TYPE_,1,1) = 'D' THEN
        Result_ := VALUE_ * ( 1 - K_ * (DaysInPeriod_ / DaysInYear_));
    ELSE
        Result_ := VALUE_ / ( 1 + K_ * (DaysINPeriod_ / DaysInYear_));
    END IF;

    RETURN Result_;
END UFORMULA01;
--------------
FUNCTION UFORMULA_D2Y (
    K_            IN       NUMBER,    -- %% коефициент
    DATEP_        IN       DATE,      -- Дата погашения
    DATEC_        IN       DATE,      -- Дата текущая
    BASEY_        IN       NUMBER     -- Код базового года

) RETURN NUMBER
--
-- Пользовательская формула
-- Преобразование % коефициента из D в Y, НБ Грузии
--
IS
    DaysInYear_     NUMBER;
    DaysInPeriod_   NUMBER;
    YearBegin_      DATE;
    YearEnd_        DATE;
    Result_         NUMBER;
BEGIN

    YearBegin_ := TRUNC( DATEC_, 'YEAR');
    YearEnd_   := LAST_DAY( YearBegin_ + 360 );

    IF    BASEY_ = 0 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := YearEnd_ - YearBegin_;
    ELSIF BASEY_ = 1 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := 365;
    ELSIF BASEY_ = 2 THEN
        DaysInPeriod_ := (EXTRACT(MONTH FROM DATEP_) - EXTRACT(MONTH FROM DATEC_) - 1) * 30;
        DaysInPeriod_ := DaysInPeriod_ + EXTRACT(DAY FROM DATEP_);
        DaysInPeriod_ := DaysInPeriod_ + (30 - EXTRACT(DAY FROM DATEC_));
        DaysInYear_   := 360;
    ELSIF BASEY_ = 3 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := 360;
    ELSE
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := YearEnd_ - YearBegin_;
    END IF;

        Result_ := K_ / ( 1 - K_ * (DaysInPeriod_ / DaysInYear_));

    RETURN Result_;
END UFORMULA_D2Y ;
---------------------
FUNCTION UFORMULA_Y2D (
    K_            IN       NUMBER,    -- %% коефициент
    DATEP_        IN       DATE,      -- Дата погашения
    DATEC_        IN       DATE,      -- Дата текущая
    BASEY_        IN       NUMBER     -- Код базового года

        ) RETURN NUMBER
--
-- Пользовательская формула
-- Преобразование % коефициента из D в Y, НБ Грузии
--
IS
    DaysInYear_     NUMBER;
    DaysInPeriod_   NUMBER;
    YearBegin_      DATE;
    YearEnd_        DATE;
    Result_         NUMBER;
BEGIN

    YearBegin_ := TRUNC( DATEC_, 'YEAR');
    YearEnd_   := LAST_DAY( YearBegin_ + 360 );

    IF    BASEY_ = 0 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := YearEnd_ - YearBegin_;
    ELSIF BASEY_ = 1 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := 365;
    ELSIF BASEY_ = 2 THEN
        DaysInPeriod_ := (EXTRACT(MONTH FROM DATEP_) - EXTRACT(MONTH FROM DATEC_) - 1) * 30;
        DaysInPeriod_ := DaysInPeriod_ + EXTRACT(DAY FROM DATEP_);
        DaysInPeriod_ := DaysInPeriod_ + (30 - EXTRACT(DAY FROM DATEC_));
        DaysInYear_   := 360;
    ELSIF BASEY_ = 3 THEN
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := 360;
    ELSE
        DaysInPeriod_ := TRUNC(DATEP_ - DATEC_);
        DaysInYear_   := YearEnd_ - YearBegin_;
    END IF;

    Result_ := K_ / ( 1 + K_ * (DaysInPeriod_ / DaysInYear_));

    RETURN Result_;
END UFORMULA_Y2D;
-----------------

--Пересмотр форв.купона по ЦБ
procedure CP_FORV_KUP(nId_ int) is
begin
     for k in
       (SELECT e.ACC, e.ACCR,
         decode(a.ostB, 0,
                0,
               -(k.CENA_KUP*a.ostB/k.CENA - NVL(r2.ostB,0))
                )  SF
        from cp_kod k, cp_deal e, accounts a, accounts r, accounts r2
        where  k.id=nID_ and k.id = e.id and a.acc= e.acc and r.acc=e.accr
          and r2.acc(+)=e.accr2 and a.ostc<>0 and k.cena>0 and k.CENA_KUP>0
        )
    loop
       update accounts set ostf= k.SF where acc=k.ACCR;
    end loop;

end CP_FORV_KUP;
-----------------------------------------------------------------------------
-- RMany_dat
-- НАПОЛНЕНИЕ очереди для модификации потоков
-----------------------------------------------------------------------------
PROCEDURE RMany_dat (REF1_   IN cp_deal.ref%type,
                     REF2_   IN cp_deal.ref%type,
                     VDAT_   IN DATE,
                     N_      IN NUMBER,
                     R_      IN NUMBER)
IS
 dd     cp_deal%rowtype;
 kk     cp_kod%rowtype;   -- 2/06-14 ! lokal
 ff     cp_pf%rowtype;

BEGIN

    BEGIN
       SELECT d.*
         INTO dd
         FROM cp_deal d
        WHERE d.REF = REF1_;

       SELECT k.*
         INTO kk
         FROM cp_kod k
        WHERE k.id = dd.id;

       SELECT f.*
         INTO ff
         FROM cp_pf f, accounts a, cp_vidd v
        WHERE     v.vidd = SUBSTR (a.nls, 1, 4)
              AND a.acc = dd.acc
              AND v.emi = kk.emi
              AND v.pf = f.pf;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN RETURN;
    END;

    IF  NVL(ff.no_a,0) = 1
    THEN
       DELETE
         FROM CP_MANY_dat
        WHERE REF1 = REF1_
          AND REF2 = REF2_;

       LOG('RMany_dat. НЕ включаємо в чергу пакет '||ref1_||' / '||ref2_,'INFO',5);
       RETURN;
    END IF;


    UPDATE CP_MANY_DAT
       SET SS = SS + N_,
           SN = SN + R_
     WHERE REF2 = REF2_
       AND REF1 = REF1_;

     IF SQL%ROWCOUNT=0
     THEN
        -- в т.ч. дисконтные
        INSERT INTO CP_MANY_DAT (REF1, REF2, VDAT, SS, SN)
           SELECT REF1_, REF2_, VDAT_, N_, R_
             FROM DUAL
            WHERE NVL (kk.ir, 0) = 0
                  OR EXISTS
                        (SELECT 1
                           FROM cp_dat
                          WHERE id = kk.id
                            AND dok >= VDAT_);

        LOG('RMany_dat. Запис в чергу пакета '||REF1_||' / '||REF2_,'INFO',5);
     END IF;

END RMany_dat;
-----------------------------------------------------------------------------

PROCEDURE RMany
(p_REF1 number, -- реф первичной сделки покурки
 p_REF2 number, -- реф следуюшей сделки продажи / перемещения
 p_VDAT date  ,
 p_N number   , -- використовується як накопичена сума номіналу при декільках угодах продажу в один день по одній угоді купівлі
 p_R number   , -- сума купону угоди
 p_out out varchar2) is

-- Sta Анулирование старых ден.потоков  и  Построение новых при частичной продаже/перемещении пакета ЦБ.
  title constant varchar2(12) := 'CP.RMany:';
  Id_    cp_deal.id%type;
  kk     cp_kod%rowtype;  -- ! lokal
  dd     cp_dat%rowtype;
  ACCR_  number;
  ACCR2_ number;
  ACCR3_ number;
  ACCD_  number;
  N_     number := 0 ; --ост.Номинал текущий
  N1_    number := 0 ; --номинал к погащению в последнюю дату   N1_    number := 0 ; --номинал к погащению в последнюю дату
  D_     number := 0 ; --ост.реального Дисконта/Премии
  V_     number := 0 ; --ост.виртуальн Дисконта/Премии


  nKol_  int    ;
  nInt1_ number ;
  Irr_   number ;
  IrE_   number ;
  R_     number :=0;
  R2_    number :=0;
  R3_    number :=0;
  l_erat   cp_deal.erat%type;
  l_erate  cp_deal.erate%type;
  l_ref_main int; l_fl int; l_op int;

BEGIN
  bars_audit.info(title || 'Start with params: '
                        || ', p_REF1 => ' || p_REF1
                        || ', p_REF2 => ' || p_REF2
                        || ', p_VDAT => ' || to_char(p_VDAT, 'dd.mm.yyyy')
                        || ', p_N => '    || p_N
                        || ', p_R => '    || p_R);

  p_out:='00';
  -- а надо ли это делать вообще ?
  begin    ------------------------- есть ли номинал
     select id,accR,accR2, accR3, fost(acc,p_vdat), NVL(accD,accP), op
     into ID_, ACCR_, ACCR2_, ACCR3_, N_, ACCD_, l_op
     from cp_deal where ref=p_REF1 and fost(acc, p_vdat) <0 ;
  EXCEPTION WHEN NO_DATA_FOUND THEN p_out:='00';  RETURN ;
  end;

  -----------
  If ACCD_ is not null then ---------------------- есть ли реальный Д/П
     D_ := fost( accd_, p_vdat);
  end if;                   ---------------------- есть ли вирт Д/П
  select nvl(SUM( fOST(a.acc,p_vdat) ),0) into v_  FROM ACCOUNTS A, cp_ref_acc r
  where r.ref = p_REF1 and r.acc=a.acc and a.tip in ('2VP','2VD');
  D_  := D_ +  V_;

  ----------------------------------------
  begin   --Есть ли последняя дата в графике купонных платежей ?
    select  k.* into kk  from  cp_kod k, cp_dat d  where k.id=ID_ and d.id=k.ID and d.dok=k.DATP;  kk.ir:= nvl(kk.IR,0);
  EXCEPTION WHEN NO_DATA_FOUND THEN p_out:='02';
    raise_application_error(-(20000+333),  '\ Нет графика купонных платежей для ЦБ id=' || ID_ ||' , ref='||p_REF1,TRUE);
  end;

  -- цена последнего номинала N1_ (пересчитаем и запишем на всякий случай)
  select nvl( kk.CENA_START, kk.cena) - nvl(sum(nom),0)  into N1_ from cp_dat where id= ID_ and  dok < kk.DATP;
  update cp_dat set nom = N1_ where id =ID_ and dok = kk.DATP and nom <> N1_;

  -- цена текушего номинала kk.cena
  select nvl( kk.CENA_START, kk.cena) - nvl(sum(nom),0)  into kk.cena  from cp_dat where id = ID_ and dok < p_vdat;

  --расчет для  нового раб.потока
  nKol_ := Abs(N_ /(100*kk.CENA));
  -- номинал  N1_ к погащению в последнюю дату  в целіх гг.кк
  N1_ := N1_ * nkol_ ;


  -- Сумма нач.проц по % ставке в целых (типа 28.67)
  If kk.KY > 0          then nInt1_ := Round( kk.CENA * kk.IR / kk.KY,0)             / 100;
  ElsIf kk.PERIOD_KUP>0 then nInt1_ := Round( kk.CENA * kk.IR * kk.PERIOD_KUP/365,0) / 100;
  Else                       nInt1_ := 0;
  end if;

  BARS_AUDIT.INFO(title || 'nInt1_= ' ||nInt1_||', kk.CENA = '||kk.CENA||', kk.IR='||kk.IR||', kk.KY='||kk.KY);
  If Nvl(accR_,0)  >0 then  R_  := fost (accr_ , p_vdat);   end if;
  If Nvl(accR2_,0) >0 then  R2_ := fost (accr2_, p_vdat);   end if;
  If Nvl(accR3_,0) >0 then  R3_ := fost (accr3_, p_vdat);   end if;

  l_fl:=1;  -- флаг щодо перерахунку еф. ставки

 if l_op=3 and p_ref1=p_ref2 then
 begin
 select d.erat, d.erate, d.ref, 3
 into l_erat, l_erate, l_ref_main, l_fl
 from cp_deal d
 where d.ref = (select ar.ref_main
                from cp_arch ar
                where ar.ref=p_ref1 and ar.op=3);
 EXCEPTION WHEN NO_DATA_FOUND THEN l_fl:=1;
 end;
 end if;

  If gl.aMfo in ('300001') then l_fl:=1; end if;

  --перемещение в архив
  insert into CP_MANY_upd (REF,FDAT,SS1,SDP,SN2)
  select REF,FDAT,SS1,SDP,SN2 from cp_many where ref=p_REF1;

  If gl.aMfo in ('300001','321024')  or p_ref1 = p_ref2 then
     -- в НБУ всегда идет пересчет эф. ставки.
     -- в КБ - только при первичном построении

     -- Врем.табл для IRR ( в коп)
     delete from TMP_IRR;
     --1)  день-1 выдачи средств
     insert into TMP_IRR(n,s) values (1,N_+D_+r_+R2_+R3_ );
     --2) день-i погаш купона и част.номинала
     insert into TMP_IRR(n,s) select (DOK-p_Vdat+1), 100*nKol_*(nvl(nom,0)+Nvl(KUP,nInt1_)) from cp_dat where id=ID_ and DOK>p_VDAT and DOK<kk.DATP;
     --3) день-к погаш посл.купона и ост.номинала
     insert into TMP_IRR(n,s) select (DOK-p_Vdat+1), 100*N1_+100*nKol_*Nvl(KUP,nInt1_)      from cp_dat where id=ID_ and DOK =kk.DATP;
     Irr_  := xIRR( kk.IR ) * 100 ;                                            --| єфф ставка реальная
     If kk.IR = 0 then                            IrE_ :=0;                    --\ єфф ставка эталонная.
     else   update TMP_IRR set s=s-D_ where n=1;  IrE_ := xIRR( kk.IR ) *100 ; --/ Для амортизации
     end if;
     if l_fl=1 then                                                                   --|
     update cp_deal set erat=IRR_, erate=IRE_ where ref=p_REF1;   --| Сохранить ставки
     elsif l_fl=3 then
     update cp_deal set erat=l_erat, erate=l_erate where ref=p_REF1;
     else null;
     end if;

     -- пост табл Новых потоков (в  цел)
     delete from cp_many where ref=p_REF1 ;
     --1) день-1 выдачи средств
     insert into cp_many(REF,FDAT,SS1,SDP,SN2) values (p_REF1,p_VDAT, N_/100 ,D_/100, (r_+R2_+R3_)/100);
     --2) день-i погаш купона и част.номинала
     insert into cp_many(REF,FDAT,SS1,SDP,SN2) select P_REF1,DOK, nKol_*nvl(nom,0), 0, nKol_*Nvl(KUP,nInt1_) from cp_dat where id=ID_ and DOK>p_VDAT and DOK<kk.DATP ;
     --3) день-к погаш посл.купона и ост.номинала
     insert into cp_many(REF,FDAT,SS1,SDP,SN2) select P_REF1,DOK, N1_             , 0, nKol_*Nvl(KUP,nInt1_) from cp_dat  where id=ID_ and dOK=kk.DATP ;

  else
     -- в КБ -- добавить  в табл старых  потоков новую будущую часть (в  цел)
     delete from cp_many where ref=p_REF1 and fdat >= p_VDAT; --майбутня частина рахується від дати у черзі на перерахунок потоків, навіть якщо вона заднім числом  --gl.bdate;

     --1) день-1 продажи ЦБ
     insert into cp_many(REF,FDAT,SS1,SDP,SN2) select p_REF1,p_VDAT, x.N/100 + nvl(p_N,0)/100, (-x.D+x.P)/100, x.R/100 + nvl(p_R,0)/100 from cp_arch x where x.ref = p_REF2 ;
     --2) день-i погаш купона и част.номинала
     insert into cp_many(REF,FDAT,SS1,SDP,SN2) select P_REF1,DOK, nKol_*nvl(nom,0), 0, nKol_*Nvl (KUP,nInt1_) from cp_dat where id=ID_ and DOK>p_VDAT and DOK< kk.DATP ;
     --3) день-к погаш посл.купона и ост.номинала
     insert into cp_many(REF,FDAT,SS1,SDP,SN2) select P_REF1,DOK, N1_, 0 , nKol_*Nvl (KUP,nInt1_)             from cp_dat where id=ID_ and dOK=kk.DATP ;

  end if;
 bars_audit.info(title || 'Finish with params: p_out => ' || p_out);
END RMany;

------
PROCEDURE RMany_all  (DAT_ date) is
 -- модификация потоков всех сделок из очереди. Очистка очереди
  l_ret        varchar2(2);
  l_ref_prev   number;
  l_vDat_prev  date;
  l_sum_N_prev number;
  l_sum_R_prev number;
  l_sum_N      number;
  l_sum_R      number;
begin
  --raise_application_error(-20001, 'DAT_ = '||to_date(DAT_, 'DD.MM.YYYY HH24:MI'));
 for k in (select m.REF1, m.REF2, m.VDAT,m.SS,m.SN, o.sos, d.op, d.n, d.r
           from CP_MANY_dat m, oper o, cp_arch d
           where o.ref=m.ref2   and ( o.sos<0 OR o.sos>=5 ) and o.ref=d.ref
           ORDER By m.REF1, m.VDAT
             )
 loop
     LOG('RMany_all. *Модифікація потоків для угоди '||k.ref1);
     l_ret := null;
     If k.sos >= 5 then
        if k.ref1=k.ref2 then    --  and  k.op in (1,3)
            update cp_deal set active=1 where ref=k.ref1 and nvl(active,0)=0;
            commit;
        end if;
        /* Diver: Костилювання старого коду. Предмова: вхідний параметр DAT_ невикористовується(WTF?), а в процедуру перебудови RMany передавалось два невикористовуємих параметри.
                  Навчив процедуру накопичувати суму проданого номіналу у разі якщо в Один День по різних угодах продажу було декілька операцій по угоді купівлі.
                  Приклад:
                  ID      REF угоди купівлі     REF продажу       Дата продажу      Сума номіналу    Сума купону угоди
                  335     23680633401           34356409801       21.05.2015        10000000         250100
                  335     23680633401           34356417501       21.05.2015        5000000          125050
                  335     23680633401           34356397901       21.05.2015        10000000         250100
        */
        if l_vDat_prev = k.VDAT and l_ref_prev = k.ref1 then
          l_sum_N := l_sum_N + l_sum_N_prev;
          l_sum_R := l_sum_R + l_sum_R_prev;
          else
            l_sum_N := 0;
            l_sum_R := 0;
        end if;
        LOG('RMany_all. Модифікація потоків для угоди '||k.ref1||' '||k.ref2,'INFO',5);
        cp.RMany(k.ref1, k.REF2, k.VDAT, l_sum_N/*k.ss*/, l_sum_R/*k.sn*/, l_ret);
        if l_ret!='00' then
          LOG(' RMany_all. проблема модифікації потоків для угоди '||k.ref2||' код='||l_ret,'ERROR');
        end if;
        l_vDat_prev  := k.VDAT;
        l_sum_N_prev := k.n;
        l_sum_R_prev := k.r;
        l_ref_prev   := k.ref1;
        if l_ret='00' and k.ref1 != k.ref2 and k.op=3 and l_CP_MVRAT='1' then
           move_potok (p_ref1 => k.ref1, p_ref2 => k.ref2, p_datm => k.vdat);
           LOG('RMany_all. Перенесення поток_в реф '||k.ref1||' -> '||k.ref2,'TRACE',5);
        end if;

     end if;

     if l_ret='00' or k.sos< 0 then
        delete from CP_MANY_dat  where ref2=k.REF2 and ref1=k.ref1;
     end if;
 end loop;


 ---Пересмотр форв.купона для тех ЦБ, по кот был БЭК.
  -- Після відмови від metr=4 відпадає смисл даного фрагмента  8/06-15
 for k in (select distinct ID from cp_arch where ref in (select m.REF1 from CP_MANY_dat m, oper o where o.ref=m.ref2 and o.sos<0) )
 loop
    cp.cp_FORV_KUP(k.id);
 end loop;
end RMany_all;
---------------

PROCEDURE DOK_DNK (DAT_ DATE)
IS
   kup_      cp_dat.KUP%TYPE;
   OSTC_     accounts.OSTC%TYPE;
   OSTC_R2   accounts.OSTC%TYPE;
   ND_       oper.ND%TYPE;
   DATN_     DATE := dat_next_u (DAT_, 1);                -- дата след.раб дня
   Accc_r    accounts.Accc%TYPE;
   Accc_r2   accounts.Accc%TYPE;
   l_check   number := 0;
   l_int     number := 0; -- признак, что в текущем купонном периоде начисление выполнено в полном объеме
   l_ir      cp_kod.ir%type;
   l_txt     varchar2(4000);

   -- функция проверки наличия кода ЦП в справочнике исключений для принудительной
   -- смены купонного периода без наличия погашения в предыдущем купонном периоде
    FUNCTION f_check_R (p_id NUMBER)
       RETURN NUMBER
    IS
       p_result   NUMBER := 0;
    BEGIN
       BEGIN
          SELECT 1
            INTO p_result
            FROM CP_CHECK
           WHERE id = p_id;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN p_result := 0;
       END;
    bars_audit.trace('CP:f_check_R('||to_char(p_id)||') result = '||to_char(p_result));
       RETURN p_result;
    END;

    -- функция проверки наличия полного начисления купона в меняемом купонном периоде
    FUNCTION f_check_int (p_acc NUMBER, p_dat DATE)
       RETURN NUMBER
    IS
       l_int_ok   NUMBER := 0;
    BEGIN
       bars_audit.info('CP:f_check_int p_acc =' || to_char(p_acc) ||', p_dat='|| to_char(p_dat,'dd.mm.yyyy'));
       BEGIN
          SELECT 1
            INTO l_int_ok
            FROM int_accn
           WHERE acc = p_acc AND id = 0 AND acr_dat = p_dat-1;
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN l_int_ok := 0;
       END;
       bars_audit.trace('CP:f_check_int('||to_char(p_acc)||'==>'||to_char(p_dat,'dd.mm.yyyy')||') result = '||to_char(l_int_ok));
       RETURN l_int_ok;
    END;

BEGIN
   -- отбор непогаш. купонных ЦБ для пересмотра купонного периода и,
   -- возможно, установки новой суммы фиксированного купона
   delete cp_dok_dnk;
   bars_audit.trace('DOK_DNK starts, DAT_ = '||to_char(DAT_,'dd/mm/yyyy'));
   FOR k
      IN (SELECT n.ID,
                 n.DOK,
                 n.DNK,
                 e.acc,
                 e.accr,
                 e.ACCR2,
                 e.REF,
                 o.cp_ID, o.metr,
                 (a.ostc / 100) / o.cena KOL,
                 (select ir from cp_dat where dok = n.dnk and id = e.id) ir
            FROM cp_deal e,
                 accounts a,
                 cp_kod o,
                 (  SELECT id,
                           MAX (TO_DATE (iif_d (dok, DATN_, dok, dok, NULL))) DOK,
                           MIN (TO_DATE (iif_d (dok, DATN_, NULL, NULL, dok))) DNK
                      FROM cp_dat
                  GROUP BY id) n
           WHERE     e.id = n.ID
                 AND e.acc = a.ACC
                 AND a.ostc <> 0
                 AND e.accr IS NOT NULL
                 AND n.DOK < DATN_
                 AND DATN_ < n.DNK
                 AND o.id = e.ID
                 AND (o.DOK IS NULL AND n.DOK IS NOT NULL OR o.DOK < n.DOK))
   LOOP
    bars_audit.trace('CP: k.id = '|| to_char(k.id));
    BEGIN
       -- фиксированный купон ?
       SELECT kup
         INTO kup_
         FROM cp_dat
        WHERE id = k.id
          AND dok = k.DNK;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN kup_ := NULL;
    END;

    BEGIN
       SELECT -ostc / 100, accc
         INTO OSTC_, Accc_r
         FROM accounts
        WHERE acc = k.ACCR;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN OSTC_ := 0;
    END;

    BEGIN
       SELECT -OSTC / 100, ACCC
         INTO OSTC_R2, ACCC_R2
         FROM ACCOUNTS
        WHERE ACC = K.ACCR2;
    EXCEPTION WHEN NO_DATA_FOUND
              THEN OSTC_R2 := 0;
    END;

    l_check := f_check_R(k.id);
    l_int := f_check_int(k.acc, k.DOK);

    IF ((OSTC_ <> 0) OR (OSTC_R2 <> 0)) and l_check = 0
    THEN
      begin
      SELECT nd
       INTO ND_
       FROM oper
      WHERE REF = k.REF;
      exception when no_data_found then ND_ := substr(to_char(k.ref),1,10);
      end;
      l_txt :=
      'CP.DOK_DNK: ЦП № ' || k.ID
                || ', iд.'            || k.CP_ID
                || ' DNK='            || k.DNK
                || ' Угода реф='      || k.REF
                || ', № '             || ND_
        || ' Змiна купонного перiоду, але нарах.купон НЕ погашено (НЕ обнулено)';

    logger.error (l_txt);
    begin
     insert into cp_dok_dnk(ID, CP_ID, CP_REF, DATE_RUN, DESCRIPTION)
     values (k.ID,k.CP_ID, k.REF, sysdate,l_txt);
    exception when others then bars_audit.error ('cp:cp_dok_dnk failed = '||sqlerrm);
    end;
    ELSE
        if l_int = 1
        then
         UPDATE cp_kod
            SET dok = k.dok, dnk = k.DNK, CENA_KUP = kup_
          WHERE id = k.ID;

         begin
          select ir
            into l_ir
            from cp_kod
           where id = k.id;
         exception when no_data_found then l_ir := null;
         end;
         bars_audit.trace('DOK_DNK: l_ir = ' || to_char(l_ir)||', k.ir=' || to_char(k.ir));

         if k.ir is not null and NBUBNK_ != 1 and nvl(l_ir,0) != k.ir
         then
           UPDATE cp_kod
              SET ir = k.ir
            WHERE id = k.ID;
         end if;

         IF gl.aMFO = '300465' AND accc_r IS NOT NULL
         THEN
            UPDATE accounts
               SET mdate = k.DNK
             WHERE acc = Accc_r;
         END IF;

         IF KUP_ > 0 and k.metr = 4
         THEN
            UPDATE accounts
               SET ostf = -k.KOL * KUP_ * 100, mdate = k.DNK - 1
             WHERE acc = k.accr;
         else
            UPDATE accounts SET mdate = k.DNK - 1
             WHERE acc = k.accr;
         END IF;
        l_txt := 'CP.DOK_DNK: ЦП № '  || k.ID
                    || ', iд.'            || k.CP_ID
                    || ' DNK='            || k.DNK
                    || ' Угода реф='      || k.REF
                    || ' Змiна купонного перiоду. Купон='    || -k.KOL * KUP_
                    || ' Пакет '          || ABS (k.KOL)     || ' шт.';
        logger.info (l_txt);
        begin
         insert into cp_dok_dnk(ID, CP_ID, CP_REF, DATE_RUN, DESCRIPTION)
         values (k.ID,k.CP_ID, k.REF, sysdate,l_txt);
        exception when others then bars_audit.error ('cp:cp_dok_dnk failed = '||sqlerrm);
        end;
        else
        l_txt :='CP.DOK_DNK: ЦП № '|| k.ID
                    || ', iд.'            || k.CP_ID
                    || ' DNK='            || k.DNK
                    || ' Угода реф='      || k.REF
            || ' Змiна купонного перiоду неможлива. Нарахуйте купон по дату закінчення купонного періоду';
          logger.info (l_txt);
        begin
         insert into cp_dok_dnk(ID, CP_ID, CP_REF, DATE_RUN, DESCRIPTION)
         values (k.ID,k.CP_ID, k.REF, sysdate,l_txt);
        exception when others then bars_audit.error ('cp:cp_dok_dnk failed = '||sqlerrm);
        end;
        end if;
    END IF;
   END LOOP;

   ---
   FOR k
      IN (SELECT e.accr
            FROM cp_deal e, saldoa s
           WHERE     e.accr IS NOT NULL
                 AND e.accr = s.acc
                 AND s.fdat = DAT_
                 AND s.ostf <> 0
                 AND s.ostf - s.dos + s.kos = 0)
   LOOP
      UPDATE accounts
         SET ostf = 0
       WHERE acc = k.ACCR and ostf <> 0;
   END LOOP;
END DOK_DNK;

PROCEDURE Cp_DEL(REF_ int) is
begin
  for k in (select a.acc, ostc, ostb, ostf, Nvl(d.accr,0) ACCR
            from cp_DEAL d, accounts a
            where d.ref=REF_ and a.acc in
            (d.acc,d.accd,d.accp,d.accr, d.accr2,d.accs)
            )
  loop
     If k.ostc <>0 or k.ostb<>0  OR (k.ACCR<>k.ACC and k.ostf<>0) then
        raise_application_error(-(20000+ern), '\ Ненулевые остатки !',TRUE);
     end if;

     update accounts set dazs=gl.BDATE, ostf=0 where acc=k.ACC;

  end loop;
  delete from cp_DEAL where ref=REF_;
end CP_DEL;
-----------
PROCEDURE Cp_Nomin(ACC_ int) is

begin

 begin
/*
 1 = Начислать купон на номинал всего пакета
 2 = Начислать купон на номинал 1 шт и умножать на кол-во в пакете
 null = по старому. т.е. для вал 1 = на номинал пакета
                         для грн 2 = на номинал 1 шт
 -- Нач купона : в вал от общ.суммы, в нац.вал - от номинала 1 шт
*/

   select DECODE(k.PR1_KUP, 1,0, 2,CENA, decode(k.kv,gl.baseval,CENA,0) )*100
   into acrN.cur_Nomin from cp_kod k, cp_deal d
   where d.id=k.id and d.acc=ACC_ and Nvl(cena,0) >0;
 EXCEPTION WHEN NO_DATA_FOUND THEN acrn.cur_Nomin:=null;
 end;

end Cp_Nomin;
-----------------------------------------------------------------------------
-- Cp_reg_ex
-- открытие счетов ценных бумаг, используя OP_REG_EX
-----------------------------------------------------------------------------
PROCEDURE Cp_reg_ex (mod_    IN     INTEGER,
                     p1_     IN     INTEGER,
                     p2_     IN     INTEGER,
                     p3_     IN     INTEGER,
                     p4_     IN OUT INTEGER,
                     rnk_    IN     INTEGER,
                     nls_    IN OUT VARCHAR2,
                     kv_     IN     SMALLINT,
                     nms_    IN     VARCHAR2,
                     tip_    IN     CHAR,
                     isp_    IN     SMALLINT,
                     accR_      OUT INTEGER)
IS
   pap_   ps.pap%type;
BEGIN
   nls_ := VKRZN (SUBSTR (gl.AMFO, 1, 5), nls_);
   OP_REG_EX (mod_,
              p1_,
              p2_,
              P3_,
              p4_,
              RNK_,
              nls_,
              kv_,
              NMS_,
              tip_,
              isp_,
              accR_,
              CP_PAY_);

   BEGIN
      SELECT pap
        INTO pap_
        FROM ps
       WHERE nbs = SUBSTR (nls_, 1, 4);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         pap_ := 3;
   END;

   UPDATE accounts
      SET pap = pap_
    WHERE acc = accR_;
END Cp_reg_ex;
-----------------------------------------------------------------------------

PROCEDURE CP_BASEY (ACC_ number, DAT_ date) is
  --переустановка базового года
begin
 begin
   select  k.KY * (k.DNK - NVL(k.DOK,k.DAT_EM) )
   into acrn.CUR_BASEY
   from cp_kod k, cp_deal d
   where d.id=k.id and d.acc=ACC_ and
         k.KY is not null and k.DNK is not null and
         NVL(k.DOK,k.DAT_EM) <=DAT_ and DAT_ <=k.DNK ;
 EXCEPTION WHEN NO_DATA_FOUND THEN acrn.CUR_BASEY:=null;
 end;
end CP_BASEY ;
-----------------

PROCEDURE CP_REE2 (CP_ID_ varchar2, sErr OUT varchar2) is
-- 08-09-2008 Sta синхр пл.инст депозитария для всех ЦБ по пар.NUll
 OKPO_ Varchar2(8);

begin
 for k in (select cp_id, mfo, okpo, nls from cp_ree2
           where (cp_id=CP_ID_ or CP_ID_ is null)
          )
 loop
    begin
      select  NLS, substr(OKPO,1,8) into NLS_, OKPO_
      from CP_ALIEN where mfo=k.MFO and kv=gl.baseval and rownum=1;

      --пополнение CP_REE2
      if k.okpo is null and OKPO_ is not null then
         update CP_REE2 set okpo=OKPO_ where mfo=k.MFO and cp_id=k.CP_ID;
      end if;
      if k.nls is null and NLS_ is not null then
         update CP_REE2 set nls=NLS_ where mfo=k.MFO and cp_id=k.CP_ID;
      end if;
    EXCEPTION WHEN NO_DATA_FOUND THEN
      --вставка в CP_ALIEN
      insert into CP_ALIEN (kv, mfo, okpo, nls, id,name)
      select gl.baseval, k.mfo, k.okpo, k.nls, S_CP_alien.NEXTVAL,
             substr(b.NB,1,35)
      from banks B where mfo=k.mfo;
    end;
 end loop;
 commit;
end CP_REE2;
-----------------------------------------------------------------------------
   -- PROCEDURE FXB()
   -- определение глобальных переменных пакеджа
   -- PAR      VAL   COMM
   -- FXB-1-0  FX7   Код оп FXB для ЦБ Других эм по нац.вал
   -- FXB-1-1  FX8   Код оп FXB для ЦБ Других эм по ИН.вал
   -- FXB-2-0  FX9   Код оп FXB для ЦБ СВОИХ  эм по НАЦ.вал
   -- FXB-2-1  FX0   Код оп FXB для ЦБ СВОИХ  эм по ИН.вал
-----------------------------------------------------------------------------
PROCEDURE FXB(KV_     IN  cur_rates.kv%type,
              TIPD_   IN  cp_kod.tip%type)
IS
   l_sErr   VARCHAR2 (200);
BEGIN
   BEGIN
      SELECT tt
        INTO FXB_
        FROM CP_tt
       WHERE     tip = kk.TIP
             AND kv = kk.KV
             AND SUBSTR (kk.cp_id, 1, 2) LIKE isin
             AND rez = DECODE (kk.country, 804, 1, 2);
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         IF kk.kv != 980 AND kk.country = 804 AND kk.cp_id LIKE 'UA%'
         THEN
            l_sErr := l_sErr || 'НЕ вказано код операції в CP_TT для вал. ОВДП';
            raise_application_error (-20203, l_sErr, TRUE);
         END IF;

         BEGIN
            SELECT SUBSTR (val, 1, 3)
              INTO FXB_
              FROM params
             WHERE par = 'FXB-' || TO_CHAR (TIPD_) || '-' || DECODE (KV_, gl.baseval, '0', '1');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN FXB_ := 'FXB';
         END;
   END;
END FXB;
-----------------------------------------------------------------------------
PROCEDURE F_REF(ref_ int, sREF1 varchar2, sREF2 OUT varchar2)
 is
begin

  if sREF1 is null then sREF2:=to_char(REF_);
  Else     sREF2:=sREF1 || ',' || to_char(REF_);
  end if;
end F_REF;
--------------------------------------

PROCEDURE CP_KUPON (TIPD_      IN     INT,
                    VOB_       IN     INT,
                    GRP_       IN     INT,
                    nID_       IN     INT,
                    nRYN_      IN     INT,
                    nVIDD_     IN     INT,
                    SUMK       IN     NUMBER,
                    SK_           OUT NUMBER,
                    B_4621     IN     VARCHAR2,
                    sREF          OUT VARCHAR2,
                    sErr          OUT VARCHAR2,
                    REF_MAIN      OUT INT)
IS
-- процедура разноски уплаченного купона
   KV_   int; CP_ID_ varchar2(20) ; EMI_ int  ; S_4621 varchar2(38);
   DK_   int; NAZN_  varchar2(160); VDAT_ date; SR_ number :=0;
   REF2_ int; NLS2_  varchar2(15) ; S2_ number; SS_ number :=0;
   REF_  int; NLS1_  varchar2(15) ; S1_ number; S_  number :=0;
   B_4621k varchar2(15);
   KUP_DATE_  date; -- дата погашения купона (при погашении купона после смены купонного периода и нового начисления)
   ACCR  NUMBER;
   ACCN  NUMBER;
   -- для обработки "кривого" купона
   NLS3_ accounts.nls%type;
   S3_   number := 0;
begin
 IO_:=0;

 begin /* транз. для рознесення купонів */
    SELECT TRIM (SUBSTR (val, 1, 15))
      INTO B_4621K
      FROM params
     WHERE par = 'CP_4621K' AND val IS NOT NULL;
 EXCEPTION WHEN NO_DATA_FOUND THEN  B_4621K :=B_4621;
 end;

 BEGIN
   sERR:='4.Нет ЦБ '||nID_;
    SELECT kv,
           cp_id,
           emi,
           CASE WHEN dnk >= gl.bDATE THEN dok-1 ELSE dnk-1 END
      INTO KV_,
           CP_ID_,
           EMI_,
           KUP_DATE_
      FROM cp_kod
     WHERE id = nID_;

   sERR:='5.Нет сч.тр. '||B_4621K;

    SELECT SUBSTR (nms, 1, 38)
      INTO S_4621
      FROM accounts
     WHERE kv = KV_ AND nls = B_4621K;
 EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN;
 END;

 select * into kk from cp_kod where id=nID_;
 cp.FXB(KV_,TIPD_);
 sERR:=NULL;

 If TIPD_ = 1 then NAZN_ :='Отриманий купон ЦП '||CP_ID_ ;
 else              NAZN_ :='Погашення нарахованого купону ЦП '||CP_ID_ ;
 end if;

 SK_    := SUMK * 100;
 DK_    := TIPD_ - 1;
 sREF   := null;
 if VOB_ = 96 then  VDAT_ := F_VDAT_ZO ( add_MONTHS(gl.BDATE, -1 ) );
 else               VDAT_ := gl.BDATE  ;
 end if;

 for k in
       (SELECT c.NLSR,
               r.acc                  ACC,
               SUBSTR (r.nms, 1, 38)  NMS,
               c.NLSR2,
               c.NLSR3,
               r2.acc                 ACC2,
               r3.acc                 ACC3,
               SUBSTR (r2.nms, 1, 38) NMS2,
               SUBSTR (r3.nms, 1, 38) NMS3,
               d.accR,
               d.accR2,
               d.accR3,
               d.REF
          FROM cp_accc c,
               accounts r,
               accounts r2,
               accounts r3,
               cp_deal D,
               accounts aM,
               accounts aD
         WHERE     aM.kv = KV_
               AND c.nlsA = aM.nls
               AND r.kv = aM.kv
               AND c.nlsR = r.nls
               AND r2.kv(+) = KV_
               AND r3.kv(+) = KV_
               AND c.nlsR2 = r2.nls(+)
               AND c.nlsR3 = r3.nls(+)
               AND c.emi = EMI_
               AND c.ryn = NVL (nRYN_, c.ryn)
               AND c.vidd = NVL (nVIDD_, c.vidd)
               AND D.id = nID_
               AND d.acc = aD.acc
               AND aD.accc = aM.acc)
 loop
    ----------- Накопичений (купленный)  купон
    if k.accR2 is not null or k.accR3 is not null
    then /* м.б. и отрицательный */
       begin
           SELECT nls,decode(TIPD_,1,-1,1)*ostc
             INTO NLS2_,S2_
             FROM accounts
            WHERE acc=k.accR2;
       exception when no_data_found then NLS2_:= null; S2_ := 0;
       end;

       begin
           SELECT nls,decode(TIPD_,1,-1,1)*ostc
             INTO NLS3_,S3_
             FROM accounts
            WHERE acc=k.accR3;
       exception when no_data_found then NLS3_:= null; S3_ := 0;
       end;

       If S2_ > 0 and S2_ > SK_
       then  S2_:= SK_;
       end if;

       If S3_ > 0 and S3_ > SK_
       then  S3_:= SK_;
       end if;

       If (S2_ <> 0 or S3_ <> 0) AND (SK_ > 0 or S2_ <0 or S3_ <0 ) then
          if SS_ = 0 then
             GL.REF (REF2_); F_REF(REF2_,sREF, sREF);
             begin
              insert into cp_payments(cp_ref, op_ref)
              values (k.ref, REF2_);
             exception when others then null;
             end;

             GL.in_doc3  (ref_  => REF2_, tt_   => FXB_,   vob_ => nvl(vob_, 6)    , nd_   => substr(to_char(REF2_),1,10),pdat_=> sysdate,
                          vdat_ => vdat_, dk_   => DK_ ,   kv_  => kv_     , s_    => s_,      kv2_   => kv_,      s2_ => S_,
                          sk_   => null , data_ => greatest(VDAT_,gl.bDATE), datp_ => gl.bdate,
                          nam_a_=> coalesce(k.NMS2,k.NMS3),
                          nlsa_ => coalesce(k.NLSR2,k.NLSR3),
                          mfoa_ => gl.AMFO , nam_b_ => S_4621, nlsb_ => B_4621K,  mfob_ => gl.AMFO,
                          nazn_ => NAZN_, d_rec_=> null,   id_a_ => gl.aOKPO, id_b_ => gl.aOKPO, id_o_ => null,
                          sign_ => GetAutoSign, sos_  => 1   , prty_ => null ,  uid_  => null );
          end if;

          If S2_< 0 then  payTT ( 0,REF2_,VDAT_,FXB_,1-DK_,kv_,NLS2_,-S2_,kv_,B_4621K,-S2_);
          else            payTT ( 0,REF2_,VDAT_,FXB_,  DK_,kv_,NLS2_, S2_,kv_,B_4621K, S2_);
          end if;

          If S3_< 0 then  payTT ( 0,REF2_,VDAT_,FXB_,1-DK_,kv_,NLS3_,-S3_,kv_,B_4621K,-S3_);
          else            payTT ( 0,REF2_,VDAT_,FXB_,  DK_,kv_,NLS3_, S3_,kv_,B_4621K, S3_);
          end if;

          update opldok set txt = NAZN_ where ref = REF2_ and stmt = gl.ASTMT;
          SS_ := SS_ + S2_ + S3_;
          SK_ := SK_ - S2_ - S3_;
       end if;
    end if;

    -------- начисленный купон
    if SK_ > 0 and k.accR is not null then /* только полож */
     SELECT nls,least(decode(TIPD_,1,-1,1)*ostc ,SK_) into NLS1_,S1_ FROM accounts WHERE acc=k.accR;
     -- Подменяю реальный остаток начисленного купона на остаток на день планового погашения
     /* BEGIN
        SELECT NLS, ACC
          INTO NLS1_, ACCR
          FROM ACCOUNTS
         WHERE ACC = K.ACCR;
      EXCEPTION WHEN NO_DATA_FOUND THEN S1_ := 0;
                WHEN VALUE_ERROR   THEN S1_ := 0;
      END;

      BEGIN
        SELECT CD.ACC
          INTO ACCN
          FROM ACCOUNTS A, cp_deal cd
         WHERE a.acc = cd.acc
           AND cd.accr = K.ACCR;

       S1_ :=  LEAST(-CP.CP_REAL_INTDATE (ACCN, KUP_DATE_+1, TIPD_),SK_);
      EXCEPTION WHEN NO_DATA_FOUND THEN S1_ := 0;
                WHEN VALUE_ERROR   THEN S1_ := 0;
      END;*/
      BARS_AUDIT.INFO('Погашение купона бумаги: acc = '||TO_CHAR(ACCN));
      BARS_AUDIT.INFO('Погашение купона: acc = '||TO_CHAR(ACCR)||','||NLS1_||', s= '|| TO_CHAR(S1_)||' =>'||TO_CHAR(KUP_DATE_+1,'dd/mm/yyyy'));

       If S1_>0 then
          if S_ = 0 then
             GL.REF (REF_);  F_REF( REF_, sREF, sREF );
              begin
                 insert into cp_payments(cp_ref, op_ref)
                 values (k.ref, REF_);
               exception when others then null;
               end;
             GL.in_doc3  (ref_  =>REF_ , tt_   => FXB_,   vob_ =>nvl(vob_, 6)    , nd_   =>substr(to_char(REF_),1,10),pdat_=> sysdate,
                          vdat_ =>vdat_, dk_   => DK_ ,   kv_  =>kv_     , s_    =>s_,      kv2_  =>kv_,      s2_ => S_,
                          sk_   =>null , data_ =>greatest(VDAT_,gl.bDATE), datp_ =>gl.bdate,
                          nam_a_=>k.NMS, nlsa_ => k.NLSR, mfoa_=>gl.AMFO , nam_b_=>S_4621  , nlsb_=>B_4621K,  mfob_=> gl.AMFO,
                          nazn_ =>NAZN_, d_rec_=> null,   id_a_=>gl.aOKPO, id_b_ =>gl.aOKPO, id_o_=>null,     sign_=> GetAutoSign,
                          sos_  => 1   , prty_ => null,   uid_ => null ) ;
          end if;
          payTT(0,REF_,VDAT_,FXB_,DK_,kv_,NLS1_,S1_,kv_,B_4621K,S1_);
          update opldok set txt=NAZN_ where ref=REF_ and stmt=gl.ASTMT;
          S_ := S_ + S1_;
          SK_:= SK_ - S1_;
          update int_accn set APL_DAT=KUP_DATE_ where acra=k.accR and id=0;
       end if;
    end if;
 end loop;

 If SS_ <>0      then update oper set s=Abs(SS_),s2=Abs(SS_) where ref=REF2_; SR_:=SR_+SS_; end if;
 If S_   >0      then update oper set s=S_      ,s2=S_       where ref=REF_ ; SR_:=SR_+S_ ; end if;
 if REF_ is null then REF_ :=REF2_ ;                                                        end if;
 if REF_ is null then sERR := '6.Нет купл/нач.остатков'; RETURN;                            end if;

 REF_MAIN:= REF_;
 -- купон (выплатить по своим или принять погашение по чужим)OP = 4
 INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,R,STR_REF,OP) values (Ref_,nID_,gl.BDATE,gl.BDATE,gl.BDATE,SR_,sREF,4);

end CP_KUPON;
-----------------------

PROCEDURE CP_MOVE
 ( GRP_   IN  int, VOB_ int,
   nID_   IN  int,
   nRYN1_ IN  int,
   nNBS1_ IN  int,
   nRYN2_ IN  int,
   nNBS2_ IN  int,
   SUMN   IN  number,
   nREF_  IN  int,
   NAZN_  IN  varchar2,
   B_4621 IN  varchar2,
   sREF   OUT varchar2,
   sErr   OUT varchar2,
   REF_MAIN OUT int ) is

-- процедура перемещения между портфелями nNBS1_+nRYN1_ =>nNBS2_+nRYN2_

 accD_  int     ;   acc_  int        ; accR_ int    ; accP_  int        ;
 accR6_ int     ;   r1_    int       ; accR2_ int   ; erat_       number     :=0 ;
 accS_  NUMBER  ;                      nlss_ accounts.nls%type;
 accS5_ NUMBER  ; S5_ number         ; nlss5_ accounts.nls%type;
 accS6_  NUMBER ; S6_ number         ; nlss6_ accounts.nls%type;
 accR9_ int;
 accN_exp int;
 accRD_ number;
 accS2_ number;


 ACRB_D int     ;   ACRB_P int    ;    REF_  int         ; NLS_FXP_1 varchar2(15) ;
 N_  number   ; S_     number     ; NLS_FXP_2 varchar2(15) ;
 CENA_KUP_   number     ;

 OSTSQ_ number          ;
 NLSGA_ varchar2(15)                 ; accc_ int    ; sQ_ NUMBER :=0    ; NMS_   varchar2(38)    ;
 DK_   int      ; S_4621 varchar2(38); TTV_ char(3) ; VDAT_  date       ; SSQ_   number          :=0;
 RNK1_ int      ;

 DAT_0101 date  := to_date('0101'||to_char(gl.bdate,'yyyy'), 'DDMMYYYY');
 cp_id_r varchar2(20)   ;
 l_stmt int :=0 ;
 -- вирт Д/П
 VD_ number     ; VP_ number  ; VDP_ number  ; NLSV_ accounts.NLS%type;  acc_2vd  accounts.ACC%type; acc_2vp  accounts.ACC%type;
 pr1_kup_ cp_kod.pr1_kup%type;

-- суми до перемищення
 SN_ number;  --  сума по рах-х N
 SD_ number;  --  сума по рах-х D
 SP_ number;  --  сума по рах-х P
 SR_ number;  --  сума по рах-х R
 SR2_ number; --  сума по рах-х R2
 SS_ number;  --  сума по рах-х S
 SR9_ number; --  сума по рах-х R9  Expiry
 SN_exp number;  --  сума по рах-х N expiry

 NN_ number;  -- заявлена сума N на перем?щення
 DP_    number     ;

 NO_P_    cp_pf.NO_P%type ;
 NO_A_    cp_pf.NO_A%type ;

 ac2 cp_accc%rowtype  ; -- принимающий суб.пф
 --kk  cp_kod%rowtype   ; -- Опись ЦБ ! global
 aa  accounts%rowtype ;
 l_init_ref cp_deal.initial_ref%type;
 l_dat_bay date;
 r_refw cp_refw%rowtype;  fl_m int :=0;

PROCEDURE INS_CP_ACCOUNTS
     (p_ref int, p_type varchar2, p_acc int, p_ostc number default 0, p_ostcr number default 0) is
begin
   begin
   insert into cp_accounts (cp_ref,cp_acctype,cp_acc,ostc,ostcr)
   values
   (p_ref,p_type,p_acc, nvl(p_ostc,0), nvl(p_ostcr,0));
   exception when dup_val_on_index then null;
          --   when others then null;
          --   LOG(' CP_MOVE. проблема запису в CP_ACCOUNTS ref='||p_ref||' type='||p_type,'ERROR');
   end;
end INS_CP_ACCOUNTS;

begin
  IO_ :=0;  cp_id_r:='';

  begin
    BARS_Audit.info('CP.CP_MOVE:nID_ = ' || nID_ ||'nNBS2_ = ' || nNBS2_|| ' nRYN2_=' || nRYN2_);
    sERR   :='7.Нет в PARAMS RNK_CP'  ; select to_number(val) into RNK1_ from params  where par = 'RNK_CP' ;
    sERR   :='8.Нет ЦБ '||nID_        ;
    select *  into kk    from cp_kod  where id  = nID_ ;
    BARS_Audit.info('nNBS2_ = ' || nNBS2_ || ' nRYN2_=' || nRYN2_);
    select *  into ac2   from cp_accc where vidd=nNBS2_ and RYN=nRYN2_ and emi=kk.EMI;

    kk.ir  := nvl(kk.ir ,0);            kk.basey := nvl(kk.basey   ,0) ;
    kk.rnk   := NVL(kk.rnk,RNK1_);
    kk.dnk := nvl(kk.dNk,kk.DATp)     ; CENA_KUP_:= NVL(kk.CENA_KUP,0) / kk.cena  ;
    if kk.metr = 23 then kk.metr := 8 ;
    else                 kk.metr := nvl(kk.metr,0);
    end if ;

    if kk.pr1_kup is null then
       if kk.kv = gl.baseval then pr1_kup_ := 2  ;
       else                       pr1_kup_ := 1  ;
       end if;
    else                          pr1_kup_ := kk.pr1_kup;
    end if;

    sERR:='9.Нет сч.транзита '||B_4621;
    select substr(nms,1,38) into S_4621 from accounts where  kv=kk.KV and nls=B_4621;
    -- Характеристики портфеля
    select nvl(no_p,0), nvl(no_a,0) into no_p_,no_a_ from  cp_pf where pf = ac2.pf;
    If NO_A_ <>1 then
       sERR:='10.Нет сч.дох. по амортиз. Диск.,Прем.(CP_ACCC)';

       select ad.acc, ap.acc into   ACRB_D, ACRB_P  from accounts aD, accounts aP
       where aD.kv = gl.baseval and aD.nls=ac2.s605 and aP.kv = gl.baseval and aP.nls = ac2.s605P ;
       NLS_FXP_2 := ac2.NLS_FXP ;
       NLS_FXP_1 := ac2.NLS_FXP ;
    end if;
  EXCEPTION WHEN NO_DATA_FOUND THEN  RETURN;
  end;

  VDAT_:=gl.BDATE;
  if VOB_ = 96 then   VDAT_:= F_VDAT_ZO( add_MONTHS(gl.BDATE, -1 ) ); end if;

  sERR:=NULL;

  cp.FXB(kk.KV, kk.TIP );

  SN_:=SUMN * 100;
  SD_:=0 ; SP_:=0; SR_:=0; SR2_:=0; SS_:=0; sERR:=Null; sREF:=Null;  VD_:=0 ; VP_:=0; s5_:= 0; s6_:=0;
  SR9_:=0;  SN_exp:=0;

  GL.REF (REF_);  REF_MAIN:= REF_;  F_REF( REF_, sREF, sREF );
               begin
                 insert into cp_payments(cp_ref, op_ref)
                 values (REF_MAIN, REF_);
               exception when others then null;
               end;
  s8_:= substr('000000000'|| REF_CP_NBU(REF_), -8 );
  -- а-ля продать без торг.результата

  begin
  /*select a.NLS,  substr(a.nms,1,38)   into NLSGA_, NMS_  from cp_accC c,  accounts a
    where c.vidd=nNBS1_ and c.ryn=nRYN1_ and a.nls=c.nlsA and c.emi= kk.EMI  AND A.KV=kk.KV ;*/
    SELECT a.NLS, SUBSTR (a.nms, 1, 38)
      INTO NLSGA_, NMS_
      FROM accounts a
     WHERE (nbs, nls) = (SELECT SUBSTR (nlsA, 1, 4), nlsA
                           FROM cp_accC c
                          WHERE c.vidd = nNBS1_ AND c.ryn = nRYN1_ AND c.emi =  kk.EMI)
       AND A.KV = kk.KV;
  EXCEPTION WHEN NO_DATA_FOUND THEN sERR:='11.Нет осн.сч.ВХ в ФУ'; RETURN;
  END;

  INSERT INTO oper (ref,tt,vob,nd,dk,PDAT,VDAT,DATD, DATP, nam_a,nlsa,mfoa,kv,s,nam_b,nlsb,mfob,kv2,s2,nazn,userid,sign,id_a,id_b)
  VALUES (ref_,FXB_,nvl(VOB_, 6),substr(ref_,1,10),0, sysdate, VDAT_, greatest(VDAT_,gl.bDATE), gl.bDATE,NMS_,   NLSGA_,gl.AMFO,kk.KV,SN_,
     S_4621,  B_4621,  gl.AMFO,kk.KV,SN_,NAZN_,gl.aUid, GetAutoSign, gl.aOkpo, gl.aOkpo );
  NN_:= SN_;

  If NLSGA_ like '899%' then   update oper set nlsb=CP_nls8_ where ref=REF_; end if;

    LOG('CP_MOVE: Глоб. пар-р CP_MV_RAT ='||l_CP_MVRAT,'TRACE',5);
    logger.info('CP.CP_MOVE: REF '||nREF_||' -> '||ref_);
  SSQ_:=0;
  for k in (select a.acc, e.ref, a.nls NLSA,  -a.ostb OSTA,
                   d.nls NLSD,  nvl( d.ostb,0) OSTD ,
                   p.nls NLSP, -nvl( p.ostb,0) OSTP,
                   r.nls NLSR, -nvl( r.ostb,0) OSTR ,
                   r2.nls NLSR2,-nvl(r2.ostb,0) OSTR2,
                   s.nls NLSS,  nvl( s.ostb,0) OSTS ,
                   r9.nls NLSR9, -nvl( r9.ostb,0) OSTR9,
                   n_exp.nls NLSN_exp, -nvl( n_exp.ostb,0) OSTN_exp,
                   s.daos DAOSS, s.acc ACCS,  nvl( s.ostQ,0) OSTSQ,
                   e.ACCS5,  -- НБУ.Доч.счет 5121.
                   e.ACCS6,   -- НБУ.Доч.счет 6300.
                   e.ERAT, e.op, decode(e.op,3,e.initial_ref,e.ref) initial_ref,
                   rownum, --e.dat_bay
                   decode(e.op,3,e.dat_bay,e.dat_ug) dat_bay
            from cp_deal  e, accounts a , accounts d, accounts p,
                 accounts r, accounts r2, accounts s, accounts r9, accounts N_EXP
            where e.id=nID_ and
                  nNBS1_ in (substr(          a.nls ,1,4),
                             substr(NVL(p.nls,a.nls),1,4),
                             substr(NVL(d.nls,a.nls),1,4)) and
                  e.ryn  = nRYN1_ and
                  a.acc  = e.acc  and e.accs    = s.acc (+) and
                  e.accd = d.acc (+) and e.accp = p.acc (+) and
                  e.accr = r.acc (+) and e.accr2=r2.acc (+) and
                  a.ostb < 0
                  and active=1
             and e.accexpr = r9.acc (+) and e.accexpn=N_EXP.acc (+)
             and (nREF_ is null OR    nREF_ =e.REF)
            order by e.ref)
  loop

     fl_m:=fl_m+1;

     if NN_ >0 then
        -- сворачивание номинала
        if k.rownum=1 then l_init_ref:=k.initial_ref;
           l_dat_bay:=k.dat_bay;
        end if;
        N_ := least(NN_, k.OSTA);
        If k.NLSA NOT like '899%' then   payTT(0,REF_,VDAT_,FXB_,0,kk.KV,k.NLSA,N_,kk.KV, B_4621, N_);
        else                             payTT(0,REF_,VDAT_,FXB_,0,kk.KV,k.NLSA,N_,kk.KV,CP_nls8_,N_);
        end if;
        update opldok set txt=sNOMINAL where ref=REF_ and stmt=gl.ASTMT;
        NN_:= NN_ - N_;
        cp.RMany_DAT(k.REF, ref_, VDAT_,N_, 0 );
       -- cp.RMany_DAT(REF_, ref_, VDAT_,N_, 0 );

        if kk.DOX =1 then
           --акции
           S_:= (k.erat/k.OSTA)*N_;
           update cp_deal set erat=erat - S_ where ref=k.ref;
           ERAT_:= ERAT_ + S_;
        end if;

        if k.ACCS5 is not null then
           --свернуть и накопить ост. 5121
           select  * into aa from accounts where acc = k.ACCS5 ;
           S_  :=  round ( (aa.ostc /k.OSTA) * N_, 0);
           s5_ :=  s5_ + s_;
           If aa.ostc > 0 then dk_  := 1 ; else dk_ :=0 ; s_ := - s_;  end if;
           payTT(0,ref_,VDAT_,FXB_, dk_ , aa.kv ,aa.NLS, S_ , aa.KV , B_4621 , S_ );
        end if;

        if k.ACCS6 is not null then
           --свернуть и накопить ост.6300
           select  * into aa from accounts where acc = k.ACCS6 ;
           S_  :=  round ( (aa.ostc /k.OSTA) * N_, 0);
           s6_ :=  s6_ + s_;
           If aa.ostc > 0 then dk_  := 1 ; else dk_ :=0 ; s_ := - s_;  end if;
           payTT( 0, ref_, VDAT_, FXB_, dk_ , aa.kv ,aa.NLS, S_ , aa.KV , B_4621 , S_ );
        end if;


        if k.OSTS <>0 then /* сворачивание переоценки */
           S_  := round( (k.OSTS /k.OSTA)*N_, 0) ; -- номинал
           -- 27.03.2008 + 22.07.2010 +17.04.2002  -- перенос переоценки
           DAT_0101 := to_date('0101'||to_char(gl.bdate,'yyyy'), 'DDMMYYYY');
           select Nvl(sum(decode(o.dk,0,-1,+1)*o.sq),0)   into OSTSQ_
           from opldok o, oper p
           where p.ref = o.ref  and p.vdat > DAT_0101  and o.tt in ('FXP','FXX','096')
             and ( acc = k.ACCS OR
                   acc = (select o.accs from cp_deal o, cp_deal n  where n.REF = k.REF and o.REF = n.REF_OLD )
                 );

           SQ_ := round( (OSTSQ_/k.OSTA)*N_, 0) ; -- истор.экв.
           If SQ_<>0 then
              If SQ_ > 0 then Dk_:=0;
              Else            DK_:=1;
              end if;
              l_stmt  := l_stmt + 1 ;
              SSQ_:= SSQ_ + SQ_;
            end if;

           SS_ := SS_ + S_;
           S_  := ABS(S_) ;
           If  k.OSTS <0 then DK_:=0; else DK_:=1; end if;
           payTT(0,ref_,VDAT_,FXB_,DK_,kk.KV,k.NLSS,S_,kk.KV,B_4621,S_);
           update opldok set txt=decode (DK_,1,sPEREOV, sPEREOP )  where ref=REF_ and stmt=gl.ASTMT;
        end if;

        if k.OSTD >0 then /* сворачивание дисконта */
           S_:= round( (k.OSTD /k.OSTA)*N_, 0) ;
           payTT(0,ref_,VDAT_,FXB_,1,kk.KV,k.NLSD,S_,kk.KV,B_4621,S_);
           update opldok set txt=sDISKONT where ref=REF_ and stmt=gl.ASTMT;
           SD_:=SD_ + S_;
        end if;

        begin
           -- вирт дисконт в удельном весе
           select ostb, nls into S_, NLSV_ from cp_ref_acc r, accounts a  where r.ref=k.ref and r.acc=a.acc and a.tip='2VD' and a.ostB>0;
           S_:= round( (S_ /k.OSTA)*N_, 0) ;
           payTT(0,ref_,VDAT_,FXB_,1,kk.KV,NLSV_,S_,kk.KV,B_4621,S_);
           update opldok set txt='2VD:'||sDISKONT where ref=REF_ and stmt=gl.ASTMT;
           VD_:=VD_ + S_;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end;

        if k.OSTP >0 then /* сворачивание премии */
           S_:= round( (k.OSTP /k.OSTA)*N_, 0) ;
           payTT(0,ref_,VDAT_,FXB_,0,kk.KV,k.NLSP,S_,kk.KV,B_4621,S_);
           update opldok set txt=sPREMIA where ref=REF_ and stmt=gl.ASTMT;
           SP_:=SP_ + S_ ;
        end if;

        begin
           -- вирт прем в удельном весе
           select -ostb, nls into S_, NLSV_ from cp_ref_acc r, accounts a  where r.ref=k.ref and r.acc=a.acc and a.tip='2VP' and a.ostB<0;
           S_:= round( (S_ /k.OSTA)*N_, 0) ;
           payTT(0,ref_,VDAT_,FXB_,0,kk.KV,NLSV_,S_,kk.KV,B_4621,S_);
           update opldok set txt='2VP:'||sPREMIA where ref=REF_ and stmt=gl.ASTMT;
           VP_:=VP_ + S_ ;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end;

           if k.OSTN_exp >0 then /* сворачивание простр. N */
              S_:= round( (k.OSTN_exp /k.OSTA)*N_, 0) ;
              payTT(0,ref_,VDAT_,FXB_,0,kk.KV,k.NLSN_exp,S_,kk.KV,B_4621,S_);
              update opldok set txt=sNOMINAL_exp where ref=REF_ and stmt=gl.ASTMT;
              cp.RMany_DAT(k.REF, REF_,VDAT_,0, S_ );
              SN_exp:=SN_exp + S_;
           end if;


        If kk.DOX >= 2 then
           if k.OSTR >0 then /* сворачивание нач купона */
              S_:= round( (k.OSTR /k.OSTA)*N_, 0) ;
              payTT(0,ref_,VDAT_,FXB_,0,kk.KV,k.NLSR,S_,kk.KV,B_4621,S_);
              update opldok set txt=sKUPON where ref=REF_ and stmt=gl.ASTMT;
              cp.RMany_DAT(k.REF,REF_, VDAT_,0, S_ );
              SR_:=SR_ + S_;
           end if;
           if k.OSTR2 >0 then /* сворачивание накоп купона */
              S_:= round( (k.OSTR2 /k.OSTA)*N_, 0) ;
              payTT(0,ref_,VDAT_,FXB_,0,kk.KV,k.NLSR2,S_,kk.KV,B_4621,S_);
              update opldok set txt=sKUPON2 where ref=REF_ and stmt=gl.ASTMT;
              cp.RMany_DAT(k.REF, REF_,VDAT_,0, S_ );
              SR2_:=SR2_ + S_;
           end if;

           if k.OSTR9 >0 then /* сворачивание простр. купона */
              S_:= round( (k.OSTR9 /k.OSTA)*N_, 0) ;
              payTT(0,ref_,VDAT_,FXB_,0,kk.KV,k.NLSR9,S_,kk.KV,B_4621,S_);
              update opldok set txt=sKUPON9 where ref=REF_ and stmt=gl.ASTMT;
              cp.RMany_DAT(k.REF, REF_,VDAT_,0, S_ );
              SR9_:=SR9_ + S_;
           end if;

        end if;
     end if;

  If NN_ >0 then     sERR:='12.Нет нужной суммы номинала'; RETURN;
  end if;

  ---- а-ля купить в новую кучку / открыть всю толпу нужных счетов
  cp_id_r:=null;
  if gl.AMFO in ('300001') or l_mfou='300465' then
     cp_id_r := kk.cp_id||'/' ;
  end if;

  begin /* открыть сч номинала */
    select acc, substr(nls,1,5)||'0'||s8_, substr(cp_id_r||nms,1,38) into accc_,NLS_,NMS_ from accounts where nls=ac2.nlsA and kv=kk.KV;
  EXCEPTION WHEN NO_DATA_FOUND THEN    sERR:='13.Нет осн.сч. ИСХ в ФУ'; return;
  END;

  -- A) раскрыть номинал
  cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK, NLS_,kk.KV,NMS_,'ODB',gl.aUid,acc_);
  UPDATE accounts SET mdate=kk.DATP,accc=ACCC_, seci=4, pos=1, daos=VDAT_, pap=3  WHERE acc=acc_;

  cp_inherit_specparam (acc_, accc_, 0);

  If NLS_ NOT like '899%' then     payTT(0,ref_,VDAT_,FXB_,1,kk.KV,nls_,SN_,kk.KV,B_4621,SN_);
  else                             payTT(0,ref_,VDAT_,FXB_,1,kk.KV,nls_,SN_,kk.KV,CP_nls8_,SN_);
  end if;
  update opldok set txt=sNOMINAL where ref=REF_ and stmt=gl.ASTMT;

  -- R)раскрыть Купон нарахований
  IO_:= 0;
  If kk.DOX >= 2 then
     if kk.ir >0 then

        begin /* открыть сч зачислять начисленный % */
            SELECT a.acc,
                   SUBSTR (a.nls, 1, 5) || '0' || S8_,
                   SUBSTR (cp_id_r || a.nms, 1, 38),
                   a6.acc,
                   DECODE (kk.KV, gl.baseval, p.TT, p.TTV),
                   NVL (p.io, 0)                              --nvl( kk.io, NVL(p.io,0) )   --  6/08-14
              INTO accc_, NLS_, NMS_, accR6_, TTV_, IO_
              FROM accounts a, ACCOUNTS A6, proc_dr$base p
             WHERE     a.nls = ac2.nlsR
                   AND a.kv = kk.KV
                   AND a6.kv = gl.baseval
                   AND a6.nls = ac2.NLS_PR
                   AND p.nbs = ac2.vidd
                   AND ROWNUM = 1;
        EXCEPTION WHEN NO_DATA_FOUND THEN
            sERR:='14.Нет сч.купона ИСХ в ФУ або ?PROC_DR'; return;
        END;

        cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,NLS_,kk.KV,NMS_,'ODB',gl.aUid,accR_);
        UPDATE accounts SET mdate= kk.DNK-1,accc=ACCC_, seci=4,daos=VDAT_, pos=1 WHERE acc=accR_;

        cp_inherit_specparam (accR_, accc_, 0);

        if CENA_KUP_ >0 and l_mfou in ('300465') and kk.metr=4  then
           UPDATE accounts SET OSTF=CENA_KUP_ WHERE acc  = accR_;
           insert into int_accn (acc  ,id,acra ,acrb  ,metr,tt             ,BASEY   ,FREQ, ACR_DAT       , io)
                         values (accR_,1 ,accR_,accR6_,4   ,NVL(TTV_,'FX%'),kk.BASEY,1   , gl.BDATE-1+IO_, IO_);
        else
            INSERT INTO int_accn (acc, id, acra, acrb, metr, tt, BASEY, FREQ, ACR_DAT, STP_DAT, IO)
                 VALUES (acc_, 0, accR_, accR6_, iif_n (pr1_kup_,2,kk.metr,8,kk.metr), NVL (TTV_, 'FX%'), kk.BASEY, 1, gl.BDATE - 1 + IO_, kk.DATP - 1, IO_);

            INSERT INTO int_ratn (ACC, ID, BDAT, IR)
                 VALUES (acc_, 0, gl.bdate, kk.ir);
        end if;

        if SR_>0 then
           gl.payv(0,ref_,VDAT_,FXB_,1,kk.KV,NLS_,SR_,kk.KV ,B_4621,SR_);
           update opldok set txt=sKUPON where ref=REF_ and stmt=gl.ASTMT;
        end if;
     end if;
     --R2) Купон накопичений
     bars_Audit.info('CP.CP_MOVE: 16.' || ac2.nlsR2 || 'kk.KV='|| to_char( kk.KV));
     if SR2_ >0 then
        begin
        SELECT acc, SUBSTR (cp_id_r || nms, 1, 38), SUBSTR (nls, 1, 5) || '2' || S8_
          INTO accc_, NMS_, NLS_
          FROM accounts
         WHERE nls = ac2.nlsR2 AND kv = kk.KV;
        EXCEPTION WHEN NO_DATA_FOUND THEN sERR:='16.Нет сч.купона-2 ИСХ в ФУ'; return;
        END;
        cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_, kk.KV ,NMS_,'ODB',gl.aUid,accR2_);
        UPDATE accounts SET mdate= kk.DNK-1,accc=ACCC_,seci=4,daos=VDAT_, pos=1 WHERE acc=accR2_;

        cp_inherit_specparam (accR2_, accc_, 0);

        payTT(0,ref_,VDAT_,FXB_,1, kk.KV ,NLS_,SR2_ , kk.KV ,B_4621, SR2_ );
        update opldok set txt=sKUPON2 where ref=REF_ and stmt=gl.ASTMT;
     end if;
     bars_Audit.info('CP.CP_MOVE: 16a. ac2.nlsexpR=' || ac2.nlsexpR || ', kk.KV='|| to_char( kk.KV));
     --R9) Купон прострочений
     if SR9_ >0 then
        begin
         select acc,  substr(cp_id_r||nms,1,38),  substr(nls,1,5) ||'2'||S8_
           into accc_, NMS_, NLS_
           from accounts
          where nls = ac2.nlsexpR
            and kv= kk.KV;
        EXCEPTION WHEN NO_DATA_FOUND THEN sERR:='16a.Нет сч.купона-9 ИСХ в ФУ'; return;
        END;
        cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_, kk.KV ,NMS_,'ODB',gl.aUid, accR9_);
        UPDATE accounts
           SET mdate = kk.DNK-1,
               accc = ACCC_,
               seci = 4,
               daos = VDAT_,
               pos = 1
         WHERE acc = accR9_;

         cp_inherit_specparam (accR9_, accc_, 0);

        payTT(0,ref_,VDAT_,FXB_,1, kk.KV ,NLS_,SR9_ , kk.KV ,B_4621, SR9_ );
        update opldok set txt=sKUPON9 where ref=REF_ and stmt=gl.ASTMT;
     end if;
  end if;

  -- SS) Если есть переоценка в принимающей стороне
  accS_ := null;
  If ac2.NLSS is not null and no_p_ <>1 then /* сч.переоценки */
     --1305, 1315
     begin
        SELECT acc, SUBSTR (nls, 1, 5) || '0' || S8_, SUBSTR (cp_id_r || nms, 1, 38)
          INTO accc_, NLSS_, NMS_
          FROM accounts
         WHERE nls = ac2.NLSS AND kv = kk.KV;
     EXCEPTION WHEN NO_DATA_FOUND THEN sERR:='1.CP_MOVE:Нет сч.переоценки ИСХ в ФУ'; return;
     END;
     cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nlss_, kk.KV ,NMS_,'ODB',gl.aUid,accS_);
     UPDATE accounts SET mdate=kk.DATP,accc=ACCC_,seci=4,daos=VDAT_,pos=1      WHERE acc=accS_;
     cp_inherit_specparam (accS_, accc_, 0);
  end if;

/*
Если перемещаем с портфеля, который имеет счет реальной переоценки S (1305/1315) в
портфель который не имеет счет реальной переоценки S (1305/1315)

1. FROM S5<>0, S6<>0  TO  S5<>0, S6<>0     (   открываем S5 и S6)
2. FROM S5 =0, S6<>0  TO  S5 =0, S6<>0     (   открываем S5 и S6)
3. FROM S5<>0, S6 =0  TO  S5<>0            (   открываем S5     )
4. FROM S5 =0, S6 =0  TO                   (не открываем        )

Если перемещаем с портфеля, который не имеет счет реальной переоценки S (1305/1315) в
портфель который имеет счет реальной переоценки S (1305/1315): открываем счета S, S5, S6
*/

  --5121) НБУ.NLSS5 Род.счет 5121.
  If ac2.NLSS5 is not null and ( s5_ <> 0 or s6_ <> 0 or accS_ is not null ) then
     begin
        SELECT acc, SUBSTR (cp_id_r || nms, 1, 38), SUBSTR (nls, 1, 5) || '0' || s8_
          INTO accc_, NMS_, NLS_
          FROM accounts
         WHERE nls = ac2.NLSS5 AND kv = gl.baseval;
       cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_,gl.baseval,NMS_,'ODB', gl.aUid,accS5_);
       UPDATE accounts SET mdate=kk.DATP,accc=ACCC_,seci=4, pos=1, daos=VDAT_    WHERE acc=accS5_;
       --пербрось ост.
       if S5_ <> 0 then
          If s5_ > 0 then dk_  := 1 ; else dk_ :=0 ;  s5_ := - s5_; end if;
          payTT(0,ref_,VDAT_,FXB_, dk_ , gl.baseval ,B_4621, S5_, gl.baseval , nls_ , S5_ );
       end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN accS5_:=null; sERR:='34.CP_MOVE:Нет сч.NLSS5 Род.счет 5121';   return;
     END;
  end if;

  --6300 (6310) Рах.NLS_FXP~НЕреалiз.рез~переоц
  If ac2.NLS_FXP is not null and ( s6_ <> 0 or accS_ is not null )
                             and NBUBNK_ = 1 then
     begin
        SELECT acc, SUBSTR (cp_id_r || nms, 1, 38), SUBSTR (nls, 1, 5) || '0' || s8_
          INTO accc_, NMS_, NLS_
          FROM accounts
         WHERE nls = ac2.NLS_FXP AND kv = gl.baseval;
       cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_,gl.baseval,NMS_,'ODB',gl.aUid,accS6_);
       UPDATE accounts SET mdate=kk.DATP,accc=ACCC_,seci=4, pos=1, daos=VDAT_    WHERE acc=accS6_;

       --перебрось ост.
       if S6_ <> 0 then
          If s6_ > 0 then dk_  := 1 ; else dk_ :=0 ;  s6_ := - s6_; end if;
          payTT(0,ref_,VDAT_,FXB_, dk_ , gl.baseval ,B_4621, S6_, gl.baseval , nls_ , S6_ );
       end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN accS6_:=null;  sERR:='34.CP_MOVE:Нет сч. Рах.NLS_FXP~НЕреалiз.рез~переоц в ФУ';   return;
     END;
  end if;


  If (nNBS1_ = nNBS2_ or l_mfou ='300465')  and no_p_<>1 then
        /* между суб.портфелями внутри одного портфеля */
     -- переоценку переносим на переоценку
     If SS_ > 0 then    DK_:=0;
     else               DK_:=1;
     end if;
     S_:= Abs(SS_);
     if S_ !=0 then
     payTT(0,ref_,VDAT_,FXB_,DK_, kk.KV ,NLSS_,S_, kk.KV ,B_4621,S_);
     update opldok set txt=decode (DK_,0,sPEREOV, sPEREOP )  where ref=REF_ and stmt=gl.ASTMT;
     end if;

     If SSQ_ <>0               and
        NLS_FXP_2 is not null  and
        NLS_FXP_1 is not null  AND
        NLS_FXP_1 <> NLS_FXP_2 then

        SSQ_:= Abs(SSQ_);
        payTT(0,ref_,VDAT_,FXB_,1-DK_,gl.baseval, NLS_FXP_2, SSQ_, gl.baseval, NLS_FXP_1, SSQ_);
        update opldok set txt=decode (DK_,0,sPEREOV, sPEREOP ) where ref=REF_ and stmt=gl.ASTMT;
     end if;

  else /* свернем переоц на Дисконт или премию */
     IF SS_ > 0 then SD_ := SD_ + SS_;
     else            SP_ := SP_ - SS_;
     end if;
     SS_:=0;
  end if;

  DP_ := SP_ - SD_ ;
  VDP_:= VP_ - VD_ ;

  -- P) Премия
  If SP_ > SD_ then   SP_:= SP_ - SD_ ; SD_:=0;
     begin /* открыть сч и зачислить перемещаемую премию */
       select acc, substr(nls,1,5)||'0'||S8_, substr(cp_id_r||nms,1,38)  into accc_, NLS_, NMS_
       from accounts  where nls=ac2.nlsP and kv= kk.KV ;
     EXCEPTION WHEN NO_DATA_FOUND THEN    sERR:='1.Нет сч.премии ИСХ в ФУ'; return;
     END;
     cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_, kk.KV ,NMS_,'ODB',gl.aUid,accP_);
     UPDATE accounts SET mdate=kk.DATP,accc=ACCC_,seci=4,daos=VDAT_, pos=1      WHERE acc=accP_;

     cp_inherit_specparam (accP_, accc_, 0);

     If no_A_ <>1  then
        insert into int_accn (acc ,acra ,acrb  ,id,metr,ACR_DAT   , s ,STP_DAT, IO , basey, freq )
                      values (ACC_,ACCP_,ACRB_P, 3,   6,gl.bdate-1, S_,kk.DATP-1, IO_, 0,     1);
     end if;

     payTT(0,ref_, VDAT_,FXB_,1, kk.KV ,NLS_,SP_, kk.KV ,B_4621,SP_);
     update opldok set txt=sPREMIA where ref=REF_ and stmt=gl.ASTMT;

  -- D) Дисконт
  elsif SP_ < SD_ then   SD_:= SD_ - SP_ ; SP_:=0;
     begin /* открыть сч и зачислить перемещаемый дисконт */
       select acc, substr(nls,1,5)||'0'||S8_, substr(cp_id_r||nms,1,38) into accc_, NLS_, NMS_
       from accounts  where nls= ac2.nlsD and kv= kk.KV  ;
     EXCEPTION WHEN NO_DATA_FOUND THEN     sERR:='17.Нет сч.дисконта ИСХ в ФУ'; return;
     END;
     cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_, kk.KV ,NMS_,'ODB',gl.aUid,accD_);
     UPDATE accounts SET mdate=kk.DATP,accc=ACCC_,seci=4,daos=VDAT_,pos=1          WHERE acc=accD_;

     cp_inherit_specparam (accD_, accc_, 0);

     If no_A_ <>1  then
        insert into int_accn (acc ,acra ,acrb  ,id,metr,ACR_DAT   ,s ,STP_DAT, IO , basey,freq)
                      values (ACC_,ACCD_,acrb_D,2 ,6   ,gl.bdate-1,S_,kk.DATP-1, IO_, 0    , 1  );
     end if;
     payTT(0,ref_,VDAT_,FXB_,0, kk.KV ,NLS_,SD_, kk.KV ,B_4621,SD_);
     update opldok set txt=sDISKONT where ref=REF_ and stmt=gl.ASTMT;
  end if;

  -- VP) вирт Премия
  If VP_ > VD_ then     VP_:= VP_ - VD_ ; VD_:=0;
     -- вирт Премия
     begin
       select acc, substr(nls,1,5)||'2'||S8_, substr(cp_id_r||nms,1,38) into accc_, NLS_, NMS_
       from accounts     where nls = ac2.s2VP and kv  = kk.KV  ;
     EXCEPTION WHEN NO_DATA_FOUND THEN    sERR:='2VP.Нет сч.вирт.премии ИСХ в ФУ'; return;
     END;
     cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_, kk.KV ,NMS_,'2VP',gl.aUid, acc_2vp);
     insert into cp_REF_ACC(ref,acc) values (REF_,Acc_2vp);
     UPDATE accounts SET mdate=kk.DATP,accc=ACCC_,seci=4,daos=VDAT_, pos=1   WHERE acc=acc_2vp;
     payTT(0,ref_, VDAT_,FXB_,1, kk.KV ,NLS_,VP_, kk.KV ,B_4621,VP_);
     update opldok set txt='2VP:'||sPREMIA where ref=REF_ and stmt=gl.ASTMT;

  -- VD) Вирт Дисконт
  elsif VP_ < VD_ then   VD_:= VD_ - VP_ ; VP_:=0;
     begin
       select acc, substr(nls,1,5)||'2'||S8_, substr(cp_id_r||nms,1,38)   into accc_, NLS_, NMS_
       from accounts where nls = ac2.s2VD and kv  = kk.KV ;
     EXCEPTION WHEN NO_DATA_FOUND THEN    sERR:='2VD.Нет сч.вирт дисконта ИСХ в ФУ'; return;
     END;
     cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_, kk.KV ,NMS_,'2VD',gl.aUid,acc_2vd);
     insert into cp_REF_ACC(ref,acc) values (REF_,Acc_2vd);
     UPDATE accounts SET mdate=kk.DATP,accc=ACCC_,seci=4,daos=VDAT_,pos=1       WHERE acc=acc_2vd;
     cp_inherit_specparam (acc_2vd, accc_, 0);

     payTT(0,ref_,VDAT_,FXB_,0, kk.KV ,NLS_,VD_, kk.KV ,B_4621,VD_);
     update opldok set txt='2VD:'||sDISKONT where ref=REF_ and stmt=gl.ASTMT;

  end if;

  if VDP_ <> 0 and DP_ = 0 and no_A_ <>1  then
    INSERT INTO int_accn (acc,
                          id,
                          metr,
                          ACR_DAT,
                          STP_DAT,
                          IO,
                          basey,
                          freq)
         VALUES (ACC_,
                 2,
                 6,
                 gl.BDATE - 1 + IO_,
                 kk.DATP - 1,
                 IO_,
                 0,
                 1);
  end if;

  --Нарах. Дивіденти
  begin --!н.д.1
    select a.*
      into aa
    from cp_accounts ca, accounts a
    where ca.cp_ref = nREF_ and ca.cp_acctype = 'RD'
      and ca.cp_acc = a.acc and a.ostc != 0;
      
    --звернути 
    if aa.ostc > 0 then dk_  := 1 ; else dk_ := 0 ; s_ := - s_;  end if;
    payTT(0,ref_,VDAT_,FXB_, dk_ , aa.kv ,aa.NLS, S_ , aa.KV , B_4621 , S_ );    
      
    begin --!н.д.2
      select acc, substr(nls,1,5)||'0'||s8_, substr(cp_id_r||nms,1,38) into accc_,NLS_,NMS_ from accounts where nls=ac2.nlsRD and kv=kk.KV;
      exception 
        when NO_DATA_FOUND then --!н.д.2   
          sERR:='36.Невказаний рах. нарах. дивідентів ИСХ в ФУ'; 
          return;
    end;

    -- відкрити рахунок 
    cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK, NLS_,kk.KV,NMS_,'ODB',gl.aUid,accrd_);
    update accounts set mdate=kk.DATP,accc=ACCC_, seci=4, pos=1, daos=VDAT_, pap=3  where acc=accrd_;   
    cp_inherit_specparam (accrd_, accc_, 0);
    --та розвернути  
    dk_ := case dk_ 
             when 0 then 1 
             when 1 then 0 
           end;
    payTT(0,ref_,VDAT_,FXB_, dk_ , kk.KV ,NLS_, S_ , kk.KV , B_4621 , S_ );
    
    exception --!н.д.1
      when NO_DATA_FOUND then
        null; --ок. не має або нульовий  
  end;  
    
  --Переоцінка хитра додаткова S2 (опціон)
  begin --!н.д.1
    select a.*
      into aa
    from cp_accounts ca, accounts a
    where ca.cp_ref = nREF_ and ca.cp_acctype = 'S2'
      and ca.cp_acc = a.acc and a.ostc != 0;
      
    --звернути 
    if aa.ostc > 0 then dk_  := 1 ; else dk_ := 0 ; s_ := - s_;  end if;
    payTT(0,ref_,VDAT_,FXB_, dk_ , aa.kv ,aa.NLS, S_ , aa.KV , B_4621 , S_ );    
      
    begin --!н.д.2
      select acc, substr(nls,1,5)||'0'||s8_, substr(cp_id_r||nms,1,38) into accc_,NLS_,NMS_ from accounts where nls=ac2.nlsS2 and kv=kk.KV;
      exception 
        when NO_DATA_FOUND then --!н.д.2   
          sERR:='37.Невказаний рах. переоцінки по опціону S2 ИСХ в ФУ'; 
          return;
    end;

    -- відкрити рахунок 
    cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK, NLS_,kk.KV,NMS_,'ODB',gl.aUid,accs2_);
    update accounts set mdate=kk.DATP,accc=ACCC_, seci=4, pos=1, daos=VDAT_, pap=3  where acc=accs2_;   
    cp_inherit_specparam (accs2_, accc_, 0);
    --та розвернути  
    dk_ := case dk_ 
             when 0 then 1 
             when 1 then 0 
           end;
    payTT(0,ref_,VDAT_,FXB_, dk_ , kk.KV ,NLS_, S_ , kk.KV , B_4621 , S_ );
    
    exception --!н.д.1
      when NO_DATA_FOUND then
        null; --ок. не має або нульовий  
  end;    

  --  годовой купон               -- годовой дисконт
  --   SN_*RATE_/100               -- DP_*365 / (kk.DATP - GL.BDATE)
--  S_   := SN_ + DP_ + VDP_ + SR_ ; ---"цена перемещения"  -- 05-01-2009 эф.ставка
  S_   := SN_ + DP_ + VDP_ + SR_ + SR2_ + SR9_ + SN_EXP; ---"цена перемещения"  -- 02-11-2015 эф.ставка
  SN_ := SN_ + SN_EXP;  SR_ := SR_ + SR9_;  -- !  2/11-15
  erat_:= ( (SN_*nvl(kk.ir,0)/100) + ( (DP_+VDP_) *365/(kk.DATP-GL.BDATE))  )/( (S_+SN_)/2 );

  insert into cp_deal
  (ID , RYN  ,ACC ,ACCD , ACCP ,ACCR ,ACCR2 , ACCS ,ACCS6 ,ACCS5, ACCEXPN, ACCEXPR,
                          REF , erat, initial_ref, dat_bay)
  values
  (nID_,nRYN2_,acc_,accd_, accp_,accr_, ACCR2_, accs_, ACCS6_, ACCS5_, accn_exp, accR9_,
                          ref_, erat_, l_init_ref, l_dat_bay);

  for k8 in (
            select ref, 'N' l_type, acc from cp_deal where ref=ref_
            union all
            select ref, 'R', accr from cp_deal where ref=ref_ and accr is not null
            union all
            select ref, 'R2', accr2 from cp_deal where ref=ref_ and accr2 is not null
            union all
            select ref, 'S', accs from cp_deal where ref=ref_ and accs is not null
            union all
            select ref, 'D', accd from cp_deal where ref=ref_ and accd is not null
            union all
            select ref, 'P', accp from cp_deal where ref=ref_ and accp is not null
            union all
            select ref, 'R3', accr3 from cp_deal where ref=ref_  and accr3 is not null
            union all
            select ref, 'UNREC', accunrec from cp_deal where ref=ref_  and accunrec is not null
            union all
            select ref_, 'RD', accrd_ from dual where accrd_ is not null
            union all
            select ref_, 'S2', accs2_ from dual where accs2_ is not null
            )

 loop
     INS_CP_ACCOUNTS (p_ref =>ref_, p_type =>k8.l_type, p_acc =>k8.acc);
 end loop;

  -- перемещение в портфелях OP = 3
  INSERT into cp_arch
  (REF, ID, DAT_UG, DAT_OPL, DAT_ROZ,  N,  D,  P,  R, vd, vp, STR_REF, OP)
  values
  (Ref_,nID_,gl.BDATE,gl.BDATE,gl.BDATE, SN_,SD_,SP_,SR_,vd_, vp_, sREF, 3 );

  cp.RMany_DAT(REF_, ref_, VDAT_,SN_, 0 );

  -- Для форвардного купона
  cp.cp_FORV_KUP(nID_);
     -- переоформляем гарантии
    /* cp_warranty_method.id = 1 -- полное удаление гарантии
    cp_warranty_method.id = 2 -- уменьшение гарантии в удельном весе */
    begin
       select cd.REF,
              sz.pawn,
              A.nls,
              A.kv,
              p.acc,
              p.accs,
              ABS(A.ostb),
              SZ.idz,
              SZ.cc_idz,
              SZ.sdatz,
              C.rnk,
              AW.VALUE,
              A.OB22
        bulk collect
        into l_cp_warrantyset
        FROM  cc_accp P,
              pawn_acc SZ,
              accounts A,
              accountsw aw,
              customer C,
              cp_deal cd
        WHERE     SZ.acc = p.acc
              AND p.rnk = C.rnk
              AND a.acc = aw.acc
              AND aw.tag = 'CP_WARR'
              AND a.acc = P.acc
              AND cd.acc = p.accs
              and cd.ref = p.nd
              and cd.ref = nREF_
              and to_number(AW.VALUE) in (1,2);

    exception when no_data_found then bars_audit.trace('CP: для пересмотра нет гарантий пакета REF='|| to_char(k.ref));
    end;

    if l_cp_warrantyset.count > 0
     then
      for w in 1..l_cp_warrantyset.count
      loop
         bars_audit.trace('%s l_cp_warrantyset (l_cp_warrantyset(w).cp_war+1 = %s, S = %s)', 'CP_MOVE', to_char(l_cp_warrantyset(w).cp_war+1),to_char(l_cp_warrantyset(w).s));
         -- со старого пакета удаляем
            p_cp_addwarranty(p_mode    => 2,                               -- 0-вставка, 1-изменение, 2-удаление, 3-пропорциональное уменьшение
                             p_ref     => nREF_,                           -- референс сделки с ЦП
                             p_pawn    => l_cp_warrantyset(w).pawn,        -- вид обеспечения                                                   |
                             p_kv      => l_cp_warrantyset(w).kv,          -- валюта                                                            | для открытия счета гарантии
                           --p_ob22    => l_cp_warrantyset(w).ob22,        -- OB22                                                              |
                             p_CP_WAR  => l_cp_warrantyset(w).cp_war,      -- параметр вида изменения гарантии при частичном погашении/продаже  |
                             p_rnk     => l_cp_warrantyset(w).rnk,         -- РНК третьего лица, дающего гарантии
                             p_s       => l_cp_warrantyset(w).s,           -- сумма гарантии
                             p_ccnd    => l_cp_warrantyset(w).CC_IDZ,      -- номер договора гарантии
                             p_sdate   => l_cp_warrantyset(w).sdatz,       -- дата договора гарантии
                             p_nls     => l_cp_warrantyset(w).nls);        -- счет 9 класса
          -- на новый пакет открываем
            p_cp_addwarranty(p_mode    => 0,                               -- 0-вставка, 1-изменение, 2-удаление, 3-пропорциональное уменьшение
                             p_ref     => ref_,                            -- референс сделки с ЦП
                             p_pawn    => l_cp_warrantyset(w).pawn,        -- вид обеспечения                                                   |
                             p_kv      => l_cp_warrantyset(w).kv,          -- валюта                                                            | для открытия счета гарантии
                           --p_ob22    => l_cp_warrantyset(w).ob22,        -- OB22                                                              |
                             p_CP_WAR  => l_cp_warrantyset(w).cp_war,      -- параметр вида изменения гарантии при частичном погашении/продаже  |
                             p_rnk     => l_cp_warrantyset(w).rnk,         -- РНК третьего лица, дающего гарантии
                             p_s       => l_cp_warrantyset(w).s/100,       -- сумма гарантии (обычно она заводится с интерфейса в гривнах, но тут - копейки - делим на 100)
                             p_ccnd    => l_cp_warrantyset(w).CC_IDZ,      -- номер договора гарантии
                             p_sdate   => l_cp_warrantyset(w).sdatz,       -- дата договора гарантии
                             p_nls     => l_cp_warrantyset(w).nls);        -- счет 9 класса
       bars_audit.trace('CP: пересмотрена гарантия пакета REF='|| to_char(l_cp_warrantyset(w).ref_)|| ' на сумму '|| to_char(l_cp_warrantyset(w).s) || ' по счету '|| l_cp_warrantyset(w).nls);
      end loop;
    end if;

    begin
        select ref_, 'PORTF',           -- convert
        case
        when substr(nNBS2_,1,3) in ('141','143','310','311','312') then 1
        when substr(nNBS2_,1,3) in ('142','144','321') then 3
        when substr(nNBS2_,1,3) in ('140','300','301') then 4
        when substr(nNBS2_,1,3) in ('410','420') then 2
        else null  end
        into r_refw.ref, r_refw.tag, r_refw.value
        from dual;
    end;

    if r_refw.value is not null then
       CP_SET_TAG(r_refw.ref,r_refw.tag,r_refw.value,3);
    end if;


  end loop;

  if fl_m = 0 then null;
       sERR:='CP_MOVE: Не знайдено пакетів для переміщення '|| to_char(nID_);
       RETURN;
  end if;

end CP_MOVE;
------------------------------------------------------------------------
    /* PROCEDURE CP_PROD  */
    -- продажи ранее купленных чужих   (TIP=1)
    -- отправка эмитенту (погашение эмитентом TIP=1)
    -- процедура первичной продажи своих (TIP=2)
------------------------------------------------------------------------
PROCEDURE CP_PROD (TIPD_       IN     cp_kod.tip%type,      -- 1 акт (чужие), 2 пас (свои)
                   VOB_        IN     oper.vob%type,        -- вид банковского документа
                   GRP_        IN     INT,                  -- группа доступа по счетам
                   nID_        IN     cp_kod.id%type,       -- код ЦБ
                   nNBS_       IN     cp_accc.vidd%type,    -- БАЛ счет
                   nRYN_       IN     cp_accc.ryn%type,     -- субпортфель
                   DAT_UG      IN     DATE,                 -- дата сделки
                   DAT_OPL     IN     DATE,                 -- дата поставки
                   DAT_ROZ     IN     DATE,                 -- дата расчетов
                   DAT_KOM     IN     DATE,                 -- дата опл комис
                   SUMBN       IN     NUMBER,               -- сумма номинала (в грн)
                   SUMB        IN     NUMBER,               -- сумма сделки
                   SUMBK       IN     NUMBER,               -- сумма комиссии
                   RR_         IN     NUMBER,               -- сумма заявленного купона
                   NAZN_       IN     oper.nazn%type,       -- назначение платежа
                   NLS9        IN     accounts.nls%type,    -- счет резерва
                   REF_REPO_   IN     VARCHAR2,             -- реф сделки покупки для РЕПО, или null
                   sFREE       IN     VARCHAR2,             -- резерв -- нигде не используется?
                   B_4621      IN     accounts.nls%type,    -- счет транзита
                   B_1819      IN     accounts.nls%type,    -- форвард-номинал с 1819 на 4621 (дата поставки DAT_OPL > дата расчетов DAT_ROZ)
                   B_1919      IN     accounts.nls%type,    -- форвард-номинал с 1919 на 4621 (дата поставки DAT_OPL < дата расчетов DAT_ROZ)
                   sREF           OUT cp_arch.str_ref%type, -- список референсов сделки
                   sErr           OUT VARCHAR2,             -- сообщение об ошибке
                   REF_MAIN    IN OUT INT)                  -- референс основной сделки
IS
   title       constant    varchar2(12) := 'CP.CP_PROD:';
   aa          accounts%ROWTYPE;
   cpk         cp_kod%ROWTYPE;         -- коллекция параметров кода ЦП

   nREPO_      INT;                    -- реф сделки покупки для РЕПО, или null
   REF_        oper.ref%type;          -- референс проводки, в которую вставляется вся бухмодель
   DK_         oper.dk%type;           -- направление проводки

   V1_         NUMBER;                 -- собівартість продажу 1 ЦП
   r1_         INT;                    -- CP_PAWN.NDZ Реф.ДОГОВОРА залога, пока не использ. это OUT параметр op_reg_ex (p4)
   KUP1_       NUMBER;                 -- купон 1-го дня
   DP1_        NUMBER;                 -- дисконт/премия 1-го дня
   ERAT_       NUMBER;                 -- 05-01-2009 эф.ставка

   RNK1_       customer.rnk%type;      -- РНК технич
   OP_         cp_op.op%type;          -- код операции по ЦБ

   VDAT_       DATE;                   -- дата рассчета DAT_ROZ или для корректирующих = дата последнего рабочего дня предыдущего месяца
   FLAG_OPL_   INT := 0;               -- для оплаты доч.проводок по D, P, ...

   cp_id_r     VARCHAR2 (20);          -- cp_id || '/' для наименования счета в переменной NMS_ (осн.сч.в ФУ)
   NMS_        accounts.nms%type;      -- наименование основного счета в ФУ И НЕ ТОЛЬКО

   S_          NUMBER;                 -- переменная для сумм - везде?
   accc_       accounts.acc%type;      -- переменная для вычитки родительского счета

   acc_        accounts.acc%type;      -- асс основного счета ЦП
   accR_       accounts.acc%type;      -- асс счета начисленного купона R (открывается в процедуре)
   accR2_      accounts.acc%type;      -- асс счета купленного купона R2 (открывается в процедуре)
   accP_       accounts.acc%type;      -- асс счета премии (по маске счета консолидированной премии)(открывается в процедуре)
   accD_       accounts.acc%type;      -- асс счета дисконта (по маске счета консолидированного дисконта)(открывается в процедуре)

   D_          NUMBER;
   DP_         NUMBER;
   P_          NUMBER;
   N_          NUMBER;                 -- сумма номинала отдельной кучки/сделки в продажу, используется в цикле набора нужной для продажи суммы
   K_          NUMBER;                 -- сумма комиссии в копейках SUMBK * 100 (входной параметр)

   NLSG_       accounts.nls%type;      -- счет номинала (консолидированный RI_CPACCC.nlsA) для общей/верхней проводки

   -- вопрос, почему нельзя брать из коллекции RI_CPACCC
   ACRB_D      accounts.acc%type;      -- асс консолидированного счета дисконта
   ACRB_P      accounts.acc%type;      -- асс консолидированного счета премии


   sNls        accounts.nls%type;       -- лицевой счет форвард-номинал с 1919/1819 Кредит.задолж. или Дебет.задолж.
   SA_         NUMBER;                  -- сумма сделки = SUMB (входной параметр)
   SD_         NUMBER;
   SP_         NUMBER;

   SN_         NUMBER;                  -- сумма номинала в копейках SUMBN * 100 (входной параметр)
   NN_         NUMBER;                  -- NN_ становится = SN_ и уменьшается в цикле?

   SS_         NUMBER;

   T_          NUMBER;                  -- торговый результат
   S_4621      VARCHAR2 (38);           -- наименовние транзитного счета
   NLS62_      accounts.nls%type;       -- счет торгового результата

   R_          NUMBER;
   accR6_      accounts.acc%type;
   NAZN1_      VARCHAR2 (70);
   R2_         NUMBER;
   R2a_        NUMBER;

   TTV_        tts.tt%type;


   OSTSQ_      NUMBER;
   SQ_         NUMBER   := 0;          -- реал рез переоценки от одной кучки
   l_accn1     INT      := NULL;
   l_vdat      DATE;

   ------- Для обеспечения на 1 ЦБ
   l_nlsz      accounts.nls%TYPE;
   l_accs      accounts.acc%TYPE;
   l_kvz       accounts.kv%TYPE;
   l_id        cp_deal.id%TYPE;
   l_ref       cp_deal.REF%TYPE;
   l_rnk       accounts.rnk%TYPE;
   l_ob22      accounts.ob22%TYPE;
   l_sz        accounts.ostc%TYPE;

   NLSR_bek    accounts.NLS%TYPE;
   NLSR_bek3   accounts.NLS%TYPE;
   nTmp_       INT;

   ACCCR_      accounts.acc%TYPE := NULL;
   ACCCR2_     accounts.acc%TYPE := NULL;


   VD_         NUMBER;                          -- накопление суммы вирутального дисконта для вставки в архив
   VP_         NUMBER;                          -- накопление суммы виртуальной премии для вставки в архив
   SR_         NUMBER;                          -- накопление суммы купона для вставки в архив

   l_metr      cp_kod.metr%TYPE;                -- метод начисления купонов
   B4621R      accounts.nls%TYPE;               -- ТРАНЗИТ для купона. Для обычного купона = B_4621, для отриц - из cp_accp.B4621R


   l_fulkup    NUMBER;

   l_osts      NUMBER;                          --\ сальдо счета переоценки ном, которое надо делить
   l_ostsq     NUMBER;                          --/ сальдо счета переоценки экв, которое надо делить
   l_koeff     NUMBER;                          -- коэффициент удельного веса
   l_datpm     DATE;                            -- уточн. дата погашення ЦП (исп., если продали чужую ЦБ в будущем)

   -- вычитывается и нигде не используется!
   Sumb_A      NUMBER;                 -- попередня сума угоди -- вычитывается и нигде не используется!
   DAT_OPL_A   DATE;                   -- попередня дата вал -- вычитывается и нигде не используется!
   l_kol       INT := 1;               -- пакет ЦП -- вычитывается и нигде не используется!
   l_prev_vdat DATE;                            -- дата предыдущей переоценки
   l_NLS_DP accounts.NLS%type; -- счет дисконта ИЛИ премии при продаже СВОИХ ЦП
   -- не используются
   -- DAT7        DATE;
   -- DAT_0101    DATE     := TO_DATE ('0101' || TO_CHAR (gl.bdate, 'yyyy'), 'DDMMYYYY');
   -- REF1_       oper.ref%type;
   -- sNls_       accounts.nls%type;
   -- l_stmt      INT := 0;
   -- l_ky        INT := 1;
   S_TRANS_DK_NMS varchar2(38);
   S_TRANS_DK_NLS varchar2(15);

   l_vob          int := VOB_;
------------------------------------------------------------------------------
begin
  bars_audit.trace('%s Start for ID = %s, tip = %s, nREPO_ = %s',
                    title,
                    to_char(nID_),
                    to_char(TIPD_),
                    to_char(nREPO_));
  bars_audit.info(title || ' Start with '
                        || ', CP_METOD = ' || to_char(l_CP_METOD)
                        || ', CP_TRANS_DK = ' || to_char(l_CP_TRANS_DK)
                        || ', B_1819 = '||B_1819
                        || ', B_1919 = '||B_1919);

  if l_CP_TRANS_DK is null
  then l_CP_TRANS_DK := 0; --Робота через транз.рах =0
  end if;

  if l_CP_TRANS_DK = 0
  then S_TRANS_DK_NLS := B_4621;
  else S_TRANS_DK_NLS := B_1819;
  end if;

  if l_CP_METOD is null
  then l_CP_METOD := 1; --1 - за датою розр
  end if;

  sErr  := null;
  nREPO_:= to_number(REF_REPO_);

  bars_audit.trace('%s Начало инициализации и проверок ID = %s, tip = %s',
                    title,
                    to_char(nID_),
                    to_char(TIPD_));

  BEGIN
    BEGIN
        SELECT *
          INTO cpk
          FROM cp_kod
         WHERE id = nID_
           AND tip = TIPD_;
    EXCEPTION WHEN no_data_found
              THEN sERR := '18.Нет ЦБ '||nID_;
                   bars_audit.trace('%s Операция продажи ЦБ не завершена для ID = %s, tip = %s, с сообщением: %s ',
                                        title,
                                        to_char(nID_),
                                        to_char(TIPD_),
                                        sERR);
                   RETURN;
    END;

    BEGIN
        SELECT TO_NUMBER (val)
          INTO RNK1_
          FROM params
         WHERE par = 'RNK_CP';
    EXCEPTION WHEN no_data_found
              THEN sERR := '23.Нет в PARAMS RNK_CP';
                   bars_audit.trace('%s Ошибка операции продажи ЦБ для ID = %s, tip = %s, с сообщением: %s ',
                                        title,
                                        to_char(nID_),
                                        to_char(TIPD_),
                                        sERR);
    END;

    BEGIN
        SELECT SUBSTR (nms, 1, 38)
          INTO S_TRANS_DK_NMS
          FROM accounts
         WHERE kv = cpk.kv
           AND nls = S_TRANS_DK_NLS;
    EXCEPTION WHEN no_data_found
              THEN sERR := '19.Нет сч.транзита '||S_TRANS_DK_NLS;
                   bars_audit.trace('%s Ошибка операции продажи ЦБ для ID = %s, tip = %s, с сообщением: %s ',
                                        title,
                                        to_char(nID_),
                                        to_char(TIPD_),
                                        sERR);
    END;

    BEGIN
        SELECT *
          INTO RI_CPACCC    -- коллекция консолидированных счетов для субпортфеля
          FROM cp_accc
         WHERE vidd = nNBS_
           AND ryn = nRYN_
           AND emi = cpk.emi;
    EXCEPTION WHEN no_data_found
              THEN sERR := '21.Нет в cp_accc';
                   bars_audit.trace('%s Ошибка операции продажи ЦБ для ID = %s, tip = %s, с сообщением: %s ',
                                        title,
                                        to_char(nID_),
                                        to_char(TIPD_),
                                        sERR);
    END;

    BEGIN
        SELECT NLS, SUBSTR (nms, 1, 38)
          INTO NLSG_, NMS_
          FROM accounts
         WHERE nls = RI_CPACCC.nlsA
           AND KV = cpk.kv;
    EXCEPTION WHEN no_data_found
              THEN sERR := '21.Нет осн.сч.в ФУ';
                   bars_audit.trace('%s Ошибка операции продажи ЦБ для ID = %s, tip = %s, с сообщением: %s ',
                                        title,
                                        to_char(nID_),
                                        to_char(TIPD_),
                                        sERR);
    END;


    if RI_CPACCC.nls_FXP is null -- не настроен счет нереализованного результата переоценки в справочнике консолидированных счетов по субпортфелю
     then -- тогда берем счет переоценки ИЗ НАСТРОЕК ОПЕРАЦИИ? круто
        SELECT nlsk
          INTO RI_CPACCC.nls_FXP
          FROM tts
         WHERE tt = 'FXP';
    end if;

    -- счет реализованного результата переоценки, если не настроен в консолидированных счетах, то берем счет нереализованного результата переоценки
    RI_CPACCC.nls_FXR := NVL(RI_CPACCC.nls_FXR,RI_CPACCC.nls_FXP);

    BEGIN
        SELECT NLS
          INTO NLS62_   -- Рах-к торгового результату
          FROM accounts
         WHERE nls = RI_CPACCC.nlsG
           AND kv = GL.BASEVAL;
    EXCEPTION WHEN no_data_found
              THEN sERR := '21t.Нет сч.торг.рез. в ФУ';
                   bars_audit.trace('%s Ошибка операции продажи ЦБ для ID = %s, tip = %s, с сообщением: %s ',
                                        title,
                                        to_char(nID_),
                                        to_char(TIPD_),
                                        sERR);
    END;

    cpk.ir       := NVL(cpk.ir,0);
    cpk.basey    := NVL(cpk.basey,0);
    cpk.CENA_KUP := NVL(cpk.CENA_KUP,0)/cpk.cena;
    cpk.rnk      := NVL(cpk.rnk,RNK1_);
    cpk.dnk      := NVL(cpk.dnk,cpk.datp);
    l_fulKUP     := ROUND(100 * SUMBN * cpk.ir /(100 * NVL(cpk.ky,1)),2);

    If cpk.metr = 23
     then    l_metr := 8;
     else    l_metr := nvl(cpk.metr,0);
    end if;

    l_kol        := ROUND(SUMBN/cpk.cena, 2);
    kk           := cpk;  -- !
  EXCEPTION WHEN NO_DATA_FOUND
            THEN RETURN;
  END;

  bars_audit.trace('%s Инициализация - ОК для ID = %s, tip = %s', title, to_char(nID_), to_char(TIPD_));

  sErr      := NULL; -- сброс ошибок, так как возврат блока инициализации выполнен

  cp.FXB(cpk.kv, TIPD_);-- определение глобальных переменных пакеджа

  bars_audit.trace('%s Запуск: страховочная амортизация до текущего дня для ID = %s, tip = %s', title, to_char(nID_), to_char(TIPD_));
  /* страховочная амортизация до текущего дня */
  IF cpk.dox >= 2 AND TIPD_=1
  THEN
     FOR K IN ( SELECT d.REF, a.daos
                  FROM cp_deal d, accounts A
                 WHERE d.ID = nID_
                   AND a.acc = d.acc
                   AND a.ostc <> 0
                   AND (nREPO_ IS NULL OR d.REF = nREPO_) )
     LOOP
       IF k.DAOS < gl.BDATE
        THEN  cp.CP_AMOR(k.REF, nID_ ,GRP_, gl.bdate-1,  sErr);
       END IF;
     END LOOP;

     IF sErr IS NOT NULL
      THEN sErr:='20.Амортизация '||sErr;
           bars_audit.trace('%s Ошибка операции продажи ЦБ для ID = %s, tip = %s, с сообщением: %s ',
                                title,
                                to_char(nID_),
                                to_char(TIPD_),
                                sERR);
           RETURN;
     END IF;
  END IF;
  bars_audit.trace('%s Страховочная амортизация до текущего дня - ОК для ID = %s, tip = %s', title, to_char(nID_), to_char(TIPD_));
  BEGIN
     SELECT d.acc
       INTO l_accn1
       FROM cp_deal d
      WHERE d.id = nID_ AND (nREPO_ IS NOT NULL AND d.REF = nREPO_);
  EXCEPTION
     WHEN NO_DATA_FOUND
     THEN NULL; -- тут осознанно ничего не сообщаем, так как операция может быть НЕ РЕПО
  END;

  bars_audit.trace('%s Инициализация сумм для ID = %s, tip = %s, REF_MAIN = %s', title, to_char(nID_), to_char(TIPD_), to_char(REF_MAIN));
  SA_   := SUMB * 100;  -- сумма сделки в копейках = SUMB (входной параметр)
  VD_   := 0;           -- накопление суммы виртуального дисконта для вставки в архив
  SD_   := 0;
  SP_   := 0;
  SN_   := SUMBN * 100; -- номинал сделки в копейках
  R2_   := RR_  * 100;
  VP_   := 0;           -- накопление суммы виртуальной премии для вставки в архив
  SR_   := 0;           -- накопление суммы купона для вставки в архив
  SS_   := 0;

  sREF := null;

  if VOB_ = 96
   then VDAT_:= F_VDAT_ZO(ADD_MONTHS(gl.bdate, -1)); -- дата последнего рабочего дня предыдущего месяца
   else VDAT_:= DAT_ROZ;
  end if;
  if l_vob is null then
    if cpk.KV = gl.baseval then l_vob :=6; else l_vob:=16; end if;
  end if;

  l_vdat    := VDAT_;
  l_datpm   := cpk.datp;

  IF REF_MAIN IS NULL
  THEN
     bars_audit.trace('%s REF_MAIN = null (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
     if  DAT_ROZ > cpk.datp
     then
        bars_audit.trace('%s врегулювання випадку коли, datp = holiday (REF_MAIN= null) (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
     -- врегулювання випадку коли, datp = holiday
        BEGIN
           SELECT holiday
             INTO l_datpm
             FROM holiday
            WHERE holiday = cpk.datp
              AND kv = cpk.kv;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN l_datpm := cpk.datp;
        END;
     end if;
       ---  if l_CP_METOD = 0  then l_datpm := dat_opl;  else l_datpm := dat_roz; end if;

     bars_audit.trace('%s Дата l_datpm = %s (REF_MAIN= null) (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_), to_char(l_datpm,'dd/mm/yyyy'));

     -- выдача главного реф на продажу + внебаланс(или без) + дебиторы-Кредиторы (или без них)
     GL.REF (REF_);
     REF_MAIN := REF_;
     -- внебаланс (если дата сделки != дата оплаты != дата расчета)
     bars_audit.trace('%s внебаланс (если дата сделки != дата оплаты != дата расчета) (REF_MAIN= null) (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_), to_char(l_datpm,'dd/mm/yyyy'));
     CP.CP_vneb(DK_       =>    1,
                KV_       =>    cpk.kv,
                nNBS_     =>    nNBS_,
                nRYN_     =>    nRYN_,
                EMI_      =>    cpk.emi,
                p_SN_     =>    SN_,            -- номинал сделки в коп
                p_SA_     =>    SA_,            -- сумма сделки в копейках = SUMB (входной параметр)
                CP_ID_    =>    cpk.cp_id,
                DAT_UG    =>    DAT_UG,
                DAT_OPL   =>    DAT_OPL,
                DAT_ROZ   =>    DAT_ROZ,
                DAT_KOM   =>    DAT_KOM,
                NAZN_     =>    NAZN_,
                REF_      =>    REF_,
                NLS9      =>    NLS9,           -- счет резерва
                sREF      =>    sREF,
                sErr      =>    sErr);

     IF sErr IS NOT NULL
      THEN
          bars_audit.trace('%s Ошибка внебаланса (REF_MAIN= null) (ID = %s, tip = %s) завершился с ошибкой %s', title, to_char(nID_), to_char(TIPD_), sErr);
          RETURN;
     END IF;

       GL.in_doc3 (ref_     => REF_,
                   tt_      => FXB_,
                   vob_     => l_vob,
                   nd_      => SUBSTR(TO_CHAR(REF_), 1, 10),
                   pdat_    => SYSDATE,
                   vdat_    => vdat_,
                   dk_      => 0,
                   kv_      => cpk.kv,
                   s_       => SA_,             -- сумма сделки в копейках = SUMB (входной параметр)
                   kv2_     => cpk.kv,
                   s2_      => SA_,             -- сумма сделки в копейках = SUMB (входной параметр)
                   sk_      => NULL,
                   data_    => GREATEST(VDAT_, gl.bdate),
                   datp_    => gl.bdate,
                   nam_a_   => NMS_,
                   nlsa_    => NLSG_,           -- счет номинала консолидированный RI_CPACCC.nlsA
                   mfoa_    => gl.AMFO,
                   nam_b_   => S_4621,
                   nlsb_    => S_TRANS_DK_NLS,          -- транзитный счет
                   mfob_    => gl.AMFO,
                   nazn_    => NAZN_,
                   d_rec_   => NULL,
                   id_a_    => gl.aOkpo,
                   id_b_    => gl.aOkpo,
                   id_o_    => NULL,
                   sign_    => GetAutoSign,
                   sos_     => 1,
                   prty_    => NULL,
                   uid_     => NULL);

     F_REF(REF_, sREF, sREF);
     begin
        insert into cp_payments(cp_ref, op_ref)
        values (REF_, REF_);
     exception when others then null;
     end;

     bars_audit.trace('%s Основная операция REF_ = %s (REF_MAIN= null) (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
    if l_CP_TRANS_DK = 0
    then
     IF DAT_OPL != DAT_ROZ -- возникновение деб/кред задолженности при форвардных сделках
     THEN
        bars_audit.trace('%s DAT_OPL = %s != DAT_ROZ = %s (REF_MAIN= null) (ID = %s, tip = %s)', title,to_char(DAT_OPL,'dd/mm/yyyy'),to_char(DAT_ROZ,'dd/mm/yyyy'), to_char(nID_), to_char(TIPD_));
        If DAT_OPL < DAT_ROZ
         then sNls := B_1919;  NAZN1_ := sZABORK;
         else sNls := B_1819;  NAZN1_ := sZABORD;
        end if;
        bars_audit.trace('%s sNls = %s, NAZN1_ = %s (REF_MAIN=null) (ID = %s, tip = %s)', title, sNls, NAZN1_, to_char(nID_), to_char(TIPD_));

        if l_CP_METOD = 0
         then payTT(0,        REF_,   DAT_OPL,  FXB_,   0,
              cpk.kv,   B_4621, SA_,
              cpk.kv,   sNls,   SA_);  -- форвард-номинал с 1919/1819  на 4621
         else payTT(0,        REF_,   VDAT_,    FXB_,   0,
              cpk.kv,   B_4621, SA_,
              cpk.kv,   sNls,   SA_);  -- форвард-номинал с 1919/1819  на 4621
         end if;

        UPDATE opldok
           SET txt = NAZN1_
         WHERE REF = REF_ AND stmt = gl.ASTMT;
     END IF;
   end if;
  ELSE
    /* номинал + переоценка уже есть, надо дописать остальные прводки и оплатить их по плану или по факту согласно полю sos основной операции REF_MAIN */
    bars_audit.trace('%s номинал + переоценка уже есть, надо дописать остальные прводки и оплатить их по плану или по факту согласно полю sos основной операции REF_MAIN (ID = %s, tip = %s) завершился с ошибкой %s', title, to_char(nID_), to_char(TIPD_));
    REF_:= REF_MAIN;

    SELECT DECODE (sos, 5, 1)
      INTO FLAG_OPL_
      FROM oper
     WHERE REF = REF_MAIN;
     bars_audit.trace('%s FLAG_OPL_ = %s (ID = %s, tip = %s)', title, to_char(FLAG_OPL_), to_char(nID_), to_char(TIPD_));
  END IF;

-------------------------------------------------------------------------------
-- сбор необходимого номинала на продажу из существеющих кучек/пакетов
-------------------------------------------------------------------------------
          bars_audit.trace('%s сбор необходимого номинала на продажу из существеющих кучек/пакетов (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
          NN_ := SN_; -- сумма номинала в копейках
          bars_audit.trace('%s NN_ = %s(ID = %s, tip = %s)', title, to_char(NN_), to_char(nID_), to_char(TIPD_));
          if TIPD_ <>  1
           then goto SVOI_CP;
           bars_audit.trace('%s !!goto SVOI_CP!! (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
          end if;
        -------------------------------------------------------------------------------
          <<CHUZI_CP>> null; -- Чужие ЦБ. -- нигде нет перехода сюда
          bars_audit.trace('%s !!<<CHUZI_CP>>!! (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
        -------------------------------------------------------------------------------
          BEGIN
             SELECT op,
                    sumb,
                    DAT_OPL,
                    str_ref
               INTO OP_,
                    Sumb_A,
                    DAT_OPL_A,
                    sREF
               FROM cp_arch
              WHERE REF = REF_;
          EXCEPTION
             WHEN NO_DATA_FOUND

             THEN OP_ := NULL;
          END;

          If NVL(OP_,0) = -2        -- (-2    Продажа чужой ЦБ в будущем)
           then goto RESHTA_;
           bars_audit.trace('%s goto RESHTA_(ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
          end if;

          -- Начальные проводки - номинал+переоценка -- Для будущих и обычных продаж ЧУЖИХ ЦБ  - одинаково
          FOR K IN (  SELECT a.acc,
                             e.REF,
                             a.nls                      NLSA,
                             - (a.ostb + a.ostf)        OSTA,
                             NVL((s.ostb + s.ostf), 0)  OSTS, -- остаток на счете переоценки
                             e.ERAT,
                             e.accs5,
                             e.accs6,
                             e.accs,
                             s.nls                      NLSS, -- счет переоценки
                             s.ostq,
                             s.daos
                        FROM cp_deal e,
                             accounts a,
                             accounts p,
                             accounts s
                       WHERE     e.id = nID_
                             AND e.ryn = nRYN_
                             AND e.acc = a.acc
                             AND e.accP = p.acc(+)
                             AND e.accs = s.acc(+)
                             AND a.ostb + a.ostf < 0
                             AND nNBS_ IN (SUBSTR (A.nls, 1, 4), NVL (SUBSTR (P.nls, 1, 4), ''))
                             AND (nREPO_ IS NULL OR e.REF = nREPO_)
                    ORDER BY e.REF) -- берем кучки/сделки хронологически, вначале самые старые
          loop
             if NN_ > 0
             then /* номинал */
                N_ := LEAST(NN_, k.OSTA); -- сумма номинала кучки/сделки
                NN_:= NN_ - N_ ;          -- набираем сумму номинала для сделки продажи из имеющихся кучек/сделок
                bars_audit.trace('%s N_ = %s, NN_ = %s (ID = %s, tip = %s)', title, to_char(N_), to_char(NN_), to_char(nID_), to_char(TIPD_));
                IF cpk.dox = 1
                THEN   -- для 1.Нефiкс.прибуток (дивиденд)
                       -- Дт. Кт. Счет номинала на сумму номинала
                       PAYTT(0,        REF_,       VDAT_, FXB_, 0,
                             cpk.kv,   k.NLSA,     N_,
                             cpk.kv,   CP_nls8_,   N_);
                ELSE   -- для 2.Борговi ЦП / 21.Купон (%>0) Зовнўшня позика
                       -- Дт. Транизитный счет Кт. Счет номинала на сумму номинала
                       PAYTT(0,        REF_,   VDAT_,  FXB_, 0,
                             cpk.kv,   k.NLSA,         N_,
                             cpk.kv,   S_TRANS_DK_NLS, N_);
                END IF;

                UPDATE opldok
                   SET txt = sNOMINAL
                 WHERE REF = REF_
                   AND stmt = gl.ASTMT;

                LOG('CP_PROD N ref='||ref_||' '||k.ref||' '||k.nlsa||' '||NN_||' '||N_,'INFO');

                -------
                l_koeff := abs(N_/k.OSTA);
                bars_audit.trace('%s l_koeff = %s, k.OSTA = %s (ID = %s, tip = %s)', title, to_char(l_koeff), to_char(k.OSTA), to_char(nID_), to_char(TIPD_));
                bars_audit.info(title||': l_koeff =' || to_char(l_koeff));
                -- Расчет и Сохр коеф-та пропорции при продаже из кучки НЕ в OPLDOK, а в отдельной новой табл CP_FORW
                INSERT INTO CP_FORW (REF, STMT, DK, ACC, TXT, TT, FDAT, S, SQ, SOS, SS, SSQ)
                   SELECT REF,
                          STMT,
                          dk,
                          acc,
                          TO_CHAR (l_koeff),
                          TT,
                          FDAT,
                          S,
                          SQ,
                          SOS,
                          ROUND (l_koeff * k.OSTS, 0),
                          DECODE (k.accs6,
                                  NULL, ROUND (l_koeff * k.OSTQ, 0),
                                  fost (k.accs6, gl.bdate))
                     FROM opldok
                    WHERE REF = REF_
                      AND stmt = gl.aStmt
                      AND acc = k.acc;

                LOG('CP_PROD ref='||ref_||' '||k.ref||' '||round(l_koeff*k.OSTS,0)||' '||round(l_koeff,4),'INFO');

                -- гарантии на пакет необходимо пересмотреть
                /* cp_warranty_method.id = 1 -- полное удаление гарантии
                   cp_warranty_method.id = 2 -- уменьшение гарантии в удельном весе */
                begin
                   select cd.REF,
                          sz.pawn,
                          A.nls,
                          A.kv,
                          p.acc,
                          p.accs,
                          case
                            when to_number(case when l_koeff = '1' then '1' else AW.VALUE end) = '1'
                            then ABS(A.ostb)
                            when to_number(case when l_koeff = '1' then '1' else AW.VALUE end) = '2'
                            then ABS(A.ostb) * l_koeff
                          end,
                          SZ.idz,
                          SZ.cc_idz,
                          SZ.sdatz,
                          C.rnk,
                          case when to_char(l_koeff) = '1' then '1' else AW.VALUE end, -- Если пакета после продажи нет, но обеспечение пропорционально списывается, тогда обеспечения нет - то есть при полной продаже - делать списание.
                          A.OB22
                    bulk collect
                    into l_cp_warrantyset
                    FROM  cc_accp P,
                          pawn_acc SZ,
                          accounts A,
                          accountsw aw,
                          customer C,
                          cp_deal cd
                    WHERE     SZ.acc = p.acc
                          AND p.rnk = C.rnk
                          AND a.acc = aw.acc
                          AND aw.tag = 'CP_WARR'
                          AND a.acc = P.acc
                          AND cd.acc = p.accs
                          and cd.ref = p.nd
                          and cd.ref = k.ref
                          and to_number(case when l_koeff = '1' then '1' else AW.VALUE end) in (1,2);

                exception when no_data_found then bars_audit.trace('CP: для пересмотра нет гарантий пакета REF='|| to_char(k.ref));
                end;

                if l_cp_warrantyset.count > 0
                 then
                  for w in 1..l_cp_warrantyset.count
                  loop
                     bars_audit.trace('%s l_cp_warrantyset (l_cp_warrantyset(w).cp_war+1 = %s, S = %s)', title, to_char(l_cp_warrantyset(w).cp_war+1),to_char(l_cp_warrantyset(w).s));
                        p_cp_addwarranty(p_mode    => l_cp_warrantyset(w).cp_war+1,    -- 0-вставка, 1-изменение, 2-удаление, 3-пропорциональное уменьшение
                                         p_ref     => l_cp_warrantyset(w).ref_,        -- референс сделки с ЦП
                                         p_pawn    => l_cp_warrantyset(w).pawn,        -- вид обеспечения                                                   |
                                         p_kv      => l_cp_warrantyset(w).kv,          -- валюта                                                            | для открытия счета гарантии
                                       --p_ob22    => l_cp_warrantyset(w).ob22,        -- OB22                                                              |
                                         p_CP_WAR  => l_cp_warrantyset(w).cp_war,      -- параметр вида изменения гарантии при частичном погашении/продаже  |
                                         p_rnk     => l_cp_warrantyset(w).rnk,         -- РНК третьего лица, дающего гарантии
                                         p_s       => l_cp_warrantyset(w).s,           -- сумма гарантии
                                         p_ccnd    => l_cp_warrantyset(w).CC_IDZ,      -- номер договора гарантии
                                         p_sdate   => l_cp_warrantyset(w).sdatz,       -- дата договора гарантии
                                         p_nls     => l_cp_warrantyset(w).nls);        -- счет 9 класса
                   bars_audit.trace('CP: пересмотрена гарантия пакета REF='|| to_char(l_cp_warrantyset(w).ref_)|| ' на сумму '|| to_char(l_cp_warrantyset(w).s) || ' по счету '|| l_cp_warrantyset(w).nls);
                  end loop;
                end if;
                -------- Обеспечение на 1 шт.ЦБ -- тут повтор p_cp_addwarranty
               /* BEGIN
                    SELECT a.nls,  c.acc,  a.kv,  c.id, c.REF, a.rnk, a.ob22, ABS(A.ostc)/100 * l_koeff
                      INTO l_nlsz, l_accs, l_kvz, l_id, l_ref, l_rnk, l_ob22, l_sz
                      FROM cp_deal c, cc_accp p, accounts a
                     WHERE REF = k.REF
                       AND c.acc = p.accs
                       AND p.acc = a.acc;

                   P_cp_ZAL(l_nlsz, l_accs, l_kvz, null, l_id, l_ref, l_rnk, l_ob22, -l_sz, l_ref, 1 );
                EXCEPTION WHEN NO_DATA_FOUND
                          THEN NULL;
                END;*/
                --------
                --  Если есть резерв (5121) - добавляется проводка Дт 5121 (дочерний счет) - Кт 5040
                IF k.ACCS5 IS NOT NULL  -- НБУ.Доч.счет 5121.
                THEN
                    SELECT *
                      INTO aa
                      FROM accounts
                     WHERE acc = k.ACCS5;
                   IF aa.ostc > 0
                   THEN
                    S_ := ABS(ROUND(ABS(N_/k.OSTA) * (aa.ostb + aa.ostf),0));

                    PAYTT(FLAG_OPL_,    ref_,               VDAT_,  FXB_,   1,
                          aa.kv,        aa.NLS,             S_,  -- НБУ.Доч.счет 5121.
                          aa.kv,        RI_CPACCC.nls_5040, S_); -- НБУ.Счет ФУ 5040. Используем при продаже

                    UPDATE opldok
                       SET txt = 'Сума позитивного результату переоцінки'
                     WHERE REF = REF_
                       AND stmt = gl.ASTMT;

                      LOG('CP_PROD 5 ref='||REF_||' '||k.ref||' '||aa.nls||' '||S_||' '||(aa.ostb + aa.ostf),'INFO');
                   END IF;
                END IF;

                If k.osts <> 0 OR k.ACCS IS NOT NULL OR k.ACCS6 IS NOT NULL  -- остаток на счете переоценки кучки/сделки не нуль, или счет переоценки не пуст, или счет 6300 не пуст
                then
                   If k.osts > 0  then dk_ := 1; NAZN1_ := sPEREOV;
                   else                dk_ := 0; NAZN1_ := sPEREOP;
                   end if;

                   S_  := ABS(ROUND(ABS(N_/k.OSTA) * k.ostS,0));
                   SQ_ := gl.p_icurval(cpk.kv, S_, VDAT_);

                   IF CP_RT_ = '1' or k.ACCS6 IS NOT NULL  --(0=Сумма переоц не вкл в торг.рез., 1= вкл) или (НБУ.Доч.счет 6300 прописан)
                   THEN
                      if S_ != 0 then
                        -- проводка Дт(Кт)счет переоценки - Дт(Кт)Транзитный счет
                        PAYtt(FLAG_OPL_,    REF_,   VDAT_,  FXB_,   dk_,
                              cpk.kv,       k.NLSS,         S_,
                              cpk.kv,       S_TRANS_DK_NLS, S_);

                        UPDATE opldok
                           SET txt = NAZN1_
                         WHERE REF = REF_
                           AND stmt = gl.ASTMT;

                        LOG('CP_PROD S ref='||ref_||' '||k.ref||' '||k.nlss||' '||S_||' '||k.osts,'INFO');
                      end if;

                      IF k.ACCS6 IS NOT NULL -- НБУ.Доч.счет 6300.
                      THEN
                        SELECT *
                          INTO aa
                          FROM accounts
                         WHERE acc = k.ACCS6;

                        if aa.ostc > 0 then dk_:=1; NAZN1_ := sPEREOP;  -- Полож.рез.переоценки
                        else                dk_:=0; NAZN1_ := sPEREOV;  -- Отриц.рез.переоценки
                        end if;

                        S_ := ABS(ROUND(ABS(N_/k.OSTA) * (aa.ostb + aa.ostf) ,0));

                        PAYTT(FLAG_OPL_,    REF_,               VDAT_,  'FXP',  DK_,
                              aa.kv,        aa.nls,             S_,
                              gl.baseval,   RI_CPACCC.nls_FXR,  S_);

                        UPDATE opldok
                           SET txt = NAZN1_
                         WHERE REF = REF_
                           AND stmt = gl.ASTMT;

                         LOG('CP_PROD 6 ref='||REF_||' '||k.ref||' '||aa.nls||' '||S_||' '||(aa.ostb + aa.ostf),'INFO');
                      end if;
                   ELSE
                      bars_audit.trace('%s Поиск предыдущей переоценки', title);
                      BEGIN                                                 --COBUSUPABS-3715
                         SELECT MAX (fdat)
                           INTO l_prev_vdat
                           FROM opldok
                          WHERE acc = k.accs
                            AND sos = 5
                            AND fdat >= k.daos
                            AND fdat < gl.bdate;
                         bars_audit.trace('%s Дата предыдущей переоценки = %s', title, to_char(l_prev_vdat,'dd.mm.yyyy'));
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN l_prev_vdat := gl.bdate;
                              bars_audit.trace('%s Дата предыдущей переоценки не найдена', title);
                      END;                                                  --/COBUSUPABS-3715

                       SQ_ := gl.p_icurval(cpk.kv, S_, NVL(l_prev_vdat,VDAT_));

                      -- проводка Дт.(Кт.) счет переоценки кучки - Дт.(Кт.) консолидированный счет переоценки
                      PAYTT(FLAG_OPL_,  REF_,               VDAT_,  'FXP',  dk_,
                            cpk.kv,     k.NLSS,             S_,   -- счет переоценки кучки
                            gl.baseval, RI_CPACCC.nls_FXP,  SQ_); -- Переоценка назад, откуда появилась (Рах.FXР~неРЕАЛIЗОВ.рез~переоц)

                      UPDATE opldok
                         SET txt = NAZN1_
                       WHERE REF = REF_
                         AND stmt = gl.ASTMT;
                   END IF;
                END IF;  -- k.osts
             END IF;  -- NN
            -- наполняем очередь для модификации потоков
            cp.RMany_DAT(k.REF, REF_, VDAT_,N_, 0);
          END LOOP;

  IF NN_ > 0 --(набранная и уменьшенная в цикле сумма номинала из кучек не вместилась в требуемую сумму продажи ЦП)
  THEN
    sERR := '22.Нет нужной суммы номинала';
    bars_audit.trace('%s Неудачно набранная сумма продажи (ID = %s, tip = %s): %s', title, to_char(nID_), to_char(TIPD_), sERR);
    RETURN;  -- откат операции
  END IF;

-------------------------------------------------------------------------------
-- если набрали сумму на продажу из пакетов, фиксируем в архиве сделок
-------------------------------------------------------------------------------

  IF DAT_ROZ > DAT_UG       -- Документ майбутнього періоду
  THEN -- все остальные составляющие сделаем потом
    bars_audit.trace('%s Документ майбутнього періоду (DAT_ROZ > DAT_UG) (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
    INSERT INTO cp_arch (REF, ID,   DAT_UG, DAT_OPL, DAT_ROZ, SUMB, N,  R,  STR_REF, OP, REF_REPO)
         VALUES         (REF_,nID_, DAT_UG, DAT_OPL, DAT_ROZ, SA_,  SN_,R2_,sREF,    -2, nREPO_);   -- (OP = -2    Продажа чужой ЦБ в будущем)

     IF nREPO_ IS NOT NULL
     THEN
        UPDATE cp_arch
           SET REF_REPO = REF_
         WHERE REF = nREPO_;

        UPDATE cp_arch
           SET acc = l_accn1
         WHERE REF = REF_;
     END IF;

    UPDATE oper
       SET sos = 3      --3    Документ майбутнього періоду
     WHERE REF = REF_;
    RETURN;
  END IF;

------------------------------------------------------------------------------
-- Дополнительные проводки - (D, P. R. R2,...) в дату валютирования
------------------------------------------------------------------------------
  <<RESHTA_>> null;
  bars_audit.trace('%s <<RESHTA_>> (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));

  B4621R := S_TRANS_DK_NLS;
  r2a_   := abs(R2_);

  If sign(R2_) = -1
  then
     sERR := '21r.Нет сч. Деб.заб для вiд`ємного купону';
     r2a_ := l_fulkup - r2a_;   -- повинен = R+R2
     begin
        SELECT NLS
          INTO B4621R
          FROM accounts
         WHERE nls = RI_CPACCC.B4621R
           AND kv = cpk.KV
           AND dazs IS NULL;

       sERR := '';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN bars_audit.trace('%s Доп проводки неуспешные (ID = %s, tip = %s) с ошибкой: %s', title, to_char(nID_), to_char(TIPD_), sERR);
                    RETURN;
     END;
  end if;
------------------------------------------------------------------------------
  LOG('CP_PROD-1 ref='||REF_,'INFO');
  bars_audit.trace('%s Доп проводки начало цикла (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
  FOR k IN (  SELECT a.acc,
                     e.REF,
                     e.accs,
                     r2.nls             NLSR2,
                     -NVL (r2.ostB, 0)  OSTR2,
                     r3.nls             NLSR3,
                     -NVL (r3.ostB, 0)  OSTR3,
                     d.nls              NLSD,
                     NVL (d.ostB, 0)    OSTD,
                     p.nls              NLSP,
                     -NVL (p.ostB, 0)   OSTP,
                     r.nls              NLSR,
                     -NVL (r.ostB, 0)   OSTR
                FROM accounts a,
                     accounts d,
                     accounts p,
                     accounts r,
                     accounts r2,
                     accounts r3,
                     (SELECT REF, ACC, ACCD, ACCP, ACCR, ACCR2, ACCR3, ACCS,
                             (SELECT SUM(S)
                                FROM opldok
                               WHERE acc = ee.acc
                                 AND REF >= REF_
                                 AND s <> 0
                                 AND dk = 1) N
                        FROM cp_deal ee
                       WHERE acc IN (SELECT acc
                                       FROM opldok
                                      WHERE REF = REF_ AND dk = 1)) e
               WHERE     a.acc = e.acc
                     AND e.accd = d.acc(+)
                     AND e.accp = p.acc(+)
                     AND e.accr = r.acc(+)
                     AND e.accr2 = r2.acc(+)
                     AND e.accr3 = r3.acc(+)
                     AND (d.ostb <> 0 OR p.ostb <> 0 OR r.ostb <> 0 OR r2.ostb <> 0 OR r3.ostb <> 0)
            ORDER BY e.REF)
  LOOP
     -- Вычитать l_koeff
    bars_audit.trace('%s Цикл доп проводок k.acc = %s (ID = %s, tip = %s)', title, to_char(k.acc), to_char(nID_), to_char(TIPD_));
    BEGIN
       SELECT TO_NUMBER(txt)
         INTO l_koeff
         FROM cp_forw
        WHERE REF = REF_
          AND acc = k.acc
          AND TO_NUMBER(txt) < 1;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN l_koeff := 1;
    END;
    bars_audit.trace('%s Цикл доп проводок k.acc = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(k.acc), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
    -- наполняем очередь для модификации потоков
    bars_audit.trace('%s наполняем очередь для модификации потоков k.acc = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(k.acc), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
    cp.RMany_DAT(k.REF, REF_, VDAT_, N_,0);

     -- Реальный дисконт в удельном весе
    IF k.OSTD > 0
    THEN
       bars_audit.trace('%s Цикл доп проводок Реальный дисконт в удельном весе k.OSTD = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(k.OSTD), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
       S_:= ROUND(k.OSTD * l_koeff, 0);

       PAYTT(FLAG_OPL_,    ref_,   VDAT_,  FXB_,   1,
             cpk.kv,       k.NLSD,         S_,
             cpk.kv,       S_TRANS_DK_NLS, S_);

       UPDATE opldok
          SET txt = sDISKONT
        WHERE REF = REF_
          AND stmt = gl.ASTMT;

        LOG('CP_PROD D ref='||ref_||' '||k.REF||' '||k.nlsd||' '||S_||' '||k.ostd,'INFO');

       SD_ := SD_ + S_; -- с накоплением в цикле
    END IF;

     -- виртуальный дисконт в удельном весе
    BEGIN
       SELECT a.*
         INTO aa
         FROM cp_ref_acc r,
              accounts a
        WHERE r.REF = k.REF
          AND r.acc = a.acc
          AND a.tip = '2VD'
          AND a.ostB > 0;

       IF aa.daos >= TO_DATE ('01/06/2013', 'dd/mm/yyyy')
       THEN
          l_vdat := aa.daos;
       END IF;

       S_ := ROUND (aa.ostc * l_koeff, 0); -- сумма виртуального дисконта по сделке
       bars_audit.trace('%s Цикл доп проводок сумма виртуального дисконта по сделке S_ = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(S_), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
       IF cpk.kv = gl.baseval
       THEN
          PAYTT (FLAG_OPL_,     ref_,           VDAT_,  FXB_,   1,
                 cpk.kv,        aa.NLS,         S_,
                 gl.baseval,    RI_CPACCC.S2VD2,S_);
       ELSE
          PAYTT (FLAG_OPL_,     ref_,           VDAT_,  'FXF',  1,
                 cpk.kv,        aa.NLS,         S_,
                 gl.baseval,    RI_CPACCC.S2VD2,gl.p_icurval (cpk.kv, S_, l_vdat));
       END IF;

       UPDATE opldok
          SET txt = '2VD:' || sDISKONT
        WHERE REF = REF_
          AND stmt = gl.ASTMT;

       LOG ('CP_PROD VD ref='|| REF_ || ' '|| k.REF|| ' '|| S_ || ' ' || aa.ostc,'INFO');

       VD_ := VD_ + S_;-- с накоплением в цикле суммы виртуального дисконта
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN NULL; -- сознательно гасим ошибку, так как виртульного дисконта может не быть
    END;

     -- Реальная премия в удельном весе
    IF k.OSTP > 0
    THEN
        bars_audit.trace('%s Цикл доп проводок Реальная премия в удельном весе  k.OSTP  = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(k.OSTP), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
        S_:= ROUND(k.OSTP * l_koeff,0);

        -- на счет премии k.NLSP с транзитного счета сумму премии в удельном весе (S_:= ROUND(k.OSTP * l_koeff,0))
        PAYTT(FLAG_OPL_,    ref_,       VDAT_,  FXB_,   0,
              cpk.kv,       k.NLSP,             S_,                 -- на счет премії с транзитного счета сумму премии в удельном весе
              cpk.kv,       S_TRANS_DK_NLS,     S_);

        UPDATE opldok
           SET txt = sPREMIA
         WHERE REF = REF_
           AND stmt = gl.ASTMT;

        LOG('CP_PROD P ref='||ref_||' '||k.REF||' '||k.nlsp||' '||S_||' '||k.ostp,'INFO');
            IF cpk.dox = 1
             THEN  SP_ := SP_ + S_ - N_;-- с накоплением в цикле
             ELSE  SP_ := SP_ + S_;     -- с накоплением в цикле
            END IF;
    END IF;
     --  Виртуальным Премией . . .
     BEGIN
        SELECT a.*
          INTO aa
          FROM cp_ref_acc r,
               accounts a
         WHERE r.REF = k.REF
           AND r.acc = a.acc
           AND a.tip = '2VP'
           AND a.ostB < 0;

        if aa.daos >= to_date('01/06/2013','dd/mm/yyyy')
        then l_vdat := aa.daos;
        end if;

        S_:= ROUND(-aa.ostc * l_koeff, 0);

        if cpk.kv = gl.baseval then PAYtt(FLAG_OPL_, ref_, VDAT_, FXB_,0, cpk.kv,aa.NLS,S_,gl.baseval, RI_CPACCC.s2VP2,                    S_        );
        else                        PAYtt(FLAG_OPL_, ref_, VDAT_,'FXF',0, cpk.kv,aa.NLS,S_,gl.baseval, RI_CPACCC.s2VP2, gl.p_icurval(cpk.kv,S_,l_vdat));
        end if;

        UPDATE opldok
           SET txt = '2VP:' || sPREMIA
         WHERE REF = REF_
           AND stmt = gl.ASTMT;

        LOG('CP_PROD VP ref='||ref_||' '||k.ref||' '||S_||' '||aa.ostc,'INFO');

        VP_ := VP_ + S_; -- с накоплением в цикле
     EXCEPTION WHEN NO_DATA_FOUND
               THEN NULL; -- сознательно гасим ошибку, так как виртульной премии может не быть
     END;

     -- КУПОН
     if k.OSTR > 0 and cpk.dox >= 2
     then
        S_ := ROUND(k.OSTR * l_koeff,0);
        bars_audit.trace('%s Цикл доп проводок КУПОН S_  = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(S_), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
        PAYtt(FLAG_OPL_,    ref_,       VDAT_,  FXB_,   0,
              cpk.kv,       k.NLSR,     S_,
              cpk.kv,       B4621R,     S_);

        UPDATE opldok
           SET txt =DECODE(SIGN(R2_), 1, sKUPON, 'Купон, що вiдшкодовується покупцю')
         WHERE REF = REF_
           AND stmt = gl.ASTMT;

        LOG('CP_PROD R ref='||ref_||' '||k.ref||' '||k.nlsr||' '||S_||' '||k.ostr,'INFO');
        -- наполняем очередь для модификации потоков
        CP.RMany_DAT(k.REF, REF_,VDAT_, 0, S_);

        SR_ := SR_ + S_;-- с накоплением в цикле
        NLSR_bek := k.NLSR;
     END IF;

          -- КУПОН
     if k.OSTR3 > 0 and cpk.dox >= 2
     then
        S_ := ROUND(k.OSTR3 * l_koeff,0);
        bars_audit.trace('%s Цикл доп проводок КУПОН S_  = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(S_), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
        PAYtt(FLAG_OPL_,    ref_,       VDAT_,  FXB_,   0,
              cpk.kv,       k.NLSR3,     S_,
              cpk.kv,       B4621R,      S_);

        UPDATE opldok
           SET txt =DECODE(SIGN(R2_), 1, sKUPON, 'Кривий Купон')
         WHERE REF = REF_
           AND stmt = gl.ASTMT;

        LOG('CP_PROD R ref='||ref_||' '||k.ref||' '||k.nlsr||' '||S_||' '||k.ostr,'INFO');
        -- наполняем очередь для модификации потоков
        CP.RMany_DAT(k.REF, REF_,VDAT_, 0, S_);

        SR_ := SR_ + S_;-- с накоплением в цикле
        NLSR_bek3 := k.NLSR3;
     END IF;

     IF k.OSTR2 <>0
     THEN
        S_ := ROUND( k.OSTR2 * l_koeff,0);
        bars_audit.trace('%s Цикл доп проводок КУПОН R2 S_  = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(S_), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
        If S_ > 0 then  PAYtt(FLAG_OPL_,ref_,VDAT_,FXB_,0, cpk.kv ,k.NLSR2, S_, cpk.kv ,B4621R, S_);
        else            PAYtt(FLAG_OPL_,ref_,VDAT_,FXB_,1, cpk.kv ,k.NLSR2,-S_, cpk.kv ,B4621R,-S_);
        end if;

        UPDATE opldok
           SET txt = sKUPON2
         WHERE REF = REF_ AND stmt = gl.ASTMT;

        LOG('CP_PROD R2 ref='||ref_||' '||k.ref||' '||k.nlsr2||' '||S_||' '||k.ostr2,'INFO');

        -- наполняем очередь для модификации потоков
        CP.RMany_DAT(k.REF, REF_, VDAT_, 0, S_);

        SR_ := SR_ + S_;     -- с накоплением в цикле для вставки в cp_arch
        NLSR_bek := k.NLSR2; -- а как же NLSR_bek := k.NLSR???
     END IF;

     IF k.OSTR3 <>0
     THEN
        S_ := ROUND( k.OSTR3 * l_koeff,0);
        bars_audit.trace('%s Цикл доп проводок КУПОН R3 S_  = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(S_), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
        If S_ > 0 then  PAYtt(FLAG_OPL_,ref_,VDAT_,FXB_,0, cpk.kv ,k.NLSR3, S_, cpk.kv ,B4621R, S_);
        else            PAYtt(FLAG_OPL_,ref_,VDAT_,FXB_,1, cpk.kv ,k.NLSR3,-S_, cpk.kv ,B4621R,-S_);
        end if;

        UPDATE opldok
           SET txt = sKUPON3
         WHERE REF = REF_ AND stmt = gl.ASTMT;

        LOG('CP_PROD R3 ref='||ref_||' '||k.ref||' '||k.nlsr2||' '||S_||' '||k.ostr2,'INFO');

        -- наполняем очередь для модификации потоков
        CP.RMany_DAT(k.REF, REF_, VDAT_, 0, S_);

        SR_ := SR_ + S_;     -- с накоплением в цикле для вставки в cp_arch
        NLSR_bek := k.NLSR3; -- а как же NLSR_bek := k.NLSR???
     END IF;

     IF k.accs IS NOT NULL
     THEN
        SELECT NVL(SUM(DECODE(dk, 0, -1, +1) * s), 0)
          INTO S_
          FROM opldok
         WHERE REF = REF_
           AND acc = k.accs;

        SS_ := SS_ + S_;
     END IF;
  END LOOP;

------------------------------------------------------------------------------
  IF R2_ < 0 -- верно только для РЕПО
  THEN
      bars_audit.trace('%s Цикл доп проводок REPO S_  = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(R2_), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
      PAYTT(FLAG_OPL_,  REF_,   VDAT_,  FXB_,   1,
            cpk.kv,     B4621R,         abs(R2_),
            cpk.kv,     S_TRANS_DK_NLS, abs(R2_));
  ELSE      -- балансировка купона 28.05.2014 Восстановление от 18-02-2010
     bars_audit.trace('%s Цикл доп проводок балансировка купона 28.05.2014 Восстановление от 18-02-2010  SR_  = %s, NLSR_bek = %s (ID = %s, tip = %s), l_koeff = %s', title, to_char(SR_), to_char(NLSR_bek), to_char(nID_), to_char(TIPD_), to_char(l_koeff));
     IF NLSR_bek IS NOT NULL AND SR_ <> RR_*100
     THEN
         S_ := SR_ - RR_ * 100;
         IF S_ > 0
         THEN   DK_ := 1;   -- взяла больше, чем надо. Возврат в последную кучку
         ELSE   DK_ := 0;   -- взяла меньше, чем надо. Дозабрать из последней кучки. если там есть. иначе - свал
                BEGIN
                   SELECT 1
                     INTO nTmp_
                     FROM accounts
                    WHERE nls = NLSR_bek
                      AND kv = cpk.kv
                      AND OSTB - S_  <= 0;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN sERR := 'Нет достаточной суммы начисленного купона';
                        bars_audit.trace('%s Цикл доп проводок c ошибкой S_  = %s (ID = %s, tip = %s), sERR = %s', title, to_char(S_), to_char(nID_), to_char(TIPD_), sERR);
                        RETURN;
                END;
         END IF;

      SR_ := SR_ - S_;
      S_  := ABS(S_);

      PAYTT(FLAG_OPL_,  REF_,       VDAT_,  FXB_,   DK_,
            cpk.kv,     NLSR_bek,   S_,
            cpk.kv,     B4621R,     S_);

      UPDATE opldok
         SET txt = sKUPON
       WHERE REF = REF_
         AND stmt = gl.ASTMT;
     END IF;
  END IF;   -- r2
------------------------------------------------------------------------------
    /*
       If CP_RT_ ='1' then    T_:= SA_ - SN_ + SD_  - SP_  - SR_ - SS_ ;
       else                   T_:= SA_ - SN_ + SD_  - SP_  - SR_;
       end if;
    */
   -- 08.10.2014 Сухова.
   -- Торговый рез от продажи - это сальдо торгового счета S_TRANS_DK_NLS для этой сделки
   -- Боже ! Как же это теперь очевидно !

    SELECT NVL(SUM(DECODE(dk, 1, +1, -1) * S), 0) + SA_
      INTO T_
      FROM opldok o, accounts a
     WHERE o.REF = REF_
       AND o.acc = a.acc
       AND a.kv  = cpk.kv
       AND a.nls = S_TRANS_DK_NLS;

   -- делаем проводку по учету торгового результата
   IF T_ > 0 -- положительный торговый результат
   THEN
    bars_audit.trace('%s Цикл доп проводок Учёт (+) торгового результата  T_ = %s (ID = %s, tip = %s)', title, to_char(T_), to_char(nID_), to_char(TIPD_));
    PAYTT(FLAG_OPL_,    REF_,   VDAT_,  'FXT',  1,
          cpk.kv,       S_TRANS_DK_NLS, T_,
          gl.baseval,   NLS62_, gl.p_icurval(cpk.kv ,T_, VDAT_));
    UPDATE opldok
       SET txt = sTORGP
     WHERE REF = REF_ AND stmt = gl.ASTMT;
   ELSIF T_ < 0 -- отрицательный торговый результат
   THEN
    bars_audit.trace('%s Цикл доп проводок Учёт (-) торгового результата  T_ = %s (ID = %s, tip = %s)', title, to_char(T_), to_char(nID_), to_char(TIPD_));
    PAYtt(FLAG_OPL_,  REF_,     VDAT_,  'FXT',  0,
          cpk.kv,     S_TRANS_DK_NLS,   -T_,
          gl.baseval, NLS62_,   gl.p_icurval(cpk.kv ,-T_, VDAT_));
    UPDATE opldok
       SET txt = sTORGV
     WHERE REF = REF_ AND stmt = gl.ASTMT;
   END IF;
   bars_audit.trace('%s Цикл доп проводок Фиксируем в архиве (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
   UPDATE cp_arch
      SET d    = SD_,
          vd   = VD_,
          p    = SP_,
          vp   = VP_,
          r    = R2_,
          s    = SS_,
          op   = ABS(Op),
          t    = T_,
          tq   = gl.p_icurval(cpk.kv, T_, gl.bdate)
    WHERE REF = REF_;

   -- Ощад просит CP_ARCH.br = RI_CPACCC.vidd  26/09-14
   IF SQL%ROWCOUNT = 0
   THEN
      bars_audit.trace('%s В архиве нет записей с ref = %s (Ощад просит CP_ARCH.br = RI_CPACCC.vidd  26/09-14 - Вставляем!) (ID = %s, tip = %s)', title, to_char(REF_), to_char(nID_), to_char(TIPD_));
      -- продали чужую ЦБ в будущем
      INSERT INTO cp_arch (REF, ID,  DAT_UG,DAT_OPL,DAT_ROZ, SUMB,  N,  STR_REF, OP,                           REF_REPO,    D,  P,  R,  S,  VD, VP, T,  TQ)
           VALUES         (REF_,nID_,DAT_UG,DAT_OPL,DAT_ROZ, SA_,   SN_,sREF,    DECODE(DAT_ROZ,l_datpm,20,2), nREPO_,      SD_,SP_,R2_,SS_,VD_,VP_,T_, gl.p_icurval(cpk.kv, T_, gl.bdate));  -- SR_

      IF nREPO_ IS NOT NULL
      THEN
        UPDATE cp_arch
           SET REF_REPO = REF_
         WHERE REF = nREPO_;
      END IF;
   END IF;

   -- Для форвардного купона
   cp.cp_FORV_KUP(nID_);
   RETURN;
------------------------------------------------------------------------------
  <<SVOI_CP>> null;   -- продажа СВОИХ бумаг
  bars_audit.trace('%s <<SVOI_CP>> продажа СВОИХ бумаг (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));
------------------------------------------------------------------------------
  s8_:= SUBSTR('000000000'|| REF_CP_NBU(REF_), -8);
  N_ := SUMBN *100;  -- номинал
  S_ := SUMB  *100;  -- вартисть пакета
  K_ := SUMBK *100;  -- сумма комиссии
  R_ := RR_   *100;  -- купон

  cp_id_r := null;
  if gl.AMFO in ('300001') or l_mfou = '300465'
  then
     cp_id_r := cpk.cp_id||'/' ;
  end if;

  BEGIN
    IF cpk.dox >= 2 AND N_ <> S_ -- возникновени дисконта или премии, когда стоимость пакета не равна номиналу
    THEN
       sERR := '24.Нет сч.дох. по ам. Д/П';

        SELECT ad.acc, ap.acc
          INTO ACRB_D, ACRB_P           -- консолидированные счета дисконта и премии для субпортфеля
          FROM accounts aD, accounts aP, cp_accc c
         WHERE     aD.kv  = gl.baseval
               AND aD.nls = c.s605      -- асс счета амортизации дисконта
               AND aP.kv  = gl.baseval
               AND aP.nls = c.s605P     -- асс счета амортизации премии
               AND c.emi  = cpk.emi
               AND c.vidd = nNBS_
               AND c.RYN  = nRYN_;
    END IF;

    sERR := '25.Нет осн.сч. в ФУ';

    SELECT a.acc,
           SUBSTR (cp_id_r || a.nms, 1, 38),
           a.nls,
           SUBSTR (a.nls, 1, 5) || '0' || s8_
      INTO accc_, NMS_, NLSG_, NLS_
      FROM accounts a, cp_accc p
     WHERE     a.nls  = p.nlsA -- счет номинала
           AND a.kv   = cpk.kv
           AND p.vidd = nNBS_
           AND p.emi  = cpk.emi
           AND p.RYN  = nRYN_;

  EXCEPTION WHEN NO_DATA_FOUND
            THEN RETURN;
  END;

  sERR := NULL;

  -- открытие счета номинала ЦП (по маске консолидированного счета номинала)
  cp.CP_REG_EX(99, 0, 0, GRP_, r1_, cpk.rnk, NLS_, cpk.kv, NMS_, 'ODB', gl.aUid, acc_);

  UPDATE accounts
     SET mdate = cpk.datp,
         accc = ACCC_,
         seci = 4,
         pos = 1
   WHERE acc = ACC_;

  -- Дт. Транзитный счет Кт. Счет номинала сделки
  PAYTT(0,      REF_,       VDAT_,  FXB_,   0,
        cpk.kv, NLS_,       N_,
        cpk.kv, S_TRANS_DK_NLS,     N_);

  UPDATE opldok
     SET txt = sNOMINAL
   WHERE REF = REF_
     AND stmt = gl.ASTMT;

  F_REF(REF_, sREF, sREF);
     begin
        insert into cp_payments(cp_ref, op_ref)
        values (REF_, REF_);
     exception when others then null;
     end;

  cpk.CENA_KUP := ROUND(GREATEST(0, cpk.CENA_KUP * N_ - R_), 0) ;

  IF  cpk.ir > 0 or cpk.CENA_KUP > 0  -- если годовая %% ставка > 0 или цена купона > 0
  THEN
     -- Для начисления (амортизации) купона в дальнейшем     -- Счет нач ???8 и доходов 6???
    BEGIN
       SELECT a.acc,
              SUBSTR (cp_id_r || a.nms, 1, 38),
              SUBSTR (a.nls, 1, 5) || '0' || s8_,
              a6.acc,
              DECODE (cpk.kv, gl.baseval, P.tt, P.ttv),
              NVL (cpk.io, NVL (p.io, 0))
         INTO acccR_, NMS_, NLS_, accR6_, TTV_, IO_
         FROM accounts a,
              cp_accc C,
              proc_dr$base P,
              ACCOUNTS A6
        WHERE     a.nls  = C.nlsR
              AND a.kv   = cpk.kv
              AND C.vidd = nNBS_
              AND C.emi  = cpk.emi
              AND P.nbs  = nNBS_
              AND a6.kv  = gl.baseval
              AND a6.nls = C.nls_pr
              AND c.RYN  = nRYN_
              AND A.DAZS IS NULL
              AND A6.DAZS IS NULL;

       IF cpk.IO IS NOT NULL
       THEN IO_ := cpk.IO;
       END IF;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN sERR := '26.Нет сч.НАЧ.% в ФУ';
            RETURN;
    END;

    -- открытие счета начисленных процентов
    cp.CP_REG_EX(99, 0, 0, GRP_, r1_, cpk.rnk, NLS_, cpk.kv, NMS_,'ODB', gl.aUid, accR_);

    IF IO_ = 1 AND cpk.DAT_EM < cpk.datp - 1 THEN  IO_ := 1; -- депозит ( минус 1 день)
    ELSE                                           IO_ := 0; -- умолчательный (по дате) овернайт.
    END IF;    -- ! актуальне для ДС НБУ

     --20.05.2008

    IF R_<>0  THEN /* Для НАКОПИЧЕНОГО (проданного) купона */
        BEGIN
           SELECT a.acc,
                  SUBSTR (cp_id_r || a.nms, 1, 38),
                  SUBSTR (a.nls, 1, 5) || '2' || S8_
             INTO ACCCR2_, NMS_, NLS_
             FROM accounts a, cp_accc c
            WHERE     a.nls = c.nlsR2
                  AND a.kv = cpk.kv
                  AND c.vidd = nNBS_
                  AND c.emi = cpk.emi
                  AND c.RYN = nRYN_;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN sERR := '26.Нет сч.НАКОП.% в ФУ';
                RETURN;
        END;

        cp.CP_REG_EX(99,0,0,GRP_,r1_, cpk.rnk ,nls_, cpk.kv ,NMS_,'ODB',gl.aUid,accR2_);

        UPDATE accounts
           SET mdate = cpk.dnk - 1,
               accc = ACCCR2_,
               seci = 4,
               pos = 1
         WHERE acc = accR2_;

        IF r_ > 0
         THEN DK_:=0;
         ELSE DK_:=1;
        END IF;

        PAYTT(0,        ref_,   VDAT_,  FXB_,   DK_,
              cpk.kv,   NLS_,   R_,
              cpk.kv,   S_TRANS_DK_NLS, R_);

        UPDATE opldok
           SET txt = SUBSTR ('Код ' || cpk.cp_id || ' ' || sKUPON2 || T4_, 1, 70)
         WHERE REF = REF_
           AND stmt = gl.ASTMT;
    END IF;

    IF cpk.CENA_KUP >0
    THEN
       UPDATE accounts
          SET mdate = cpk.dnk - 1,
              accc = ACCCR_,
              seci = 4,
              OSTF = -cpk.CENA_KUP,
              pos = 1
        WHERE acc = accR_;

       INSERT INTO int_accn (ACC,   ID, ACRA,   ACRB,   METR,   TT,                 BASEY,      FREQ,   ACR_DAT,        IO)
            VALUES          (accR_, 0,  accR_,  accR6_, 4,      NVL(TTV_,'FX%'),    cpk.basey,  1,      gl.BDATE-1+IO_, IO_);
     else
        UPDATE accounts
           SET mdate = cpk.dnk - 1,
               accc = ACCCR_,
               seci = 4,
               OSTF = -cpk.CENA_KUP,
               pos = 1
        WHERE acc = accR_;

        INSERT INTO int_accn (ACC,  ID, ACRA,   ACRB,   METR,   TT,                 BASEM,  BASEY,      FREQ,   ACR_DAT,            STP_DAT,        IO)
             VALUES          (acc_, 1,  accR_,  accR6_, l_metr, NVL (TTV_, 'FX%'),  0,      cpk.basey,  1,      gl.BDATE - 1 + IO_, cpk.datp - 1,   IO_);

        INSERT INTO int_ratn (ACC, ID, BDAT,     IR)
             VALUES          (acc_, 1, gl.bdate, cpk.ir);
    END IF;
  END IF;

  V1_ := (S_ + K_) * cpk.cena * 100 / N_;  --собиварт продажу 1 ЦП
  DP_ := S_ - R_ - N_;

  IF DP_< 0
   THEN  D_ := -DP_; P_ := 0;
   ELSE  D_ := 0;    P_ := DP_;
  END IF;
------------------------------------------------------------------------------
  If P_> 0 -- Премия
  THEN
    BEGIN
       SELECT a.acc,
              SUBSTR (cp_id_r || a.nms, 1, 38),
              SUBSTR (a.nls, 1, 5) || DECODE (cpk.dox, 1, '1', '0') || S8_
         INTO accc_, NMS_, NLS_
         FROM accounts a, cp_accc p
        WHERE     a.nls = p.nlsP
              AND a.kv = cpk.kv
              AND p.vidd = nNBS_
              AND p.emi = cpk.emi
              AND p.RYN = nRYN_;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN
          sERR := '2.Нет сч.премии в ФУ';
          RETURN;
    END;
    l_NLS_DP := NLS_;
   -- открытие счета премии (по маске счета консолидированной премии)
   cp.CP_REG_EX(99, 0, 0, GRP_, r1_, cpk.rnk, nls_, cpk.kv, NMS_, 'ODB', gl.aUid, accP_);

    UPDATE accounts
       SET mdate = cpk.datp,
           accc = ACCC_,
           seci = 4,
           pos = 1
     WHERE acc = accP_;

     IF cpk.dox >= 2 -- вид доходности 2.Борговi ЦП/21.Купон (%>0) Зовнўшня позика
     THEN
        INSERT INTO INT_ACCN (ACC,  ACRA,   ACRB,   ID, METR,   ACR_DAT,    S,      STP_DAT,    IO,     BASEY,  FREQ)
             VALUES          (ACC_, ACCP_,  ACRB_P, 2,  6,      gl.bdate-1, V1_,    cpk.datp-1, IO_,    0,      1);
     END IF;

     PAYTT(0,       REF_,   VDAT_,  FXB_,   0,
           cpk.kv,  NLS_,   P_,
           cpk.kv,  S_TRANS_DK_NLS, P_);

      UPDATE opldok
        SET txt = sPREMIA
      WHERE REF = REF_
        AND stmt = gl.ASTMT;

     if K_ > 0  -- сумма комиссии
     THEN
        PAYtt(0,        REF_,   VDAT_,  FXB_,   1,
              cpk.kv,   NLS_,   K_,
              cpk.kv,   S_TRANS_DK_NLS, K_);

        UPDATE opldok
           SET txt = sKOMIS
         WHERE REF = REF_
           AND stmt = gl.ASTMT;
     END IF;
  END IF;

  IF D_ > 0 -- Дисконт
  THEN
    -- наследование счета и наименования от консолидированного счета дисконта из cp_accc
    BEGIN
       SELECT a.acc,
              SUBSTR (cp_id_r || a.nms, 1, 38),
              SUBSTR (a.nls, 1, 5) || DECODE (cpk.dox, 1, '2', '0') || S8_
         INTO accc_, NMS_, NLS_
         FROM accounts a, cp_accc p
        WHERE     a.nls  = p.nlsD
              AND a.kv   = cpk.kv
              AND p.vidd = nNBS_
              AND p.emi  = cpk.emi
              AND p.RYN  = nRYN_;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN sERR := '28.Нет сч.диск в ФУ';
            RETURN;
    END;
    l_NLS_DP := NLS_;
    -- открытие счета дисконта (по маске консолидированного счета дисконта)
    cp.CP_REG_EX(99, 0, 0, GRP_, r1_, cpk.rnk, nls_, cpk.kv, NMS_, 'ODB', gl.aUid, accD_);

    UPDATE accounts
       SET mdate = cpk.datp,
           accc = accc_,
           seci = 4,
           pos = 1
     WHERE acc = accD_;

     if cpk.dox >= 2 then -- для видов доходности 2.Борговi ЦП/ 21.Купон (%>0) Зовнішня позика
        INSERT INTO int_accn (ACC,  ACRA,   ACRB,   ID, METR,   ACR_DAT,    S,      STP_DAT,    IO, BASEY,  FREQ)
             VALUES          (ACC_, ACCD_,  ACRB_D, 3,  6,      gl.bdate-1, V1_,    cpk.datp -1,IO_,0,      1);
     end if;

    -- Дт. счет дисконта Кт. Транзитный счет на сумму дисконта
    PAYTT(0,        REF_,   VDAT_,  FXB_,   1,
          cpk.kv,   NLS_,   D_,
          cpk.kv,   S_TRANS_DK_NLS, D_);

    UPDATE opldok
       SET txt = sDISKONT
     WHERE REF = REF_
       AND stmt = gl.ASTMT;

    IF K_ > 0  -- сумма комиссии
    THEN
      -- Дт. консолидированный счет дисконта Кт. Транзитный счет на сумму комиссии за дисконт
        PAYtt(0,        ref_,   VDAT_,  FXB_,   1,
              cpk.kv,   NLS_,   K_,
              cpk.kv,   S_TRANS_DK_NLS, K_);

        UPDATE opldok
           SET txt = sKOMIS
         WHERE REF = REF_
           AND stmt = gl.ASTMT;
    END IF;
  END IF;

  IF cpk.datp > DAT_ROZ AND cpk.dox >= 2 AND DP_ <> 0
  THEN
     KUP1_ := N_*  cpk.ir /36500;               -- купон 1-го дня
     DP1_  := DP_ / (cpk.datp - DAT_ROZ);       -- дисконт/премия 1-го дня
     ERAT_ := (KUP1_ - DP1_) / ((S_ + N_)/2);   -- 05-01-2009 эф.ставка
  END IF;
  -- создание сделки продажи ЦП
  INSERT INTO CP_DEAL(ID,   RYN,    ACC,    ACCD,   ACCP,   ACCR,   ACCR2,  REF,    ERAT)
       VALUES        (nID_, nRYN_,  acc_,   accD_,  accP_,  accR_,  accr2_, REF_,   ERAT_);

  IF K_ > 0 -- комисия
  THEN
    if l_CP_TRANS_DK = 0
    then
     If DAT_KOM > DAT_ROZ -- комиссия завешивается на кредиторскую задолженность
     then
      if l_CP_METOD = 0
      then
        PAYTT(0,        REF_,   DAT_OPL,  FXB_,   1,
              cpk.kv,   B_4621, K_,
              cpk.kv,   B_1919, K_);
      else
        PAYTT(0,        REF_,   VDAT_,    FXB_,   1,
              cpk.kv,   B_4621, K_,
              cpk.kv,   B_1919, K_);
      end if;
        UPDATE opldok
           SET txt = sKOMISK
         WHERE REF = REF_ AND stmt = gl.ASTMT;

     ELSIF DAT_KOM < DAT_ROZ -- комиссия завешивается на дебеторскую задолженность
     THEN
      if l_CP_METOD = 0
      then
        PAYTT(0,        REF_,   DAT_OPL,  FXB_,   1,
              cpk.kv,   B_4621, K_,
              cpk.kv,   B_1819, K_);
      else
        PAYTT(0,        REF_,   VDAT_,    FXB_,   1,
              cpk.kv,   B_4621, K_,
              cpk.kv,   B_1819, K_);
      end if;

        UPDATE opldok
           SET txt = sKOMISD
         WHERE REF = REF_
           AND stmt = gl.ASTMT;

     END IF;
    end if;
     IF D_ = 0 AND P_ = 0
     THEN
        -- Дт. Транзитный счет Кт.Консолидированный счет комиссионнах расходов
        PAYTT(0,        REF_,       VDAT_,  FXB_,   0,
              cpk.kv,   S_TRANS_DK_NLS,     K_,
              cpk.kv,   RI_CPACCC.nls71,    K_);

        UPDATE opldok
           SET txt = sKOMISD
         WHERE REF = REF_
           AND stmt = gl.ASTMT;
     END IF;
  END IF;

   -- Продажа своих ЦБ OP = 2
   INSERT INTO cp_arch  (REF,  ID,  DAT_UG, DAT_OPL, DAT_ROZ, acc,  SUMB,   N, D, P, R, STR_REF,  OP,REF_REPO)
        VALUES          (REF_, nID_,DAT_UG, DAT_OPL, DAT_ROZ, ACC_, S_,     N_,D_,P_,R_,sREF,     2, nREPO_ );

   IF nREPO_ IS NOT NULL
   THEN
    UPDATE cp_arch
       SET REF_REPO = REF_
     WHERE REF = nREPO_;
   END IF;
  bars_audit.trace('%s Финиш (ID = %s, tip = %s)', title, to_char(nID_), to_char(TIPD_));

  exception
    when others then
      bars_audit.error(title||SQLERRM||','||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
      raise;
end CP_PROD;
------------------------------------------------------------------------------

------------------------------------------------------------------------------
PROCEDURE CP_AMOR
( ref1_ INT,
  ID_   int,
  GRP_  int,
  aDAT_ date,
  sErr OUT varchar2 ) is

NDOG_    oper.ND%type      ; -- № угоди
CP_ID_   cp_kod.CP_ID%type ;
DATP_    cp_kod.DATP%type  ; --дата погаш
SDP_     accounts.OSTB%type; -- несамортиз остаток
SN_      accounts.OSTB%type; --сумма номинала
KV_      accounts.KV%type  ;
NLSA_    accounts.NLS%type ;
NLSB_    accounts.NLS%type ;
ACCDP_   accounts.ACC%type ; NLSDP_   accounts.NLS%type ;
N_DAOS_  accounts.DAOS%type;
ACCN_    accounts.ACC%type ; ACCCN_   accounts.ACCC%type ;
PF_      cp_pf.PF%type     ;
ACR_DAT_ int_accn.ACR_DAT%type;
NAZN_    oper.NAZN%type    ;
NMSA_    oper.NAM_A%type   ;
NMSB_    oper.NAM_A%type   ;
OKPO_    oper.ID_A%type    ;
REF_     oper.REF%type     ;
VOB_     oper.VOB%type     ;
VDAT_    oper.VDAT%type    ;
DK_      oper.DK%type      ;
PR_AMR_  cp_kod.PR_AMR%type;
ER_      cp_deal.erat%type ;
ERE_     cp_deal.eratE%type;
ir_      cp_kod.IR%type    ;
dok_     cp_kod.dok%type   ;
dnk_     cp_kod.dNk%type   ;
CENA_KUP_ NUMBER           ;
KUP1_     NUMBER           ;
aDAT1_   date :=aDAT_+1    ;
----------------------------
DNI_   int    ; -- общее кол-во дней амортизации до конца жизни ЦБ
DNJ_   int    ; -- общее кол-во дней амортизации в данном сеансе
KOL_   int    ; -- кол-во штук в пакете
S_  number :=0; -- сумма аморт отчисления - за период
Q_  number :=0; -- сумма-екв аморт отчисления - за период
S1_ number :=0; -- сумма аморт отчисления - за 1 день
FL_    int    ; -- флаг опл (по пл или факту)
IA_A_ number  ; -- суььф проводок по амортизации.
SA_A_ number  ; -- общ.сальдо для амортизации.
NR_A_ number  ; -- норма   амортизации.
PR_A_ number  ; -- Процент амортизации.
ALL_  int :=0 ; -- признак полной амортизации

begin

  select decode(substr(flags,38,1),'1',2,0) into FL_ from tts where tt='FXM';

   if CP_AMORT_ ='1' then
      begin
        select c.pf into PF_   from cp_deal d, accounts ad, accounts ar, cp_accc c
        where d.ref=REF1_ and d.acc=ad.acc and ad.accc = ar.acc   and ar.nls = c.nlsa
          and c.pf in (select pf from cp_pf where nvl(CP_PF.no_a,0) = 1)
--        and c.pf in (4,6,7)
          and ad.kv=ar.kv and d.ryn = c.ryn and rownum = 1;
        RETURN;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end;
   end if;

   sErr:='';

   NLSDP_ := null;  SDP_  := 0  ;  NLSA_ := null;  NMSA_ := null;
   NLSB_  := null;  S_    :=0   ;  NMSB_ := null;  OKPO_ := gl.aOKPO; ALL_  :=0;

   select o.ND , k.cp_id, NVL(i.ACR_DAT,N.daos-1), round(n.ostc/(k.CENA*100),0),
          i.acra,N.acc  , n.accc, N.ostb , n.daos,    k.datp,
          k.PR_AMR, E.ERAT, E.ERATE, nvl(k.ir,0)/36500 , n.kv ,
          NVL(K.cena_kup,0)/k.cena , nvl(K.dok,K.DAT_EM), nvl(K.dNk,K.DATp),
          k.tip
   into NDOG_  , CP_ID_ , ACR_DAT_ , KOL_  ,  ACCDP_ , ACCN_  , ACCCN_ , SN_    , N_DAOS_ , DATP_ ,
        PR_AMR_, ER_    , ERE_     , IR_   ,  KV_    , cena_kup_, dok_ , dnk_   , tip_cp
   from cp_deal E, accounts N,  int_accn I,  cp_kod   K,   oper     O
   where E.acc  = N.acc  AND E.acc  = I.acc AND I.metr = 6  AND  E.id   = K.id
     AND O.ref  = e.ref  and (i.id = 2 OR i.id = 3 )   AND E.ref  = REF1_  AND  NVL(i.ACR_DAT,N.daos-1) < adat_  ;

   If ACCDP_ is not null then

      select DP.nls,DP.ostb, a.nls,substr(a.nms,1,38), b.nls,substr(b.nms,1,38)   into NLSDP_, SDP_, NLSA_, NMSA_, NLSB_, NMSB_
      from int_accn I,  accounts DP, accounts A,  accounts B
      where I.acc=ACCN_ AND I.metr = 6  AND  ACCDP_ = DP.acc
        and (i.id = 2   and DP.ostb >0  OR   i.id = 3 and  DP.ostb <0 )and DP.ostc = DP.ostb
        AND DP.accc= A.acc AND  I.acrb = B.acc AND B.kv = gl.baseval  ;
   end if;
--------------
   If SN_=0 or DATP_<= adat_ or
      --DATP_<= gl.BDATE
      -- надо амортизировать "под ноль" - если завтра уже будет дата погпшения ЦБ в целом
      Dat_Prev_U(DATP_,1) <= adat_     then
      DNI_ := 0 ; /* остаточная амортизация всего остатка SDP_ */
      ALL_ := 1 ;
   else
     DNI_:= DATP_-1 - ACR_DAT_;
   end if;

   DNJ_:= adat_ - ACR_DAT_;
   If DNJ_<=0 then    RETURN;   end if;
   --------------------------------------

   If DNI_  <= 1 then S_:= SDP_ ;  ALL_ := 1;  GOTO PROVODKA;  end if; --  послед, забираем весь ост
   If PR_AMR_= 4 then                          GOTO PROVODKA;  end if; --  линейно


   If ERE_ is NOT null  then

      --по ЧЕСТНОМУ методу эф.% ставки

      select round(SUM((SS1+SN2)/power( 1 + (ER_ )/100,(FDAT- aDAT1_)/365 )),2),
             round(SUM((SS1+SN2)/power( 1 + (ERE_)/100,(FDAT- aDAT1_)/365 )),2)
      into S_, S1_  from cp_many where ref= REF1_ and fdat >= aDAT1_;

      -- норма   амортизации.
      NR_A_ := ABS(S_- S1_)*100;

      -- общ.сальдо для амортизации.
      select Abs ( SDP_ + nvl( sum(a.OSTC), 0 ) )    into SA_A_  from accounts a, cp_ref_acc x
      where a.accc is not null and a.ostc<>0 and a.ostc=a.ostb   and a.tip in ('2VD','2VP') and a.acc =x.acc and x.ref=REF1_;

      -- Процент амортизации.
      If SA_A_ > 0 then      PR_A_   := NR_A_/SA_A_;
      else                   PR_AMR_ := 4 ;    GOTO PROVODKA;    -- перейти на аморт вир.Д/П линейно.
      end if;

      --сумма фактической амортизации реального Д/П
      S_:= ABS(SDP_) - ABS(SDP_) *PR_A_;

      if S_ < 0 then  logger.info('CP_AMOR по р-ку '||NLSDP_||' сума вже замортизована раніше '||S_);
         S_:=0;
      end if;

      GOTO PROVODKA;
   end if;

   --по так называемому методу эф.% ставки
   -- сделано ОТ ЦЕНЫ КУПОНА И % СТАвки  --  купон 1-го дня
   If cena_kup_> 0 then   KUP1_:= SN_*cena_kup_/(dnk_-dok_);
   else                   KUP1_:= SN_*IR_;
   end if;

   WHILE DNJ_>0
   LOOP
      S1_ := ABS( (SN_+SDP_) * ER_ - KUP1_) ;
      DNJ_:= DNJ_ - 1;
      If    Abs(SDP_)>0 and abs(SDP_)<=S_ then S_:=S_+Abs(SDP_); EXIT;
      ElsIf SDP_>0  then S_:=S_+S1_; SDP_:= SDP_- S1_;
      ElsIf SDP_<0  then S_:=S_+S1_; SDP_:= SDP_+ S1_;
      end if;
   end loop;

--=============
  <<PROVODKA>> null;
   If PR_AMR_ = 4 then S_:= SDP_*DNJ_/ DNI_;  end if;  --  линейно
   S_:= ABS(round(S_,0));
   --обычная амортизация (грн или вал)
   if KV_=gl.baseval then VOB_:=6; else VOB_:=16; end if;
  VDAT_:=GL.BDATE;
   -- в период ЗО на Украине
   If gl.baseval=980 and   to_char(gl.bdate,'yyyyMM') > to_char(aDAT_,'yyyyMM') then  VOB_:= 96;  VDAT_:= F_VDAT_ZO(aDAT_) ;
   end if;

   If SDP_<> 0 and S_>0 then
      --реальный Д/П
      If SDP_>0 then DK_:=1;
      else           DK_:=0;
      end if;

      if tip_cp=1  then  DP_slovo:=Iif_N( DK_,1,'премiї','дисконту','');
      else               DP_slovo:=Iif_N( DK_,1,'дисконту','премiї','');
      end if;

      NAZN_:= substr( Iif_n(ALL_,0,'','','Остаточна ') || ' Амортизацiя реал.'  ||  DP_slovo||
              '. ЦП '||CP_ID_||' уг.'||NDOG_||' пакет '||KOL_||' шт. Перiод '|| to_char(ACR_DAT_+1,'dd/mm/yyyy') ||' - ' ||
              to_char( aDAT_ ,'dd/mm/yyyy') , 1, 160 ) ;

      IA_A_ := S_; GL.REF (REF_);    Q_:=gl.p_icurval(KV_, S_, VDAT_ );
      GL.in_doc3  (ref_  =>REF_,  tt_   =>'FXM',   vob_ =>vob_    , nd_   =>substr(to_char(REF_),1,10),pdat_=> sysdate,
                   vdat_ =>vdat_, dk_   => DK_ ,   kv_  =>kv_     , s_    =>s_,    kv2_   =>gl.baseval, s2_ => Q_,
                   sk_   =>null , data_ =>greatest(VDAT_,gl.bDATE), datp_ =>gl.bdate,
                   nam_a_=>NMSA_,nlsa_  =>NLSA_,mfoa_=>gl.AMFO    , nam_b_=>NMSB_   , nlsb_ =>NLSB_,  mfob_=> gl.AMFO,
                   nazn_ =>NAZN_, d_rec_=> null,   id_a_=>OKPO_   , id_b_ =>OKPO_,    id_o_ =>null,   sign_=> GetAutoSign,
                   sos_  => 1   , prty_ =>null ,  uid_  => null );
      payTT(0,REF_,VDAT_,'FXM',DK_,KV_,NLSDP_,S_,gl.baseval,NLSB_, Q_ );
      update opldok set txt=substr(NAZN_,1,70) where ref=REF_ and stmt=gl.ASTMT;
      if FL_=2 then        gl.pay(2,REF_,gl.bDATE);     end if;
   end if;

   ref_:= null;

   If ERE_ is null  then goto ZAP_ARC; end if;
   ------------------------------------------

  --амортизация сопутствующих дисконтов/премий
  --по ЧЕСТНОМУ методу эф.% ставки
  declare
     s2VD1_ accounts.NLS%type;  s2VP1_ accounts.NLS%type;
     l_vdat date;
  begin
     select c.s2VD1 , c.s2VP1     INTO     s2VD1_,   s2VP1_     FROM cp_accc c, accounts rn
     where rn.nls = c.NLSA     and rn.acc = ACCCN_     and c.s2VD  is not null and c.s2VP  is not null
       and c.s2VD0 is not null and c.s2VD1 is not null and c.s2VP0 is not null and c.s2VP1 is not null   and rownum=1;
     l_vdat:=vdat_;

     For k in (select d.ostc, r.nls NLSR, substr(r.nms ,1,38) NMS, d.nls NLSD, a6.nls  NLS6 , substr(a6.nms,1,38) NMS6, d.daos
               from accounts d, accounts r, accounts a6
               where d.accc=r.acc   and a6.kv=gl.baseval  and a6.nls=decode(d.tip,'2VD',s2VD1_,s2VP1_)  and d.tip in ('2VD','2VP')
                and d.ostc<>0 and d.ostc=d.ostb           and d.acc in (select acc from cp_ref_acc where ref=REF1_)
              )
    loop
       --сумма фактической амортизации виртуального Д/П
       If ALL_ = 1 then S_ := k.OSTC;
       else             S_ := k.OSTC - round(k.OSTC*PR_A_,0);
       end if;

       S_ := Abs(S_);
       If S_ > 0 then

          If REF_ is null then
             --виртуал Д/П
             If k.ostc>0 then DK_:=1;
             else             DK_:=0;
             end if;

             NAZN_:= substr(    Iif_n(ALL_,0,'','','Остаточна ')     ||  'Амортизацiя вiрт.'|| Iif_N( DK_,1,'премiї','дисконту','') ||
              '. ЦП '  || CP_ID_||' уг.'||NDOG_    ||  ' пакет '|| KOL_  ||' шт. Перiод '   || to_char(ACR_DAT_+1,'dd/mm/yyyy')     ||' - ' ||
              to_char( aDAT_ ,'dd/mm/yyyy') , 1,160);

              GL.REF (REF_);
              if k.daos>=to_date('01/06/2013','dd/mm/yyyy') then l_vdat:=k.daos; end if;
              Q_:=gl.p_icurval(KV_, S_, l_vdat );

              GL.in_doc3  (ref_  =>REF_,  tt_   =>'FXM',   vob_ =>vob_    , nd_   =>substr(to_char(REF_),1,10),pdat_=> sysdate,
                           vdat_ =>vdat_, dk_   => DK_ ,   kv_  =>kv_     , s_    =>s_,    kv2_   =>gl.baseval, s2_ => Q_,
                           sk_   =>null , data_ =>greatest(VDAT_,gl.bDATE), datp_ =>gl.bdate,
                           nam_a_=>k.NMS,nlsa_  =>k.NLSR,  mfoa_=>gl.AMFO , nam_b_=>k.NMS6  , nlsb_ =>k.NLS6, mfob_=> gl.AMFO,
                           nazn_ =>NAZN_, d_rec_=> null,   id_a_=>OKPO_   , id_b_ =>OKPO_,    id_o_ =>null,   sign_=> GetAutoSign,
                           sos_  => 1   , prty_ =>null ,  uid_  => null );
          end if;

          Q_:=gl.p_icurval(KV_, S_, l_vdat );
          If k.OSTC > 0 then  payTT(0,REF_,VDAT_,'FXM',1,KV_,k.nlsD,S_,gl.baseval,s2VD1_, Q_ );
          else                payTT(0,REF_,VDAT_,'FXM',0,KV_,k.nlsD,S_,gl.baseval,s2VP1_, Q_ );
          end if;
          update opldok set txt='Амортизацiя вiрт.Д/П' where ref=REF_ and stmt=gl.ASTMT;
       end if;
       IA_A_ := IA_A_ + S_;
    end loop;
    if FL_=2 and ref_ is not null then      gl.pay(2,REF_,gl.bDATE);   end if;

  EXCEPTION WHEN NO_DATA_FOUND THEN null;
  end;

  <<ZAP_ARC>> null;
  update int_accn SET ACR_DAT = adat_ where acc = ACCN_ and metr=6;


EXCEPTION WHEN NO_DATA_FOUND THEN    RETURN;  --  sERR:='222.Нет инф, реф='||REF1_;
end CP_AMOR;
--------------------------------------------

PROCEDURE CP_KUP (p_CP_AI    IN     VARCHAR2,   -- '1'= регулювання лiквiдностi,  '0' = з акцiонерами
                  TIPD_      IN     INT,
                  VOB_       IN     INT,
                  GRP_       IN     INT,
                  nID_       IN     INT,
                  nNBS_      IN     INT,
                  nRYN_      IN     INT,
                  DAT_UG     IN     DATE,
                  DAT_OPL    IN     DATE,
                  DAT_ROZ    IN     DATE,
                  DAT_KOM    IN     DATE,
                  SUMBN      IN     NUMBER,     -- номинал
                  SUMB       IN     NUMBER,     -- вартисть пакета (в грн. НЕ в коп)
                  RR_        IN     NUMBER,     -- для акций =% от капитала, для долговых=накоп.купон
                  SUMBK      IN     NUMBER,     -- сумма комиссии
                  NAZN_      IN     VARCHAR2,
                  NLS9       IN     VARCHAR2,
                  rNls_         OUT VARCHAR2,   -- cчет, по кот сделана комиссия
                  B_4621     IN     VARCHAR2,
                  B_1819     IN     VARCHAR2,
                  B_1919     IN     VARCHAR2,
                  sREF          OUT VARCHAR2,
                  sErr          OUT VARCHAR2,
                  REF_MAIN      OUT INT)
IS

title constant varchar2(10) := 'CP.CP_KUP:';
-- процедура покупки чужих или выкупа (погашения) своих
S_  number  ; accN_  int ; accN2_ int ; NMS_  varchar2(38) ;
D_  number  ; accD_  int ; REF_   int ; DP_   number ;

l_NLS_DP accounts.NLS%type ;

P_  number  ; accP_  int ; N_  number ; NLSG_  varchar2(15);
R_  number  ; accR_  int ; REF1_  int ; acc_  int    ;
K_  number  ; L_     int ; ACCC_ int    ;
ACCR2_ int  ; accR6_ int ; ACRB_  int ; ACRBP_  int  ;

CENA_KUP_L  NUMBER  ;
ERAT_ number; VDAT_  date; V1_   number ;--собиварт прибдання 1 ЦП
r1_    int  ; DAT7   date; KUP1_ number ; sNls   varchar2(15);
SR_ number  ; DP1_ number; sNls_  varchar2(15);
SA_ number  ; SD_ number ; SN_  number; SP_   number ; NAZN1_ varchar2(70);
SS_ number  ; T_  number ; NN_  number; DK_    int   ; OKPO_ varchar2(14) ;
S_4621 varchar2(38)     ; TTV_ char(3)       ;
S_TRANS_DK_NMS varchar2(38);
S_TRANS_DK_NLS varchar2(15);
NLS703      varchar2(15) ; PF_ int;
NLS703P     varchar2(15) ;
NLS71_      varchar2(15) ;-- счет комиссии
RNK1_  int ; --РНК технич

NO_P_  cp_pf.NO_P%type ;
NO_A_  cp_pf.NO_A%type ;
r_pf2  cp_pf%rowtype     ;  -- в який портф
r_ryn2 cp_ryn%rowtype    ;  -- в який суб/портф
---
---------------
accS_  number; accS6_ number;  accS5_ number; CP_ID_R varchar2(25);
--kk cp_kod%rowtype;  -- ! global

/* обработка кривого купона при покупке */
 l_has_awry_period int := 0; -- есть ли "кривой" купон для бумаги - при наличии укороченного 1го или последнего купонного периода
 l_npp             int;
 l_normal          int;
 l_awry_first      int;
 l_awry_last       int;
 l_R3              accounts%rowtype;
 R3_               number := 0; -- сумма для размещения на счете "кривого" купона
 l_count           number := 0; -- количество купленных бумаг
 l_kupon_price     number := 0; -- цена купона из cp_kod.cena_kup
 l_tag             cp_tag.tag%type;
 l_portf           varchar2(3);

 l_vob             int := VOB_;

BEGIN
  bars_audit.info(title || ' Start with p_CP_AI = '||to_char(p_CP_AI)
                        || ', CP_METOD = ' || to_char(l_CP_METOD)
                        || ', CP_TRANS_DK = ' || to_char(l_CP_TRANS_DK)
                        || ', B_1819 = '||B_1819
                        || ', B_1919 = '||B_1919);

  if l_CP_TRANS_DK is null
  then l_CP_TRANS_DK := 0; --Робота через транз.рах =0
  end if;

  if l_CP_TRANS_DK = 0
  then S_TRANS_DK_NLS := B_4621;
  else S_TRANS_DK_NLS := B_1919;
  end if;

  /*проверка на кривой купон*/
  awry_period(p_id          => nId_,                -- IN код ценной бумаги
              p_npp         => l_npp,               -- OUT текущий купонный период
              p_normal      => l_normal,            -- OUT количество дней в нормальном купонном периоде (втором)
              p_awry        => l_has_awry_period,   -- OUT признак наличия укороченного купонного периода 1/0
              p_awry_first  => l_awry_first,        -- OUT количество дней в первом купонном периоде
              p_awry_last   => l_awry_last);        -- OUT количество дней в последнем купонном периоде

  if l_CP_METOD is null
  then l_CP_METOD := 1; --1 - за датою розр
  end if;
  IO_:=0;
  begin
    sERR:='29.Нет в PARAMS RNK_CP';  select to_number(val) into RNK1_ from params where par='RNK_CP';

    begin
        select *
          into kk
          from cp_kod
          where id = nId_;
    exception when no_data_found then  sERR:='30.Не налаштований код ЦП '||nID_; return;
    end;

    l_kupon_price := kk.CENA_KUP;
    kk.basey      := NVL(kk.basey,0);
    kk.ir         := NVL(kk.IR,0);
    kk.CENA_KUP   := NVL(kk.CENA_KUP,0) / kk.cena;
    kk.rnk        := NVL(kk.rnk, RNK1_);
    kk.dok        := NVL(kk.dOK,kk.DAT_EM);
    kk.dnk        := NVL(kk.dnk,kk.datp);
    if kk.metr = 23 then kk.metr := 8;
    else                 kk.metr := nvl(kk.metr,0) ;
    end if;

    If kk.PR1_KUP is null then
       if kk.kv =gl.baseval then  kk.PR1_KUP := 2;
       else                       kk.PR1_KUP := 1;
       end if;
    end if;
    --l_has_awry_period := 0; -- 21/01/2016 из-за разночтений БМ по кривому купону временно ставим заглушку на непроверку
    N_ := SUMBN*100; -- номинал
    /* Обработка укороченного купонного периода (первого)*/
    if l_has_awry_period = 0
    then
        If kk.CENA_KUP >0 then     KUP1_:= N_*kk.CENA_KUP/ (kk.DNK- kk.dok);
        else                       KUP1_:= N_*kk.ir      / 36500;
        end if;
    else
        If kk.CENA_KUP >0 then     KUP1_:= N_*kk.CENA_KUP/ (l_normal); -- количество дней и купон в нормальном купонном периоде
        else                       KUP1_:= N_*kk.ir      / 36500;
        end if;
    end if;

    begin
    SELECT SUBSTR (a.nms, 1, 38), c.okpo
      INTO S_TRANS_DK_NMS, OKPO_
      FROM accounts a, cust_acc u, customer c
     WHERE a.acc = u.acc
       AND u.rnk = c.rnk
       AND a.kv = kk.KV
       AND nls = S_TRANS_DK_NLS;
    exception when no_data_found then sERR:='31.Не знайдено конс.рах.транзита'||S_TRANS_DK_NLS||'('||kk.KV||')'; return;
    end;

    bars_audit.trace('kk.DOX='||to_char(kk.DOX)||',TIPD_='||to_char(TIPD_)||'nvl(r_pf2.NO_A,0)='||to_char(nvl(r_pf2.NO_A,0)));

    if  kk.DOX >= 2  and TIPD_=1 and nvl(r_pf2.NO_A,0) <>1 then     --  r_pf2.pf in (4,6,7)
        begin
           SELECT aD.acc, aP.acc, aD.nls, aP.nls
             INTO ACRB_, ACRBP_,NLS703, NLS703P
             FROM accounts aD, accounts aP, cp_accc c
            WHERE aD.kv = gl.baseval
              and aD.nls=c.s605
              and aP.kv=gl.baseval
              and aP.nls=c.s605P
              and c.vidd=nNBS_
              and c.RYN=nRYN_
              and c.emi= kk.EMI;
        EXCEPTION WHEN NO_DATA_FOUND THEN sERR:='32.Не налаштовано рахунок 6 кл.по аморт.';  RETURN;
        END;
    end if;
  END;
  sERR:=Null;   sREF:=null;

  cp.FXB(kk.KV ,TIPD_);

  S_ := SUMB *100;              -- вартисть пакета
  K_ := SUMBK*100;              -- сумма комиссии
  R_ := RR_  *100;              -- накопленный купон
  R3_:= 0;
  if l_has_awry_period = 1 and l_npp = 1                 -- если есть кривой купон в первом купонном периоде при покупке, то его долю надо закинуть на его счет
  then
    l_count := N_/(kk.CENA);
    R_      := l_count * round((l_kupon_price / l_normal)*(gl.BDATE - kk.dat_em),2);
    R3_     := l_count * round((l_kupon_price / l_normal)*(l_normal - l_awry_first),2);

    bars_audit.info(title||'/ R_ = '||to_char(R_)||', R3_ = '||to_char(R3_)||' ,l_count = ' || to_char(l_count)||', l_normal = '|| l_normal||' ,l_awry_first = '|| l_awry_first||' ,gl.BDATE - kk.dok='||(gl.BDATE - kk.dok));
  end if;

  GL.REF (REF_);
  REF_MAIN:=REF_;
  --внебаланс
  cp.CP_VNEB(0, kk.KV,nNBS_,nRYN_, kk.EMI, N_, S_,  kk.CP_ID ,DAT_UG,DAT_OPL,DAT_ROZ,DAT_KOM,NAZN_,REF_,NLS9,sREF,sErr);
  if sErr is not null then RETURN; end if;
  -----------------------------------------
  s8_:= substr( '000000000'|| REF_CP_NBU(REF_) , -8 );
  --основной
  cp_id_r := null;
  if gl.AMFO in ('300001') or l_mfou='300465' then
     cp_id_r := kk.cp_id||'/' ;
  end if;


  begin
    select a.acc, substr(cp_id_r||a.nms,1,38), Decode( kk.DOX,1,p.NLSP,p.nlsA),
           decode( kk.DOX , 1,'89980',substr(a.nls,1,5) )||'0'||s8_,  p.PF, p.nls71, nvl(f.NO_P,0), nvl(f.NO_A,0)
      into accc_, NMS_,NLSG_, NLS_, PF_ , NLS71_, NO_P_,  NO_A_
      from accounts a, cp_accc p, cp_pf f
     where a.nls=p.nlsA
       and a.kv= kk.KV
       and p.vidd=nNBS_
       and p.emi= kk.EMI
       and p.RYN=nRYN_
       and f.pf = p.pf;
  EXCEPTION WHEN NO_DATA_FOUND THEN  sERR:='33.Не налаштовано конс.рах.номіналу'; RETURN;
  END;

  if VOB_ = 96 then VDAT_:= F_VDAT_ZO( add_MONTHS(gl.BDATE, -1 ) );
  else
    VDAT_:= DAT_ROZ;
  end if;
  if l_vob is null then
    if kk.KV = gl.baseval then l_vob :=6; else l_vob:=16; end if;
  end if;


  GL.in_doc3
       (ref_  =>REF_ , tt_   => FXB_,   vob_ =>l_vob   , nd_   =>substr(to_char(REF_),1,10),pdat_=> sysdate,
        vdat_ =>vdat_, dk_   => 1   ,   kv_  =>kk.kv   , s_    =>s_,      kv2_   =>kk.kv,     s2_ => S_,
        sk_   =>null , data_ =>greatest(VDAT_,gl.bDATE), datp_ =>gl.bdate,
        nam_a_=>NMS_ , nlsa_ => NLSG_,  mfoa_=>gl.AMFO , nam_b_=>S_TRANS_DK_NMS, nlsb_ => S_TRANS_DK_NLS,   mfob_=> gl.AMFO ,
        nazn_ =>NAZN_, d_rec_=> null,   id_a_=>OKPO_   , id_b_ =>OKPO_,   id_o_ =>null,     sign_=> GetAutoSign, sos_ => 1,
        prty_ =>null , uid_  => null );

    F_REF( REF_, sREF, sREF );

    -- дебиторы-Кредиторы или без них
    if l_CP_TRANS_DK = 0 -- работа через транзитный счет. если = 1, то этой переброски быть не может
    then
        If DAT_OPL = DAT_ROZ then   sNls:= B_4621;
        else
           If DAT_OPL<DAT_ROZ then    sNls:= B_1819;  NAZN1_:= sZABORD ;
           Else                       sNls:= B_1919;  NAZN1_:= sZABORK ;
           end if;
           if l_CP_METOD = 0
           then payTT(0,ref_,VDAT_,   FXB_,1, kk.kv ,B_4621,S_, kk.kv ,sNls,S_);
           else payTT(0,ref_,DAT_OPL, FXB_,1, kk.kv ,B_4621,S_, kk.kv ,sNls,S_);
           end if;
           update opldok set txt=NAZN1_ where ref=REF_ and stmt=gl.ASTMT;
        end if;
    end if;

    if TIPD_ = 1 then
       -- купить чужие
       -- открыть КУЧКУ (всю толпу нужных счетов)
       -- Структура хвоста : 1 знак   - рынок
       --                  : 7 знаков - REF
       --                  : 1 знак   - пусто/номер
       -- в акциях применяется для разбивки   / номинал='8998*'
       --   основного счета 1300             -  премия =''
       --                                     \ дисконт='2'

       -- в боргових ЦП  для разбивки         / начисл.=' '
       -- начисленного купона                 \ куплен.='2'

       LOG('CP_KUP ref='||ref_||' S='||S_,'INFO');
      -- LOG('CP_KUP ref='||ref_||' rnk='||kk.rnk,'INFO');

       --сч-НОМИНАЛ
       cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK, nls_, kk.kv ,NMS_,'ODB', gl.aUid,acc_);
       UPDATE accounts SET mdate= kk.DATP ,accc=ACCC_,seci=4, pos=1, daos=VDAT_, pap=3 WHERE acc=ACC_;

       cp_inherit_specparam (acc_, accc_, 0);

       If kk.DOX = 1 then    PAYtt(0,ref_,VDAT_, FXB_,1,kk.kv,nls_,N_, kk.kv ,CP_nls8_,N_);
       else                  PAYtt(0,ref_,VDAT_, FXB_,1,kk.kv,nls_,N_, kk.kv ,S_TRANS_DK_NLS,N_);
       end if;

       update opldok set txt=substr('Код '|| kk.CP_ID ||' '|| sNOMINAL|| kk.name ,1,70)       where ref=REF_ and stmt=gl.ASTMT;

       --переоценка (если есть счет ФУ) и порт переоценивается
       If NO_P_ <> 1 then

          if NBUBNK_ = 1 then
          --НБУ.NLSS5 Род.счет 5121.
              begin
                select a.acc, substr(cp_id_r||a.nms,1,38), substr(a.nls,1,5)||'0'||s8_
               into accc_, NMS_, NLS_    from accounts a, cp_accc p
                where a.nls = p.NLSS5 and a.kv = gl.baseval and p.vidd=nNBS_ and p.emi= kk.EMI and p.RYN=nRYN_ ;
                cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK ,nls_,gl.baseval,NMS_,'ODB',gl.aUid,accS5_);
                UPDATE accounts SET mdate= kk.DATP ,accc=ACCC_,seci=4, pos=1, daos = DAT_UG   WHERE acc=accS5_;
              EXCEPTION WHEN NO_DATA_FOUND THEN accS5_:=null;     sERR:='34.Не налаштовано конс.рах.NLSS5 (5121)';   return;
              END;

          --6300 (6310) Рах.NLS_FXP~НЕреалiз.рез~переоц
              begin
                select a.acc, substr(cp_id_r||a.nms,1,38), substr(a.nls,1,5)||'0'||s8_    into accc_, NMS_, NLS_
                from accounts a, cp_accc p where a.nls = p.NLS_FXP and a.kv = gl.baseval and p.vidd=nNBS_ and p.emi= kk.EMI and p.RYN=nRYN_ ;

                cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK, nls_,gl.baseval,NMS_,'ODB',gl.aUid,accS6_);
                UPDATE accounts SET mdate= kk.DATP ,accc=ACCC_,seci=4, pos=1, daos= DAT_UG   WHERE acc=accS6_;
              EXCEPTION WHEN NO_DATA_FOUND THEN accS6_:=null;     sERR:='34.Не налаштовано конс.рах.NLS_FXP~НЕреалiз.рез~переоц в ФУ';   return;
              END;
          end if;    -- NBUBNK
        bars_audit.trace('!!!');
          --1305, 1315
          begin
            select a.acc, substr(cp_id_r||a.nms,1,38), substr(a.nls,1,5)||'0'||s8_      into accc_, NMS_, NLS_
            from accounts a, cp_accc p
            where a.nls=p.nlsS and a.kv= kk.KV and p.vidd=nNBS_ and p.emi= kk.EMI and p.RYN=nRYN_ ;

            bars_audit.trace('accc_='||to_char(accc_)||',NMS_='||to_char(NMS_)||'NLS_='||to_char(NLS_));

            cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , nls_, kk.kv,NMS_,'ODB',gl.aUid,accS_);

            bars_audit.trace('accS_='||to_char(accS_));

            UPDATE accounts SET mdate= kk.DATP ,accc=ACCC_,seci=4, pos=1, daos=VDAT_    WHERE acc=accS_;

            cp_inherit_specparam (accS_, accc_, 0);

          EXCEPTION WHEN NO_DATA_FOUND THEN accS_:=null;   sERR:='34.Не налаштовано конс.рах.переоцінки';   return;
          END;

       end if;

       CENA_KUP_L  := kk.CENA_KUP;
       kk.CENA_KUP := ROUND(GREATEST(0, kk.CENA_KUP * N_ - abs(R_)), 0);
       -- LOG('CP_KUP ref='||ref_||' R='||R_||' CENA_KUP='||CENA_KUP_L||' CENA_KUP* '||kk.CENA_KUP,'INFO');

       if R_ <> 0  then
          -- Для НАКОПИЧЕНОГО (купленного) купона
          begin
            select a.acc, substr(cp_id_r||a.nms,1,38),substr(a.nls,1,5)||'2'|| S8_        into accc_, NMS_, NLS_
            from accounts a, cp_accc p
            where a.nls=p.nlsR2 and a.kv= kk.KV and p.vidd=nNBS_ and p.emi= kk.EMI and p.RYN=nRYN_ ;
          EXCEPTION WHEN NO_DATA_FOUND THEN   sERR:='37.Не налаштовано конс.рах.накопиченого купону.';  RETURN;
          END;
          cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , nls_, kk.kv ,NMS_,'ODB', gl.aUid ,accR2_);
          UPDATE accounts SET mdate= kk.DNK-1, accc=ACCC_,seci=4,pos=1, daos=VDAT_
                 WHERE acc=accR2_;

          cp_inherit_specparam (accR2_, accc_, 0);

          if r_ > 0 then DK_:=1;
          else           DK_:=0;
          end if;
              PAYtt(0,ref_,VDAT_, FXB_,DK_, kk.kv ,NLS_,Abs(R_), kk.kv ,S_TRANS_DK_NLS,Abs(R_));
          update opldok set txt= substr('Код '|| kk.CP_ID ||' '|| sKUPON2|| kk.name ,1,70)   where ref=REF_ and stmt=gl.ASTMT;
       end if;
     bars_audit.info('!!!');
       -- обработка кривого купона
       if R3_ <> 0
       then
          BEGIN
            select a.acc,
                   substr(cp_id_r||a.nms,1,38),substr(a.nls,1,5)||'3'|| S8_
              into accc_, l_r3.NMS, l_r3.NLS
              from accounts a, cp_accc p
             where a.nls = p.nlsR2
               and a.kv = kk.KV
               and p.vidd = nNBS_
               and p.emi = kk.EMI
               and p.RYN = nRYN_ ;
          EXCEPTION WHEN NO_DATA_FOUND
                    THEN sERR:='37/3.Не налаштовано конс.рах."кривого".купону.';
                         RETURN;
          END;

          cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , l_r3.nls, kk.kv,l_r3.NMS,'ODB', gl.aUid, l_r3.acc);
          UPDATE accounts
             SET mdate = kk.DNK-1,
                 accc = ACCC_,
                 seci = 4,
                 pos = 1,
                 daos = VDAT_
           WHERE acc = l_r3.acc;

          cp_inherit_specparam (l_r3.acc, accc_, 0);

          if R3_ > 0 then DK_:=1;
          else           DK_:=0;
          end if;
          PAYtt(0,REF_, VDAT_, FXB_, DK_, kk.kv, l_r3.NLS, Abs(R3_), kk.kv ,S_TRANS_DK_NLS, Abs(R3_));
          update opldok set txt= substr('Код '|| kk.CP_ID ||' '|| sKUPON3|| kk.name ,1,70)   where ref = REF_ and stmt = gl.ASTMT;
       end if;
        bars_audit.info('2!!!');
       if kk.ir > 0 or kk.CENA_KUP > 0  then
          -- Для начисления (амортизации) купона в дальнейшем
          -- Счет нач ???8 и доходов 6???
          begin
            select a.acc, substr( cp_id_r||a.nms,1,38), substr(a.nls,1,5)||'0'||s8_,
                   a6.acc, decode( kk.kv,gl.baseval,p.tt,p.ttv),
                   NVL(p.io,0)
                  --  nvl( kk.io, NVL(p.io,0) )  -- 6/08-14 без аналізу CP_KOD.io
            into accc_, NMS_, NLS_,accR6_ , TTV_, IO_
            from accounts a, cp_accc C, accounts a6, proc_dr$base P
            where a.nls=C.nlsR and a.kv= kk.KV and C.vidd=nNBS_ and C.emi= kk.EMI
              and C.RYN=nRYN_  and P.nbs=nNBS_ AND a6.kv=gl.baseval    and a6.nls=C.NLS_PR  and rownum =1;
          EXCEPTION WHEN NO_DATA_FOUND THEN sERR:='35.Нет сч.НАЧ.% в ФУ'; RETURN;
          END;
          bars_audit.info('!!!2a');
          cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , nls_, kk.kv ,NMS_,'ODB', gl.aUid,accR_);

          cp_inherit_specparam (accR_, accc_, 0);

                /*  -- 6/08-14 відключив для ЦП tip=1
          IF IO_ = 1 AND kk.DAT_EM < kk.DATP -1 THEN IO_ := 1 ;
          ELSE                                  IO_ := 0 ;
          END IF;    */

          if CENA_KUP_L >0 and gl.amfo = '300465' and kk.metr=4 then
             UPDATE accounts SET mdate= kk.DNK-1, accc=ACCC_,seci=4,OSTF= kk.CENA_KUP , pos=1,daos=VDAT_   WHERE acc  = accR_;
             insert into int_accn (acc,id,acra,acrb,metr,tt,BASEY,FREQ, ACR_DAT, io)
               values(accR_,1,accR_,accR6_,4,NVL(TTV_,'FX%'), kk.BASEY,1, gl.BDATE-1+IO_, io_);
          else

            UPDATE accounts
               SET mdate = kk.DNK - 1,
                   accc = ACCC_,
                   seci = 4,
                   pos = 1,
                   daos = VDAT_
             WHERE acc = accR_;

             -- 30-03-2011 По просьбе НБУ
                INSERT INTO int_accn (acc, id, acra, acrb, metr, tt, BASEM, BASEY, FREQ, ACR_DAT, STP_DAT, IO)
                     VALUES (acc_, 0, accR_, accR6_,
                            iif_n (kk.pr1_kup,2,kk.metr,8,kk.metr), NVL (TTV_, 'FX%'), 0, kk.BASEY, 1, (gl.BDATE - 1 + IO_), (kk.DATP - 1), IO_);

                INSERT INTO int_ratn (ACC,ID,BDAT,IR)
                     VALUES (acc_,0,gl.bdate,kk.ir);
          end if;
       end if;
bars_audit.info('3!!!');
       V1_:= (S_ + K_ - R_- R3_ )* kk.CENA * 100 / N_ ;  --собиварт прибдання 1 ЦП
       If kk.DOX = 1
        then  DP_ := S_ - R_ - R3_;
        else  DP_ := S_ - N_ - R_ - R3_;
       end if;
          bars_audit.info('CP_KUP: 2) DP_ = ' || to_char(DP_));
       IF DP_< 0
       THEN  D_:= -DP_; P_:=0  ;
       ELSE  D_:=0    ; P_:=DP_;
       END IF;
           bars_audit.info('CP_KUP: P_ = ' || to_char(P_)||' D_ = ' || to_char(D_));
       If P_> 0 then
          -- Премия
          begin
            select a.acc, substr(cp_id_r||a.nms,1,38), substr(a.nls,1,5)||'0'||s8_
              into accc_, NMS_, l_NLS_DP
              from accounts a,
                   cp_accc p
             where a.nls = p.nlsP
               and a.kv = kk.KV
               and p.vidd = nNBS_
               and p.emi = kk.EMI
               and p.RYN = nRYN_;
          EXCEPTION WHEN NO_DATA_FOUND
                    THEN sERR :='3.Нет сч.премии в ФУ';
                         RETURN;
          END;

          cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , l_NLS_DP, kk.kv ,NMS_,'ODB', gl.aUid ,accP_);

          UPDATE accounts
             SET mdate = kk.DATP,
                 accc = ACCC_,
                 seci = 4,
                 pos = 1,
                 daos = VDAT_
           WHERE acc = accP_;

          cp_inherit_specparam (accP_, accc_, 0);

          -- если портфель амотризируется
          IF kk.DOX >= 2 AND NO_A_ <> 1
          THEN
                INSERT INTO int_accn (acc, acra, acrb, id, metr, ACR_DAT, s, STP_DAT, IO, basey, freq)
                     VALUES (ACC_, ACCP_, ACRBP_, 3, 6, (gl.bdate - 1 + IO_), V1_, (kk.DATP - 1), IO_, 0, 1);
              END IF;

              PAYtt(0,ref_,VDAT_, FXB_,1, kk.kv, l_NLS_DP,P_, kk.kv , S_TRANS_DK_NLS,P_);
          update opldok set txt= substr('Код '|| kk.CP_ID ||' '|| iif_s( kk.DOX , 1,'','Вартiсть придбання',sPREMIA)||' '|| kk.name ,1,70)
                 where ref=REF_ and stmt=gl.ASTMT;
       end if;

       If D_>0 then
          -- Дисконт
          begin
            select a.acc, substr(cp_id_r||a.nms,1,38), substr(a.nls,1,5) || decode( kk.DOX , 1, '2','0')||S8_ into accc_, NMS_, l_NLS_DP
            from accounts a, cp_accc p where a.nls=p.nlsD and a.kv= kk.KV and p.vidd=nNBS_ and p.emi= kk.EMI and p.RYN=nRYN_;
          EXCEPTION WHEN NO_DATA_FOUND THEN   sERR :='38.Нет сч.диск в ФУ'; return;
          END;
          cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , l_NLS_DP, kk.kv ,NMS_,'ODB', gl.aUid ,accD_);
          UPDATE accounts SET mdate= kk.DATP,accc=ACCC_, seci=4, pos=1, daos=VDAT_ WHERE acc=accD_;

          cp_inherit_specparam (accD_, accc_, 0);

          -- если портфель амотризируется
          if kk.DOX >= 2 and NO_A_ <> 1 then
             insert into int_accn (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO,basey,freq) values (ACC_,ACCD_,ACRB_, 2, 6, gl.bdate-1 + IO_, V1_, kk.DATP-1,IO_,0,1 );
          end if;

              PAYtt(0,ref_,VDAT_, FXB_,0, kk.kv ,l_NLS_DP,D_, kk.kv ,S_TRANS_DK_NLS,D_);
          update opldok set txt=substr('Код '|| kk.CP_ID ||' '|| sDISKONT|| kk.name ,1,70) where ref=REF_ and stmt=gl.ASTMT;
       end if;

       -- долговые ЦБ  + если портфель амотризируется
       if kk.DOX >= 2 and NO_A_ <> 1 then
          If DP_ <> 0 then
             -- сделано ОТ ЦЕНЫ КУПОНА И % СТАвки  --  купон 1-го дня
             -- дисконт/премия 1-го дня
             DP1_ := DP_ /( kk.DATP-DAT_ROZ);
             erat_:= (KUP1_-DP1_) / ((S_-R_-R3_+N_)/2) ;
          else
             insert into int_accn (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO,basey,freq)
             values (ACC_,ACCD_,ACRB_, 2, 6, gl.bdate - 1 + IO_,V1_,  kk.DATP-1,IO_,0,1);
          end if;
       end if;

       insert into cp_deal(ID , RYN , ACC , ACCD , ACCP , ACCR , ACCR2 , ACCR3,    ACCS , accS6 , accS5 , REF , erat  )
                values (  nID_,nRYN_, acc_, accD_, accP_, accR_, accR2_, l_r3.acc, accS_, accS6_, accS5_, ref_, erat_ );
       begin
          insert into cp_payments(cp_ref, op_ref)
          values (REF_, REF_);
       exception when others then null;
       end;

       begin
          insert into cp_accounts(cp_ref, cp_acctype, cp_acc)
          select * from
              (select ref_ as cp_ref, 'N' as cp_acctype,  acc_ as cp_acc from dual union all
               select ref_,           'D',                accD_    from dual union all
               select ref_,           'P',                accP_    from dual union all
               select ref_,           'R',                accR_    from dual union all
               select ref_,           'R2',               accR2_   from dual union all
               select ref_,           'R3',               l_r3.acc from dual union all
               select ref_,           'S',                accS_    from dual union all
               select ref_,           'S6',               accS6_   from dual union all
               select ref_,           'S5',               accS5_   from dual         )
           where cp_acc is not null;
       exception when others then bars_audit.info ('CP: вставка новых счетов в cp_accounts неуспешна/'|| sqlerrm);
       end;

       If kk.DOX >= 2   then
          cp.RMany_DAT(REF_, REF_, VDAT_,N_, 0 );
       end if;

       -- комисия
       If K_ > 0
       then
         DAT7 := greatest ( DAT_KOM,DAT_ROZ) ;
          --14.05.2013 -Транзитний рах-к для проводки по сумі комісії  4621/2746
            if l_CP_TRANS_DK = 0
            then
              If NO_A_ <> 1 then -- для порфеля ЦБ, которые учитываются за "справедливою варт
                 rNls_ := B_4621;
                 PAYtt(0,ref_,DAT7,FXB_,0, kk.kv,rNls_,K_,kk.kv,l_nls_dp ,0);
                 update opldok set txt=sKOMISA where ref=REF_ and stmt=gl.ASTMT;
              Else
                 rNls_ := B_1819;
                 PAYtt(0,ref_,DAT7,FXB_,0, kk.kv,B_1819,K_, gl.baseval, NLS71_, gl.p_icurval(kk.kv,K_,gl.bdate));
                 update opldok set txt=sKOMISN where ref=REF_ and stmt=gl.ASTMT;
              end if;
              LOG('CP_KUP ref='||ref_||' ком.='||K_,'INFO');
            else
                rNls_ := S_TRANS_DK_NLS;
                PAYtt(0,ref_,DAT7,FXB_,0, kk.kv,S_TRANS_DK_NLS,K_, gl.baseval, NLS71_, gl.p_icurval(kk.kv,K_,gl.bdate));
                update opldok set txt=sKOMISN where ref=REF_ and stmt=gl.ASTMT;
            end if;
           end if;
        -- купить ЦБ чужие OP=1
           INSERT into cp_arch(REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,acc,SUMB,N,D,P,R,STR_REF,OP) values (Ref_,nID_,DAT_UG,DAT_OPL,DAT_ROZ,acc_,S_,N_,D_,P_,R_+R3_,sREF,1 );
        -- Ощад просить CP_ARCH.br = RI_CPACCC.vidd  26/09-14

        begin
        select
        case
        when substr(nNBS_,1,3) in ('141','143','310','311','312') then 1
        when substr(nNBS_,1,3) in ('142','144','321') then 3
        when substr(nNBS_,1,3) in ('140','300','301') then 4
        when substr(nNBS_,1,3) in ('410','420') then 2
        else null  end
        into l_portf from dual;
        end;

        LOG('CP_KUP: portf='||l_portf||' NBS='||nNBS_,'TRACE',5);
        if l_portf is not null then
           l_tag:='PORTF';
           CP_SET_TAG(ref_,l_tag,l_portf,3);
        end if;

       bars_audit.info(title||' Start оценка справедливой стоимости RateB_/RateS_');
                  --16-02-10 створення вiрт.Д/П
       declare
         s2VD_  accounts.NLS%type   ;  s2VP_  accounts.NLS%type   ;
         a2VD_  accounts.ACC%type   ;  a2VP_  accounts.ACC%type   ;
         m2VD_  accounts.NmS%type   ;  m2VP_  accounts.NmS%type   ;
         s2VD0_ accounts.NLS%type   ;  s2VP0_ accounts.NLS%type   ;
         s2VD1_ accounts.NLS%type   ;  s2VP1_ accounts.NLS%type   ;
         Tips_  accounts.TIP%type   ;  txt_   opldok.txt%type     ;
         RateS_ CP_RATES.RATE_S%type;  RateB_ CP_RATES.RATE_B%type;
         ACCv_  accounts.ACC%type   ;  NLS_S499 accounts.NLS%type ;
         Vq_    number  ;
         DPN_   number  := D_ - P_  ;
       begin
         -- а есть ли рыночная цена на дату сделки
           SELECT rate_S / bsum, rate_B / bsum
              INTO RateS_, RateB_
              FROM CP_RATES
             WHERE     id = nID_
                   AND VDATE = DAT_UG
                   AND (rate_S IS NOT NULL OR rate_B IS NOT NULL);

             If RateB_ is not null then  S_:=abs(N_)*RateB_-(SUMB-RR_)*100; --по чист.цене
                                        bars_audit.info(title||' RateB_ ='|| to_char(nvl(RateB_,0.00))||' (по чист.цене)');
             else                       S_:=abs(N_)*RateS_-(SUMB    )*100; --по гряз.цене
                                        bars_audit.info(title||' RateS_ ='|| to_char(nvl(RateS_,0.00))||' (по гряз.цене)');
             end if;

         if S_ <> 0 then  LOG('CP_KUP ref='||ref_||' форм-ня VD/VP'||' Сума коригування='||S_,'INFO',5);
         else             LOG('CP_KUP ref='||ref_||' без формування VD/VP','INFO',5);   RETURN;
         end if;

         -- LOG('CP_KUP V ref='||ref_||' rnk='||kk.rnk,'INFO');

       ---------------   21/12

        If p_CP_AI  = '0'   then
           -- 26-10-2010  Опция "С акционерами"
           -- Создание=Открыть счет Виртуального ДП
           -- Капитал (5 класс) - из настройки субпортфелей.
           -- CP_ACCC.S2VD0 - Счет создания вирт.Дисконта
           -- CP_ACCC.S2VP0 - Счет создания вирт.Премии

           sERR:='45.Перев_рити конс. рах-ки щодо в_рт-х Д/П';
            select c.s2VD , c.s2VP , c.s2VD0 , c.s2VP0 , c.s2VD1 , c.s2VP1 , p.acc, d.acc, substr(p.nms,1,38), substr(d.nms,1,38)
            INTO     s2VD_,   s2VP_,   s2VD0_,   s2VP0_,   s2VD1_,   s2VP1_, a2VP_, a2VD_,          m2VP_ ,             m2VD_
            FROM  cp_accc c,  accounts d, accounts p
            where vidd=nNBS_ and RYN=nRYN_ and emi= kk.EMI
              and c.s2VD  is not null and c.s2VP  is not null and c.s2VD0 is not null and c.s2VD1 is not null
              and c.s2VP0 is not null and c.s2VP1 is not null and d.nls = c.s2VD and p.nls  =  c.s2VP
              and d.kv = kk.KV and p.kv = kk.KV and d.dazs is null  and p.dazs is null
              and S_ <>0 ;
            sERR:=null;

            If    S_>0 then ACCC_:= a2VP_; nls_:= s2VP_; nms_ := m2VP_ ;           Tips_:= '2VP'; dk_ := 1; sNls_:= s2VP0_;
            elsIf S_<0 then ACCC_:= a2VD_; nls_:= s2VD_; nms_ := m2VD_ ; /*S_:= -S_;*/ Tips_:= '2VD'; dk_ := 0; sNls_:= s2VD0_;
            end if;

        ElsIf p_CP_AI  = '1'   then
           /* 30-12-2010  Опция "Регул.ликвидности"
           Счета Виртуального Д/П НЕ открываются !
           Его остаток расчитывается и сразу сливается с реальным ДП
           Для балансировки используем
           счет cp_accc.S7499(Деб) или cp_accc.S6499 (Кред)
           */

            if NBUBNK_ = '1' then
               sERR:='46.Перев_рити конс. рах-ки щодо в_рт-х Д/П (6499,7499)';
            else
               sERR:='46.Перев_рити конс. рах-ки щодо в_рт-х Д/П (6390,7390)';
            end if;

            select decode( Sign(S_), -1, c.s7499, c.s6499)    INTO   NLS_S499
            FROM  cp_accc c,  accounts a6, accounts a7
            where vidd=nNBS_ and RYN=nRYN_ and emi= kk.EMI
              and a6.nls = c.s6499 and a6.kv = gl.baseval and a6.dazs is null
              and a7.nls = c.s7499 and a7.kv = gl.baseval and a7.dazs is null  and S_ <>0 ;
            sERR:=null;

        end if;

        -------------------------

         If p_CP_AI  = '0'  and NBUBNK_ = '1'  then

            /* 26-10-2010  Опция "С акционерами"  для НБУ
               Создание=Открыть счет Виртуального ДП
               Капитал (5 класс) - из настройки субпортфелей.
               CP_ACCC.S2VD0 - Счет создания вирт.Дисконта
               CP_ACCC.S2VP0 - Счет создания вирт.Премии
            */

           --LOG('CP_KUP V ref='||ref_||' rnk='||kk.rnk||' nls='||nls_,'INFO',5);
            nls_:= substr(NLS_,1,4)||'02'||Substr(S8_,-7);
            nms_:= substr( cp_id_r||nms_,1,38);
            cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , nls_, kk.kv,NMS_,Tips_, gl.aUid,accv_);
           --LOG('CP_KUP V1 ref='||ref_||' rnk='||kk.rnk||' accv='||accv_,'INFO',5);

                UPDATE accounts
                   SET mdate = kk.DATP,
                       accc = ACCC_,
                       seci = 4,
                       pos = 1,
                       daos = VDAT_
                 WHERE acc = accv_;

                cp_inherit_specparam (accv_, accc_, 0);

                s_:=abs(s_);
                Vq_ := gl.p_icurval( kk.kv, s_, VDAT_);
                PAYtt(0,ref_,VDAT_, FXB_,dk_, kk.kv ,NLS_,s_,gl.baseval,sNls_,Vq_);

                update opldok set txt=substr('Код '|| kk.CP_ID ||' створення вiрт.Д/П',1,70)  where ref=REF_ and stmt=gl.ASTMT;

                insert into cp_REF_ACC(ref,acc) values (REF_,Accv_);

                UPDATE CP_ARCH
                   SET VP = S_ * DK_, VD = S_ * (1 - DK_)
                 WHERE REF = REF_;

                begin
                insert into cp_accounts(cp_ref, cp_acctype, cp_acc)
                values (ref_,decode(DK_,0,'VD','VP'),accp_);
                exception
                       when dup_val_on_index then NULL;
                       when others then bars_audit.error ('CP: вставка новых счетов в cp_accounts неуспешна/'|| sqlerrm);
                 end;


         ElsIf p_CP_AI  = '1'  then
            /* 30-12-2010  Опция "Регул.ликвидности"
               Счета Виртуального Д/П НЕ открываются !
               Его остаток расчитывается и сразу сливается с реальным ДП
               Для балансировки используем
               счет cp_accc.S7499(Деб) или cp_accc.S6499 (Кред)
               в КБ рах-ки 7390, 6390
            Файл примеров  K:\sta\cp\NBU\Akcioner2.xls
            -------------------------------------------------------------
               ||Реальн.||Виртуал||Сальдо ||   Проводки                ||
            ---||-------||-------||-------||---------------------------||
             № ||рД |рП ||вД |вП ||рД |рП || Деб | Кред| Сумма  Коммент||
            ===||=======||=======||=======||===========================||
            *0д||   |   || 1 |   || 1 |   || 7499| рД  |  1  Откытие рД|| Приклад № 8
            ---||-------||-------||-------||---------------------------||
            *0п||   |   ||   |-1 ||   |-1 || рП  | 6699|  1  Откытие рП|| Приклад № 7
            ---||-------||-------||-------||---------------------------||
            *д1|| 2 |   || 1 |   || 3 |   || 7499| рД  |  1     Увел рД|| Приклад № 3
            ---||-------||-------||-------||---------------------------||
            *д2|| 2 |   ||   |-1 || 1 |   || рД  | 6499|  1     Умен рД|| Приклад № 1
            ---||-------||-------||-------||---------------------------||
            *д3|| 2 |   ||   |-3 ||   |-1 || рД  | 6499|  2    Обнул рД|| Приклад № 2
               ||   |   ||   |   ||   |   || рП  | 6499|  1  Откытие рП||
            ---||-------||-------||-------||---------------------------||
            *п1||   |-2 ||   |-1 ||   |-3 || рП  | 6499|  1     Увел рП|| Приклад № 4
            ---||-------||-------||-------||---------------------------||
            *п2||   |-2 || 1 |   ||   |-1 || 7499| рП  |  1     Умен рП|| Приклад № 6
            ---||-------||-------||-------||---------------------------||
            *п3||   |-2 || 3 |   || 1 |   || 7499| рП  |  2    Обнул рП|| Приклад № 5
               ||   |   ||   |   ||   |   || 7499| рД  |  1  Откытие рД||
            ---||-------||-------||-------||---------------------------||
          */

            sERR:=null;

            DPN_ := DPN_ - S_;
            txt_ := 'Об`єднання вiрт.Д/П з реал.Д/П';
            LOG('CP_KUP ref='||ref_||' VD/VP nls='||nls_s499,'INFO',5);

            If s_ >0 then dk_:= 0;                   --Вирт.П
            else          dk_:= 1;   S_ := - S_ ;    --Вирт.Д
            end if;

            If    DK_=0 and D_>0 and  S_< D_   -- рД + вП Приклад № 1 6499 Умен рД
               OR DK_=1 and D_>0               -- рД + вД Приклад № 3 7499 Увел рД
               OR DK_=0 and P_>0               -- рП + вП Приклад № 4 6499 Увел рП
               OR DK_=1 and P_>0 and  S_< P_   -- рП + вД Приклад № 6 7499 Умен рП
               then
               Vq_ := gl.p_icurval( kk.kv, s_, VDAT_);
               PAYtt(0,ref_,VDAT_,FXB_,dk_,gl.baseval,NLS_S499,Vq_, kk.kv,l_NLS_DP,s_ );
               update opldok set txt= txt_ where ref=REF_ and stmt=gl.ASTMT;
            else

               If    DK_=0 and D_>0 and S_>= D_ --рД => рП Приклад № 2 6499 Обнул рД
                  OR DK_=1 and P_>0 and S_>= P_ --рП => рД Приклад № 5 7499 Обнул рП
                  then
                  Vq_ := gl.p_icurval( kk.kv, (P_+D_), VDAT_);
                  PAYtt(0,ref_,VDAT_,FXB_,dk_, gl.baseval,NLS_S499,Vq_, kk.kv,l_NLS_DP, P_+D_ );
                  update opldok set txt= txt_ where ref=REF_ and stmt=gl.ASTMT;
               end if ;

               S_ := S_- (P_+D_);
               If S_ > 0 then
                  -- Откытие рП Приклад № 2
                  -- Откытие рП Приклад № 7
                  -- Откытие рД Приклад № 5
                  -- Откытие рД Приклад № 8

                  -- закр сч Д/П
                  --delete from int_accn where acc=ACC_ and id in (2,3);
                  insert into cp_REF_ACC (ref,acc) select REF_,nvl(accp,accd) from CP_deal where (accp is not null OR accd is not null) and ref=REF_;
                  begin
                     select a.acc, substr(cp_id_r||a.nms,1,38),  substr(a.nls,1,5)||decode( kk.DOX, 1, '2','0')||S8_
                     into accc_, NMS_, l_NLS_DP
                     from accounts a, cp_accc p  where a.nls = decode(DK_,0,p.nlsP,p.nlsD)  and a.kv= kk.KV and p.vidd=nNBS_ and  p.emi= kk.EMI and p.RYN=nRYN_;
                  EXCEPTION WHEN NO_DATA_FOUND THEN sERR :='38.Нет сч.реал.Д/П в ФУ'; return;
                  END;
                  cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , l_NLS_DP, kk.kv ,NMS_,'ODB',gl.aUid,accP_);
                  UPDATE accounts SET mdate= kk.DATP ,accc=ACCC_,seci=4, pos=1, daos=VDAT_  WHERE acc=accP_;

                  cp_inherit_specparam (accP_, accc_, 0);

                  LOG('CP_KUP ref='||ref_||' VD/VP *nls='||l_nls_dp,'INFO',5);

                  if kk.DOX >= 2 then
                     If DK_= 0 then --Вирт.П
                       --insert into int_accn  (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO, basey,freq) values (ACC_,ACCP_,ACRBP_,3,6,gl.bdate-1,V1_, kk.DATP-1,IO_,0,1);
                        begin
                        update int_accn set acra = ACCP_, id = 3
                         where acc = ACC_ and id in (2,3);
                         if sql%rowcount = 0 then
                          begin
                            insert into int_accn  (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO, basey,freq) values (ACC_,ACCP_,ACRBP_,3,6,gl.bdate-1,V1_, kk.DATP-1,IO_,0,1);
                          exception when dup_val_on_index then bars_audit.error('cp_kup: неудача при вставке проц карточки 3 с учетом вирт д/п');
                          end;
                         end if;
                        end;
                        update cp_deal set accP=ACCP_, accD = null where ref=REF_;
                     else           --Вирт.Д
                        --insert into int_accn  (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO, basey,freq) values (ACC_,ACCP_,ACRB_,2,6,gl.bdate-1,V1_, kk.DATP-1,IO_,0,1);
                        begin
                        update int_accn set acra = ACCP_, id = 2
                         where acc = ACC_ and id in (2,3);
                         if sql%rowcount = 0 then
                          begin
                            insert into int_accn  (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO, basey,freq) values (ACC_,ACCP_,ACRB_,2,6,gl.bdate-1,V1_, kk.DATP-1,IO_,0,1);
                          exception when dup_val_on_index then bars_audit.error('cp_kup: неудача при вставке проц карточки 2 с учетом вирт д/п');
                          end;
                         end if;
                        end;

                        update cp_deal set accP=null, accD = ACCP_ where ref=REF_;
                     end if;
                  end if;

                  Vq_ := gl.p_icurval( kk.kv, s_, VDAT_);
                  PAYtt(0,ref_,VDAT_,FXB_,dk_, gl.baseval,NLS_S499,Vq_, kk.kv,l_NLS_DP,s_);
                  update opldok set txt= txt_ where ref=REF_ and stmt=gl.ASTMT;

                  begin
                  insert into cp_accounts(cp_ref, cp_acctype, cp_acc)
                  values (ref_,decode(DK_,0,'P','D'),accp_);
                  exception
                        when dup_val_on_index then NULL;
                        when others then bars_audit.error ('CP: вставка новых счетов в cp_accounts неуспешна/'|| sqlerrm);
                  end;

               end if;

            end if;

            If DPN_ > 0 then   update CP_ARCH Set D = DPN_ , P =   0    where ref=REF_;
            else               update CP_ARCH Set D = 0    , P = - DPN_ where ref=REF_;
            end if;

               --- 21/12
         ElsIf p_CP_AI  = '0' and NBUBNK_ = '0'  then
          /*   в КБ Ощадбанк
               Опция "Регул.ликвидности" для акционеров
               Счета Виртуального Д/П НЕ открываются !
               Его остаток расчитывается и сразу сливается с реальным ДП
               Для балансировки используем счет cp_accc.S2VD0
          */

            sERR:=null;
            NLS_S499:=S2VD0_;

            DPN_ := DPN_ - S_;
            txt_ := 'Об`єднання вiрт.Д/П з реал.Д/П';
            LOG('CP_KUP ref='||ref_||' VD/VP nls='||nls_s499,'INFO',5);

            If s_ >0 then dk_:= 0;                   --Вирт.П
            else          dk_:= 1;   S_ := - S_ ;    --Вирт.Д
            end if;

            If    DK_=0 and D_>0 and  S_< D_   -- рД + вП Приклад № 1 6499 Умен рД
               OR DK_=1 and D_>0               -- рД + вД Приклад № 3 7499 Увел рД
               OR DK_=0 and P_>0               -- рП + вП Приклад № 4 6499 Увел рП
               OR DK_=1 and P_>0 and  S_< P_   -- рП + вД Приклад № 6 7499 Умен рП
               then
               Vq_ := gl.p_icurval( kk.kv, s_, VDAT_);
               PAYtt(0,ref_,VDAT_,FXB_,dk_,gl.baseval,NLS_S499,Vq_, kk.kv,l_NLS_DP,s_ );
               update opldok set txt= txt_ where ref=REF_ and stmt=gl.ASTMT;
            else

               If    DK_=0 and D_>0 and S_>= D_ --рД => рП Приклад № 2 6499 Обнул рД
                  OR DK_=1 and P_>0 and S_>= P_ --рП => рД Приклад № 5 7499 Обнул рП
                  then
                  Vq_ := gl.p_icurval( kk.kv, (P_+D_), VDAT_);
                  PAYtt(0,ref_,VDAT_,FXB_,dk_, gl.baseval,NLS_S499,Vq_, kk.kv,l_NLS_DP, P_+D_ );
                  update opldok set txt= txt_ where ref=REF_ and stmt=gl.ASTMT;
               end if ;

               S_ := S_- (P_+D_);
               If S_ > 0 then
                  -- opening рП Приклад № 2
                  --         рП Приклад № 7
                  --         рД Приклад № 5
                  --         рД Приклад № 8

                  -- close сч Д/П
                  delete from int_accn where acc=ACC_ and id in (2,3);
                  insert into cp_REF_ACC (ref,acc)
                  select REF_,nvl(accp,accd)
                         from CP_deal where (accp is not null OR accd is not null)
                                            and ref=REF_;
                  begin
                     select a.acc, substr(cp_id_r||a.nms,1,38),  substr(a.nls,1,5)||decode( kk.DOX, 1, '2','0')||S8_
                     into accc_, NMS_, l_NLS_DP
                     from accounts a, cp_accc p
                     where a.nls = decode(DK_,0,p.nlsP,p.nlsD)  and a.kv= kk.KV
                           and p.vidd=nNBS_ and  p.emi= kk.EMI and p.RYN=nRYN_;
                  EXCEPTION WHEN NO_DATA_FOUND THEN sERR :='38.Нет сч.реал.Д/П в ФУ'; return;
                  END;
                  cp.CP_REG_EX(99,0,0,GRP_,r1_, kk.RNK , l_NLS_DP, kk.kv ,NMS_,'ODB',gl.aUid,accP_);
                  UPDATE accounts SET mdate= kk.DATP ,accc=ACCC_,seci=4, pos=1, daos=VDAT_  WHERE acc=accP_;
                  LOG('CP_KUP ref='||ref_||' VD/VP *nls='||l_nls_dp,'INFO',5);

                  if kk.DOX >= 2 then
                     If DK_= 0 then --Вирт.П
                        insert into int_accn  (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO, basey,freq)
                        values (ACC_,ACCP_,ACRBP_,3,6,gl.bdate-1,V1_, kk.DATP-1,IO_,0,1);
                        update cp_deal set accP=ACCP_, accD = null where ref=REF_;
                     else           --Вирт.Д
                        insert into int_accn  (acc,acra,acrb,id,metr,ACR_DAT,s,STP_DAT,IO, basey,freq)
                        values (ACC_,ACCP_,ACRB_,2,6,gl.bdate-1,V1_, kk.DATP-1,IO_,0,1);
                        update cp_deal set accP=null, accD = ACCP_ where ref=REF_;
                     end if;
                  end if;

                  Vq_ := gl.p_icurval( kk.kv, s_, VDAT_);
                  PAYtt(0,ref_,VDAT_,FXB_,dk_, gl.baseval,NLS_S499,Vq_, kk.kv,l_NLS_DP,s_);
                  update opldok set txt= txt_ where ref=REF_ and stmt=gl.ASTMT;

                  begin
                  insert into cp_accounts(cp_ref, cp_acctype, cp_acc)
                  values (ref_,decode(DK_,0,'P','D'),accp_);
                  exception
                        when dup_val_on_index then NULL;
                        when others then bars_audit.error ('CP: вставка новых счетов в cp_accounts неуспешна/'|| sqlerrm);
                  end;

               end if;

            end if;

            If DPN_ > 0 then   update CP_ARCH Set D = DPN_ , P =   0    where ref=REF_;
            else               update CP_ARCH Set D = 0    , P = - DPN_ where ref=REF_;
            end if;

         end if;   -- If p_CP_AI

       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end;   -- VD/VP

       --  "конец" купить чужие
       RETURN;
    end if;

--------------------------------------
     -- выкупить(погасить) свои
     SA_:= SUMB *100;   SN_:= SUMBN *100;  SD_:=0;  SP_:=0;   SR_:=0; SS_:=0;
     NN_:= SN_;
     for k in (select a.acc, e.ref, a.nls NLSA, a.ostb OSTA,   d.nls NLSD , -nvl( d.ostb,0) OSTD ,
                      p.nls NLSP  ,  nvl( p.ostb,0)    OSTP,   r.nls NLSR ,  nvl( r.ostb,0) OSTR, e.erat
               from cp_deal e, accounts a, accounts d, accounts p, accounts r
               where e.id  =nID_       AND substr(a.nls,1,4)= nNBS_ AND  e.ryn =nRYN_      AND a.acc  = e.acc      AND
                     e.accd= d.acc (+) AND e.accp = p.acc (+)       AND  e.accr= r.acc (+) AND a.ostb > 0
               order by e.ref)
     loop
        if NN_ >0 then           N_ := least(NN_, k.OSTA);
           payTT(0,ref_,VDAT_,FXB_,1, kk.kv ,k.NLSA,N_, kk.kv ,B_4621,N_);
           update opldok set txt= substr('Код '|| kk.CP_ID ||' '|| sNOMINAL||' '|| N_,1,70)  where ref=REF_ and stmt=gl.ASTMT;
           NN_:= NN_ - N_;
           if kk.DOX =1 then
              update cp_deal set erat=erat - (k.erat/k.OSTA)*N_        where ref=k.ref;
           end if;

           if k.OSTD >0 then
              S_:= round( (k.OSTD /k.OSTA)*N_, 0) ;
              PAYtt(0,ref_,VDAT_, FXB_,0, kk.kv ,k.NLSD,S_, kk.kv ,B_4621,S_);
              update opldok set txt= substr('Код '|| kk.CP_ID ||' '|| sDISKONT|| kk.name ,1,70) where ref=REF_ and stmt=gl.ASTMT;
              SD_:=SD_ + S_;
           end if;

           if k.OSTP >0 then
              S_:= round( (k.OSTP /k.OSTA)*N_, 0) ;
              PAYtt(0,ref_,VDAT_, FXB_,1, kk.kv ,k.NLSP,S_, kk.kv ,B_4621,S_);
              update opldok set txt= substr('Код '|| kk.CP_ID||' '|| sPREMIA|| kk.name ,1,70) where ref=REF_ and stmt=gl.ASTMT;
              SP_:=SP_ + S_ ;
           end if;
           if k.OSTR >0 and kk.DOX >= 2 then
              --S_:= round( (k.OSTR /k.OSTA)*N_, 0) ;
              S_ := least ( k.OSTR, R_); R_:= R_ - S_;
              PAYtt(0,ref_,VDAT_, FXB_,1, kk.kv ,k.NLSR,S_, kk.kv ,B_4621,S_);
              update opldok set txt= substr('Код '|| kk.CP_ID||' '|| sKUPON|| kk.name ,1,70)  where ref=REF_ and stmt=gl.ASTMT;
              SR_:=SR_ + S_;
           end if;
        end if;
     end loop;
     If NN_ >0 then    sERR:='39.Нет нужной суммы номинала'; return;   end if;

     T_:= SA_ - SN_ + SD_ - SP_ - SR_ ;
     if T_<> 0 then   IF t_ >0 THEN dk_:=0;  ELSE  dk_:=1; END IF;    T_:=Abs(T_);
        PAYtt(0,ref_,VDAT_, 'FXT',DK_, kk.kv ,B_4621, T_,gl.baseval,NLS703,  gl.p_icurval( kk.kv ,T_,VDAT_) );
        update opldok set txt = substr('Код '|| kk.CP_ID||' '|| sSOBIVN|| kk.name ,1,70)  where ref=REF_ and stmt=gl.ASTMT;
     end if;

     -- Выкупить(т.е. только погасть) ЦБ свои OP=20
     INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,  SUMB,  N,  D,  P,  R,STR_REF, OP )
     values              (Ref_,nID_,DAT_UG,DAT_OPL,DAT_ROZ, SA_,SN_,SD_,SP_,SR_,sREF  , 20 );

end CP_kup;
-------------------------------------------------------------------------------
-- CP_cur() процедура переоценки
-------------------------------------------------------------------------------
/* 18.11.2013 Все переделываем ! Переоцениваем форварт-остаток
-- 19.04.2013 - Довбня Л.О. <larysa@bank.gov.ua>
-- 1. При переоценке, не учитывать частичную сумму по сделке, которая заложена в будущем на продажу.
-- 2. Заложить в ПО параметр CP_FORV_,
--    который будет давать возможность, для сделок, которые участвуют в форвардных продажах, выбора переоценивать их или нет.
-- 3. Во время оплаты в день валютирования сделок по форвардным продажам, списывать сумму со счетов переоценки актива и доходов,
    в процентном соотношении суммы которые были на момент ввода операции, а не на дату валютирования.
    Между датой операции и датой валютирования на эти счета будут зачислены суммы переоценки на остаток, который остается после продажи.
*/
-------------------------------------------------------------------------------
PROCEDURE CP_cur (REF1_   IN     cp_deal.ref%type,      -- идентификатор "кучки" или референс сделки
                  ID_     IN     cp_kod.id%type,        -- идентификатор ЦБ в системе cp_kod.id
                  GRP_    IN     INT,
                  PF_     IN     INT,
                  DAT_    IN     DATE,                  -- дата курса (дата переоценки?)
                  s6300   IN     accounts.nls%type,     -- номер счета 6300 "Дохід у вигляді дивiдендiв"
                  s4621   IN     accounts.nls%type,     -- номер транзитного счета в валюте ЦБ
                  sErr       OUT VARCHAR2)              -- флаг ошибки
IS
 l_tt       tts.tt%type := 'FXP';   -- код операции переоценки
 CP_FORV_   char(1)     := '0';     -- гл.парам CP_FORV=1=Не переоц.будущие продажи (пока не используется)
 FL_        int;                    -- параметр от флага операции 37 Оплата по факт.остатку = 1 (FL_ = 2)/ По план.остатку = 0 (FL_ = 0)/ Не платить = 2 (FL_ = 0)
 NAME_4621  varchar2(38);           -- наименование cчета транзита в валюте ЦБ
 OKPO_      varchar2(15);           -- ОКПО счета транзита (NAME_4621) в валюте ЦБ
 NAME_6300  varchar2(38);           -- наименование общ.счета 6300 для переоц (из карт.оп.'FXP')
 VOB_       oper.vob%type;          -- вид банковского документа
 VDAT_      date;                   -- дата валютирования
 PREV_VDAT_ date;                   -- дата пердыдущей переоценки
 koeff_     number      :=  1;      -- коеффициент = удельный вес (через номинал) проданой в будущем и не проданой части
 NEW_       number;                 -- новая стоимость (новая цена номинала)
 OLD_       number;                 -- старая стоимость (старая цена номинала)
 S_         number;                 -- разница = старая цена - новая цена (OLD_ - NEW_)
 SS_        number;
 DK_        int;
 SQ_        number;
 EMI_       int;

 ref_       int;
 QQ_        number;
 NAZN_      oper.nazn%type;         -- назначение документа переоценки


 S_FXP_     varchar2(15);           -- частный грн-счет для переоц (из CP_ACCC)
 NAME_FXP_  varchar2(38);           -- и его наименование

 OSTA_      number;                 -- номинал (новая цена остатка номинала за DAT_ курса)
 OSTS_      number;                 -- переоценка (старая цена)
 OSTD_      number;                 -- дисконт
 OSTP_      number;                 -- премия
 OSTR_      number;                 -- купон начисленный
 OSTR2_     number;                 -- купон накопленный
 OST2VDP_   number;                 -- вирт.Д/П

BEGIN

 bars_audit.trace('%s Start for ID = %s, ref = %s', 'CP_CUR:', to_char(ID_), to_char(REF1_));
 BEGIN
    select substr(trim(val),1,1)
      into CP_FORV_                 -- нигде пока далее не используется
      from params
     where par = 'CP_FORV';
 EXCEPTION WHEN NO_DATA_FOUND THEN null;
 END;

 BEGIN
  -- Проверка наличия кода и настроек операции op.tt
  -- Читаем флаг операции 37 Оплата по факт.остатку = 1 (FL_ = 2)/ По план.остатку = 0 (FL_ = 0)/ Не платить = 2 (FL_ = 0)
   BEGIN
      SELECT DECODE (SUBSTR (flags, 38, 1), '1', 2, 0)
        INTO FL_
        FROM tts
       WHERE tt = l_tt;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN sERR := '40.Нет оп.FXP';
           bars_error.raise_nerror('DOC', 'TRANSACTION_DOES_NOT_EXIST', l_tt);
           bars_audit.trace('%s init sERR = %s', 'CP_CUR:', sERR);
   END;

   BEGIN
       select *
         into kk                        -- пакетная коллекция параметров кода ценной бумаги
         from cp_kod
        where id    = ID_               --(ID_ входной параметр)
          and AMORT = 0;
   EXCEPTION WHEN OTHERS
             THEN bars_audit.trace('%s пакетная коллекция параметров кода ценной бумаги ID_ = %s failed: %s, %s, %s',
                                    'CP_CUR:',
                                    TO_CHAR(ID_),
                                    to_char(SQLCODE),
                                    SQLERRM,
                                    DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
                  sERR := ': Ценная бумага ID = '|| TO_CHAR(ID_) ||' является амортизационной или не описана в CP_KOD. Переоценка неуспешна.';
                  RETURN;
   END;

   begin
       select substr(a.nms,1,38), c.okpo
         into NAME_4621, OKPO_
         from accounts a,
              cust_acc u,
              customer c
        where a.acc = u.acc
          and u.rnk = c.rnk
          and a.nls = s4621             --(s4621 входной параметр)
          and a.kv  = kk.KV;
   exception when NO_DATA_FOUND
             then sERR:='40.Нет сч.транзита '||s4621|| '/'|| kk.KV;
                  bars_audit.trace('%s init sERR = %s', 'CP_CUR:',sERR);
                  RETURN;
   end;

   if s6300 is not null                 --(s6300 входной параметр)
   then
    begin
        select substr(nms,1,38)
          into NAME_6300
          from accounts
         where kv  = gl.baseval
           and nls = s6300;             --(s6300 входной параметр)
    exception when no_data_found
              then sERR:='41/1.Нет сч.дох-расх по переоценке '||s6300;
                   bars_audit.trace('%s init sERR = %s', 'CP_CUR:', sERR);
    end;
   end if;
 EXCEPTION WHEN OTHERS
           THEN bars_audit.trace('%s init failed:', 'CP_CUR:',SQLERRM);
                RETURN;
 END;

 if sERR is null
  then bars_audit.trace('%s init ok', 'CP_CUR:');
 end if;

-----------------------------------------------
  for k in (SELECT e.REF,
                   SUBSTR (da.NLS, 1, 1)    N8,
                   c.VDATE,
                   c.RATE_O,                        -- курс на дату DAT_ (cp_rates)
                   c.BSUM,                          -- базовая сумма курса (cp_rates)
                   e.ACC,
                   e.ACCS,
                   e.accs6,                         -- дочерний счет 6300
                   e.ACCD,
                   e.ACCP,
                   e.ACCR,
                   e.ACCR2,
                   rs.KV,
                   kc.NLSS                  NLSS_G,
                   SUBSTR (rs.nms, 1, 38)   NMS,
                   ds.nls                   NLSS,
                   NVL (kc.NLS_FXP, s6300)  NLS_FXP,
                   NVL (PRO, 0)             PRO,
                   da.OSTF,
                   ds.OSTF                  OSTFS
              FROM accounts da,                     /* доч номинал */
                   accounts ds,                     /* доч переоц */
                   cp_deal e,                       /* кучки */
                   cp_rates c,                      /* курсы */
                   CP_ACCC kc,                      /* консолид сч */
                   ACCOUNTS rS                      /* род переоц */
             WHERE     e.id = kk.id
                   AND e.acc = da.acc
                   AND da.OSTC = da.OSTB            /* защита от новых операций */
                   AND e.accs = ds.acc
                   AND ds.OSTC = ds.OSTB            /* защита от незавиз опер по переоц */
                   AND e.id = ID_                   --(ID_ входной параметр)
                   AND e.id = c.id
                   AND ds.accc = rs.ACC
                   AND rs.nls = kC.nlss
                   AND ds.kv = rs.kv
                   AND e.REF = REF1_                --(REF1_ входной параметр)
                   AND c.IDB = kc.IDB
                   AND e.ryn = kc.RYN
                   AND c.VDATE = (SELECT MAX (VDATE)
                                    FROM cp_rates
                                   WHERE idb   = c.idb
                                     AND id    = e.id
                                     AND VDATE <= DAT_)--(DAT_ входной параметр)
          )
    loop
       bars_audit.trace('%s start loop', 'CP_CUR:',sERR);
       -- обычная переоценка (грн или вал)
       -- вычитываем вид банковского документа
       if k.KV = gl.baseval
        then VOB_:= 6;
        else VOB_:= 16;
       end if;

       -- дата валютирования
       VDAT_  := gl.bdate;

       -- в период ЗО на Украине (по курсу прошл.мес)
       If gl.baseval = 980 and to_char(gl.bdate,'yyyyMM') > to_char(k.VDATE,'yyyyMM')
       then VOB_    :=  96;
            VDAT_   :=  F_VDAT_ZO(k.VDATE);
       end if;

       -- новая цена остатка номинала за DAT_ курса
       if VOB_ = 96
        then OSTA_ := FOSTZn(k.ACC, VDAT_, gl.bdate);
        else OSTA_ := FOST(k.ACC,gl.bdate);
       end if;
       bars_audit.trace('%s OSTA_=', 'CP_CUR:',to_char(OSTA_));
       -- считаем коеф = удельный вес (через номинал) проданой в будущем и не проданой части
       If OSTA_ = 0
        then koeff_ := 1;
        else koeff_ := (k.OSTF + OSTA_)/ OSTA_;
       end if;
       bars_audit.trace('%s koeff_=', 'CP_CUR:',to_char(koeff_));
       -- новая цена остатка номинала за DAT_ курса с учетом проданной в будущем части
       OSTA_    := k.OSTF + OSTA_;

       -- новая цена номинала = (новая цена остатка номинала за DAT_ курса с учетом проданной в будущем части * курс(cp_rates.rate_o)/базовая сумма(cp_rates.bsum)
       NEW_     := round((OSTA_ * k.RATE_O/k.BSUM), 0);
       bars_audit.trace('%s NEW_=', 'CP_CUR:',to_char(NEW_));
       -- стаые цены пересчитаем по составляющим.
       OSTS_ := 0;        -- старая цена: переоценка
       If k.ACCS is not null then
          If VOB_ = 96
           then OSTS_ := FOSTZn (k.ACCS, VDAT_, gl.bdate );
           else OSTS_ := FOST   (k.ACCS,        gl.bdate );
          end if;
        OSTS_ := OSTS_ + k.OSTFS ; -- форвард-остаток
       end if;

       OST2VDP_ := 0 ;   ---- старая цена: Виртуального Д/П
       BEGIN
       select koeff_* NVL(SUM(DECODE(VOB_, 96, FOSTZn(x.ACC,VDAT_,gl.BDate), FOST(x.ACC, gl.bdate))),0)
         into OST2VDP_
         from accounts a,
              cp_ref_acc x
        where a.accc is not null
          and a.tip in ('2VD','2VP')
          and a.acc = x.acc
          and x.ref = k.REF;
       EXCEPTION WHEN NO_DATA_FOUND
                 THEN NULL;  -- тут ничего не делаем сознательно, виртуального Д/П может просто не быть
       END;

       OSTD_ := 0;        ---- старая цена: дисконт
       If k.ACCD is not null
       then
          If VOB_ = 96
           then OSTD_ := koeff_ * FOSTZn(k.ACCD, VDAT_, gl.bdate);
           else OSTD_ := koeff_ * FOST  (k.ACCD,        gl.bdate);
          end if;
       end if;

       OSTP_ := 0;        ---- старая цена: премия
       If k.ACCP is not null
       then
         If VOB_ = 96
          then OSTP_ := koeff_ * FOSTZn (k.ACCP, VDAT_, gl.bdate);
          else OSTP_ := koeff_ * FOST   (k.ACCP,        gl.bdate);
         end if;
       end if;

       OSTR_ := 0;        ---- старая цена: купон начисленный
       If k.ACCR is not null and k.PRO = 1
       then
         If VOB_ = 96
          then OSTR_ := koeff_ * FOSTZn (k.ACCR, VDAT_, gl.bdate);
          else OSTR_ := koeff_ * FOST   (k.ACCR,        gl.bdate);
         end if;
       end if;

       OSTR2_ := 0;     ---- старая цена: купон накопленный
       If k.ACCR2 is not null and k.PRO = 1 then
          If VOB_ = 96
           then OSTR2_ := koeff_ * FOSTZn(k.ACCR2, VDAT_, gl.bdate);
           else OSTR2_ := koeff_ * FOST  (k.ACCR2,        gl.bdate);
          end if;
       end if;

       -- старая цена:   Итого
       if kk.dox > 1 -- Вид доходности
        then OLD_ := OSTA_ + OSTS_ + OSTD_ + OSTP_ + OSTR_ + OSTR2_ + OST2VDP_ ; -- 2.Борговi ЦП / 21.Купон (%>0) Зовнўшня позика
        else OLD_ := 0     + OSTS_ + OSTD_ + OSTP_ + OSTR_ + OSTR2_ + OST2VDP_ ; -- 1.Нефiкс.прибуток (дивиденд)
       end if;

       -- Разница = старая цена - новая цена
       S_:= ROUND((OLD_ - NEW_), 0);
       bars_audit.trace('%s S_=', 'CP_CUR:',to_char(S_));
       If S_ <> 0 then
          If s6300 is not null              --(s6300 входной параметр, счет доходов)
          then
            S_FXP_      := s6300;
            NAME_FXP_   := NAME_6300;
          else
            BEGIN
            select substr(nms,1,38)
              into NAME_FXP_
              from accounts
             where kv = gl.baseval
               and nls = k.NLS_FXP;

             S_FXP_:= k.NLS_FXP;
            EXCEPTION WHEN NO_DATA_FOUND
                      THEN NULL; -- наименование получателя может быть пустым в oper.nam_b (nullable = Y)
            END;
          end if;

          if S_ < 0 -- если разница переоценки отрицательная, меняем направление проводки
          then  DK_:= 0;
                S_ := -S_;
          else  DK_:= 1;
          end if;
          -- эквивалент переоценки на дату валютирования (банкдата)
          SQ_   := gl.p_icurval(k.kv, S_, VDAT_);
          -- назначение документа переоценки
          nazn_ := substr( to_char(kk.CP_ID)
                            ||'. '
                            ||to_char(REF1_)
                            ||'. Переоцiнка ЦП по курсу '
                            ||to_char(k.RATE_O)
                            ||'/'
                            ||to_char(k.BSUM)
                            ||', дата курсу '
                            ||to_char(k.VDATE,'dd/mm/yyyy'),1,160);

          --вставка документа
          BEGIN
            gl.ref (REF_);
            gl.in_doc3 (   ref_     => REF_,
                           tt_      => l_tt,
                           vob_     => vob_,
                           nd_      => SUBSTR (TO_CHAR (REF_), 1, 10),
                           pdat_    => SYSDATE,
                           vdat_    => vdat_,
                           dk_      => dk_,
                           kv_      => kk.kv,
                           s_       => s_,
                           kv2_     => gl.baseval,
                           s2_      => SQ_,
                           sk_      => NULL,
                           data_    => GREATEST (VDAT_, gl.bdate),
                           datp_    => gl.bdate,
                           nam_a_   => K.NMS,
                           nlsa_    => K.NLSS_G,
                           mfoa_    => gl.AMFO,
                           nam_b_   => NAME_FXP_,
                           nlsb_    => S_FXP_,
                           mfob_    => gl.AMFO,
                           nazn_    => nazn_,
                           d_rec_   => NULL,
                           id_a_    => OKPO_,
                           id_b_    => OKPO_,
                           id_o_    => NULL,
                           sign_    => NULL,
                           sos_     => 1,
                           prty_    => NULL,
                           uid_     => NULL);
          EXCEPTION WHEN OTHERS
                    THEN sERR := 'CP_CUR: неудача при вставке документа переоценци: '||to_char(SQLCODE)||','||SQLERRM||','||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
          END;

          --18.12.2012 Переоценка - на внесистемные счета 63*
          declare
           nlss6_   accounts.nls%type := S_FXP_;
          begin
             If k.accs6 is not null
             then --
                BEGIN
                    select nls
                      into nlss6_
                      from accounts
                     where acc = k.accs6
                       and kv = gl.baseval
                       and dazs is null;
                EXCEPTION WHEN NO_DATA_FOUND THEN null;
                END;
             end if;

             If CP_CUR_ = '1'
             then      -----  расформировать и сформировать наново
             /*
               bars_audit.trace('%s Поиск предыдущей переоценки', 'CP_CUR');
               BEGIN                                                 --COBUSUPABS-3715
                  SELECT MAX (fdat)
                    INTO PREV_VDAT_
                    FROM opldok
                   WHERE acc = nvl(k.accs6, k.accs)
                     AND sos = 5
                     AND fdat >= (select daos from accounts where acc = nvl(k.accs6, k.accs))
                     AND fdat < gl.bdate;
                  bars_audit.trace('%s Дата предыдущей переоценки = %s', 'CP_CUR', to_char(PREV_VDAT_,'dd.mm.yyyy'));
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN PREV_VDAT_ := gl.bdate;
                       bars_audit.trace('%s Дата предыдущей переоценки не найдена', 'CP_CUR');
               END;*/

                If OSTS_ <> 0
                then
                 If OSTS_ > 0
                  then DK_ := 1;
                  else DK_ := 0;
                 end if;

                 S_ := ABS(OSTS_);
                 SQ_:= gl.p_icurval(k.kv, S_, VDAT_);--COALESCE(PREV_VDAT_,VDAT_)); -- COBUSUPABS-3715

                 PAYtt(0,           ref_,   VDAT_,
                       l_tt,        DK_,
                       k.kv,        k.NLSS, S_,
                       gl.baseval,  nlss6_, SQ_);

                 update opldok
                    set txt = DECODE(DK_, 0, sPEREOV, sPEREOP)
                  where ref = REF_
                    and stmt = gl.ASTMT;
                end If;

                S_:= (OSTS_ + NEW_- OLD_ );

                If S_ <> 0
                then
                 If S_ < 0
                  then DK_ := 1;
                  else DK_ := 0;
                 end if;

                 S_ := ABS(S_);
                 SQ_:= gl.p_icurval(k.kv, S_, VDAT_);

                 PAYtt(0,           ref_,   VDAT_,
                       l_tt,        DK_,
                       k.kv,        k.NLSS, S_,
                       gl.baseval,  nlss6_, SQ_);

                   update opldok
                      set txt = DECODE(DK_, 0, sPEREOV, sPEREOP)
                    where ref = REF_
                      and stmt = gl.ASTMT;
                end If;
             else       ----- только дельта переоценки
                PAYTT(0,            ref_,   VDAT_,
                      l_tt,         DK_,
                      k.kv,         k.NLSS, S_,
                      gl.baseval,   nlss6_, SQ_);

                update opldok
                   set txt = DECODE(DK_, 0, sPEREOV, sPEREOP)
                 where ref = REF_
                   and stmt = gl.ASTMT;
             end if;
          end;

          -- Если стоит флаг оплаты (37 = 1), платим по факту
          if FL_ = 2
          then
            gl.pay(2,REF_,gl.bDATE);
          end if;
       end if; --If S_ <> 0 then
    end loop;

    if SQL%ROWCOUNT = 0
     then
       sERR:=': Не найдены данные для переоценки ЦБ '|| to_char(ID_);
       RETURN;
    end if;
 RETURN;
end CP_cur;
---------------------------------------------------------------------------
/* PROCEDURE CP_vneb */
-- процедура внебаланса
---------------------------------------------------------------------------
PROCEDURE CP_vneb (DK_       IN     oper.dk%type,
                   KV_       IN     accounts.kv%type,
                   nNBS_     IN     cp_vidd.vidd%type,
                   nRYN_     IN     cp_accc.ryn%type,
                   EMI_      IN     cp_vidd.emi%type,
                   p_SN_     IN     NUMBER,            -- номинал сделки в коп
                   p_SA_     IN     NUMBER,            -- сумма  сделки  в коп
                   CP_ID_    IN     cp_kod.cp_id%type,
                   DAT_UG    IN     DATE,
                   DAT_OPL   IN     DATE,
                   DAT_ROZ   IN     DATE,
                   DAT_KOM   IN     DATE,
                   NAZN_     IN     oper.nazn%type,
                   REF_      IN     oper.ref%type,
                   NLS9      IN     accounts.nls%type, -- счет резерва
                   sREF      IN OUT VARCHAR2,
                   sErr         OUT VARCHAR2)
IS
 title constant varchar2(12) := 'CP.CP_vneb:';
 NLS9_      accounts.nls%type;
 NMS9_      accounts.nms%type;
 OKPO_      customer.okpo%type;
 NLSG_      accounts.nls%type;
 NMS_       accounts.nms%type;
 NAZN1_     oper.nazn%type;
 REF1_      oper.ref%type;
 FXN_       tts.tt%type := 'FXN';
 VOB_NB_    oper.vob%type := 6;

 SN_        number;  -- номинал сделки в коп
 SA_        number;  -- сумма  сделки  в коп

BEGIN
 bars_audit.trace('%s Start with params: (DK_;nNBS_;nRYN_;NLS9;EMI_) = (%s), p_SN_ = %s, p_SA_ = %s, CP_ID_ = %s',
                    title,
                    to_char(DK_)||';'||nNBS_||';'||nRYN_||';'||NLS9||';'||EMI_,
                    to_char(p_SN_),
                    to_char(p_SA_),
                    to_char(CP_ID_));

 If gl.AMFO in ('300001','321024','300205') then
    -- для стенда на БАРСЕ (БД RNBU) и для реального использования "глупостей" в НБУ
    SN_ := p_SA_;  -- ТОЖЕ СУММА сделки в коп !!
    SA_ := p_SA_;  --      сумма сделки в коп
 else
    SN_ := p_SN_;  -- номинал сделки в коп
    SA_ := p_SA_;  -- сумма  сделки  в коп
 end if;
 bars_audit.trace('%s SN_ = %s, SA_ = %s', title, to_char(SN_), to_char(SA_));

 BEGIN
   select substr(p.val,1,3)
     into FXN_
     from params p,
          cp_vidd v
    where v.vidd = nNBS_
      and v.emi = EMI_
      and p.par = 'FXN-'|| v.tipd || decode (kv_, gl.baseval, '-0','-1');
 EXCEPTION WHEN NO_DATA_FOUND
           THEN FXN_ := 'FXN';
 END;
 bars_audit.trace('%s FXN_ = %s', title, to_char(FXN_));

 BEGIN
    SELECT a.nls, SUBSTR (a.nms, 1, 38), c.okpo
      INTO NLS9_, NMS9_, OKPO_
      FROM accounts a,
           cust_acc u,
           customer c,
           tts t
     WHERE     a.kv = KV_
           AND a.nls = t.nlsk
           AND a.acc = u.acc
           AND u.rnk = c.rnk
           AND t.tt = FXN_;
 EXCEPTION WHEN NO_DATA_FOUND
           THEN sERR := '42.Нет внеб-контр.сч. в ФУ в карточке оп.'||FXN_;
                bars_audit.trace('%s Err = %s', title, to_char(sERR));
                RETURN;
 END;
 bars_audit.trace('%s NLS9_ = %s, NMS9_ = %s, OKPO_ = %s', title, NLS9_, NMS9_, OKPO_);

  if DAT_UG < DAT_ROZ
  THEN
     -- внебаланс-1,3. Отображаем номинал пакета SN_,  т.к.это ожидаемые ЦБ
    bars_audit.trace('%s DAT_UG < DAT_ROZ отoбражаем номинал пакета SN_,  т.к.это ожидаемые ЦБ', title);
    BEGIN
       SELECT SUBSTR (cp_id_ || '/' || a.nms, 1, 38),
              a.nls,
              DECODE (DK_, 1, sVNEB3, sVNEB1)
         INTO NMS_, NLSG_, NAZN1_
         FROM accounts a, cp_accc p
        WHERE     a.nls = DECODE (DK_, 1, p.nlsN3, p.nlsN1)
              AND a.kv = KV_
              AND p.vidd = nNBS_
              AND p.ryn = nRYN_
              AND p.emi = EMI_;
    EXCEPTION
       WHEN NO_DATA_FOUND
       THEN sERR := '43.Нет внеб-1,3 сч. в ФУ';
            bars_audit.trace('%s DAT_UG < DAT_ROZ err = %s', title, sERR);
            RETURN;
    END;
    bars_audit.trace('%s NMS_ = %s, NLSG_ = %s, NAZN1 _= %s', title, NMS_, NLSG_, NAZN1_);
    -- открытие внеб
    GL.REF (REF1_);

    If gl.baseval = 980 and DAT_UG < gl.bdate
     then VOB_NB_ := 96;
     else VOB_NB_ := 6;
    end if;
    bars_audit.trace('%s открытие внеб REF1_ = %s, VOB_NB_ = %s', title, to_char(REF1_), to_char(VOB_NB_));

    INSERT INTO oper (ref,  tt,     vob,    nd,     dk,     PDAT,    VDAT,   DATD,      DATP,   nam_a,  nlsa,   mfoa,    kv,    s,  nam_b,  nlsb,   mfob,   kv2, s2, nazn,  userid,  sign,        ID_A,  ID_B)
         VALUES      (ref1_,FXN_,   VOB_NB_,ref_,   1-DK_,  sysdate, DAT_UG, gl.bdate,  DAT_UG, NMS_ ,  NLSG_,  gl.AMFO, KV_,   SN_,NMS9_,  NLS9_,  gl.AMFO,KV_, SN_,NAZN_, USER_ID, GetAutoSign, OKPO_, OKPO_);

    PAYtt(0,    ref1_,  DAT_UG, FXN_,   1-DK_,
          kv_,  nlsG_,  SN_,
          kv_,  nls9_,  SN_ );

    UPDATE opldok
       SET txt = NAZN1_
     WHERE REF = REF1_
       AND stmt = gl.ASTMT;

     F_REF(Ref1_, sREF, sREF);
     begin
        insert into cp_payments(cp_ref, op_ref)
        values (REF_, REF1_);
     exception when others then null;
     end;

     -- Закр внеб
     GL.REF (REF1_);
     bars_audit.trace('%s закрытие внеб REF1_ = %s, VOB_NB_ = %s', title, to_char(REF1_), to_char(VOB_NB_));

     INSERT INTO oper (ref,  tt,     vob,   nd,     dk,    PDAT,    VDAT,    DATD,      DATP,   nam_a,  nlsa,   mfoa,    kv,    s,  nam_b,  nlsb,   mfob,    kv2, s2, nazn,  userid,  sign,        ID_A,  ID_B)
          VALUES      (ref1_,FXN_,   6,     ref_,   DK_,   sysdate, DAT_ROZ, DAT_ROZ,   DAT_UG, NMS_ ,  NLSG_,  gl.AMFO, KV_,   SN_,NMS9_,  NLS9_,  gl.AMFO, KV_, SN_,NAZN_, USER_ID, GetAutoSign, OKPO_, OKPO_);

     PAYtt(0,   ref1_,  DAT_ROZ, FXN_,   DK_,
           kv_, nlsG_,  SN_,
           kv_, nls9_,  SN_ );

    UPDATE opldok
       SET txt = NAZN1_
     WHERE REF = REF1_
       AND stmt = gl.ASTMT;

     F_REF(Ref1_, sREF, sREF);
     begin
        insert into cp_payments(cp_ref, op_ref)
        values (REF_, REF1_);
     exception when others then null;
     end;
  end if;

  if DAT_UG < DAT_OPL
  then     -- внебаланс-2,4 Отображаем стоимость пакета SA_, т.к.это ожидаемые деньги
  bars_audit.trace('%s DAT_UG < DAT_OPLОтображаем стоимость пакета SA_, т.к.это ожидаемые деньги', title);
     begin
        SELECT SUBSTR (cp_id_ || '/' || a.nms, 1, 38),
               a.nls,
               DECODE (DK_, 1, sVNEB4, sVNEB2)
          INTO NMS_, NLSG_, NAZN1_
          FROM accounts a, cp_accc p
         WHERE     a.nls = DECODE (DK_, 1, p.nlsN4, p.nlsN2)
               AND a.kv = KV_
               AND p.vidd = nNBS_
               AND p.ryn = nRYN_
               AND p.emi = EMI_;
     EXCEPTION WHEN NO_DATA_FOUND
               THEN sERR:='44.Нет внеб-2,4 сч. в ФУ';
                    bars_audit.trace('%s DAT_UG < DAT_ROZ err = %s', title, sERR);
                    RETURN;
     END;
     bars_audit.trace('%s NMS_ = %s, NLSG_ = %s, NAZN1 _= %s', title, NMS_, NLSG_, NAZN1_);
     -- Отк внеб
     GL.REF (REF1_);

     If gl.baseval = 980 and DAT_UG < gl.bdate
      then VOB_NB_ := 96;
      else VOB_NB_ := 6;
     end if;
     bars_audit.trace('%s открытие внеб REF1_ = %s, VOB_NB_ = %s', title, to_char(REF1_), to_char(VOB_NB_));

     INSERT INTO oper (ref,  tt,    vob,    nd,     dk,    PDAT,    VDAT,   DATD,      DATP,   nam_a,   nlsa,   mfoa,    kv,    s,  nam_b,  nlsb,   mfob,    kv2, s2, nazn,  userid,  sign,        ID_A,  ID_B)
          VALUES      (ref1_,FXN_,  VOB_NB_,ref_,   DK_,   sysdate, DAT_UG, gl.bdate,  DAT_UG, NMS_,    NLSG_,  gl.AMFO, KV_,   SA_,NMS9_,  NLS9_,  gl.AMFO, KV_, SA_,NAZN_, USER_ID, GetAutoSign, OKPO_, OKPO_);

     PAYtt(0,   REF1_,  DAT_UG, FXN_,   DK_,
           kv_, nlsG_,  SA_,
           kv_, nls9_,  SA_);

    UPDATE opldok
       SET txt = NAZN1_
     WHERE REF = REF1_
       AND stmt = gl.ASTMT;

     F_REF( REF1_, sREF, sREF );
     begin
        insert into cp_payments(cp_ref, op_ref)
        values (REF_, REF1_);
     exception when others then null;
     end;

     -- Закр внеб
     GL.REF (REF1_);
     bars_audit.trace('%s закрытие внеб REF1_ = %s, VOB_NB_ = %s', title, to_char(REF1_), to_char(VOB_NB_));
     INSERT INTO oper (ref,  tt,    vob,nd,     dk,    PDAT,    VDAT,   DATD,      DATP,   nam_a,   nlsa,   mfoa,    kv,    s,  nam_b,  nlsb,   mfob,    kv2, s2, nazn,  userid,  sign,        ID_A,  ID_B)
          VALUES      (ref1_,FXN_,  6,  ref_,   1-DK_, sysdate, DAT_OPL,DAT_OPL,   DAT_UG, NMS_,    NLSG_,  gl.AMFO, KV_,   SA_,NMS9_,  NLS9_,  gl.AMFO, KV_, SA_,NAZN_, USER_ID, GetAutoSign, OKPO_, OKPO_);

     PAYtt(0,   REF1_,  DAT_OPL, FXN_,   1-DK_,
           kv_, nlsG_,  SA_,
           kv_, nls9_,  SA_);

    UPDATE opldok
       SET txt = NAZN1_
     WHERE REF = REF1_
       AND stmt = gl.ASTMT;

    F_REF( REF1_, sREF, sREF );
     begin
        insert into cp_payments(cp_ref, op_ref)
        values (REF_, REF1_);
     exception when others then null;
     end;
  end if;
  bars_audit.trace('%s Финиш', title);
end CP_VNEB;
---------------------------------------------------------------------------
/*PROCEDURE rez_pay - ??? */
---------------------------------------------------------------------------
PROCEDURE rez_pay (dat_ IN DATE)
IS
   userid_   NUMBER;
BEGIN
   NULL;
END;

----------------------------------------------------------------------------
/* PROCEDURE chek_dubl_cp_id (p_DAT DATE)*/
   -- перевірка дублів по CP_ID (ISIN-код ЦП)
   -- inga 2015-09-10 где это вообще может использоваться? по БД этого не найдено,
   -- к тому же существует UNIQUE INDEX XAK_CP_ID_CP_KOD ON CP_KOD (CP_ID, DAT_EM)
----------------------------------------------------------------------------
PROCEDURE chek_dubl_cp_id (p_DAT DATE)
IS

   l_id       INT;
   l_ret      VARCHAR2 (400) := 'Старт chek_dubl_cp_id';
   l_dat_EM   cp_kod.dat_em%TYPE;
BEGIN
   l_trace := 'CP: ';
   LOG (l_ret, 'INFO');

   FOR d IN (SELECT id, dat_em, cp_id
               FROM cp_kod
              WHERE cp_id IN (  SELECT cp_id
                                  FROM cp_kod
                              GROUP BY cp_id
                                HAVING COUNT (*) > 1))
   LOOP
      BEGIN
         l_ret :=
               'Перевірити на дубль ЦП '
            || d.cp_id
            || ' ID='
            || d.id
            || ' дата емісії='
            || d.dat_em;
         LOG (l_ret, 'INFO');
      END;
   END LOOP;
END;
----------------------------------------------------------------------------
PROCEDURE awry_period (p_id       IN     cp_kod.id%TYPE,
                       p_npp         OUT cp_dat.npp%TYPE,   -- номер текущего купонного периода
                       p_normal      OUT INT,               -- количество дней в НОРМАЛЬНОМ купонном периоде
                       p_awry        OUT INT,               -- признак наличия укороченного купонного периода
                       p_awry_first  OUT INT,               -- количество дней в укороченном первом купонном периоде
                       p_awry_last   OUT INT)               -- количество дней в укороченном последнем купонном периоде
/*процедура озвращает номер текущего купонного периода
  определяет, является ли купонный период сокращенным по отношению к другим периодам проспекта эмиссии бумаги
  возвращает количество дней нормального купонного периода
  возвращает количество дней укороченного купонного периода
  действительна для первого и последнего купонных периодов
  от результата выполнения зависит возникновение счета "кривого купона" в cp_accounts R3 (cp_acctypes)
*/
is
 l_title           constant varchar2(20) := 'cp.is_awry_period:';
 l_result                   int := 0;
 l_periodcount              int;
 l_days_normal_period       int;
 l_days_awry_period_first   int;
 l_days_awry_period_last    int;

 l_cp_kod_row           cp_kod%rowtype;
 l_cpdat_row            cp_dat%rowtype;
 type t_cpdat_set is table of cp_dat%rowtype;
 l_cpdat_set t_cpdat_set := t_cpdat_set();
begin

 begin
  select *
    into l_cp_kod_row
    from cp_kod
   where id = p_id;
 exception when no_data_found
           then bars_audit.trace('%s Не найдено кода ЦП %s', l_title, to_char(p_id));
                l_result := 0;
 end;

 begin
   select min(npp)
    into p_npp
    from cp_dat
   where id = p_id and dok >= bankdate;
 exception when no_data_found
           then bars_audit.trace('%s Не найден график проспекта эмиссии для кода ЦП %s', l_title, to_char(p_id));
                l_result := 0;
                l_periodcount := 0;
 end;
 bars_audit.trace(l_title||'Номер текущего купонного периода = '|| to_char(p_npp));

 begin
   select count(*)
    into l_periodcount
    from cp_dat
   where id = p_id and dok >= bankdate;
 exception when no_data_found
           then bars_audit.trace('%s Не найден график проспекта эмиссии для кода ЦП %s', l_title, to_char(p_id));
                l_result := 0;
                l_periodcount := 0;
 end;

 if l_periodcount > 2
 then
     l_cpdat_set.extend(l_periodcount);

     select *
     bulk collect
       into l_cpdat_set
       from cp_dat
     where id = p_id;
   bars_audit.trace(l_title ||'1) p_id='||to_char(p_id)||',l_periodcount='||to_char(1)|| ',l_cpdat_set('||to_char(1)||').DOK = '||to_char(l_cpdat_set(1).DOK,'dd/mm/yyyy')||',KUP='||l_cpdat_set(1).KUP);
   bars_audit.trace(l_title ||'2) p_id='||to_char(p_id)||',l_periodcount='||to_char(l_periodcount)|| ',l_cpdat_set('||to_char(l_periodcount)||').DOK = '||to_char(l_cpdat_set(l_periodcount).DOK,'dd/mm/yyyy')||',KUP='||l_cpdat_set(l_periodcount).KUP);
   bars_audit.trace(l_title ||'3) p_id='||to_char(p_id)||',NPP='||to_char(l_cpdat_set(1).NPP));
   l_days_normal_period       := l_cpdat_set(3).DOK - l_cpdat_set(2).DOK;

   bars_audit.trace(l_title ||'4) p_id='||to_char(p_id)||',l_days_normal_period='||to_char(to_char(l_days_normal_period)));
   bars_audit.trace(l_title ||'4a'||to_char(l_cpdat_set(1).NPP-1)||','||to_char(l_cpdat_set(1).dok));
   if l_cpdat_set(1).NPP-1 <= 1 and l_cpdat_set(1).dok > bankdate
   then l_days_awry_period_first   := l_cpdat_set(1).DOK - l_cp_kod_row.DAT_EM;
   else l_days_awry_period_first   := null;
   end if;
   bars_audit.trace(l_title ||'5) p_id='||to_char(p_id)||',l_days_awry_period_first='||to_char(to_char(l_days_awry_period_first)));

   l_days_awry_period_last   := l_cpdat_set(l_periodcount).DOK - l_cpdat_set(l_periodcount-1).DOK;
   bars_audit.trace(l_title ||'6) p_id='||to_char(p_id)||',l_days_awry_period_last='||to_char(to_char(l_days_awry_period_last)));


    if   (    l_days_awry_period_first is not null
          and l_days_awry_period_first < l_days_normal_period
          and l_cpdat_set(1).KUP = l_cpdat_set(2).KUP -- если купон в графике уменьшен, то количество дней укороченного купонного периода считается нормальным
         )
      or l_days_awry_period_last < l_days_normal_period
    then p_awry := 1;                                -- признак укороченного периода
         p_awry_first := l_days_awry_period_first;   -- количество дней возвращаем укороченное
         p_awry_last  := l_days_awry_period_last;    -- количество дней возвращаем укороченное
         p_normal     := l_days_normal_period;       -- количество дней возвращаем нормального периода (2го и следующих)
    else p_awry := 0;                                -- признак не укороченного периода (нормального)
         p_awry_first := l_days_normal_period;       -- количество дней возвращаем нормальное
         p_awry_last  := l_days_normal_period;       -- количество дней возвращаем нормальное
         p_normal     := l_days_awry_period_first;   -- если купон в графике уменьшен, то количество дней укороченного купонного периода считается нормальным
                                                     -- количество дней возвращаем реального первого периода
    end if;

 end if;

 l_cpdat_set.delete;

end awry_period;
----------------------------------------------------------------------------
procedure LOG(p_info char, p_lev char default 'TRACE', p_reg int default 0) is
begin
  if l_mon = '1' then MON_U.to_log(p_reg,p_lev,l_mdl,l_trace||p_info);
  elsif p_reg = 5 then logger.info(p_info);
  else
    BEGIN
       case when p_lev = 'ERROR' then     logger.error(p_info);
            when p_lev = 'INFO'  then NULL;                     --   logger.info(p_info);
            when p_lev = 'TRACE' then NULL;                     --   logger.trace(p_info);
            NULL;
       end case;
    end;
   end if;
end log;

-------------------------------------------------------------------------------------------
procedure CP_POG_NOM2 (p_Z int, p_Id number, p_NOM100 number) is     -- 02.08.2017 Sta частичное (или полное) погашения номинала
  ckod cp_kod%rowtype;   oo oper%rowtype;           l_id number; l_nom100 number; l_kol   int ;
begin
  l_id     :=       NVL ( p_id,     to_number (pul.GEt('CP_ID' )) ) ;
  l_nom100 := NVL ( NVL ( p_NOM100, to_number (pul.GEt('CP_NOM')) ) , 0 ) ;

  If l_nom100 <= 0 then  raise_application_error(-20333,  '\ Відсутня сума погашення номіналу, код ЦП id=' || l_ID );  end if ;

  begin select * into ckod from cp_kod where id = l_id;
  EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20333,  '\ НЕ знайдено код ЦП id=' || l_ID );
  end ;

  If p_Z = 0 then oo.vob := 96; oo.vdat := cp.F_VDAT_ZO( add_MONTHS( gl.bdate , -1 ) );
  else            oo.vob :=  6; oo.vdat := gl.bdate;
  end if ;

  begin select substr(val,1,3) into oo.tt from params where par='FXB-1-'||decode(ckod.kv, gl.baseval,'0','1') ;
  EXCEPTION WHEN NO_DATA_FOUND THEN oo.tt := 'FXB';
  end ;

  If ckod.name is null then
     begin select substr(nmk,1,70) into ckod.name from customer where rnk = ckod.rnk;
     EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20333,  '\ НЕ визначено емітента, код ЦП id=' || l_ID );
     end ;
  end if;

  For k in (select pp.*,    CASE  WHEN pp.OSTC <> pp.OSTB  THEN 'план.зал НОМ НЕ=факт.зал'
                                  WHEN pp.OSTR <> 0        THEN 'зал купона НЕ=0'
                                  WHEN pp.NLSG is null     THEN 'Відсут.сист.рах.номиналу'
                                  ELSE                           NULL
                                  END   ERR
            from ( select (select -nvl(sum(ostb),0) from accounts where acc in (d.accR,d.accR2)) OSTR,
                          (select nls from accounts where acc = a.accc)                          NLSG,
                          (select substr(nms,1,38) from accounts where acc = a.accc)             NMSG,
                          d.REF, a.acc, a.NLS, -a.OSTC ostc, -a.OSTB ostb,  o.ND, o.DATD
                  from cp_deal d, accounts a, oper o
                  where d.id = l_id AND d.acc=a.acc and d.ref = o.ref (+) and d.DAZS is null  and a.ostc<0
                 ) pp
            )
  loop
      If k.ERR is not null then  raise_application_error(-20333,  '\ Угода реф ='|| k.REF||' Помилка:'|| k.ERR );  end if ;
      l_kol := div0( k.OSTC/100, ckod.CENA) ;
      oo.S  :=   l_NOM100 * l_kol;
      If  NVL(oo.s,0) <=0 or oo.s > k.ostc  then  raise_application_error(-20333,  '\ Угода реф ='|| k.REF||' Помилка: сума номіналу ='|| oo.s );  end if ;

      If oo.S = k.OSTC then  oo.nazn := 'Повне';
      else                   oo.nazn := 'Часткове';
      end if;
      oo.dk   := 0;
      oo.kv   := ckod.KV ;
      oo.nazn := Substr(oo.nazn||' погашення емiтентом '||ckod.name ||' '||ckod.cp_id||' ном.'||l_KOL||' шт. '||'Дог.№'||k.ND||' вiд '|| to_char(k.DATD,'dd.MM.yyyy'), 1, 160 );

      If oo.nlsb is null then
         begin select ab.nls, substr(ab.nms,1,38) into oo.nlsb, oo.nam_b
               from accounts ab, opldok oa, opldok ob
               where oa.ref = k.REF and  ob.ref = oa.ref and oa.stmt= ob.stmt and oa.acc= k.acc and oa.dk = 0 and ob.dk = 1 and ab.acc = ob.acc;
         EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20333,  '\ НЕ визначено Контр.рах' );
         end ;
      end if ;

      gl.ref (oo.REF);
      oo.nd := trim (Substr( '          '||to_char(oo.ref) , -10 ) ) ;
      gl.in_doc3 (ref_=>oo.REF,   tt_  =>oo.tt  , vob_=>oo.vob , nd_  =>oo.nd   ,pdat_=>SYSDATE, vdat_=>oo.vdat,  dk_ => oo.dk,
                  kv_ =>oo.kv ,   s_   =>oo.S   , kv2_=>oo.kv  , s2_  =>oo.S    ,sk_  => null  , data_=>gl.BDATE, datp_=>gl.bdate,
                nam_a_=>k.nmsG,  nlsa_ =>k.nlsG ,mfoa_=>gl.aMfo,
                nam_b_=>oo.nam_b, nlsb_=>oo.nlsb,mfob_=>gl.aMfo,
                 nazn_=>oo.nazn ,d_rec_=>null   ,id_a_=>gl.aOkpo,id_b_=>gl.aOkpo,id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
      gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, k.nls, oo.s, oo.kv,  oo.nlsb, oo.s);
      INSERT into CP_ARCH (REF_MAIN,    REF,   ID, DAT_UG  , DAT_OPL, DAT_ROZ, SUMB,   N, OP, d, p, r, s, vd, vp, t, tq) values
                             (k.ref, oo.Ref, l_ID, gl.bdate,gl.bdate,gl.bdate, oo.s,oo.S, 22, 0, 0, 0, 0,  0,  0, 0,  0);
  end loop; --k
end CP_POG_NOM2;


  -- Сумирует общее количество Ценных бумаг по Контрагентам в рамках Пакета
  -- Для формы ЦП (14*)
  function get_from_cp_zal_kolz(p_ref number, p_dat date) return number is
-- v.1.0 12.12.2017
-- актуальне значення(сума по всім контрагентам) пар-ра на дату
    l_kolz number := null;

  begin

    select sum(kolz) into l_kolz
    from cp_zal where ref = p_ref
                  and p_dat between datz_from and datz_to;

    return l_kolz;

  end;

  function get_from_cp_zal_dat(p_ref number, p_dat date) return date is
-- v.1.0 від 12/12-17
-- актуальне значення DAT2 (по мотивам застарілої f_get_from_accountspv_dat2)

    l_dat cp_zal.datz_to%type:= null;

  begin

    begin
      select max(dat) into l_dat
        from (select rnk, min(datz_to) dat
              from cp_zal where ref = p_ref
               and datz_to >= p_dat
               and nvl(kolz, 0) > 0
              group by rnk
              );
      exception
        when no_data_found then null;
    end;

    return l_dat;

  end;

  --Процедура на БМД ЦП (14) - редагування заставної інформації в розрізі контрагентів
  procedure cp_zal_change(p_ref          cp_zal.ref%type,
                          p_rnk          cp_zal.rnk%type,
                          p_id_cp_zal    cp_zal.id_cp_zal%type,
                          p_id           cp_zal.id%type,
                          p_kol_zal      cp_zal.kolz%type,
                          p_zal_from     cp_zal.datz_from%type,
                          p_zal_to       cp_zal.datz_to%type,
                          p_mode         int) --1 - add, 2 - upd, 3 - del
  is
    l_ref    cp_zal.ref%type   := nvl(p_ref,      PUL.get('CP_ref'));
    l_id     cp_zal.id%type    := nvl(p_id,       PUL.get('CP_id'));

    l_zal_from    cp_zal.datz_from%type  := p_zal_from;
    l_zal_to      cp_zal.datz_to%type    := p_zal_to;

    l_dat         date;
    l_id_cp_zal   cp_zal.id_cp_zal%type;
  begin
    if p_rnk is null then
--      bars_error.raise_nerror(G_MODULE, 'NOT_CORRECT_PAYTYPE', 'ТЕСТ');
      raise_application_error(-20001,  'Вкажіть RNK контрагента ' );
    end if;
    if p_zal_from is null then
      raise_application_error(-20001,  'Вкажіть дату Дії з ' );
    end if;
    if p_zal_to is null then
      raise_application_error(-20001,  'Вкажіть дату Дії по ' );
    end if;
    if p_zal_to < p_zal_from then
      raise_application_error(-20001,  'Дата Дії по повинна бути більша або ж така за дату Дії з' );
    end if;

    case  p_mode
      when 1 then
        select min(datz_to)
        into l_dat
        from cp_zal
        where ref = p_ref and rnk = p_rnk and datz_from > p_zal_from and datz_to < p_zal_to;--якщо пересікаються періоди

        if l_dat >= l_zal_from then --підкоректувати дату _діє до_  першого періоду куди потрапляє дата _дії з_ нового запису
--          raise_application_error(-20001,  'l_dat='||l_dat||' l_zal_from='||l_zal_from );
          update cp_zal
           set   datz_to   = p_zal_from - 1
          where ref = p_ref and rnk = p_rnk and datz_from > p_zal_from and datz_to = l_dat;
        end if;

        insert into cp_zal(ref, id, kolz, datz_from, rnk, datz_to)
        values (l_ref, l_id, p_kol_zal, l_zal_from, p_rnk, l_zal_to);
      when 2 then
        update cp_zal
           set kolz      =  p_kol_zal,
               datz_from = l_zal_from,
               datz_to   = l_zal_to,
               rnk       = p_rnk
         where id_cp_zal = p_id_cp_zal;
      when 3 then
        delete from cp_zal where id_cp_zal = p_id_cp_zal;
    end case;


    -- приводить періоди дій в розрізі rnk в непротерічність
    for c in ( select id_cp_zal,
                      nvl(lead(datz_from, 1) over (order by datz_from),
                          (select max(datz_to) from cp_zal
                            where ref = p_ref and (rnk = p_rnk or (rnk is null and p_rnk is null))) + 1) as datz_to
                 from cp_zal
                where ref = p_ref and (rnk = p_rnk or (rnk is null and p_rnk is null)) )
    loop
       update cp_zal set datz_to = c.datz_to-1 where id_cp_zal = c.id_cp_zal
                                                 and datz_to != c.datz_to-1; --немає смислу змінювати на туж дату;
    end loop;

    exception
      when others then
        if sqlcode = -1  and sqlerrm like '%IND_U_CP_ZAL_DF%' then
            raise_application_error(-20001,  'Вкажіть іншу дату Діє з. Існує вже запис для rnk= '||p_rnk||', Діє з='||p_zal_from);
          else
            raise;
        end if;
  end;


--------------------------------------
BEGIN /* анонимный блок */

/* глоб.переменные:
   CP_PAY_   char(1):='0'; --1) 0=Конс-сист., Угоди-несист, 1=Конс-несист., Угоди-сист
   CP_AMORT_ char(1):='0'; --2) 0=ТП Амотр всегда, 1=ТП не аморт
                           --3) Переоцiнка
   CP_RT_    char(1):='0'; --3.1) 0=Сумма переоц не вкл в торг.рез., 1= вкл
   CP_CUR_   char(1):='0'; --3.2) 0=Переоц через разницу, 1= с полным откатом
   CP_RATES_ char(1):='0'; --3.3) 0=по чистiй цiнi, 1=грязнi цiнi
   CP_R_KUP_ char(1):='0'; --3.3.1) 0=купон за gl.BDATE, 1=купон за DAT_
   CP_R_R2_  char(1):='0'; -- Способ деления купона при продаже чужих ЦБ
*/

     l_mdl  :=  'CP';
     l_lev  :=  'TRACE';
     l_reg  :=  0;
     l_trace:=  'CP: ';

     BEGIN /* 1) 0=Конс-сист., Угоди-несист, 1=Конс-несист., Угоди-сист */
       select '1'
         into CP_PAY_
         from params
        where par = 'CP_PAY'
          and val = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN CP_PAY_ := null;
     END;

     BEGIN /* 2) 0=ТП Амотр всегда, 1=ТП не аморт */
       select '1'
         into CP_AMORT_
         from params
        where par = 'CP_AMORT'
          and SUBSTR(val, 1, 1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN CP_AMORT_ := '0';
     END;

     BEGIN /* 3.1) 0=Сумма переоц не вкл в торг.рез., 1= вкл */
       --ЦП: 0= Сумма переоценки не включается в торг результат,
       --       а идет на тот же счет, откуда породилась ( по новой методике в КБ)
       --    1= Идет на торг.результат (как было раньше)
       --    В НБУ и НБГ(?) вставить этот параметр
       select '1'
         into CP_RT_
         from params
        where par = 'CP_RT'
          and SUBSTR(val,1,1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN CP_RT_ := '0';
     END;

     BEGIN /* 3.2) 0=Переоц через разницу, 1= с полным откатом */
       select '1'
         into CP_CUR_
         from params
        where par = 'CP_CUR'
          and val = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN CP_CUR_ := '0';
     END;

     BEGIN /* 3.3) 0=по чистiй цiнi, 1=грязнi цiнi */
       select '1'
         into CP_RATES_
         from params
        where par = 'CP_RATES'
          and SUBSTR(val, 1, 1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN CP_RATES_ := '0';
     END;

     BEGIN /* 3.3.1) 0=купон за gl.BDATE, 1=купон за DAT_ */
       select '1'
         into CP_R_KUP_
         from params
        where par = 'CP_R_KUP'
          and SUBSTR(val, 1, 1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN CP_R_KUP_ := '0';
     END;

     begin /* Способ деления купона при продаже чужих ЦБ  */
       select '1'
         into CP_R_R2_
         from params
        where par = 'CP_R_R2'
          and SUBSTR(val, 1, 1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN CP_R_R2_ := '0';
     end;

     BEGIN /* Ознака НБУ чи КБ  */
       select '1'
         into NBUBNK_
         from params
        where par = 'NBUBANK'
          and SUBSTR(val, 1, 1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN NBUBNK_ := '0';
     END;

     BEGIN /* наявність пакета  MONITOR_USER  */
        SELECT '1'
          INTO l_mon
          FROM params
         WHERE par = 'MON_USER'
           AND SUBSTR (val, 1, 1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN l_mon := '0';
     END;

     BEGIN
        SELECT NVL (mfou, mfo)
          INTO l_mfou
          FROM banks
         WHERE mfo = gl.amfo;
     EXCEPTION WHEN NO_DATA_FOUND
               THEN l_mfou := '0';
     END;

     BEGIN
        SELECT '1'          --ЦП: Переміщення. 1=потоки переносимо
          INTO l_CP_MVRAT
          FROM params
         WHERE par = 'CP_MV_RAT'
           AND SUBSTR (val, 1, 1) = '1';
     EXCEPTION WHEN NO_DATA_FOUND
               THEN l_CP_MVRAT := '0';
     END;

     BEGIN
        SELECT '1'                        -- ЦП: (работа через 1 транзитный счет, либо по Дт Кт задолженности Постанова 400)
          INTO l_CP_TRANS_DK
          FROM params
         WHERE par = 'CP_TRANS_DK'
           AND SUBSTR (val, 1, 1) = '1';  -- через ДК задолженность
     EXCEPTION WHEN NO_DATA_FOUND
               THEN l_CP_TRANS_DK := '0'; -- через транзитный
     END;

     BEGIN
        SELECT '1'                        -- ЦП: Метод обліку: 0 - за датою операції, 1 - за датою розрахунку
          INTO l_CP_METOD
          FROM params
         WHERE par = 'CP_METOD'
           AND SUBSTR (val, 1, 1) = '1';  --  1 - за датою розрахунку
     EXCEPTION WHEN NO_DATA_FOUND
               THEN l_CP_METOD := '0';    --  0 - за датою операції
     END;
   IF LENGTH(gl.aMFO) > 6 THEN
      --неукраинские
      sNOMINAL:= 'Номин.стоимость';
      sNOMINAL_exp:= 'Номин.простр.';
      sDISKONT:= 'Дисконт';
      sPREMIA := 'Премия';
      sKUPON  := 'Начис.проценты';
      sKUPON2 := 'Накоп.проценты';
      sKUPON3 := 'Накоп.проценты (R3)';
      sKUPONo := 'Полученный купон';
      sKUPON9 := 'Простр.купон';
      sZABORK := 'Кредит.задолж.';
      sZABORD := 'Дебет. задолж.';
      sPEREOP := 'Полож.рез.переоценки';
      sPEREOV := 'Отрицат.рез.переоценки';
      sTORGP  := 'Полож.торг.результат';
      sTORGV  := 'Отрицат.торг.результат';
      sKOMIS  := 'Комис.расходы';
      sKOMISA := 'Амopт.комис.расходы';
      sKOMISN := 'Неамopт.комис.расходы';
      sKOMISK := 'Кредит.задолж.(комис.расход)';
      sKOMISD := 'Дебет. задолж.(комис.расход)';
      sAMORT  := ' ';
      sSOBIVN := 'Неаморт.себестоимос.';
      sVNEB1  := 'ЦБ, купленные, не отправленные';
      sVNEB2  := 'Стоимость ЦБ до поставки';
      sVNEB3  := 'ЦБ, проданные, не отправленные';
      sVNEB4  := 'Стоимость ЦБ до получения';
   ELSE
      sNOMINAL:= 'Номiн.вартiсть';
      sNOMINAL_exp:= 'Номiн.простр.';
      sDISKONT:= 'Дисконт';
      sPREMIA := 'Премiя';
      sKUPON  := 'Нарах.вiдсотки';
      sKUPON2 := 'Накоп.вiдсотки';
      sKUPON3 := 'Накоп.вiдсотки (R3)';
      sKUPONo := 'Отриманий купон';
      sKUPON9 := 'Простр.купон';
      sZABORK := 'Кредит.заборг.';
      sZABORD := 'Дебет. заборг.';
      sPEREOP := 'Позит.рез.переоцiнки';
      sPEREOV := 'Вiд`ємн.рез.переоцiнки';
      sTORGP  := 'Позит.торг.результат';
      sTORGV  := 'Вiд`ємн.торг.результат';
      sKOMIS  := 'Комiс.витрати';
      sKOMISA := 'Амopт.комiс.витрати';
      sKOMISN := 'Неамopт.комiс.витрати';
      sKOMISK := 'Кредит.заборг.з комiс.витрат';
      sKOMISD := 'Дебет.заборг.з комiс.витрат';
      sAMORT  := ' ';
      sSOBIVN := 'Неаморт.собiвартiсть';
      sVNEB1  := 'ЦП, що купленi, але не вiдправленi';
      sVNEB2  := 'Вартiсть ЦП до постачання';
      sVNEB3  := 'ЦП, що проданi, але не вiдправленi';
      sVNEB4  := 'Вартiсть ЦП до отримання';
   END IF;
END CP;
/

PROMPT *** Create  grants  CP ***
grant EXECUTE                                                                on CP              to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cp.sql =========*** End *** ========
 PROMPT ===================================================================================== 
