

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_23_OB22.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_23_OB22 ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_23_OB22 (dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null,nal_  varchar2)  IS

/* РУ+ГОУ          Версия 3.0 13-06-2017  17-03-2017 23-11-2016  29-07-2016 27-07-2016  18-05-2016

10) 23-06-2017  -   Оплата через процедуру gl.payv вместо paytt
 9) 17-03-2017  -   R013 по  1590,1592,2400,2401,3590 не зависит от категории риска
 8) 23-11-2016 LUDA РНК для 7 класса или с любого существующего бал. счета , если не нашла то 1||код региона
 7) 22-11-2016 LUDA Вернула БРАНЧ при открытии клиента (Ошибка в ВЭБ CANNOT INSERT NULL INTO ("BARS"."CUSTOMER"."TOBO") )
 6) 29-07-2016 LUDA Dat_last --> Dat_last_work
 5) 27-07-2016 LUDA При открытии 7 кл. было РНК=1 --> RNK_b
 4) 27-07-2016 LUDA Убрала БРАНЧ при открытии клиента (ЗАЧЕМ? сама не помню)
 3) 18-05-2016 LUDA Клиент+счета по странам риска (для отчетности)
 2) 13-05-2016 LUDA Номер счета по маске
 1) 24-02-2016 LUDA Формирование проводок по ФАКТУ (параметр REZ_PAY)
------------------ 13-01-2016
13-01-2016         Update DAOS только если оно >= 01-01-YYYY
06-01-2016         Тип операции только ARE (AR* - убрала)
04-01-2016         Уточнено Назначение платежа и наименование клиента
10-12-2015    LUDA Добавлена возможность сформировать резерв по одному договору
                   (используется при переносе кредитов).
------------------ 18.09.15
31-07-2015    LUDA Добавлен новый вид nal = 5 - включается в налоговый
                   для нач.% (r013 = 5 - после 30 дней)
08-06-2015    LUDA Назначение платежа для 2401 уточнено
08-06-2015    LUDA NLS_ - 14 знаков
08-06-2015    LUDA Счета по ценным бумагам новые
27-03-2015    LUDA Убрала отметку о выполнении проводок (REZ_PROTOCOL) в PAY_23
25-02-2015    LUDA Убрала k.r_acc:=acc_  в строке 458.
16-12-2014    LUDA Добавлена колонка REF в таблицу REZ_DOC_MAKET
10-12-2014    LUDA Не формировались проводки по вновь открытым счетам - исправила
25-11-2014    LUDA Добавлен портфельный метод
25-11-2014    LUDA При открытии счетов 1890,2890,3590 карточка клиента (custtype=1-банк)
07-11-2014    LUDA Реанимация 7 класса если счет закрыт.
05-11-2014    LUDA Вставила   PUL_dat(sdat01_,'')
22-04-2014    LUDA Единая программа формирования проводок в СБЕРБАНКЕ для
                   региолнальных управлений и ГОУ
18-04-2014    LUDA Не везде проставлялся R013
27-02-2014    LUDA Обновлялась дата открытия при изменении БРАНЧА
                   (дата открытия проставляется последний рабочий
                    день месяца только для вновь открываемых счетов)
21-01-2014    LUDA Единая программа формирования проводок в СБЕРБАНКЕ для
                   региолнальных управлений и ГОУ

   Mode_= 0 - с проводками
        = 1 - Макет проводок

   nal_ = 0 - Не врах.в податковий облік {индивидуал.}(для нарах.% не погаш. < 30 днів) +ЦП
        = 1 - Врах.   в податковий облік {индивидуал.}(для нарах.% не погаш. < 30 днів)
        = 2 - АРЖК
        = 5 - Врах.   в податковий облік {индивидуал.}(для нарах.% не погаш. > 30 днів)
        = 6 - Не врах.в податковий облік {индивидуал.}(для нарах.% не погаш. > 30 днів)
        = 7 - Цінні папери      (для нарах.% не погаш. >30 днів)
        = 8 - Портфельний метод (Врах.   в податковий облік)
        = 9 - Портфельний метод (Не врах.в податковий облік)
        = A - Не врах.в податковий облік {портфельный}(для нарах.% не погаш. < 30 днів)
        = B - Врах.   в податковий облік {портфельный}(для нарах.% не погаш. < 30 днів)
        = C - Врах.   в податковий облік {портфельный}(для нарах.% не погаш. > 30 днів)
        = D - Не врах.в податковий облік {портфельный}(для нарах.% не погаш. > 30 днів)

*/
  doform_nazn           varchar2(100);
  doform_nazn_korr      varchar2(100);
  doform_nazn_korr_year varchar2(100);

  rasform_nazn           varchar2(100);
  rasform_nazn_korr      varchar2(100);
  rasform_nazn_korr_year varchar2(100);

  par        NBS_OB22_PAR_REZ%rowtype;
  b_date     date;  dat31_     date;
  vv_        int ;  p4_        int;
  l_MMFO     int ;
  l_day_year NUMBER;  r7702_acc  number;  mon_       NUMBER;  year_      NUMBER;  vob_       number;  otvisp_    number;  fl         number(1);
  s_old_     number;  s_old_q    number;  s_new_     number;  s_val_     number;  userid_    number;  l_user     number;  diff_      number;
  ref_       number;  nn_        number;  l_rez_pay  number;  l_pay      number;  REZPROV_   NUMBER   DEFAULT 0;
  r7702_     varchar2(20);  nazn_      varchar2(500);  tt_        varchar2(3)   ; nam_a_     varchar2(50);  nam_b_     varchar2(50);  r7702_bal  varchar2(50);
  kurs_      varchar2(500); okpoa_     varchar2(14) ;  error_str  varchar2(1000); ru_        varchar2(50);  sdat01_    char(10);
  l_absadm   staff$base.logname%type;   GRP_   accounts.grp%type:= 21;  rnk_b      accounts.rnk%type;  acc_       accounts.acc%type ;  nls_       accounts.nls%type;
  maska_     accounts.nls%type      ;  isp_    accounts.isp%type     ;  nms_       accounts.nms%type;  l_acc      accounts.acc%type ;  rnk_       accounts.rnk%type;
  nmk_       customer.nmk%type      ;  nmkl_   customer.nmk%type     ;  nmklk_     customer.nmk%type;  k050_      customer.k050%type;  s080_      specparam.s080%type;
  s090_      specparam.s090%type    ;  r013_   specparam.r013%type   ;  l_code     regions.code%type;  oo         oper%rowtype      ;  name_mon_  META_MONTH.name_plain%type;
  rz_        nbu23_rez.rz%type      ;  l_nd    oper.nd%type;  
  e_nofound_7form    exception;  
  e_nofound_7rasform exception;

  TYPE CurTyp IS REF CURSOR;
  c0 CurTyp;

  ---------------------------------------
  procedure p_error( p_error_type  NUMBER,
                     p_nbs         VARCHAR2,
                     p_s080        VARCHAR2,
                     p_custtype    VARCHAR2,
                     p_kv          VARCHAR2,
                     p_branch      VARCHAR2,
                     p_nbs_rez     VARCHAR2,
                     p_nbs_7f      VARCHAR2,
                     p_nbs_7r      VARCHAR2,
                     p_sz          NUMBER,
                     p_error_txt   VARCHAR2,
                     p_desrc       VARCHAR2)
  is
  PRAGMA AUTONOMOUS_TRANSACTION;
  begin
     insert into srezerv_errors ( dat,userid, error_type, nbs, s080, custtype, kv, branch, nbs_rez, nbs_7f, nbs_7r,
                                  sz, error_txt, desrc)
                         values (dat01_, userid_, p_error_type, p_nbs, p_s080, p_custtype, p_kv, p_branch, p_nbs_rez,
                                 p_nbs_7f, p_nbs_7r, p_sz, substr(p_error_txt,1,999), p_desrc) ;
     COMMIT;
  end;
  ---------------------------------------
  procedure pap_77 (p_acc  NUMBER,p_pap NUMBER) is
     l_fl NUMBER;
     begin
        select 1 into l_fl from accounts  where acc= p_acc and pap<>p_pap;
        update accounts set pap = p_pap where acc= p_acc;
     EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;

  end pap_77;
  ---------------------------------------

