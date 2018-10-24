
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/forex.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FOREX 

is

g_header_version  constant varchar2(64)  := 'version 2 26.02.2018';
g_header_defs     constant varchar2(512) := '';

/*

 26.02.2018 Sta Доп.рекв о сделкам Форекс (с новым доп.параметром F092) для корректного формирования ф.510 (файл 3К XML).
                COBUMMFO-6808, COBUMMFO-6704 - Дзедзюсь Костя

 18.07.2017 Sta - передано напрямую. Все 92** проверены.
 28.10.2016 Sta Переоцінка до "справедл.вартості"= поточному оф.курсу коротких одноногих. 
 20.10.2016 Проверка возможности пролонгации второг ноги
 15.01.2015 Анул.поч.угоду + Анул.ВСЮ.угоду
 24-12-2014 Sta Возможность корр даты в пл.календаре по %% для Депо-свопов
 07.11.2014 Sta Процентні ставки на ресурси на М/Б ринку
 04.11.2014 Sta rev_swap_OB
 22.10.2014 Сухова:
            функция получения справедливой стоимости PV свопа p_swap на дату p_Dat
            Процедура Окончательного закрытия сделки FX_CLOSE
            функции получения типа FOREX-сделки  get_forextype, 2,  3 перенесена в заголовок - для внешнего использовани
*/



function header_version return varchar2; -- header_version - возвращает версию заголовка пакета
function body_version   return varchar2; -- body_version - возвращает версию тела пакета
------------------------------------------
function  GetW ( p_deal_tag number, p_tag varchar2) return varchar2   ; ---- Получить     Доп.рекв о сделкам Форекс
procedure SetW ( p_deal_tag number, p_tag varchar2,  p_val varchar2 ) ; ---  Установить   Доп.рекв о сделкам Форекс

function open_accF ( p_rnk  number,  p_nbs accounts.nbs%type,  p_kv accounts.kv%type ) return number ;

procedure open_accP ( p_swaptag    number,
  p_rnk        fx_deal_acc.rnk%type,
  p_fxtype     fx_deal_acc.fx_type%type,
  p_kvtype     fx_deal_acc.kv_type%type,
  p_kv         fx_deal_acc.kv%type,
  p_acc    out number ) ;
------------------------------------------
procedure REV_SPOT_OB (p_dat date, p_DEAL_TAG int ) ; -- 28.10.2016 Sta Переоцінка до "справедл.вартості"= поточному оф.курсу коротких одноногих. 

procedure LONG_TERM   (p_mode int , p_SWAP_TAG int, p_DEAL_TAG int ) ;
--Проверка возможности пролонгации второг ноги

function get_forextype (p_dat date, p_data date, p_datb date) return varchar2 ;
         --- функция получения типа FOREX-сделки только от платежных дат
-------------------------------------------------------------------------------
function get_forextype2 (p_swap number, p_dat date, p_data date, p_datb date) return varchar2;
         --- функция2 получения типа FOREX-сделки - с учетом СВОП
-------------------------------------------------------------------------------
function get_forextype3 (p_deal number) return varchar2;
         ---  функция3 получения типа FOREX-сделки по ее референсу : с учетом СВОП, с учетом процентов
-------------------------------------------------------------------------------

function get_forextype3k (p_deal number) return varchar2;
         ---  функция3K получения ОБОБЩЕННОГО типа FOREX-сделки по ее референсу (для доступа в таблицу FOREX_ob22)
         -- c разбивкой на ДЕПО-СВОП и ВАЛ-СВОП

-------------------------------------------------------------------------------
function IR_MB (p_FDAT date, p_kv int, p_term int) return number;
         ---  функция получения Процент/ставки на ресурси на М/Б ринку
-------------------------------------------------------------------------------
function PV1 (p_deal number, p_dat date) return number;
         ---  функция получения справедливой стоимости PV одной записи дату p_Dat
-------------------------------------------------------------------------------
function PVXR (p_swap number, p_deal number, p_dat date, p_kv number, p_IRE number) return number ;
         ---  функция получения справедливой стоимости PV по опному СВОПУ в целом при заданных ставках
-------------------------------------------------
function PVX (p_swap number, p_dat date) return number;
         ---  функция получения справедливой стоимости PV по опному СВОПУ в целом
------------------------------------------------------------------------------
procedure opl1 (p_oper in out oper%rowtype) ;
-------------------------------------------------------------------------------
procedure FX_CLOSE (p_dat date   ,  -- отчетная дата
                    p_deal number,  -- реф. одной записи                       или 0=ВСЕ \
                    p_swap number   -- реф. одного свопа (несколько записей )  или 0=все  \
                  );
     ---- Процедура Окончательного закрытия сделки
------------------------------------------------------------------

procedure get_fxacc (
  p_swaptag    number,
  p_rnk        number,
  p_fxtype     fx_deal_acc.fx_type%type,
  p_kva        number,
  p_kvb        number,
  p_acca   out number,
  p_accb   out number );

-------------------------------------------------------------------------------
procedure create_deal_EX (
  p_dealtype     number,   --   0 - обычный форекс,   1 - валютный своп ,  2 - депо своп 
  p_mode         number,   --   0 - обычный форекс,   1 - начальный своп,  2 - конечный своп,   3 - %% по своп,   4 - уменьшение срока своп
  p_deal_tag out fx_deal.deal_tag%type,
  p_swap_tag     fx_deal.swap_tag%type,
  p_ntik         fx_deal.ntik%type,
  p_dat          fx_deal.dat%type,
  p_kva          fx_deal.kva%type,
  p_data         fx_deal.dat_a%type,
  p_suma         fx_deal.suma%type,
  p_sumc         fx_deal.sumc%type,
  p_kvb          fx_deal.kvb%type,
  p_datb         fx_deal.dat_b%type,
  p_sumb         fx_deal.sumb%type,
  p_sumb1        fx_deal.sumb1%type,
  p_sumb2        fx_deal.sumb%type,
  p_rnk          fx_deal.rnk%type,
  p_nb           fx_deal.nb%type,
  p_kodb         fx_deal.kodb%type,
  p_swi_ref      fx_deal.swi_ref%type,
  p_swi_bic      fx_deal.swi_bic%type,
  p_swi_acc      fx_deal.swi_acc%type,
  p_nlsa         fx_deal.nlsa%type,            -- счет для входа валюты (документ по вал-а (FX3))
  p_swo_bic      fx_deal.swo_bic%type,
  p_swo_acc      fx_deal.swo_acc%type,
  p_nlsb         fx_deal.nlsb%type,            -- счет для отправки валюты (счет партнера)
  p_b_payflag    fx_deal.b_payflag%type,       -- флаг оплаты документа по валюте-Б (0-не платить, 1-СЭП(FX1), 2-SWIFT(FX4), 3-МО(FX6))
  p_agrmnt_num   fx_deal.agrmnt_num%type,
  p_agrmnt_date  fx_deal.agrmnt_date%type,
  p_interm_b     fx_deal.interm_b%type,
  p_alt_partyb   fx_deal.alt_partyb%type,
  p_bicb         fx_deal.bicb%type,
  p_curr_base    fx_deal.curr_base%type,
  p_telexnum     fx_deal.telexnum%type,
  p_kod_na       fx_deal.kod_na%type,
  p_kod_nb       fx_deal.kod_na%type,
  p_field_58d    fx_deal.field_58d%type,
  p_vn_flag      fx_deal.vn_flag%type,
  p_nazn         varchar2 ,
  p_f092         VARCHAR2 , --\ доп.реквизиты
  p_forex        VARCHAR2   --/
);


procedure create_deal (
  p_dealtype     number,   --   0 - обычный форекс,   1 - валютный своп ,  2 - депо своп 
  p_mode         number,   --   0 - обычный форекс,   1 - начальный своп,  2 - конечный своп,   3 - %% по своп,   4 - уменьшение срока своп
  p_deal_tag out fx_deal.deal_tag%type,
  p_swap_tag     fx_deal.swap_tag%type,
  p_ntik         fx_deal.ntik%type,
  p_dat          fx_deal.dat%type,
  p_kva          fx_deal.kva%type,
  p_data         fx_deal.dat_a%type,
  p_suma         fx_deal.suma%type,
  p_sumc         fx_deal.sumc%type,
  p_kvb          fx_deal.kvb%type,
  p_datb         fx_deal.dat_b%type,
  p_sumb         fx_deal.sumb%type,
  p_sumb1        fx_deal.sumb1%type,
  p_sumb2        fx_deal.sumb%type,
  p_rnk          fx_deal.rnk%type,
  p_nb           fx_deal.nb%type,
  p_kodb         fx_deal.kodb%type,
  p_swi_ref      fx_deal.swi_ref%type,
  p_swi_bic      fx_deal.swi_bic%type,
  p_swi_acc      fx_deal.swi_acc%type,
  p_nlsa         fx_deal.nlsa%type,            -- счет для входа валюты (документ по вал-а (FX3))
  p_swo_bic      fx_deal.swo_bic%type,
  p_swo_acc      fx_deal.swo_acc%type,
  p_nlsb         fx_deal.nlsb%type,            -- счет для отправки валюты (счет партнера)
  p_b_payflag    fx_deal.b_payflag%type,       -- флаг оплаты документа по валюте-Б (0-не платить, 1-СЭП(FX1), 2-SWIFT(FX4), 3-МО(FX6))
  p_agrmnt_num   fx_deal.agrmnt_num%type,
  p_agrmnt_date  fx_deal.agrmnt_date%type,
  p_interm_b     fx_deal.interm_b%type,
  p_alt_partyb   fx_deal.alt_partyb%type,
  p_bicb         fx_deal.bicb%type,
  p_curr_base    fx_deal.curr_base%type,
  p_telexnum     fx_deal.telexnum%type,
  p_kod_na       fx_deal.kod_na%type,
  p_kod_nb       fx_deal.kod_na%type,
  p_field_58d    fx_deal.field_58d%type,
  p_vn_flag      fx_deal.vn_flag%type,
  p_nazn         varchar2 );

-------------------------------------------------------------------------------
procedure p3800 (p_deal_tag fx_deal.deal_tag%type ) ;

procedure proc_swap (
  -- p_mode - режим выполнения процедуры:
  -- 0 - Разбить помесячно пл.календарь
  -- 1 - Пересчет сумм пл.календаря
  -- 2 - Сохранение FX-сделок по процентам
  p_mode     int,
  p_deal_tag number,
  p_basey_a  number,
  p_rate_a   number,
  p_basey_b  number,
  p_rate_b   number );

-------------------------------------------------------------------------------
procedure UPD1 (p_otm1 int, p_otm int, p_Deal number, p_PVX number, p_PVX1 number, p_IRAE number, p_IRBE number);
procedure rev_swap_OB (p_otm int, p_Deal number, p_PVX number, p_PVX1 number, p_IRAE number, p_IRBE number);
-------------------------------------------------------------------------------
procedure set_fxswap (p_dealtag number, p_npp number, p_suma number, p_sumb number, p_VDAT date);
-------------------------------------------------------------------------------------------------
procedure FX_DEL (p_mode int , p_tag number );
-- F1_Select(13,"FOREX.FX_DEL_DEL(1,:SWAP_TAG);Анул.поч.угоду "|| Str( :SWAP_TAG) || " ?; ОК !" )
-- F1_Select(13,"FOREX.FX_DEL_DEL(0,:DEAL_TAG,);Анул.ВСЮ.угоду "|| Str( :_TAG) || " ?; ОК !" )
-----------------------------------------------------------------------------
procedure set_int_ratn_mb ( p_date date, p_kv number, p_term number, p_ir number);
--Відсоткові ставки на  МБ ринку
end forex;
/
CREATE OR REPLACE PACKAGE BODY BARS.FOREX is

  g_body_version    constant varchar2(64)  := 'version 2 26.02.2018';

/*
01.10.2018 MDom В процедурі pay_forward_vn додано внутрішню функцію перевірки дати для коректного розкриття бухгалтерської моделі SPLIT-угод
                (коли одна з дат валютування в межах SPOT), щоб закриття внебалансу (9й клас) та рах.181902 відбувалися в один день
                (перша дата валютування або валюти А, або валюти Б)
28.09.2018 MDom В процедурі переоцінки одноногих угод REV_SPOT_OB, додана умова щоб при виконанні Finish/3800 Форекс-угод
                відбувалася переоцінка для SPLIT-угод коли одна з дат валютування у рамках SPOT а інша - більше дати угоди

12.09.2018 MDom В функцію get_forextype додана додаткова умова для Спліт-угод, коли одна з дат валютування у рамках SPOT а інша - більше дати угоди
                В процедуру pay_fx2, додана окрема обробка для Спліт-угод
                Логіка по Спліт-угодам перенесена в процедуру pay_split, яка раніше ніколи не визивалася

26.02.2018 Sta Доп.рекв о сделкам Форекс (с новым доп.параметром F092) для корректного формирования ф.510 (файл 3К XML).
               COBUMMFO-6808, COBUMMFO-6704 - Дзедзюсь Костя
18.07.2017 Sta - передано напрямую. Все 92** проверены.
05.07.2017 Sta Форекс-продукты в разрезе ДЛ/КОР + 1/2 (вал/депо) в всязи с переходом на новые бал счета 

10.03.2017 Sta закоментарено    ---- update oper   set dk  = 1, kv = xx.kva, nlsa = l_1819, s = xx.suma, kv2 = xx.kvb, nlsb = l_1819, s2 = xx.sumb where ref = xx.ref ;
24.02.2017 Sta + Алена Ш. Де-лонгация( но НЕ лонгация !!!!)  депо-свoпов
07.02.2017 Sta + Алена Ш. убрали переоц Похидных ФИ, которое БЕК
29.12.2016 STA Добили ... forex_ob22.S62 - лицетые счета. а не ББББ/ОО
28.12.2016 Sta Переоцінка до "справедл.вартості"= поточному оф.курсу коротких одноногих.

25.10.2016 Sta Лонгирование (отрезание и пришивание 2-й ноги) допускается только для ДЕПО-СВОПА
20.10.2016 Sta Длина kod = 15 Надо увеличить до 17  SWAP_FORWARD_Cnnn   nnn = количество сделок по процентам
               Защита от использования в филиалах . Только для гл.МФО !
               Проверка возможности пролонгации второг ноги

11/10/2015 Sta Доступ к сч6209 при переоц на финише (от технолога)
04.10.2016 Sta Испр ош при открытиии новых сч
02/09/2016 Sta Счета крд и деб задолж по переоценке до справ.стоимости - в разрезе контрагентов

27.02.2015 Sta + Билошицкая. Самоопределяющаяся виза в P3800/
                             Чтобы унифицировать отражение сделок в балансе, брать на позицию все (в т.ч. и налальные) сделки,
                             по которым дата валютирования - сегодня, при регламентном закрытии дня,
                             Либо при ручном запуске процедуры Finish 3800.

 03.02.2015 Sta Идентификация временем всех атоматных проводок
 22.01.2015 Sta Полное анулирование с процентами
 14.01.2015 Sta Анулирование
 08.01.2015 Sta Вставки(дооплаты)  вал.поз в существующие - по плану или по факту - в зависимости  от даты
                c 01.01.2015 отключен сбор в ПФ за безнал
 29-12-2014 Sta финальная переоцнека +  обнуление справедливой стоимости
 24-12-2014 Sta Возможность корр даты в пл.календаре по %% для Депо-свопов
 19.12.2014 Sta Уточнение от Дубинина по расч суммы переоц    23 323 048-25 861 545 =     -      196 013
 17.12.2014 Sta  forex.ob22.P_SPOT = 1 Признак розрахунку РКР-3 від СЗККВ/СЗКПВ по рах.вал.поз
                                       Иначе по правилам ПОХИДНЫХ ФИ - Рыбалко Л
*/

--------------------------------------------- constants
   g_body_defs       constant varchar2(512) := '';
   g_modcode         constant varchar2(3)   := 'FX';
   g_fxmode_forex    constant number        := 0; -- обычный форекс
   g_fxmode_swap     constant number        := 1; -- валютный своп
   g_fxmode_dsw      constant number        := 2; -- депо своп
   g_fxtype_tod      constant varchar2(10)  := 'TOD';
   g_fxtype_split    constant varchar2(10)  := 'SPLIT';
   g_fxtype_spot     constant varchar2(10)  := 'SPOT';
   g_fxtype_forward  constant varchar2(10)  := 'FORWARD';
--------------------------------------------- variables
   g_bankmfo         varchar2(6)  ;
   g_bankname        varchar2(38) ;
   g_bankokpo        varchar2(14) ;
   g_bankbic         varchar2(14) ;
   g_FX_3540         varchar2(14) ; -- расчетный счет дебиторской задолжености
   g_FX_3640         varchar2(14) ; -- расчетный счет кредиторской задолжености
   g_FX_3540N        varchar2(14) ; -- расчетный счет дебиторской задолжености для НЕрезидентов
   g_FX_3640N        varchar2(14) ; -- расчетный счет кредиторской задолжености для НЕрезидентов
   g_FX_PFDB         varchar2(14) ; -- Нарахування збору в ПФ: Рах.Дебет
   g_FX_PFCR         varchar2(14) ; -- Нарахування збору в ПФ: Рах.Кредит
   g_FX_SPOT         varchar2(3)  ; -- код операции SPOT
   g_VOB_FX2V        number       ; -- vob для ВАЛ-ВАЛ
   g_VOB_FX2GV       number       ; -- vob для ГРН-ВАЛ
   g_VOB_FX2VG       number       ; -- vob для ВАЛ-ГРН
   g_VOB_VAL         number       ; -- vob
   l_nls_1819        varchar2(14) ;
   l_nls_3540        varchar2(14);
   l_nls_3640        varchar2(14);
   l_dealtype        number;

