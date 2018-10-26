CREATE OR REPLACE PACKAGE ELT
IS

G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 39.4 від 28/12/2016';
G_AWK_HEADER_DEFS CONSTANT VARCHAR2(512) := '';

 -- Функции и процедуры для расчета абонплаты по электронным услугам
 -- В дальнейшем м.б. и сами услуги

 -- 28/12/16     OPN_ACNT, SET_TARIFF, DEL_TARIFF
 --  9/08-16     Уточнено верс_ю п_сля включення opl_web, borg_web.
 -- 20/01-16     Нова F_ELT_TAR_PAK
 -- 15/03-12 KDI Уточнено R013=1 для рах-в 3579
 --  1/03-12 KDI mode=7 пошук segm
 -- 29/02-12 KDI Виправив опечатку not null при погашенн_
 -- 20/02-12 KDI для mode=3 уточнив критер_й NLS_P = NLS36 - для блокування погашення
 -- 15/02-12 KDI Адаптац_я для Ощадбанку. Ф-_я  F_CH_GASH - зовн_шня
 -- 18/01-12 KDI Прибрав запис деяких пов_домлень в журнал АБС
 --  3/01-12 KDI П_дм_на рах-ку-платника в пр-р_ погашення 3579 (mode=8)
 -- 30/12-11 KDI Узгодження пар-в для виклику зовн_шньої функц_ї анал_зу
 --              документообороту для р_зних код_в тариф_в.
 --  6/12-11 KDI Анал_з наявност_ рах-ку NLS_P в пр-р_ погашення 3579
 -- 30/11-11 KDI F_ELT_RNK
 -- 18/11-11 KDI Можлив_сть додаткового анал_зу оборот_в по р-ку кл_єнта
 --              через зовн_шню функц_ю F_Elt_nadra (для кожного тарифу)
 -- 15/11-11 KDI Зм_ни стосовно визначення тарифу та рах-ку 6110
 --              Анал_з MFOP для НАДРА
 --  2/03-10 KDI Виправив синтаксис вставки запису в табл. Specparam_int
 --              (актуально т_льки для Ощадбанку)
 -- 05/11-09 KDI Вичитка глоб-го пар-ра MFOP - головний банк для ф_л_й.
 --              Визначення глобального та _ндив_дуальних рахунк_в ПДВ винесено
 --              в функц_ї зовн_шнього налаштування (в TNAZNF).
 --              Для Ощадбанку - залишився алгоритм в_д 02.04.09
 --              Зм_нив лог_ку по фрагментах специф_чних для Ощадбанку.
 --              Можна об_йтись без зм_нної препроцесора OSC
 -- 23/09-09 KDI Можлив_сть погашення абонплати (ДТ 26_0 - КР 3570) частинами
 --              по анал_зу глоб. пар-ра ELT_4
 -- 15/07-09 KDI Пр-ра ELT.BORG  для Mode 8. П_дправив визначення дати
 --              для включення правильного м_сяця в призначення платежу
 --              док-та на погашення простроченої абонплати
 -- 04.06.09 KDI Вв_в зм_нну препроцесора OSC для присвоєння OB22 по р-ку 3579.
 --              Ще раз уточнення для спецпар-_в р-ку 3579 - r013,s180,s240.
 -- 28.04.09 KDI Значение спецпар-ров для 3579 - r013,s180,s240.
 -- 10.04.09 KDI Исправил проверку наличия кода переданной в пр-ру операции.
 --              Урезал до 38 с. название счета 3579 при вставке в OPER.
 --              Добавил Logger.trace для пр-ры BORG mode 8
 -- 06.04.09 KDI Уточнил алгоритм для определения названия счета 3578/3579
 --              через ф-ию F_newnms
 -- 02.04.09 KDI Введена возможность выполнения внешней ф-ии для определения
 --              счета ПДВ. Выбор ф-ии по анализу глоб. пар-ра PDV_FUNC.
 --              Подправлен алгоритм вызова внешней ф-ии определения счета 6110.
 --              Дополнил Logger.info по отказу проводок в пр-ре BORG.
 -- 18.09.08 KDI Изменен алгоритм вычитки из карточки клиента
 --              допреквизита Y_ELT (автом. удержание абонплаты)
 --              Добавил Logger.Trace в "узкие" места и
 --              Logger.Info в критические точки для записи "следов"
 --              работы модуля в журнал событий
 -- 03.08.07 KDI Компоновка текста NAZN для разных проводок
 --              из пр-р ELT.opl, ELT.borg вынесена в табл.TNAZN
 --              Введен глоб.пар-р ELT_3  Если =1 погашение 26_0 -> 3570
 --              по каждой услуге, иначе - общей суммой
 --              Анализ значения Customerw.isp для tag='Y_ELT'
 -- 24.04.07 KDI Определение тарифа с учетом периода действия возможного
 --              индивидуального тарифа. Ф-ия TARIF
 -- 10.01.07 KDI Уточнение критериев порождения документов и уточнение в NAZN
 --              При работе со счетом абонплаты 3600 для формирования дохода
 --              на 6110 допол-ый контроль суммы сформированного аванса.
 --              Доп.контроль соотношения суммы абонплаты (ост-к 3570) и
 --              остатка на 26_0 для генерации проводки гашения (mode_=3).
 -- 27.09.2006 KDI Убрал слово <Стягнення> из назначения при формировании аванса.
 --                Актуально только для "СЕБ-БАНК"
 -- 25.07.2006 KDI Новая пр-ра BORG для работы в портфеле со счетами 3578/3579
 --                Альтернатива использования схем перекрытия 3579980
 --                и пр-ры переноса на прострочку ELT_3579
 -- 28.03.2006 Sta Динамически вычисляемый счет дох
 -- 03/11-05   *****  V.24 от 03/11-05  *****
 -- ! Убрал PRAGMA. Обязательно при использовании пакеджа GL c 25/10-05
 --   и изменил условие расчета S для "Столица" при mode_= 3 в пр-ре OPL

 aCOUNTRY number DEFAULT 804 ; n980_ int default gl.baseval;
 JAN1_ date := to_date('20040101','YYYYMMDD');

 ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(400);
 err_num number;  err_msg varchar2(80);

 FDAT1_ date; FDAT2_ date; FSUM_ number(20,2); FSPR_ varchar2(253);
 FWDAT_ date:= to_date('01012004','ddmmyyyy') ;
 FKOL_ int;
 fND_  int := -1;
 fid_  int := -1;
 fTmp_ int;
 FSPDV_ number(20,2);

 OKPO_ varchar2(14);
 FL_ int  ;  pNDS_ number;
 descrname_ varchar2(10);
 reg_g varchar2(1) := Nvl(GetGlobalOption('ELT_3'),'0');
 suf_  varchar2(10);    us_id_ int;
 N_Func_ varchar2(21);  F_CH_GASH varchar2(21);
 Variant_s varchar2(5); Variant_ number;
 nlsb_ varchar2(15);
 PDV_Func_ varchar2(21);
 l_elt4 varchar2(1) := Nvl(GetGlobalOption('ELT_4'),'0');
 fl_ndw varchar2(50) :='1';
 nm_f_ndw varchar2(10); int_sql varchar2(120);
 l_MFOP varchar2(9) := Nvl(GetGlobalOption('MFOP'),'0');
 l_MFO  varchar2(9) := Nvl(GetGlobalOption('MFO'),'0');
 G_PDV_sql TNAZNF.txt%TYPE;   G_PDV varchar2(15) :='36220';
 l_pdv varchar2(15):='36229';
 fl_l_pdv int :=0;
 l_ff varchar2(120);
 l_ndw varchar2(50):='1';
---=====================

-- header_version - возвращает версию заголовка пакета
function header_version return varchar2;

-- body_version - возвращает версию тела пакета
function body_version return varchar2;

--*************
FUNCTION  F_All (nd_ int, id_ int, sdate_ date, p_wdate_ date) RETURN number;
--PRAGMA RESTRICT_REFERENCES ( F_All, WNDS );
--общее по всем функциям
------------------------