BEGIN

   l_rez_pay   := nvl(F_Get_Params('REZ_PAY', 0) ,0); -- Формирование  резерва по факту (1 - ФАКТ)
   select id into l_absadm from staff$base where logname = 'ABSADM';
   logger.info('PAY1 : l_rez_pay= ' || l_rez_pay) ;
   if l_rez_pay = 1 THEN
         l_pay := 1;
   else  l_pay := 0;
   end if;

   sdat01_    := to_char( DAT01_,'dd.mm.yyyy');
   PUL_dat(sdat01_,'');
   l_day_year := 27; -- к-во дней с начала года, после которого корректирующие не месячные , а годовые
   nn_        := 22;
   if mode_ = 0 THEN
      z23.to_log_rez (user_id , nn_ , dat01_ ,'Начало Проводки - Реальные '||'nal='||nal_);
   else
      z23.to_log_rez (user_id , nn_ , dat01_ ,'Начало Проводки - МАКЕТ '||'nal='||nal_);
   end if;
   dat31_  := Dat_last_work(dat01_-1); -- Последний рабочий день месяца
   oo.vdat := dat31_;
   oo.datd := gl.bdate;
   if p_user  = -1 THEN -- Трансформационные проводки
      l_user := -1;
   else
      l_user := p_user;
   end if;

   select EXTRACT(month  FROM dat31_), EXTRACT(YEAR  FROM dat31_) INTO mon_, year_ from dual; -- номер месяца, год
   select name_plain INTO name_mon_ from META_MONTH where n=mon_;

   doform_nazn            := 'Формування резерву за '||name_mon_||' '||year_;
   doform_nazn_korr       := 'Кор.проводка за '||name_mon_||' '||year_ ||' по форм.резерву ';
   doform_nazn_korr_year  := 'Кор.річна проводка за '||name_mon_||' '||year_ ||' по форм.резерву ';

   rasform_nazn           := 'Зменшення резерву за '||name_mon_||' '||year_ ;
   rasform_nazn_korr      := 'Кор.проводка за '||name_mon_||' '||year_ ||' по зменш.резерву ';
   rasform_nazn_korr_year := 'Кор.річна проводка за '||name_mon_||' '||year_ ||' по зменш.резерву ';

   userid_ := user_id;

   s_new_ := 0;
   if nal_='0' and l_user is null THEN
      --выбираем не оплаченные документы
      --проверка, есть ли за текущую дату расчета непроведенные проводки по резервам
      SELECT count(*) INTO s_new_ FROM oper
      WHERE tt = 'ARE' and vdat = dat31_ AND sos not in (5, -1); --выбираем не оплаченные документы

      if s_new_ > 0 then
         bars_error.raise_error('REZ',4);
      end if;
   end if;

   if nal_='0' THEN