-- types
   type t_cust is record ( nmk   varchar2(38),
                           okpo  customer.okpo%type,
                           rezid number,
                           kod_b custbank.kod_b%type,
                           kod_g customer.country%type );
-------------------------------------------------------------------------------
function header_version return varchar2 is begin return 'Package HEADER FOREX ' || g_header_version || '.' || chr(10)   || 'AWK definition: ' || chr(10)   ||  g_header_defs; end header_version;
function body_version   return varchar2 is begin return 'Package BODY FOREX '   || g_body_version   || '.' || chr(10) || 'AWK definition: ' || chr(10)  || g_body_defs; end body_version;
-------------------------------------------------------------------------------
function  GetW ( p_deal_tag number, p_tag varchar2) return varchar2  Is  ---- Получить     Доп.рекв о сделкам Форекс
                                                     l_val varchar2 (200);
begin 
  begin select w.value into l_Val from operw w, fx_deal d where d.Deal_Tag = p_Deal_Tag and d.Ref = w.Ref and w.tag = p_Tag ;
  exception when no_data_found then null;
  end;
  Return l_Val ;
end GetW;

procedure SetW ( p_deal_tag number, p_tag varchar2,  p_val varchar2 ) is  --- Установить   Доп.рекв о сделкам Форекс
  l_Ref number;
begin
  begin select REF into l_ref from fx_deal where deal_tag = p_deal_tag;
  exception when no_data_found then raise_application_error(-(20203), 'Не знайдено FOREX-угоду = ' || p_deal_tag );
  end;
  begin insert into operw (REF, TAG, VALUE) values ( l_Ref,  p_TAG, p_VAL );
  exception when others then   if SQLCODE = - 00001 then null;   else raise; end if; --ORA-00001: unique constraint (BARS.XPK_CPTAG) violated
  end;
end SetW ;
--------------

procedure REV_SPOT_OB (p_dat date, p_DEAL_TAG int ) is -- 28.10.2016 Sta Переоцінка до "справедл.вартості"= поточному оф.курсу коротких одноногих.
  l_Kod  varchar2(30)   := 'SPOT';
  ff forex_ob22%rowtype ;
  dd accounts%rowtype   ;
  kk accounts%rowtype   ;
  a6 accounts%rowtype   ;
  oo oper%rowtype       ;
  l_Deb number ;
  l_crd number ;
begin
  If gl.aMfo <> F_Get_Params ('GLB-MFO')  then  RETURN ;  end if;

  begin  select * into ff from forex_ob22 where kod = l_kod  ;
  exception when no_data_found then raise_application_error(-(20203), 'Не налаштовано (в forex_ob22) параметри переоцiнки для ' || l_kod);
  end;

  begin select * into a6 from accounts where kv=gl.baseval and nls = ff.s62 and dazs is null and rownum=1 ;
  exception when no_data_found then  raise_application_error(-(20203), 'Не знайдено для '|| l_kod || ' рах ' || ff.s62  );
  end;
  ---------------------------------

for xx in (select x.*
			 from fx_deal x
			where x.swap_tag is null
              --and FOREX.get_forextype3K(x.deal_tag) = l_kod --2018.09.28 закоментовано
              --2018.09.28 нова умова, щоб відбувалася переоцінка для SPLIT-угод коли дати валютування > дати угоди та одна з дат валютування у рамках SPOT
              and (forex.get_forextype3K(x.deal_tag) = l_kod or
                   (forex.get_forextype3K(x.deal_tag) = 'SPLIT' and x.dat_a > x.dat and x.dat_b > x.dat))
              ----
              and EXISTS (SELECT 1
						   FROM oper
						  WHERE REF = x.REF
							AND sos > 0)
              AND NVL (x.sos, 10) < 15
			  and x.DEAL_TAG = decode(p_DEAL_TAG, 0, x.DEAL_TAG, p_DEAL_TAG))
loop

  dd.NBS    := substr(ff.s3d,1,4) ;
  dd.ob22   := substr(ff.s3d,6,2) ;
  begin select * into dd from accounts where kv=gl.baseval and nbs=dd.NBS and ob22=dd.ob22 and dazs is null and rnk=xx.rnk and rownum=1;
  exception when no_data_found then
        dd.acc  := FOREX.open_accF (xx.rnk, dd.NBS, gl.baseval);
        accreg.setAccountSParam(dd.acc, 'OB22', dd.ob22 );
        begin select * into dd from accounts where acc = dd.acc;
        exception when no_data_found then raise_application_error(-(20203), 'Не знайдено '||ff.s3d ||  ' для РНК='||xx.rnk );
        end ;
  end;

  kk.NBS  := substr(ff.s3k,1,4) ;
  kk.ob22 := substr(ff.s3k,6,2) ;
  begin select * into kk from accounts where kv=gl.baseval and nbs=kk.NBS and ob22=kk.ob22 and dazs is null and rnk=xx.rnk and rownum=1;
  exception when no_data_found then
    kk.acc  := FOREX.open_accF (xx.rnk, kk.NBS, gl.baseval);
    accreg.setAccountSParam(kk.acc, 'OB22', kk.ob22 );
    begin select * into kk from accounts where acc = kk.acc;
    exception when no_data_found then raise_application_error(-(20203), 'Не знайдено '||ff.s3k ||  ' для РНК='||xx.rnk );
    end ;
  end;

  ---------
  oo.kv    := gl.baseval;
  oo.kv2   := gl.baseval;
  oo.tt    := 'FXP';
  oo.vob   := 6;
  oo.datd  := p_dat;
  oo.ref   := xx.ref; ----null;
  oo.nazn  := 'Переоцiнка SPOT-угоди '||xx.ntik||' вiд '||to_char(xx.dat,'dd.mm.yyyy')||' по офіційному курсу валют станом на '||to_char(p_dat,'dd.mm.yyyy');
  oo.nlsa  := a6.nls;
  oo.nam_a := substr(a6.nms,1,38) ;

  oo.d_rec :='Обнулення суми порередньої переоцінки'    ;
  select sum ( decode (dk,1,1,-1) * decode(acc,dd.acc,s,0) ),  sum ( decode (dk,1,1,-1) * decode(acc,kk.acc,s,0) ) into l_Deb, l_crd
  from opldok  where ref = xx.ref and sos >= 4  and acc in (dd.acc, kk.acc);

  If l_Deb <> 0 then   oo.nlsb := dd.nls   ; oo.nam_b := substr(dd.nms,1,38)  ;
     If l_Deb > 0 then oo.dk   := 0 ; oo.s :=  l_Deb  ;
     else              oo.dk   := 1 ; oo.s := -l_Deb  ;
     end if;           oo.s2   := oo.s     ;
     FOREX.opl1(oo) ;  gl.pay ( 2, oo.ref, gl.bdate)  ;
  end if;

  If l_crd <> 0 then   oo.nlsb := kk.nls   ; oo.nam_b := substr(kk.nms,1,38)  ;
     If l_crd > 0 then oo.dk   := 0 ; oo.s :=  l_crd  ;
     else              oo.dk   := 1 ; oo.s := -l_crd  ;
     end if;           oo.s2   := oo.s     ;
     FOREX.opl1(oo) ;  gl.pay ( 2, oo.ref, gl.bdate)  ;
  end if;

  If oo.ref is not null then  gl.pay ( 2, oo.ref, gl.bdate); end if ;

  If xx.dat_a > p_dat and xx.dat_b > p_dat then oo.s := gl.p_icurval ( xx.kva, xx.suma, p_dat) - gl.p_icurval ( xx.kvb, xx.sumb, p_dat) ;
     If oo.s <> 0    then  oo.d_rec :='Формування суми поточної переоцінки'   ;
        If oo.s > 0  then oo.dk   := 0 ; oo.nlsb := dd.nls   ; oo.nam_b := substr(dd.nms,1,38) ;
        else              oo.dk   := 1 ; oo.nlsb := kk.nls   ; oo.nam_b := substr(kk.nms,1,38) ; oo.s := - oo.s;
        end if;           oo.s2   := oo.s  ;
        FOREX.opl1(oo) ;  gl.pay ( 2, oo.ref, gl.bdate)  ;
     end if;
  end if;
end loop;

end REV_SPOT_OB;
--------------------------------

procedure LONG_TERM (p_mode int , p_SWAP_TAG int, p_DEAL_TAG int ) is
 --Проверка возможности пролонгации второг ноги
  sErr_ varchar2 (520);
  XX1 fx_deal%rowtype ;
  i_ int;
begin

  pul.put ( tag_ =>'DEAL_TAG', val_ => to_char(p_DEAL_TAG) );

  If p_mode = 0 then
     sErr_ :='Вибрано угоду '|| p_DEAL_TAG || '. ';

     -- Надо выделить конечную сделку ДЕПО СВОП
     If    p_SWAP_TAG is Null      then  raise_application_error(-20000, sErr_ ||'Вона НЕ є СВОП-угодою');
     ElsIf p_DEAL_TAG = p_SWAP_TAG then  raise_application_error(-20000, sErr_ ||'Вона Є першою "ногою" СВОП-угоди');
     end if;

     begin select * into XX1 from fx_deal f  where deal_tag = p_DEAL_TAG   and exists
          (select 1 from fx_deal where deal_tag = f.swap_tag and suma = f.sumb and kva = f.kvb);
     exception when no_data_found  then  raise_application_error(-20000, sErr_ ||'НЕ знайдено її першу "ногу" ');
     end;
/*
28/09/2016    840    100000    28/09/2016    980    2500000    21494701    21494701  1-я нога
12/12/2016    980    2500000    12/12/2016    840    100000    21494801    21494701  2-я нога
30/09/2016    980    626    30/09/2016    840    26    21494901    21494701
31/10/2016    980    6459    31/10/2016    840    259    21495001    21494701
30/11/2016    980    6251    30/11/2016    840    251    21495101    21494701
12/12/2016    980    2292    12/12/2016    840    92    21495201    21494701
*/
     select count(*) into i_ from fx_deal where swap_tag = XX1.swap_tag and deal_tag not in (p_DEAL_TAG, xx1.swap_tag);

     If i_ = 0 then
        raise_application_error(-20000, sErr_ ||'Вона НЕ є ДЕПО-СВОП-угодою');  --      pul.put(tag_ =>'PAR_SWAP', val_ =>'1' ); -- 1 = 'SWAP'
     else        pul.put(tag_ =>'PAR_SWAP', val_ =>'2' ); -- 2 'DSW'
     end if;
  -- select pul.get('PAR_SWAP') into par_1_2  from dual;

  end if;

end LONG_TERM;
-------------------------
function to_n (p_str varchar2) return number is   n number;
  begin  begin n := to_number(p_str);  exception when others then     n := null;  end;   return n;  end to_n;
-------------------------------------------------------------------------------
-- init
-- инициализация переменных
--
procedure init  is
begin

  g_bankmfo     := gl.amfo;
  g_bankname    := substr(getglobaloption('NAME'),1,38);
  g_bankokpo    := f_ourokpo;
  g_bankbic     := getglobaloption('BICCODE');
                -----------------------------------------
  g_FX_3540     := substr(trim(getglobaloption('FX_3540')),1,14);
  g_FX_3640     := substr(trim(getglobaloption('FX_3640')),1,14);
  g_FX_3540N    := substr(trim(getglobaloption('FX_3540N')),1,14);
  g_FX_3640N    := substr(trim(getglobaloption('FX_3640N')),1,14);
  g_FX_PFDB     := substr(trim(getglobaloption('FX_PF_DB')),1,14);
  g_FX_PFCR     := substr(trim(getglobaloption('FX_PF_CR')),1,14);
  g_FX_SPOT     := substr(trim(getglobaloption('FX_SPOT')),1,3);
  g_VOB_FX2V    := to_n(trim(GetGlobalOption('FX2V')));
  g_VOB_FX2GV   := to_n(trim(GetGlobalOption('FX2GV')));
  g_VOB_FX2VG   := to_n(trim(GetGlobalOption('FX2VG')));
  g_VOB_VAL     := nvl(to_n(trim(GetGlobalOption('MBK_VZAL'))),6);

end init;

------------------------------------------------------------------
function get_forextype (p_dat date, p_data date, p_datb date) return varchar2  IS
         --- функция получения типа FOREX-сделки только от платежных дат
  l_fxtype varchar2(10);  l_dat    date;
begin  l_dat := dat_next_u( p_dat, 2);

  if p_dat = p_data and p_dat = p_datb         then  l_fxtype := g_fxtype_tod    ;  -- 1 - TOD - день в день
  elsif p_dat = p_data and p_datb > p_dat
     or p_dat = p_datb and p_data > p_dat      then  l_fxtype := g_fxtype_split  ;  -- 1a - SPLIT
  --COBUMMFO-7334 когда одна из дат A/B в пределах SPOT, а другая отличается, тоже определяем как SPLIT
  elsif (p_data between p_dat and l_dat and
         p_data <> p_datb and p_datb > p_dat) or 
        (p_datb between p_dat and l_dat and
         p_data <> p_datb and p_datb > p_dat)  then  l_fxtype := g_fxtype_split  ;  -- 1a - SPLIT
  ----
  elsif p_dat < p_data and p_data <= l_dat and
        p_dat < p_datb and p_datb <= l_dat     then  l_fxtype := g_fxtype_spot   ;  -- 2 - SPOT
  else                                               l_fxtype := g_fxtype_forward;  -- 3 - FORWARD
  end if;
  return l_fxtype;
end get_forextype;

-------------------------------------------------------------------------------
function get_forextype2 (p_swap number, p_dat date, p_data date, p_datb date) return varchar2 is
         --- функция2 получения Ключа-типа FOREX-сделки - с учетом СВОП
  l_kod varchar2(30);
begin
  l_kod := FOREX.GetW(p_swap, 'FOREX');
  If l_kod  is     null then  l_kod := trim( FOREX.get_forextype (p_dat, p_data, p_datb ) ) ; end if ;
  If p_swap is NOT null then  l_kod := 'SWAP_' || l_kod; end if;
  return l_kod ;
end get_forextype2 ;

-------------------------------------------------------------------------------
function get_forextype3 (p_deal number) return varchar2 is
         ---  функция3 получения типа FOREX-сделки по ее референсу : с учетом СВОП, с учетом процентов
  xx  fx_deal%rowtype ;  R_Kod  varchar2(30) ;
  l_kod1 varchar2(30) ;  l_kod2 varchar2(30) ;  l_kod3 varchar2(30) ;  l_nom  number := 0  ;  l_kol  number := 0  ;
begin

  begin select * into xx from fx_deal where deal_tag = p_deal;   exception when no_data_found then null;   end;

  If    xx.SWAP_TAG is NOT null and xx.SWAP_TAG =  xx.DEAL_TAG  then l_kod3 := '_B0' ;
  ElsIf xx.SWAP_TAG is NOT null and xx.SWAP_TAG <> xx.DEAL_TAG  then select min(deal_tag), count(*)  into  xx.deal_tag , l_kol  from fx_deal where SWAP_TAG = xx.SWAP_TAG and deal_tag <> xx.SWAP_TAG;
     If l_kol  > 0 then                                              select * into xx from fx_deal where deal_tag = xx.deal_tag;
        for k in (select * from fx_deal where SWAP_TAG=xx.SWAP_TAG and deal_tag <= p_deal and deal_tag <> xx.SWAP_TAG order by deal_tag )
        loop
           if l_nom = 0 then l_kod3 := '_EN' ;
           Else              l_kod3 := '_C' || l_nom ;
           end if;
           l_nom  := l_nom + 1;
        end loop;
     end if;
  end if;

  R_Kod := FOREX.GetW (p_Deal, 'FOREX') ;
  If R_Kod  is null then   
     l_kod2 := FOREX.get_forextype (xx.dat, xx.dat_a,xx.dat_b ) ;
     If    xx.SWAP_TAG is  null then   l_kod1 := ''           ;
     ElsIf l_kol > 1            then   l_kod1 := 'D.SWAP_'    ;
     else                              l_kod1 := 'V.SWAP_'    ;
     end if;
     R_Kod := Substr( l_kod1||l_kod2, 1, 30 ) ;
  end if;

  RETURN Substr( R_kod||l_kod3, 1, 30 ) ;

end get_forextype3;

-------------------------------------------------------------------------------
function get_forextype3K (p_deal number) return varchar2 is
         ---  функция3K получения ОБОБЩЕННОГО типа FOREX-сделки по ее референсу (для доступа в таблицу FOREX_ob22)
         -- c разбивкой на ДЕПО-СВОП и ВАЛ-СВОП
  l_kod varchar2(30); l_Tmp int;
begin
  l_Kod := FOREX.get_forextype3 ( p_deal);
  l_Tmp := instr (l_kod, '_',      -1 )  ;
  if l_Tmp > 0 then  l_Kod := substr(l_kod,  1 , l_Tmp-1 )  ; end if;
  Return (l_kod) ;
end  get_forextype3K;
-----------------------------------------
function IR_MB (p_FDAT date, p_kv int, p_term int) return number is
    ---  функция получения Процент/ставки на ресурси на М/Б ринку строго на отчетную дату
    --   l_fdat date;
    l_TM int; l_TX int;  l_RM number; l_RX number; l_RS number;

begin

  select max(term) into l_TM from int_ratn_mb where kv = p_kv and term <= p_term and fdat = p_FDAT;

  If l_TM  is null then
     RETURN to_number (null);