FUNCTION  F_Dat1 (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN date ;
--PRAGMA RESTRICT_REFERENCES ( F_Dat1, WNDS );
--первая дата в закрытом периоде по услуге
-------------

FUNCTION  F_Dat2 (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN date ;
--PRAGMA RESTRICT_REFERENCES ( F_Dat2, WNDS );
--последняя дата в закрытом периоде по услуге
--------------

FUNCTION  F_Sum (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN number ;
--PRAGMA RESTRICT_REFERENCES ( F_Sum, WNDS );
--сумма за усл в закрытом периоде

FUNCTION  F_SumP (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN number ;
--PRAGMA RESTRICT_REFERENCES ( F_SumP, WNDS );
--сумма за усл в закрытом периоде

---==========================
--FUNCTION  F_Spr (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN varchar2 ;
--PRAGMA RESTRICT_REFERENCES ( F_Spr, WNDS );
----сумма прописью

---==========================
PROCEDURE AKT(id_ int, RNK_ int, p_WDATE_ date) ;
--формирование врем.таблицы для печати

---=================
FUNCTION  RAB_DNI ( DAT1_ date, DAT2_ date) RETURN NUMBER ;
--PRAGMA RESTRICT_REFERENCES ( RAB_DNI, WNDS );
--количество раб дней в периоде
------------

FUNCTION  RAB_DNI1 ( DAT1_ date, DAT2_ date, KOL_ int ) RETURN NUMBER ;
--PRAGMA RESTRICT_REFERENCES ( RAB_DNI1, WNDS );
--количество раб дней в известном периоде периоде
-----------

FUNCTION  ROZ_AV ( DAT1_ date,DAT2_ date,KOL_ int, ND_ INT) RETURN NUMBER ;
--PRAGMA RESTRICT_REFERENCES ( ROZ_AV, WNDS );
--розрахунковий аванс

FUNCTION  TARIF ( DAT1_ date, DAT2_ date, ND_ int, ID_ INT) RETURN NUMBER ;
--розрахунковий тариф
------------
FUNCTION F_ELT_RNK (p_NLS varchar2, p_KV int default 980, p_reg int default 0)
return varchar2;

FUNCTION  F_ELT_TAR_PAK (p_ND INT) RETURN NUMBER;
  -- тарифний пакет

procedure opl_web(p_mode  integer,
                  p_date  varchar2,
                  p_packet integer,
                  p_nls36 varchar2);

procedure borg_web(p_mode  integer,
                   p_date  varchar2,
                   p_packet integer,
                   p_nls36 varchar2);

-------------
PROCEDURE OPL
(MODE_ INT,
 TT_      char,
 REZ_     number,
 NLS_PDV_ varchar2,
 mes_     varchar2,
 DAT1_    date,
 DAT2_    date,
 KOL_     int,
 PAKET_   int,
 NLS36_   varchar2 ,
 sErr_ OUT varchar2 );
-- оплата
----------------------------
PROCEDURE BORG
(MODE_ INT,
 TT_      char,
 REZ_     number,
 NLS_PDV_ varchar2,
 mes_     varchar2,
 DAT1_    date,
 DAT2_    date,
 KOL_     int,
 PAKET_   int,
 NLS36_   varchar2 ,
 sErr_ OUT varchar2 );
-- оплата по ДТ-заборгованостi
----------------------------
PROCEDURE shnel
( DAT1_ date, DAT2_ date, KOL_ int, sErr_ OUT varchar2 );
-- для ускорения по населению в режиме "з розрах. авансом"
---------------

  --
  -- OPN_ACNT ( в_дкриття рахунку )
  --
  procedure OPN_ACNT
  ( p_nd        in     integer
  , p_acc2600   in     accounts.acc%type
  , p_nls3570   in     accounts.nls%type
  );

  --
  -- SET_TARIFF ( встановлення/зм_на параметр_в тарифу для дог. РКО )
  --
  procedure SET_TARIFF
  ( p_nd           in     e_tar_nd.nd%type
  , p_id           in     e_tar_nd.id%type
  , p_active       in     e_tar_nd.otm%type
  , p_amnt         in     e_tar_nd.sumt%type
  , p_end_dt       in     e_tar_nd.dat_end%type
  , p_idv_trf      in     e_tar_nd.sumt1%type
  , p_beg_dt       in     e_tar_nd.dat_beg%type
  , p_exmpt_beg_dt in     e_tar_nd.dat_lb%type
  , p_exmpt_enf_dt in     e_tar_nd.dat_le%type
  , p_incm_amnt    in     e_tar_nd.s_porog%type
  , p_trf1_amnt    in     e_tar_nd.s_tar_por1%type
  , p_trf2_amnt    in     e_tar_nd.s_tar_por2%type
  );

  --
  -- DEL_TARIFF ( ввидалення тарифу з дог. РКО )
  --
  procedure DEL_TARIFF
  ( p_nd           in     e_tar_nd.nd%type
  , p_id           in     e_tar_nd.id%type
  );

END ELT;
/
CREATE OR REPLACE PACKAGE BODY ELT
IS

  G_BODY_VERSION  CONSTANT VARCHAR2(64)  := 'version 45.12 від 01.09.2017';
  G_AWK_BODY_DEFS CONSTANT VARCHAR2(512) := '';    -- 45.2 в_д 18.03.2017

/****
12/05    KDI COBUSUPABS-5912. Правка пр-ри ROZ_AV, OPL + ACCREG
18/03    KDI COBUSUPABS-5576. Пр-ра BORG. Дод. рекв_зити SHTAR, KTAR для док-та погашення 3579
16/03    KDI COBUSUPABS-5576. Дод. реквізити SHTAR, KTAR для док-та списання
 2/02    KDI COBUSUPABS-5068 - рах-к 'W4A', tt='PKH' (для ПЦ)
10/01-17 KDI COBUSUPABS-5068 - рах-к 'W4A', tt='ELP' (для ПЦ)
15/12  - BAA додав проц. OPN_ACNT
09/12  - BAA заповнення ОБ22 через проц.
31/08    Уточнення по пошуку входження в корпорацію
 9/08    Включаю аналіз E_TARIF.fl1 + формула NAZN - оплата вперед
31/03
16/03    Аналіз оборотів по всіх ID з ID_GLOB=204
24/02    Пр-ра BORG: ф-ка F_GET_ELT_OB22
16/02    Пр-ра BORG: заремив вичитку пар-ра SHTAR
10/02    В документ нарахування включено допрек-т KTAR. Значення з ID_GLOB
20/01    Нова F_ELT_TAR_PAK для TARIF та ...
16/01-16 SHTAR + 204 ....
30/12    Глоб. пар-ри MFOP + MFO  для ГОУ
24/12    Передача уточненого значення ОБ22 для формули F_ACC_TAG_1... по корпор-му контрагенту
14/12    BORG: Відмінено присвоєння 3579/07
28/10    Уточнено компоновку формули та змінні для неї
25/10-15 Розширена формула для рах-ку 6110.
         Нова функція F_ACC_TAG_1  для можливості вичитки інд-го 6110 для будь-яких тарифів.
29/09-14 Уточнено вичитку формули призначення платежу
24/09-14 Уточнення ОБ22 для 6110 по корпоративних клієнтах
26/06-14 Функція перевірки оборотів...
15/04-14 Варіації щодо формул призначення платежу в пр-рі BORG
14/04-14 Варіації щодо формул призначення платежу в пр-рі OPL
25/02-14 Зміни щодо обробки валютних рахунків та інше
     ф-ія F_ELT_RNK
     Пр-ри CP_OPL, CP_BORG, SHNELL, ROZ_AV
***/

n_tar_pak number :=0;

-- * header_version - возвращает версию заголовка пакета СЭП
function header_version return varchar2 is
begin
  return 'Package header ELT '||G_HEADER_VERSION||'.'||chr(13)||chr(10)
     ||'AWK definition: '||chr(13)||chr(10)
     ||G_AWK_HEADER_DEFS;
end header_version;

-- * body_version - возвращает версию тела пакета СЭП
function body_version return varchar2 is
begin
  return 'Package body ELT '||G_BODY_VERSION||'.'||chr(13)||chr(10)
     ||'AWK definition: '||chr(13)||chr(10)
     ||G_AWK_BODY_DEFS;
end body_version;

function Get_NLS_random  (p_R4 accounts.NBS%type ) return accounts.NLS%type   is   --получение № лиц.сч по случ.числам
                          nTmp_ number ;            l_nls accounts.NLS%type ;
begin
  While 1<2        loop nTmp_ := trunc ( dbms_random.value (1, 999999999 ) ) ;
     begin select 1 into nTmp_ from accounts where nls like p_R4||'_'||nTmp_  ;
     EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ;
     end;
  end loop;         l_nls := vkrzn ( substr(gl.aMfo,1,5) , p_R4||'0'||nTmp_ );
  RETURN l_Nls ;
end    Get_NLS_random ;
---=====================
FUNCTION  F_All (nd_ int, id_ int, sdate_ date, p_wdate_ date) RETURN number is
--общее по всем функциям
P_PDV_ number(7,2);
WDATE_ date;
begin
   WDATE_:=p_wdate_;         -- LAST_DAY(p_wdate_);
if FWDAT_ <>  WDATE_ then
  FKOL_:=elt.RAB_DNI(to_date('01'||to_char(WDATE_,'mmyyyy'),'ddmmyyyy'),WDATE_);
  FWDAT_:=WDATE_;
end if;

if fND_ = ND_ and fID_ = ID_ then   return 0; end if;

begin
  select greatest(n.DAT_BEG,to_date('01'||to_char(WDATE_,'mmyyyy'),'ddmmyyyy')),
         least(nvl(n.DAT_END,WDATE_ ),WDATE_ ),
      --   NVL(n.DAT_END, WDATE_),
         NVL(n.sumt,e.sumt), e.NDS
  into FDAT1_, FDAT2_, FSUM_, P_PDV_
  FROM e_tar_nd n, e_tarif e
  WHERE n.nd=ND_ and n.id=e.id and n.id=ID_;
          -- ! переопределение FSUM_ с учетом периода действия индив-го тарифа
  FSUM_:= ELT.Tarif(FDAT1_, FDAT2_, ND_, ID_);
  FSUM_:= round( FSUM_ *  elt.RAB_DNI1(FDAT1_,FDAT2_,FKOL_) / FKOL_,0);
  FSPDV_:=0;
  if P_PDV_ <> 0 then
     FSPDV_ := round( (FSUM_*P_PDV_)/(100+P_PDV_) );
  end if;
exception when NO_DATA_FOUND THEN FDAT1_:=null; FDAT2_:=null;
                                  FSUM_:=null; FSPDV_:=NULL;
end;
  FND_:= ND_; FID_:=ID_;
  return 1;
end F_All;
-----------
FUNCTION  F_Dat1 (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN date is
--первая дата в закрытом периоде по услуге
begin
 fTmp_:=elt.F_All (nd_, id_, sdate_, wdate_); return FDAT1_;
end F_Dat1;
-------------
FUNCTION  F_Dat2 (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN date is
--последняя дата в закрытом периоде по услуге
begin
 fTmp_:=elt.F_All (nd_, id_, sdate_, wdate_); return FDAT2_;
end F_Dat2;
-------------
FUNCTION  F_Sum (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN number is
--сумма за усл в закрытом периоде
begin
 fTmp_:=elt.F_All (nd_, id_, sdate_, wdate_); return  FSUM_;
end F_Sum;
---------------
FUNCTION  F_SumP (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN number is
-- сумма НДС за услугу в закрытом периоде
begin
 fTmp_:=elt.F_All (nd_, id_, sdate_, wdate_); return  FSPDV_;
end F_SumP;
---==========================
--FUNCTION  F_Spr (nd_ int, id_ int, sdate_ date, wdate_ date) RETURN varchar2 is
----сумма прописью
--begin
-- fTmp_:=elt.F_All (nd_, id_, sdate_, wdate_);
-- return   substr(f_sumpr(FSUM_,'980','F',2),1,253);
--end F_Spr;
---=========================
PROCEDURE AKT(id_ int, RNK_ int, p_WDATE_ date) is
--формирование врем.таблицы для печати
WDATE_ date;
begin
   WDATE_:=LAST_DAY(p_wdate_);
 DELETE from tmp_ag1 where id=id_ or id is null;
 insert into tmp_ag1
       (id,   ND,  RNK,  NMK,    NLS,  SDATE, WDATE,    US, DATE3,DATE4, ir, sz8)
 select ID_,d.nd,d.RNK,substr(c.NMK,1,38),
        d.nls26,d.SDATE, WDATE_, n.id,
        elt.F_Dat1(n.nd,n.id,d.sdate,WDATE_),
        elt.F_Dat2(n.nd,n.id,d.sdate,WDATE_),
        elt.F_Sum (n.nd,n.id,d.sdate,WDATE_),
        elt.F_Sump (n.nd,n.id,d.sdate,WDATE_)
 FROM   customer C, e_deal D, e_tar_nd N
 where  d.nd =n.nd and d.rnk= c.rnk and d.rnk=decode(RNK_,0,c.rnk,RNK_)
        and d.sos<>15;
 commit;
end AKT;
---=========================

FUNCTION  RAB_DNI ( DAT1_ date, DAT2_ date) RETURN NUMBER is
--количество раб дней в периоде
  KOL_ number;  KOL1_ number;
begin

  if DAT2_ < DAT1_  then return 0; end if;

 KOL_:= DAT2_ - DAT1_ +1;

 SELECT count(*) into KOL1_ FROM HOLIDAY
 WHERE KV=n980_
       and holiday BETWEEN DAT1_ AND DAT2_;
 KOL_:= KOL_ - kol1_;

  RETURN KOL_;
end RAB_DNI;
------------
FUNCTION  RAB_DNI1 ( DAT1_ date, DAT2_ date, KOL_ int ) RETURN NUMBER is
--количество раб дней в известном периоде
  KOL1_ number; KOL2_ number;
begin
  if DAT2_ < DAT1_  then return 0; end if;

  if DAT1_ <= JAN1_ and DAT2_ is null then
     KOl1_:=KOL_;
  else
 begin
 select DAT2_ - DAT1_ +1 into KOL1_  from DUAL;

 SELECT count(*) into kol2_ FROM HOLIDAY
 WHERE KV=n980_
       and holiday BETWEEN DAT1_ AND DAT2_;
 KOL1_:= KOL1_ - kol2_;
 exception  when others THEN KOL1_:='0';
 end;
   end if;
   RETURN KOL1_;
end RAB_DNI1;

------------
FUNCTION Tarif
( DAT1_ date
, DAT2_ date
, ND_   INT
, ID_   int
) RETURN NUMBER
is -- розрахунковий тариф
  S_tar number;    S_tari number;
  dtl_b date;      dtl_e date;
  l_nls varchar2(14); l_kv26 int; l_acc26 int;
begin

  select n.sumt, t.sumt, n.dat_lb, n.dat_le, nls26, kv26, acc26
    into S_tari, S_tar, dtl_b, dtl_e, l_nls, l_kv26, l_acc26
    from e_tar_nd n, e_tarif t, e_deal e
   where n.nd=nd_
     and n.id=t.id
     and e.nd=n.nd
     and n.id=ID_;

  if s_tari is not NULL
  then

        if NVL(dtl_b,dat1_) > NVL(dtl_e,dat2_) then   -- НЕ коректный период
           RETURN NVL(S_tar,0);
        end if;

        if    NVL(dtl_b,dat1_) > dat2_  then RETURN NVL(S_tar,0);
        elsif NVL(dtl_e,dat2_) < dat1_  then RETURN NVL(S_tar,0);
        else  RETURN NVL(S_tari,0);
        end if;
     end if;

    if ( l_mfo = '380764' )
    then -- НАДРА

      S_tar := f_tarif(ID_,l_kv26,l_nls,0,1);

      RETURN nvl(S_tar,0);

    end if;

    if ( ID_ = 204 ) -- what the hell is this?
    then

      if NVL(F_ELT_TAR_PAK(ND_),0) = 0
      then

        null;

      else

        S_tar := f_tarif(ID_,l_kv26,l_nls,0,1);

        return nvl(S_tar,0);

      end if;

    end if;


  RETURN NVL(S_tar,0);

end Tarif;

------------
FUNCTION F_ELT_RNK (p_NLS varchar2, p_KV int default 980, p_reg int default 0)
return varchar2 is
l_nd varchar2(38);
l_rnk int;
l_nls varchar2(15);  l_nmk varchar2(38);
l_ret varchar2(50);
-- ! Только для портфеля абонплаты
-- Возвращает NLS/RNK или NMKK клиента для договора по р/счету (E_DEAL.nls26)

BEGIN
 begin
   select max(rnk) into l_rnk
          from e_deal
          where nls26=p_NLS and kv26=p_kv;
   EXCEPTION WHEN OTHERS THEN l_rnk:=NULL;
 end;

begin
select trim(substr(nvl(nmkk,nmk),1,38)) into l_nmk
from customer where rnk=l_rnk;
exception when NO_DATA_FOUND then l_nmk:='?';
end;

if p_reg=0 then
l_ret:='по р-ку '||p_nls;
if p_kv!=980 then l_ret:=l_ret||'/'||p_kv; end if;
--l_ret:=l_ret||'/'||to_char(l_rnk);
return l_ret;
else
return l_nmk;
end if;
end F_ELT_RNK;
----------------
FUNCTION  F_ELT_TAR_PAK (p_ND INT) RETURN NUMBER is
  -- тарифний пакет
  n_tpak number;
  l_acc int;

  begin

  n_tpak:=0;

  begin
  select acc26 into l_acc from e_deal where nd=p_nd;

    begin
    SELECT to_number(translate(w.VALUE,'.',','), '9999D99') into n_tpak
    FROM   AccountsW W
    WHERE  w.acc=l_acc
           and w.TAG='SHTAR' and w.VALUE is not null;
    exception when NO_DATA_FOUND then n_tpak:=0;
    end;

  exception when NO_DATA_FOUND then l_acc:=-9;
  end;

  return nvl(n_tpak,0);

  end;  -- F_ELT_TAR_PAK

----------------
FUNCTION  ROZ_AV ( DAT1_ date, DAT2_ date, KOL_ int, ND_ INT) RETURN NUMBER is
  --розрахунковий аванс
  S_ number; S5 number;
  l_dat_b date; l_dat_e date;
  l_id int; l_fl1 int; fl5 int:=1;
  l_kol int;
begin
  if KOL_ = 0 then return 0; end if;
  l_kol:=KOL_; S_:=0; S5:=0;

  if DAT1_ <= JAN1_ and DAT2_ is null then

     SELECT SUM(ELT.Tarif(DAT1_, DAT2_, ND_, e.id))
            --SUM( NVL(n.sumt,e.sumt) )
     INTO S_
     FROM e_tar_nd n, e_tarif e
     WHERE n.nd=ND_ and n.id=e.id ;

  else

     for k in
     (select           --greatest(nvl(n.dat_beg,DAT1_),DAT1_), least(nvl(n.dat_end,DAT2_),DAT2_),
            nvl(n.dat_beg,DAT1_) dat_b, nvl(n.dat_end,DAT2_) dat_e, n.id, e.fl1
     --into l_dat_b, l_dat_e, l_id, l_fl1
     FROM e_tar_nd n, e_tarif e
     WHERE n.nd=ND_ and n.id=e.id)
     loop
     l_dat_b:=k.dat_b; l_dat_e:=k.dat_e; l_id:=k.id; l_fl1:=k.fl1; fl5:=1; S5:=0;

     if l_dat_b < DAT1_ then l_dat_b := DAT1_;
     elsif l_dat_b > DAT2_ then S5:=0; S_:=S_+S5; fl5:=0;
     else if l_fl1= 1 then l_dat_b:=DAT1_; end if;
     end if;

     if l_dat_e > DAT2_ then l_dat_e:=DAT2_;
     elsif l_dat_e < DAT1_ then S5:=0; S_:=S_+S5; fl5:=0;
     else if l_fl1= 1 then l_dat_e:=DAT2_; end if;
     end if;

     if fl5=0 then null;
     else
     l_kol := elt.RAB_DNI(l_dat_b,l_dat_e);
     S5:= round(ELT.Tarif(DAT1_, DAT2_, ND_, l_id) * l_kol / KOL_,0);
     S_ := S_ + S5;
     end if;


     /***
     SELECT SUM( round(ELT.Tarif(DAT1_, DAT2_, ND_, e.id) *
       decode(nvl(fl1,0),1,KOL_,elt.RAB_DNI(greatest(DAT1_,n.DAT_BEG), least(NVL(n.DAT_END,DAT2_),DAT2_ )
                  )) / KOL_,0) )
     INTO S_
     FROM e_tar_nd n, e_tarif e
     WHERE n.nd=ND_ and n.id=e.id ;
     ***/

     end loop;

  end if;

  RETURN NVL(S_,0);

end ROZ_AV ;
------------

-- Процедура для оплати з БМД (ММФ)
procedure opl_web(p_mode   integer,
                  p_date   varchar2,
                  p_packet integer,
                  p_nls36  varchar2) is
  l_tt       oper.tt%type;
  l_dat1     date;
  l_dat2     date;
  l_kol      integer;
  l_err      varchar2(4000);
begin
  if p_packet = 0
  then
   l_tt:='ELA';
  else
 l_tt   := GetGlobalOption('ELT_TT');
  end if;

  l_dat1 := to_date('01' || p_date, 'ddmmyyyy');
  l_dat2 := last_day(l_dat1);
  l_kol  := elt.RAB_DNI(l_dat1, l_dat2);
  opl(p_mode, l_tt, 0, null, p_date, l_dat1, l_dat2, l_kol, p_packet, p_nls36, l_err);
end opl_web;


PROCEDURE OPL
( MODE_     INT,
  TT_       char,
  REZ_      number,
  NLS_PDV_  varchar2,
  mes_      varchar2,
  DAT1_     date,
  DAT2_     date,
  KOL_      int,
  PAKET_    int,
  NLS36_    varchar2 ,
  sErr_ OUT varchar2
) IS

 S_ number; S_NDS_ number;
 REF_ int ;
 TXT_ varchar2(80);
 NAZN_ varchar2(180); ID_ int;
 naznf_  varchar2(180);
 l_nazn  varchar2(180);  l_nazn2  varchar2(180);  --TNAZNF.txt%TYPE;
 l_npd_3570 varchar2(160); l_npk_3570 varchar2(160);
 FL_ int  ;  FL_Y int;  pNDS_ number;
 STXT_ varchar2(35);
 datm_ date;
 datlit_ varchar2(25);
 datlit_f varchar2(25); -- нарахування наперед
 t_pdv varchar2(12);
 t_pdv1 varchar2(12);
 t_pdvs varchar2(20);
 pdv5 number;
 TXT5 varchar2(80);
 reg_g varchar2(1) := Nvl(GetGlobalOption('ELT_3'),'0');
 S_K number;  SS_ number;
 ELT_ND_ varchar2(20);
 ELT_DT_ varchar2(10);
 ELT_NDW_ varchar2(50);
 int_func_ varchar2(160);
 ff_ varchar2(160);
 PDV_f_ varchar2(120);
 nls_pdvv_ varchar2(15);
 nls_pdvr_ varchar2(15);
 DEB_26_ CHAR(1);
 l_pdvnls varchar2(15);
 l_elt_rnk varchar2(38);
 l_nlsp varchar2(15);
 l_nmsp varchar2(38);
 l_kodk int;
 l_ob22_6 varchar2(2);
 fl_korp int:=0;
 pnt int;
 --n_tar_pak number;
 l_ostc3 number;
 l_ostb3 number;
 l_tip accounts.tip%type;
 l_tt tts.tt%type;
 l_id_glob e_tarif.id_glob%type;
 ern CONSTANT POSITIVE   := 208;
 err1 EXCEPTION;
 erm VARCHAR2(400);
 err EXCEPTION;

  PROCEDURE INS_OPERW
  ( p_ref int, p_tag varchar2, p_value varchar2
  ) IS
  BEGIN
    begin
      insert into operw (ref,tag,value) values (p_ref, p_tag, p_value);
    exception
      when dup_val_on_index then null;
    end;
  END INS_OPERW;
  ---
BEGIN

  delete from tmp_ovr where id=36;

  JAN1_:= ADD_MONTHS(LAST_DAY(DAT1_),-1)+1;

  case
    when MODE_ = 0
    then
      STXT_ :='Повернути надлишки ав.(3600->26_0)';
      TXT_  :='Повернення. ';
    when MODE_ = 1
    then
      STXT_ :='Стягнути розрах.аванс (26_0->3600)';
    when MODE_ = 2
    then
      STXT_ :='Сформувати доходи банку (3*->6*)';
    when MODE_ = 3
    then
      STXT_ :='Закрити заб-ть (26_0->3570*)';
    else
      null;
  end case;

  -- флаг оплаты из TTS
  l_tt:=TT_;
  begin
    select decode (substr(flags,38,1), '1',1,0) into FL_ from tts where tt=l_tt;
  exception
    when NO_DATA_FOUND then
      logger.error( 'ELT.OPL  Операція НЕ знайдена '||l_tt);
      erm:='Операція НЕ знайдена '||l_tt;
      raise_application_error(-(20203),'\9350 - Cannot found '||erm||' '||SQLERRM,TRUE);
  end;

  datlit_ := ''; datlit_f := '';
  ID_ :=USER_ID;
  TXT_:= TXT_||'Аванс за надання ел.послуг в '|| MES_ ;

  -- можливi послуги з ПДВ i без ПДВ
  l_pdvnls :='36220';
  nls_pdvr_:='36221';

  if nls_pdv_ like '3622%'
  then    -- 4-й пар-р виклику ф-ії Sel001
    nls_pdvr_:=nls_pdv_;
  elsif fl_l_pdv=0 then  nls_pdvr_:=G_pdv;
  elsif fl_l_pdv=9 then  nls_pdvr_:=l_pdvnls;  -- НЕ вдалось знайти інд. р-к ПДВ
  else NULL;
  end if;

  for k in ( SELECT d.ND, d.CC_ID, d.SDATE, c.OKPO,
                    a3.NLS NLS3, a3.ostc OST3, substr(a3.NMS,1,38) NMS3,
                    a2.NLS NLS2, greatest(0,a2.ostc+NVL(a2.lim,0)) OST2,
                    a3.ostb OST3P, a3.acc acc3,
                    a2.ostc OST2C, substr(a2.NMS,1,38) NMS2, d.WDATE,
                    d.SA, a2.acc, d.accp, a2.kv KV2,
                    a2.tip tip2, p.tip tipp,
                    p.nls  NLS_P, p.ostc OST_P, substr(p.nms,1,38) NMS_P,
                    c.rnk, c.branch BRANCH_K, a2.branch BRANCH_R, a2.lim
              FROM e_deal$base d, accounts a3, accounts a2, customer c, accounts p
             WHERE d.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
               and d.rnk = c.rnk
               and d.acc36  = a3.acc and a3.dazs is null
               and d.acc26  = a2.acc and a2.dazs is null
               and d.accp  = p.acc(+) and p.dazs is null
               and (PAKET_  = 0 or a3.nls= NLS36_)
               and d.sos<>15  -- без закритих угод
             order by d.nd )
  loop
    logger.info('ELT.OPL  nd='||k.nd||';  MODE ='|| MODE_ ||' begin');
    savepoint DO_O;  --jeka 07.06.2017
    begin
    l_tt:=TT_; --jeka 06.06.2017  --всегда стартуем с этой операции

    pnt := 0;

    BEGIN
      select substr(VALUE,1,1)
        into DEB_26_
        from CUSTOMERW
       where TAG = 'Y_ELT'
         and RNK = k.RNK
         and VALUE Is Not Null -- = 'N'
         and ROWNUM = 1;
    exception
      when NO_DATA_FOUND then
        DEB_26_:='Y';
    end;

    if to_char(k.wdate,'YYMM') < to_char(bankdate,'YYMM')
    then
      datm_:= dat1_;
    else
      datm_:= bankdate;
    end if;

    datlit_ :=' '||F_Month_lit(datm_,1,4);
    datlit_f:=' '||F_Month_lit(ADD_MONTHS(datm_,+1),1,4);

    ELT_nd_ := F_ELT_nd(k.nls3);

    pnt := -1;

    ELT_dt_ := F_ELT_dt(k.nls3);

    if fl_ndw ='1' then
       int_sql:='select '||nm_F_ndw||'('||k.nls3||')'||' from dual';
       logger.trace('ELT.int_sql='||int_sql);
       begin
       execute immediate int_sql  into ELT_ndw_;
       exception  when OTHERS then
       ELT_ndw_:='..';
       end;
    else
      ELT_ndw_:='..';
    end if;

    logger.trace('ELT.ndw='||ELT_ndw_);

    l_elt_rnk := F_ELT_RNK(k.nls2,k.kv2);

    pnt:=-2;

    if l_mfop = '300465' or l_mfo='300465'
    then
      begin
        SELECT to_number(translate(trim(w.VALUE),'.',','), '9999D99')
          into n_tar_pak
          FROM   AccountsW W
         WHERE  w.acc=k.acc
           and w.TAG='SHTAR' and w.VALUE is not null;
      exception
        when NO_DATA_FOUND then
          n_tar_pak:=0;
      end;
    end if;

    bars_audit.info( $$PLSQL_UNIT || 'OPL: n_tar_pak=' || to_char( n_tar_pak ) );
------------
  If MODE_ < 2
  then

       begin
    SELECT  NVL(e.NDS,pNDS_ )
    into PDV5
    FROM e_tar_nd n, e_tarif e
    WHERE n.nd=k.ND and n.id=e.id
          and n.DAT_END is NULL and n.DAT_BEG is not NULL   -- and n.otm=1
          and rownum=1;
    exception  when NO_DATA_FOUND THEN pdv5:=0;
       end;
    TXT5:= TXT_;

--    S_:=elt.ROZ_AV (DAT1_, DAT2_, KOL_, k.ND) ;
      S_:= k.SA;
      --стягнення та повернення авансу
      If    MODE_= 1 and S_>k.OST3 and k.ost3>=0
            and DAT1_ > k.WDATE
            and DEB_26_ = 'Y' then
            S_:= least(S_- k.OST3, k.OST2) ;
-------- можливi послуги з ПДВ i без ПДВ для NAZN
         if PDV5 >0 then
            TXT5 := TXT5 || ' з ПДВ ' || PDV5 || '%' ;
         else
            TXT5 := TXT5 || ' без ПДВ ' ;
         end if;
      elsIf MODE_= 0 and k.OST3>S_  then
            S_:= k.OST3 -S_ ;
      else  S_:= 0;
      end if ;

      if S_ > 0
      then

        if S_ = k.SA
        then

          S_NDS_:=0;

       -- ?? треба думати як розр-ти ПДВ по кожнiй послузi окремо та просумувати....
       -- if d.NDS=0 then t_pdv1:=' без ПДВ.';
          if 1=0
          then
            t_pdv1:=' без ПДВ.';
            t_pdvs:=' без ПДВ.';
          else
            t_pdvs:='';
          end if;

        else
          t_pdvs:='';
        end if;

        savepoint DO_PROVODKI_1;

        begin

          GL.REF (REF_);

          bars_audit.info( $$PLSQL_UNIT || 'OPL: Start pay document #' || to_char( REF_ )|| ', mode=' || to_char(MODE_) );

          NAZN_:=substr(TXT5||'. Угода '||k.CC_ID||' вiд '||to_char(k.SDATE,'dd/mm/yyyy'),1,160);

          GL.IN_DOC3( ref_   => REF_,
                      tt_    => l_tt,          dk_    => MODE_,
                      vob_   => 6,            nd_    => SubStr(to_char(REF_),-10),
                      pdat_  => sysdate,      data_  => gl.bDATE,
                      vdat_  => gl.bDATE,     datp_  => gl.bDATE,
                      kv_    => gl.baseval,   kv2_   => gl.baseval,
                      s_     => S_,           s2_    => S_,
                      mfoa_  => gl.AMFO,      mfob_  => gl.AMFO,
                      nlsa_  => k.NLS2,       nlsb_  => k.NLS3,
                      nam_a_ => k.NMS2,       nam_b_ => k.NMS3,
                      id_a_  => k.okpo,       id_b_  => k.okpo,
                      nazn_  => NAZN_,        uid_   => null,
                      d_rec_ => null,         sk_    => null,
                      id_o_  => null,         sign_  => null,
                      sos_   => null,         prty_  => null
                    );

          GL.PAYV( FL_, REF_, GL.BDATE, l_tt, MODE_
                 , gl.baseval, K.NLS2, S_
                 , gl.baseval, K.NLS3, S_ );

        exception
          when others then
            rollback to DO_PROVODKI_1;
            begin
              insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt )
              values (GL.BDATE, 36, MODE_, K.NLS2, K.NLS3, S_,STXT_);
            end;
        end;

      end if;

   elsIF MODE_ =2 and DAT1_ > k.WDATE /*and DEB_26_ = 'Y' */then     --jeka 26.06.2017 COBUSUPMMFO-840

 -- Вичитуємо ІНДИВІДУАЛЬНИЙ рах-к ПДВ

   if g_pdv_sql is not NULL and fl_l_pdv = 0 then

      ff_:=g_pdv_sql;
      ff_ := Replace(ff_,':ACC',k.acc );

       begin
      execute immediate ff_  into l_pdvnls;
      logger.trace( 'ELT. Інд.рах.ПДВ='||l_pdvnls);
      exception  when OTHERS then
      logger.error( 'ELT. incorrect SQL expr.- інд.рах.ПДВ  '||ff_);
      l_pdvnls:='36221';  fl_l_pdv:=9;
      end;
      nls_pdvr_:=l_pdvnls;
   end if;


   if l_MFOP ='300465' or l_mfo = '300465' then
   begin
   select kodk into l_kodk from RNKP_KOD where rnk=k.rnk and kodk is not null and rownum=1;
   fl_korp:=1;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_kodk:=0; fl_korp:=0;
   end;
   end if;


   if k.nls3 like '3570%'
      or (k.nls3 like '3600%' and k.ost3 >= k.SA and k.ost3=k.ost3p)
   then

     logger.trace('ELT.OPL 2 ND='||k.ND);
declare
   NLS6_ varchar2(15) ; NMS6_ varchar2(38);
   c int; i int;  -- хандлер курсора и перем
   dSql_ varchar2(200):='****'; -- тело формулы
   nTmp_ int; sTmp_ varchar2(250); -- тело SELECT
   l_ob22 varchar2(2):='67'; l_nbs6 char(4);
   l_tar number :=0; s_kontr number :=0;

  l_dat_b date; l_dat_e date; S5 number:=0;
  l_id int; l_fl1 int; fl5 int:=1;
  l_kol int:=0;

begin
   if newnbs.g_state= 1 then  --переход на новый план счетов
    l_nbs6:='6510';
   else
    l_nbs6:='6110';
   end if;
   c:=DBMS_SQL.OPEN_CURSOR; --открыть курсор

   FOR d in (SELECT e.NLS6, e.NAME, NVL(e.NDS,pNDS_ ) NDS,
          ---   round(ELT.Tarif(DAT1_, DAT2_, n.ND, e.id) *
          ---         decode(nvl(e.fl1,0),1,KOL_,
          ---         elt.RAB_DNI(greatest(n.DAT_BEG,DAT1_), least(nvl(n.DAT_END,DAT2_ ),DAT2_)
          ---                             )) / KOL_, 0) S,
                    0 S,
                    nvl(trunc(n.dat_beg),DAT1_) dat_b, nvl(trunc(n.dat_end),DAT2_) dat_e,
                    e.id ID, e.npd_3570, ob22_6110, e.id_glob, e.fl1, n.nd
             FROM e_tar_nd n, e_tarif e  WHERE n.nd=k.ND and n.id=e.id
                                           AND n.dat_beg is not null) --jeka 05.07.2017
   LOOP


     l_dat_b:=d.dat_b; l_dat_e:=d.dat_e; l_id:=d.id; l_fl1:=d.fl1; fl5:=1;

     if d.fl1=0 then null;
        l_kol := elt.RAB_DNI(l_dat_b,l_dat_e);
     else
     if l_dat_b < DAT1_ then l_dat_b := DAT1_;
     elsif l_dat_b > DAT2_ then S5:=0;  fl5:=0;
     else if l_fl1= 1 then l_dat_b:=DAT1_; end if;
     end if;

     if l_dat_e > DAT2_ then l_dat_e:=DAT2_;
     elsif l_dat_e < DAT1_ then S5:=0;  fl5:=0;
     else if l_fl1= 1 then l_dat_e:=DAT2_; end if;
     end if;

     if fl5=0 then null; S_:=0; l_kol:=0;
     else
     l_kol := elt.RAB_DNI(l_dat_b,l_dat_e);
     end if;

     end if;

     if fl5=1 then
       logger.info('ELT_TRACE l_kol = '||to_char(l_kol)||', KOL_ = '||to_char(KOL_));
  --     raise_application_error(-20001,'ELT_TRACE l_kol = '||to_char(l_kol)||', KOL_ = '||to_char(KOL_));
        S5:= round(ELT.Tarif(DAT1_, DAT2_, d.ND, l_id) * l_kol / KOL_,0);
        S_ := S5;
     end if;

     d.s:=S_;



         l_tar:=d.s;
       logger.info('ELT.OPL 2 nd='||k.nd||' tarif='||d.ID||' пакет='||n_tar_pak||' suma='||d.s);

      if d.S >0 then
--         if d.NDS=0 then t_pdv1:=' без ПДВ.';
--         else            t_pdv1:=' з ПДВ '||d.NDS|| '%.';
--         end if;

            S_NDS_:=0;  S_:=d.S;
            if d.NDS >=1 then
           /* % НДС = NDS. Пропорция имеет вид: d.S - 100+NDS, S_NDS_- NDS */
            S_NDS_:= round( (d.S*d.NDS)/(100+d.NDS) );
            S_:= d.S - S_NDS_ ;
            end if;

         if d.NDS=0 then t_pdv1:=' без ПДВ.';
                         t_pdvs:=' без ПДВ.';
         else   t_pdv1:=' з ПДВ '||d.NDS|| '%.';
                t_pdvs:=' з ПДВ '||trim(to_char(S_NDS_/100,'99D99'))||' грн.';
         end if;

---===================
     if gl.amfo = '380764'             -- НАДРА
        or l_MFOP ='300465' or l_MFO ='300465' then       -- Ощадбанк
     if N_Func_ is not NULL then  int_func_ := N_Func_;

       if nvl(n_tar_pak,0) = 0 or d.id_glob not in (204) then goto LAB_2; end if;

     /*   if d.id=4 or d.id=7 then
        s_kontr:=k.ost2c;
        elsif d.id in (8,11) then s_kontr:=l_tar;
        else s_kontr:=0;
        end if;  */   s_kontr:=0;

     ff_:='select '||int_Func_||'('||k.acc||','||
          'to_date('''||to_char(DAT2_, 'dd/mm/yy')||''',''dd/mm/yy''),'||
          nvl(to_char(d.id_glob), 'null') ||','||s_kontr||',0) '||
          ' from dual';
      bars_audit.info('Привет от ДИ: ' || ff_);
 --   logger.trace('ELT.OPL 2 '||ff_);

begin
    execute immediate ff_  into FL_Y;
    exception  when OTHERS then
    logger.error( 'ELT.OPL  Ошибка выполнения ф-ии '||int_Func_ || chr(10) ||
                  ff_ || chr(10) ||
                  sqlerrm || chr(10) ||
                  DBMS_UTILITY.FORMAT_ERROR_BACKTRACE());
    FL_Y:=0;
    erm:='incorrect SELECT expression with '||ff_;
    raise err;
end;
   -- logger.trace('ELT.OPL 2 '||k.nls2||'/'||k.kv2||' флаг='||FL_Y);
    if FL_Y=0 then
       logger.info('ELT.OPL 2 '||k.nls2||'/'||k.kv2||' тариф '||d.id
                  ||' т.пакет='||n_tar_pak||' флаг='||FL_Y||' НЕ нараховуємо абонплату');
    goto kin_2;
    end if;
    end if;  -- N_Func
    end if;  -- MFO
---===================

<<LAB_2>> NULL;
         -- безобразия с назначением платежа  по старому
         NAZN_:=d.NAME;
         if gl.amfo = '300205' then  -- УПБ
            NAZN_:=substr(NAZN_||' за '||datlit_,1,160);   -- ||t_pdv1,1,160);
         elsif gl.amfo = '300175' then  -- AGIO
            datlit_:=to_char(datm_,'mm/yyyy')||'р.';
            NAZN_:=substr(NAZN_||' за '||datlit_||t_pdv1,1,160);
            NAZN_:=substr(NAZN_||' Угода '||k.CC_ID||' вiд '||to_char(k.SDATE,'dd/mm/yyyy'),1,160);
         else
            NAZN_:=substr(NAZN_||' за '||datlit_||t_pdv1,1,160);
            NAZN_:=substr(NAZN_||' Угода '||k.CC_ID||' вiд '||to_char(k.SDATE,'dd/mm/yyyy'),1,160);
         end if;
         -- Формування призначення платежу через динамічну формулу
         begin
           select max(txt) into naznf_ from tnaznf where comm like 'ELT.OPL: NAZN MODE 2.%';
           EXCEPTION WHEN NO_DATA_FOUND THEN naznf_:=NULL;
         end;

      if d.npd_3570 is null then
         l_nazn:=naznf_;
      else
         l_nazn:='#('||d.npd_3570;  naznf_:=l_nazn||')';
      end if;

   IF SUBSTR(naznf_,1,2)='#(' THEN -- Dynamic NAZN present

      begin
      pnt:=1;
      naznf_ := Replace( naznf_, ':NAME_US', d.name );
      naznf_ := Replace( naznf_, ':PDV', t_pdv1 );
      naznf_ := Replace( naznf_, ':PD_VS', t_pdvs );
      naznf_ := Replace( naznf_, ':F_ELT_ND', ELT_nd_);
      naznf_ := Replace( naznf_, ':F_ELT_NDW', ELT_ndw_);
      if ELT_dt_ is not NULL then
      naznf_ := Replace( naznf_, ':F_ELT_DT', ' вiд '||ELT_dt_);
      end if;

      if datlit_ is not NULL then
      naznf_ := Replace( naznf_, ':R_DATE', ' за '||datlit_);
      end if;

      if datlit_f is not NULL then
      naznf_ := Replace( naznf_, ':F_DATE', ' за '||datlit_f);
      end if;

   --   if FL_Y=1 then l_ELT_rnk:=''; end if;
   --   l_ELT_rnk:='';
      naznf_ := Replace( naznf_, ':F_ELT_RNK', l_ELT_rnk);
      exception when others then
      logger.error('ELT.OPL 2 довжина naznf='||naznf_);
    raise_application_error(-(20203),'\9350 - naznf_ length '||SQLERRM,TRUE);
      end;

      BEGIN
      pnt:=2;
      l_nazn2:=null;
      EXECUTE IMMEDIATE
        'SELECT '||SUBSTR(naznf_,3,LENGTH(naznf_)-3)||' FROM DUAL' INTO l_nazn2;
      EXCEPTION
         WHEN OTHERS THEN
              err_num := SQLCODE;
              err_msg := SUBSTR(SQLERRM, 1, 80);
         erm:='incorrect SELECT expression p.M2 ';
         raise err;
      END;

      naznf_:=l_nazn2;    -- prom for otl
      if naznf_ is not NULL and length(naznf_)>10 then
         nazn_:= substr(naznf_,1,160);
      end if;

   END IF;

  begin
  select ob22,nbs into l_ob22,l_nbs6
  from tarif where kod=d.id;             -- NADRA
  exception  when NO_DATA_FOUND THEN l_ob22:='00'; --l_nbs6:='6110';
  end;

  if l_MFOP ='300465' or l_MFO='300465' then null;       -- тимчасово  28/10-15
     l_ob22:=d.ob22_6110;
       if newnbs.g_state= 1 then  --переход на новый план счетов
        l_nbs6:='6510';
       else
        l_nbs6:='6110';
       end if;
  end if;

  l_ob22_6:= null;

  if (l_MFOP ='300465' or l_MFO='300465') and fl_korp=1 then
     case (l_kodk)
      when 1 then
        l_ob22_6:='73';
      when 2 then
        l_ob22_6:='77';
      when 5 then
        l_ob22_6:='99';
      when 6 then
        l_ob22_6:='A4';
      when 8 then
        l_ob22_6:='A6';
      when 11 then
        l_ob22_6:='A7';
      else
        l_ob22_6:= null;
     end case;
  end if;

  if l_ob22_6 is not null then l_ob22:=l_ob22_6; end if;

         savepoint DO_PROVODKI_2;

         pnt:=3;
         begin
              -- logger.info('ELT.OPL dsql='||dsql_||' d.nls6='||d.nls6);

            If dSql_ <> d.NLS6 then /*смена счета 6-класса */  dSql_:=d.NLS6;
               dSql_ := Replace( dSql_, ':NLS26', k.acc);
               dSql_ := Replace( dSql_, ':BRANCH', k.branch_r);
               dSql_ := Replace( dSql_, ':OB22', l_ob22);
               dSql_ := Replace( dSql_, ':NBS6', l_nbs6);   nlsb_:=null;
               if (l_MFOP ='300465' or l_MFO='300465')
                  and dSql_ like 'NBS_OB22%'
                  and l_ob22_6 is not null then
               dSql_ := substr(dSql_,1,22)||l_ob22_6||substr(dsql_,25);
               sTmp_:= 'SELECT ' || dSql_ || ' from dual ';
          ---     logger.info('ELT.OPL sql= '||sTmp_);
               null;
               end if;
               sTmp_:= 'SELECT ' || dSql_ || ' from dual ';    pnt:=30;
     --    logger.info('ELT.OPL 2 sql= '||sTmp_);
  ---       logger.trace('ELT.OPL 2 sql= '||sTmp_);
               DBMS_SQL.PARSE(c,sTmp_ , DBMS_SQL.NATIVE); --приготовить дин.SQL
               DBMS_SQL.DEFINE_COLUMN(c,1,NLS6_,15);  --установить знач колонки в SELECT
               pnt:=31;
               i:=DBMS_SQL.EXECUTE(c);  --выполнить приготовленный SQL
               pnt:=32;
               IF DBMS_SQL.FETCH_ROWS(c)>0 THEN --прочитать
                  DBMS_SQL.COLUMN_VALUE(c,1,NLS6_); --снять результирующую переменную
               end if;
               nlsb_:=nls6_; pnt:=4;
   --   logger.info('ELT.OPL 2 nls6= '||nls6_);
               select substr(nms,1,38) into NMS6_
               from accounts where nls=NLS6_ and kv=n980_;
            end if;

            GL.REF (REF_);
            pnt:=5;
            /* % НДС = NDS. Пропорция имеет вид: d.S - 100+NDS, S_NDS_- NDS */
  --          S_NDS_:= round( (d.S*d.NDS)/(100+d.NDS) );
  --          S_:= d.S - S_NDS_ ;
     ---       logger.info('ELT.OPL 2 insert = '||
     ---                   ref_||' '||tt_||' '||n980_||' '||gl.amfo||' '||
     ---                   S_/100||' '||k.nls3||' '||k.nms3||' '||nls6_||' '
     ---             ||nazn_||' '||id_||' '||k.okpo||' '||okpo_);

            INSERT INTO oper (ref, nd, tt, vob, dk, kv, kv2, mfoa, mfob,
                   PDAT, VDAT, DATD, DATP, s, s2,
                   nam_a,nlsa, nam_b, nlsb,  nazn, userid, id_a, id_b)
            VALUES (REF_, case when length(ref_) > 10 then substr(ref_, -10) else to_char(ref_) end,
                   l_tt, 6, 1,n980_,n980_,gl.AMFO,gl.AMFO,
                    sysdate, gl.bDATE,gl.bDATE,gl.bDATE, S_, S_,
                    k.NMS3,k.NLS3, NMS6_, NLS6_,NAZN_,iD_,k.okpo, OKPO_);
            nlsb_:=nls6_;
     -- logger.info('ELT.OPL 2 payv ');
            pnt:=6;
            GL.PAYV(FL_,REF_,GL.BDATE,l_tt,1,n980_,K.NLS3,S_,n980_,NLS6_,S_);
     -- logger.info('ELT.OPL 2 payv 2 ');

            if S_NDS_ >=1 then pnt:=7; nlsb_:=nls_pdvr_;     -- ?  > 0
                               -- проводка по ПДВ
               GL.PAYV(FL_,REF_,GL.BDATE,l_tt,1,n980_,K.NLS3,S_NDS_,n980_,NLS_PDVr_,S_NDS_);
            end if;
     -- logger.info('ELT.OPL 2 update ');
            pnt:=8;
            update e_deal set WDATE=DAT2_ where nd=k.ND;

            pnt:=9; ins_operw(ref_,'KTAR',d.id_glob);

            if nvl(n_tar_pak,0) != 0 then ins_operw(ref_,'SHTAR',n_tar_pak); end if;

         exception when others then  rollback to DO_PROVODKI_2;
            begin
              insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt ) values
                               (GL.BDATE, 36, 1, k.NLS3, NLSB_, S_, STXT_ );
    logger.info('ELT.OPL 2 Отказ проводки для ND='||k.ND
                  ||' ДТ '||k.NLS3||' КР '||NLSB_||' S='||d.S
                  ||' pnt='||pnt||' т.пакет='||n_tar_pak||' корп.='||l_kodk);
              goto KIN_2;
            end;
         end;
      end if;
      <<kin_2>> NULL;
   END LOOP;  -- d
   DBMS_SQL.CLOSE_CURSOR(c);   -- закрыть курсор
exception when others then
  DBMS_SQL.CLOSE_CURSOR(c);   -- закрыть курсор
  raise_application_error(-20001,SQLERRM);
END;
   end if;  ----  k.nls3 like ...
---------
    elsif MODE_ =3 and DAT1_ <= k.WDATE
    then

      bars_audit.info( $$PLSQL_UNIT || 'OPL: Start mode=' || to_char(MODE_) );

      -- declare  err EXCEPTION;
      begin

        l_nlsp:=k.nls2;
        l_nmsp:=k.nms2;
        l_tip:=k.tip2;

        if k.nls_p is not null
        then
          l_nlsp := k.nls_p;
          l_nmsp := k.nms_p;
          l_tip  := k.tipp;
        end if;

        if l_tip = 'W4A'
        then l_tt:='PKH';
        end if;

      begin
      select ostc, ostb into l_ostc3, l_ostb3 from accounts where acc=k.acc3;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        bars_audit.info( $$PLSQL_UNIT || 'OPL:not found acc #' || to_char( k.acc3 ) );
      end;

      --пересчитываем остатки по 26*  --COBUMMFO-4069
      k.ost2:=  greatest(0,fost(k.acc,bankdate)+NVL(k.lim,0));
      if k.accp is not null then
       k.ost_p:= greatest(0,nvl(fost(k.accp,bankdate),0));
      else k.ost_p:= 0;
      end if;

      t_pdv:='без ПДВ.';
      S_:= k.SA;
      -- стягнення заборгованостi з р/р клiента
      If    MODE_= 3 and /*k.OST3<0*/ l_ostc3<0 and (k.ost2>0 or k.ost_p>0) --jeka 06.06.2017
            and k.ost3p = k.ost3
            and l_ostc3 = l_ostb3  -- 9/08-16 дод. контроль для мультивалютних 26..
                                   -- на одному 3570 - погашення один раз
            and (k.nls_p != k.nls3 or k.nls_p is NULL)
            and DEB_26_ = 'Y' then

         if l_elt4='1' and reg_g='0' then   --gl.amfo = '380623' then    -- "Столиця"
               S_:= least(-k.OST3, k.OST2) ;
             if k.nls_p is not null then S_:= least(-k.OST3, k.OST_P) ; end if;
         else
             if k.ost2 >= -k.ost3 or k.ost_p >= -k.ost3 then
                S_:=-k.OST3;
             else S_:= 0;
             logger.trace('ELT.OPL 3 ND='||k.ND||' недостатньо коштів для погашення '||k.ost2||' < '||k.ost3);
             end if;
         end if;

      else  S_:= 0;
      end if ;

      if k.nls_p is NULL and k.kv2!=980 then S_:=0; end if;


  if reg_g='0' then         -- 3.5  погашення 26_0 -> 3570 загальною сумою

    if S_ >0 then         -- 3.6
      logger.trace('ELT.OPL 3 ND='||k.ND);
      savepoint DO_PROVODKI_3;
--     declare  err EXCEPTION;
      begin
           GL.REF (REF_);
              NAZN_:='Абонплата за <Кліент-Банк> ';
       if gl.amfo = '353575' then
          NAZN_:='Абонплата за розрахункове обслуговування ';
       end if;
       NAZN_:=substr(NAZN_||' за '||datlit_,1,160)||' '||t_pdv;
       NAZN_:= substr(NAZN_ ||
              ' Угода '||k.CC_ID||' вiд '|| to_char(k.SDATE,'dd/mm/yyyy'),1,160);
       if gl.amfo = '300205' then  -- УПБ
          NAZN_:='Плата за банківські послуги'
                 ||' за '||datlit_||' згідно тарифів банку'; end if;


       begin
       select max(txt) into naznf_ from tnaznf where comm like 'ELT.OPL: NAZN MODE 3.%';
       EXCEPTION WHEN NO_DATA_FOUND THEN naznf_:=NULL;
       end;

       begin
       select e.npk_3570, e.id_glob  into l_npk_3570, l_id_glob
             FROM e_tar_nd n, e_tarif e
       WHERE n.nd=k.ND and n.id=e.id     --and e.npk_3570 is not null
             and rownum=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN l_npk_3570:=null;
       end;

       if l_npk_3570 is null then
          l_nazn:=naznf_;
       else
          l_nazn:='#('||l_npk_3570;  naznf_:=l_nazn||'*';
       end if;

   IF SUBSTR(naznf_,1,2)='#(' THEN -- Dynamic NAZN present

      begin
      naznf_ := Replace( naznf_, ':F_ELT_ND', ELT_nd_);
      naznf_ := Replace( naznf_, ':F_ELT_NDW', ELT_ndw_);
      if ELT_dt_ is not NULL then
      naznf_ := Replace( naznf_, ':F_ELT_DT', ' вiд '||ELT_dt_);
      end if;
      if datlit_ is not NULL then
      naznf_ := Replace( naznf_, ':R_DATE', ' за '||datlit_);
      end if;
      naznf_ := Replace( naznf_, ':F_DATE', ' за '||datlit_f);
 --   if FL_Y=1 then l_ELT_rnk:=''; end if;
 --     l_ELT_rnk:='';
      naznf_ := Replace( naznf_, ':F_ELT_RNK', l_ELT_rnk);
      exception when others then
      logger.error('ELT.OPL 3 довжина naznf='||naznf_);
    raise_application_error(-(20203),'\9350 - naznf_ length '||SQLERRM,TRUE);
      end;

      BEGIN
   --         logger.trace('ELT.OPL 3 naznf='||naznf_);
      EXECUTE IMMEDIATE
        'SELECT '||SUBSTR(naznf_,3,LENGTH(naznf_)-3)||' FROM DUAL' INTO naznf_;
      EXCEPTION
         WHEN OTHERS THEN
         erm:='incorrect SELECT expression p.M3 ';  --ern:=203;
         raise err;
         null;
      END;

      if naznf_ is not NULL and length(naznf_)>10 then
         nazn_:= substr(naznf_,1,160);
      end if;

   END IF;

   INSERT INTO oper (ref, nd, tt, vob, dk, PDAT, VDAT, DATD, DATP,
          s, s2,nam_a, nlsa, mfoa, kv, nam_b, nlsb, mfob, kv2,
          nazn, userid, id_a, id_b)
   VALUES (REF_, case when length(ref_) > 10 then substr(ref_, -10) else to_char(ref_) end,
           l_tt,6, 1,sysdate, gl.bDATE,gl.bDATE,gl.bDATE,
           S_, S_, l_nmsp,l_nlsp, gl.AMFO, n980_, k.NMS3, k.NLS3, gl.AMFO, n980_,
           NAZN_,iD_, k.okpo, k.okpo);

    if l_tt='PKH' then
      l_nlsp:=bpk_get_transit('2O',K.NLS3,l_nlsp,n980_);
    end if;
   GL.PAYV(FL_,REF_,GL.BDATE,l_tt,1,n980_,l_nlsp,S_,n980_,K.NLS3,S_);

   if nvl(n_tar_pak,0) != 0 then ins_operw(ref_,'SHTAR',n_tar_pak); end if;

   ins_operw(ref_,'KTAR',l_id_glob);

  exception
         when err then
            logger.error('ELT.exc err 3 naznf='||naznf_||' '||SQLERRM);
            raise err1;
         when others then rollback to DO_PROVODKI_3;
            logger.error('ELT.exc oth 3 naznf='||naznf_||' '||SQLERRM);
           begin
             insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt ) values
              (GL.BDATE, 36, MODE_, l_nlsp, K.NLS3, S_,STXT_);
      logger.error('ELT.OPL 3.6 Отказ проводки для ND='||k.ND
                  ||' ДТ '||l_nlsp||' КР '||k.NLS3||' S='||S_);
             goto KIN_3;
           end;
  end;

      <<kin_3>> NULL;
---------
   end if;           -- 3.6
   else              -- 3.5      -- погашення з 26_0 по кожнiй угодi окремо
           -- !! станом на 2017 р. даний фрагмент потребує доопрацювання i в Ощадбанку НЕ включений.
       if S_ >0 then     -- 3.7

          S_K:=elt.ROZ_AV (DAT1_, DAT2_, KOL_, k.ND) ;

          if k.SA = S_K then       -- 3.8

          logger.trace('ELT.OPL 3i ND='||k.ND);

          savepoint DO_PROV_3;   SS_:=0; -- по угодi

         FOR d in (SELECT e.NLS6, e.NAME, NVL(e.NDS,pNDS_ ) NDS,
                      round(ELT.Tarif(DAT1_, DAT2_, n.ND, e.id) *
                           elt.RAB_DNI( greatest(n.DAT_BEG,DAT1_),
                                        least(nvl(n.DAT_END,DAT2_ ),DAT2_ )
                                       ) / KOL_, 0)  S,
                   npk_3570
             FROM e_tar_nd n, e_tarif e  WHERE n.nd=k.ND and n.id=e.id )
         LOOP
     if d.S >0 then
 --  declare  err EXCEPTION;
   begin
         SS_:= SS_ + d.S;
--         if d.NDS=0 then t_pdv1:=' без ПДВ.';
--         else            t_pdv1:=' з ПДВ '||d.NDS|| '%.';
--         end if;

            S_NDS_:=0;
            if d.NDS >=1 then
           /* % НДС = NDS. Пропорция имеет вид: d.S - 100+NDS, S_NDS_- NDS */
            S_NDS_:= round( (d.S*d.NDS)/(100+d.NDS) );
            --   S_:= d.S - S_NDS_ ;
            end if;


       if d.NDS=0 then t_pdv1:=' без ПДВ.';
                         t_pdvs:=' без ПДВ.';
         else   t_pdv1:=' з ПДВ '||d.NDS|| '%.';
                t_pdvs:=' з ПДВ '||S_NDS_|| ' грн.';
         end if;


         NAZN_:=d.NAME;
         if gl.amfo = '300205' then  -- УПБ
            NAZN_:=substr(NAZN_||' за '||datlit_,1,160);   -- ||t_pdv1,1,160);
         elsif gl.amfo = '300175' then  -- AGIO
            datlit_:=to_char(datm_,'mm/yyyy')||'р.';
            NAZN_:=substr(NAZN_||' за '||datlit_||t_pdv1,1,160);
            NAZN_:=substr(NAZN_||' Угода '||k.CC_ID||' вiд '||to_char(k.SDATE,'dd/mm/yyyy'),1,160);
         else
            NAZN_:=substr(NAZN_||' за '||datlit_||t_pdv1,1,160);
            NAZN_:=substr(NAZN_||' Угода '||k.CC_ID||' вiд '||to_char(k.SDATE,'dd/mm/yyyy'),1,160);
         end if;

         begin
           select max(txt) into naznf_ from tnaznf where comm like 'ELT.OPL: NAZN MODE 3i.%';
           EXCEPTION WHEN NO_DATA_FOUND THEN naznf_:=NULL;
           end;

         if d.npk_3570 is null then
           l_nazn:=naznf_;
         else
           l_nazn:='#('||d.npk_3570;  naznf_:=l_nazn||'*';
         end if;

   IF SUBSTR(naznf_,1,2)='#(' THEN -- Dynamic NAZN present

      begin
      naznf_ := Replace( naznf_, ':NAME_US', d.name ) ;
      naznf_ := Replace( naznf_, ':PDV', t_pdv1 ) ;
      naznf_ := Replace( naznf_, ':F_ELT_ND', ELT_nd_);
      naznf_ := Replace( naznf_, ':F_ELT_NDW', ELT_ndw_);
      if ELT_dt_ is not NULL then
      naznf_ := Replace( naznf_, ':F_ELT_DT', ' вiд '||ELT_dt_);
      end if;
      if datlit_ is not NULL then
      naznf_ := Replace( naznf_, ':R_DATE', ' за '||datlit_);
      end if;
      naznf_ := Replace( naznf_, ':F_DATE', ' за '||datlit_f);
 --   if FL_Y=1 then l_ELT_rnk:=''; end if;
 --     l_ELT_rnk:='';
      naznf_ := Replace( naznf_, ':F_ELT_RNK', l_ELT_rnk);
      exception when others then
      logger.error('ELT.OPL 3i довжина naznf='||naznf_);
    raise_application_error(-(20203),'\9350 - naznf_ length '||SQLERRM,TRUE);
      end;

      BEGIN
  --          logger.trace('ELT.OPL 3i naznf='||naznf_);
      EXECUTE IMMEDIATE
        'SELECT '||SUBSTR(naznf_,3,LENGTH(naznf_)-3)||' FROM DUAL' INTO naznf_;
      EXCEPTION
         WHEN OTHERS THEN
         erm:='incorrect exp-n p.M3i '; --ern:=203;
         raise err;
      END;

      if naznf_ is not NULL and length(naznf_)>10 then
         nazn_:= substr(naznf_,1,160);
      end if;

   END IF;

            GL.REF (REF_);

--    logger.trace('ELT.oper 3i fl='||fl_||' tt='||l_tt||' BD='||gl.bDATE
--              ||' ref='||ref_);

           INSERT INTO oper (ref, nd, tt, vob, dk, kv, kv2, mfoa, mfob,
                   PDAT, VDAT, DATD, DATP, s, s2,
                   nam_a,nlsa, nam_b, nlsb,  nazn, userid, id_a, id_b)
            VALUES (REF_, case when length(ref_) > 10 then substr(ref_, -10) else to_char(ref_) end,l_tt,6,1,n980_,n980_,gl.AMFO,gl.AMFO,
                    sysdate, gl.bDATE, gl.bDATE, gl.bDATE, d.S, d.S,
                    l_nmsp, l_nlsp, k.NMS3, k.NLS3, NAZN_, iD_, k.okpo, k.okpo);

--    logger.trace('ELT.oper 3i OKPO='||k.okpo||' UID='||iD_||' kv='||n980_);

            GL.PAYV(FL_,REF_,GL.BDATE,l_tt,1,n980_,l_nlsp,d.S,n980_,k.NLS3,d.S);
         exception
         when err then
              logger.info('ELT.exc err 3i naznf='||naznf_);
              raise err1;
         when others then
              logger.info('ELT.exc oth 3i naznf='||naznf_);
              logger.info('ELT.exc oth 3i nazn='||nazn_);
              rollback to DO_PROV_3;
            begin
              insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt )
                    values (GL.BDATE, 36, 1, l_nlsp, k.NLS3, d.S, STXT_ );
    logger.info('ELT.OPL 3 Отказ проводки для ND='||k.ND||' ДТ '||l_nlsp||' КР '||k.NLS3||' S='||d.S);
              goto KIN_3a;
            end;
      end;
      end if;
         end loop;  -- d

     if SS_ != S_K then rollback to DO_PROV_3;
     logger.info('ELT.OPL 3i Расчетная и накопленная сумма НЕ равны для ND='||k.ND);
     end if;

          else
    logger.info('ELT.OPL 3 Расчетная и накопленная сумма НЕ равны для ND='||k.ND);
          end if;    -- 3.8
     <<kin_3a>> NULL;
       end if;   -- 3.7
   end if;   -- reg_g  3.5
  end;
  end if;   -- mode_
     <<kin_k>> NULL;
  exception when others then
    logger.info('ELT.OPL  nd='||k.nd||';  MODE ='|| MODE_ ||' ERROR= '||SQLERRM);
    if l_tt = 'ELA' then
      rollback to DO_O;
    else
      raise_application_error(-20203,'ELT.OPL  nd='||k.nd||';  MODE ='|| MODE_ ||' ERROR= '||SQLERRM);
    end if;
  end;
end loop;   -- k
--commit;
     <<kin_3b>> NULL;

EXCEPTION
   WHEN err THEN
            logger.info('ELT.exc err naznf='||naznf_);
         raise_application_error(-(20000+ern),'\9351 - '||erm||naznf_||' '||SQLERRM,TRUE);
   WHEN err1 THEN
            logger.info('ELT.exc err1 naznf='||naznf_);
         raise_application_error(-(20000+ern),'\9351 - '||erm||naznf_||' '||SQLERRM,TRUE);
   WHEN OTHERS THEN
            logger.info('ELT.exc oth naznf='||naznf_||' pnt='||pnt);
    raise_application_error(-(20000+ern),erm||'  '||SQLERRM,TRUE);


END OPL ;
--------------------------------------


-- Процедура для оплати з БМД (ММФ)
procedure borg_web(p_mode   integer,
                   p_date   varchar2,
                   p_packet integer,
                   p_nls36  varchar2) is
  l_tt       oper.tt%type;
  l_dat1     date;
  l_dat2     date;
  l_kol      integer;
  l_err      varchar2(4000);
begin
  if p_packet = 0 then
   l_tt:='ELA';
  else
  l_tt   := GetGlobalOption('ELT_TT');
  end if;
  l_dat1 := to_date('01' || p_date, 'ddmmyyyy');
  l_dat2 := last_day(l_dat1);
  l_kol  := elt.RAB_DNI(l_dat1, l_dat2);
  borg(p_mode, l_tt, 0, null, p_date, l_dat1, l_dat2, l_kol, p_packet, p_nls36, l_err);
end borg_web;


PROCEDURE BORG
(MODE_ INT,
 TT_      char,
 REZ_     number,
 NLS_PDV_ varchar2,
 mes_     varchar2,
 DAT1_    date,
 DAT2_    date,
 KOL_     int,
 PAKET_   int,
 NLS36_   varchar2 ,
 sErr_ OUT varchar2 ) IS

 S_ number; S_NDS_ number;
 REF_ int ; TXT_ varchar2(80);
 NAZN_ varchar2(180); ID_ int;
 naznf_  varchar2(180);
 l_nazn varchar2(180);   --TNAZNF.txt%TYPE;
 l_npd_3579 varchar2(160); l_npk_3579 varchar2(160);
 FL_ int  ; pNDS_ number;
 STXT_ varchar2(35);
 datm_ date;
 datlit_ varchar2(25);
 datlit_f varchar2(25);
 t_pdv varchar2(12); t_pdv1 varchar2(12);
 pdv5 number; TXT5 varchar2(80);
 nls8_    varchar2(15); nms8_ varchar2(70);  acc8_ int;
 nmkl_    varchar2(35); suf_  varchar2(70);  tmp_  varchar2(30);
 descrname_ varchar2(10); nms8p_ varchar2(70);
 p_mfo_ varchar2(12);
 ELT_ND_ varchar2(20); ELT_DT_ varchar2(10);
 ELT_NDW_ varchar2(50);
 DEB_26_ CHAR(1);
 s180f varchar(1); s240f varchar(1);
 r013f varchar(1); ob22f varchar(2) :=NULL;
 sql_  varchar2(300);
 l_elt_rnk varchar2(38);
 l_nlsp varchar2(15);  l_nmsp varchar2(38); l_ostp number;
 l_segm varchar2(4);
-- n_tar_pak int;
 l_id int; l_ob22n varchar2(2);
 l_tip accounts.tip%type;
 l_tt tts.tt%type;
 l_id_glob e_tarif.id_glob%type;
 pnt int;
 l_ostc8 number;
 l_ostb8 number;
 l_ostc3 number;
 l_ostb3 number;

  PROCEDURE INS_OPERW
  ( p_ref int, p_tag varchar2, p_value varchar2
  ) IS
  BEGIN
    begin
      insert into operw (ref,tag,value) values (p_ref, p_tag, p_value);
    exception
      when dup_val_on_index then null;
    end;
  END INS_OPERW;


BEGIN
 delete from tmp_ovr where id=36;

 if MODE_ = 7 then
       STXT_ :='Стягнути розрах.аванс (3578->3600)';
       TXT_:='' ;
 elsif MODE_ = 8 then
       TXT_:='' ;
       STXT_ :='Закрити заб-ть (26_0->3578/3579)';
 end if;

 -- флаг оплаты из TTS
    l_tt:=TT_;
begin
    select decode (substr(flags,38,1), '1',1,0) into FL_ from tts where tt=l_tt;
    exception  when NO_DATA_FOUND then
    logger.error( 'ELT.BORG  Операція НЕ знайдена '||l_tt);
    erm:='Операція НЕ знайдена '||l_tt;
    raise_application_error(-(20203),'\9350 - Cannot found '||erm||' '||SQLERRM,TRUE);
end;

    datlit_ := ''; datlit_f := '';

 ID_ :=us_id_;      --USER_ID;
 TXT_:= TXT_||' аванс за надання ел.послуг в '|| MES_ ;

    logger.trace('ELT.BORG 0 '|| MODE_||' '||DAT1_||' '||NLS36_||' '||PAKET_ );

  descrname_:='ELT3579';
  if Variant_ = 0 then descrname_:='ELT3578'; end if;

  begin
  SELECT UPPER(nvl(masknms,NULL))
    INTO suf_ FROM nlsmask WHERE UPPER(maskid)=UPPER(descrname_);
  exception when others then suf_:=to_char(null) ;
  end;

for k in (SELECT d.ND, d.CC_ID, d.SDATE, c.OKPO,
                 a3.NLS NLS3, a3.ostc OST3, substr(a3.NMS,1,38) NMS3,
                 a2.NLS NLS2, greatest(0,a2.ostc+NVL(a2.lim,0)) OST2,
                 substr(a2.NMS,1,38) NMS2, d.WDATE,
                 d.SA,
                 p.nls NLS_P, p.ostc OST_P, substr(p.nms,1,38) NMS_P,
                 a8.NLS NLS8, a8.ostc OST8, substr(a8.NMS,1,38) NMS8,
                 a8.ostb OST8P , a3.ostb OST3P,
                 a2.acc, c.rnk, a3.isp, a3.tobo, a3.acc ACC3, a2.kv KV2,
                 a2.tip tip2, p.tip tipp, d.accp, a2.lim
          FROM   e_deal$base d, accounts a3, accounts a2, customer c,
                 accounts a8, accounts p
          WHERE d.kf = SYS_CONTEXT ('bars_context', 'user_mfo')
            and d.rnk    = c.rnk
            and d.acc36  = a3.acc and a3.dazs is null
            and d.acc26  = a2.acc and a2.dazs is null
            and d.accD = a8.acc(+)
            --a8.dazs is null
            and d.accp  = p.acc(+) and p.dazs is null
            and (PAKET_  = 0 or a3.nls= NLS36_)
            and d.sos<>15  -- без закритих угод
            and ((nvl(a3.ostc,0)<0 and MODE_ = 7)
                 or (nvl(a8.ostc,0)<0 and MODE_  = 8))
          order by d.nd
          )
  loop
    logger.info('ELT.BORG  nd='||k.nd||';  MODE ='|| MODE_ ||' begin');
    savepoint DO;  --jeka 07.06.2017
    begin
    l_tt:=TT_; --jeka 06.06.2017  --всегда стартуем с этой операции
     --logger.trace('ELT.BORG k '|| MODE_||' '||DAT1_||' '||k.NLS3||' '||k.nls8 );

    pnt:=0;
    begin
      select substr(VALUE,1,1)
        into DEB_26_
        from CUSTOMERW
       where TAG = 'Y_ELT'
         and RNK = k.RNK
         and VALUE Is Not Null -- = 'N'
         and ROWNUM = 1;
    exception
      when NO_DATA_FOUND then
        DEB_26_:='Y';
    end;

    if to_char(k.wdate,'YYMM')<to_char(bankdate,'YYMM')
    then
      datm_:=dat1_;
    else
      datm_:=bankdate;
    end if;

    datlit_ :=' '||F_Month_lit(datm_,1,4);
    datlit_f:=' '||F_Month_lit(ADD_MONTHS(datm_,+1),1,4);

    ELT_nd_ := F_ELT_nd(k.nls3);
    ELT_dt_ := F_ELT_dt(k.nls3);

    if fl_ndw ='1'
    then
       int_sql:='select '||nm_F_ndw||'('||k.nls3||')'||' from dual';
  --   logger.trace('ELT.int_sql='||int_sql);
       begin
       execute immediate int_sql  into ELT_ndw_;
       exception  when OTHERS then
       ELT_ndw_:='..';
       end;
    else ELT_ndw_:='..';
    end if;
  --   logger.trace('ELT. nls3='||k.nls3||' ndw='||ELT_ndw_);

        l_elt_rnk:='..';
    begin
    select F_ELT_RNK(k.nls2,k.kv2) into l_elt_rnk from dual;
  --  exception  when OTHERS then l_elt_rnk:='';   null;
    end;

    begin  pnt:=1;
       select e.npd_3579, e.npk_3579, id_glob
       into l_npd_3579, l_npk_3579, l_id_glob
             FROM e_tar_nd n, e_tarif e
       WHERE n.nd=k.ND and n.id=e.id and rownum=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN l_npd_3579:=null; l_npk_3579:=null;
    end;

    if l_mfop = '300465' or l_MFO='300465' then
       begin pnt:=2;
         SELECT to_number(translate(trim(w.VALUE),'.',','), '9999D99') into n_tar_pak
         FROM   AccountsW W
         WHERE  w.acc=k.acc
                and w.TAG='SHTAR' and w.VALUE is not null;
         exception when NO_DATA_FOUND then n_tar_pak:=0;
        end;
    end if;
------------
     if MODE_=7 then
       begin
    SELECT  NVL(e.NDS,pNDS_ ), n.id
    into PDV5, l_id
    FROM e_tar_nd n, e_tarif e
    WHERE n.nd=k.ND and n.id=e.id
          and n.DAT_END is NULL and n.DAT_BEG is not NULL   -- and n.otm=1
          and rownum=1;
    exception  when NO_DATA_FOUND THEN pdv5:=0;
       end;

         if k.nls3 like '3600%' then
         TXT5:='Формування частини авансу по абонплаті з рах-ку 3578';
         STXT_:='Стягнути розрах.аванс (3578->3600)';
         else
         TXT5:='Перенесення суми боргу по абонплаті на прострочені';
         STXT_:='Перенести на простроч. (3570->3579)';
         end if;

      S_:= k.SA;
      logger.trace('ELT.BORG 7.1 '||DAT1_||' '||k.nls3||' '||k.OST3 ||' '||k.wdate);

      ----jeka 06.06.2017  добавил по принципу OPL
      begin
      select ostc, ostb into l_ostc3, l_ostb3 from accounts where acc=k.acc3;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        bars_audit.info( $$PLSQL_UNIT || 'OPL:not found acc #' || to_char( k.acc3 ) );
      end;


      --стягнення авансу з р-ку 3578/перенесення на прострочку 3579
      If    MODE_= 7 and /*S_>k.OST3  and k.ost3=k.ost3p */  S_>l_ostc3  and l_ostc3=l_ostb3    -- факт=план
            and DAT1_ > k.WDATE
            and k.nls3 like '3600%'      -- AGIO
            /*and DEB_26_ = 'Y'*/ then   --jeka 26.06.2017 COBUSUPMMFO-840
            S_:= S_- k.OST3;
            datlit_:=' '||F_Month_lit(dat1_,1,4);
      elsif MODE_= 7 and /*k.OST3<0 and k.ost3=k.ost3p  */  l_ostc3<0 and l_ostc3 = l_ostb3   -- факт=план
            and DAT1_ > k.WDATE
            and k.nls3 like '3570%'      -- others
            /*and DEB_26_ = 'Y'*/ then    --jeka 26.06.2017 COBUSUPMMFO-840
            S_:= - k.OST3; -- S_:= least(-k.OST3, k.SA);
            datlit_:=' '||F_Month_lit(ADD_MONTHS(DAT1_,-1),1,4);
            datlit_f:=' '||F_Month_lit(ADD_MONTHS(DAT1_,0),1,4);
      else  S_:= 0;
      end if ;

      if S_ >0 then
-------
    if k.nls8 is NULL then     -- 5
    if newnbs.g_state= 1 then  --переход на новый план счетов

     select substr(F_NEWNMS(NULL,descrname_,NULL,k.rnk,NULL),1,70) into nms8p_  from dual;
        if suf_ is NULL then nms8_:=nms8p_; end if;
          nls8_ := Get_NLS_random  ( '3570'  ) ;  --получение № лиц.сч по случ.числам
          OP_REG(9,0,0,0,tmp_,k.rnk,nls8_,n980_, nms8_,'ODB',k.isp,acc8_);
          p_setAccessByAccMask(acc8_,k.acc);
          update accounts set tobo=k.tobo where acc=acc8_;
          r013f:='1'; s180f:=NULL; s240f:=NULL;

          if l_mfop = '300465' or l_MFO='300465' then     -- Ощадбанк
             r013f:='1'; s180f:='1'; s240f:='1';  ob22f:='38';
          end if;

          if l_mfo = '380764' then     -- НАДРА
             r013f:='1'; s180f:='1'; s240f:='1';  ob22f:='74';
          end if;
          Accreg.setAccountSParam(acc8_, 'R013', r013f);
          Accreg.setAccountSParam(acc8_, 'S180', s180f);
          Accreg.setAccountSParam(acc8_, 'S240', s240f);

          if l_mfo = '380764'
          then      -- НАДРА
            sql_:='select segm from customer where rnk=:rnk';
            begin
              EXECUTE IMMEDIATE sql_ into l_segm USING k.rnk;
            exception when others then
              raise_application_error(-(20203),'\9350 - no table Exist or others '||SQLERRM,TRUE);
            END;

            if l_segm like '1%'
            then ob22f:='75';
            else ob22f:='74';
            end if;

          end if;
            l_ob22n:=f_get_elt_ob22(l_id,'3579');

          if l_ob22n is not null
          then ob22f:=l_ob22n;
          end if;

          Accreg.setAccountSParam( acc8_, 'OB22', ob22f );

          if p_mfo_ is not NULL
          then
            begin
              insert into bank_acc (acc,mfo) values (acc8_,p_mfo_);
            exception
              when others then
                NULL;
            end;
          end if;
     else
      begin
        select substr(decode(nmkk,NULL,nmk,nmkk),1,35)
          into nmkl_
          from customer where rnk=k.rnk;
      EXCEPTION WHEN NO_DATA_FOUND THEN nmkl_:='??';
      end;

      if k.nls3 like '3600%'
      then nls8_ := sb_acc('3578??????????',k.nls3);
      else nls8_ := sb_acc('3579??????????',k.nls3);
      end if;

      nls8_:=VKRZN(SUBSTR(gl.aMFO,1,5),nls8_);
      nms8_:=TRIM(SUBSTR(suf_||':'||nmkl_,1,70));
      -- logger.trace('ELT.BORG 7.11 '||k.nls3||' '||nls8_||' '||nms8_||' '||descrname_);
      begin

        select substr(F_NEWNMS(NULL,descrname_,NULL,k.rnk,NULL),1,70) into nms8p_  from dual;

        if suf_ is NULL then nms8_:=nms8p_; end if;

      EXCEPTION
        WHEN OTHERS THEN NULL;
      end;

      begin
        select mfo into p_mfo_
          from bank_acc where acc=k.acc3;
      EXCEPTION WHEN NO_DATA_FOUND THEN p_mfo_:=NULL;
      end;

      -- logger.trace('ELT.BORG 7.12 '||k.nls3||' '||nls8_||' '||nms8_);

      BEGIN
        SELECT acc, nms
          INTO acc8_, nms8_
          FROM accounts
         WHERE nls=nls8_ AND kv=n980_;    ---AND dazs IS NULL;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN    pnt:=71;

          OP_REG(9,0,0,0,tmp_,k.rnk,nls8_,n980_, nms8_,'ODB',k.isp,acc8_);

          p_setAccessByAccMask(acc8_,k.acc);

          update accounts set tobo=k.tobo where acc=acc8_;

          r013f:='1'; s180f:=NULL; s240f:=NULL;

          if l_mfop = '300465' or l_MFO='300465' then     -- Ощадбанк
             r013f:='1'; s180f:='1'; s240f:='1';  ob22f:='24';
          end if;

          if l_mfo = '380764' then     -- НАДРА
             r013f:='1'; s180f:='1'; s240f:='1';  ob22f:='74';
          end if;

          /***
          begin
            insert into specparam (acc,r013,s180,s240)
            values (acc8_,r013f,s180f,s240f);
          exception when others then
            NULL;
          end;
          ***/

          --Accreg.setAccountSParam( p_acc, k.tag, l_val);

          Accreg.setAccountSParam(acc8_, 'R013', r013f);
          Accreg.setAccountSParam(acc8_, 'S180', s180f);
          Accreg.setAccountSParam(acc8_, 'S240', s240f);

          if l_mfo = '380764'
          then      -- НАДРА

            sql_:='select segm from customer where rnk=:rnk';

            begin
              EXECUTE IMMEDIATE sql_ into l_segm USING k.rnk;
            exception when others then
              raise_application_error(-(20203),'\9350 - no table Exist or others '||SQLERRM,TRUE);
            END;

            if l_segm like '1%'
            then ob22f:='75';
            else ob22f:='74';
            end if;

          end if;

          l_ob22n:=f_get_elt_ob22(l_id,'3579');

          if l_ob22n is not null
          then ob22f:=l_ob22n;
          end if;

          Accreg.setAccountSParam( acc8_, 'OB22', ob22f );

          if p_mfo_ is not NULL
          then
            begin
              insert into bank_acc (acc,mfo) values (acc8_,p_mfo_);
            exception
              when others then
                NULL;
            end;
          end if;

      END;
     end if;
      update E_DEAL set NLS_D=nls8_ where nd=k.nd;

    else

      nls8_:=k.nls8; nms8_:=k.nms8;

    end if;      -- 5

    savepoint DO_PROVODKI_7;

    begin
           GL.REF (REF_);
   --      logger.trace('ELT.BORG 7.2 '||nls8_||' '|| S_||' '||REF_);

           NAZN_:=substr(TXT5||' за '||datlit_,1,160);

    if gl.amfo = '300205' then     -- УПБ
       NULL;
    else
           NAZN_:=substr(NAZN_||'. Угода '||k.CC_ID||' вiд '||
                         to_char(k.SDATE,'dd/mm/yyyy'),1,160);
    end if;

         begin
           select max(txt) into naznf_ from tnaznf where comm like 'ELT.BORG: NAZN MODE 7.%';
           EXCEPTION WHEN NO_DATA_FOUND THEN naznf_:=NULL;
           end;

        if l_npd_3579 is null then
           l_nazn:=naznf_;
        else
           l_nazn:='#('||l_npd_3579;     --l_nazn:=l_nazn||':R_DATE';
           naznf_:=l_nazn||'*';
        end if;

   IF SUBSTR(naznf_,1,2)='#(' THEN -- Dynamic NAZN present

      begin
      naznf_ := Replace( naznf_, ':F_ELT_ND', ELT_nd_);
      if ELT_dt_ is not NULL then
      naznf_ := Replace( naznf_, ':F_ELT_DT', ' вiд '||ELT_dt_);
      naznf_ := Replace( naznf_, ':F_ELT_NDW', ELT_ndw_);
      end if;
      if datlit_ is not NULL then
      naznf_ := Replace( naznf_, ':R_DATE', ' за '||datlit_);
      end if;
      naznf_ := Replace( naznf_, ':F_DATE', ' за '||datlit_f);
 --   if FL_Y=1 then l_ELT_rnk:=''; end if;
 --     l_ELT_rnk:='';
      naznf_ := Replace( naznf_, ':F_ELT_RNK', l_ELT_rnk);
      exception when others then
      logger.error('ELT.BORG 7 довжина naznf='||naznf_);
    raise_application_error(-(20203),'\9350 - naznf_ length '||SQLERRM,TRUE);
      end;

      BEGIN
      EXECUTE IMMEDIATE
        'SELECT '||SUBSTR(naznf_,3,LENGTH(naznf_)-3)||' FROM DUAL' INTO naznf_;
      EXCEPTION
         WHEN OTHERS THEN
       raise_application_error(-(20203),'\9350 - expression is incorrect via '||naznf_||' '||SQLERRM,TRUE);
         naznf_:=NULL;
         null;
      END;

      if naznf_ is not NULL and length(naznf_)>10 then
         nazn_:= substr(naznf_,1,160);
      end if;

   END IF;

      nms8_:=substr(nms8_,1,38);

      logger.trace('ELT.BORG 7.20 '||nazn_||' '||REF_);

INSERT INTO oper (ref, nd, tt, vob, dk, PDAT, VDAT, DATD, DATP,
                  s, s2,nam_a, nlsa, mfoa, kv, nam_b, nlsb, mfob, kv2,
                  nazn, userid, id_a, id_b)
VALUES (REF_, case when length(ref_) > 10 then substr(ref_, -10) else to_char(ref_) end,
     l_tt,6, 1,sysdate, gl.bDATE,gl.bDATE,gl.bDATE,
     S_, S_, NMS8_, NLS8_, gl.AMFO, n980_, k.NMS3, k.NLS3, gl.AMFO, n980_,
     NAZN_,iD_, k.okpo, k.okpo);

      logger.trace('ELT.BORG 7.21 '||nls8_||' '|| S_||' '||REF_||' '||nms8_);

           GL.PAYV(FL_,REF_,GL.BDATE,l_tt,1,n980_,NLS8_,S_,n980_,K.NLS3,S_);
   --    logger.trace('ELT.BORG 7.22 '||nls8_||' '|| S_||' '||REF_);
         exception when others then rollback to DO_PROVODKI_7;
           begin
      -- ! пишем протокол при сбое оплаты по ФАКТУ
             insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt )
                    values (GL.BDATE, 36, MODE_, NLS8_, K.NLS3, S_,STXT_);
      logger.error('ELT.BORG 7 отказ TMP_OVR '||mode_
                    ||' '||nls8_||' '||k.nls3||' '|| S_||' '||REF_||' pnt='||pnt);
             goto KIN_7;
           end;
         end;
   --    logger.trace('ELT.BORG 7.3 '|| nls8_||' '||S_||' '||REF_||'+');

      end if;
      <<kin_7>> NULL;
---------
   elsif MODE_ =8
         and NVL(k.ost8,0) < 0
         and k.nls8 is not NULL then
      --пересчитываем остатки по 26*  --COBUMMFO-4069
      k.ost2:=  greatest(0,fost(k.acc,bankdate)+NVL(k.lim,0));
      if k.accp is not null then
       k.ost_p:= greatest(0,nvl(fost(k.accp,bankdate),0));
      else k.ost_p:= 0;
      end if;

      l_nlsp:=k.nls2; l_nmsp:=k.nms2; l_ostp:=k.ost2; l_tip:=k.tip2;
      if k.nls_p is not null then
         l_nlsp := k.nls_p; l_nmsp := k.nms_p; l_ostp:=k.ost_p; l_tip:=k.tipp;
      end if;

      S_:=0;   -- S_:= k.SA;
 --    logger.trace('ELT.BORG 8.1 '||k.nls8||' '||k.ost8);

      ----jeka 06.06.2017  добавил по принципу OPL
      begin
      select ostc, ostb into l_ostc8, l_ostb8 from accounts where nls=k.NLS8;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        bars_audit.info( $$PLSQL_UNIT || 'OPL:not found acc #' || to_char( k.NLS8) );
      end;

     -- стягнення заборгованостi з р/р клiента
      If    MODE_= 8 and /*k.OST8<0*/ l_ostc8<0 and l_ostc8 = l_ostb8 and k.OST8=k.OST8P and l_ostp>0 ----jeka 06.06.2017
            and (k.nls_p != k.nls3 or k.nls_p is NULL)
            and DEB_26_ = 'Y' then
            S_:= least(-k.OST8, l_ostp) ;
      else  S_:= 0;
      end if ;
 --     logger.trace('ELT.BORG 8.2 '||k.ost8||' '||S_);

      if k.nls_p is NULL and k.kv2!=980 then S_:=0; end if;

      if S_ >0 then

         savepoint DO_PROVODKI_8;

         datlit_:=' '||F_Month_lit(ADD_MONTHS(DAT1_,-1),1,4);
         datlit_f:=' '||F_Month_lit(ADD_MONTHS(DAT1_,+0),1,4);

         if l_tip='W4A' then l_tt:='PKH'; end if;

         begin
           GL.REF (REF_);
   --      logger.trace('ELT.BORG 8.3 '||k.ost8||' '||S_||' '|| REF_);

        NAZN_:='Погашення простр.заборгованості по абонплаті';
        if k.nls3 like '3600%' then
              NAZN_:='Погашення заб-ті по р-ку 3578';
         else
             if gl.amfo = '300205' then
             NAZN_:='Погашення простр.заборгованості за банківські послуги';
             end if;
         end if;

         begin
           select max(txt) into naznf_ from tnaznf where comm like 'ELT.BORG: NAZN MODE 8.%';
           EXCEPTION WHEN NO_DATA_FOUND THEN naznf_:=NULL;
         end;

        if l_npk_3579 is null then
           l_nazn:=naznf_;
        else
           l_nazn:='#('||l_npk_3579;      --l_nazn:=l_nazn||':R_DATE';
           naznf_:=l_nazn||'*';
        end if;

   IF SUBSTR(naznf_,1,2)='#(' THEN -- Dynamic NAZN present

      begin   pnt:=83;
      naznf_ := Replace( naznf_, ':F_ELT_ND', ELT_nd_);
      if ELT_dt_ is not NULL then
      naznf_ := Replace( naznf_, ':F_ELT_DT', ' вiд '||ELT_dt_);
      naznf_ := Replace( naznf_, ':F_ELT_NDW', ELT_ndw_);
      end if;
      if datlit_ is not NULL then
      naznf_ := Replace( naznf_, ':R_DATE', ' за '||datlit_);
      end if;
      naznf_ := Replace( naznf_, ':F_DATE', ' за '||datlit_f);
 --   if FL_Y=1 then l_ELT_rnk:=''; end if;
 --     l_ELT_rnk:='';
      naznf_ := Replace( naznf_, ':F_ELT_RNK', l_ELT_rnk);
      exception when others then
      logger.error('ELT.BORG 8 довжина naznf='||naznf_);
    raise_application_error(-(20203),'\9350 - naznf_ length '||SQLERRM,TRUE);
      end;

      BEGIN
      EXECUTE IMMEDIATE
        'SELECT '||SUBSTR(naznf_,3,LENGTH(naznf_)-3)||' FROM DUAL' INTO naznf_;
      EXCEPTION
         WHEN OTHERS THEN
       raise_application_error(-(20203),'\9350 - expression is incorrect via '||naznf_||' '||SQLERRM,TRUE);
         naznf_:=NULL;
         null;
      END;

      if naznf_ is not NULL and length(naznf_)>10 then
         nazn_:= substr(naznf_,1,160);
      end if;

   END IF;     pnt:=84;

    --  logger.trace('ELT.BORG 8.31 '||nazn_||' '||REF_);

      INSERT INTO oper (ref, nd, tt, vob, dk, PDAT, VDAT, DATD, DATP,
                        s, s2,nam_a, nlsa, mfoa, kv, nam_b, nlsb, mfob, kv2,
                        nazn, userid, id_a, id_b)
      VALUES (REF_, case when length(ref_) > 10 then substr(ref_, -10) else to_char(ref_) end,
         l_tt,6, 1,sysdate, gl.bDATE,gl.bDATE,gl.bDATE,
         S_, S_, l_nmsp,l_nlsp, gl.AMFO, n980_, k.NMS8, k.NLS8, gl.AMFO, n980_,
         NAZN_,iD_, k.okpo, k.okpo);

    --  logger.trace('ELT.BORG 8.32 '||k.nls8||' '|| S_||' '||REF_||' '||k.nms8);

    if l_tt='PKH' then
      l_nlsp:=bpk_get_transit('2O',K.NLS8,l_nlsp,n980_);
    end if;

     GL.PAYV(FL_,REF_,GL.BDATE,l_tt,1,n980_,l_nlsp,S_,n980_,K.NLS8,S_);

    if nvl(n_tar_pak,0) != 0 then ins_operw(ref_,'SHTAR',n_tar_pak); end if;

  exception when others then rollback to DO_PROVODKI_8;
           begin
             insert into TMP_OVR (DAT, ID, DK, NLSA, NLSB, S, txt )
             values              (GL.BDATE, 36, MODE_, l_nlsp, K.NLS8, S_,STXT_);
             logger.error('ELT.BORG 8 отказ TMP_OVR '||mode_||' '||l_nlsp||' '||
                    k.nls8||' '|| S_||' '||REF_||' pnt='||pnt);
             goto KIN_8;
           end;
  end;
  --     logger.trace('ELT.BORG 8.4 '||k.ost8||' '||S_||' '|| REF_||'+');

      end if;
      <<kin_8>> NULL;
---------
   end if;
  exception when others then
    logger.info('ELT.BORG  nd='||k.nd||';  MODE ='|| MODE_ ||' ERROR= '||SQLERRM);
    if l_tt = 'ELA' then
      rollback to DO;
    else
      raise_application_error(-20203,'ELT.BORG  nd='||k.nd||';  MODE ='|| MODE_ ||' ERROR= '||SQLERRM);
    end if;
  end;
end loop;
--commit;
END BORG;
--------------------------------------
--------------
PROCEDURE shnel
( DAT1_ date, DAT2_ date, KOL_ int, sErr_ OUT varchar2 ) is
-- для ускорения по населению в режиме "з розрах авансом"
 S_ number; l_kol int;
begin
 logger.info('ELT Shnel start '||DAT1_||' '||DAT2_||' '||KOL_||' '
                               ||to_char(sysdate,'ddmmyy,hh:mi:ss'));

 l_kol:=0;
 if DAT1_ is not NULL and DAT2_ is not NULL then
    l_kol := DAT2_ - DAT1_ + 1;
 end if;
 if l_kol = 0 or l_kol > 31 then goto ex_10; end if;

 if KOL_ is not NULL and KOL_ > 0 and KOL_ <= 31 then
 update E_DEAL
        set SA = elt.ROZ_AV (DAT1_, DAT2_, KOL_, ND)
        where sos<>15;
 commit;
 end if;
 <<ex_10>> NULL;
 logger.info('ELT Shnel finish '|| to_char(sysdate,'ddmmyy,hh:mi:ss'));

end shnel ;

  --
  -- OPN_ACNT ( відкриття рахунку )
  --
  procedure OPN_ACNT
  ( p_nd           in     integer
  , p_acc2600      in     accounts.acc%type
  , p_nls3570      in     accounts.nls%type
  ) is
    title    constant     varchar2(60)  := $$PLSQL_UNIT||'.OPN_ACNT';
    l_usr_mfo             varchar(6);
    l_tmp                 integer;
    l_acc                 accounts.acc%type;
    l_nls                 accounts.nls%type;
    l_980                 accounts.kv%type;
    l_nms                 accounts.nms%type;
    l_rnk                 accounts.rnk%type;
    l_ob22                accounts.ob22%type;
    l_nmk                 customer.nmk%type;
    l_r013                specparam.r013%type;
    l_s240                specparam.s240%type;
    l_s180                specparam.s180%type;
    l_isp                 accounts.isp%type;
    l_grp                 accounts.grp%type;
    l_branch              accounts.branch%type;
    l_mfo                 bank_acc.mfo%type;
  begin

    bars_audit.trace( '%s: Entry with ( p_nd=%s, p_acc2600=%s, p_nls3570=%s ).'
                    , title, to_char(p_nd), to_char(p_acc2600), p_nls3570 );

    l_usr_mfo := BARS.GL.AMFO;
    l_980     := BARS.GL.BASEVAL;

    select a.RNK, a.ISP, a.GRP, a.BRANCH, b.MFO, nvl(c.NMKK,c.NMK)
      into l_rnk, l_isp, l_grp, l_branch, l_mfo, l_nmk
      from ACCOUNTS a
      join CUSTOMER c
        on ( c.RNK = a.RNK )
      left
      join BANK_ACC b
        on ( b.ACC = a.ACC )
     where a.KF  = l_usr_mfo
       and a.ACC = p_acc2600;

    if ( p_nls3570 Is Null )
    then
      l_nls := BARS.F_NEWNLS2( null, 'ELT', '3570', l_rnk, null, l_980 );
    else

      begin
        select ACC
          into l_acc
          from BARS.ACCOUNTS
         where KF  = l_usr_mfo
           and NLS = p_nls3570
           and KV  = l_980
           and RNK = l_rnk
           and nvl(OB22,'02') in ( select unique nvl(t.OB22_3570,'02')
                                     from BARS.E_TAR_ND d
                                     join BARS.E_TARIF  t
                                       on ( t.ID = d.ID )
                                    where d.ND = p_nd
                                      and t.OB22_3570 <> '03' -- РКО
                                 )
           and DAZS is Null;
      exception
        when NO_DATA_FOUND then
          l_acc := null;
          l_nls := p_nls3570;
      end;

    end if;

    If ( l_acc Is Null )
    then -- відкриваємо

      l_nls := BARS.VKRZN( SubStr(l_usr_mfo,1,5), SubStr(l_nls,1,14) );

      l_nms := BARS.F_NEWNMS( Null,'ELT', '3570', l_rnk, Null );

      l_nms := SubStr(nvl(l_nms,'Абонплата '||l_nmk), 1, 70 );

      OP_REG_EX( mod_  => 9
               , p1_   => 0
               , p2_   => 0
               , p3_   => l_grp
               , p4_   => l_tmp
               , rnk_  => l_rnk
               , nls_  => l_nls
               , kv_   => l_980
               , nms_  => l_nms
               , tip_  => 'ODB'
               , isp_  => l_isp
               , accR_ => l_acc
               , tobo_ => l_branch );

      if ( l_nls like '3570%' )
      then

        l_s240 := '1';
        l_s180 := '1';
        l_r013 := '2';

        If ( l_usr_mfo = '380764' )
        then -- НАДРА

          execute immediate q'[select case SubStr(SEGM,1,1) when '1' then '05' when '2' then '09' else '02' end]'||
                            q'[  from BARS.CUSTOMER where RNK = :l_rnk]'
             into l_ob22
            using l_rnk;

        else -- Ощадбанк

          begin

            select unique OB22_3570
              into l_ob22
              from BARS.E_TAR_ND d
              join BARS.E_TARIF  t
                on ( t.ID = d.ID )
             where d.ND = p_nd
--             and t.OB22_3570 is not null
--             and rownum = 1
            ;

            if ( l_ob22 Is Null )
            then
              raise_application_error( -20666, 'Не вказано значення ОБ22 для тарифу!' );
            end if;

          exception
            when NO_DATA_FOUND then
              -- l_ob22 := '02';
              raise_application_error( -20666, 'Не вказано тариф для договору!' );
            when TOO_MANY_ROWS then
              raise_application_error( -20666, 'Вказано тарифи з різними значеннями ОБ22!' );
          end;

        end if;

      end if;

      bars_audit.trace( '%s: ( ACC=%s, R013=%s, S240=%s, S180=%s, OB22=%s ).', title
                      , to_char(l_acc), l_r013, l_s240, l_s180, l_OB22 );

      --
      /***
      insert
        into BARS.SPECPARAM
           ( ACC, R013, S240, S180 )
      values
           ( l_acc, l_r013, l_s240, l_s180 );

      ***/

          Accreg.setAccountSParam(l_acc, 'R013', l_r013);
          Accreg.setAccountSParam(l_acc, 'S180', l_s180);
          Accreg.setAccountSParam(l_acc, 'S240', l_s240);

      Accreg.setAccountSParam( l_acc, 'OB22', l_OB22 );

      --
      If ( l_mfo Is Not Null )
      then

        update BARS.BANK_ACC
           set mfo = l_mfo
         where acc = l_acc;

        if ( sql%rowcount = 0 )
        then
          insert
            into BARS.BANK_ACC ( ACC, MFO )
          values ( l_acc, l_mfo );
        end if;

      end if;

      p_setAccessByAccMask( l_acc, p_acc2600 );

      -- SEC.addagrp( l_acc, T0.pGr );

    end if;

    If ( l_acc Is Not Null )
    then
      update BARS.E_DEAL$BASE
         set ACC36 = l_acc
       where ND    = p_nd;
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end OPN_ACNT;

  --
  --
  --
  procedure SET_TARIFF
  ( p_nd           in     e_tar_nd.nd%type
  , p_id           in     e_tar_nd.id%type
  , p_active       in     e_tar_nd.otm%type
  , p_amnt         in     e_tar_nd.sumt%type
  , p_end_dt       in     e_tar_nd.dat_end%type
  , p_idv_trf      in     e_tar_nd.sumt1%type
  , p_beg_dt       in     e_tar_nd.dat_beg%type
  , p_exmpt_beg_dt in     e_tar_nd.dat_lb%type
  , p_exmpt_enf_dt in     e_tar_nd.dat_le%type
  , p_incm_amnt    in     e_tar_nd.s_porog%type
  , p_trf1_amnt    in     e_tar_nd.s_tar_por1%type
  , p_trf2_amnt    in     e_tar_nd.s_tar_por2%type
  ) is
    title    constant     varchar2(60)  := $$PLSQL_UNIT||'.SET_TARIFF';
    l_qty                 number(1);
  begin

    bars_audit.trace( '%s: Entry with ( p_nd=%s, p_id=%s, p_active=%s ).'
                    , title, to_char(p_nd), to_char(p_id), to_char(p_active) );

    update E_TAR_ND
       set OTM        = p_active
         , SUMT       = p_amnt
         , DAT_BEG    = p_beg_dt
         , DAT_END    = p_end_dt
         , SUMT1      = p_idv_trf
         , DAT_LB     = p_exmpt_beg_dt
         , DAT_LE     = p_exmpt_enf_dt
         , S_POROG    = p_incm_amnt
         , S_TAR_POR1 = p_trf1_amnt
         , S_TAR_POR2 = p_trf2_amnt
     where ND = p_nd
       and ID = p_id;

    if ( sql%rowcount = 0 )
    then

      insert
        into E_TAR_ND
           ( ND, ID, OTM, DAT_BEG, DAT_END, SUMT
           , SUMT1, DAT_LB, DAT_LE, S_POROG, S_TAR_POR1, S_TAR_POR2 )
      values
           ( p_nd, p_id, p_active, p_beg_dt, p_end_dt, p_amnt
           , p_idv_trf, p_exmpt_beg_dt, p_exmpt_enf_dt, p_incm_amnt, p_trf1_amnt, p_trf2_amnt );

      select count( unique OB22_3570 ) -- unique values (ignore null)
        into l_qty
        from BARS.E_TAR_ND d
        join BARS.E_TARIF  t
          on ( t.ID = d.ID )
       where d.ND = p_nd;

      if ( l_qty > 1 )
      then
        raise_application_error( -20666, 'Заборонено вказувати тарифи з різними значеннями ОБ22!' );
        -- або відкриття рах. 3570 з новим ОБ22...
      end if;

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SET_TARIFF;

  --
  --
  --
  procedure DEL_TARIFF
  ( p_nd           in     e_tar_nd.nd%type
  , p_id           in     e_tar_nd.id%type
  ) is
    title    constant     varchar2(60)  := $$PLSQL_UNIT||'.DEL_TARIFF';
  begin

    bars_audit.trace( '%s: Entry with ( nd=%s, id=%s ).', title, to_char(p_nd), to_char(p_id) );

    delete BARS.E_TAR_ND
     where ND = p_nd
       and ID = p_id
       and nvl(OTM,0) = 0;

    if ( sql%rowcount = 0 )
    then
      bars_audit.trace( '%s: tariff deleted.', title );
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end DEL_TARIFF;

BEGIN

  JAN1_:= ADD_MONTHS (LAST_DAY(bankdate),-1)+1;

  logger.trace('ELT  '||'JAN1_='|| JAN1_);

  select val into OKPO_ from params where par='OKPO';

  select gl.aUID into us_id_ from dual;

  -- % НДС из PARAMS
  begin
  select NVL(to_number(VAL), 0) into pNDS_ from params where par='ELT_NDS';
  exception  when NO_DATA_FOUND THEN pNDS_:=0;
  end ;

  begin
    select NVL(VAL,'0') into Variant_s from params where par='ELT_VAR';
  exception
    when NO_DATA_FOUND THEN Variant_s:='0';
  end ;

  Variant_  := 0;

    descrname_:='ELT3579';
    if Variant_s = '0' then descrname_:='ELT3578'; end if;

     Variant_ :=0;
  if Variant_s = '1' then
     Variant_:=1;
  elsif Variant_s='2' then
     Variant_:=2;
  elsif Variant_s='UPB' then
     Variant_:=2;
  elsif Variant_s='3' then
     Variant_:=3;
  end if;

  -- Вичитуємо ф-ію для визначення ГЛОБАЛЬНОГО рах-ку ПДВ
  begin
    select max(txt) into G_PDV_sql from tnaznf where comm like 'ELT.OPL: G_PDV глобал%';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN G_PDV_sql:=NULL;
  end;

  if g_pdv_sql is not NULL
  then
    begin
      execute immediate g_pdv_sql  into g_pdv;
      logger.info( 'ELT. Глоб.рах.ПДВ='||g_pdv);
    exception
      when OTHERS then
        logger.error( 'ELT. incorrect SQL expr.- глоб.рах.ПДВ '||g_pdv_sql);
        g_pdv:='36220';
    end;
  end if;

  -- Вичитуємо ф-ію для визначення ІНДИВІДУАЛЬНОГО рах-ку ПДВ
  begin
    select max(txt)
      into G_PDV_sql
      from tnaznf
     where comm like 'ELT.OPL: L_PDV локал%';
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      G_PDV_sql := NULL;
  end;

  bars_audit.trace( 'ELT. SQL-для інд.рах.ПДВ '||G_PDV_sql);

 /****************
 -- контрольний виклик прописаної формули
   if g_pdv_sql is not NULL  then
      l_ff:=g_pdv_sql;
      l_ff:= Replace(l_ff,':ACC',0);
      begin
      execute immediate l_ff  into l_pdv;
   --   logger.info( 'ELT. SQL- для інд.рах.ПДВ '||l_ff);
      exception  when OTHERS then
      logger.error( 'ELT. incorrect SQL expr. - '||l_ff);
      l_pdv:='0000';  fl_l_pdv:=9;
      end;
   end if;
  ******************/

  -- можлива зовнішня ф-ія додаткового контролю (по заявці Демарка)
  begin
    select trim(VAL) into N_Func_ from params where par='ELT_FUNC';
  exception
    when NO_DATA_FOUND THEN N_Func_:=NULL;
  end ;

  logger.info('ELT '||'N_Func_='|| N_Func_ );

  -- можлива зовнішня ф-ія контролю умов стягнення (погашення)
  begin
  select trim(VAL) into F_CH_GASH from params where par='ELT_GASH';
         exception  when NO_DATA_FOUND THEN F_CH_GASH:=NULL;
  end ;

  -- Вичитуємо ф-ію для визначення інд-го рах-ку ПДВ  -- !! для філій Ощадбанку
  begin
    select trim(VAL) into PDV_Func_ from params where par='PDV_FUNC';
  exception
    when NO_DATA_FOUND THEN PDV_Func_:=NULL;
  end ;

  logger.trace('ELT '||'PDV_Func_='|| PDV_Func_ );

  -- Перевірка наявності ф-ії додреквізитів  (заявка УПБ)
  nm_F_ndw:='F_ELT_NDW';
  int_sql:='select '||nm_F_ndw||'(''35700'')'||' from dual';

  begin
    execute immediate int_sql into l_ndw;
  exception  when OTHERS then
    logger.info( 'ELT. incorrect SQL expr.- Ф-ія додреквізитів '||int_sql);
    fl_ndw:='0'; l_ndw:='0';
  end;

END ELT;
/