--      DELETE FROM srezerv_errors;
      DELETE FROM rez_doc_maket;
   end if;

   b_date  := gl.BDATE; -- bankdate;
   otvisp_ := nvl(GetGlobalOption('REZ_ISP'),userid_);

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0')) INTO REZPROV_ FROM params WHERE par = 'REZPROV';
   EXCEPTION WHEN NO_DATA_FOUND THEN rezprov_ := 0;
   END;

   BEGIN
      SELECT SUBSTR (val, 1, 14) INTO okpoa_ FROM params WHERE par = 'OKPO';
   EXCEPTION WHEN NO_DATA_FOUND THEN  okpoa_ := '';
   END;

   -- Определяем схема MMFO ?
   begin
      select count(*) into l_MMFO from mv_kf;
      if l_MMFO > 1 THEN             l_MMFO := 1; -- схема    MMFO
      ELSE                           l_MMFO := 0; -- схема не MMFO
      end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN l_MMFO := 0; -- схема не MMFO
   end ;
   if l_MMFO = 1 THEN
      begin
         select code into l_code from regions where kf = sys_context('bars_context','user_mfo');
      EXCEPTION WHEN NO_DATA_FOUND THEN l_code := '';
      end;
   end if;

   --выборка данных для проводок
   DECLARE
      TYPE r0Typ IS RECORD (
           COUNTRY  CUSTOMER.COUNTRY%type,
           NBS_REZ  srezerv_ob22.NBS_REZ%TYPE,
           OB22_REZ srezerv_ob22.OB22_REZ%TYPE,
           NBS_7f   srezerv_ob22.NBS_7f%TYPE,
           OB22_7f  srezerv_ob22.OB22_7f%TYPE,
           NBS_7r   srezerv_ob22.NBS_7r%TYPE,
           OB22_7r  srezerv_ob22.OB22_7r%TYPE,
           kv       accounts.kv%TYPE,
           rz       nbu23_rez.rz%TYPE,
           branch   accounts.branch%TYPE,
           sz       number,
           szn      number,
           sz_30    number,
           s080     specparam.s080%TYPE,
           pr       srezerv_ob22.pr%TYPE,
           r_s080   specparam.s080%TYPE,
           r013     specparam.r013%TYPE,
           nd       nbu23_rez.nd%TYPE,
           cc_id    nbu23_rez.cc_id%TYPE,
           nd_cp    nbu23_rez.nd_cp%TYPE,
           r_acc    VARCHAR2(1000),
           r_nls    VARCHAR2(1000),
           f7_acc   VARCHAR2(1000),
           f7_nls   VARCHAR2(1000),
           r7_acc   VARCHAR2(1000),
           r7_nls   VARCHAR2(1000),
           cnt      int );
      k r0Typ;
   begin

      if nal_ in ('0','1','2','5','B','C') THEN

         OPEN c0 FOR
         select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz    , t.branch, t.sz,
                t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp ,
                ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc  ,
                ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls  , count(*) cnt
         from ( select c.country, o.NBS_REZ , o.OB22_REZ, o.NBS_7f  , o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr , o.r013 , nvl(r.rz,1) rz, r.KV,
                       null nd  , null cc_id, null nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                       sum(nvl(r.rez   *100,0)) sz      , sum(nvl(r.rezn*100,0)) szn  ,
                       sum(nvl(r.rez_30*100,0)) sz_30   , decode(r.kat,1,1,9,9,2) s080, r.kat r_s080
                from nbu23_rez r
                join customer     c on (r.rnk = c.rnk)
                join srezerv_ob22 o on (r.nbs = o.nbs and o.nal=nal_ AND 
                                        r.s250=decode(nal_,'A','8','B','8','C','8','D','8',decode(r.s250,'8','Z',r.s250)) and
                                        nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                        decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                        nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                        r.kv = decode(o.kv,'0',r.kv,o.kv) )
                where fdat = dat01_  and substr(r.id,1,4) <> 'CACP' 
                      and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                      and nvl(decode(nal_,'2',rez_30,'5',rez_30,'6',rez_30,'C',rez_30,'D',rez_30,'8',r.rez,rez_0),0) <> 0
                      and decode(nal_,'0',-sign(r.rez),'2',-sign(r.rez),sign(r.rez)) = 1 
                group by c.country,o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, r.KV, r.rz,
                         rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',decode(r.kat,1,1,9,9,2),r.kat
              ) t
         --счет резерва
         left join v_gls080 ar on ( t.NBS_REZ = ar.nbs    and t.OB22_REZ = ar.ob22  and ar.rz    = t.rz    and t.KV = ar.kv  and ar.pap = decode(nal_,'0',1,'2',1,2) and
                                    t.branch  = ar.BRANCH and ar.dazs is null       and t.r_s080 = ar.s080 and t.country = ar.country)
         --счет 7 класса формирования
         left join v_gl a7_f   on (t.NBS_7f = a7_f.nbs    and t.OB22_7f = a7_f.ob22 and '980' = a7_f.kv and
                                   t.branch = a7_f.BRANCH and a7_f.dazs is null)
         --счет 7 класса уменьшения
         left join v_gl a7_r   on (t.NBS_7r = a7_r.nbs    and t.OB22_7r = a7_r.ob22 and '980' = a7_r.kv and
                                   t.branch = a7_r.BRANCH and  a7_r.dazs is null)
         group by t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv, t.rz, t.branch, t.sz, t.szn, t.sz_30,
                  t.s080   , t.pr     , t.nd      , t.cc_id , t.nd_cp  , t.r_s080, t.r013   ;

      elsif nal_ in ('3','7') THEN

         OPEN c0 FOR
         select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz   , t.branch, t.sz,
                t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp,
                ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc ,
                ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls, count(*) cnt
         from ( select c.country, o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013,nvl(r.rz,1) rz, r.KV,
                       '1' cc_id,0 nd,r.nd_cp,rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                       sum(nvl(r.rez*100,0)) sz,sum(nvl(r.rezn*100,0)) szn,sum(nvl(r.rez_30*100,0)) sz_30,
                       decode(r.kat,1,1,9,9,2) s080,r.kat r_s080
                from nbu23_rez r
                join customer     c on (r.rnk = c.rnk)
                join srezerv_ob22 o on (r.nbs = o.nbs and o.nal=decode(nal_,'3','1',nal_) AND 
                                        nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                        decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                        nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                        r.kv = decode(o.kv,'0',r.kv,o.kv) )
                where fdat = dat01_ and nvl(decode(nal_,'3',rez-rez_30,rez_30),0) <> 0 and id like 'CACP%' AND
                      r.nls NOT in ('31145020560509','31145020560510','31141039596966','31148011314426')
                      and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                group by c.country, o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r,o.pr, o.r013,'1', r.KV, r.rz,0,
                         r.nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',
                         decode(r.kat,1,1,9,9,2),r.kat ) t
         --счет резерва
         left join v_gls080 ar on (t.NBS_REZ = ar.nbs      and t.OB22_REZ = ar.ob22   and ar.rz =t.rz        and t.KV = ar.kv   and
                                   t.branch  = ar.BRANCH   and ar.dazs is null        and t.r_s080 = ar.s080 and t.nd_cp=ar.nkd and
                                   t.country = ar.country)
         --счет 7 класса формирования
         left join v_gl a7_f   on (t.NBS_7f  = a7_f.nbs    and t.OB22_7f  = a7_f.ob22 and '980' = a7_f.kv and
                                   t.branch  = a7_f.BRANCH and a7_f.dazs is null)
         --счет 7 класса уменьшения
         left join v_gl a7_r   on (t.NBS_7r  = a7_r.nbs    and t.OB22_7r  = a7_r.ob22 and '980' = a7_r.kv and
                                   t.branch  = a7_r.BRANCH and a7_r.dazs is null)
         group by t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv, t.nd, t.rz, t.branch, t.sz, t.szn,
                  t.sz_30  , t.s080   , t.pr      , t.cc_id , t.nd_cp  , t.r_s080, t.r013;
      else

         OPEN c0 FOR
         select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz   , t.branch, t.sz,
                t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp,
                ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc,
                ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls, count(*) cnt
         from ( select c.country, o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, nvl(r.rz,1) rz, r.KV,
                       r.nd     , r.cc_id  , r.nd_cp   , rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                       sum(nvl(r.rez*100,0)) sz,sum(nvl(r.rezn*100,0)) szn,0 sz_30, decode(r.kat,1,1,9,9,2) s080, r.kat r_s080
                from nbu23_rez r
                join customer     c on (r.rnk = c.rnk)
                join srezerv_ob22 o on (r.nbs = o.nbs and o.nal=decode(nal_,'3','1','4','1',nal_) AND 
                                        nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                        decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                        nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                        r.kv = decode(o.kv,'0',r.kv,o.kv) )
                where fdat = dat01_ and nvl(r.rez,0) <> 0 and
                      r.nls in ('31145020560509','31145020560510','31141039596966','31148011314426')
                      and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                group by C.COUNTRY,o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, r.nd, r.cc_id,
                         r.KV, r.rz, r.nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',
                         decode(r.kat,1,1,9,9,2),r.kat ) t
         --счет резерва
         left join v_gls080 ar on (t.NBS_REZ = ar.nbs      and t.OB22_REZ = ar.ob22   and ar.rz    = t.rz    and t.KV    = ar.kv  and
                                   t.branch  = ar.BRANCH   and ar.dazs is null        and t.r_s080 = ar.s080 and t.nd_cp = ar.nkd and
                                   t.country = ar.country)
         --счет 7 класса формирования
         left join v_gl a7_f   on (t.NBS_7f  = a7_f.nbs    and t.OB22_7f  = a7_f.ob22 and '980'    = a7_f.kv and
                                   t.branch  = a7_f.BRANCH and a7_f.dazs is null)
         --счет 7 класса уменьшения
         left join v_gl a7_r   on (t.NBS_7r  = a7_r.nbs    and t.OB22_7r  = a7_r.ob22 and '980'    = a7_r.kv and
                                   t.branch = a7_r.BRANCH  and a7_r.dazs is null)
         group by t.country,t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv, t.rz, t.branch, t.sz, t.szn,
                  t.sz_30  , t.s080  , t.pr      , t.nd    , t.cc_id  , t.nd_cp , t.r_s080 , t.r013;
      end if;

      loop
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;

         fl   := 0;
         -- acc_ := k.r_acc;
         -- logger.info('PAY1 : nls_= ' || k.r_nls||'/'||k.kv) ;
         -- logger.info('PAY2 : acc_= ' || acc_) ;
         -- logger.info('PAY3 : R013= ' || k.r013) ;
         --проверка корректности данных
         logger.info('PAY11-5 : NBS/OB22 = ' || k.NBS_REZ||'/'||k.OB22_REZ || ' nal_= ' || nal_|| ' k.r_nls= ' || k.r_nls || ' k.f7_nls= ' || k.f7_nls || ' k.r7_nls= ' || k.r7_nls) ;   
         if k.cnt > 1 then
            -- для одного счета резерва найдено несколько лицевых счетов
            if instr(k.r_nls,',') > 0 then
               p_error( 12, k.NBS_REZ||'/'||k.OB22_REZ,null, null, k.kv, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.r_nls||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
               fl := 1;

            end if;
            -- для одного счета 7 класса (для формирования) найдено несколько лицевых счетов
            if instr(k.f7_nls,',') > 0 then
               p_error( 12, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.f7_nls, 'Рахунок резерву - '||k.r_nls);
               fl := 2;

            end if;
            -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
            if instr(k.r7_nls,',') > 0 then
               p_error( 12, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.r7_nls, 'Рахунок резерву - '||k.r_nls);
               fl := 3;

            end if;
         end if;
         if fl = 0 THEN   acc_ := k.r_acc;  end if;

         -- Определение параметров клиента и счета
         begin
            select * into par from NBS_OB22_PAR_REZ  where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=k.rz;
         EXCEPTION  WHEN NO_DATA_FOUND THEN
            par.par_rnk   := 'REZ_RNK_UL';
            par.nmk       := 'ЮО (неизвестен)';
            par.cu        := 2;
            par.Codcagent := 3;
            par.ISE       := '11002';
            par.ved       := '51900';
            par.sed       := '12';
            par.nazn      := '(?)';
         END;
         oo.nazn := par.nazn;
         if l_user is not null and l_user <> -1 THEN
            oo.nazn := oo.nazn ||' (перенос)';
         end if;

         --проверка открыты ли необходимые счета в базе
         if k.r_acc is null then
            if REZPROV_ = 1 then
               -- Счет не открыт - открываем нужный счет
               acc_:=null;
               nmk_:='Резерви ';
               nmk_ := nmk_ || par.nmk || '/(' || k.country || ')';
               K050_ := par.sed||'0';
               begin
                  select rnk into rnk_b from BRANCH_COUNTRY_RNK where branch = k.branch and tag = par.par_rnk and country = k.country;
                  --logger.info('PAY1 -1: nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' RNK_B=' || rnk_b ) ;
                  update customer set date_off = NULL where rnk = rnk_b and date_off is not null;
               -- select val into rnk_b from BRANCH_PARAMETERS where length(branch)=15 and tag=tag_ and branch =k.branch;
               EXCEPTION  WHEN NO_DATA_FOUND THEN
                  BEGIN
                     select substr(name,22,15) into ru_ from branch where branch=k.branch;
                  EXCEPTION  WHEN NO_DATA_FOUND THEN ru_:='';
                  END;

                  -- регистрация
                  rnk_   := bars_sqnc.get_nextval('s_customer');
                  nmkl_  := substr(trim(NMK_),1,70);
                  nmklk_ := substr(nmkl_,1,38);

                  kl.open_client (Rnk_,           -- Customer number
                                  par.cu,         -- Custtype_-- Тип клиента: 1-банк, 2-юр.лицо, 3-физ.лицо
                                  null,           -- № договора
                                  nmkl_,          -- Nmk_,       -- Наименование клиента
                                  NMkl_,          -- Nmk_,       -- Наименование клиента международное
                                  nmklk_,         -- Наименование клиента краткое
                                  ru_,            -- Adr_-- Адрес клиента
                                  par.Codcagent,  -- Характеристика
                                  k.Country,      -- Страна
                                  99,             -- Prinsider_, -- Признак инсайдера
                                  1,              -- Tgr_, -- Тип гос.реестра
                                  okpoa_,         -- ОКПО
                                  null,           -- Stmt_,     -- Формат выписки
                                  null,           -- Sab_,      -- Эл.код
                                  b_date,         -- DateOn_,    -- Дата регистрации
                                  null,           -- Taxf_,      -- Налоговый код
                                  null,           -- CReg_,      -- Код обл.НИ
                                  null,           -- CDst_,     -- Код район.НИ
                                  null,           -- Adm_,      -- Админ.орган
                                  null,           -- RgTax_,    -- Рег номер в НИ
                                  null,           -- RgAdm_,    -- Рег номер в Адм.
                                  null,           -- DateT_,    -- Дата рег в НИ
                                  null,           -- DateA_,    -- Дата рег. в администрации
                                  par.Ise,        -- Инст. сек. экономики
                                  '10',           -- FS Форма собственности
                                  '96120',        -- OE,        -- Отрасль экономики
                                  par.Ved,        -- Вид эк. деятельности
                                  par.Sed,        -- Форма хозяйствования
                                  K050_,          -- Показатель k050
                                  null,           -- Notes_,    -- Примечание
                                  null,           -- Notesec_   -- Примечание для службы безопасности
                                  null,           -- CRisk_,    -- Категория риска
                                  null,           -- Pincode_,  --
                                  null,           -- RnkP_,     -- Рег. номер холдинга
                                  null,           -- Lim_,      -- Лимит кассы
                                  null,           -- NomPDV_,   -- № в реестре плат. ПДВ
                                  null,           -- MB_,       -- Принадл. малому бизнесу
                                  0,              -- BC_,       -- Признак НЕклиента банка
                                  null,           -- Tobo_,     -- Код безбалансового отделения
                                  null            -- Isp_       -- Менеджер клиента (ответ. исполнитель)
                                  );
                  begin
                     INSERT INTO BRANCH_COUNTRY_RNK ( BRANCH, COUNTRY, TAG,  RNK ) VALUES (k.branch, k.country, par.par_rnk, rnk_);
                  EXCEPTION WHEN others then
                     if SQLCODE = -00001 then
                        update BRANCH_COUNTRY_RNK set rnk = rnk_ where branch = k.branch and tag = par.par_rnk;
                     end if;
                  end;

                  rnk_b:=rnk_;
                  --logger.info('PAY1 0 : nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' RNK_B=' || rnk_b ) ;
               end;

               if k.r_s080='0' then
                  s080_:=k.s080;
               else
                  s080_:=k.r_s080;
               end if;

               SELECT UPPER(NVL(k.NBS_REZ,SUBSTR(MASK,1,4))||SUBSTR(MASK,5,8))||k.OB22_REZ INTO maska_
               FROM   nlsmask WHERE  maskid='REZ';
               nls_ := f_newnls2 (NULL, 'REZ' ,k.NBS_REZ, RNK_b, S080_, k.kv, maska_);
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               k.r_nls := nls_;
               select substr(trim('('||k.ob22_rez||')'|| decode(mode_,3,trim(k.CC_ID),'') || nmk_ || substr(k.branch,8,8)),1,70) into nms_ from dual;
               begin
                  select isp into isp_  from v_gl
                  where kv = k.kv and branch = k.branch and nbs = k.NBS_REZ and dazs is null and isp <> l_absadm and rownum = 1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm;
               end;

               begin
                  select acc into l_acc from v_gl where nls=nls_ and kv=k.kv and dazs is not null;
                  update accounts set dazs = null where acc=l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN null;
               END;
               if isp_ = 20094 THEN isp_ := l_absadm; end if;
               logger.info('PAY1 : nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' isp_=' || isp_ || ' NLS_=' || nls_ || ' KV=' || k.kv) ;
               op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,k.kv,nms_,'REZ',isp_,acc_);
               --logger.info('PAY55 : nls_= ' || nls_||' '||acc_) ;
               k.r_acc:=acc_;
               update accounts set                 daos=dat31_       where acc= acc_ and daos > dat31_ ;
               update accounts set tobo = k.branch                   where acc= acc_ and tobo <> k.branch ;
               update accounts set pap  = decode(nal_,'0',1,'2',1,2) where acc= acc_ and pap  <> decode(nal_,'0',1,'2',1,2) ;
               update specparam_int set ob22=k.OB22_REZ where acc=acc_;
               if sql%rowcount=0 then
                  insert into specparam_int(acc,ob22) values(acc_, k.OB22_REZ);
               end if;
               update accounts set ob22 = k.OB22_REZ where acc= acc_ and (ob22 <> k.OB22_REZ or ob22 is null) ;

               if k.kv=980 THEN
                  s090_:='1';
               ELSE
                  s090_:='5';
               END IF;

               update specparam set s080=s080_,s090=s090_,nkd=k.nd_cp where acc=acc_;
               if sql%rowcount=0 then
                  insert into specparam (acc,s080,s090,nkd) values(acc_, s080_,s090_,k.nd_cp);
               end if;
            else
               p_error( 11, k.NBS_REZ||'/'||k.OB22_REZ,k.r_s080, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null,
                        k.sz, k.NBS_REZ||'/'||k.OB22_REZ||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
               fl := 4;
            end if;
            if k.r_s080='0' then
               s080_:=k.s080;
            else
               s080_:=k.r_s080;
            end if;
         end if;
         if k.r_acc is not null and fl = 0 THEN
            update accounts set tip='REZ'         where acc= k.r_acc and tip<>'REZ'; 
         end if;
         -- Для отчетности заполнение R013 для 2400
         --logger.info('PAY6 : acc_= ' || acc_) ;
         --logger.info('PAY7 : k.nbs_rez= ' || k.nbs_rez) ;
         --logger.info('PAY8 : k.r013= ' || k.r013) ;
         if    acc_ is not null and k.nbs_rez = '3190' and k.r013=1 THEN
               k.r013 := 'A';
         elsif acc_ is not null and k.nbs_rez = '3190' and k.r013=2 THEN
               k.r013 := 'B';
         end if;
         if mode_ = 0 THEN

            --logger.info('PAY9 : k.r013= ' || k.r013) ;
            --logger.info('PAY9 : acc_  = ' || acc_) ;
            update specparam set r013=nvl(k.r013,r013) where acc=acc_;
            if sql%rowcount=0 then
               insert into specparam (acc,r013) values(acc_, k.r013);
            end if;
         end if;

         --проверка открыт ли нужный счет 7 класса
         if k.f7_acc is null then
            if REZPROV_ = 1 then
               acc_:=null;
               nls_ := k.NBS_7F || '0' || substr(k.branch,9,6) || k.OB22_7F ||'0';
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               nms_ := 'Формир.рез. ' || ',об22=' || k.OB22_7F || ',бранч=' || k.branch;
               k.f7_nls := nls_;

               begin
                  select isp, rnk into isp_, rnk_b from v_gl
                  where kv=980 and branch = k.branch and nbs =k.NBS_7F and ostc<>0 and dazs is null and isp<>l_absadm and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN isp_ :=l_absadm; rnk_b :=to_number('1' || l_code);
               end;
               bars_audit.error('111 счет='|| nls_);

               begin
                  select acc into l_acc from accounts where nls=nls_ and kv=980 and dazs is not null;
                  -- или закрыт или поменяли БРАНЧ
                  -- восстанавливаем
                  update accounts set dazs = null, tobo = k.branch where acc=l_acc;
                  update specparam_int set ob22=k.OB22_7F where acc=l_acc;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(l_acc, k.OB22_7F);
                  end if;
                  update accounts set ob22 = k.OB22_7F    where acc=l_acc and (ob22 <> k.OB22_7F or ob22 is null) ;
                  k.f7_acc := l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  op_reg(99, 0, 0, GRP_, p4_, rnk_b, nls_, 980, nms_, 'ODB', isp_, acc_);
                  k.f7_acc:=acc_;
                  -- update accounts set tobo = k.branch,daos=dat31_ where acc= acc_;
                  update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                  update accounts set tobo = k.branch             where acc= acc_ and tobo <> k.branch ;

                  update specparam_int set ob22=k.OB22_7F where acc=acc_;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(acc_, k.OB22_7F);
                  end if;
                  update accounts set ob22=k.OB22_7F  where acc= acc_ and (ob22 <> k.OB22_7F or ob22 is null) ;
               end;
            Else
               p_error( 8, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz, k.NBS_7f||'/'|| k.OB22_7f,  'Рахунок резерву - '||k.r_nls);
               fl := 4;
            end if;
         end if;

         --проверка открыт ли нужный счет 7 класса
         if k.r7_acc is null then
            if REZPROV_ = 1 then
               acc_:=null;
               nls_ := k.NBS_7R || '0' || substr(k.branch,9,6) || k.OB22_7R ||'0';
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               nms_ := 'Формир.рез. ' || ',об22=' || k.OB22_7R || ',бранч=' || k.branch;
               k.r7_nls := nls_;

               begin
                  select isp, rnk into isp_,rnk_b  from v_gl
                  where kv=980 and branch = k.branch and nbs =k.NBS_7R and ostc<>0 and dazs is null and isp<>l_absadm and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm; rnk_b :=to_number('1' || l_code);
               end;
               bars_audit.error('222 счет='|| nls_);

               begin
                  select acc into l_acc from accounts where nls=nls_ and kv=980 and dazs is not null;
                  -- или закрыт или поменяли БРАНЧ
                  update accounts set dazs=null, tobo=k.branch where acc=l_acc;
                  update specparam_int set ob22=k.OB22_7R where acc=l_acc;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(l_acc, k.OB22_7R);
                  end if;
                  update accounts set ob22 = k.OB22_7R where acc=l_acc and (ob22 <> k.OB22_7R or ob22 is null);
                  k.r7_acc:=l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,980,nms_,'ODB',isp_,acc_);
                  k.r7_acc:=acc_;
                  --update accounts set tobo = k.branch,daos=dat31_ where acc= acc_;
                  update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                  update accounts set tobo = k.branch             where acc= acc_ and tobo <> k.branch ;

                  update specparam_int set ob22=k.OB22_7R where acc=acc_;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(acc_, k.OB22_7R);
                  end if;
                  update accounts set ob22 = k.OB22_7R where acc=acc_ and (ob22 <> k.OB22_7R or ob22 is null);
               end;
            else
               p_error( 8, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null,  k.sz, k.NBS_7r||'/'|| k.OB22_7r,  'Рахунок резерву - '||k.r_nls);
                fl := 4;
            end if;
         end if;

         begin
            savepoint sp;
            error_str :=null;
            --формирование проводок
         logger.info('PAY11-6 : NBS/OB22 = ' || k.NBS_REZ||'/'||k.OB22_REZ || ' fl= ' || fl) ;   
            if fl = 0 then
               oo.tt   := 'ARE';
               oo.nlsa := k.r_nls;
               oo.kv  := k.kv;
               oo.kv2 := 980;

               if l_user is not null THEN
                  oo.vob  := 6;
                  s_old_  := 0;  -- Предыдущий резерв
               else
                  -- Определяем необходимый вид VOB
                  if b_date - dat31_ > l_day_year and dat01_=to_date('01-01-2016','dd-mm-yyyy')  THEN
                     oo.vob := 99; -- корректирующие годовые
                     begin
                        select ostc into s_old_ from accounts where acc=k.r_acc; -- при годовых текущий остаток
                     EXCEPTION WHEN NO_DATA_FOUND THEN s_old_ := 0;
                     end;
                  ElsIf TO_CHAR (b_date, 'YYYYMM') > TO_CHAR (dat31_, 'YYYYMM') THEN
                     oo.vob := 96; -- корректирующие
                     select ost_korr(k.r_acc,dat31_,null,k.nbs_rez) INTO s_old_ from dual; -- Предыдущий резерв -  остаток с корректир.
                  ELSE
                     oo.vob := 6;  -- обычные
                     select ost_korr(k.r_acc,dat31_,null,k.nbs_rez) INTO s_old_ from dual; -- Предыдущий резерв -  остаток с корректир.
                  END IF;
               end if;
               --новая сумма резерва
               if    nal_  in ('4','8')      THEN  s_new_ := k.sz;
               elsif nal_  in ('2','5','C')  THEN  s_new_ := k.sz_30;
               elsif nal_  in ('6','D')      THEN  s_new_ := k.sz_30;
               elsif nal_  in ('3')          THEN  s_new_ := k.sz-k.sz_30;
               elsif nal_  =   '7'           THEN  s_new_ := k.sz_30;
               else
                  if    k.sz_30<>0           THEN  s_new_ := k.sz-k.sz_30;
                  else                             s_new_ := k.sz;
                  end if;
               end if;

               error_str := error_str||'1';
               --резерв изменился
               --logger.info('PAY11 : s_new_= ' || s_new_) ;
               --logger.info('PAY11 : s_old_= ' || s_old_) ;
               --logger.info('KORR99-11: vob_= ' || vob_||'s_old_='||s_old_||':s_new-'||s_new_||'-'||k.r_nls) ;
              logger.info('PAY11-7 : NBS/OB22 = ' || k.NBS_REZ||'/'||k.OB22_REZ || ' s_old_= ' || s_old_|| ' s_new_= ' || s_new_) ;   
               if s_new_ - s_old_ <> 0 then
                  if s_new_ > s_old_ then-- увеличение резерва
                     oo.dk     := 0;
                     oo.s      := (-s_old_ + s_new_);
               logger.info('PAY11-1 : NBS/OB22 = ' || k.NBS_REZ||'/'||k.OB22_REZ || ' s_old_= ' || s_old_|| ' s_new_= ' || s_new_ || ' oo.s= ' || oo.s) ;
                     oo.nlsb   := k.f7_nls;
                     r7702_acc := k.f7_acc;
                     --r7702_    := k.f7_nls;
                     r7702_bal := k.NBS_7f||'/'||k.OB22_7f;
                     pap_77 (k.f7_acc,1); -- Корректировка признака актива-пассива по 7 кл.
                     IF    oo.vob = 99 THEN oo.nazn := doform_nazn_korr_year || oo.nazn;
                     ElsIf oo.vob = 96 THEN oo.nazn := doform_nazn_korr      || oo.nazn;
                     Else                   oo.nazn := doform_nazn           || oo.nazn;
                     END IF;


                  else--уменьшение резерва

                     oo.dk     := 1;
                     oo.s      := (s_old_ - s_new_);
               logger.info('PAY11-2 : NBS/OB22 = ' || k.NBS_REZ||'/'||k.OB22_REZ || ' s_old_= ' || s_old_|| ' s_new_= ' || s_new_ || ' oo.s= ' || oo.s) ;
                     oo.nlsb   := k.r7_nls;
                     r7702_acc := k.r7_acc;
                     --r7702_    := k.r7_nls;
                     r7702_bal := k.NBS_7r||'/'||k.OB22_7r;
                     pap_77 (k.r7_acc,2);
                     IF    oo.vob = 99 THEN oo.nazn := rasform_nazn_korr_year || oo.nazn;
                     ElsIf oo.vob = 96 THEN oo.nazn := rasform_nazn_korr      || oo.nazn;
                     Else                   oo.nazn := rasform_nazn           || oo.nazn;
                     END IF;

                  end if;
                  oo.s2     := gl.p_icurval ( oo.kv, oo.s, oo.vdat );
                  error_str := error_str||'2';

                  -- узнать название нужных счетов для вставки в OPER
                  SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO oo.nam_a, oo.nam_b
                  FROM v_gl a, v_gl b WHERE a.acc = k.r_acc and b.acc = r7702_acc;

logger.info('PAY11-3 : NBS/OB22 = ' || k.NBS_REZ||'/'||k.OB22_REZ || ' oo.nlsa= ' || oo.nlsa|| ' oo.nlsb= ' || oo.nlsb ) ;
                  IF mode_ = 0 THEN

                     gl.ref (oo.REF);
                     oo.nd := substr(to_char(oo.ref),-10);
                     gl.in_doc3 (ref_ => oo.REF  , tt_  => oo.tt  , vob_ => oo.vob ,   nd_ =>oo.nd   , pdat_=>SYSDATE, vdat_ =>oo.vdat, dk_ =>oo.dk,
                                  kv_ => oo.kv   , s_   => oo.S   , kv2_ => oo.kv2 ,   s2_ =>oo.S2   , sk_  => null  , data_ =>oo.DATD, datp_=>gl.bdate,
                               nam_a_ => oo.nam_a,nlsa_ => oo.nlsa,mfoa_ => gl.aMfo, nam_b_=>oo.nam_b,nlsb_ =>oo.nlsb, mfob_ =>gl.aMfo ,
                                nazn_ => oo.nazn ,d_rec_=> null   ,id_a_ => null   , id_b_ =>null    ,id_o_ =>null   , sign_ =>null,sos_=>1,prty_=>null,uid_=>null);
                     gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa , oo.s, oo.kv2    ,oo.nlsb, oo.s2);
                     gl.pay (2, oo.ref, gl.bdate);  -- по факту

                  end if;
                  -- резерв не поменялся - все равно запишем в rez_doc_maket с признаком dk = -1
                  -- чтобы впоследствии при полном расформировании не учитывать этот счет
               else
                  oo.dk     := -1;
                  oo.nam_a  := null;
                  oo.nam_b  := null;
                  oo.nlsb   := null;
                  oo.nazn   := null;
                  oo.s      := s_new_;
 logger.info('PAY11-7 : NBS/OB22 = ' || k.NBS_REZ||'/'||k.OB22_REZ || ' s_old_= ' || s_old_|| ' s_new_= ' || s_new_) ;   
                  oo.s2     := gl.p_icurval ( oo.kv, oo.s, oo.vdat );
                  error_str := error_str||' 16';
               end if;
               INSERT INTO rez_doc_maket (tt    , vob     , pdat   , vdat     , datd   , datp    , nam_a   , nlsa   , mfoa  , 
                                          id_a  , nam_b   , nlsb   , mfob     , id_b   , kv      , s       , kv2    , s2    , nazn    , userid , dk   , branch_a, ref    )
                                  VALUES (oo.tt , k.s080  , SYSDATE, oo.vdat  , oo.datd, gl.bdate, oo.nam_a, oo.nlsa, k.nbs_rez||'/'||k.ob22_rez      ,
                                          okpoa_, oo.nam_b, oo.nlsb, r7702_bal, okpoa_ , oo.kv   , oo.s    , oo.kv2 , oo.s2 , oo.nazn , userid_, oo.dk, k.branch, oo.ref );
               error_str := error_str||' 10';

            end if;
         exception when others then
            rollback to sp;
            p_error( 5, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
                     k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7f||'/'|| k.OB22_7f||','||k.NBS_7r||'/'|| k.OB22_7r||
                     substr(sqlerrm,instr(sqlerrm,':')+1), error_str);
         end;

      end loop;
      CLOSE c0;
   END;

   -----------------------------------------------------------
   --РАСФОРМИРОВАНИЕ ДЛЯ ТЕХ СЧЕТОВ ПО КОТОРЫМ ТЕКУЩИЙ РЕЗЕРВ НЕ ФОРМИРОВАЛСЯ (т.е. = 0)
   --(НЕТ В nbu23_rez)

   DECLARE TYPE r0Typ IS RECORD (
                r_acc    accounts.acc%TYPE,
                OB22_REZ srezerv_ob22.OB22_REZ%TYPE,
                NBS_REZ  srezerv_ob22.NBS_REZ%TYPE,
                branch   accounts.branch%TYPE,
                r_nls    accounts.nls%TYPE,
                kv       accounts.kv%TYPE,
                sz       accounts.ostc%TYPE,
                NBS_7r   srezerv_ob22.NBS_7r%TYPE,
                OB22_7r  srezerv_ob22.OB22_7r%TYPE,
                r7_acc   VARCHAR2(1000),
                r7_nls   VARCHAR2(1000),
                NBS_7f   srezerv_ob22.NBS_7r%TYPE,
                OB22_7f  srezerv_ob22.OB22_7r%TYPE,
                f7_acc   VARCHAR2(1000),
                f7_nls   VARCHAR2(1000),
                pr       srezerv_ob22.pr%TYPE);
      k r0Typ;
   begin
      if l_user is null  THEN
         if nal_ in ('0','1','2','5','B','C') THEN
          
            OPEN c0 FOR
            select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                   a.nls r_nls, a.kv, ost_korr(a.acc,dat31_,null,a.nbs) sz, 
                   o.NBS_7R, o.OB22_7R, ConcatStr(a7r.acc) r7_acc, ConcatStr(a7r.nls) r7_nls,  
                   o.NBS_7F, o.OB22_7F, ConcatStr(a7f.acc) f7_acc, ConcatStr(a7f.nls) f7_nls,o.pr
            from v_gl a
            left join srezerv_ob22 o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
            left join v_gl a7r on (o.NBS_7R = a7r.nbs and a7r.nbs like '77%'  and o.OB22_7R = a7r.ob22 and '980' = a7r.kv and
                                  rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' = a7r.BRANCH and a7r.dazs is null )
            left join v_gl a7f on (o.NBS_7f = a7f.nbs and a7f.nbs like '77%'  and o.OB22_7f = a7f.ob22 and '980' = a7f.kv and
                                  rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' = a7f.BRANCH and a7f.dazs is null )
            where a.nbs||a.ob22 in (select distinct nbs_rez||ob22_rez from srezerv_ob22 where substr(nbs_rez,1,2) not in ('14','31','32')) and
                  o.nal = decode(nal_, '3', '1', '4', '1', nal_) and a.dazs is null and ost_korr(a.acc,dat31_,null,a.nbs) <> 0 and a.pap = decode(nal_,'0',1,'2',1,2)
                  --не формировались проводки
                  and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
                  --нет ошибок
                  and not exists (select 1 from srezerv_errors r
                                  where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_
                                        and r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
            group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                     a.nls, a.kv, o.NBS_7R, o.OB22_7R, o.NBS_7f, o.OB22_7f,o.pr ;
         else
            OPEN c0 FOR
            select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                   a.nls r_nls, a.kv, ost_korr(a.acc,dat31_,null,a.nbs) sz, 
                   o.NBS_7R, o.OB22_7R, ConcatStr(a7r.acc) r7_acc, ConcatStr(a7r.nls) r7_nls,
                   o.NBS_7f, o.OB22_7f, ConcatStr(a7f.acc) f7_acc, ConcatStr(a7f.nls) f7_nls,o.pr
            from v_gl a
            left join srezerv_ob22 o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
            left join v_gl a7r on (o.NBS_7R = a7r.nbs and a7r.nbs like '77%'  and o.OB22_7R = a7r.ob22 and '980' = a7r.kv and
                                  rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' = a7r.BRANCH and a7r.dazs is null )
            left join v_gl a7f on (o.NBS_7f = a7f.nbs and a7f.nbs like '77%'  and o.OB22_7f = a7f.ob22 and '980' = a7f.kv and
                                  rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' = a7f.BRANCH and a7f.dazs is null )
            where a.nbs||a.ob22 in (select distinct nbs_rez||ob22_rez from srezerv_ob22 where substr(nbs_rez,1,2) in ('14','31','32')) 
              and o.nal=decode(nal_,'3','3','4','1',nal_) and a.dazs is null and ost_korr(a.acc,dat31_,null,a.nbs) <> 0
            --не формировались проводки
            and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
            --нет ошибок
            and not exists (select 1 from srezerv_errors r
                            where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_ and
                                  r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
            group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                     a.nls, a.kv, o.NBS_7R, o.OB22_7R, o.NBS_7f, o.OB22_7f,o.pr;
         end if;

         loop
            FETCH c0 INTO k;
            EXIT WHEN c0%NOTFOUND;

            fl := 0;

            if k.NBS_7R is null then
               p_error( 8, k.NBS_rez||'/'|| k.OB22_rez,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.r7_nls,  'Рахунок резерву - '||k.r_nls);
               fl := 5;

            -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
            elsif instr(k.r7_nls,',') > 0 then
               p_error( 7, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.r7_nls,  'Рахунок резерву - '||k.r_nls);
               fl := 5;
            --счета не найдены
            elsif k.r7_acc is null then
               acc_:=null;
               nls_ := k.NBS_7R || '0' || substr(k.branch,9,6) || k.OB22_7R ||'0';
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               nms_ := 'Формир.рез. ' || ',об22=' || k.OB22_7R || ',бранч=' || k.branch;
               k.r7_nls := nls_;
               begin
                  select isp, rnk into isp_,rnk_b  from v_gl
                  where kv=980 and branch = k.branch and nbs =k.NBS_7R and ostc<>0 and dazs is null and isp<>l_absadm and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm; rnk_b :=to_number('1' || l_code);
               end;
               bars_audit.error('222 счет='|| nls_);

               begin
                  select acc into l_acc from accounts where nls=nls_ and kv=980 and dazs is not null;
                  -- или закрыт или поменяли БРАНЧ
                  update accounts set dazs=null, tobo=k.branch where acc=l_acc;
                  update specparam_int set ob22=k.OB22_7R where acc=l_acc;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(l_acc, k.OB22_7R);
                  end if;
                  update accounts set ob22 = k.OB22_7R where acc=l_acc and (ob22 <> k.OB22_7R or ob22 is null);
                  k.r7_acc:=l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,980,nms_,'ODB',isp_,acc_);
                  k.r7_acc:=acc_;
                  --update accounts set tobo = k.branch,daos=dat31_ where acc= acc_;
                  update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                  update accounts set tobo = k.branch             where acc= acc_ and tobo <> k.branch ;
                  update specparam_int set ob22=k.OB22_7R where acc=acc_;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(acc_, k.OB22_7R);
                  end if;
                  update accounts set ob22 = k.OB22_7R where acc=acc_ and (ob22 <> k.OB22_7R or ob22 is null);
               end;
            end if;
            if k.NBS_7f is null then
               p_error( 8, k.NBS_rez||'/'|| k.OB22_rez,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.f7_nls,  'Рахунок резерву - '||k.r_nls);
               fl := 5;
               -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
            elsif instr(k.f7_nls,',') > 0 then
               p_error( 7, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                        k.kv, null, k.sz,k.f7_nls,  'Рахунок резерву - '||k.r_nls);
               fl  := 5;

            --счета не найдены
            elsif k.f7_acc is null then
               acc_:=null;
               nls_ := k.NBS_7f || '0' || substr(k.branch,9,6) || k.OB22_7f ||'0';
               nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
               nms_ := 'Формир.рез. ' || ',об22=' || k.OB22_7f || ',бранч=' || k.branch;
               k.r7_nls := nls_;

               begin
                  select isp, rnk into isp_,rnk_b  from v_gl
                  where kv=980 and branch = k.branch and nbs =k.NBS_7f and ostc<>0 and dazs is null and isp<>l_absadm and rownum=1;
               EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm; rnk_b :=to_number('1' || l_code);
               end;
               bars_audit.error('222 счет='|| nls_);
    
               begin
                  select acc into l_acc from accounts where nls=nls_ and kv=980 and dazs is not null;
                  -- или закрыт или поменяли БРАНЧ
                  update accounts set dazs=null, tobo=k.branch where acc=l_acc;
                  update specparam_int set ob22=k.OB22_7f where acc=l_acc;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(l_acc, k.OB22_7f);
                  end if;
                  update accounts set ob22 = k.OB22_7f where acc=l_acc and (ob22 <> k.OB22_7f or ob22 is null);
                  k.f7_acc := l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,980,nms_,'ODB',isp_,acc_);
                  k.f7_acc:=acc_;
                  --update accounts set tobo = k.branch,daos=dat31_ where acc= acc_;
                  update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                  update accounts set tobo = k.branch             where acc= acc_ and tobo <> k.branch ;
                  update specparam_int set ob22=k.OB22_7f where acc=acc_;
                  if sql%rowcount=0 then
                     insert into specparam_int(acc,ob22) values(acc_, k.OB22_7f);
                  end if;
                  update accounts set ob22 = k.OB22_7f where acc=acc_ and (ob22 <> k.OB22_7f or ob22 is null);
               end;

/*
               begin
                  select acc into l_acc from accounts
                  where nbs=k.nbs_7r and ob22 = k.ob22_7r and kv=980 and branch=k.branch and dazs is not null;
                  -- или закрыт или поменяли БРАНЧ
                  update accounts set dazs=null where acc=l_acc;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  p_error( 8, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                           k.kv, null,  k.sz, k.NBS_7r||'/'|| k.OB22_7r, 'Рахунок резерву - '||k.r_nls);
                  fl := 5;
               end;
*/
            end if;
            --logger.info('PAY1 : nbs_rez/ob22= ' || k.nbs_rez||'/'||k.ob22_rez|| ' NLS='||k.r_nls) ;
            begin
               savepoint sp;
               -- Определение параметров клиента и счета
               error_str :=null;
               --формирование проводок
               if fl = 0 then
                  begin
                     select * into par from NBS_OB22_PAR_REZ  where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=1;
                  EXCEPTION  WHEN NO_DATA_FOUND THEN
                     par.nazn      := '(?)';
                  END;
                  oo.nazn := par.nazn;
                  --тип операции
                  tt_ := 'ARE';
                  -- Определяем необходимый вид VOB

                  if b_date - dat31_ > l_day_year and dat01_=to_date('01-01-2016','dd-mm-yyyy')  THEN
                     vob_ := 99; -- корректирующие годовые
                     begin
                        select ostc into s_old_ from accounts where acc=k.r_acc; -- при годовых текущий остаток
                     EXCEPTION WHEN NO_DATA_FOUND THEN s_old_ := 0; 
                     end;
                     --logger.info('KORR99-1: vob_= ' || vob_||'ostc='||s_old_||'-'||k.r_acc||'-'||k.r_nls) ;
                  ElsIf TO_CHAR (b_date, 'YYYYMM') > TO_CHAR (dat31_, 'YYYYMM') THEN
                     vob_ := 96; -- корректирующие
                     -- узнать предыдущие остатки
                     s_old_ := k.sz;
                     -- logger.info('KORR99-2: vob_= ' || vob_||'ostc='||s_old_||'-'||k.r_acc||'-'||k.r_nls) ;
                  ELSE
                     vob_ := 6;  -- обычные
                     -- узнать предыдущие остатки
                     s_old_ := k.sz;
                     -- logger.info('KORR99-3: vob_= ' || vob_||'ostc='||s_old_||'-'||k.r_acc||'-'||k.r_nls) ;
                  END IF;

                  --новая сумма резерва
                  s_new_ := 0;
                  if s_old_ < 0 then-- увеличение резерва
                     r7702_acc := k.f7_acc;
                     r7702_    := k.f7_nls;
                     r7702_bal := k.NBS_7f||'/'||k.OB22_7f;
                     pap_77 (k.f7_acc,1); -- Корректировка признака актива-пассива по 7 кл.
                     diff_     := -(s_old_ - s_new_);
                     oo.dk := 0;
                  else--уменьшение резерва
                     r7702_acc := k.r7_acc;
                     r7702_    := k.r7_nls;
                     r7702_bal := k.NBS_7r||'/'||k.OB22_7r;
                     pap_77 (k.r7_acc,2);
                     diff_ := (s_old_ - s_new_);
                     oo.dk := 1;
                  end if;
                  -- узнать название нужных счетов для вставки в OPER
                  SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO nam_a_, nam_b_ FROM v_gl a, v_gl b
                  WHERE a.acc = k.r_acc and b.acc = r7702_acc;
                  error_str := error_str||'2';
                  -- проводка по расформированию резерва
                  IF mode_ = 0  THEN
                     gl.REF (ref_);
                     l_nd := substr(to_char(ref_),-10);
                  END IF;
                  error_str := error_str||'5';
                  IF    vob_ = 99 THEN oo.nazn := rasform_nazn_korr_year || oo.nazn;
                  ElsIf vob_ = 96 THEN oo.nazn := rasform_nazn_korr      || oo.nazn;
                  Else                 oo.nazn := rasform_nazn           || oo.nazn;
                  END IF;
                  error_str := error_str||'6';
                  if diff_ <> 0 THEN
                     IF mode_ = 0 then
                        INSERT INTO oper (REF   , tt    , vob    , nd    , dk  , pdat   , vdat  , datd  , datp  , nam_a , nlsa      , mfoa   , id_a   ,
                                          nam_b , nlsb  , mfob   , id_b  , kv  , s      , kv2   , s2    , nazn  , userid)
                                  VALUES (ref_  , tt_   , vob_   , l_nd  , oo.dk, SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls   , gl.amfo, okpoa_ ,
                                          nam_b_, r7702_, gl.amfo, okpoa_, k.kv, diff_  , 980   , gl.p_icurval (k.kv, diff_, dat31_), oo.nazn  , otvisp_);
                        error_str := error_str||'7';
                        gl.payv (l_pay, ref_, dat31_, tt_, oo.dk, k.kv, k.r_nls, diff_, 980, r7702_, gl.p_icurval (k.kv, diff_, dat31_));
                        error_str := error_str||'8';

                     end if;

                     INSERT INTO rez_doc_maket (tt   , vob , pdat , vdat   , datd  , datp      , nam_a , nlsa   , mfoa, id_a      , nam_b , nlsb,
                                                mfob , id_b, kv   , s      , kv2   , s2        , nazn  , userid , dk  , branch_a  , ref   )
                                        VALUES (tt_  , nvl(k.pr,0), SYSDATE, dat31_, b_date    , b_date, nam_a_ , k.r_nls,
                                                k.nbs_rez||'/'||k.ob22_rez , okpoa_, nam_b_    , r7702_, r7702_bal , okpoa_, k.kv,
                                                diff_, 980 , gl.p_icurval (k.kv, diff_, dat31_), oo.nazn , userid_, 2   , k.branch  , ref_  );
                     error_str := error_str||'9';
                  end if;
               end if;
            exception when others then rollback to sp;
               p_error( 9, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
                        k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7r||'/'|| k.OB22_7r|| substr(sqlerrm,instr(sqlerrm,':')+1),error_str );
            end;
         end loop;
         CLOSE c0;
      end if;
   END;

   if mode_ = 0 THEN
      z23.to_log_rez (user_id , -nn_ , dat01_ ,'Конец Проводки - Реальные '||'nal='||nal_);
   else
      z23.to_log_rez (user_id , -nn_ , dat01_ ,'Конец Проводки - МАКЕТ '||'nal='||nal_);
   end if;

   rez.p_unload_data;

END PAY_23_OB22  ;
/
show err;

PROMPT *** Create  grants  PAY_23_OB22 ***
grant EXECUTE                                                                on PAY_23_OB22     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PAY_23_OB22     to RCC_DEAL;
grant EXECUTE                                                                on PAY_23_OB22     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_23_OB22.sql =========*** End *
PROMPT ===================================================================================== 