--raise_application_error(-20000, 'Відсутні М/Б ставки по вал=' || p_kv || ' що <= терміну '|| p_term || ' на дату ' || to_char(p_FDAT,'dd.mm.yyyy')  );
  end if;

  select min(term) into l_TX from int_ratn_mb  where kv = p_kv and term >= p_term and fdat = p_FDAT ;
  If l_TX  is null then
     RETURN to_number (null);
     --raise_application_error(-20000, 'Відсутні М/Б ставки по вал=' || p_kv || ' що >= терміну '|| p_term || ' на дату ' || to_char(p_FDAT,'dd.mm.yyyy')  );
  end if;

  select ir into l_RM from int_ratn_mb where kv = p_kv and term = l_TM and fdat = p_FDAT ;
  select ir into l_RX from int_ratn_mb where kv = p_kv and term = l_TX and fdat = p_FDAT ;

  l_RS := l_RM + div0 ( (l_RX - l_RM ) * ( p_term - l_TM ) , ( l_TX - l_TM ) ) ;

  Return greatest (0,l_RS) ;

/*
From: Дубінін Вячеслав Олександрович [mailto:DubininVO@oschadbank.ua]
Sent: Monday, November 03, 2014 4:20 PM
To: Татьяна Сухова
Subject: Интреполяция ставок

Входящие данные:
% ставка по кредитам МБК на 30 дн. (1 мес) = 12%
% ставка по кредитам МБК на 90 дн. (3 мес) = 18%
Задача : найти % ставку по кредиту МБК сроком 54 дня.
Решение: %ставка на 54 дня = %ставка 30 дн + (%ставка 90 дн - %ставка 30 дн) / (90 дн – 30 дн) * (54 дн – 30 дн) = 12% +  (18%-12%) / (90 – 30) * (54 – 30) = 14,40%

Пусть в справочнике есть только ограниченный интервал значений сроков ( например, два значения для 30 и 90 дней.)
•    Для  промежуточн. в интервале  значения  30  <  54  < 90 - ясно
•    Для пограничного  в интервале  значения  30  =  30  < 90 - ясно
Прошу вашего примера для краевых ситуаций, Например
•    Вне интервала слева  3 <  30  <  90
•    Вне интервала слева       30  <  90  < 200
Если исходить из того, что  сроки 1<...<30<...<90<...<99999…  будут всегда ,  то мой вопрос снимается.
*/

end IR_MB;

-------------------------------------------------------------------------------
function PV1 (p_deal number, p_dat date) return number is   ---  функция получения справедливой стоимости PV одной записи на  дату p_Dat
 l_pv number;
begin    -- жду алгоритма от ОБ. FА пока - просто какая-то формула, не имеет никакого смфсла !
  begin  select gl.p_icurval(kva,suma,p_dat) - gl.p_icurval(kvb,sumb,p_dat) into l_PV from fx_deal where deal_tag =p_deal;
  exception when no_data_found  then l_pv := 0;
  end  ;    return round(l_pv,0) ;
end PV1;

-------------------------------------------------------------------------------
function PVXR (p_swap number, p_deal number, p_dat date, p_kv number, p_IRE number) return number  is
   ---  функция получения справедливой стоимости PV по одной стороне в номинале  -- Дисконтирование
   -- p_IRE не использую . т.к. все равно пересчитываю
   l_PV number := 0;     xx fx_deal%rowtype;
   -----------------
   function PVXR1  (xx fx_deal%rowtype, p_kv number, p_dat date ) return number is
            l_T  number;
            l_R  number;
            l_PV number ;
   begin    If p_kv  = xx.kva  then
               l_T  := (xx.dat_A-p_DAT) ; l_R := FOREX.IR_MB ( p_DAT, xx.KVA, l_T ) / 100 ; -- Срок + средняя  МБ ставка
               l_PV := round ( xx.sumA  / POWER ( (1+l_R), l_T/365 ), 0) ;                  -- Спрапв.стоимость
            Else
               l_T  := (xx.dat_B-p_DAT) ; l_R := FOREX.IR_MB ( p_DAT, xx.KVB, l_T ) /100 ; -- Срок + средняя  МБ ставка
               l_PV := round ( xx.sumB  / POWER ( (1+l_R), l_T/365 ), 0) ; -- Спрапв.стоимость
            end if;
            Return l_PV;
   end PVXR1;
   -----------------
begin
   begin  select * into xx from fx_deal where deal_tag = p_deal;
      If p_swap = p_deal then   l_PV := PVXR1( xx, p_kv,  p_dat ) ;
      Else
         for x in (select * from fx_deal where swap_tag = p_swap and deal_tag <> p_swap and decode (kva,p_kv,dat_A,dat_B) > p_DAT order by dat_a)
         loop           l_PV := l_PV +  PVXR1( x , p_kv,  p_dat ) ;  end loop;
      end if;

   exception when no_data_found then l_PV  := 0 ;
   end  ;
   RETURN l_PV ;
end PVXR;

-------------------------------------------------------------------------------
function PVX (p_swap number, p_DAT date) return number is
         ---  функция получения справедливой стоимости PV по опному СВОПУ в целом - жду формулу от ОБ
  l_TA  int ;  l_RA number ;  l_PVA number := 0; l_PVqA number := 0;
  l_TB  int ;  l_RB number ;  l_PVB number := 0; l_PVqB number := 0;  l_PVq number := 0;
  xx  fx_deal%rowtype ;
begin

    -- возвратная сделка по телу свопа
    select NVL(min(deal_tag), p_swap)  into xx.deal_tag   from fx_deal where swap_tag = p_swap and deal_tag <> p_swap;
    If xx.deal_tag is NOT null then      select * into xx from fx_deal where deal_tag = xx.deal_tag;

       -- По стороне А
       l_TA := xx.dat_a - p_DAT ;               -- срок размещения
       If l_TA = 0 then  l_PVA  := xx.sumA ;    -- Справ. стоимость = бал.стоимости
       else
--        l_RA  := FOREX.IR_MB ( p_FDAT => p_DAT , p_kv   => xx.KVA,      p_term => l_TA) ; --  средняя  МБ ставка
          l_PVA := FOREX.PVXR  ( p_swap => p_swap, p_deal => xx.deal_tag, p_dat  => p_dat , p_kv => xx.kva, p_IRE => null );
       end if;

       -- По стороне Б
       l_TB := xx.dat_b - p_DAT ;               -- срок размещения
       If l_TB = 0 then  l_PVB  := xx.sumB ;    -- Справ. стоимость = бал.стоимости

       Else

--        l_RB  := FOREX.IR_MB ( p_FDAT => p_DAT , p_kv => xx.KVB,        p_term => l_TB) ;
          l_PVB := FOREX.PVXR  ( p_swap => p_swap, p_deal => xx.deal_tag, p_dat  => p_dat , p_kv => xx.kvB, p_IRE => null );
       end if;

    end if;

    -- Справ. стоимость в экв на отч. дату
   l_PVqA := gl.p_icurval( xx.kvA, round(l_PVA,0), p_DAT);
   l_PVqB := gl.p_icurval( xx.kvB, round(l_PVB,0), p_DAT);
   l_PVq  := l_PVqA - l_PVqB ;
   RETURN l_PVQ ;
end pvx;

-------------------------------------------------------------------------------
procedure opl1 (p_oper in out oper%rowtype) is
begin
  if p_oper.ref is null then
     gl.ref (p_oper.ref);
     gl.in_doc3 (ref_  => p_oper.ref , tt_   => p_oper.tt, vob_   => p_oper.vob  , nd_   => to_char(p_oper.ref),  pdat_ => sysdate ,
                 vdat_ => gl.bDate   , dk_   => p_oper.dk, kv_    => p_oper.kv   , s_    => p_oper.s   , kv2_    => p_oper.kv2,
                 s2_   => p_oper.s2  , sk_   => p_oper.sk, data_  => p_oper.datd , datp_ => gl.bdate   , nam_a_ => p_oper.nam_a,
                 nlsa_ => p_oper.nlsa, mfoa_ => gl.aMfo  , nam_b_ => p_oper.nam_b, nlsb_ => p_oper.nlsb, mfob_  => gl.aMfo,
                 nazn_ => p_oper.nazn, d_rec_=> null     , id_a_  => p_oper.id_a , id_b_ => p_oper.id_b, id_o_  => null,
                 sign_ => null       , sos_  => null     , prty_  => 0           , uid_  => null );
  end if;
  gl.payv(0, p_oper.ref, gl.bdate, p_oper.tt, p_oper.dk, p_oper.kv, p_oper.nlsa, p_oper.s, p_oper.kv, p_oper.nlsb, p_oper.s);
  update opldok set txt = substr(to_char(sysdate,'dd.mm.yy hh24:mi:ss#') || p_oper.d_rec,1,70)  where ref = p_oper.ref and stmt = gl.aStmt;
end opl1;

-------------------------------------------------------------------------------
procedure FX_CLOSE (p_dat date   ,  -- отчетная дата
                    p_deal number,  -- реф. одной записи                       или 0=ВСЕ \
                    p_swap number   -- реф. одного свопа (несколько записей )  или 0=все  \
                  ) IS
  ---- Процедура Окончательного закрытия сделки
  l_dat date := nvl ( p_dat, gl.BDate);

  procedure FX_CLOSE1 (p_dat date, xx fx_deal%rowtype ) is
     l_sos int ;     l_kod varchar2 (30); l_PVq number ;
  begin
      if (xx.dat_a > p_dat and
		  xx.dat_b > p_dat)
	   OR
         (xx.dat_a = xx.dat and
		  xx.dat_b = xx.dat and
		  xx.dat = p_dat )     then
        l_sos := 10 ; -- НеЗавершенные сделки-ОДИНОЧКИ и части СВОПОВ/ Расчет еще НЕ наступил
      Elsif xx.dat_a = p_dat OR 
			xx.dat_b = p_dat then
        l_sos := 12 ; -- пл.дата наступила - хотябы по одной из сторон

      Elsif xx.dat_a < p_dat and xx.dat_b < p_dat then
         If xx.swap_tag is null                   then
		   l_sos := 15 ; -- Завершенные сделки-ОДИНОЧКИ
         Else
		   l_sos := 14 ; -- Завершенные части СВОПА
           begin
			 select 14
			   into l_sos
			   from dual
		      where exists (select 1 from fx_deal where swap_tag = xx.swap_tag and ( dat_a>= p_dat or dat_b >= p_dat) );
            exception when no_data_found then 
			  l_sos := 15 ; -- Завершенный СВОП
            end ;
         end if ;
      end if ;
      update fx_deal set sos= l_sos where deal_tag = xx.deal_tag ;

      -- в платежную дату (промежуточную или финальную)
      If least ( xx.dat_a, xx.dat_b) = p_dat then
         -- взять на вал.поз.
         FOREX.p3800 ( xx.deal_tag);

         l_kod := FOREX.get_forextype3 (xx.deal_tag );
         If l_kod like '%EN' then

            -- в платежную дату возвратного платежа (только в  финальную ! ) / Справедливая стоимость - по оф.курсу
            l_PVq := gl.p_icurval( xx.kva, xx.suma, gl.bdate ) -  gl.p_icurval( xx.kvb, xx.sumb, gl.bdate );

            -- финальная переоцнека
            FOREX.UPD1( 0, 1, xx.DEAL_TAG, l_PVq/100, xx.sump/100, 0, 0) ;
         end if;
         -- обнуление справедливой стоимости
         FOREX.UPD1( 0, 1, xx.DEAL_TAG, 0, l_PVq/100, 0, 0) ;
      end if;

  end FX_CLOSE1 ;
  ---------------
begin
  -- Защита от использования в филиалах . Только для гл.МФО !
  If gl.aMfo <> F_Get_Params('GLB-MFO')  then  RETURN ;  end if;
  ------------------------------------------------------------------
  If p_swap = 0 and p_deal = 0  then  forex.REV_SPOT_OB (p_dat => gl.bdate, p_DEAL_TAG =>0  ); end if;
  ------------

  for xx in ( select * from fx_deal where nvl(sos,0) < 15 )
  loop
    If  p_swap  = 0            and  p_deal  = 0            OR
        p_swap  = 0            and  p_deal  = xx.deal_tag  OR
        p_swap  = xx.swap_tag  and  p_deal  = 0            OR
        p_swap  = xx.swap_tag  and  p_deal  = xx.deal_tag     then
        FX_CLOSE1 (l_dat, xx);
    end if;
  end loop;

end FX_CLOSE;

-------------------------------------------------------------------------------
-- set_sparam
-- процедура установки спецпараметров счета
--
procedure set_sparam (p_acc number)
is
  l_sp_name    sparam_list.name%type;
  l_sp_tabname sparam_list.tabname%type;
  l_sp_tag     sparam_list.tag%type;
begin

  -- спецпараметры
  for z in ( select s.sp_id, s.value
               from accounts a, fx_deal_accsparam s
              where a.acc = p_acc
                and a.nbs = s.nbs
                and s.value is not null )
  loop
     begin
        select name, tabname, tag into l_sp_name, l_sp_tabname, l_sp_tag
          from sparam_list
         where spid = z.sp_id;
        if upper(l_sp_tabname) = 'ACCOUNTSW' and l_sp_tag is not null then
           accreg.setAccountwParam(p_acc, l_sp_tag, z.value);
        else
           accreg.setAccountSParam(p_acc, l_sp_name, z.value);
        end if;
     exception when no_data_found then null;
     end;
  end loop;

end set_sparam;

-------------------------------------------------------------------------------
-- set_rate
-- процедура установки % ставки счета
--
procedure set_rate (p_acc number, p_basey number, p_rate number)
is
  l_id  number;
  l_dat date;
  l_ir  number;
  l_br  number;
begin
  if p_acc is not null then
     select pap-1 into l_id from accounts where acc = p_acc;
     begin
        insert into int_accn (acc, id, metr, basem, basey, freq, tt, io)
        values (p_acc, l_id, 0, null, p_basey, 1, '%%1', 0);
        insert into int_ratn (acc, id, bdat, ir, br, op)
        values (p_acc, l_id, gl.bdate, p_rate, null, null);
     exception when dup_val_on_index then
        update int_accn set basey = p_basey, acra = null, acrb = null where acc = p_acc and id = l_id;
        begin
           select i.bdat, i.ir, br into l_dat, l_ir, l_br
             from int_ratn i
            where i.acc = p_acc
              and i.id = l_id
              and i.bdat = ( select max(bdat) from int_ratn where acc = i.acc and id = i.id );
           if l_dat = gl.bdate then
              update int_ratn set ir = p_rate, br = null, op = null where acc = p_acc and id = l_id and bdat = l_dat;
           elsif l_dat <> gl.bdate then
              insert into int_ratn (acc, id, bdat, ir, br, op)
              values (p_acc, l_id, gl.bdate, p_rate, null, null);
           end if;
        exception when no_data_found then
           insert into int_ratn (acc, id, bdat, ir, br, op)
           values (p_acc, l_id, gl.bdate, p_rate, null, null);
        end;
     end;
  end if;
end set_rate;

-------------------------------------------------------------------------------
-- open_accf
-- ФУКЦИЯ ! (процедура) открытия счета
--
function open_accF (
  p_rnk   number,
  p_nbs   accounts.nbs%type,
  p_kv    accounts.kv%type ) return number
is
  l_acc accounts.acc%type;
  l_nls accounts.nls%type;
  l_nms accounts.nms%type;
  l_tip accounts.tip%type := 'ODB';
--l_isp accounts.isp%type;
  l_p4  number;
begin
  select f_newnls2(null, l_tip, p_nbs, p_rnk, null, p_kv),   substr(f_newnms (null, l_tip, p_nbs, p_rnk, null),1,70)    into l_nls, l_nms    from dual;
  -- открытие счета
  op_reg_ex(99, 0, 0, 30, l_p4, p_rnk, l_nls, p_kv, l_nms, l_tip, gl.aUid, l_acc);
  -- спецпараметры
  set_sparam(l_acc);
  return l_acc;
end open_accf;

-------------------------------------------------------------------------------
-- open_accP
-- процедура открытия счета 9кл. для указанных типа сделки и валюты
--
procedure open_accP (
  p_swaptag    number,
  p_rnk        fx_deal_acc.rnk%type,
  p_fxtype     fx_deal_acc.fx_type%type,
  p_kvtype     fx_deal_acc.kv_type%type,
  p_kv         fx_deal_acc.kv%type,
  p_acc    out number )
is
  l_column forex_ob22.s9a%type := null;
  l_nbs    accounts.nbs%type   := null;
  l_ob22   accounts.ob22%type  := null;
  l_acc    accounts.acc%type   := null;
  l_id     number;
  -----------------
  l_kod    varchar2(30);
begin
  l_kod :=  pul.Get('FOREX_KOD');

  begin select decode(p_kvtype, 'A', s9a, s9p) into l_column   from forex_ob22  where kod = l_kod ;
  exception when no_data_found then   raise_application_error(-20203, 'Невідомий тип FOREX-угоди ' || l_kod);
  end;

  l_nbs  := substr(l_column, 1, 4);
  l_ob22 := substr(l_column, 6, 2);
  
  if l_nbs is null then     raise_application_error(-20000, 'Не задано бал.рах для типу FOREX-угоди ' || l_kod );  end if;

  l_acc := FOREX.open_accF(p_rnk, l_nbs, p_kv);

  if l_ob22 is not null then     accreg.setAccountSParam(l_acc, 'OB22', l_ob22);  end if;

  select s_fxdealacc.nextval into l_id from dual;
  insert into fx_deal_acc (id, rnk, fx_type, kv_type, kv, acc9)  values (l_id, p_rnk, p_fxtype, p_kvtype, p_kv, l_acc);

  p_acc := l_acc;

end open_accP;

-------------------------------------------------------------------------------
-- get_freeacc
-- функция получения счета 9кл. для указанных типа сделки и валюты
--
function get_freeacc (
  p_swaptag  number,
  p_rnk      number,
  p_fxtype   fx_deal_acc.fx_type%type,
  p_kvtype   fx_deal_acc.kv_type%type,
  p_kv       number) return number
is
  l_acc number;
  l_id  number;
  l_dat date;
  l_ir  number;
  l_br  number;

  L_FOREX_KOD forex_ob22.kod%type;

begin
  L_FOREX_KOD := pul.get('FOREX_KOD');
  begin  -- ищем свободный 
     select a.acc into l_acc   from  accounts a, forex_ob22 f
      where a.rnk = p_rnk        and a.kv =  p_kv                                                          -- совпадает по РНК и по вал
        and f.kod = L_FOREX_KOD  and decode (p_kvtype,'A', f.s9a,f.s9p) like a.nbs||'_'||a.ob22            -- совпадает по бал+об22
        and a.ostb = 0 and a.ostf = 0 and a.ostc = 0  and a.dazs  is null                                  -- без остатка, но  не закрыт
        and (a.dapp is null or a.dapp < gl.bdate -10) and rownum = 1;                                      -- работал более 10 дней назад ==>> любой из таких 
  exception when no_data_found then  FOREX.open_accP (p_swaptag, p_rnk, p_fxtype , p_kvtype, p_kv, l_acc); -- или откріваем новый
  end;

-----------------------------  -- обнуляем % ставку
  select pap-1 into l_id from accounts where acc = l_acc;
  begin
     select i.bdat, i.ir, br into l_dat, l_ir, l_br  from int_ratn i       where i.acc = l_acc and i.id = l_id    and i.bdat = ( select max(bdat) from int_ratn where acc = i.acc and id = i.id );
     if l_dat = gl.bdate and ( nvl(l_ir,0) <> 0 or nvl(l_br,0) <> 0 ) then update int_ratn set ir = 0, br = null, op = null where acc = l_acc and id = l_id and bdat = l_dat;
     elsif l_dat <> gl.bdate then                                          insert into int_ratn (acc, id, bdat, ir, br, op)     values (l_acc, l_id, gl.bdate, 0, null, null);
     end if;
  exception when no_data_found then null;
  end;
  return l_acc;
end get_freeacc;

-------------------------------------------------------------------------------
-- get_fxacc
-- процедура получения счетов 9 кл. для сделки
--
procedure get_fxacc (
  p_swaptag    number,
  p_rnk        number,
  p_fxtype     fx_deal_acc.fx_type%type,
  p_kva        number,
  p_kvb        number,
  p_acca   out number,
  p_accb   out number )  is
begin
  p_acca := get_freeacc(p_swaptag, p_rnk, p_fxtype, 'A', p_kva);
  p_accb := get_freeacc(p_swaptag, p_rnk, p_fxtype, 'B', p_kvb);
end get_fxacc;

-------------------------------------------------------------------------------
-- get_acc
-- функция получения acc счета по nls, kv
--
function get_acc (p_nls varchar2, p_kv number) return number
is
  l_acc number := null;
begin
  begin   select acc into l_acc from accounts where nls = p_nls and kv = p_kv;
  exception when no_data_found then   l_acc := null;
     -- bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', p_acc);
  end;
  return l_acc;
end get_acc;

-------------------------------------------------------------------------------
-- get_nls
-- функция получения nls по acc
--
function get_nls (p_acc number) return varchar2
is
  l_nls accounts.nls%type := null;
begin
  begin
     select nls into l_nls from accounts where acc = p_acc;
  exception when no_data_found then
     l_nls := null;
     -- bars_error.raise_nerror('SVC', 'ACC_NOT_FOUND', p_acc);
  end;
  return l_nls;
end get_nls;

-------------------------------------------------------------------------------
-- set_doc
-- процедура вставки документа в oper
--
procedure set_doc (
  p_vdat   in date,
  p_datd   in date,
  p_tt     in oper.tt%type,
  p_vob    in oper.vob%type,
  p_dk     in oper.dk%type,
  p_nam_a  in oper.nam_a%type,
  p_nlsa   in oper.nlsa%type,
  p_mfoa   in oper.mfoa%type,
  p_id_a   in oper.id_a%type,
  p_nam_b  in oper.nam_b%type,
  p_nlsb   in oper.nlsb%type,
  p_mfob   in oper.mfob%type,
  p_id_b   in oper.id_b%type,
  p_kv     in oper.kv%type,
  p_s      in oper.s%type,
  p_kv2    in oper.kv2%type,
  p_s2     in oper.s2%type,
  p_nazn   in oper.nazn%type,
  p_ref   out number )
is
  l_ref number;
begin
  gl.ref (l_ref);
  gl.in_doc3 (ref_    => l_ref,
              tt_     => p_tt,
              vob_    => p_vob,
              nd_     => to_char(l_ref),
              pdat_   => sysdate,
              vdat_   => p_vdat,
              dk_     => p_dk,
              kv_     => p_kv,
              s_      => p_s,
              kv2_    => p_kv2,
              s2_     => p_s2,
              sk_     => null,
              data_   => p_datd,
              datp_   => gl.bdate,
              nam_a_  => p_nam_a,
              nlsa_   => p_nlsa,
              mfoa_   => p_mfoa,
              nam_b_  => p_nam_b,
              nlsb_   => p_nlsb,
              mfob_   => p_mfob,
              nazn_   => p_nazn,
              d_rec_  => null,
              id_a_   => p_id_a,
              id_b_   => p_id_b,
              id_o_   => null,
              sign_   => null,
              sos_    => null,
              prty_   => 0,
              uid_    => null );
  p_ref := l_ref;
end set_doc;

-------------------------------------------------------------------------------
-- pay_subdoc
-- процедура оплаты проводки (opldok)
--
procedure pay_subdoc (
  p_flg   in number,
  p_ref   in number,
  p_dat   in date,
  p_tt    in varchar2,
  p_dk    in number,
  p_kva   in number,
  p_nlsa  in varchar2,
  p_suma  in number,
  p_kvb   in number,
  p_nlsb  in varchar2,
  p_sumb  in number,
  p_txt   in varchar2 )
is
begin
  gl.payv(flg_   => p_flg,
          ref_   => NVL( p_ref, gl.aRef ) ,
          dat_   => p_dat,
          tt_    => p_tt,
          dk_    => p_dk,
          kv1_   => p_kva,
          nls1_  => p_nlsa,
          sum1_  => p_suma,
          kv2_   => p_kvb,
          nls2_  => p_nlsb,
          sum2_  => p_sumb );
  if p_txt is not null then
     update opldok set txt = p_txt where ref = p_ref and stmt = gl.aStmt;
  end if;
end pay_subdoc;

-------------------------------------------------------------------------------
-- set_operw
-- заполнение доп. рекв. операций
--
procedure set_operw (p_ref number, p_tag varchar2, p_value varchar2)
is
begin
  if p_value is not null then
     begin
        insert into operw (ref, tag, value)
        values (p_ref, p_tag, p_value);
     exception when dup_val_on_index then
        update operw set value = p_value where ref = p_ref and trim(tag) = trim(p_tag);
     end;
  end if;
end set_operw;

-------------------------------------------------------------------------------
-- f_dopr_a
-- процедура установки доп.реквизитов документа по вал-А
--
procedure f_dopr_a (p_ref number, p_fxdeal fx_deal%rowtype, p_cust t_cust)  is
  l_kurs number;
begin
  set_operw(p_ref, 'KOD_B', p_cust.kod_b);
  set_operw(p_ref, 'KOD_G', p_cust.kod_g);
  set_operw(p_ref, 'KOD_N', p_fxdeal.kod_na);

  if p_fxdeal.kva <> gl.baseval then
     select round(gl.p_icurval(p_fxdeal.kvb, p_fxdeal.sumb, bankdate) * nominal / p_fxdeal.suma, 8) into l_kurs from tabval where kv = p_fxdeal.kva;
     set_operw(p_ref, 'KURS', to_char(l_kurs));
  end if;

end f_dopr_a;

-------------------------------------------------------------------------------
-- f_dopr_b
-- процедура установки доп.реквизитов документа по вал-Б
--
procedure f_dopr_b (p_ref number, p_fxdeal fx_deal%rowtype, p_cust t_cust)
is
  b643   boolean;
  l_kurs number;
begin
  b643 := case when p_fxdeal.kvb=643 and p_cust.kod_b=643 then true else false end;
  if p_fxdeal.bicb is not null then
     if b643 = true and p_fxdeal.field_58d is not null then
        set_operw(p_ref, '58D', p_fxdeal.field_58d);
     else
        set_operw(p_ref, '58A', case when p_fxdeal.swo_acc is not null then '/' || p_fxdeal.swo_acc || chr(13) || chr(10)|| p_fxdeal.bicb
                                     when p_fxdeal.nlsb is not null then '/' || p_fxdeal.nlsb || chr(13) || chr(10) || p_fxdeal.bicb
                                     else p_fxdeal.bicb
                                end);
     end if;
  end if;

  set_operw(p_ref, '57A', case when p_fxdeal.swo_acc is not null  and 1=0 then '/' || p_fxdeal.swo_acc || chr(13) || chr(10) || p_fxdeal.swo_bic
                               else p_fxdeal.swo_bic
                          end);
  if p_fxdeal.alt_partyb is not null and p_fxdeal.swo_bic is null then
     set_operw(p_ref, '57D', p_fxdeal.alt_partyb);
  end if;
  set_operw(p_ref, '56A', p_fxdeal.interm_b);
  set_operw(p_ref, 'KOD_B', p_cust.kod_b);
  set_operw(p_ref, 'KOD_G', p_cust.kod_g);
  set_operw(p_ref, 'KOD_N', p_fxdeal.kod_nb);

  if p_fxdeal.kvb <> gl.baseval then
     select round(gl.p_icurval(p_fxdeal.kva, p_fxdeal.suma, bankdate) * nominal / p_fxdeal.sumb, 8) into l_kurs from tabval where kv = p_fxdeal.kvb;
     set_operw(p_ref, 'KURS', to_char(l_kurs));
  end if;

  if b643 = true then
     set_operw(p_ref, '72', '/RPP/' || substr(p_fxdeal.ntik,-3) || '.' || to_char(sysdate,'yyMMdd') || '.5.ELEK.01' || chr(13) || chr(10) ||
                            '/NZP/''(VO02020)'' FOREKS' || chr(13) || chr(10) ||
                            '//SOGL.DOG.n' || p_fxdeal.kvb || '/' || p_fxdeal.kva || '/' || p_fxdeal.ntik || chr(13) || chr(10) ||
                            '//OT.' || to_char(p_fxdeal.dat,'dd.MM.yyyy') || ' BEZ NDS');
  else
     set_operw(p_ref, '72', '/BNF/FOREX AGR NO.' || p_fxdeal.kvb || '/' || p_fxdeal.kva || '/' || p_fxdeal.ntik || chr(13) || chr(10) ||
                            '//DD.' || to_char(p_fxdeal.dat,'dd.MM.yyyy'));
  end if;
end f_dopr_b;

-------------------------------------------------------------------------------
-- pay_forward_vn
-- процедура оплаты документа по счетам 9кл.
--
procedure pay_forward_vn (
  p_fxdeal in out fx_deal%rowtype,
  p_fxtype        varchar2, ----Не исп, т.к. только ДЛ/КОР (от дат). а надо про ноги + вал/депо 
  p_cust          t_cust,
  p_tt            varchar2,
  p_nazn          varchar2 )
is
  l_oper    oper%rowtype;
  l_acca    number := null;
  l_accb    number := null;
  l_tt_nls  tts.nlsk%type ;
  
  --2018.10.01 COBUMMFO-7334 для вірного формування бухгалтерської моделі SPLIT-угод, коли одна з дат валютування в межах SPOT
  function f_get_correct_date(
    p_fx_deal     fx_deal%rowtype,
    p_date_val    date) return date
  is
  begin
    --якщо тип угоди SPLIT і дати валютування не дорівнюють даті угоди, тоді це SPLIT, коли одна з дат валютування у рамках SPOT
    if get_forextype(p_fx_deal.dat, p_fx_deal.dat_a, p_fx_deal.dat_b) = 'SPLIT' and p_fx_deal.dat_a <> p_fx_deal.dat and p_fx_deal.dat_b <> p_fx_deal.dat then
       --закриття внебалансу (9й клас) та рах. 181902 в один день (в першу дату валютування або валюти А, або валюти Б)
      return least(p_fx_deal.dat_a, p_fx_deal.dat_b);
    else
      --інакше повертаємо ту саму дату, яку передали в функцію
      return p_date_val;
    end if;
  end;
  ----
begin
--logger.info('XXX-1*'|| p_fxtype||p_fxdeal.deal_tag||'*'|| p_fxdeal.swap_tag||'*');
logger.info('XXX-11*'|| gl.bdate||'*'||p_fxdeal.dat_a||'*'|| p_fxdeal.dat_b||'*');


  -- FXF/FX5 - внебаланс
  iF p_fxtype LIKE '%TOD%' THEN  RETURN; END IF;

  if p_fxdeal.acc9a is null or p_fxdeal.acc9b is null then
     forex.get_fxacc( p_fxdeal.swap_tag, p_fxdeal.rnk, PUL.GET ('FOREX_KOD') , p_fxdeal.kva, p_fxdeal.kvb, l_acca, l_accb ) ;
     l_oper.nlsa := get_nls(l_acca);
     l_oper.nlsb := get_nls(l_accb);
  else
     l_acca := p_fxdeal.acc9a;
     l_accb := p_fxdeal.acc9b;
     l_oper.nlsa := get_nls(l_acca);
     l_oper.nlsb := get_nls(l_accb);
  end if;

  if l_oper.nlsa is null or l_oper.nlsb is null then     raise_application_error(-20000, 'Неизвестны счета для оплаты! Не заполнен справочник счетов Spot/Forward.');  end if;

  l_oper.tt := p_tt;
  select nlsk into l_tt_nls from tts where tt = l_oper.tt;
  if (l_tt_nls like '#%') then      execute immediate 'select ' || substr(l_tt_nls, 2) || ' from dual'     into l_tt_nls;  end if;

  if p_fxdeal.deal_tag is null then
     l_oper.vob := 16;

     If p_fxdeal.dat_a > gl.bdate OR p_fxdeal.dat_b > gl.bdate then
        set_doc (gl.bdate,gl.bdate,l_oper.tt,l_oper.vob,1,g_bankname,l_oper.nlsa,g_bankmfo,g_bankokpo,p_cust.nmk,l_oper.nlsb,g_bankmfo,g_bankokpo,p_fxdeal.kva,p_fxdeal.suma,p_fxdeal.kvb,p_fxdeal.sumb,p_nazn,l_oper.ref);
     else
        set_doc (gl.bdate,gl.bdate,l_oper.tt,l_oper.vob,1,g_bankname,l_nls_1819 ,g_bankmfo,g_bankokpo,p_cust.nmk,l_nls_1819 ,g_bankmfo,g_bankokpo,p_fxdeal.kva,p_fxdeal.suma,p_fxdeal.kvb,p_fxdeal.sumb,p_nazn,l_oper.ref);
     end if;

  else
     l_oper.ref := NVL(p_fxdeal.ref, gl.aRef);
  end if;

--logger.info('XXX-2*'|| gl.bdate||p_fxdeal.dat_a||'*'|| p_fxdeal.dat_b||'*');

  If p_fxdeal.dat_a > gl.bdate then
     pay_subdoc(0, l_oper.ref, gl.bdate,                                                        l_oper.tt, 1, p_fxdeal.kva, l_oper.nlsa, p_fxdeal.suma, p_fxdeal.kva, l_tt_nls,    p_fxdeal.suma, 'Розкрити вимоги');
     pay_subdoc(0, l_oper.ref, /*p_fxdeal.dat_a*/ f_get_correct_date(p_fxdeal, p_fxdeal.dat_a), l_oper.tt, 0, p_fxdeal.kva, l_oper.nlsa, p_fxdeal.suma, p_fxdeal.kva, l_tt_nls,    p_fxdeal.suma, 'Закрити вимоги');
  end if ;

  If p_fxdeal.dat_b > gl.bdate then
     pay_subdoc(0, l_oper.ref, gl.bdate,                                                        l_oper.tt, 1, p_fxdeal.kvb, l_tt_nls,    p_fxdeal.sumb, p_fxdeal.kvb, l_oper.nlsb, p_fxdeal.sumb, 'Розкрити зобов`язання');
     pay_subdoc(0, l_oper.ref, /*p_fxdeal.dat_b*/ f_get_correct_date(p_fxdeal, p_fxdeal.dat_b), l_oper.tt, 0, p_fxdeal.kvb, l_tt_nls,    p_fxdeal.sumb, p_fxdeal.kvb, l_oper.nlsb, p_fxdeal.sumb, 'Закрити зобов`язання');
 end if;

  -- FX2
  if p_fxdeal.vn_flag = 0 then
     pay_subdoc(0, l_oper.ref, /*p_fxdeal.dat_a*/ f_get_correct_date(p_fxdeal, p_fxdeal.dat_a), 'FX2', 1, p_fxdeal.kva, l_nls_3540, p_fxdeal.suma, p_fxdeal.kva, l_nls_1819, p_fxdeal.suma, 'Розкрити деб.заборгованiсть на МБ');
     pay_subdoc(0, l_oper.ref, /*p_fxdeal.dat_b*/ f_get_correct_date(p_fxdeal, p_fxdeal.dat_b), 'FX2', 1, p_fxdeal.kvb, l_nls_1819, p_fxdeal.sumb, p_fxdeal.kvb, l_nls_3640, p_fxdeal.sumb, 'Розкрити кред.заборгованiсть на МБ');
  end if;

  p_fxdeal.ref := l_oper.ref;
  p_fxdeal.acc9a := l_acca;
  p_fxdeal.acc9b := l_accb;

end pay_forward_vn;

-------------------------------------------------------------------------------
-- pay_tod
-- процедура оплаты документов сделки TOD
--
procedure pay_tod (
  p_fxdeal in out fx_deal%rowtype,
  p_cust          t_cust,
  p_nazn          varchar2 )
is
  l_oper  oper%rowtype;
begin

  -- FX2 bankdate
  l_oper.tt := 'FX2';
  if p_fxdeal.deal_tag is null then
     l_oper.vob := case when p_fxdeal.kva  = gl.baseval and p_fxdeal.kvb <> gl.baseval then nvl(g_VOB_FX2GV, g_VOB_VAL)
                        when p_fxdeal.kva <> gl.baseval and p_fxdeal.kvb  = gl.baseval then nvl(g_VOB_FX2VG, g_VOB_VAL)
                        else nvl(g_VOB_FX2V, g_VOB_VAL)
                   end;
     set_doc (gl.bdate, gl.bdate, l_oper.tt, l_oper.vob, 1,
        g_bankname, l_nls_3540, g_bankmfo, g_bankokpo,
        p_cust.nmk, l_nls_3640, g_bankmfo, g_bankokpo,
        p_fxdeal.kva, p_fxdeal.suma, p_fxdeal.kvb, p_fxdeal.sumb, p_nazn, l_oper.ref);
  else
     l_oper.ref := p_fxdeal.ref;
  end if;

  pay_subdoc(0, l_oper.ref, gl.bdate, l_oper.tt, 1, p_fxdeal.kva, l_nls_3540, p_fxdeal.suma, p_fxdeal.kva, l_nls_1819, p_fxdeal.suma, 'Розкрити деб.заборгованiсть на МБ');
  pay_subdoc(0, l_oper.ref, gl.bdate, l_oper.tt, 1, p_fxdeal.kvb, l_nls_1819, p_fxdeal.sumb, p_fxdeal.kvb, l_nls_3640, p_fxdeal.sumb, 'Розкрити кред.заборгованiсть на МБ');

  p_fxdeal.ref := l_oper.ref;

end pay_tod;

-------------------------------------------------------------------------------
-- pay_spot
-- процедура оплаты документов сделки SPOT
--
procedure pay_spot (
  p_fxdeal in out fx_deal%rowtype,
  p_cust          t_cust,
  p_nazn          varchar2 )
is
  l_oper     oper%rowtype;
  l_fx5_nls  tts.nlsk%type;
begin

  -- внебаланс FX5+FX2 / FXO
  if    g_FX_SPOT is not null and g_FX_SPOT = 'FX5' then  pay_forward_vn(p_fxdeal, g_fxtype_spot, p_cust, 'FX5', p_nazn);   -- sFX_SPOT = 'FX5' как FORWARD

  elsif g_FX_SPOT is not null and g_FX_SPOT = 'FXO' then   -- sFX_SPOT = 'FXO' - без 9 кл.                                      -- 2.1.1 - FXO
     l_oper.tt   := g_FX_SPOT;
     l_oper.nlsa := l_nls_3540;
     l_oper.nlsb := l_nls_3640;

     if p_fxdeal.deal_tag is null then
        select nvl(vob,6) into l_oper.vob from tts_vob where tt = l_oper.tt;
        set_doc (gl.bdate, gl.bdate, l_oper.tt, l_oper.vob, 1, g_bankname, l_oper.nlsa, g_bankmfo, g_bankokpo,  p_cust.nmk, l_oper.nlsb, g_bankmfo, g_bankokpo,  p_fxdeal.kva, p_fxdeal.suma, p_fxdeal.kvb, p_fxdeal.sumb, p_nazn, l_oper.ref);
     else
        l_oper.ref := p_fxdeal.ref;
     end if;

     pay_subdoc(0, l_oper.ref, gl.bdate, l_oper.tt, 1, p_fxdeal.kva, l_oper.nlsa, p_fxdeal.suma, p_fxdeal.kvb, l_oper.nlsb, p_fxdeal.sumb, null);

     p_fxdeal.ref := l_oper.ref;

  else
     raise_application_error(-2000, 'Unknown mode of deal SPOT');
  end if;

end pay_spot;

procedure pay_split (p_fxdeal in out fx_deal%rowtype,
                     p_cust   in     t_cust,
                     p_nazn          varchar2)
  is
  l_oper  oper%rowtype;
begin
  --COBUMMFO-7334 когда любая из дат валютирования совпадает с датой заключения сделки, подходит алгоритм pay_tod, как и было раньше
  if p_fxdeal.dat = p_fxdeal.dat_a or p_fxdeal.dat = p_fxdeal.dat_b then
    pay_tod(p_fxdeal, p_cust, p_nazn); 
  --иначе, если одна из дат A/B в пределах SPOT, а другая отличается - действуем по алгоритму SPOT
  else
    pay_spot(p_fxdeal, p_cust, p_nazn);
  end if;
  ----
end pay_split;

-------------------------------------------------------------------------------
-- pay_forward
-- процедура оплаты документов сделки FORWARD
--
procedure pay_forward (
  p_fxdeal in out fx_deal%rowtype,
  p_cust          t_cust,
  p_nazn          varchar2 )
is
  l_oper     oper%rowtype;
  l_acca     number := null;
  l_accb     number := null;
  l_fxf_nls  tts.nlsk%type;
begin

  -- FXF - внебаланс+FX2
  pay_forward_vn(p_fxdeal, g_fxtype_forward, p_cust, 'FXF', p_nazn);

end pay_forward;

-------------------------------------------------------------------------------
-- pay_sumc
-- процедура оплаты проводки по отщеплению клиентской части
--
procedure pay_sumc (p_fxdeal fx_deal%rowtype)
is
  l_count number;
  l_oper  oper%rowtype;
begin

  if nvl(p_fxdeal.sumc,0) > 0 then

     -- 2900
     select nlsk into l_oper.nlsb from tts where tt = 'GO2';
     select count(*) into l_count
       from opldok o, accounts a
      where o.ref = p_fxdeal.ref
        and o.acc = a.acc
        and a.nls = l_oper.nlsb;

     if l_count = 0 then

        l_oper.tt   := 'FX2';
        l_oper.nlsa := l_nls_1819;

        -- 1819->2900-KVA
        l_oper.s := p_fxdeal.sumc;
        pay_subdoc(0, p_fxdeal.ref, p_fxdeal.dat_a, l_oper.tt, 1, p_fxdeal.kva, l_oper.nlsa, l_oper.s, p_fxdeal.kva, l_oper.nlsb, l_oper.s, 'Вiдщiплення кл.частини вал, що отримана');

        -- 2900->1819-KVB
        l_oper.s := round(l_oper.s*(p_fxdeal.sumb / p_fxdeal.suma ),0);
        pay_subdoc(0, p_fxdeal.ref, p_fxdeal.dat_a, l_oper.tt, 0, p_fxdeal.kvb, l_oper.nlsa, l_oper.s, p_fxdeal.kvb, l_oper.nlsb, l_oper.s, 'Вiдщiплення кл.частини вал, що сплачена');

        If p_fxdeal.kva <> gl.baseval and p_fxdeal.kvb = gl.baseval and l_oper.s < p_fxdeal.sumb then -- При покупке банком вал - тут же начисление в ПФ

           If g_FX_PFDB is null then raise_application_error(-20000, 'Не налаштовано гл.пар FX_PF_DB = Нарахування збору в ПФ: Рах.Дебет'  ); End if;
           If g_FX_PFCR is null then raise_application_error(-20000, 'Не налаштовано гл.пар FX_PF_CR = Нарахування збору в ПФ: Рах.Кредит' ); End if;

           l_oper.s := p_fxdeal.sumb - l_oper.s       ; -- банковская часть грн-суммы
           l_oper.s := ROUND ( l_oper.s * 5/1000 , 0) ; -- 0.5% в Пенс.фонд за покупку вал
           If l_oper.s >= 1 then
              pay_subdoc(0, p_fxdeal.ref, p_fxdeal.dat_a, 'PS1', 1, gl.baseval, g_FX_PFDB, l_oper.s, gl.baseval, g_FX_PFCR, l_oper.s, 'Нарахування в ПФ з купівлі без/гот вал Банком');
           end if;
        End If ;
     end if;
  end if;

exception when no_data_found then null;
end pay_sumc;

-------------------------------------------------------------------------------
-- pay_pf
-- поцедура оплаты проводки по начислению в ПФ при покупке банком валюты
--
procedure pay_pf (p_fxdeal fx_deal%rowtype)
is
  l_count number;
  l_oper  oper%rowtype;
begin
  RETURN ; -- c 01.01.2015 отключен сбор в ПФ за безнал
  --------
  If p_fxdeal.kva <> gl.baseval and p_fxdeal.kvb = gl.baseval and
     g_FX_PFDB is not null and g_FX_PFCR is not null then

     -- 3622
     select count(*) into l_count from opldok o, accounts a  where o.ref = p_fxdeal.ref and o.acc = a.acc and a.nls = g_FX_PFCR;

     if l_count = 0 then
        l_oper.s := round((p_fxdeal.sumb - round(nvl(p_fxdeal.sumc,0) * p_fxdeal.sumb / p_fxdeal.suma, 0)) * 5/1000 , 0);
        if l_oper.s >= 1 then
           l_oper.tt   := 'PS1';
           l_oper.kv   := gl.baseval;
           l_oper.nlsa := null;
           pay_subdoc(0, p_fxdeal.ref, p_fxdeal.dat_a, l_oper.tt, 1, l_oper.kv, g_FX_PFDB, l_oper.s, l_oper.kv, g_FX_PFCR, l_oper.s, 'Нарахування в ПФ з купівлі без/гот вал Банком');
        end if;
     end if;
  end if;

end pay_pf;

-------------------------------------------------------------------------------
-- pay_fx2
-- процедура оплаты документа по торговым счетам
--
procedure pay_fx2 (
  p_fxdeal in out fx_deal%rowtype,
  p_cust          t_cust,
  p_nazn          varchar2,
  p_fxtype        varchar2 )
is
begin

  if    p_fxtype = g_fxtype_tod then --or p_fxtype = g_fxtype_split   then --2018.09.12 закомментировано, т.к. перенесено в pay_split
    pay_tod     (p_fxdeal, p_cust, p_nazn) ; 
  elsif p_fxtype = g_fxtype_spot then 
    pay_spot    (p_fxdeal, p_cust, p_nazn) ;  -- 1.2 - SPOT   
  --COBUMMFO-7334
  elsif p_fxtype = g_fxtype_split then
    pay_split(p_fxdeal, p_cust, p_nazn);
  ----
  else
    pay_forward (p_fxdeal, p_cust, p_nazn) ;  -- 1.3 - FORVARD
  end if;

  set_operw(p_fxdeal.ref, 'SUMKL', p_fxdeal.sumc);

  if p_fxdeal.vn_flag = 0 then
     pay_sumc(p_fxdeal);       -- отщепление клиентской части
     pay_pf(p_fxdeal);       -- начисление в ПФ
  end if;

end pay_fx2;

-------------------------------------------------------------------------------
-- pay_fx3
-- процедура оплаты документа по входу валюты-А
--
procedure pay_fx3 (
  p_fxdeal in out fx_deal%rowtype,
  p_cust          t_cust,
  p_nazn          varchar2 )
is
  l_oper oper%rowtype;
begin

  if p_fxdeal.vn_flag = 0 and p_fxdeal.nlsa is not null then

     -- определение параметров оплаты
     l_oper.tt  := 'FX3';
     select nvl(min(vob), 6) into l_oper.vob from tts_vob where tt = l_oper.tt;
     l_oper.vob := case when p_fxdeal.kva = gl.baseval then l_oper.vob
                        else g_VOB_VAL
                   end;
     l_oper.nlsa := p_fxdeal.nlsa;
     l_oper.nlsb := l_nls_3540;
     select substr(nms,1,38) into l_oper.nam_a from accounts where nls = p_fxdeal.nlsa and kv = p_fxdeal.kva;

     -- оллата
     set_doc (p_fxdeal.dat_a, p_fxdeal.dat_a, l_oper.tt, l_oper.vob, 1,
        l_oper.nam_a, l_oper.nlsa, g_bankmfo, g_bankokpo,
        g_bankname,   l_oper.nlsb, g_bankmfo, g_bankokpo,
        p_fxdeal.kva, p_fxdeal.suma, p_fxdeal.kva, p_fxdeal.suma, p_nazn, l_oper.ref);
     pay_subdoc(0, l_oper.ref, p_fxdeal.dat_a, l_oper.tt, 1, p_fxdeal.kva, l_oper.nlsa, p_fxdeal.suma, p_fxdeal.kva, l_oper.nlsb, p_fxdeal.suma, 'Закрити деб.заборгованiсть на МБ');

     -- доп.реквизиты
     f_dopr_a(l_oper.ref, p_fxdeal, p_cust);

     p_fxdeal.refa := l_oper.ref;

  end if;

end pay_fx3;

-------------------------------------------------------------------------------
-- payb
-- процедура оплаты документа по отправке валюты-Б
--
procedure payb (
  p_fxdeal in out fx_deal%rowtype,
  p_cust          t_cust,
  p_nazn          varchar2,
  p_s          in number,
  p_ref       out number)
is
  l_oper oper%rowtype;
begin

  if nvl(p_fxdeal.b_payflag,0) > 0 then

     l_oper.nlsa := g_FX_3640;
     -- проплата через СЭП(ВПС)
     if p_fxdeal.b_payflag = 1 then

        l_oper.tt   := 'FX1';
        select nvl(min(vob), 6) into l_oper.vob from tts_vob where tt = l_oper.tt;
        l_oper.nlsb := p_fxdeal.nlsb;
        l_oper.mfob := p_fxdeal.kodb;
        l_oper.id_b := p_cust.okpo;

     -- проплата через СВИФТ
     elsif p_fxdeal.b_payflag = 2 then

        l_oper.tt   := 'FX4';
        select nvl(min(vob), 6) into l_oper.vob from tts_vob where tt = l_oper.tt;
        l_oper.vob  := case when p_fxdeal.kvb = gl.baseval then l_oper.vob
                            else g_VOB_VAL
                       end;
        select nlsk into l_oper.nlsb from tts where tt = l_oper.tt;
        l_oper.mfob := g_bankmfo;
        l_oper.id_b := g_bankokpo;

     -- проплата внутр МО
     elsif p_fxdeal.b_payflag = 3 then

        l_oper.tt   := 'FX6';
        select nvl(min(vob), 6) into l_oper.vob from tts_vob where tt = l_oper.tt;
        l_oper.vob  := case when p_fxdeal.kvb = gl.baseval then l_oper.vob
                            else g_VOB_VAL
                       end;
        l_oper.nlsb := p_fxdeal.swo_acc;
        l_oper.mfob := g_bankmfo;
        l_oper.id_b := p_cust.okpo;

     else
        raise_application_error(-20000, 'ERROR p_fxdeal.b_pay_flag');
     end if;

     set_doc (p_fxdeal.dat_b, p_fxdeal.dat_b, l_oper.tt, l_oper.vob, 1,
        g_bankname, l_oper.nlsa, g_bankmfo,   g_bankokpo,
        p_cust.nmk, l_oper.nlsb, l_oper.mfob, l_oper.id_b,
        p_fxdeal.kvb, p_s, p_fxdeal.kvb, p_s, p_nazn, l_oper.ref);

     paytt ( flg_ => null,
             ref_ => l_oper.ref,
            datv_ => p_fxdeal.dat_b,
              tt_ => l_oper.tt,
             dk0_ => 1,
             kva_ => p_fxdeal.kvb,
            nls1_ => l_oper.nlsa,
              sa_ => p_s,
             kvb_ => p_fxdeal.kvb,
            nls2_ => l_oper.nlsb,
              sb_ => p_s );

     f_dopr_b(l_oper.ref, p_fxdeal, p_cust);

  end if;

  p_ref := l_oper.ref;

end payb;

-------------------------------------------------------------------------------
-- pay_fx4
-- процедура оплаты документа по отправке валюты-Б
--
procedure pay_fx4 (
  p_fxdeal in out fx_deal%rowtype,
  p_cust          t_cust,
  p_nazn          varchar2 )
is
begin
  if p_fxdeal.vn_flag = 0 then
     if nvl(p_fxdeal.sumb1,0) <> 0 and nvl(p_fxdeal.sumb2,0) <> 0 then
        payb(p_fxdeal, p_cust, p_nazn, p_fxdeal.sumb1, p_fxdeal.refb);
        payb(p_fxdeal, p_cust, p_nazn, p_fxdeal.sumb2, p_fxdeal.refb2);
     else
        payb(p_fxdeal, p_cust, p_nazn, p_fxdeal.sumb, p_fxdeal.refb);
     end if;
  end if;
end pay_fx4;

-------------------------------------------------------------------------------
-- get_nazn
-- функция получения назначения платежа
--
function get_nazn (p_fxdeal fx_deal%rowtype, p_fxtype varchar2, p_cust t_cust, p_nazn varchar2) return varchar2
is
begin
  return nvl(p_nazn, substr(p_fxtype || ' ' || p_cust.nmk || ' ' || p_fxdeal.kva || '/' || p_fxdeal.kvb ||
                     ' Тiкет '|| p_fxdeal.ntik ||' від ' || to_char(p_fxdeal.dat, 'dd.mm.yyyy'), 1, 160));
end;

-------------------------------------------------------------------------------
-- pay_deal
-- процедура оплаты документов по FOREX-сделке
--
procedure pay_deal (
  p_mode     in     number,
  p_fxdeal   in out fx_deal%rowtype,
  p_nazn     in     varchar2 )
is
  l_fxtype varchar2(30);
  l_cust   t_cust;
  l_nazn   oper.nazn%type;
  l_p1     number;
  l_p2     number;
  i        number;
begin

  -- определяем тип FOREXC-сделки
  l_fxtype := get_forextype(p_fxdeal.dat, p_fxdeal.dat_a, p_fxdeal.dat_b);
  l_fxtype := Nvl( pul.GET('FOREX_KOD'),  l_fxtype);

  -- определяем торговый счет
  begin     select s1t into l_nls_1819 from forex_ob22 where kod = l_fxtype;
  exception when no_data_found then  raise_application_error(-20000, 'НЕ знайдено в FOREX_OB22 код '|| l_fxtype);
  end;

  l_nls_1819 := nbs_ob22(substr(l_nls_1819,1,4), substr(l_nls_1819,6,2));

  if l_nls_1819 is null then   raise_application_error(-20000, 'Не указан торговый счет в справочнике!');  end if;

  -- данные партнера
  select substr(nvl(c.nmkk,c.nmk),1,38), c.okpo, t.rezid, b.kod_b, c.country
  into l_cust.nmk, l_cust.okpo, l_cust.rezid, l_cust.kod_b, l_cust.kod_g
  from customer c, custbank b, codcagent t
  where c.rnk = p_fxdeal.rnk  and c.rnk = b.rnk   and c.codcagent = t.codcagent;
  l_cust.nmk := nvl(p_fxdeal.nb, l_cust.nmk);

  -- определяем счета деб.кред задолж.
  l_nls_3540 := case when l_cust.rezid=1 then g_FX_3540 else nvl(g_FX_3540N, g_FX_3540) end;
  l_nls_3640 := case when l_cust.rezid=1 then g_FX_3640 else nvl(g_FX_3640N, g_FX_3640) end;

  -- назначение платежа
  l_nazn := get_nazn(p_fxdeal, l_fxtype, l_cust, p_nazn);

  -- для ДЕПО СВОП / валютный СВОП
  -- если изменение (уменьшение) срока, надо сторнировать документы
  if p_mode = 4 then
     for docs in ( select unique f.deal_tag, o.ref
                     from fx_deal f, fx_deal_ref r, opldok o
                    where f.swap_tag = p_fxdeal.swap_tag
                      and f.deal_tag = r.deal_tag
                      and r.ref = o.ref
                      and o.fdat >= least(p_fxdeal.dat_a, p_fxdeal.dat_b)
                      and o.sos < 5 )
     loop
        gl.bck(docs.ref);
        update opldok o set tt = (select tt from oper where ref = o.ref) where ref = docs.ref and tt = 'BAK';
     end loop;
  end if;

  -- платежи по торговым счетам
  pay_fx2 (p_fxdeal, l_cust, l_nazn, l_fxtype);

  -- платежи по ВАЛ-А
  pay_fx3 (p_fxdeal, l_cust, l_nazn);

  -- платежи по ВАЛ-Б
  pay_fx4 (p_fxdeal, l_cust, l_nazn);

end pay_deal;

-------------------------------------------------------------------------------
-- link_ref
-- процедура привязки документа к сделке
--
procedure link_ref (p_deal_tag fx_deal.deal_tag%type, p_ref number)
is
begin
  if p_ref is not null then
     begin   insert into fx_deal_ref (deal_tag, ref)  values (p_deal_tag, p_ref);
     exception when dup_val_on_index then null;
     end;
  end if;
end link_ref;

-------------------------------------------------------------------------------
-- new_deal
-- процедура создания FOREX-сделки с оплатой докментов по сделке
--
procedure new_deal (
  p_mode   in     number,
  p_fxdeal in out fx_deal%rowtype,
  p_nazn   in     varchar2 )        is
begin
  -- оплата документов по сделке
  pay_deal(p_mode, p_fxdeal, p_nazn);

  -- сохранение сделки
  -- уменьшение срока - меняем параметры сделки, платим по факту основной документ
  if p_mode = 4 then
     update fx_deal
        set dat_a       = p_fxdeal.dat_a,
            dat_b       = p_fxdeal.dat_b,
            ref         = p_fxdeal.ref,
            refa        = p_fxdeal.refa,
            refb        = p_fxdeal.refb,
            refb2       = p_fxdeal.refb2,
            kodb        = p_fxdeal.kodb,
            swi_bic     = p_fxdeal.swi_bic,
            swi_acc     = p_fxdeal.swi_acc,
            swi_f56a    = p_fxdeal.swi_f56a,
            swo_bic     = p_fxdeal.swo_bic,
            swo_acc     = p_fxdeal.swo_acc,
            swo_f56a    = p_fxdeal.swo_f56a,
            swo_f57a    = p_fxdeal.swo_f57a,
            agrmnt_num  = p_fxdeal.agrmnt_num,
            agrmnt_date = p_fxdeal.agrmnt_date,
            interm_b    = p_fxdeal.interm_b,
            alt_partyb  = p_fxdeal.alt_partyb,
            nlsa        = p_fxdeal.nlsa,
            nlsb        = p_fxdeal.nlsb,
            b_payflag   = p_fxdeal.b_payflag,
            sumc        = p_fxdeal.sumc,
            sumb1       = p_fxdeal.sumb1,
            sumb2       = p_fxdeal.sumb2,
            kod_na      = p_fxdeal.kod_na,
            kod_nb      = p_fxdeal.kod_nb,
            field_58d   = p_fxdeal.field_58d,
            vn_flag     = p_fxdeal.vn_flag,
            nb          = p_fxdeal.nb
      where deal_tag = p_fxdeal.deal_tag;
     if p_fxdeal.ref is not null then      gl.pay(2, p_fxdeal.ref, bankdate);   end if;
  -- новая сделка - добавляем в таблицу
  else
     select s_fx_deal.nextval into p_fxdeal.deal_tag from dual;
     p_fxdeal.swap_tag := case when p_mode > 0 then nvl(p_fxdeal.swap_tag,p_fxdeal.deal_tag) else p_fxdeal.swap_tag end;
     insert into fx_deal values p_fxdeal;
  end if;

  -- устанавливаем признак swap для первой своп-сделки (если не установлено, напр., создание своп из архива)
  if p_mode = 2 then    update fx_deal set swap_tag = p_fxdeal.swap_tag where deal_tag = p_fxdeal.swap_tag;  end if;

  -- привязка документов (fx_deal_ref)
  link_ref(p_fxdeal.deal_tag, p_fxdeal.ref);
  link_ref(p_fxdeal.deal_tag, p_fxdeal.refa);
  link_ref(p_fxdeal.deal_tag, p_fxdeal.refb);
  link_ref(p_fxdeal.deal_tag, p_fxdeal.refb2);

end new_deal;

-------------------------------------------------------------------------------

-- -- процедура создания FOREX-сделки
procedure create_deal_EX (
  p_dealtype     number,   --   0 - обычный форекс,   1 - валютный своп ,  2 - депо своп 
  p_mode         number,   --   0 - обычный форекс,   1 - начальный своп,  2 - конечный своп,   3 - %% по своп,   4 - уменьшение срока своп
  p_deal_tag out fx_deal.deal_tag%type,
  p_swap_tag     fx_deal.swap_tag%type,
  p_ntik         fx_deal.ntik%type,
  p_dat          fx_deal.dat%type,
  p_kva          fx_deal.kva%type,
  p_data         fx_deal.dat_a%type,
  p_suma         fx_deal.suma%type,
  p_sumc         fx_deal.sumc%type,
  p_kvb          fx_deal.kvb%type,
  p_datb         fx_deal.dat_b%type,
  p_sumb         fx_deal.sumb%type,
  p_sumb1        fx_deal.sumb1%type,
  p_sumb2        fx_deal.sumb%type,
  p_rnk          fx_deal.rnk%type,
  p_nb           fx_deal.nb%type,
  p_kodb         fx_deal.kodb%type,
  p_swi_ref      fx_deal.swi_ref%type,
  p_swi_bic      fx_deal.swi_bic%type,
  p_swi_acc      fx_deal.swi_acc%type,
  p_nlsa         fx_deal.nlsa%type,            -- счет для входа валюты (документ по вал-а (FX3))
  p_swo_bic      fx_deal.swo_bic%type,
  p_swo_acc      fx_deal.swo_acc%type,
  p_nlsb         fx_deal.nlsb%type,            -- счет для отправки валюты (счет партнера)
  p_b_payflag    fx_deal.b_payflag%type,       -- флаг оплаты документа по валюте-Б (0-не платить, 1-СЭП(FX1), 2-SWIFT(FX4), 3-МО(FX6))
  p_agrmnt_num   fx_deal.agrmnt_num%type,
  p_agrmnt_date  fx_deal.agrmnt_date%type,
  p_interm_b     fx_deal.interm_b%type,
  p_alt_partyb   fx_deal.alt_partyb%type,
  p_bicb         fx_deal.bicb%type,
  p_curr_base    fx_deal.curr_base%type,
  p_telexnum     fx_deal.telexnum%type,
  p_kod_na       fx_deal.kod_na%type,
  p_kod_nb       fx_deal.kod_na%type,
  p_field_58d    fx_deal.field_58d%type,
  p_vn_flag      fx_deal.vn_flag%type,
  p_nazn         varchar2 ,
  p_f092         VARCHAR2 , --\ доп.реквизиты
  p_forex        VARCHAR2   --/
) IS
begin 
  
  bars_audit.info('FOREX1:'||p_forex);
    
  If p_f092  is not null then pul.put('F092'     , p_F092 ) ; else  pul.put('F092'     , null);                                             end if ; 
  If p_forex is not null then pul.put('FOREX_KOD', p_FOREX) ; else  pul.put('FOREX_KOD', Forex.get_forextype (p_dat, p_data , p_datb ) );   end if ;

 -- bars_audit.info('FOREX2:'||p_forex);

  FOREX.create_deal(
  p_dealtype  ,  p_mode       ,  p_deal_tag ,  p_swap_tag  ,  p_ntik ,  p_dat      ,  p_kva      ,  p_data    ,  p_suma   ,  p_sumc     ,  p_kvb     ,  p_datb ,  p_sumb     ,
  p_sumb1     ,  p_sumb2      ,  p_rnk      ,  p_nb        ,  p_kodb ,  p_swi_ref  ,  p_swi_bic  ,  p_swi_acc ,  p_nlsa   ,  p_swo_bic  ,  p_swo_acc ,  p_nlsb ,  p_b_payflag,
  p_agrmnt_num,  p_agrmnt_date,  p_interm_b ,  p_alt_partyb,  p_bicb ,  p_curr_base,  p_telexnum ,  p_kod_na  ,  p_kod_nb ,  p_field_58d,  p_vn_flag ,  p_nazn 
  );                             
                                 FOREX.SetW ( p_deal_tag => p_deal_tag, p_tag =>'FOREX' , p_val => pul.Get('FOREX_KOD' ) ) ; 
                                 
                               -- bars_audit.info(p_val);
                                  
  If p_f092  is not null then    FOREX.SetW ( p_deal_tag => p_deal_tag, p_tag =>'F092'  , p_val => p_f092                ) ;  end if ;

   bars_audit.info('FOREX3_GET:'||pul.Get('FOREX_KOD' ));

end create_deal_EX;
-------------------
procedure create_deal (
  p_dealtype     number,   --   0 - обычный форекс,   1 - валютный своп,   2 - депо своп (с процентами)
  p_mode         number,   --   0 - обычный форекс    1 - начальный своп,  2 - конечный своп,  3 - %% по своп,  4 - уменьшение срока своп
  p_deal_tag out fx_deal.deal_tag%type,
  p_swap_tag     fx_deal.swap_tag%type,
  p_ntik         fx_deal.ntik%type,
  p_dat          fx_deal.dat%type,
  p_kva          fx_deal.kva%type,
  p_data         fx_deal.dat_a%type,
  p_suma         fx_deal.suma%type,
  p_sumc         fx_deal.sumc%type,
  p_kvb          fx_deal.kvb%type,
  p_datb         fx_deal.dat_b%type,
  p_sumb         fx_deal.sumb%type,
  p_sumb1        fx_deal.sumb1%type,
  p_sumb2        fx_deal.sumb%type,
  p_rnk          fx_deal.rnk%type,
  p_nb           fx_deal.nb%type,
  p_kodb         fx_deal.kodb%type,
  p_swi_ref      fx_deal.swi_ref%type,
  p_swi_bic      fx_deal.swi_bic%type,
  p_swi_acc      fx_deal.swi_acc%type,
  p_nlsa         fx_deal.nlsa%type,            -- счет для входа валюты (документ по вал-а (FX3))
  p_swo_bic      fx_deal.swo_bic%type,
  p_swo_acc      fx_deal.swo_acc%type,
  p_nlsb         fx_deal.nlsb%type,            -- счет для отправки валюты (счет партнера)
  p_b_payflag    fx_deal.b_payflag%type,       -- флаг оплаты документа по валюте-Б (0-не платить, 1-СЭП(FX1), 2-SWIFT(FX4), 3-МО(FX6))
  p_agrmnt_num   fx_deal.agrmnt_num%type,
  p_agrmnt_date  fx_deal.agrmnt_date%type,
  p_interm_b     fx_deal.interm_b%type,
  p_alt_partyb   fx_deal.alt_partyb%type,
  p_bicb         fx_deal.bicb%type,
  p_curr_base    fx_deal.curr_base%type,
  p_telexnum     fx_deal.telexnum%type,
  p_kod_na       fx_deal.kod_na%type,
  p_kod_nb       fx_deal.kod_na%type,
  p_field_58d    fx_deal.field_58d%type,
  p_vn_flag      fx_deal.vn_flag%type,
  p_nazn         varchar2 )  is 

  l_fxdeal fx_deal%rowtype;  l_data   date;  l_datb   date;  l_FOREX_KOD forex_ob22.kod%type;

begin 
  If gl.aMfo <> F_Get_Params('GLB-MFO')  then  RETURN ;  end if;

  l_FOREX_KOD := NVL( Pul.Get('FOREX_KOD'),  Forex.get_forextype (p_dat, p_data , p_datb ) ) ;

  If    p_dealtype = 1 then l_FOREX_KOD := 'V.SWAP_'|| l_FOREX_KOD ;
  ElsIf p_dealtype = 2 then l_FOREX_KOD := 'D.SWAP_'|| l_FOREX_KOD ;
  end if;

  pul.put('FOREX_KOD', l_FOREX_KOD);
  ---------------------------------
  l_fxdeal.deal_tag    := null;
  l_fxdeal.swap_tag    := p_swap_tag;
  l_fxdeal.ntik        := p_ntik;
  l_fxdeal.dat         := p_dat;
  l_fxdeal.kva         := p_kva;
  l_fxdeal.dat_a       := p_data;
  l_fxdeal.suma        := p_suma;
  l_fxdeal.sumc        := p_sumc;
  l_fxdeal.kvb         := p_kvb;
  l_fxdeal.dat_b       := p_datb;
  l_fxdeal.sumb        := p_sumb;
  l_fxdeal.sumb1       := p_sumb1;
  l_fxdeal.sumb2       := p_sumb2;
  l_fxdeal.rnk         := p_rnk;
  l_fxdeal.nb          := p_nb;
  l_fxdeal.kodb        := p_kodb;
  l_fxdeal.swi_ref     := p_swi_ref;
  l_fxdeal.swi_bic     := p_swi_bic;
  l_fxdeal.swi_acc     := p_swi_acc;
  l_fxdeal.nlsa        := p_nlsa;
  l_fxdeal.swo_bic     := p_swo_bic;
  l_fxdeal.swo_acc     := p_swo_acc;
  l_fxdeal.nlsb        := p_nlsb;
  l_fxdeal.b_payflag   := p_b_payflag;
  l_fxdeal.agrmnt_num  := p_agrmnt_num;
  l_fxdeal.agrmnt_date := p_agrmnt_date;
  l_fxdeal.interm_b    := p_interm_b;
  l_fxdeal.alt_partyb  := p_alt_partyb;
  l_fxdeal.bicb        := p_bicb;
  l_fxdeal.curr_base   := p_curr_base;
  l_fxdeal.telexnum    := p_telexnum;
  l_fxdeal.kod_na      := p_kod_na;
  l_fxdeal.kod_nb      := p_kod_nb;
  l_fxdeal.vn_flag     := p_vn_flag;
  l_fxdeal.acc9a       := null;
  l_fxdeal.acc9b       := null;
  l_fxdeal.ref         := null;
  l_fxdeal.refa        := null;
  l_fxdeal.refb        := null;
  l_fxdeal.refb2       := null;

  -- при уменьшении срока своп %% базы и ставки не меняются
  if p_mode = 4
  then

    begin
        select deal_tag, acc9a, acc9b, dat_a, dat_b, ref, refa, refb, refb2
          into l_fxdeal.deal_tag, l_fxdeal.acc9a, l_fxdeal.acc9b, l_data, l_datb,
               l_fxdeal.ref, l_fxdeal.refa, l_fxdeal.refb, l_fxdeal.refb2
          from fx_deal
         where deal_tag = ( select deal_tag from fx_deal
                             where swap_tag = p_swap_tag
                               and kva = l_fxdeal.kva and suma = l_fxdeal.suma
                               and kvb = l_fxdeal.kvb and sumb = l_fxdeal.sumb );
        if l_fxdeal.dat_a > l_data        or l_fxdeal.dat_b > l_datb        or l_fxdeal.dat_a = l_data and l_fxdeal.dat_b = l_datb then
           raise_application_error(-20000, 'Невірно вказані дати угоди !!!');
        end if;
    exception when no_data_found then
        l_fxdeal.deal_tag := null;
        l_fxdeal.acc9a := null;
        l_fxdeal.acc9b := null;
        l_fxdeal.ref   := null;
        l_fxdeal.refa  := null;
        l_fxdeal.refb  := null;
        l_fxdeal.refb2 := null;
    end;

  end if;

  new_deal(p_mode, l_fxdeal, p_nazn);

  p_deal_tag := l_fxdeal.deal_tag;

  bars_audit.info( 'forex.create_deal: Exit with ( deal_tag = ' || l_fxdeal.deal_tag || ' ).' );

end create_deal;
-------------------------------------------------------------------------------
-- proc_swap
-- процедура разметки, перерасчета, оплаты платежного календаря по % сделки ДЕПО-СВОП
--
procedure proc_swap (
  -- p_mode - режим выполнения процедуры:
  -- 0 - Разбить помесячно пл.календарь
  -- 1 - Пересчет сумм пл.календаря
  -- 2 - Сохранение FX-сделок по процентам
  -- 4 - Разбить помесячно пл.календарь в связи с уменьшением срока ДЕПО СВОП
  p_mode     int,
  p_deal_tag number,
  p_basey_a  number,
  p_rate_a   number,
  p_basey_b  number,
  p_rate_b   number )
is
  l_deal_tag number;
  l_swap_tag number;
  l_fxdeal   fx_deal%rowtype;
  l_swapdeal fx_deal%rowtype;
  l_basey_a  number := 0;
  l_basey_b  number := 0;
  l_rate_a   number := 0;
  l_rate_b   number := 0;
  l_nmk      customer.nmk%type;
  i          number;
  L_NAZN     OPER.NAZN%TYPE;
begin

  If gl.aMfo <> F_Get_Params('GLB-MFO')  then  RETURN ;  end if;

  l_deal_tag := nvl(p_deal_tag, to_number(pul.Get_Mas_Ini_Val('DSW'))) ;
  if l_deal_tag is null then  raise_application_error(-20000, 'Невідомий ід. угоди !');  end if;

  select swap_tag into l_swap_tag from fx_deal where deal_tag = l_deal_tag;

  if l_swap_tag is null then    raise_application_error(-20000, 'Угода ' || l_deal_tag || ' не є SWAP-угодою !');   end if;

  select count(*) into i from fx_deal where swap_tag = l_swap_tag;
  if    i = 1 then     raise_application_error(-20000, 'Угода ' || l_deal_tag || ' не є SWAP-угодою !');
--  elsif i > 2 and p_mode <> 4 then   raise_application_error(-20000, 'По угоді ' || l_deal_tag || ' вже розмічено SWAP-угоди !');
  end if;

  -- выбираем вторую сделку
  select * into l_fxdeal    from fx_deal f   where swap_tag = l_swap_tag     and deal_tag <> l_swap_tag
     and (kva, suma, kvb, sumb) = (select kvb, sumb, kva, suma from fx_deal where deal_tag = l_swap_tag)
     and deal_tag = ( select max(deal_tag) from fx_deal where swap_tag = l_swap_tag and kva = f.kva and suma = f.suma and kvb = f.kvb and sumb = f.sumb);
  begin  SELECT NAZN INTO L_NAZN FROM OPER WHERE REF = l_fxdeal.REF;
         L_NAZN := SUBSTR('Проценти.'|| L_NAZN ,1, 160);
  exception when no_data_found then  NULL;
  end;

  -- 0 - Разбить помесячно пл.календарь
  if p_mode in (0, 4) then

     delete from fx_swap where deal_tag >= l_fxdeal.deal_tag;

     -- установка pul-переменной
     pul.Set_Mas_Ini('DSW', to_char(l_fxdeal.deal_tag), '№ обратной сделки ДЕПО-СВОП');

     -- установка %% базы и %% ставки
     if p_mode = 0 then if p_basey_a is null or p_basey_b is null then  raise_application_error(-20000, 'Не задано %% базу !'); end if;
                        if nvl(p_rate_a,0)=0 or nvl(p_rate_b,0)=0 then  raise_application_error(-20000, 'Не задано %% ставку !');   end if;
        set_rate(l_fxdeal.acc9a, p_basey_a, p_rate_a);
        set_rate(l_fxdeal.acc9b, p_basey_b, p_rate_b);

        insert into fx_swap (deal_tag, npp, dat1, dat2, vdat, kva, suma, kvb, sumb, basey_a, rate_a, basey_b, rate_b)
        select l_fxdeal.deal_tag, x.npp, dat1, dat2, vdat,
               l_fxdeal.kva, calp(l_fxdeal.suma, p_rate_a, x.dat1, x.dat2, p_basey_a),
               l_fxdeal.kvb, calp(l_fxdeal.sumb, p_rate_b, x.dat1, x.dat2, p_basey_b),
               p_basey_a, p_rate_a, p_basey_b, p_rate_b
          from ( select greatest(trunc(add_months(l_fxdeal.dat, c.num-1) ,'MM'), l_fxdeal.dat) dat1,
                        least(last_day(add_months(l_fxdeal.dat, c.num-1)), l_fxdeal.dat_a-1)   dat2,
                        least(last_day(add_months(l_fxdeal.dat, c.num-1)), l_fxdeal.dat_a  )   vdat,  c.num npp
                 from conductor c where add_months(l_fxdeal.dat, c.num-2) <= l_fxdeal.dat_a  and l_fxdeal.dat_a > l_fxdeal.dat
                 union all   select  l_fxdeal.dat, l_fxdeal.dat, l_fxdeal.dat, 0 from dual where l_fxdeal.dat_a = l_fxdeal.dat
               ) x
          where dat1 <= dat2 and dat2 <= vdat ;

     else
        begin select basey into l_basey_a from int_accn where acc = l_fxdeal.acc9a and id = 0;
        exception when no_data_found then raise_application_error(-20000, 'По угоді не визначено %% базу!');
        end;
        begin select basey into l_basey_b from int_accn where acc = l_fxdeal.acc9b and id = 1;
        exception when no_data_found then raise_application_error(-20000, 'По угоді не визначено %% базу!');
        end;

        insert into fx_swap (deal_tag, npp, dat1, dat2, vdat, kva, suma, kvb, sumb, basey_a, rate_a, basey_b, rate_b)
        select l_fxdeal.deal_tag, x.npp, dat1, dat2, vdat,
               l_fxdeal.kva, calp(l_fxdeal.suma, get_int_rate(l_fxdeal.acc9a, x.dat1), x.dat1, x.dat2, l_basey_a),
               l_fxdeal.kvb, calp(l_fxdeal.sumb, get_int_rate(l_fxdeal.acc9b, x.dat1), x.dat1, x.dat2, l_basey_b),
               l_basey_a, get_int_rate(l_fxdeal.acc9a, x.dat1) rate_a, l_basey_b, get_int_rate(l_fxdeal.acc9b, x.dat1) rate_b
          from ( select greatest(trunc(add_months(l_fxdeal.dat, c.num-1) ,'MM'), l_fxdeal.dat) dat1,
                        least(last_day(add_months(l_fxdeal.dat, c.num-1)), l_fxdeal.dat_a-1)   dat2,
                        least(last_day(add_months(l_fxdeal.dat, c.num-1)), l_fxdeal.dat_a  )   vdat,  c.num npp
                 from conductor c where add_months(l_fxdeal.dat, c.num-2) <= l_fxdeal.dat_a  and l_fxdeal.dat_a > l_fxdeal.dat
                 union all   select  l_fxdeal.dat, l_fxdeal.dat, l_fxdeal.dat, 0 from dual where l_fxdeal.dat_a = l_fxdeal.dat
               ) x
          where dat1 <= dat2 and dat2 <= vdat   ;
---and vdat >= least(l_fxdeal.dat_a, l_fxdeal.dat_b);
     end if;


  -- 1 - Пересчет сумм пл.календаря
  --   размечаем/пересчитываем календарь
  elsif p_mode = 1 then

     if l_fxdeal.acc9a is null then   raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано рах 9 кл для вал-А');    end if;

     begin   select basey, acrn.fprocn(acc, id, l_fxdeal.dat) into l_basey_a, l_rate_a from int_accn where acc = l_fxdeal.acc9a and id = 0 ;
     exception when no_data_found then  raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано проц.карт-0 9 кл для вал-А');
     end;

     if l_basey_a is null      then raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано проц базу-0 9 кл для вал-А');     end if;
     if nvl(l_rate_a,0) <= 0   then raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано проц.ставку-0 9 кл для вал-А');   end if;
     if l_fxdeal.acc9b is null then raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано рах 9 кл для вал-Б');             end if;

     begin  select basey, acrn.fprocn(acc, id, l_fxdeal.dat) into l_basey_b, l_rate_b from int_accn where acc = l_fxdeal.acc9b and id = 1 ;
     exception when no_data_found then   raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано проц.карт-1 9 кл для вал-Б');
     end;

     if l_basey_b is null      then raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано проц базу-1 9 кл для вал-Б');     end if;
     if nvl(l_rate_b,0) <= 0   then raise_application_error(-20000, 'deal_tag=' || l_fxdeal.deal_tag || ' Не вказано проц.ставку-1 9 кл для вал-Б');   end if;

     update fx_swap t1
        set t1.dat1 = (select nvl(max(t2.vdat+1),l_fxdeal.dat) from fx_swap t2 where t2.deal_tag = t1.deal_tag and t2.vdat < t1.vdat),
            t1.dat2 = decode(t1.vdat, l_fxdeal.dat_a, t1.vdat-1, t1.vdat)
      where t1.deal_tag = l_fxdeal.deal_tag;

     update fx_swap t1
        set t1.dat1 = l_fxdeal.dat
      where t1.deal_tag = l_fxdeal.deal_tag
        and t1.npp = (select min(t2.npp) from fx_swap t2 where t2.deal_tag = t1.deal_tag);

     update fx_swap t1
        set suma = calp(l_fxdeal.suma, l_rate_a, t1.dat1, t1.dat2, l_basey_a),
            sumb = calp(l_fxdeal.sumb, l_rate_b, t1.dat1, t1.dat2, l_basey_b),
            npp  = (select count(*) from fx_swap t2 where t2.deal_tag = t1.deal_tag and t2.vdat <= t1.vdat)
      where t1.deal_tag = l_fxdeal.deal_tag;

  -- 2 - Сохранение FX-сделок по процентам
  elsif p_mode = 2 then

     -- бек предыдущих по процентам
     for z in ( select * from fx_deal where swap_tag = l_swap_tag and deal_tag  not in (l_fxdeal.deal_tag, l_fxdeal.swap_tag)  )
     loop ful_bak( z.REF);   end loop;


     for z in ( select * from fx_swap where deal_tag = l_fxdeal.deal_tag and nvl(suma,0) <> 0 and nvl(sumb,0) <> 0 order by npp )
     loop
        l_swapdeal.deal_tag    := null;
        l_swapdeal.swap_tag    := l_swap_tag;
        l_swapdeal.ntik        := l_fxdeal.ntik;
        l_swapdeal.dat         := l_fxdeal.dat;
        l_swapdeal.kva         := z.kva;
        l_swapdeal.dat_a       := z.vdat;
        l_swapdeal.suma        := z.suma;
        l_swapdeal.sumc        := null;
        l_swapdeal.kvb         := z.kvb;
        l_swapdeal.dat_b       := z.vdat;
        l_swapdeal.sumb        := z.sumb;
        l_swapdeal.sumb1       := 0;
        l_swapdeal.sumb2       := 0;
        l_swapdeal.rnk         := l_fxdeal.rnk;
        l_swapdeal.nb          := l_fxdeal.nb;
        l_swapdeal.kodb        := l_fxdeal.kodb;
        l_swapdeal.swi_ref     := l_fxdeal.swi_ref;
        l_swapdeal.swi_bic     := l_fxdeal.swi_bic;
        l_swapdeal.swi_acc     := l_fxdeal.swi_acc;
        l_swapdeal.nlsa        := l_fxdeal.nlsa;
        l_swapdeal.swo_bic     := l_fxdeal.swo_bic;
        l_swapdeal.swo_acc     := l_fxdeal.swo_acc;
        l_swapdeal.nlsb        := l_fxdeal.nlsb;
        l_swapdeal.b_payflag   := l_fxdeal.b_payflag;
        l_swapdeal.agrmnt_num  := l_fxdeal.agrmnt_num;
        l_swapdeal.agrmnt_date := l_fxdeal.agrmnt_date;
        l_swapdeal.interm_b    := l_fxdeal.interm_b;
        l_swapdeal.alt_partyb  := l_fxdeal.alt_partyb;
        l_swapdeal.bicb        := l_fxdeal.bicb;
        l_swapdeal.curr_base   := l_fxdeal.curr_base;
        l_swapdeal.telexnum    := l_fxdeal.telexnum;
        l_swapdeal.kod_na      := l_fxdeal.kod_na;
        l_swapdeal.kod_nb      := l_fxdeal.kod_nb;
        l_swapdeal.field_58d   := l_fxdeal.field_58d;
        l_swapdeal.vn_flag     := l_fxdeal.vn_flag;
        l_swapdeal.acc9a       := l_fxdeal.acc9a;
        l_swapdeal.acc9b       := l_fxdeal.acc9b;

        -- данные партнера
        select substr(nvl(c.nmkk,c.nmk),1,38) into l_nmk  from customer c   where c.rnk = l_swapdeal.rnk;

        new_deal(3, l_swapdeal, L_NAZN);

     end loop;

     delete from fx_swap where deal_tag = l_fxdeal.deal_tag;

  end if;

end proc_swap;

-------------------------------------------------------------------------------
-- rev_swap
-- переоценка портфеля сделок
--
procedure UPD1 (p_otm1 int   , -- закрыть сделку
                p_otm int    , -- переоценить сделку
                p_Deal number, -- реф возвратной сделки
                p_PVX number , -- справ.стоимость текущая
                p_PVX1 number, -- справ.стоимость предыдущая
                p_IRAE number,
                p_IRBE number) is
  xx      fx_deal%rowtype ;
begin

  begin  select * into xx from fx_deal where deal_tag = p_deal ;
  exception when no_data_found then  Return;
  end;

  If    p_otm1 = 1   then FOREX.FX_CLOSE (p_dat  => gl.bdate   ,  -- отчетная дата
                                          p_deal => 0          ,  -- реф. одной записи                       или 0=ВСЕ \
                                          p_swap => xx.Swap_tag   -- реф. одного свопа (несколько записей )  или 0=все  \
                                          ) ; -- закрытие
  ElsIf p_otm  = 1   then FOREX.rev_swap_OB
                                         (p_otm, p_Deal, p_PVX, p_PVX1, p_IRAE , p_IRBE ); -- переоценка
  end if;

end UPD1;

-------------------------------------------------------------------------------
procedure ADD_IR (p_DAT date, p_DAT31 date, p_kv number, p_IR number) is
   -- запоминание ручных средних ставок
   l_min  int ;
   l_max  int ;
   l_trm  int := p_DAT  -  p_DAT31 ;  -- срок размещения
begin
   select min(term), max(term) into l_min, l_max from INT_RATN_MB where kv = p_kv and fdat = p_DAT31 ;
   If l_min is null  OR l_trm < l_min   OR l_trm > l_max  then -- отсутствуют вообще | наш срок меньше мин в справочнике | наш срок больше макс в справочнике
      Insert into INT_RATN_MB (FDAT, KV, TERM, IR) values ( p_DAT31, p_kv, l_trm, p_IR ) ;
   end if;

end ADD_IR ;

-------------------------------------------------------------------------------
procedure rev_swap_OB (p_otm int, p_Deal number, p_PVX number, p_PVX1 number, p_IRAE number, p_IRBE number) is
  oo      oper%rowtype       ;
  l_PVq   number             ;
  l_PVA   number             ;
  l_PVB   number             ;
  xx      fx_deal%rowtype    ;
  f_OB    forex_ob22%rowtype ;
  aa_D    acCounts%rowtype   ;  -- счет деб.зад. (актив)
  aa_K    acCounts%rowtype   ;  -- счет кред.зад. (пассив)
  aa_6    acCounts%rowtype   ;  -- счет НеРеализ.рез.
  L_dat   date               :=  gl.bdate ;
  l_Kod   varchar2(30)       ;
  l_nls varchar2(15)         ;
  l_Tmp int;
begin
  If gl.aMfo <> F_Get_Params('GLB-MFO')  then  RETURN ;  end if;

  If NVL(p_otm,0) <> 1                      then RETURN; end if;

  l_PVq := NVL(p_PVX, 0) * 100 ;

  If NVL(p_PVX1,0) = 0 and  NVL(L_PVq,0) =0 and ( nvl(p_IRAE,0) = 0 OR  nvl(p_IRBE,0) =0 )   then RETURN; end if;

  --  07.02.2017 Sta + Алена Ш. убрали переоц Похидных ФИ, которое БЕК
  begin  select x.* into xx from fx_deal x where deal_tag = p_deal
            and EXISTS (SELECT 1 FROM oper  WHERE REF = x.REF AND sos > 0)
            AND NVL (x.sos, 10) < 15 ;
  exception when no_data_found then  Return;
  end;

  l_Kod := Substr ( FOREX.get_forextype3K ( xx.deal_tag) , 1, 30) ;

  If l_Kod like '%TOD%' then return; end if;
  ---- 
  begin select * into f_OB  from forex_ob22  where kod = l_kod  ;
  exception when no_data_found then  raise_application_error(-(20203), 'Не налаштовано (в forex_ob22) параметри переоцiнки для ' || l_kod);
  end;

---- 04/10/2016 Sta Счета крд и деб задолж по переоценке до справ.стоимости - в разрезе контрагентов
  aa_d.NBS    := substr(f_OB.s3d,1,4) ;
  aa_d.ob22   := substr(f_OB.s3d,6,2) ;
  begin select * into aa_D from accounts where kv=gl.baseval and nbs=aa_d.NBS and ob22=aa_d.ob22 and dazs is null and rnk=xx.rnk and rownum=1;
  exception when no_data_found then

    aa_d.acc  := FOREX.open_accF (xx.rnk, aa_d.NBS, gl.baseval);
    accreg.setAccountSParam(aa_d.acc, 'OB22', aa_d.ob22 );

    begin select * into aa_D from accounts where acc = aa_d.acc;
    exception when no_data_found then raise_application_error(-(20203), 'Не знайдено '||f_OB.s3d ||  ' для РНК='||xx.rnk );
    end ;
  end;

  aa_k.NBS  := substr(f_OB.s3k,1,4) ;
  aa_k.ob22 := substr(f_OB.s3k,6,2) ;
  begin select * into aa_K from accounts where kv=gl.baseval and nbs=aa_k.NBS and ob22=aa_k.ob22 and dazs is null and rnk=xx.rnk and rownum=1;
  exception when no_data_found then
    aa_k.acc  := FOREX.open_accF (xx.rnk, aa_k.NBS, gl.baseval);
    accreg.setAccountSParam(aa_k.acc, 'OB22', aa_k.ob22 );
    begin select * into aa_k from accounts where acc = aa_k.acc;
    exception when no_data_found then raise_application_error(-(20203), 'Не знайдено '||f_OB.s3k ||  ' для РНК='||xx.rnk );
    end ;
  end;
  -------
  aa_6.nls := f_OB.s62 ;

  begin select * into aa_6 from accounts where kv=gl.baseval and nls = f_OB.s62 and dazs is null and rownum = 1;
  exception when no_data_found then  raise_application_error(-(20203), 'Не знайдено для '|| l_kod || ' рах ' || f_OB.s62 );
  end;
  ---------------------------------
  oo.kv := gl.baseval;  oo.tt := 'FXP';  oo.vob := 6;  oo.datd := l_dat;  oo.ref      := xx.ref; ----null;
  oo.nazn     := 'Переоцiнка SWAP-угоди '|| xx.ntik ||' вiд '|| to_char( xx.dat, 'dd.mm.yyyy' ) ||
                     ' по справедливiй вартостi станом на '      || to_char(  l_dat, 'dd.mm.yyyy' );
  oo.nlsa     := aa_6.nls;    oo.nam_a    := substr(aa_6.nms,1,38) ;

  If NVL(p_PVX1,0) <> 0 then oo.d_rec  :='Обнулення порередньої справедливої вартостi= ' || p_pvx1 ; oo.s :=   p_PVX1*100 ;
     If p_PVX1 > 0      then oo.dk := 1;  oo.nlsb := aa_D.nls ; oo.nam_b := substr(aa_D.nms,1,38)  ;
     else                    oo.dk := 0;  oo.nlsb := aa_K.nls ; oo.nam_b := substr(aa_K.nms,1,38)  ; oo.s := - oo.s   ;
     end if;
     FOREX.opl1(oo);
  end if;
  -----
  If NVL(L_PVq,0) = 0 and  p_IRAE > 0 and p_IRBE > 0  then

     -- запоминание ручных средних ставок в справочнике - для возможного использования в других сделках
     ADD_IR (xx.dat_A, l_DAT, xx.kva , p_IRAE) ;
     ADD_IR (xx.dat_B, l_DAT, xx.kvB , p_IRBE) ;

     l_PVA := FOREX.PVXR ( p_swap => nvl(xx.swap_tag, xx.deal_tag), p_deal => xx.deal_tag, p_dat => l_dat, p_kv => xx.kva, p_IRE => p_IRAE );
     l_PVB := FOREX.PVXR ( p_swap => nvl(xx.swap_tag, xx.deal_tag), p_deal => xx.deal_tag, p_dat => l_dat, p_kv => xx.kvb, p_IRE => p_IRBE );
     l_PVq := gl.p_icurval( xx.kva, l_PVA, l_dat) - gl.p_icurval( xx.kvb, l_PVB, l_dat) ;
  End if;


  -----
  If NVL(l_PVq, 0) <> 0 then oo.d_rec  :='Формування поточної справедливої вартостi= ' || l_pvq  ;
     If l_PVq > 0       then oo.dk := 0;  oo.s :=  l_PVq  ;  oo.nlsb := aa_D.nls ; oo.nam_b := substr(aa_D.nms,1,38) ;
     else                    oo.dk := 1;  oo.s := -l_PVq  ;  oo.nlsb := aa_K.nls ; oo.nam_b := substr(aa_K.nms,1,38) ;
     end if;
     FOREX.opl1(oo);
  end if;

  If oo.ref is not null then  gl.pay ( 2, oo.ref, gl.bdate); end if ;

  update fx_deal set sump = l_PVq where deal_tag = p_deal ;

end rev_swap_OB;

-------------------------------------------------------------------------------
-- pay_3800
-- процедура Взято на вал/поз торгове сальдо угоди без кл.частини
--
procedure p3800 (p_deal_tag fx_deal.deal_tag%type ) is
  xx fx_deal%rowtype    ;
  kk forex_ob22%rowtype ;
  l_kod    varchar2(30) ;
  l_1819  accounts.nls%type;
  l_3800  accounts.nls%type;
  l_stmt  number ;  l_sos   number ;  nTmp_ number ;
begin
  If gl.aMfo <> F_Get_Params('GLB-MFO')  then  RETURN ;  end if;

  begin   select * into xx from fx_deal where deal_tag = p_deal_tag and ref is not null ;
  exception when no_data_found then  raise_application_error(-(20203), 'Не знайдено ФОРЕКС № ' ||  p_deal_tag );
  end;

  -- Взятие на вал.поз - только в пл.даты (т.к. форвард нельзя, не знаем курс)
  If least ( xx.dat_a, xx.dat_b) >  gl.bdate then    RETURN;   end if;

  -- Зашита от повторного выполнения
  begin select 1  into nTmp_ from opldok o, vp_list v  where o.ref = xx.ref and o.acc =v.acc3800 and rownum=1 ; -- 288972272
        RETURN ;
  exception when no_data_found then null;
  end;

  l_Kod := FOREX.get_forextype3K (  xx.deal_tag )  ;
  begin   select * into kk from forex_ob22 where kod  = l_kod;
  exception when no_data_found then  raise_application_error(-(20203), 'Не знайдено опис для ФОРЕКС-тип ' ||  l_kod );
  end;

  -- торговый счет
  If gl.amfo = '300465' then  l_1819 := nbs_ob22_null( substr(kk.s1t,1,4), substr(kk.s1t,6,2), '/300465/000010/' );
  Else                        l_1819 := nbs_ob22_null( substr(kk.s1t,1,4), substr(kk.s1t,6,2)                    );
  end if;

  --сальдо торгового счета в рамках этого реф
  select nvl( sum( decode(o.dk,1,1,-1) *o.s), 0) into xx.suma from opldok o, accounts a where o.ref=xx.ref and o.acc=a.acc and a.nls=l_1819 and a.kv=xx.kva;
  select nvl( sum( decode(o.dk,1,1,-1) *o.s), 0) into xx.sumb from opldok o, accounts a where o.ref=xx.ref and o.acc=a.acc and a.nls=l_1819 and a.kv=xx.kvb;

  If xx.suma > 0 or xx.sumb < 0 then
     xx.suma := greatest (0,  xx.suma );
     xx.sumb := greatest (0, -xx.sumb );

     If gl.amfo = '300465' then  l_3800 := nbs_ob22_null( substr(kk.s38,1,4), substr(kk.s38,6,2), '/300465/000010/' );
     Else                        l_3800 := nbs_ob22_null( substr(kk.s38,1,4), substr(kk.s38,6,2) );
     end if;

     PUL.Set_Mas_Ini( 'VP', l_3800, 'Рах.вал/поз' );
     select max(stmt) , max(sos) into l_stmt, l_sos from opldok where ref = xx.ref;

---- update oper   set dk  = 1, kv = xx.kva, nlsa = l_1819, s = xx.suma, kv2 = xx.kvb, nlsb = l_1819, s2 = xx.sumb where ref = xx.ref ;

     If kk.p_SPOT = 1 then
        -- Признак розрахунку РКР-3 від СЗККВ/СЗКПВ по рах.вал.поз
        payTT (0, xx.ref, gl.Bdate,  '38V', 1, xx.kva, l_1819, xx.suma, xx.kvb, l_1819, xx.sumb);
        update opldok set txt = 'Взято на вал/поз тогрове сальдо угоди без кл.частини' where ref = xx.ref and stmt > l_stmt and tt <> 'SPM';
     Else
        -- Иначе по правилам ПОХИДНЫХ ФИ - Рыбалко Л
        gl.payv (0, xx.ref, gl.Bdate,  '38V', 1, xx.kva, l_1819, xx.suma, xx.kvb, l_1819, xx.sumb);
        update opldok set txt = to_char(sysdate,'dd.mm.yy hh24:mi:ss#') ||'Взято на вал/поз тогрове сальдо угоди без кл.частини'
         where ref = xx.ref and stmt > l_stmt;

        -- Перебросить нереализованный на реализованній результат с датой конца сделки
        declare  l_nlsN number; l_nlsR number; l_s number; l_dk int;  l_vdat date  := gl.bdate ; vp vp_list%rowtype ;l_kv int;
        begin
           --- Выбор счетов по матрице
           If xx.kva <> gl.baseval then l_kv := xx.kva;
           Else                         l_kv := xx.kvb;
           end if;
           begin  select v.*  into vp  from  vp_list v, accounts a where a.kv = l_kv  and a.nls = l_3800 and a.acc = v.acc3800;
           exception when no_data_found then raise_application_error(-(20203), 'Не знайдено ВалПоз KV=' || l_kv || ' nls='|| l_3800 );
           end;
           begin  select D.nls, S.nls into l_nlsN, l_nlsR from accounts D, accounts S where d.acc= vp.acc_rrd and s.acc = vp.acc_rrs ;
           exception when no_data_found then
              raise_application_error(-(20203), 'Не знайдено для ВалПоз KV=' ||l_kv || ' nls='|| l_3800   || ' рах.НКР-2 або РКР' );
           end;
           -- Проводка по оф.курсу ( м.б. форвардная)
           l_s := gl.p_icurval( xx.kva, xx.suma, gl.bdate)  - gl.p_icurval( xx.kvb, xx.sumb, gl.bdate) ;
           If l_s <> 0 then
              If l_s > 0 then l_dk := 1 ;
              Else            l_dk := 0 ; l_s  := - l_s;
              end if ;
              If xx.swap_tag is not null then
                 select Nvl( max( greatest(dat_a, dat_b)), gl.bDate)  into l_vdat from fx_deal where swap_tag = xx.swap_tag;
              end if;
              gl.payv(0, xx.ref, l_vdat, 'FXP', l_dk, gl.baseval, l_nlsN, l_s, gl.baseval, l_nlsR, l_s);
              update opldok set txt = to_char(sysdate,'dd.mm.yy hh24:mi:ss#') ||'НP->РP,оф.курс' where ref = xx.ref and stmt = gl.aStmt;
           End if;
        end;
     end if;

     if l_sos >= 4 then    -- xx.dat < gl.bdate then -- автовиза только на вставки(дооплаты)  вал.поз в существующие
        gl.pay (2, xx.ref, gl.bdate);
     end if;

  End if;

end  p3800 ;

-------------------------------------------------------------------------------
-- set_fxswap
-- процедура установки сумм платежного календаря по % сделки ДЕПО-СВОП
--
procedure set_fxswap (p_dealtag number, p_npp number, p_suma number, p_sumb number, p_VDAT date) is
begin
  update fx_swap SET suma = p_suma*100, vdat = p_VDAT,  sumb = p_sumb*100  WHERE  deal_tag = p_dealtag and npp = p_npp;
end set_fxswap;

-------------------------------------------------------------------------------
procedure FX_DEL (p_mode int , p_tag number ) is
  xx fx_deal%rowtype;

begin

  If p_mode = 3 then  ---- Розгорнення залишку по COBUSUPABS-4730 - разовыи скрипт

     declare dat1_ date ;  a_NEW accounts%rowtype; oo oper%rowtype ;  nTmp_ int ;
     begin
       -- цикл по счетам
       for A_OLD in ( select * from accounts  where nbs in  ('3041','3351')  and ostc <>0 and kv = 980 )
       loop
         update accounts set pap = 3 where acc = A_OLD.acc;
         -- найти последнюю дату когда ост был = 0
         select max(fdat) into dat1_ from saldoa  where  acc = A_OLD.acc  and ostf = 0 ;
         -- найти суммы по каждой сделке
         for RR in (select f.RNK, f.REF, sum( decode (o.dk,0, -1, 1)*o.s) S
                    from opldok o, fx_deal f
                    where o.acc = A_OLD.acc and o.fdat >= dat1_ and o.sos=5   and o.ref = f.ref
                    group by f.RNK, f.REF
                    having sum ( decode (o.dk,0, -1, 1)*o.s) <> 0
                   )
         loop
            begin select * into A_NEW from accounts
                  where kv=980 and nbs=A_OLD.NBS and ob22=A_OLD.ob22 and dazs is null and rnk = RR.rnk and rownum=1;
            exception when no_data_found then
                  A_NEW.nls := substr(f_newnls2(null, 'ODB', A_OLD.nbs, RR.rnk, null, A_OLD.kv),1,14) ;
                  A_NEW.nms := substr(f_newnms (null, 'ODB', A_OLD.nbs, RR.rnk, null          ),1,70) ;
                  -- открытие счета
                  op_reg_ex(99, 0, 0, null, nTmp_ , RR.rnk, A_NEW.nls, A_OLD.kv, A_NEW.nms, A_OLD.tip, A_OLD.isp, A_NEW.acc);
                  Accreg.setAccountSParam(A_NEW.Acc, 'OB22', A_OLD.OB22);
            end ;
            If RR.s < 0 then nTmp_ := 0 ;    RR.s := - RR.S ;
            else             nTmp_ := 1 ;
            end if;
            gl.payv(0, RR.ref, gl.bdate, '024', nTmp_, 980, A_OLD.nls, RR.s, 980, A_NEW.nls, RR.s );
            update opldok set txt = 'Розгорнення залишку по COBUSUPABS-4730' where ref = RR.ref and  stmt = gl.aStmt;
            gl.pay (2, RR.ref, gl.bdate );
         end loop  ;  -- RR
         update accounts set pap = A_OLD.pap, dazs = gl.bdate +1 where acc = A_OLD.acc;
       end loop    ;  -- A_OLD;
     end;
     RETURN;
  end if;
  ------------------

  begin   select * into xx from fx_deal where deal_tag = p_tag ;
  exception when no_data_found then   raise_application_error(-(20203), 'Не знайдено угоду =' || p_tag );
  end;

  If p_mode = 1  then     -- F1_Select(13,"FOREX.FX_DEL_DEL(1,:SWAP_TAG);Анул.поч.угоду "|| Str( :SWAP_TAG) || " ?; ОК !" )
     for k in (select * from oper where ref in ( xx.ref, nvl(xx.refa, xx.ref), nvl(xx.refb, xx.ref) ) )
     loop  if  k.sos > 3 then  raise_application_error(-(20203), 'Док реф = ' || k.ref || ' уже завізовано ! '  );
           else ful_bak (k.ref) ;
           end if ;
     end loop ;

  elsIf p_mode = 0   then      -- F1_Select(13,"FOREX.FX_DEL_DEL(0,:DEAL_TAG,);Анул.ВСЮ.угоду "|| Str( :_TAG) || " ?; ОК !" )

     for k in (select *
               from oper
               where ref in
                    (select r.ref from fx_deal x, fx_deal_ref r
                     where r.deal_tag = x.deal_tag and ( x.deal_tag = xx.deal_tag OR x.swap_tag = xx.swap_tag )
                     )
              )
     loop  if  k.sos > 3 then  raise_application_error(-(20203), 'Док реф = ' || k.ref || ' уже завізовано ! '  );
           else ful_bak (k.ref) ;
           end if ;
     end loop ;
  end if ;
end FX_DEL;

procedure set_int_ratn_mb( p_date date, p_kv number, p_term number, p_ir number)
  as
  begin
   insert into int_ratn_mb
            (fdat, kv, term, ir)
   values  (p_date, p_kv, p_term, p_ir);
  exception when others then  if (sqlcode = -1)
                                   then  raise_application_error(-20000,'Данний запис вже існує (Дата+Валюта+Термін розміщення) ');
                              elsif (sqlcode =-01400)  then    raise_application_error(-20000,'Не заповнено всі обов`язкові поля! ');
                              else raise; end if;
  end;

begin
  init;
end;
/
 show err;
 
PROMPT *** Create  grants  FOREX ***
grant EXECUTE                                                                on FOREX           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FOREX           to BARS_CONNECT;
grant EXECUTE                                                                on FOREX           to FOREX;
grant EXECUTE                                                                on FOREX           to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/forex.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 