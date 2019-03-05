CREATE OR REPLACE PACKAGE BARS.PRVN_FLOW
is
/*  
  27.12.2018 Сухова. Для отладки Добавила  procedure D_XXX   ( p_dat01 date, p_ND number ) ; -- Обработка витрины по 1 дог
*/
  --
  -- constants
  --
  G_HEADER_VERSION  CONSTANT VARCHAR2(64) := 'version 3.6  27.12.2018';
  G_SHOW_LOG                 BOOLEAN      := false;

  --
  -- types
  --
  type r_cur_type is record ( CCY_ID  number(3)
                            , AGR_ID  number(38)
                            , END_DT  date
                            , GEN_ID  number(38)
--                          , LIM_BAL number(24)
                            , AGR_QTY number(3)
                            , AGR_NUM number(3)
                            , AGR_TP  varchar(3)
                            );

  type c_cur_type is ref cursor return r_cur_type;

  type r_shd_type is record ( ND        number(38)  -- Agreement id ( AGRM_ID )
                            , FDAT      date        --
                            , LMT_INPT  number(24)  -- limit input  ( LMT_AMNT_IN )
                            , LMT_OTPT  number(24)  -- limit output ( LMT_AMNT_OUT )
                            , SS        number(24)  --
                            , SN        number(24)  --
                            , SNO       number(24)  -- відкладенні відсотки
                            , SSP       number(24)  --
                            , SNP       number(24)  --
                            , DAY_QTY   number(24)  -- кількість днів у періоді для розрахунку відсотків
                            , IR        number(6,3) --
                            , SN1       number(24)  -- Розрах.Відсотки на SS
                            , SN2       number(24)  -- Розрах.Відсотки на SP
                            );

  type t_shd_type is table of r_shd_type;

  --
  -- cursors
  --

  --
  -- functions
  --
  function header_version return varchar2;
  function body_version   return varchar2;

  --
  -- получение DOS, KOS
  --
  function QDK_12
  ( p_dk   int
  , p_acc  number
  , p_dat1 date
  , p_dat2 date
  , p_di   number
  , p_nbs  varchar2
  , p_ZO   int
  ) return number;

  --
  -- получение ост (аналог OST_KORR)
  --
  function QST_12
  ( p_acc  accounts.acc%type
  , p_dat  date
  , p_nbs  accounts.nbs%type
  , p_zo   int
  ) return accounts.ostc%type;

  --
  -- получение суммы однотипных сч
  --
  function GET_SUM
  ( p_nd    number
  , p_kv    int
  , p_tip   accounts.tip%type
  , p_dat01 date
  , p_ZO    int
  ) return number;

  --
  -- получение дельты PV по дате ректркутуризации
  --
  function F_DEL_PV
  ( p_id   number
  , p_Rdat date
  ) return number;

  --
  -- получение номера лиц.счета
  --
  function GET_NLS_b
  ( p_nd   number
  , p_tip  accounts.tip%type
  ) return varchar2;

  --
  -- =1 - берем с архива ND_ACC_ARC
  -- =0 - берем прямо из ND_ACC
  --
  function G_ND_ACC
  ( p_DAT01 DATE
  ) return  INT;

  ------------------------------------
  procedure err_23  ( p_dat01 date   ); -- n) Перевірка 100%-ї Готовністі   НБУ-23
  procedure SEND_MSG( p_txt varchar2 ); -- BMS Признак: 1-установлена рассылка сообщений
  procedure LOC_DAT ( p_bDAT date    ); -- d) Установити локальну Банк.Дату
  procedure F02     ( p_dat31 date   ); -- 7 ) #02 *Формування #02
  procedure DRAPS02 ( p_dat31 date   ); -- *) SNP: Пере-Формування місячного знімоку
  procedure REC_23  ( p_dat01 date   ); -- 3) Z23: *Пере-Формування Рез-НБУ-23
  ------------------------------------
  procedure bal0    ( p_mode int, p_nd number, p_tip accounts.tip%type, p_dat01 date, p_ZO int )           ; -- балансировка - по дон. по типу счета
  ------------------------------------
  procedure p60     ( p_tipA IN int, p_ND IN number, p_acc_sna IN number, a6 OUT accounts%rowtype ) ;
  procedure u_SNA   ( p_dat   date ) ; -- урегулирование НЕВИЗНАНИХ. Уменьшение SNA := LEAST ( SNA, -(SN+SPN) )
  procedure D_XXX   ( p_dat01 date, p_ND number ) ; -- Обработка витрины по 1 дог
  procedure D_SNA   ( p_dat01 date ) ; -- SNA от Делойта
  procedure heir39  ( p_dat01 date ) ; -- наследование рез-МСФЗ от промлого месяца
  procedure opl     ( oo IN OUT oper%rowtype ) ;
  function  BAD_CP  ( p_OSA VARCHAR2, z_dat01 date )  return varchar2 ;
  procedure div39   ( p_mode int, p_dat01 date ); -- разделение рез-39 по КД в НБУ-23-РЕЗ.
  procedure del0    ( p_mode int)               ; -- отладочная процедура очистки всех таблиц
  procedure FROM_SRR_XLS (p_ID_CALC_SET srr_xls.id_calc_set%type);
-- -- ежедневная процедура добавки новых КД
-- procedure add1
-- ( p_dat01 date
-- , p_mode  int     default 0
-- , p_nd    number  default null );
--
-- -- Построение ден.потоков по требованию
-- procedure add2( p_mode int, p_id number, p_dat01 date, p_zo int  );
--
-- -- Построение ден.потоков по КП
-- procedure ADD2_SS ( x0 prvn_flow_deals_const%rowtype,
--                     xx prvn_flow_deals_var%rowtype,
--                     p_dat31 date,
--                     p_dat01 date,
--                     p_fla   int ,  p_fl_nd_acc int , p_zo int );

  ---- Для изменений во вюшке-гляделке но НОСТРО (по счетам !)------------------------------------
  procedure nos_ins( p_kv int, p_nls varchar2 );

  procedure nos_upd( p_nd    number, p_sos   int, p_CC_ID varchar2, p_SDATE date, p_WDATE   date , p_LIMIT number
                   , p_FIN23 int   , p_OBS23 int, p_KAT23 int     , p_pd    int , p_FIN_351 int );
  procedure nos_del( p_nd number);

  --
  --
  --
  procedure ADD_FIN_DEB
  ( p_dat date
  );

  --
  --
  --
  function GET_CROSS_RATE
  ( p_ccy_id_1         tabval$global.kv%type
  , p_ccy_id_2         tabval$global.kv%type
  , p_bnk_dt           date
  ) return number
  deterministic
  result_cache;

  --
  --
  --
  function GET_ADJ_SHD
  ( p_cur              prvn_flow.c_cur_type
  , p_rpt_dt           date
  , p_adj_f            signtype
  ) return t_shd_type
--parallel_enable -- ( partition p_cur by HASH ND )
  pipelined;

  --
  --
  --
  procedure SET_ADJ_SHD
  ( p_rpt_dt    in     date
  , p_adj_flag  in     pls_integer default 0
  );



end PRVN_FLOW;
/

show errors;

CREATE OR REPLACE PACKAGE BODY BARS.PRVN_FLOW
is
/*

 09.01.2019 Sta разове вирівнювання зал грош.дисконту по залученням
 27.12.2018 Sta Поменяль порядокобработки полей S(i) , S(i+1) по дисконтам
 22.12.2018 Sta +Vika Амортизация по БС=162%, 270%, 360% (COBUDWHIFRS-11)
 25.02.2019 KVA - COBUMMFO-10918  (SC-2428039 Cуттєва розбіжність між очікуваними виплатами по нарахованим відсоткам між графіками)
*/

  g_body_version  constant varchar2(64) := 'version 11.8  05.03.2019';

-- 25.09.2018(11.6) Sta Добавила во все эксепшены gl.aMfo

  individuals_shd signtype := 1; -- 1/0 - формувати графіки для ФО

  type many1 is record ( fdat date  ,
                         lim1 number,
                         ss   number,
                         lim2 number,
                         sp   number,
                         sn   number,
                         ir   number,
                         sn1  number,
                         sn2  number,
                         dat1 date  ,
                         dat2 date  ,
                         spn  number,
                         sno number
                       );
  type many is table of many1 index by varchar2(8);

  -- типы договоров по справочнику PRVN_OBJECT_TYPE
  g_CCK        constant varchar2(3) := 'CCK';
  g_BPK        constant varchar2(3) := 'BPK';
  g_CP         constant varchar2(2) := 'CP';
  g_MBK        constant varchar2(3) := 'MBK';
  g_DEB        constant varchar2(3) := 'DEB';
  g_OVR        constant varchar2(3) := 'OVR';
  g_XOZ        constant varchar2(3) := 'XOZ';
  g_BPK_INST   constant varchar2(3) := 'INS';--кредит на виплату по карткам(інстолмент)

  --
  -- Перевірка 100%-ї Готовністі НБУ-23
  --
  procedure err_23 (p_dat01 date)
  is
  begin
--  execute immediate 'truncate  table SREZERV_ERRORS';
    delete SREZERV_ERRORS;

    insert
      into srezerv_errors ( dat, error_type, error_txt, kv)
    select p_dat01, 1, 'Не виконан розрахунок забезпечення', max(row_id)
      from rez_log   where fdat=p_dat01 and kod = -14   having max(row_id) is null
     union all
    select p_dat01, 2, 'Не виконано Формування ЗАГАЛЬНОГО протоколу по 351 пост.', max(row_id)
      from rez_log   where fdat=p_dat01 and kod = -13 having max(row_id) is null ;

    commit;

    insert
      into srezerv_errors ( dat, error_type, nbs, kv, branch,  sz, error_txt )
    select p_dat01, 3, r.nbs||'/'||r.ob22, r.kv, substr(r.branch,1,15),          sum(r.rez23) sz,
           substr('S080='||r.kat||',Kл-'||decode(r.custtype,2, 'ЮО',3, 'ФО','Б')||'. Рах-'||ConcatStr(r.nls),1,255)
      from nbu23_rez r
     where fdat = p_dat01 and bv > 0 and rez<>0
       and not exists ( select 1 from srezerv_ob22 o
                         where r.nbs = o.nbs and r.ob22 = decode(o.ob22,'0',r.ob22,o.ob22)
                           and decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080)
                           and r.custtype = decode(o.custtype,'0',r.custtype,o.custtype)
                           and r.kv = decode(o.kv,'0',r.kv,o.kv) )
     group by r.nbs,r.ob22, r.kat,r.custtype, r.kv, substr(r.branch,1,15);

    commit;

  end err_23;
-----------------------------------------------------------

procedure SEND_MSG( p_txt varchar2 )
is
begin
  if getglobaloption('BMS')='1'
  then -- BMS Признак: 1-установлена рассылка сообщений
  -- bms.add_subscriber( gl.aUid);
     bms.enqueue_msg( p_txt, dbms_aq.no_delay, dbms_aq.never, gl.aUid );
  end if;
  bars_audit.info( 'OSA=>BMS:'||p_txt );
end SEND_MSG;

procedure LOC_DAT( p_bDAT date )
is
  -- d) Установити локальну Банк.Дату
begin
  -- GL.PL_DAT( p_bDAT );
  set_bankdate(p_bDAT);
  --PRVN_FLOW.SeND_MSG( p_txt => 'Установлено ЛОКальну Банк.Дату='||to_char(p_bDAT,'dd.mm.yyyy') );
end LOC_DAT;

-----------------------------------------------------------
procedure F02 ( p_dat31 date ) is     l_dat31  date ;  l_msg varchar(250) ;
 begin    If    p_dat31 is null then  l_dat31 := to_date( pul.Get_Mas_Ini_Val('zFdat1') ,'dd-mm-yyyy') ;
          else                        l_dat31 := p_dat31 ;
          end if;

     l_msg:= '7 ) #02 *Формування #02 '||l_dat31;
     --PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
     P_F02_NC ( l_dat31 ) ;
     --PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );

 end F02;

procedure DRAPS02( p_dat31 date  )  is      l_dat31 date;
 l_msg varchar2 (250);
 begin
     l_dat31 := NVL ( p_dat31, trunc( z23.DAT_END,'M' ) ) ;
     l_msg:= '*) SNP: Пере-Формування місячного знімоку '||l_dat31;
     --PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
     MDRAPS ( l_dat31 ) ;
     --PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );
 end DRAPS02 ;

procedure REC_23  ( p_dat01 date)  is
   l_res_kf  varchar2(13); sid_    varchar2(64) ;   sess_   varchar2(64) :=bars_login.get_session_clientid;
   l_dat31   date        ; l_msg   varchar2(250);
begin
   l_msg:= '3) CR-351: *Пере-Формування Кредитного ризику НБУ-351';
   --PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
   l_res_kf := trim('RESERVE'||sys_context('bars_context','user_mfo'));
   -- защита от двойного старта
   SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
   sid_:=SYS_CONTEXT('BARS_GLPARAM',l_res_kf);
   SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

   begin
      select sid into sid_ from v$session    where  sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
      raise_application_error(-20000,gl.aMfo||':Формування резерву вже виконується SID '|| sid_);
   exception  when no_data_found THEN NULL;
   end;

   l_dat31 := p_dat01-1 ;
   --PRVN_FLOW.SeND_MSG (p_txt => 'BEG DRAPS:'||l_dat31||l_msg );
   MDRAPS ( l_dat31 ) ;
   --PRVN_FLOW.SeND_MSG (p_txt => 'END DRAPS:'||l_dat31||l_msg );

   -------------------------
   -- установка флага
   gl.setp(l_res_kf,SYS_CONTEXT ('USERENV', 'SID'),NULL);

/*
   p_2401(p_dat01);            -- ->00.Розподіл фін.актівів на суттєві та несуттєві
   Z23.START_REZ(p_dat01,0);   -- ->01.Перенесення поточних ГПК в архiв
-------------------------
   OBS_23(p_dat01,0,0);        -- ->02.Розрахунок ОБС.БОРГУ по КП
   OBS_23(p_dat01,0,2);        -- ->03.Розрахунок ОБС.БОРГУ по МБК
   OBS_23(p_dat01,0,3);        -- ->04.Розрахунок ОБС.БОРГУ по БПK
   OBS_23(p_dat01,0,1);        -- ->04_0.Розрахунок ОБС.БОРГУ по ОВЕРДРАФТАМ
-------------------------
   Z23.ZALOG(p_dat01);         -- ->05.Розрахунок ЗАБЕЗПЕЧЕННЯ
*/
-------------------------------------------------------------------
   CR(p_dat01);                --      Розрахунок резерву
   -- снятие флага
   gl.setp(l_res_kf,'',NULL);
   COMMIT;

   --PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );

-------------------------------------------------------------------
end REC_23;
--------------------------
function QDK_12  (p_dk int, p_acc number, p_dat1 date, p_dat2 date, p_di number, p_nbs varchar2, p_ZO int ) return number is  --- получение dos, kos
  s_  number  :=0;
begin
  If p_dk = 0 then select Sum ( DOS+(CRDos-CuDos) ) into S_ From AGG_MONBALS where acc=p_ACC and fdat >= p_dat1 and fdat <= p_dat2;
  else             select Sum ( KOS+(CRKos-CuKos) ) into S_ From AGG_MONBALS where acc=p_ACC and fdat >= p_dat1 and fdat <= p_dat2;
  end if ;
  return NVL(s_,0) ;
end QDK_12;

--
-- получение ост (аналог OST_KORR)
--
function QST_12
( p_acc  accounts.acc%type
, p_dat  date
, p_nbs  accounts.nbs%type
, p_zo   int
) return accounts.ostc%type
is
  s_     accounts.ostc%type;
  l_zo   int;
begin

  begin

    case
      when ( p_dat > gl.bdate OR p_dat > sysdate )
      then -- тек. остаток

        select OSTC
          into s_
          from ACCOUNTS
         where ACC = p_acc;

      when ( to_char(p_dat,'DD') = '01' )
      then -- из мес. снимков

        l_zo := nvl( p_zo, 1 ); -- по умолчанию с корр

        if ( l_zo <> 1 )
        then
          l_zo := 0;
        end if;

        select OST + l_zo * (CRkos-CRdos)
          into s_
          from AGG_MONBALS
         where FDAT = add_months( p_dat, -1 )
           and ACC  = p_acc;

      else

        s_ := fost( p_acc, p_dat );

    end case;

  exception
    when NO_DATA_FOUND
    then s_ := 0;
  end;

  return s_ ;

end QST_12;

------------------
function GET_SUM
( p_nd    number
, p_kv    int
, p_tip   accounts.tip%type
, p_dat01 date
, p_ZO    int
) return number
is  -- получение суммы однотипных сч
  l_sum number;
  l_zo  int;
begin

  l_zo := nvl( p_zo ,1 );

  if p_tip = 'SDI'
  then
    select sum( - prvn_flow.qst_12( a.acc, p_dat01, a.nbs, l_zo ) )
      into l_sum
      from nd_acc n, accounts a
     where a.tip in ('SDI', 'SPI')
       and a.nbs like '2%'
       and a.kv = p_kv and a.acc = n.acc and n.nd = p_nd ;
  else
    select sum( - prvn_flow.qst_12(a .acc, p_dat01, a.nbs, l_zo ) )
      into l_sum
      from nd_acc n, accounts a
     where a.tip = p_tip and a.kv = p_kv and a.acc = n.acc and n.nd = p_nd ;
  end if ;

  RETURN nvl(l_sum,0);

end GET_SUM;
-----------------------

procedure bal0 ( p_mode int, p_nd number, p_tip accounts.tip%type, p_dat01 date, p_ZO int ) is -- балансировка - по дон. по типу счета
  l_dat01 date  ;
  l_ZO int := nvl(p_ZO,1);
  -------------
  procedure round0 (p_nd number, p_kv int, p_tip accounts.tip%type, p_dat01 date , p_sum number, p_ZO int ) is
    l_fdat date ;   l_del number ; L_id number;
  begin
    l_del := PRVN_FLOW.Get_sum (p_nd, p_kv, p_tip, p_dat01, p_ZO  ) ;
    l_del := l_del - p_sum ;

    If l_del = 0 then RETURN; end if;

    select max(ID)   into l_ID   from PRVN_FLOW_DETAILS  where MDAT = p_dat01 and ND = p_ND ;
    select max(fdat) into l_fdat from PRVN_FLOW_DETAILS  where MDAT = p_dat01 and ID = L_ID ;

    If    p_tip = 'SS ' then null;
    ElsIf p_tip = 'SN ' then          update PRVN_FLOW_DEALS_VAR set sn  = nvl(sn ,0) + l_del where id = L_id and zdat = p_dat01;
                                      update PRVN_FLOW_DETAILS   set sn  = nvl(sn ,0) + l_del where id = L_id and mdat = p_dat01 and fdat = l_fdat ;
    ElsIf p_tip in ('SPN','SLN') then update PRVN_FLOW_DEALS_VAR set spn = nvl(spn,0) + l_del where id = L_id and zdat = p_dat01;
                                      update PRVN_FLOW_DETAILS   set spn = nvl(spn,0) + l_del where id = L_id and mdat = p_dat01 and fdat = l_fdat ;
    ElsIf p_tip in ('SNO'      ) then update PRVN_FLOW_DEALS_VAR set sno = nvl(sno,0) + l_del where id = L_id and zdat = p_dat01;
                                      update PRVN_FLOW_DETAILS   set sno = nvl(sno,0) + l_del where id = L_id and mdat = p_dat01 and fdat = l_fdat ;
    ElsIf p_tip in ('SDI'      ) then update PRVN_FLOW_DEALS_VAR set sdi = nvl(sdi,0) + l_del where id = L_id and zdat = p_dat01;
    ElsIf p_tip in ('SP ','SL ') then update PRVN_FLOW_DEALS_VAR set sp  = nvl(sp ,0) + l_del where id = L_id and zdat = p_dat01;
                                      update PRVN_FLOW_DETAILS   set sp  = nvl(sp ,0) + l_del where id = L_id and mdat = p_dat01 and fdat = l_fdat ;
    end if ;
  end round0 ;

begin
  if p_dat01 is null then l_dat01 := to_date(pul.get_mas_ini_val('sFdat1'), 'dd.mm.yyyy') ;
  else                    l_dat01 := p_dat01 ;
  end if;
  for k in (select c.nd, c.kv, count(*) kol,
                   nvl(sum(v.sn)  , 0 ) sn ,
                   nvl(sum(v.SPN) , 0 ) spn,
                   nvl(sum(v.sno) , 0 ) sno,
                   nvl(sum(v.sdi) , 0 ) sdi,
                   nvl(sum(v.sp)  , 0 ) sp
            from  (select *          from PRVN_FLOW_DEALS_VAR   where zdat = p_dat01                                    ) v,
                  (select nd, kv, id from PRVN_FLOW_DEALS_CONST where tip = 'SS ' and nd = decode ( p_nd, 0, nd, p_nd ) ) c
            where c.id = v.id
            group by c.nd, c.kv
            having  count(*) > 1
           )
   loop
      round0 (k.nd, k.kv, 'SN ', l_dat01 , k.sn , l_ZO ) ;
      round0 (k.nd, k.kv, 'SPN', l_dat01 , k.spn, l_ZO ) ;
      round0 (k.nd, k.kv, 'SNO', l_dat01 , k.sno, l_ZO ) ;
      round0 (k.nd, k.kv, 'SDI', l_dat01 , k.sdi, l_ZO ) ;
      round0 (k.nd, k.kv, 'SP ', l_dat01 , k.sp , l_ZO ) ;
   end loop;
end bal0;

-------------------------------------------------
procedure p60 ( p_tipA IN int, p_ND IN number, p_acc_sna IN number, a6 OUT accounts%rowtype ) is
begin
   begin If  p_tipa in ( 3,10) and p_nd is not null then
             select b.* into a6 from accounts b, int_accn i, nd_acc n
             where n.nd = p_ND and n.acc = i.acc and i.acrb = b.acc and b.dazs is null and b.nbs like '60%'  and rownum = 1;

       elsIf p_tipa = 9 and p_nd is not null then
             select b.*  into a6
             from accounts b, int_accn i, (select * from cp_deal where ref = p_ND) d
             where i.acc in (d.acc, nvl(d.accd,d.acc), nvl(d.accp,d.acc)) and i.acrb= b.acc and b.dazs is null and b.nbs like '60%' and rownum=1;
       end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end ;

   If a6.acc is null and p_acc_SNA is not null then
      begin select b.* into a6
            from  accounts b, opldok o2, (select o.ref from opldok o, saldoa s where s.acc= p_acc_SNA and s.fdat=o.fdat and o.acc=s.acc) o1
            where o2.ref=o1.ref and o2.acc=b.acc and b.dazs is null and b.nbs like '60%'and rownum = 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN null;
      end ;
   end if ;
   RETURN;
end p60;

procedure u_SNA  ( p_dat   date ) is -- урегулирование НЕВИЗНАНИХ. Уменьшение SNA := LEAST ( SNA, -(SN+SPN) ) Ежедневно в АБС
  oo  oper%rowtype;  a6  accounts%rowtype;
------------------
begin
  oo.tt := 'IRR'; oo.vob  := 6;  oo.vdat := gl.bdate;  oo.dk   := 1 ;
  oo.nazn := 'Визнання процентних доходів в зв`язку з погашенням заборгованості по відсоткам' ;
  for k in (select sna.acc, sna.nls, sna.nms, sna.kv, x.nd, x.delB
            from accounts sna,
               ( select n.nd, a.kv, sum (a.ostC ) delC,  sum (a.ostB ) delB,
                        min ( decode (a.tip, 'SNA', a.acc , null) )    acc ,
                        sum ( decode (a.tip, 'SNA', a.OSTB, 0   ) )    ostB
                 from accounts a, nd_acc n
                 where n.acc = a.acc and a.ostB <> 0  and (a.nbs like '1%' or  a.nbs like '2%')
                 group by n.nd, a.kv
                 having sum(a.ostC) = sum (a.ostB) and sum (a.ostB)>0 and sum (a.ostB) <= sum ( decode (a.tip, 'SNA', a.OSTB, 0 ) )
                ) x
            where sna.acc = x.acc and sna.ostb = x.ostb
           )
  loop
     PRVN_FLOW.p60 ( null, null, k.acc, a6 ) ;
     oo.nlsb := a6.nls; oo.nam_b := substr(a6.nms,1,38);
     oo.nlsa :=  k.nls; oo.nam_a := substr(k.nms,1,38) ;
     oo.s    := k.Delb; oo.kv    := k.kv; oo.kv2 := gl.baseval;
     oo.ref  := null  ;
     oo.nd   := substr(to_char (k.nd), 1, 10 ) ;
     If oo.kv <> gl.baseval then  oo.s2 := gl.p_icurval ( oo.kv, oo.s, gl.bdate);
     else                         oo.s2 := oo.s ;
     end if;
     PRVN_FLOW.opl (oo) ;
     gl.pay( 2, oo.ref, gl.bdate );
  end loop;

end u_SNA;

procedure D_XXX   ( p_dat01 date, p_ND number ) IS -- Обработка витрины по 1 дог
begin pul.PUT( 'D_XXX', to_char (p_ND)  ); 
      PRVN_FLOW.D_SNA ( p_Dat01);
end D_XXX;

procedure D_SNA  ( p_dat01 date ) is -- SDM + SDF + SDI  + SDA  + SNA + SRR от Делойта
-- 27.12.2018 
      x_ND number ;
      x_RI varchar2 (100);
      X1 TEST_PRVN_OSA%ROWtype ;
      p4_ int;
      OO OPER%ROWTYPE ;
      ----------------------------

procedure D_SNA1 ( x_RI varchar2, XX In OUT TEST_PRVN_OSA%ROWtype, OO in out OPER%ROWtype)  iS
  aa accounts%rowtype   ;
  a6 accounts%rowtype   ;
  l_acc number ;
  SR_   number ;
  Del_  Number ;
  l_comm varchar2(100)  ;
  dd  cc_deal%rowtype   ;
  kk  cck_ob22%rowtype  ;
  kk9 cck_ob22_9%rowtype;
  p4_ int ;
  l_PAP int ;
  --------------------
  procedure ACC2   is
    p4_ int;  b3_ char(3); b4_ char(1);    SPC specparam%rowtype;
  begin ------------------------  Определение/Открытие  счета SDF + SDM + SDI + SDA .... + SRR + SNA
    begin  select a.* into aa from accounts a, nd_acc n   where n.nd = dd.nd and n.acc= a.acc and a.tip = aa.tip  and a.dazs is null and a.kv = xx.kv ; --- and rownum = 1 ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
         aa.ACC := NULL ;
    ---- SAVEPOINT do_op;
         BEGIN b3_ := substr(dd.prod,1,3) ;                                      aa.ob22 := null ;
               If    AA.TIP = 'SNA' THEN b4_:= '9' ;  aa.nms := 'НЕвизн.дох.'  ; aa.Ob22 := Substr (kk.SNA ,5,2) ;
               ELSiF AA.TIP = 'SRR' THEN b4_:= '7' ;  aa.nms := 'Переоцінка.'  ; a6.ob22 := Substr (kk9.SRR,5,2) ; --COMMENT ON COLUMN BARS.CCK_OB22_9.SRR IS 'БС+Об22~Переоц.~XLS';
               ELSiF AA.TIP = 'SDF' THEN b4_:= '6' ;  aa.nms := 'Д/П кориг.BV.'; aa.ob22 := kk.SDI ;               -- Все дисконты с одним и тем же об22 как и SDI
               ELSiF AA.TIP = 'SDM' THEN b4_:= '6' ;  aa.nms := 'Д/П модифік.' ; aa.ob22 := kk.SDI ;
               ELSiF AA.TIP = 'SDI' THEN b4_:= '6' ;  aa.nms := 'Д/П початков.'; aa.ob22 := kk.SDI ;
               ELSiF AA.TIP = 'SDA' THEN b4_:= '6' ;  aa.nms := 'Д/П технічний'; aa.ob22 := kk.SDI ;
               else RETURN ;
               end if;
               aa.NBS := B3_ || b4_ ;
               aa.nls := Get_NLS( xx.KV, aa.NBS );
               aa.nms := Substr ( aa.nms||'Угода='|| dd.cc_id || ' від '|| to_char(dd.sdate, 'dd.mm.yyyy'), 1,50);

               op_reg (1, XX.nd, 0, 0, p4_, dd.Rnk, aa.nls, xx.kv, aa.nms, aa.tip, gl.auid, aa.acc);

               update accounts set DAOS = oo.VDAT , pap = 3, tobo = dd.branch,  mdate = dd.wdate where acc = aa.acc;

               If aa.ob22 is not null then Accreg.setAccountSParam(aa.Acc, 'OB22', aa.ob22 ); end if;
               select * into aa from accounts where acc= aa.acc;
               --спецпарам ------------------------------------------------------
               If AA.tip in ( 'SDM' , 'SDA' ,  'SDF') then           -- Все дисконты с одним и тем же об22 как и SDI
                  begin select s.*  into spc   from specparam s, accounts a, nd_acc n
                        where n.nd = XX.nd and n.acc = a.acc and a.tip ='SDI' and a.acc=s.acc and rownum = 1 ;
                        Delete from accountsW where acc = aa.acc ;  insert into accountsw (acc,tag,value) select aa.acc,tag,value from accountsw where acc = spc.acc ;
                        Delete from specparam where acc = aa.acc ;  spc.acc := aa.acc ;    insert into specparam values spc;
                  EXCEPTION WHEN NO_DATA_FOUND THEN null ;
                  end;

              ElsIf AA.tip = 'SNA' then
/* 12.03.2018
Вс 11.03.2018 15:06 Вікторія Семенова <viktoriia.semenova@unity-bars.com>
Пока предварительный (еще банк не подтвердил)  вариант такой :
2) при открытии новых счетов SNA -  параметры S080, S180, S190, S240, S260, mDate, R011 - наследуем с 'SS ', 'SN ', 'SP ', 'SPN' (с одного из).
Параметр R013 - присваиваем значение "3"  для всех счетов - БС= 2209, 2239, 2069, 2089, 2079
*/
                 for s9 in (select s.*
                           from specparam s, accounts a, nd_acc n
                           where s.acc= a.acc and a.acc = n.acc and n.nd = XX.ND and a.kv = aa.kv  and a.dazs is null and a.tip in ('SS ', 'SN ', 'SP ', 'SPN')
                           order by a.ostc desc
                             )
                 loop
                    Accreg.setAccountSParam(aa.Acc, 'S080', s9.S080 );
                    Accreg.setAccountSParam(aa.Acc, 'S180', s9.S180 );
                    Accreg.setAccountSParam(aa.Acc, 'S190', s9.S190 );
                    Accreg.setAccountSParam(aa.Acc, 'S240', s9.S240 );
                    Accreg.setAccountSParam(aa.Acc, 'S260', s9.S260 );
                    Accreg.setAccountSParam(aa.Acc, 'R011', s9.R011 );
                    Accreg.setAccountSParam(aa.Acc, 'R013', '3'     );
                    EXIT ;
                end loop;


  end if ;

      -- EXCEPTION WHEN OTHERS THEN
      --       ROLLBACK TO do_op;
      --       erm_ := null;
      --       deb.trap(SQLERRM, code_, erm_, status_);
      --       p_Err := 'Рах.'||aa.tip||'*'||Substr (erm_, 1,90) ;
      --       goto RET_ ;
         end ;
    END  ;  --    SAVEPOINT do_op;
    -----------------------------------
    If aa.ACC is  NULL  then aa.nls := null ;  end if;
    RETURN ;
  end ;    -- ACC2
  -----------------------------------
  procedure ACC6  (p_mode int) is   -- 6,9,7,-1, +1, -3, +3
  begin  a6.nls := null ; a6.acc := null ;
     If  p_Mode in (6,9) then -- ПРОЦЕНТНЫЕ ДОХ 60*  - Для невызнаныз + Амортизация всех дисконтов + Возникновение SDA
         begin select nbs6 into a6.nbs from NBS_SS_SD where NBS2 = substr(dd.prod,1,4);
         EXCEPTION WHEN NO_DATA_FOUND  Then raise_application_error(-20000,gl.aMfo||':НЕ знайдено в NBS_SS_SD '||substr(dd.prod,1,4) );
         end ;

         If    aa.tip ='SNA'  and aa.kv  = gl.baseval then a6.ob22 :=  kk.SD_N ;
         ElsIf aa.tip ='SNA'                          then a6.ob22 :=  kk.SD_I ;
         ElsIf aa.kv  = gl.baseval                    then a6.ob22 :=  kk.SD_M ;
         else                                              a6.ob22 :=  kk.SD_J ;
         end if ;                                          a6.ob22 := NVL( a6.ob22, kk.SD_N );

     Elsif p_Mode =  7 then -- Для переоценки
           a6.nbs  := NVL( Substr (kk9.R6R,1,4), '6224') ;   a6.ob22 := NvL( Substr (kk9.R6R,5,2), '02'   ) ; -- IS 'БС+Об22~6 кл.Переоц.~XLS' ??? R7R IS 'БС+Об22~7 кл.Переоц.~XLS';

     Elsif p_Mode =  -1 then -- Для -S1
           If aa.kv = gl.baseVal then a6.nbs := Substr (kk9.S1NM,1,4);  a6.ob22 := Substr (kk9.S1NM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S1 грн~до спрв~FV_ADJ';
           Else                       a6.nbs := Substr (kk9.S1VM,1,4);  a6.ob22 := Substr (kk9.S1VM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S1 вал~до спрв~FV_ADJ';
           end if;

     Elsif p_Mode =  +1 then -- Для +S1
           If aa.kv = gl.baseVal then a6.nbs := Substr (kk9.S1NP,1,4);  a6.ob22 := Substr (kk9.S1NP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S1 грн~до спрв~FV_ADJ';
           Else                       a6.nbs := Substr (kk9.S1VP,1,4);  a6.ob22 := Substr (kk9.S1VP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S1 вал~до спрв~FV_ADJ';
           end if;

     Elsif p_Mode =  -3 then -- Для -S3
           If aa.kv = gl.baseVal then a6.nbs := Substr (kk9.S3NM,1,4);  a6.ob22 := Substr (kk9.S3NM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S3 грн~від модф~MODIF
           Else                       a6.nbs := Substr (kk9.S3VM,1,4);  a6.ob22 := Substr (kk9.S3VM,5,2); -- IS 'БС+Об22~NEW_FEE~мінус S3 вал~від модф~MODIF'
           end if;
     Elsif p_Mode =  +3 then -- Для +S3
           If aa.kv = gl.baseVal then a6.nbs := Substr (kk9.S3NP,1,4);  a6.ob22 := Substr (kk9.S3NP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S3 грн~від модф~MODIF'
           Else                       a6.nbs := Substr (kk9.S3VP,1,4);  a6.ob22 := Substr (kk9.S3VP,5,2); -- IS 'БС+Об22~NEW_FEE~плюс S3 вал~від модф~MODIF'
           end if;
     end if;
     ----------------
     a6.nls := null ;
     ----------------
     If a6.nbs is NOT null and a6.ob22 is NOT null then
        begin select * into a6 from
             (select * from accounts where  nbs= a6.nbs and ob22 = a6.ob22 and dazs is null  order by decode (BRANCH, Substr(dd.BRANCH,1,15) ,1,2 ) )
             where rownum = 1 ;

        EXCEPTION WHEN NO_DATA_FOUND  Then
           OP_BS_OB1( PP_BRANCH => substr( dd.branch,1,15), P_BBBOO => a6.nbs||a6.ob22) ;
           a6.nls := nbs_ob22_null (nbs_  => a6.nbs,  ob22_ => a6.ob22,  p_branch => substr( dd.branch,1,15) ) ;
           If a6.nls is not null then select * into a6 from accounts  where kv = gl.baseval and nls = a6.nls   ; end if;
        end ;
        If a6.daos > oo.VDAT then update accounts set daos = oo.VDAT  where acc = a6.acc;  a6.daos := oo.VDAT  ; end if;
     end if;

     If a6.nls is null then
        raise_application_error(-20000, gl.aMfo||':ND='||dd.ND||',prod='||dd.prod||',vidd='||dd.VIDD||',tip='||aa.TIP||',p_mode='||p_mode ||', a6.nbs='||a6.nbs||',a6.ob22='|| a6.ob22||'*');
     end if ;

  end  ;  --- ACC6
  -------------------------------------------------------------------------------------------------

procedure PROVODKA (x_RI varchar2, XX in out TEST_PRVN_OSA%ROWtype, OO in out OPER%ROWtype) is
  l_comm varchar2(250);
  begin  oo.ref := null ;
    iF OO.S <> 0 and l_comm is null then
       oo.kv   := xx.kv;
       If oo.S < 0 then oo.dk := 1 - oo.DK ; oo.S := - oo.S ; end if;
       If xx.kv <> gl.BaseVal then oo.s2   := gl.p_icurval( xx.kv, oo.s, OO.VDAT ); else oo.s2 := oo.s; end if;
       If xx.tip <> 9 then oo.nlsa := aa.nls;  oo.nam_a := Substr(aa.nms,1,38) ; end if;
       oo.nlsB := a6.nls ; oo.nam_a :=  Substr(a6.nms,1,38)  ; -- рабочее значение

--     SAVEPOINT do_XXX;
       declare	code_ INTEGER ;  Erm_ VARCHAR2 (1000);  status_	VARCHAR2 (1000) ;
       BEGIN
          If ABS(oo.s) < 1 then RETURN ; end if ;
          gl.ref (oo.REF);
          gl.in_doc3 (ref_ => oo.REF  , tt_  => oo.tt  , vob_ => oo.vob ,   nd_ =>oo.nd   , pdat_=>SYSDATE, vdat_ =>oo.vdat, dk_ =>oo.dk,
                       kv_ => oo.kv   , s_   => oo.S   , kv2_ => oo.kv2 ,   s2_ =>oo.S2   , sk_  => null  , data_ =>oo.DATD,datp_=>gl.bdate,
                    nam_a_ => oo.nam_a,nlsa_ => oo.nlsa,mfoa_ => gl.aMfo, nam_b_=>oo.nam_b,nlsb_ =>oo.nlsb, mfob_ =>gl.aMfo ,
                     nazn_ => oo.nazn ,d_rec_=> null   ,id_a_ => null   , id_b_ =>null    ,id_o_ =>null   , sign_ =>null,sos_=>1,prty_=>null,uid_=>null);
          gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa , oo.s, oo.kv2    ,oo.nlsb, oo.s2);
          gl.pay (2, oo.ref, gl.bdate);  -- по факту
       EXCEPTION WHEN OTHERS THEN  ----ROLLBACK TO do_XXX;
          erm_ := null;  deb.trap(SQLERRM, code_, erm_, status_);
          l_comm  := substr('*'||oo.NLSA||'*'||oo.NLSB||'*'||aa.tip||'*'||xx.ND||Substr (erm_, 1,100),1,250) ;
          raise_application_error(-20000, gl.aMfo||':'||l_comm  );
       END;
       If l_Comm is not null then  update TEST_PRVN_OSA  set comm = l_comm            where rowid = x_RI ; RETURN ; end if ;
       If oo.ref is not null then  update TEST_PRVN_OSA  set comm = comm||aa.tip||',' where rowid = x_RI ;          end if ;
    end if ;  -- OO.S <> 0 ....

  end ;  --- procedure PROVODKA  ---------------------------------------------
  ---------------------------------------------

  Procedure Get_SA (p_ost IN     number   ,  -- фактический остаток, какой есть в АБС,  на входе 
                    p_B   IN     number   ,  -- плановый остаток, каким он должен быть, на выходе ( по версии FV)
                    p_SV  IN     number   ,  -- Без/оговорочная сумма возникновения 
                    P_SA  IN OUT number   )  -- Сумма амортизации входящая , которая подлежит пересчету 
                 IS l_SA         number   ;  -- Сумма амортизации исходящая, уже пересчитанная

  begin 
      l_SA := p_OST  - p_B + p_SV ;
      If p_SA <> l_SA then 
         insert into PRVN_DEL_SD ( KF, ND, Tip, OST, B, SV, SA, XA ) values ( gl.aMfo, xx.ND, aa.tip, p_ost, p_B, p_SV, p_SA, l_SA ) ;           
         p_SA := l_SA ;
      end if ; 
  end ;  --Procedure Get_SA

  ---------------------------------------------
begin
  update TEST_PRVN_OSA  set comm = null  where rowid = x_RI;

  If xx.tip = 9  then
     declare L_ACC number    ;
        cpD  cp_deal%rowtype ;
        cpA  cp_accc%rowtype ;
        sn1  accounts%rowtype;
        sn2  accounts%rowtype;
     begin
        If ( xx.AIRC_CCY <> 0 or xx.IRC_CCY <> 0 ) then
           select * into cpD from cp_deal where ref = xx.nd;
           If cpD.ACCUNREC is null then ------------------------------ Неприз дох по ЦБ
              select * into sn1  from accounts where acc  = cpD.acc  ; -- доч.счет тела
              select * into sn1  from accounts where acc  = sn1.accc ; -- род.счет тела
              select * into cpa  from cp_accc  where nlsA = sn1.nls  and UNREC is not null and rownum = 1; -- в описателе счетов
              select * into sn1  from accounts where nls  = cpA.UNREC and kv = xx.kv ;  -- родит счет невизнаных
              SN2.nls := vkrzn( substr(gl.aMfo,1,5),  substr(sn1.nls,1,4)||'09'|| substr( '000000000'||xx.nd, -8)  ); -- доч.счет невизн
              SN2.nms := 'НЕвизн.дох. Угода='|| xx.TIP ||'/'||xx.nd ;
              OP_REG_EX (99,0,0,sn1.GRP,p4_, sn1.RNK , sn2.nls, xx.kv, sn2.NMS,'ODB', gl.aUid, sn2.acc, NULL);
              insert into cp_accounts ( CP_REF ,  CP_ACCTYPE ,  CP_ACC ) values ( cpD.ref, 'UNREC', sn2.acc );
              update cp_deal  set ACCUNREC= sn2.acc  where ref = xx.nd;
              update accounts set pap = 2, tobo = sn1.branch, daos = oo.vdat, accc = sn1.acc  where acc = SN2.acc;
           else sn2.acc := cpD.ACCUNREC ;
           end if;

           select * into sn2 from accounts where acc = sn2.acc;
           sn2.OSTC := OSTM ( p_acc => sn2.acc,   p_dat => oo.vdat );

           oo.s := round ( xx.AIRC_CCY *100 - sn2.OSTC ,0) ;
           if ABS(oo.s) >= 1 then
              oo.kv := xx.kv ;      prvn_flow.p60 ( xx.tip, xx.ND, sn2.acc, a6 ) ;
              oo.nlsB := a6.nls  ; oo.nam_a :=  Substr(a6.nms,1,38)  ; -- рабочее значение
              If a6.acc is null then    update TEST_PRVN_OSA  set  comm = 'NOT 60**' where rowid = x_RI ;            RETURN ;     end if;
           end if;
           oo.KV := sn2.KV ; oo.nlsa := sn2.nls ; oo.nam_a :=  substr(sn2.nms, 1,38);
           If oo.s > 0 then oo.dk := 0 ;
           else             oo.dk := 1 ;  oo.s := - oo.s ;
           end if ;
           PROVODKA (x_RI, XX, OO) ;
        end if;
     EXCEPTION WHEN NO_DATA_FOUND THEN    update TEST_PRVN_OSA  set  comm = 'NOT in ACC.CP_deal' where rowid = x_RI ;        return;
     end;
     RETURN;  --Ценные бумаги только SNA
  end if ;
  -------------------------------------------------------------------
  begin select d.* into dd from cc_deal  d where  d.nd = xx.nd ;
  EXCEPTION WHEN NO_DATA_FOUND THEN update TEST_PRVN_OSA  set comm ='Угоду НЕ знайдено' where rowid = x_RI ; RETURN ;
  end ;

  If dd.prod  like '9%' then  update TEST_PRVN_OSA   set    comm = 'Внеб.дог.'|| dd.prod|| ' НЕ обрабатываем' where rowid = x_RI ;  RETURN ;      end if;

  dd.prod := substr(dd.prod,1,6) ;
  l_PAP   := 1;
  -- Искривленный код продукта
  If dd.vidd =  150 and dd.prod like '1508%'   THEN

     dd.prod := '150000' ;
     kk.NBS  := '1500' ;
     kk.ob22 := '00'   ;

  ElsIf dd.vidd     in (2701,1623,3660, 150 )  THEN
     begin select a.pap, a.nbs||a.ob22, a.NBS,  a.ob22 
             into l_PAP, dd.prod,      kk.NBS, kk.ob22  
             from accounts a, nd_acc n
            where n.nd = dd.nd and n.acc = a.acc and dazs is null   and a.NBS in ( to_char(dd.VIDD), '1500', '1502' )  ;
     EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error(-20000,gl.aMfo||':НЕ знайдено осн.рах по дог.'|| dd.ND ||', vidd='|| dd.vidd );
     end ;
  end if ;

  -- "Честные" кредиты
  begin select k.* into kk from cck_ob22 k where  nbs||ob22  = dd.prod;
        If kk.d_close is not null then
           select r020_new||ob_new into dd.prod from TRANSFER_2017 where r020_old||ob_old =  dd.prod ;
           --update cc_deal set prod  = dd.prod where nd = dd.nd ;
           select k.* into kk from cck_ob22 k where  nbs||ob22  = dd.prod;
        end if ;
  EXCEPTION WHEN NO_DATA_FOUND THEN  -- по группе КРГ* - первый попавший открытый продукт
        begin select k.* into kk from cck_ob22 k where  substr(nbs,1,3) = substr(dd.prod,1,3) and rownum = 1 and  kk.d_close is null ;
              dd.prod := kk.NBS||kk.OB22 ;
        EXCEPTION WHEN NO_DATA_FOUND THEN    raise_application_error(-20000,gl.aMfo||':ND='||xx.ND||'*НЕ знайдено cck_ob22.PROD='|| dd.prod );
        end ;
  end;

  begin  select k.* into kk9 from cck_ob22_9 k where nbs||ob22 = dd.prod ;
  EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20000,gl.aMfo||':1) НЕ знайдено cck_ob22_9.PROD='|| dd.prod );
  end ;

  ----------------------

  If xx.Irr is not null  then
     begin              --(2701,1624,3660)
        If dd.vidd not in (1,2,3,11,12,13) then select a.acc into L_ACC from accounts a, nd_acc n  where n.ND = DD.ND and n.acc = a.acc and a.nbs = kk.nbs  ;
        Else                                    select a.acc into L_ACC from accounts a, nd_acc n  where n.ND = DD.ND and n.acc = a.acc and a.tip = decode ( Substr(dd.prod,1,1) , '2', 'LIM', 'SS ') ;
        end if ;
     EXCEPTION WHEN NO_DATA_FOUND THEN update TEST_PRVN_OSA  set comm ='Рах.для збереж ЕПС НЕ знайдено' where rowid = x_RI ; RETURN ;
     end ;

     xx.Irr := xx.Irr * 100 ;
     Update int_accn set acr_dat = gl.bdate where acc = l_ACC and id = - 2;
     IF SQL%ROWCOUNT=0 THEN   insert into int_accn(acc,id,acr_dat, METR, BASEM ,BASEY,FREQ ) values ( L_ACC, -2, gl.bdate,0,0,0,5);         end if;
     Update int_ratn set ir= xx.Irr where acc=L_ACC and id= -2 and bdat=gl.Bdate;
     IF SQL%ROWCOUNT=0 THEN insert into int_ratn(acc,id,ir,bdat) values (L_ACC,-2,xx.irr, gl.bdate ); end if ;
  end if;

   -- Округлените и приведение к колпейкам -= целому числу
   xx.b1 := round ( NVL( xx.b1,0),2 ) ;  xx.s1 := round ( NVL( xx.s1,0),2 ) ;  xx.s2 :=  round (  NVL( xx.s2,0),2 );
   xx.b3 := round ( NVL( xx.b3,0),2 ) ;  xx.s3 := round ( NVL( xx.s3,0),2 ) ;  xx.s4 :=  round (  NVL( xx.s4,0),2 );
   xx.b5 := round ( NVL( xx.b5,0),2 ) ;  xx.s5 := round ( NVL( xx.s5,0),2 ) ;  xx.s6 :=  round (  NVL( xx.s6,0),2 );
   xx.b7 := round ( NVL( xx.b7,0),2 ) ;  xx.s7 := round ( NVL( xx.s7,0),2 ) ;  xx.s8 :=  round (  NVL( xx.s8,0),2 );
   XX.AIRC_CCY := round ( NVL( XX.AIRC_CCY, 0 ) ,2) ;
   XX.FV_CCY   := round ( NVL( XX.FV_CCY  , 0 ) ,2) ;

   -- 22.12.2018 Амортизация по БС=162%, 270%, 360% (COBUDWHIFRS-11)
   If l_PAP = 2 then  xx.b1 := - xx.b1 ;
                      xx.b3 := - xx.b3 ;
                      xx.b5 := - xx.b5 ;
                      xx.b7 := - xx.b7 ;
   end if ;
   ----------------------------------------------------------

   For t in ( select * from tips where tip in ( 'SDI', 'SDF', 'SDM', 'SDA', 'SNA', 'SRR' )  order by decode ( tip , 'SDF', 1,  'SDM',2,  'SDI',3,  'SDA', 4, 'SNA', 5 , 'SRR',6, 7 )  )
   loop aa.tip  := t.tip ;
       ------------------ A Есть ли такой счет ?
       begin select a.* into aa from accounts a, nd_acc n where n.nd = xx.nd and n.acc = a.acc and a.tip = aa.tip and a.kv = xx.kv and a.dazs is null ;
             If aa.daos > oo.vdat then update accounts set daos = oo.vdat where acc = aa.acc ;   aa.daos := oo.vdat ; end if ;
             aa.OSTC := OSTM ( p_acc =>  aa.acc,   p_dat => oo.vdat ) ;
       exception when no_data_found then aa.OSTC := 0; aa.ACC := null ; aa.tip := t.tip ; -- счета еще нет
       end;

-------B1=SDF = Неамортиз.Д/П~за кориг.BV.~до справедливої~B1

       If aa.tip = 'SDF' then
          If xx.B1 = aa.ostc/100  then  goto EXIT_ ;  end if ;
          Get_SA ( p_ost => aa.ostc/100,  p_B => xx.b1, p_SV => xx.s1, P_SA =>xx.s2 );

          If xx.s1 <> 0 OR xx.S2 <> 0  then 
             ACC2 ; -- Найти/Открыть счет SDF
             If xx.s1 <> 0 then 
                ACC6(SIGN(xx.s1)); 
                oo.nazn := 'Виникнення '||aa.tip ||'. Дог.'||xx.ND; 
                oo.dk   := 0; 
                oo.s    := xx.s1*100; 
                PROVODKA(x_RI,XX,OO); 
             end if;
             If xx.s2 <> 0 then 
                ACC6(6) ;
                oo.nazn :='Амортизація '||aa.tip ||'. Дог.'|| xx.ND ;   
                oo.dk   := 1 ; 
                oo.s    := xx.s2*100; 
                PROVODKA(x_RI,XX,OO); 
             end if;                        
          Else  update TEST_PRVN_OSA   set   comm = comm||aa.tip||'-' where rowid = x_RI ;    -- Расчетное S1=0  и S2=0 => comm not null
          end if;

-------B3=SDM Неамортиз.Д/П~за модиф.договору           ~B3
       ElsIf aa.tip = 'SDM' then 
          If xx.B3 = aa.ostc/100  then  goto EXIT_ ;  end if ;

          Get_SA ( p_ost => aa.ostc/100,  p_B => xx.b3, p_SV => xx.s3, P_SA =>xx.s4 );

          If xx.s3 <> 0 OR xx.S4 <> 0  then 
             ACC2 ; -- Найти/Открыть счет SDM
             If xx.s3 <> 0 then 
                ACC6(3*Sign(xx.S3)); 
                oo.nazn:= 'Виникнення '||aa.tip ||'. Дог.'||xx.ND; 
                oo.dk  := 0; 
                oo.s   := xx.s3*100; 
                PROVODKA(x_RI,XX,OO); 
             end if;
             If xx.s4 <> 0  then 
                ACC6(6) ;  
                oo.nazn :='Амортизація '||aa.tip ||'. Дог.'|| xx.ND ;  
                oo.dk   := 1; 
                oo.s    := xx.s4*100; 
                PROVODKA(x_RI,XX,OO); 
             end if;
          else  update TEST_PRVN_OSA   set   comm =  comm||aa.tip||'-' where rowid = x_RI ;    -- Расчетное S3=0  и S4=0 => comm not null
          end if;

-------B5 = SDI = Неамортиз.Д/П~"грошовий"                  ~B5
       ElsIf aa.tip = 'SDI' then 
          If xx.B5 = aa.ostc/100  then  goto EXIT_ ;  end if ; -- если ост равны
          If aa.ACC is null       then  goto EXIT_ ;  end if ;     -- если нет счета, то ничего не делаем 

          oo.nazn := 'Амортизація '||aa.tip ||'. Дог.'|| xx.ND ;    

          If l_Pap = 2 and oo.vdat < to_date ('01/01/2019', 'dd/mm/yyyy' )  then
             oo.nazn := 'Разове вирівнювання залишку (запозичення) '||aa.tip ||'. Дог.'|| xx.ND ;    
             Get_SA ( p_ost => aa.ostc/100,  p_B => xx.b5, p_SV => xx.s5, P_SA =>xx.s6 );
   
       elsIf aa.OSTC < xx.b5*100 and xx.b5 > 0  OR   aa.OSTC > xx.b5*100 and xx.b5 <0  then   -- если остаток уже меньше B5 , то ничего не делаем 
               goto EXIT_ ; 
          end if ;

          ACC6(6) ;    
          oo.dk   := 1 ;        
          oo.s    := aa.OSTC - xx.b5*100 ;
          PROVODKA (x_RI, XX, OO) ; 

-------B7= SDA =  -- Неамортиз.Д/П~"технічний"                 ~B7
       ElsIf aa.tip = 'SDA' then 
          If xx.B7 = aa.ostc/100  then  goto EXIT_ ;  end if ;

          Get_SA ( p_ost => aa.ostc/100,  p_B => xx.b7, p_SV => xx.s7, P_SA =>xx.s8 );

          If xx.s7 <> 0 OR xx.S8 <> 0  then  
             ACC2 ;      -- Найти/Открыть счет SDA 
             ACC6(6) ;   -- Подобрать счет для Амортизации 
             If xx.s7 <> 0  then 
                oo.nazn := 'Виникнення '||aa.tip ||'. Дог.'|| xx.ND ; 
                oo.dk   := 0 ; 
                oo.s    := xx.s7 *100 ; 
                PROVODKA (x_RI, XX, OO) ;  
             end if;
             If xx.s8 <> 0  then 
                oo.nazn :='Амортизація '||aa.tip ||'. Дог.'|| xx.ND ;  
                oo.dk   := 1 ; 
                oo.s    := xx.s8 *100 ; 
                PROVODKA (x_RI, XX, OO) ;  
             end if;
          else  update TEST_PRVN_OSA   set   comm = comm||aa.tip||'-' where rowid = x_RI ;    -- Расчетное S7=0  и S8=0 => comm not null
          end if;

-------AIRC_CCY~Итого~НЕприз.дох
       ElsIf aa.tip = 'SNA' and aa.ostc <> XX.AIRC_CCY *100  then  -- найти/Открыть счет SNA -- найти/Открыть счет 60**
          ACC2 ; ACC6(9) ;  oo.nazn := 'Корегування Невизн.проц.дох.'||aa.tip ||'. Дог.'|| xx.ND ;  oo.DK := 0 ;  oo.S := XX.AIRC_CCY *100 - aa.OSTC ;  PROVODKA (x_RI, XX, OO) ;

-------XX.FV_CCYПереоценка, остаток
       ElsIf aa.tip = 'SRR' and aa.ostc <> XX.FV_CCY * 100   Then -- найти/Открыть счет SRR
          ACC2 ; ACC6(7) ;  oo.nazn := 'Переоцінка '||aa.tip ||'. Дог.'|| xx.ND ;                   oo.DK := 0 ;  oo.S := XX.FV_CCY  *100  - aa.OSTC ;  PROVODKA (x_RI, XX, OO) ;
-------------------------------------------------------
       end if;
     <<EXIT_>> null ;
   END LOOP ; -- T
end ;
-----------------------------
begin 
      dbms_application_info.set_client_info(':'|| gl.aMfo ||':2) IRR: Формування проводок  по SD*, SNA, SRR');
      z23.to_log_rez (user_id , 4 , p_dat01 ,'2) IRR: Формування проводок  по SD*, SNA, SRR');
      oo.ND   := 'FV9' ;
      oo.vdat := DAT_NEXT_U(p_dat01, -1);
      oo.tt   := 'IRR'     ;
      oo.DATD := gl.Bdate  ;
      oo.kv2  := gl.baseval;
      oo.mfoa := gl.aMfo   ;
      oo.mfob := gl.aMfo   ;
      oo.vob  := 96 ;
      Delete from PRVN_DEL_SD where kf = gl.Amfo ; 

      x_ND    := to_number ( Pul.GET ('D_XXX')) ;
      pul.PUT ('D_XXX', null);
      If x_ND > 0 then

         begin  select RowId into x_RI from TEST_PRVN_OSA where comm is null and tip in (3,9) and nd = x_ND; 
                select *     into   X1 from TEST_PRVN_OSA where RowId = x_RI ;
                D_SNA1 ( x_RI, X1, OO ) ; 
         EXCEPTION WHEN NO_DATA_FOUND THEN   raise_application_error(-20000,'НЕ знайдено: select * from PRVN_OSAQ where comm is null and tip in (3,9) and nd='|| x_ND );       
         end ;

      Else
         For x in (select RowId RI  from TEST_PRVN_OSA where comm is null and tip in (3,9) ) ---- and nd = 167115501 )
         loop      select * into X1 from TEST_PRVN_OSA where  RowId = x.RI;  D_SNA1 ( x.RI, X1, OO ) ;    end loop; -- x
      end if ;
end D_SNA ;

--------------------------------------------------
procedure heir39 (p_dat01 date) is   --    наследование рез-МСФЗ от промлого месяца
   z_dat01 date  ; -- отсетная дата
   s_dat01 varchar2(10); -- она же. симтольная
   l_dat31 date  ; -- посл раб дата отч.месяца
   m_dat01 date  ; -- отч.дата пред месяца
   ---------------
   l_rez  number ;
   l_rezq number ;
   s_250  char(1);
   --------------
begin
   if p_dat01 is null then
      s_dat01 := pul.get_mas_ini_val('sFdat1') ;
      if s_dat01 is null then
         raise_application_error( -20333,gl.aMfo||':prvn_flow.heir39 : Не задано звітну дату = 01.mm.yyyy');
      end if;
      z_dat01 := to_date( s_dat01, 'dd.mm.yyyy') ;
   else  z_dat01 := p_dat01;
         s_dat01 := to_char(z_dat01, 'dd.mm.yyyy')  ;
         pul_dat(s_dat01, null ) ;
   end if;

   m_dat01 := add_months (z_dat01,-1) ;
   select max(fdat)  into l_dat31  from fdat  where fdat < z_dat01 ;

   for k in (select  kv, id, bv, bvq, rez23, rezq23, s250 , acc, rowid RI  from nbu23_rez where fdat = z_dat01)
   loop l_rez := k.rez23; l_rezq := k.rezq23; s_250 := k.s250; -- по умолчанию = 23 плстанове, котоая уже расчитана.

        if k.id NOT like 'DEBH%' and k.id NOT like 'XOZ%' and k.bv > 0 then -- ищем этот счет в прощлом мес
           begin select rez39, s250_39 into l_rez, s_250 from nbu23_rez where fdat = m_dat01 and acc = k.acc and rez39 is not null ;
                 If k.kv <> gl.baseval then l_rezq := gl.p_icurval( k.kv, l_rez*100, l_dat31)/100;
                 else                       l_rezq := l_rez;
                 end if;
                 l_rez  := least ( l_rez , k.bv  ) ;
                 l_rezQ := least ( l_rezq, k.bvq ) ;
           exception when no_data_found then  null ;
           end ;

        end if ;
        update nbu23_rez  set rez39 = l_rez,  rezq39 = l_rezq , s250_39 = s_250  where rowid = k.RI;
   end loop ;

   commit;
   --Рівчачок
   Rezerv_23 ( z_dat01 );
   commit;

end heir39 ;
------------------
procedure opl (oo IN OUT oper%rowtype ) is
begin
   If oo.ref is null then gl.ref (oo.REF);
      gl.in_doc3 (ref_=>oo.REF, tt_=>oo.tt, vob_=>oo.vob, nd_ =>oo.nd, pdat_=>SYSDATE, vdat_=>oo.vdat , dk_ =>oo.dk,
                   kv_=>oo.kv , s_ =>oo.S , kv2_=>oo.kv2, s2_ =>oo.S2, sk_  => null  , data_=>gl.BDATE,datp_=>gl.bdate,
                nam_a_=>oo.nam_a,nlsa_=>oo.nlsa,mfoa_=>gl.aMfo,nam_b_=>oo.nam_b,nlsb_=>oo.nlsb, mfob_=>gl.aMfo,
                 nazn_=>oo.nazn,d_rec_=>null,  id_a_=>gl.aOkpo,id_b_ =>gl.aOkpo,id_o_=>null,sign_=>null,sos_=>1,prty_=>null,uid_=>null);
   end if; gl.payv(0, oo.ref, oo.vdat, oo.tt, oo.dk, oo.kv, oo.nlsa, oo.s, oo.kv2,  oo.nlsb, oo.s2);
end opl ;
-------

function BAD_CP(  p_OSA VARCHAR2 , z_dat01 date )  return varchar2 IS
   s_ND VARCHAR2 (20);   l_acc number ;   n_nd  number ;
BEGIN
  s_nd := substr( p_osa, instr( p_osa, '/',1) +1 ) ;

  if gl.amfo ='300465' AND P_OSA LIKE '9/%' THEN
     --- обработка гнилого портфеля по ЦБ
     begin n_nd := to_number (s_nd) ;
        select acc into l_acc from nbu23_rez where fdat=z_dat01 and nd = n_nd and id like 'CACP%' and rownum =1;
     exception when no_data_found  then
        begin
           select to_char(a.accc) into s_nd from accounts a, cp_deal p where p.ref = n_nd and p.acc = a.acc;
        exception when no_data_found  then null;
        end;
     end;
  end if;
  RETURN s_nd;
END  BAD_CP;
-------------------------------------------------------------
procedure FROM_SRR_XLS(p_ID_CALC_SET srr_xls.id_calc_set%type)  is
begin
   delete from PRVN_FV_REZ_IFRS9 where ID_CONTRACT = 'PREMIY' and id_calc_set = p_id_calc_set and id_branch = (select id from regions where kf = sys_context('bars_context','user_mfo'));
   for xls in (select x.* from SRR_XLS x, regions r  where x.id_branch = r.id and r.kf = sys_context('bars_context','user_mfo') and x.id_calc_set = p_id_calc_set)
   loop
      insert into PRVN_FV_REZ_IFRS9 (     ID_CALC_SET,     UNIQUE_BARS_IS,     ID_BRANCH,     ID_CURRENCY,     DELTA_FV_CCY, ID_CONTRACT,     RNK_CLIENT)
                             values ( xls.ID_CALC_SET, xls.UNIQUE_BARS_IS, xls.ID_BRANCH, xls.ID_CURRENCY, xls.FV_CCY      , 'PREMIY'   , xls.RNK_CLIENT);
   end LOOP;
end FROM_SRR_XLS;
-------------------------------------------------------------
procedure div39 ( p_mode int, p_dat01 date )   is   -- разделение рез-39 по КД в НБУ-23-РЕЗ.
   -- Прийом витрины резервов по МСФЗ
   -- !!!! уже НЕТ p_mode = 0 -- принять файл и разнести по НБУ23
   --              p_mode = 1 -- только принять файл
   --              p_mode = 2 -- только разнести по НБУ23
   z_dat01 date   ; l_dat31 date  ; l_dat31_fv date  ;
   l_max    number; l_min   number; l_num      number; l_nd  number; l_commit number; l_all   number;
   nTmp_    number; l_rez   number; l_acc      number; s_KB  number; s_BV     number; s_BVN   number;
   l_SNA01  number; q_Rez   number; s_k9       number; n_Rez number; l_r9     number; l_r     number;
   s_KV     int   ; l_MMFO  int   ; l_count    int   ;
   l_id  varchar2(25);  sErr_   varchar2(100) := ''  ;  l_msg varchar2(250);  s_dat01   varchar2(10);
   s_nls varchar2(15);  s_RI    varchar2(254) ;         s_tp  varchar2(1)  ;  s_tp_next varchar2(3) ;
   s1         SYS_REFCURSOR;

begin -- OSA_V_PROV_RESULTS_OSH = PRVN_FV_REZ => PRVN_OSA= > PRVN_OSAq

   If p_mode = 12 and gl.amfo <> '300465' then
      raise_application_error(-20000,gl.aMfo||':Дана опція - лише для ЦА,  МФО = 300045 ');
   end if;

   if p_dat01 is null then   s_dat01 := pul.get_mas_ini_val('sFdat1')   ; z_dat01 := to_date( s_dat01, 'dd.mm.yyyy') ;
   else  z_dat01 := p_dat01; s_dat01 := to_char(z_dat01, 'dd.mm.yyyy')  ; pul_dat(s_dat01, null ) ;
   end if     ;
   l_dat31    := Dat_last_work(z_dat01 -1 ); -- для курса
   l_dat31_fv := z_dat01 -1 ; -- дата приема витрины


   If p_mode in (1) then   --------------------------------------------- принять файл
      -- p_mode = 1 -- только принять файл

      l_msg := '1) OSA: Прийом та стиснення '||z_dat01 ;
      dbms_application_info.set_client_info(':'|| gl.aMfo ||':1) Прийом та стиснення інформації від FINEVARE');
      z23.to_log_rez (user_id , 4 , p_dat01 ,'1) Прийом та стиснення інформації від FINEVARE');
      --PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );

      l_min := to_number ( to_char( l_dat31_fv , 'YYMMDD')||'00') ;
      l_max := to_number ( to_char( l_dat31_fv , 'YYMMDD')||'99') ;
      ---------------------------------------- XXYYZZ-----WW -------------

      select max (ID_CALC_SET)   into l_num   from PRVN_FV_REZ_IFRS9 o, regions r
      where ID_CALC_SET >= l_min and ID_CALC_SET <= l_max and o.id_branch = r.id and r.kf = sys_context('bars_context','user_mfo') ;

      if l_num is null
      then
        raise_application_error( -20333,gl.aMfo||':Вітрини з рез.МСФЗ PRVN_FV_REZ_IFRS9 на дату='||to_char(l_dat31_fv,'dd.mm.yyyy') ||
                                'по ф-лу:'|| sys_context('bars_context','user_mfo') ||' не знайдено');
        return;
      end if;

      -- Определяем схема MMFO ?
      begin
         select count(*) into l_MMFO from mv_kf;
         if l_MMFO > 1 THEN             l_MMFO := 1; -- схема    MMFO
         ELSE                           l_MMFO := 0; -- схема не MMFO
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_MMFO := 0; -- схема не MMFO
      end ;
      FROM_SRR_XLS(l_num);  -- Прием XLS переоценки
      -- сжатие витрины делойта по дог Выбрасывание нулей

      delete PRVN_OSAq;

      if l_MMFO = 1 THEN
         insert into PRVN_OSAq ( rnk,   tip,   ND,   kv,  REZB,    REZ9,  AIRC_CCY, IRC_CCY,  ID_PROV_TYPE, vidd ,
                                 s1, s2, b1, s3, s4, b3, s5, s6, b5, s7, s8, b7, IRR , F1, FV_CCY)
                          select f.rnk, f.tip, f.ND, t.kv, sum (F.rezb) REZB, sum (F.rez9) REZ9, sum (F.AIRC_CCY) AIRC_CCY, sum (F.IRC_CCY) IRC_CCY,
                                 min (f.ID_PROV_TYPE ) ID_PROV_TYPE, decode(f.tip,3,d.vidd,null) vidd,
                                 sum(f.s1) s1, sum(f.s2) s2, sum(f.b1) b1, sum(f.s3)  s3 , sum(f.s4) s4, sum(f.b3)     b3, sum(f.s5) s5, sum(f.s6) s6, sum(f.b5) b5,
                                 sum(f.s7) s7, sum(f.s8) s8, sum(f.b7) b7, max(f.IRR) irr, max(f.F1) f1, sum(f.FV_CCY) FV_CCY
                       from  (select Id_currency LCV, Rnk_client  RNK,
                                     substr(Unique_Bars_is , 1 , instr(Unique_Bars_is, '/',1) -1 ) TIP,
                                     --substr(Unique_Bars_is||decode(l_MMFO,1,r.code,''), instr(Unique_Bars_is||decode(l_MMFO,1,r.code,''), '/',1) +1 ) ND,
                                     substr(Unique_Bars_is, instr(Unique_Bars_is, '/',1) +1 ) ND,
                                     nvl(Prov_Balance_CCY,0)    REZB,
                                     nvl(Prov_OffBalance_CCY,0) REZ9,
                                     nvl(AIRC_CCY,0) AIRC_CCY,
                                     nvl(IRC_CCY,0)  IRC_CCY ,
                                     ID_PROV_TYPE, -- Метка расчета резерва на индивидуальной или коллективной основе. "С" - колл, "І" - индивид
                                     nvl(FV_ADJ_NEW_FEE,0)    s1 , nvl(FV_ADJ_AMORT,0)      s2, nvl(FV_ADJ_BALANCE,0)      b1 ,
                                     nvl(MODIF_NEW_FEE,0)     s3 , nvl(MODIF_AMORT,0)       s4, nvl(MODIF_BALANCE,0)       b3,
                                     nvl(GENERAL_NEW_FEE,0)   s5 , nvl(GENERAL_FEE_AMORT,0) s6, nvl(GENERAL_FEE_BALANCE,0) b5,
                                     nvl(ACCRUAL_ADJ_DELTA,0) s7 , nvl(ACCRUAL_ADJ_AMORT,0) s8, nvl(ACCRUAL_ADJ_BALANCE,0) b7,
                                     EIR                      irr, DERECOGNITION_FLAG       f1, DELTA_FV_CCY               FV_CCY
                              from PRVN_FV_REZ_IFRS9 o, regions r
                              where o.id_branch = r.id and r.kf = sys_context('bars_context','user_mfo') and
                                  ( Prov_Balance_CCY     > 0  or  Prov_OffBalance_CCY > 0 or AIRC_CCY           > 0  or  IRC_CCY             <> 0
                                or  nvl(FV_ADJ_NEW_FEE,0)      <> 0  or  nvl(FV_ADJ_AMORT,0)       <> 0 or nvl(FV_ADJ_BALANCE,0)    <> 0  or  nvl(MODIF_NEW_FEE,0)       <> 0
                                or  nvl(MODIF_AMORT,0)         <> 0  or  nvl(MODIF_BALANCE,0)      <> 0 or nvl(GENERAL_NEW_FEE,0)   <> 0  or  nvl(GENERAL_FEE_AMORT,0)   <> 0
                                or  nvl(GENERAL_FEE_BALANCE,0) <> 0  or  nvl(ACCRUAL_ADJ_DELTA,0)  <> 0 or nvl(ACCRUAL_ADJ_AMORT,0) <> 0  or  nvl(ACCRUAL_ADJ_BALANCE,0) <> 0
                                or  nvl(DELTA_FV_CCY,0)        <> 0  or  nvl(DERECOGNITION_FLAG,0) <> 0 or nvl(EIR,0)               <> 0 ) and ID_CALC_SET = l_num
                              ) F, tabval T,cc_deal d
                        where t.lcv = f.lcv and f.nd=d.nd (+)
                        group by f.rnk, f.tip, f.ND, t.kv, d.vidd ;
      else
         insert into PRVN_OSAq ( rnk,   tip,   ND,   kv, REZB, REZ9,AIRC_CCY, IRC_CCY, ID_PROV_TYPE,  vidd,
                                 s1, s2, b1, s3, s4, b3, s5, s6, b5, s7, s8, b7, IRR , F1, FV_CCY)
                          select f.rnk, f.tip, f.ND, t.kv, sum (F.rezb) REZB, sum (F.rez9) REZ9, sum (F.AIRC_CCY) AIRC_CCY, sum (F.IRC_CCY) IRC_CCY,
                                 min (f.ID_PROV_TYPE ) ID_PROV_TYPE, decode(f.tip,3,d.vidd,null) vidd,
                                 sum(f.s1) s1, sum(f.s2) s2, sum(f.b1) b1, sum(f.s3)  s3 , sum(f.s4) s4, sum(f.b3) b3, sum(f.s5) s5, sum(f.s6) s6, sum(f.b5) b5,
                                 sum(f.s7) s7, sum(f.s8) s8, sum(f.b7) b7, max(f.IRR) irr, max(f.F1) f1, sum(f.FV_CCY) FV_CCY
                       from  (select Id_currency LCV, Rnk_client  RNK,
                                     substr(Unique_Bars_is , 1 , instr(Unique_Bars_is, '/',1) -1 ) TIP,
                                     substr(Unique_Bars_is, instr(Unique_Bars_is, '/',1) +1 ) ND,
                                     nvl(Prov_Balance_CCY,0)    REZB,
                                     nvl(Prov_OffBalance_CCY,0) REZ9,
                                     nvl(AIRC_CCY,0) AIRC_CCY,
                                     nvl(IRC_CCY,0)  IRC_CCY ,
                                     ID_PROV_TYPE, -- Метка расчета резерва на индивидуальной или коллективной основе. "С" - колл, "І" - индивид
                                     nvl(FV_ADJ_NEW_FEE,0)    s1 , nvl(FV_ADJ_AMORT,0)      s2, nvl(FV_ADJ_BALANCE,0)      b1,
                                     nvl(MODIF_NEW_FEE,0)     s3 , nvl(MODIF_AMORT,0)       s4, nvl(MODIF_BALANCE,0)       b3,
                                     nvl(GENERAL_NEW_FEE,0)   s5 , nvl(GENERAL_FEE_AMORT,0) s6, nvl(GENERAL_FEE_BALANCE,0) b5,
                                     nvl(ACCRUAL_ADJ_DELTA,0) s7 , nvl(ACCRUAL_ADJ_AMORT,0) s8, nvl(ACCRUAL_ADJ_BALANCE,0) b7,
                                     EIR                      irr, DERECOGNITION_FLAG       f1, nvl(DELTA_FV_CCY,0)        FV_CCY
                              from PRVN_FV_REZ_IFRS9 o
                              where ( Prov_Balance_CCY   > 0  or  Prov_OffBalance_CCY > 0 or AIRC_CCY           > 0  or  IRC_CCY             <> 0
                                or  FV_ADJ_NEW_FEE      <> 0  or  FV_ADJ_AMORT       <> 0 or FV_ADJ_BALANCE    <> 0  or  MODIF_NEW_FEE       <> 0
                                or  MODIF_AMORT         <> 0  or  MODIF_BALANCE      <> 0 or GENERAL_NEW_FEE   <> 0  or  GENERAL_FEE_AMORT   <> 0
                                or  GENERAL_FEE_BALANCE <> 0  or  ACCRUAL_ADJ_DELTA  <> 0 or ACCRUAL_ADJ_AMORT <> 0  or  ACCRUAL_ADJ_BALANCE <> 0
                                or  nvl(DELTA_FV_CCY,0) <> 0  or  DERECOGNITION_FLAG <> 0 or EIR               <> 0 ) and ID_CALC_SET = l_num )  F, tabval T,cc_deal d
                        where t.lcv = f.lcv and f.nd=d.nd (+)
                        group by f.rnk, f.tip, f.ND, t.kv, d.vidd ;
      end if;

      commit;

      --PRVN_FLOW.SeND_MSG (p_txt => 'END-KV:'||l_msg );

      -- сжатие витрины делойта в целом по дог в экв. для vidd not in (3,13)
--    execute immediate 'truncate table PRVN_OSAQ';
/*
      delete PRVN_OSAQ;

      insert
        into PRVN_OSAq ( rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT,  REZB, REZ9, AIRC_CCY, vidd )
      select rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT, SUM ( gl.p_icurval( KV,REZB    *100 ,l_dat31 ) ) /100 ,
             SUM ( gl.p_icurval( KV,REZ9    *100 ,l_dat31 ) ) /100 , SUM ( gl.p_icurval( KV,AIRC_CCY*100 ,l_dat31 ) ) /100 , vidd
        from PRVN_OSA
       where vidd not in (3,13) or vidd is null or
                nd in (select distinct nd
                       from (select n.nd, kv from cc_deal e, accounts a, nd_acc n
                             where   e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and  tip in ('SK9','SK0')  ) x
                       where x.kv not in (select distinct kv from cc_deal e, accounts a, nd_acc n
                                          where  e.nd=x.nd and e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and
                                                 a.tip in ('SN ','SNO','SP ','SPN','SS '))
                      )
        group by rnk, tip, ND, ID_PROV_TYPE,  IS_DEFAULT, vidd;

      -- сжатие витрины делойта по KV и дог в экв. для vidd in (3,13)
      insert into PRVN_OSAq ( rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT,  REZB, REZ9, AIRC_CCY ,vidd,kv)
         select rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT, SUM ( gl.p_icurval( KV,REZB    *100 ,l_dat31 ) ) /100 ,
                SUM ( gl.p_icurval( KV,REZ9 * 100 ,l_dat31 ) ) /100 , SUM ( gl.p_icurval( KV,AIRC_CCY*100 ,l_dat31 ) ) /100 , vidd, kv
         from   PRVN_OSA
         where  vidd in (3,13) and
                nd not in ( select distinct nd
                            from  (select n.nd, kv from cc_deal e, accounts a, nd_acc n
                                   where  e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and tip in ('SK9','SK0') ) x
                            where x.kv not in (select distinct kv from cc_deal e, accounts a, nd_acc n
                                               where  e.nd=x.nd and e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and
                                                      a.tip in ('SN ','SNO','SP ','SPN','SS ')) )
         group by kv, rnk, tip, ND, ID_PROV_TYPE,  IS_DEFAULT, vidd ;
      commit;
      PRVN_FLOW.SeND_MSG (p_txt => 'END-eqv:'||l_msg );
*/
   end if;
   -------------------
   If p_mode in (2 , 12 ) then ---------------------------------- разнести по НБУ23 через екв

      --update PRVN_OSAq set comm = null where rezb <> 0 or rez9<> 0;
      --commit;

      If p_mode = 2 then 
         dbms_application_info.set_client_info(':'|| gl.aMfo ||':7) Розподіл МСФЗ-9');
         l_msg:= '4) RR-351:  Тільки Розподіл + Рівчачок для проводок';
         z23.to_log_rez (user_id , 7 , p_dat01 ,'7) Розподіл МСФЗ-9');
      else
         dbms_application_info.set_client_info(':'|| gl.aMfo ||':7) ПЕРЕ-Розподіл ручних МСФЗ-9');
         l_msg :='4.1 для ЦА =  Тільки ПЕРЕ-Розподіл ручних + Рівчачок';
         z23.to_log_rez (user_id , 7 , p_dat01 ,'7) ПЕРЕ-Розподіл ручних МСФЗ-9');
      end if;
      --PRVN_FLOW.SeND_MSG (p_txt => 'BEG-eqv:'||l_msg );

      -- p_mode = 2 -- только разнести по НБУ23
      -- p_mode = 12 -- -- Технічний пункт =  Тільки ПЕРЕ-Розподіл ручних в ЦА
      -- обнуление рез-39 , кроме хоз.деб


      If p_mode <> 12 then
         update nbu23_rez  set rez9 = 0,  rezq9 = 0 , s250_39 = null
          where fdat = z_dat01;
            --and id not like 'DEBH%'
            --and id not like 'XOZ% ' ;
      end if;

      commit;
      LOGGER.INFO('OSA-1:Цикл по ND' );
      l_commit := 0; l_all := 0 ;
      for x in ( select kv, rnk, tip, ND, REZB, REZ9, ID_PROV_TYPE, IS_DEFAULT, rowid RI, REZB_R, REZ9_R, FV_ABS from PRVN_OSAq order by nd  )
      loop
        If p_mode = 12 then
           If x.REZB_R is     null and x.REZ9_R is     null then   goto NEXT_;       end if;
           If x.REZB_R is NOT null                          then x.REZB := x.REZb_r; end if;
           If                          x.REZ9_R is NOT null then x.REZ9 := x.REZ9_r; end if;
        end if;

        l_count := 0 ;
        l_SNA01 := 0 ;

        if   x.TIP = 3 and x.kv is null     THEN
             OPEN s1 FOR select lead(substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ),1,-1) 
                       over(order by substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9',    0, BVu )) over (partition by 1)),
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', BVu,    0 )) over (partition by 1))
                         from nbu23_rez where fdat =z_dat01 and BVu > 0 and tip not in ('SDI','SDA','SDM','SDF','SNA') and nd =  x.ND and ( rez9 = 0 or p_mode = 12)
                          AND ( id like 'CCK%' or id like 'MBDK%' or id like '150%' or id like '9000%' or id like '9122%' or id like 'DEBF%' )
                          and tipa = 3; 

       ElsIf x.TIP = 3 and x.kv is not null THEN
             OPEN s1 FOR select lead(substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ),1,-1) 
                       over(order by substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', 0  , BVu )) over (partition by 1)),
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', BVu,    0)) over (partition by 1))
                         from nbu23_rez where fdat = z_dat01 and BVu > 0  and tip not in ('SDI','SDA','SDM','SDF','SNA') and nd =  x.ND and ( rez9 = 0 or p_mode = 12)
                          AND ( id like 'CCK%' or id like 'MBDK%' or id like '150%' or id like '9000%' or id like '9122%' or id like 'DEBF%' )
                          and tipa = 3 and kv=x.kv ;
       ElsIf x.TIP = 9   then
             OPEN s1 FOR select lead(substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ),1,-1) 
                       over(order by substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu, 
                                      Div0( BVu , sum(BVu) over (partition by 1)), 0
                         from nbu23_rez where fdat = z_dat01 and BVu >= 0 and nd =  x.ND    and ( rez9 = 0 or p_mode = 12)
                          AND ( id like 'CACP%' or id like 'DEBF%' )      and tipa = 9 ;

       ElsIf x.TIP = 4   then
             OPEN s1 FOR select lead(substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ),1,-1) 
                       over(order by substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', 0  ,BVu )) over (partition by 1)),
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', BVu,   0)) over (partition by 1))
                         from nbu23_rez where fdat= z_dat01 and BVu >= 0 and ( rez9 = 0 or p_mode = 12 )
                          and tipa = 4  and nd = x.ND  AND (id like 'W4%'  or id like 'BPK%' or id like 'DEBF%') ;
       ElsIf x.TIP = 23   then   --  Instalment  COBUINST-8
             OPEN s1 FOR select lead(substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ),1,-1) 
                       over(order by substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', 0  ,BVu )) over (partition by 1)),
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', BVu,   0)) over (partition by 1))
                         from nbu23_rez where fdat= z_dat01 and BVu >= 0 and ( rez9 = 0 or p_mode = 12 )
                          and tipa = 23  and nd = x.ND  AND (id like 'INS%' or id like 'DEBF%') ;

       ElsIf x.TIP = 10  then
             OPEN s1 FOR select lead(substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ),1,-1) 
                       over(order by substr(nls,1,1)||decode (tip, 'SPN',1, 'SNO',2, 'SN ',3, 'SP ',5, 'SS ',6, 10 ) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', 0  ,BVu )) over (partition by 1)),
                                       Div0( BVu, sum(decode(substr(nls,1,1),'9', BVu,  0 )) over (partition by 1))
                         from nbu23_rez
                         where fdat= z_dat01 and BVuq >= 0 and nd = x.ND and (rez9 = 0 or p_mode = 12)
                           AND (id like 'OVER%' or id like 'DEBF%' )  and tipa = 10;

      ElsIf x.TIP = 17   then

         begin
            select ACC_SP  into l_acc from FIN_DEB_ARC  where ACC_SS = x.nd  and ACC_SS <> ACC_SP and mdat = z_dat01;
             -- ACC_SP is not null
             --and EFFECTDATE < z_dat01;
         exception  when NO_DATA_FOUND  then l_acc := x.nd;
         end;

         OPEN s1 FOR select lead(substr(nls,1,1),1,-1) over(order by substr(nls,1,1) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu, Div0 (BVu, sum(BVu) over (partition by 1)), 0  from nbu23_rez
                     where fdat= z_dat01 and BVuq >= 0 and ( rez9 = 0 or p_mode = 12 ) and acc in (x.ND,l_acc) AND ( id like 'DEB%') and tipa = 17;

      ElsIf x.TIP = 21 then

         OPEN s1 FOR
            select lead(substr(nls,1,1),1,-1) over(order by substr(nls,1,1) ), substr(nls,1,1), ROWID, nls, BVuq, KV, BVu, Div0 (BVu, sum(BVu) over (partition by 1)), 0  from   nbu23_rez
            where  fdat= z_dat01 and BVuq >= 0 and ( rez9 = 0 or p_mode = 12 ) and nd in (x.ND) AND ( id like 'DEBH%')  and tipa in ( 21, 17 );

      else
        update prvn_osaq  SET COMM = substr('NOT tip='||x.tip || '=> '||comm,1,100)  , FV_ABS = REZB+REZ9  where rowid = x.RI;
        goto NEXT_;
      end if;

       x.FV_ABS := 0;
       l_r9:= x.rez9;
       l_r := x.rezb;
       --LOGGER.INFO('PRV_OSA- 1 ND = ' ||x.nd );
       LOOP FETCH s1 into s_tp_next, s_tp, s_RI , s_nls,  s_BV, s_KV, s_BVN, s_KB , s_k9 ;
       EXIT WHEN s1%NOTFOUND;

            If s_tp = '9' then nTmp_ := round ( x.REZ9 , 2) ;
            else               nTmp_ := round ( x.REZb , 2) ;
            end if;
            --LOGGER.INFO('PRV_OSA- 1 ND = ' ||x.nd || ' nls = ' || s_nls || ' nTmp_ = ' ||nTmp_ );
            n_REZ := LEAST ( nTmp_, s_BVn)  ;                       -- приблизительны экв
            --LOGGER.INFO('PRV_OSA- 2 ND = ' ||x.nd || ' nls = ' || s_nls || ' n_REZ = ' ||n_REZ );
            If s_tp = '9' then l_r9 := l_r9 - n_rez; x.rez9 := x.rez9 - n_rez; 
            else               l_r  := l_r  - n_rez; x.rezb := x.rezb - n_rez; 
            end if;
            --LOGGER.INFO('PRV_OSA- 3 ND = ' ||x.nd || ' nls = ' || s_nls || ' l_r9 = ' ||l_r9 || ' l_r = ' ||l_r || ' x.rez9 = ' ||x.rez9 || ' x.rezb = ' ||x.rezb);
            if    s_tp_next in ('9','-1') and s_tp not in ('9') and l_r  <> 0 THEN n_rez := LEAST ( n_rez + l_r , s_BVn) ;
            elsif s_tp_next in ('-1')     and s_tp     in ('9') and l_r9 <> 0 THEN n_rez := LEAST ( n_rez + l_r9, s_BVn) ;
            end if;
            --if s_tp =  '9' and abs(l_r9) <= 0.02 and l_r9 <>0 THEN n_rez := n_rez + l_r9; end if;
            --if s_tp <> '9' and abs(l_r ) <= 0.02 and l_r  <>0 THEN n_rez := n_rez + l_r ; end if;
            --LOGGER.INFO('PRV_OSA- 4 ND = ' ||x.nd || ' nls = ' || s_nls || ' n_REZ = ' ||n_REZ || ' l_r9 = ' || l_r9);
            --n_REZ := gl.p_Ncurval( s_kv, q_REZ*100, l_dat31)/100 ; -- приблизительный номинал
            --n_REZ := Least ( n_REZ, s_BVN) ;                       -- выровняный номинал
            q_REZ := gl.p_Icurval( s_kv, n_REZ*100, l_dat31)/100 ; -- расчетный экв выровняного ном
            update nbu23_rez set rezq9 = q_REZ , rez9 = n_REZ, s250_39 = x.ID_PROV_TYPE where rowid = s_RI;
            x.FV_ABS := x.FV_ABS + n_REZ ;
            --LOGGER.INFO('PRV_OSA- 5 ND = ' ||x.nd || ' nls = ' || s_nls || ' x.FV_ABS = ' ||x.FV_ABS );
            l_count  := l_count  + 1 ;
       end loop;

       CLOSE s1;

       If  l_count > 0 then sErr_ := 'OK '|| s_nls    ;
       else                 sErr_ := 'NOT NBU23_rez'  ; x.FV_ABS := 0;
       end if ;

       update  prvn_osaq  SET COMM = substr(sErr_ || ' => '||comm,1,100), FV_ABS = (x.REZB + x.REZ9)   where rowid = x.RI  ;

       l_commit := l_commit + 1; l_all := l_all    + 1 ;
       If l_commit >= 1000 then  commit;  l_commit:= 0 ;  LOGGER.INFO('OSA-2.1:Обработано '||l_all||' дог.');    end if;

       <<NEXT_>> null;
     end loop;
     ----------------
     commit;  LOGGER.INFO('OSA-2.2:Обработано ВСЕГО '||l_all||' дог ' || to_char( z_dat01, 'dd.mm.yyyy' ) );
     --PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );
  end if;

  If p_mode in (12,2 ) then ---------------------------------- разнести по НБУ23
     -- p_mode = 0 -- принять файл и разнести по НБУ23
     --Рівчачок

     l_msg:= ' ... Рівчачок для проводок';
     --PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
     Rezerv_23 ( z_dat01 );
     commit;
     --PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );
 end if;

end div39;


------------------------------
procedure del0 ( p_mode int)
is  -- отладочная процедура очистки всех таблиц
begin
  EXECUTE IMMEDIATE ' truncate  table PRVN_FLOW_DETAILS     ' ; -- delete from PRVN_FLOW_DETAILS;
  EXECUTE IMMEDIATE ' truncate  table PRVN_FLOW_DEALS_VAR   ' ; -- delete from PRVN_FLOW_DEALS_VAR;
end del0;

--
-- ежедневная процедура добавки новых КД
--
procedure add1
( p_dat01 date
, p_mode  int     default 0
, p_nd    number  default null )
is
  title    constant  varchar2(60) := 'prvn_flow.add1';
  l_dat01            date;
  l_dat31            date;
  l_rowcnt           pls_integer;

begin

  bars_audit.info( title||': Start running with p_mode='||to_char(p_mode)
                        ||', p_nd='||to_char(p_nd)||', p_dat01='||to_char(p_dat01,'dd.mm.yyyy') );

  if ( p_dat01 is null )
  then
    l_dat01 := nvl( to_date(pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy'), GL.bdate );
  else
    l_dat01 := p_dat01;
  end if;

  select max(FDAT) into l_dat31 from FDAT where FDAT < l_dat01;

  bars_audit.info( title||': l_dat01='||to_char(l_dat01,'dd.mm.yyyy')||', l_dat31='||to_char(l_dat31,'dd.mm.yyyy') );

  -- 1)  MBK
  insert into PRVN_FLOW_DEALS_CONST
    ( id, nd, acc, dat_add, vidd, rnk, wdate, kv, sdate, daos )
  select bars_sqnc.get_nextval('PRVN_FLOWDEALS')
       , d.nd, ad.accs, sysdate, d.vidd, d.rnk,
         NVL( (select min(fdat) from cc_prol where nd= d.nd and npp = 0), d.WDAte ) wdate,
         ad.kv, d.sdate, d.sdate
    from CC_DEAL d,
         CC_ADD ad
   where d.vidd > 1500 and d.vidd < 1600
     and l_dat31 between d.SDATE and d.WDATE
     and d.nd = ad.nd and ad.adds = 0
     and not exists ( select 1 from PRVN_FLOW_DEALS_CONST where nd = d.nd and acc = ad.accs);

  l_rowcnt := SQL%ROWCOUNT;

  if ( l_rowcnt > 0 )
  then
    bars_audit.info( title||': МБК '||to_char(l_rowcnt)||' row created.' );
  end if;

  -- 2) ЮЛ+ФЛ
  -- 2.1) Имеют норм тело SS  и 8999*, который НЕ закрыт или закрыт после отчетной даты
  insert
    into PRVN_FLOW_DEALS_CONST
       ( ID, ND, ACC, DAT_ADD, VIDD,  RNK,  TIP,  DAOS, KV, SDATE, ACC8, DAZS, KV8, WDATE, I_CR9, PR_TR, FL2 )
  select bars_sqnc.get_nextval('PRVN_FLOWDEALS')
       , d.ND, SS.ACC, sysdate, d.VIDD, d.RNK, SS.TIP, SS.DAOS, SS.kv, d.sdate, SS.accc, SS.dazs, LIM.KV kv8,
               NVL( (select min(mdate) from cc_prol where nd= d.nd and npp = 0), d.wdate )       WDATE,
       decode( d.vidd,1,0,11,0, (select txt from nd_txt   where nd = d.nd and tag = 'I_CR9') )   I_CR9,
                                (select txt from nd_txt   where nd = d.nd and tag = 'PR_TR')     PR_TR,
                 1- (select substr(txt,2,1) from nd_txt   where nd = d.nd and tag = 'FLAGS')     FL2
   from cc_deal d
      , nd_acc  n
      , (select * from accounts where tip = 'SS ' and nls like '2%') SS
      , (select * from accounts where tip = 'LIM' and nls like '8999%' and (dazs is null or dazs > l_dat31 ) ) LIM
  where d.vidd in (1, 2, 3, 11, 12, 13)
    and d.sdate <= l_dat31
    and d.sos >= 10
    and d.nd = n.nd
    and d.NDG Is Null
    and n.acc = SS.acc
    and SS.accc = LIM.acc
    and not exists ( select 1 from PRVN_FLOW_DEALS_CONST where nd = d.nd and acc = SS.acc);

  l_rowcnt := SQL%ROWCOUNT;

  if ( l_rowcnt > 0 )
  then
    bars_audit.info( title||': КП 2.1 '||to_char(l_rowcnt)||' row created.');
  end if;

  -- 2.2) Имеют только просроч.тело SP(SL) и 8999*, который НЕ закрыт или закрыт после отчетной даты
  insert into prvn_flow_deals_const
    (id, nd, acc, dat_add, vidd,  rnk,  tip, daos,  kv, sdate, acc8, dazs, kv8, wdate, i_cr9, pr_tr, fl2 )
  select bars_sqnc.get_nextval('PRVN_FLOWDEALS')
       , d.ND, SP.acc, sysdate, d.VIDD, d.RNK, SP.TIP, SP.DAOS, SP.kv, d.sdate, SP.accc, SP.dazs, LIM.KV kv8,
         NVL( (select min(mdate) from cc_prol where nd= d.nd and npp = 0), d.wdate)             WDATE,
       decode( d.vidd,1,0,11,0, (select txt from nd_txt   where nd = d.nd and tag = 'I_CR9') )  I_CR9,
                                (select txt from nd_txt   where nd = d.nd and tag = 'PR_TR')    PR_TR,
                 1- (select substr(txt,2,1) from nd_txt   where nd = d.nd and tag = 'FLAGS')    FL2
  from cc_deal d, nd_acc n,
       (select * from accounts where tip in ('SP ','SL ')  and nls like '2%') SP ,
       (select * from accounts where tip = 'LIM'  and nls like '8999%' and (dazs is null or dazs > l_dat31 ) ) LIM
  where d.vidd in (1, 2, 3, 11, 12, 13)  and d.sdate <= l_dat31 and d.sos >=10
    and d.nd = n.nd and n.acc = SP.acc   and SP.accc = LIM.acc
    and not exists ( select 1 from prvn_flow_deals_const  where nd = d.nd and acc8 = SP.accc)  ;

  l_rowcnt := SQL%ROWCOUNT;

  if ( l_rowcnt > 0 )
  then
    bars_audit.info( title||': КП 2.2 '||to_char(l_rowcnt)||' row created.');
  end if;

  -- 2.3) НЕ Имеют никакого тела, но имеют что-то 2 кл и имеют8999*, который НЕ закрыт или закрыт после отчетной даты
  insert into prvn_flow_deals_const
    (id, nd, acc, dat_add, vidd,  rnk,  tip, daos, kv, sdate, acc8, dazs, kv8, wdate, i_cr9, pr_tr, fl2 )
  select bars_sqnc.get_nextval('PRVN_FLOWDEALS')
       , d.ND, null, sysdate, d.VIDD, d.RNK, null, null, null, d.sdate, LIM.acc, null, LIM.kv,
         NVL( (select min(mdate) from cc_prol where nd = d.nd and npp = 0), d.wdate)          WDATE,
        decode( d.vidd,1,0,11,0, (select txt from ND_TXT where nd = d.nd and tag = 'I_CR9') ) I_CR9,
                                 (select txt from ND_TXT where nd = d.nd and tag = 'PR_TR')   PR_TR,
                  1- (select substr(txt,2,1) from ND_TXT where nd = d.nd and tag = 'FLAGS')   FL2
  from cc_deal d, nd_acc n,
       (select * from accounts where tip = 'LIM'  and nls like '8999%' and (dazs is null or dazs > l_dat31 ) ) LIM
  where d.vidd in (1, 2, 3, 11, 12, 13) and d.SDATE <= l_dat31 and d.sos >=10
    and d.nd = n.nd and n.acc = LIM.acc
    and not exists ( select 1 from prvn_flow_deals_const  where nd = d.nd and acc8 = LIM.acc)
    and nvl( substr( PRVN_FLOW.get_nls_b ( d.nd, 'SS ') ,5,1),'*')  <> '9'     ;

  l_rowcnt := SQL%ROWCOUNT;

  if ( l_rowcnt > 0 )
  then
    bars_audit.info( title||': КП 2.3 '||to_char(l_rowcnt)||' row created.');
  end if;

  /*
   Добавки от Билецкого
   здесь договора. которых нет в ХД. но они должны быть. Причины
   1) Были изначально не загружены
   2) Появились и закрылись в период между двумя сеансами работы процедуры ADD1 - донапонления  prvn_flow_deals_const
      например. последнее состояние от 01-09-2015. а сегодня уже надо 01-10-2015
   3) для избежания этого рекомендуем процедуру донаполнения запускать ежедневно на старте дня (l_dat01 := gl.bdate)
  */

  --
  -- Add nonexistent contracts (МБК)
  --
  insert into PRVN_FLOW_DEALS_CONST
    ( id, nd, acc, dat_add, vidd, rnk, sdate, wdate, kv )
  select bars_sqnc.get_nextval('PRVN_FLOWDEALS')
       , d.nd, ad.accs, sysdate, d.vidd, d.rnk, d.sdate, NVL(p.fdat, d.wdate) as WDATE, ad.kv
    from CC_DEAL d
    join CC_ADD ad       on ( d.nd = ad.nd and ad.adds = 0 )
    left
    join CC_PROL  p      on ( p.nd = d.nd and p.npp = 0 )
    join ND_ACC   n      on ( n.nd = d.nd )
    join ACCOUNTS a      on ( a.acc = n.acc )
    left
    join SNAP_BALANCES b on ( b.acc = n.acc and b.FDAT = l_dat31 )
  where d.vidd > 1500 and d.vidd < 1600
    and d.sos  < 15
    and a.tip = 'SS'
    and b.acc is not null
    and not exists ( select 1 from PRVN_FLOW_DEALS_CONST where nd = d.nd and acc = ad.accs );

  l_rowcnt := SQL%ROWCOUNT;

  if ( l_rowcnt > 0 )
  then
    bars_audit.info( title||': КП 2.3 '||to_char(l_rowcnt)||' row created.');
  end if;

  bars_audit.trace( '%s: Exit.', title );

end add1;

-----------------------------------------
-- Построение ден.потоков по требованию
--
procedure add2 ( p_mode int, p_id number, p_dat01 date, p_zo int  ) IS   -- Построение ден.потоков по требованию
  l_dat31     date;
  l_dat01     date;
  sd_         date:= gl.bdate;
  l_first_dt  date; -- дата початку звітного періоду
  l_fla       int := 0;
  l_fl_nd_acc int := 0;
  dd          cc_deal%rowtype;
  xx          prvn_flow_deals_var%rowtype;
  tt          TEST_MANY_CCK%rowtype  ;
  SUM_SS      number;  Sum_k  number ;  nd1_  number := -1 ;
  SUM_SS1     number;  Sum_k1 number ;  kv1_  number := -1 ;
  l_zo        int := nvl(p_zo,1) ;
  l_IRR       number ;
  l_IR        number ;
  l_ost       number ;   Q_ost number ;
  l_DAZS      date;
  G_SD1       PRVN_FLOW_DEALS_VAR.SD1%type; -- проц.доход
  G_SD2       PRVN_FLOW_DEALS_VAR.SD2%type; -- амортиз доход
  G_SNA       PRVN_FLOW_DEALS_VAR.SNA%type;

  procedure SD1
  ( dd         cc_deal%rowtype
  , p_dat01    date
  , p_k1       number
  , p_acc      number
  , p_kv       number
  , p_zo       int
  , p_SD1  OUT PRVN_FLOW_DEALS_VAR.SD1%type
  , p_SD2  OUT PRVN_FLOW_DEALS_VAR.SD2%type
  , p_SNA  OUT PRVN_FLOW_DEALS_VAR.SNA%type
  ) is
    G_DATE01   date;
    G_DATE31   date;
    sd1_       number;
    dStop_     date;
  begin
    G_DATE31 := p_dat01 - 1 ;
    G_DATE01 := trunc(G_DATE31,'Y')  ;
    p_SD1 := 0;
    p_SD2 := 0;
    p_SNA := 0;
    for k in ( select a.acc, a.tip from accounts a, nd_acc n
               where n.nd=dd.nd and n.acc=a.acc
                 and a.tip in ('SDI','SPI','SNA','SP ','SS ') and kv = p_kv )
    loop
      If k.tip in ('SP ','SS ')
      then
        begin
           select least ( nvl( STP_DAT, G_DATE31) , G_DATE31)
             into dStop_ from int_accn where id = 0 and acc= k.acc;
           acrn.p_int ( k.acc, 0, G_DATE01, dStop_, sd1_, null, 0 );
           P_SD1 := P_SD1 + sd1_ ;
        exception
          when no_data_found then   null;
        end;

       ElsIf k.tip = 'SNA'            then p_SNA := p_SNA + prvn_flow.qst_12(k.acc,p_dat01,'1',p_zo) ;
       Else                                p_SD2 := P_SD2 + prvn_flow.QDK_12(0, k.acc, G_DATE01,G_DATE31, null,'1',p_zo) ;
       end if;
    end loop;
    P_SD1 := - round ( P_SD1 * p_k1, 0 ) ; -- проц.доход от всех сч.тел = сумма расчетных %%
    p_SD2 :=   round ( P_SD2 * p_k1, 0 ) ; -- амортизационный доход     = Сумма деб оборотов
    p_SNA :=   round ( p_SNA * p_k1, 0 ) ; -- непризнанный доход        = сальдо счета

  end SD1;

begin

  if p_dat01 is null
  then l_dat01 := to_date(pul.get_mas_ini_val('sFdat1'), 'dd.mm.yyyy');
  else l_dat01 := p_dat01 ;
  end if;

  if to_char(l_dat01 , 'DD' ) <> '01'   then -- 14.05.2015 Сухова. Пока работаем только с числами 01. Остатки с корр
    raise_application_error( -20333,gl.aMfo||':Пока работаем только с числами 01. Ост с корр');
  end if;

  select max(fdat)   into l_dat31  from fdat    where fdat < l_dat01 ;
--l_fl_nd_acc := prvn_flow.G_nd_acc(l_DAT01); -- 1 берем с архива . 0  нет
  l_fl_nd_acc := 0 ;
  if l_dat01 <= sd_ and to_char(l_dat01,'dd')= '01' then  l_fla := 1; end if ; -- брать из архива

--1500 сделано по МБК.
  if p_mode in ( 1500, 0 )
  then

   DELETE FROM TEST_MANY_CCK WHERE  dat = l_dat01 AND ID = GL.AuID;
   z23.mbk_many(p_dat   => l_dat01,   p_modez => 0    );

   for x in (select id, acc, nd, kv from prvn_flow_deals_const  where vidd > 1500 and vidd < 1600 and (id=p_id or nvl(p_id,0)=0 ) )
   loop l_irr := null ;
        l_ir  := null ;
      begin select * into dd from cc_deal where nd = x.nd;
            select * into tt from TEST_MANY_CCK where nd=x.nd and irr0 > 0 and irr0 < 100 AND dat = l_dat01 AND ID = GL.AuID ;
      exception when no_data_found then   null;
      end ;
      l_IRR := NVL(tt.irr0, dd.IR);
      l_IR  :=  acrn.fprocn(x.acc, 0, l_dat31) ;
      l_ost := - fost( x.acc, l_dat31) ;
      Q_ost := gl.p_icurval(x.kv, l_ost, l_dat31) ;

      -- Расчетные проц.доходы + аморт.даходы + sna
      SD1 ( dd, l_dat01, 1, x.acc , x.kv, l_zo, G_SD1, G_SD2, G_SNA );
      delete from prvn_flow_deals_var where id = x.id  and zdat =l_dat01;
      insert into prvn_flow_deals_var
                (id,   zdat,  ost, ost8,  ir,irr0 ,   wdate,    vidd,    RNK, OSTQ,OST8Q,  ZO,K,K1,   pv,   BV,  sd1,  sd2,  sna )
      values ( x.id,l_dat01,l_ost,l_ost,l_ir,l_irr,dd.wdate, dd.vidd, dd.RNK,Q_ost,Q_ost,l_zo,1, 1,tt.PV,tt.BV,G_SD1,G_SD2,G_SNA );

   end loop;

  delete from prvn_flow_details D
    where (d.id=p_id or nvl(p_id,0)=0) and mdat= l_dat01
      and exists (select 1 from test_many_mbk where nd=D.nd);

  insert into prvn_flow_details  ( MDAT,  ND,   ID,   FDAT,  SS, SPD, SN, SK )
  select l_dat01, m.nd, d.id, m.fdat, m.s, 0, m.s1, 0
    from TEST_MANY_MBK m, PRVN_FLOW_DEALS_CONST d,  PRVN_FLOW_DEALS_VAR   v
   where ( d.id = p_id or nvl(p_id,0) = 0)  and d.nd = m.nd        and v.id = d.id
     and v.zdat = l_dat01                   and v.wdate >= v.zdat  and m.FDAT  >= v.zdat;

end if;

-- КП ЮЛ + КП ФЛ
  if p_mode in (20, 22, 0 )
  then

    l_first_dt := add_months(l_dat01,-1);

    for x0 in ( select * from prvn_flow_deals_const
                where (id=p_id or nvl(p_id,0)=0)
                  and ( vidd in ( 1, 2, 3) and p_mode in (20,0)
                     or vidd in (11,12,13) and p_mode in (22,0) )
              order by nd, kv, id )
   loop
     delete from prvn_flow_deals_var  where id = x0.id  and zdat = l_dat01 ;  -- заголовки
     delete from prvn_flow_details    where id = x0.id  and mdat = l_dat01 ;  -- детали
     begin
       select dazs into l_DAZS              -- Вопрос: когда прекратить обработку  суб/дог ?
         from accounts where acc = x0.acc8; -- Ответ : КД ЗАКРЫТ ПО ВСЕМ СВОИМ ТРАНШАМ !!!!

        If l_DAZS is not null then
          update PRVN_FLOW_DEALS_CONST  set DATE_CLOSE = l_DAZS where id = x0.id;
          If l_dazs < trunc(l_dat31, 'MM' ) then goto NOT_;  end if;
        end if;
      exception when no_data_found then  goto NOT_ ;
      end;

      select * into dd  from cc_deal  where nd = x0.nd;
      --------------------------------------------------
      If x0.wdate <> dd.wdate       then        Xx.wdate := dd.wdate ;
      else                                      Xx.wdate := x0.wdate ;
      end if;

      xx.irr0  := acrn.fprocn(x0.acc8,-2,l_dat31) ;
      xx.ost8  := - prvn_flow.qst_12(x0.acc8, l_dat01, null, l_ZO);
      xx.ost8q := gl.p_icurval( x0.kv8, xx.ost8,l_dat31 );

      If x0.acc is null
      then
        xx.ost  := 0;
        xx.ostq := 0;
        xx.k    := 1;
        xx.k1   := 1;
        xx.ir   := acrn.fprocn(x0.acc8,0,l_dat31);
      else
        xx.ost  := - prvn_flow.qst_12(x0.acc,l_dat01,'2',l_ZO);
        xx.ostq := gl.p_icurval(x0.kv, xx.ost,l_dat31 );
        xx.ir   := acrn.fprocn(x0.acc, 0,l_dat31);

        If nd1_  <> x0.nd
        then
          sum_k := 0; -- обнуление
           select sum( gl.p_icurval( a.kv, - prvn_flow.qst_12( a.acc, l_dat01, a.nbs, l_zo ), l_dat31 ) )
             into SUM_SS
             from accounts a, nd_acc n
            where n.nd = x0.ND -- залишок тіла по К.Д. (в цілому)
              and n.acc= a.acc and nbs like '2%'
              and ( a.tip in ( 'SS '       ) and x0.tip =  'SS ' or
                    a.tip in ( 'SP ','SL ' ) and x0.tip <> 'SS ' );
           SUM_SS := nvl( SUM_SS,0 ) ;
         end if;

         If sum_k  < 1 then
            if SUM_SS = 0
            then xx.k := 1;
            else xx.k := least( 1-sum_k , xx.ostq/SUM_SS );
            end if;
            sum_k   := sum_k + xx.k;
         else  xx.k := 0;
         end if ;

         If nd1_  <> x0.nd OR kv1_  <> x0.kv
         then
           sum_k1 := 0; -- обнуление
           select sum ( - prvn_flow.qst_12( a.acc, l_dat01, a.nbs, l_zo ) )
             into SUM_SS1
             from accounts a, nd_acc n
            where n.nd = x0.nd and a.kv = x0.kv -- залишок тіла по К.Д. (по валюті)
              and n.acc= a.acc and nbs like '2%'
              and ( a.tip in ( 'SS '       ) and x0.tip =  'SS '
                 or a.tip in ( 'SP ','SL ' ) and x0.tip <> 'SS ' );
           SUM_SS1 := nvl( SUM_SS1, 0);
         end if;

         If sum_k1 < 1 then
           if SUM_SS1 = 0
           then xx.k1 := 1;
           else xx.k1 := least( 1-sum_k1, xx.ost /SUM_SS1);
           end if;
           sum_k1 :=  sum_k1 + xx.k1;
         else
           xx.k1 := 0;
         end if ;
         nd1_   := x0.nd ;
         kv1_   := x0.kv ;

         If x0.tip <> 'SS ' then               xx.ost := 0 ;  xx.ostq := 0 ;             end if ;
      end if;

      -- заголовки (переменная часть)
      xx.vidd := dd.vidd ;
      xx.rnk  := dd.rnk  ;

      -- Расчетные проц.доходы + аморт.даходы + sna
      SD1 ( dd, l_dat01, xx.k1, x0.acc , x0.kv, l_zo, G_SD1 , G_SD2, G_SNA ) ;

      insert
        into PRVN_FLOW_DEALS_VAR
           ( SD1, SD2, SNA, ID, ZDAT, OST, OST8, OSTQ, OST8Q, K1, K, IR, IRR0, WDATE, VIDD, RNK, I_CR9, PR_TR )
      select G_SD1, G_SD2, G_SNA, x0.id,l_dat01,xx.ost,xx.ost8,xx.ostq,xx.ost8q,xx.k1,xx.k,xx.ir,xx.irr0,xx.wdate,xx.vidd,xx.rnk,
             (select txt from nd_txt where nd = dd.nd and tag  = 'I_CR9'),
             (select txt from nd_txt where nd = dd.nd and tag  = 'PR_TR')
      from dual ;

--    if xx.k + xx.k1 > 0
--    then -- детали
--      prvn_flow.add2_ss ( x0, xx, l_dat31, l_dat01, l_fla, l_fl_nd_acc, l_ZO ) ;
--    end if;

      <<NOT_>> null;

    end loop;

  end if;

end add2;

  ------------------
  --  Построение ден.потоков по КП по SS
  procedure ADD2_SS
  ( x0          prvn_flow_deals_const%rowtype,
    xx          prvn_flow_deals_var%rowtype,
    p_dat31     date,
    p_dat01     date,
    p_fla       int ,
    p_fl_nd_acc int,
    p_zo        int
  ) IS -- Построение ден.потоков по КП
    l_ss    number;  l_lim number;      l_snz number   ; t_ss number  ; t_d_plan date; t_fdat date  ; l_k2 int     ;
    t_dat01 date  ;  l_pv0 number;      l_pv number    ; Fl2_   int   ; l_ir number  ; l_Datp date  ; psn_ int     ;
    tmp     many  ;  d8    varchar2(8); d9 varchar2(8) ; fdat_ date   ; lim1_ number ; sumg_ number ; lim2_ number ;
    l_sd    number;  l_s0  number;      l_ki  number   ; l_sno number ; l_spn number ; l_sdi number ; l_sn  number ;
    l_cr9   number;  l_sn8 number;      l_sk0 number   ; l_sk9 number ; l_s36 number ; l_sp  number ;
    l_ZO    int   := NVL(p_ZO, 1);
    ii      int_accn%rowtype;
    k1      sys_refcursor;
    k2      sys_refcursor;
    ----------------------------------------------------------------------------------------------------
    F_Cust  number(1); -- = 3 розница. Потоки НЕ формировать ! = 2 Корп  Потоки Формировать !
    l_rcvb  number(1);
begin

  --
  if ( BARS_LOSS_EVENTS.G_RECEIVABLES )
  then l_rcvb := 1;
  else l_rcvb := 0;
  end if;

  if x0.acc is null
  then  goto NOT_LIM1 ;
  end if ;

  If    nvl( xx.vidd , x0.vidd ) in ( 1, 2, 3) then F_Cust := 2;
  ElsIf nvl( xx.vidd , x0.vidd ) in (11,12,13) then F_Cust := 3;
  Else                                              F_Cust := 1;
  end if;

  l_ss  := xx.ost;
  l_lim := l_ss;
  --------------------------------------------
  If pul.Get_Mas_Ini_Val('sFdat1') = 'DEL_PV'
  then null ;
  ElsIf ( F_Cust = 3 and individuals_shd = 0 )
  then GOTO End_FLOW_1;
  end if ;
  --------------------------------------------
  begin
    select acra, basey, greatest ( (x0.daos-1),  nvl(acr_dat, (x0.daos-1) ) )
      into ii.acra, ii.basey, ii.acr_dat from int_accn where acc = x0.acc and id = 0 ;
  exception
    when no_data_found then null;
  end;

  If ii.acr_dat > p_dat01 then
    select nvl( max(int_date), ii.acr_dat) into ii.acr_dat from ACR_DOCS where  acc = x0.acc and id = 0 and int_date < p_dat01;
  end if;

  tmp.delete;

  l_datp := p_dat31;

  -- разметим даты: Для Всех КД (Даты), для НЕ-траншей: снижение лимита и расчетное погашение. Здесь еще никаких процентов пока нет
  if p_fla=1
  then open k1 for select greatest(fdat,p_dat01),  round(sumg*xx.k,0), not_sn
                     from cc_lim_arc where mdat=p_dat01 and nd=x0.nd and fdat>p_dat31
                    order by fdat ; -- уже из архива ГПК
  else open k1 for select greatest(fdat,p_dat01), round(sumg*xx.k,0), not_sn
                     from cc_lim     where                  nd=x0.nd and fdat>p_dat31
                    order by fdat ; -- прямо из ГПК
  end if;

  if not k1%isopen then return; end if;

  loop

    fetch k1 into fdat_, sumg_, psn_;

    exit when k1%notfound;

    -- приведем вал.КД к вал счета
    if x0.kv <> x0.kv8
    then
      if x0.kv8<>gl.baseval then sumg_:= gl.p_icurval(x0.kv8, sumg_, p_dat31); end if;
      if x0.kv <>gl.baseval then sumg_:= gl.p_ncurval(x0.kv , sumg_, p_dat31); end if;
    end if;

    -- сделаем расчет в переменные
    if x0.pr_tr = 1
    then
      lim1_ := 0;
      sumg_ := 0;
      lim2_ := 0;
    else
      lim1_:= l_lim ;
      if fdat_ >= xx.wdate
      then sumg_ := l_lim;               lim2_ := 0;
      else sumg_ := least (sumg_, l_ss); lim2_ := lim1_ - sumg_ ;
      end if;
    end if;

    -- Запомним в табл даты из CC_lim (arc)
    d8 := to_char(fdat_,'yyyymmdd');
    tmp(d8).fdat := fdat_   ;
    tmp(d8).sn   := 1 - nvl(psn_, 0) ;
    tmp(d8).lim1 := lim1_   ;
    tmp(d8).lim2 := lim2_   ;
    tmp(d8).ss   := sumg_   ;

    if lim2_ < 0 then
       sumg_ := sumg_ + lim2_;
       lim2_ := 0 ;
    end if;

    -- Даты из графика изм % ставок
    for r in (select * from int_ratn where bdat >= l_Datp and bdat < fdat_ and id = 0 and acc = x0.acc )
    loop
      d9 := to_char(r.bdat, 'yyyymmdd');
      if not tmp.exists(d9)
      then
          tmp(d9).fdat := r.bdat ;
          tmp(d9).ss   := 0 ;
          tmp(d9).sn   := 0 ;
          tmp(d9).lim2 := lim1_;
          tmp(d9).lim1 := lim1_;
       end if;
    end loop;

    Fl2_ := nvl(x0.fl2,1)   ; -----  Fl2_ = 0   --Это проц по пред МЕСЯЦ !!
    ------------------------------------- вставка 01 числа (если надо
    t_dat01 := trunc (fdat_, 'MM');
    if to_char (l_datp ,'yyyymm') <> to_char ( fdat_, 'yyyymm') and t_dat01  < fdat_
    then
       d8 := to_char(t_dat01,'yyyymmdd') ;
       tmp(d8).fdat := t_dat01 ;
       tmp(d8).ss   := 0 ;
       tmp(d8).sn   := 0 ;
       tmp(d8).lim2 := lim1_;
       tmp(d8).lim1 := lim1_;
    end if;

    -- для след.записи
    l_lim  := lim2_ ;

    if x0.pr_tr = 1
    then null;
    else
      if l_lim <= 0 then exit; end if;
    end if;

    l_datp := tmp(d8).fdat ;

  end loop;

  close k1;

  ----------------------------------------------
  -- Для ТРАНШЕЙ  :
  if x0.pr_tr = 1
  then

    begin
      select 1 into l_k2 from CC_TRANS_ARC  where acc = x0.acc and MDAT = p_dat01 and rownum = 1;
    exception
      when no_data_found then l_k2 := 0 ;
    end;

    if l_k2 = 1
    then open k2 for select d_plan, fdat, sv - nvl(sz,0) ss from  CC_TRANS_ARC
                      where fdat <= p_dat31 and acc=x0.acc and (sv-nvl(sz,0))>0 and MDAT= p_dat01
                      order by d_plan ; -- уже из архива траншей
    else open k2 for select d_plan, fdat, sv - nvl(sz,0) ss from cc_trans
                      where fdat <= p_dat31 and acc=x0.acc and (sv-nvl(sz,0))>0
                      order by d_plan ; -- прямо из траншей
    end if;

    loop

      fetch  k2 into t_d_plan, t_fdat, t_ss ;

      exit when k2%notfound;

      If t_d_plan <= p_dat31 then  t_d_plan :=  xx.wdate ; end if  ;

      if t_d_plan < t_fdat then  d8 := to_char(fdat_   , 'yyyymmdd');  -- просрочка =  посл.дата
      else                       d8 := to_char(t_d_plan, 'yyyymmdd');
         if not tmp.exists(d8) then tmp(d8).ss :=              t_ss ; tmp(d8).fdat := t_d_plan ;
         else                       tmp(d8).ss := tmp(d8).ss + t_ss ;
         end if;
      end if;
    end loop;

  end if;
  -------------------------------------- счета-одиночки  типа просроченных и отложенных нач %%
  <<NOT_LIM1>> null;
  -----------------
  -- на всякий случай - вставка последней даты

  If xx.wdate>p_dat31
  then
     d8 :=  to_char(xx.wdate,'yyyymmdd');
     if not tmp.exists(d8) then
        tmp(d8).fdat := xx.wdate; tmp(d8).sn := 1; tmp(d8).lim1 := 0; tmp(d8).lim2 := 0 ; tmp(d8).ss := 0 ;
     end if;
  else
     d8 := to_char(p_dat01 ,'yyyymmdd' );
     if not tmp.exists(d8) then
        tmp(d8).fdat := p_dat01 ; tmp(d8).sn := 0; tmp(d8).lim1 := 0; tmp(d8).lim2 := 0 ; tmp(d8).ss := 0 ;
     end if;
  end if ;
  ----------------------
  << End_FLOW_1>> null ;
  ----------------------
  l_sn  := 0 ; -- SN *   IS 'Нараховані відсотки';
  l_sno := 0 ; -- SNO*   IS 'Нараховані та відкладені відсотки';
  l_spn := 0 ; -- SPN*   IS 'Простроч.нарах відсотки';
  l_sdi := 0 ; -- SDI*   IS 'Дисконт/Премія';
  l_cr9 := 0 ; -- CR9    IS 'Невикористаний ліміт';
  l_sn8 := 0 ; -- SN8    IS 'Пеня';
  l_sk0 := 0 ; -- SK0    IS 'Нарахована комісія';
  l_sk9 := 0 ; -- SK9    IS 'простроч Нарахована комісія';
  l_s36 := 0 ; -- S36    IS 'Дох.майбутніх періодів';
  l_sp  := 0 ; -- SP     IS 'Просрочка

  If xx.k > 0 or xx.k1 > 0
  then

    for k in ( select a.acc
                    , a.ostc as OST
                    , CASE WHEN a.tip = 'SL '  THEN 'SP '
                           WHEN a.tip = 'SLN'  THEN 'SPN'
                           WHEN a.tip = 'SLK'  THEN 'SK9'
                           WHEN a.tip = 'SPI'  THEN 'SDI'
                           WHEN a.nbs = '3600' THEN 'S36'
                           WHEN a.tip = 'OFR'  THEN 'SK9' -- "ліва" фін.дебіторка (прострочений борг)
                           WHEN a.tip = 'ODB'  THEN 'SK0' -- "ліва" фін.дебіторка (нормальний   борг)
                           ELSE a.tip
                      END as TIP
                    , CASE WHEN a.mdate  > p_dat31 THEN a.mdate
                           WHEN xx.wdate > p_dat31 THEN xx.wdate
                           ELSE                         p_dat01
                      END as MDATE
                    , a.nbs
                    , a.kv
                    , a.nls
                 from accounts a
                 join ( select ACC
                          from ND_ACC
                         where 0  = p_fl_nd_acc
                           and ND = x0.nd
                         union all
                        select ACC
                          from ND_ACC_ARC
                         where 1    = p_fl_nd_acc
                           and MDAT = p_dat01
                           and ND   = x0.nd
                      ) n
                   on ( n.ACC = a.ACC )
                where ( a.nbs like '2%' and a.tip in ('SPN','SLN','SNO','SDI','SPI','SN ','SP ','SL ' ) and kv = NVL(x0.kv, a.kv)
                   OR   a.nbs like '9%' and a.tip in ('CR9')
                   OR   a.nbs like '3%' and a.tip in ('SK0','SK9','ODB', 'OFR') and l_rcvb = 0
                   OR   a.nbs like '8%' and a.tip in ('SN8','SLK','SLK')
                   OR   a.nbs = '3600' and ob22 = (CASE WHEN x0.vidd < 11  THEN '09' ELSE  '10' END ) -- для Корпор.Бизн 3600 с ОБ22 09, а для РБ - 3600 с ОБ22 10
                      )
             )
    loop

      If p_fla = 1
      then  --- из архива ( из снимков )
        If k.nbs like '8%' or k.nbs is null
        then k.ost := fost ( k.acc, p_dat31) ;
        else k.ost := prvn_flow.qst_12 ( k.acc, p_dat01, k.nbs, l_ZO );
        end if ;
        k.ost := nvl( k.ost,0 ) ;
      end if ;

      If    x0.kv = k.kv or x0.kv is null
      then  null;
      ElsIf x0.kv = gl.baseval then  k.ost := gl.p_Icurval( k.kv, k.ost, p_dat31 );
      ElsIf  k.kv = gl.baseval then  k.ost := gl.p_Ncurval(x0.kv, k.ost, p_dat31 );
      else                           k.ost := gl.p_Ncurval(x0.kv,gl.p_Icurval(k.kv, k.ost, p_dat31 ), p_dat31 );
      end if ;

      If k.tip in ('CR9','SN8','SK0','SK9','S36')
      then k.ost := round ( k.ost * xx.k , 0 );
      else k.ost := round ( k.ost * xx.k1, 0 );
      end if ;

      if k.ost <> 0
      then
          If    k.tip  in ('SDI')    then   l_sdi := l_sdi - k.ost;
          ElsIf k.tip  in ('CR9')    then   l_cr9 := l_cr9 - k.ost;
          ElsIf k.tip  in ('SN8')    then   l_sn8 := l_sn8 - k.ost;
          ElsIf k.tip  in ('SK0')    then   l_sk0 := l_sk0 - k.ost;
          ElsIf k.tip  in ('SK9')    then   l_sk9 := l_sk9 - k.ost;
          ElsIf k.tip  in ('S36')    then   l_s36 := l_s36 - k.ost;
          ----------------------------------------------------------------
          ElsIf k.tip  in ('SN '      )    then   l_sn  := l_sn  - k.ost;
          ElsIf k.tip  in ('SPN','SNO', 'SP ')
          then

             if    k.tip in ('SPN') then   l_spn := l_spn - k.ost ;
             elsif k.tip in ('SNO') then   l_sno := l_sno - k.ost ;
             elsif k.tip in ('SP ') then   l_sp  := l_sp  - k.ost ;
             end if;

             If ( F_Cust = 3 and individuals_shd = 0 )
             then
               null;
             else
                d8  := to_char(k.mdate,'yyyymmdd') ;
                if not tmp.exists(d8) then
                       tmp(d8).fdat := k.mdate ;
                       tmp(d8).ss  := 0        ;
                       tmp(d8).sp  := 0        ;
                       tmp(d8).sn  := 0        ;
                       tmp(d8).spn := 0        ;
                       tmp(d8).sno := 0        ;
                end if;
                if    k.tip in ('SPN') then   tmp(d8).spn := nvl(tmp(d8).spn,0) - k.ost ;
                elsif k.tip in ('SNO') then   tmp(d8).sno := nvl(tmp(d8).sno,0) - k.ost ;
                elsif k.tip in ('SP ') then   tmp(d8).sp  := nvl(tmp(d8).sp ,0) - k.ost ;
                end if;
             end if;
          end if;
       end if ;
    end loop ;
  end if; -- xx.k >0

  l_snz := nvl(l_sn, 0);

  if x0.acc is null
  then
    goto NOT_LIM2;
  end if ;

  --------------------------------------------------
  If ( F_Cust = 3 and individuals_shd = 0 )
  then
    goto End_FLOW_2;
  end if ;

  -- пересчет процентов
  declare
    l_snD number := 0 ; -- проц за 1 период
    l_snM number := 0 ; -- проц за 1 кал мес
    l_snU number := 0 ; -- проц за 1 пл.период
    l_SnI number := 0 ; -- проц на норм тело итого
    l_SpI number := 0 ; -- проц на просроч тело итого
    y_datp date  := p_dat01 ; d_Dat1 date := null    ; d_Dat2 date    ;
  begin
   -- 1. расчет на ВСЕ даты таблицы
   d8 := tmp.first   ; -- установить курсор на  первую запись - Для начисления
   d9 := tmp.first   ; -- установить курсор на  первую запись - Для уплаты

   while d8 is not null loop  -- d8 = Курсор по начислению

      if x0.pr_tr = 1 then   -- Снижение лимита для Траншей
         tmp(d8).lim1 := l_ss ;  tmp(d8).ss   := nvl(tmp(d8).ss, 0);  tmp(d8).lim2 := tmp(d8).lim1 - tmp(d8).ss;   l_ss := tmp(d8).lim2 ;
      end if;

      if tmp(d8).lim2 < 0
      then  -- Лимит не может быть отрицательным
        tmp(d8).lim2 := 0    ;  tmp(d8).ss   := tmp(d8).lim1 ;
      end if;

      tmp(d8).ir := acrn.fprocn ( x0.acc, 0, (tmp(d8).fdat -1) );
      l_snD  := calp_nr ( tmp(d8).lim1, tmp(d8).ir, y_datp, (tmp(d8).fdat -1), ii.basey ) ;
      l_SnI  := l_SnI + l_snD ; -- проц на норм тело итого
      y_datp := tmp(d8).fdat  ;

      if FL2_ = 1  then    --Это проц по пред День !!
         l_snU := l_snU  + l_snD ;
      end if;

      ---------------- поймали пл.лату по процентам
      if tmp(d8).sn  = 1 then
         tmp(d8).sn := l_sn ;  l_sn := 0 ;
         while d9 is not null loop  -- d9 = Курсор по уплате
            If tmp(d9).fdat >tmp(d8).fdat then
               EXIT ;
            end if;

            if FL2_ = 0  and to_char( tmp(d9).fdat,'DD') = '01'            OR       --Это проц по пред МЕСЯЦ !!
               Fl2_ = 1  and          tmp(d9).fdat       =  tmp(d8).fdat  then      -- Это проц по пред день

               -- выложить строку
               d_Dat2  := tmp(d9).fdat -1   ;  tmp(d8).dat2 := d_Dat2 ;
               if FL2_  = 1 and  d_dat1 is null   then    --Это проц по пред День !!
                  d_dat1 := p_dat01 ;
               end if;
               tmp(d8).dat1 := d_dat1 ;
               tmp(d8).sn1 := l_snU ;
               l_snU  := 0  ;
               l_SnI       := l_SnI - tmp(d8).sn1 ;
               -- проц за просроч тело
               if l_sp > 0 then
                  tmp(d8).sn2 := calp_nr ( l_sp, xx.ir , NVL(d_dat1,p_dat01), d_Dat2, ii.basey)   ;
                  l_SpI       := l_SpI - tmp(d8).sn2;
               end if ;
               -- приготовыть Для след строки
               d_dat1 := d_Dat2 + 1;
               d9     := tmp.next(d9) ; -- установить курсор на след.вниз запись
               EXIT   ;
            else
               d9     := tmp.next(d9) ; -- установить курсор на след.вниз запись
            end if    ;
         end loop     ;
      end if          ;
      -----------------------------
      if FL2_ = 0  then    --Это проц по пред МЕСЯЦ !!
         l_snM := l_snM  + l_snD ;
         If to_char( tmp(d8).fdat,'DD') = '01' then
            l_snU := l_snU + l_snM;
            l_snM := 0 ;
         end if;
      end if;

     --для след записи
     d8 := tmp.next(d8)   ; -- установить курсор на след.вниз запись

   end loop;

   -- обработка последнего периода
   d8     := tmp.last; -- установить курсор на последнюю запись
   d_Dat2 := (tmp(d8).fdat -1 );
   --- ---- ---- ---
   l_spI  := l_spI  +  calp_nr ( l_sp, xx.ir, p_dat01, d_dat2, ii.basey ) ;
   tmp(d8).sn1  := nvl(tmp(d8).sn1,0) + l_snI  ; -- последний период и балансировка разницы округ норм
   tmp(d8).sn2  := nvl(tmp(d8).sn2,0) + l_spI  ; -- последний период и балансировка разницы округ проср
   tmp(d8).sn   := nvl(tmp(d8).sn ,0) + l_sn   ;
   tmp(d8).dat1 := nvl(tmp(d8).dat1,  d_Dat1 ) ;
   tmp(d8).dat2 := d_Dat2 ;
   tmp(d8).ss   := tmp(d8).lim1;
   tmp(d8).lim2 := 0 ;

end;
 -------------------
 <<NOT_LIM2>> null ;
 ----------------------- Выгрузка в табл и расчет PV + PV0
 l_pv := 0  ; l_pv0 := 0; l_ki := 1 + nvl( xx.irr0, xx.ir ) / 100;
 d8   := tmp.first      ; -- установить курсор на  первую запись
 while d8 is not null loop
   tmp(d8).ss   := nvl( tmp(d8).ss  ,0 );
   tmp(d8).sn   := nvl( tmp(d8).sn  ,0 );
   tmp(d8).spn  := nvl( tmp(d8).spn ,0 );
   tmp(d8).sno  := nvl( tmp(d8).sno ,0 );
   tmp(d8).lim1 := nvl( tmp(d8).lim1,0 );
   tmp(d8).lim2 := nvl( tmp(d8).lim2,0 );
   tmp(d8).sp   := nvl( tmp(d8).sp  ,0 );
   tmp(d8).sn1  := nvl( tmp(d8).sn1 ,0 );
   tmp(d8).sn2  := nvl( tmp(d8).sn2 ,0 );
   ---------------------------------------
If tmp(d8).ss  <> 0 OR tmp(d8).sn  <> 0 OR tmp(d8).lim1 <> 0 OR tmp(d8).lim2 <> 0 or
   tmp(d8).spn <> 0 OR tmp(d8).sno <> 0 OR tmp(d8).sp   <> 0 OR tmp(d8).sn1  <> 0 OR tmp(d8).sn2 <> 0 then

   insert into prvn_flow_details (mdat,fdat,ss,spd,sn,sk,lim1,lim2, dat1, dat2, spn, sno, sp, sn1, sn2, nd,id , IR)
     values ( p_dat01, tmp(d8).fdat, tmp(d8).ss, 0, tmp(d8).sn, 0, tmp(d8).lim1, tmp(d8).lim2, tmp(d8).dat1, tmp(d8).dat2,
              tmp(d8).spn, tmp(d8).sno, tmp(d8).sp , tmp(d8).sn1, tmp(d8).sn2, x0.nd ,x0.id ,  tmp(d8).ir );
End If;

   if tmp(d8).fdat >=  p_dat01
   then
     l_s0  := round( tmp(d8).ss + tmp(d8).sp + tmp(d8).sn + tmp(d8).sn1 + tmp(d8).sn2 + tmp(d8).spn + tmp(d8).sno , 0 ) ;
     l_pv0 := l_pv0  + l_s0 ;  -- просто сумма потока

     If l_ki >= 1 and l_ki <=2
     then l_sd := round  ( l_s0 / power( l_ki, (tmp(d8).fdat - p_dat01 )/365 ),0) ;
     else l_sd := 0;
     end if;

     l_pv  := l_pv   + l_sd  ; -- сумма дисконтированного потока

   end if;
   d8   := tmp.next(d8); -- установить курсор на след.вниз запись
 end loop;
 --------------------
 <<End_FLOW_2>> null;
 --------------------
 update prvn_flow_deals_var
     set pv   = l_pv ,
         pv0  = l_pv0,
         sno  = l_sno,
         spn  = l_spn,
         sdi  = l_sdi,
         sn   = l_snz,
         cr9  = l_cr9, -- IS Невикористаний ліміт
         sn8  = l_sn8, -- IS Пеня
         sk0  = l_sk0, -- IS Нарахована комісія
         sk9  = l_sk9, -- IS простроч Нарахована комісія
         sp   = l_sp , -- IS просрочка
         s36  = l_s36, -- IS Дох.майбутніх періодів
         s36U = CASE WHEN (OST + l_sno + l_spn + l_sdi + l_snz + l_sp + l_s36) < 0  THEN 0  ELSE  l_s36   END ,
         zo   = l_ZO ,
         bv   = (  nvl(OST,0) + l_snz + l_spn + l_sno +l_sdi  +l_sp )
---------------------  SS         SN      SPN     SNO  SPI+SDI   SP
    where id = x0.id  and zdat = p_dat01 ;

end add2_ss;

--- получение дельты PV по дате реструктуризации
function f_del_pv(p_id number,
                  p_rdat date ) return number is
  befo_dat date   ;
  befo_ir  number ;
  befo_pv  number ;
  afte_dat date   ;
  afte_ir  number ;
  afte_pv  number ;
  l_id     number := abs(p_id);
  l_DEL    number ;

  l_befo_count int;
  l_afte_count int;

begin

   -- ищем максим дату ДО рестр по таб заголов PRVN_FLOW_DEALS_VAR
   select  max(Zdat)   into   befo_dat    from PRVN_FLOW_DEALS_VAR  where id = L_id and Zdat < p_rdat+1;
   if befo_dat is null then return 0; end if;

   -- ищем минималн дату ПОСЛЕ по таб заголов. PRVN_FLOW_DEALS_VAR
   select  min(Zdat)    into  afte_dat    from PRVN_FLOW_DEALS_VAR  where id = L_id and Zdat > p_rdat  ;
   if afte_dat is null then return 0; end if;

   -- ищеи Эф Проц Ставку по таблице заголовк. PRVN_FLOW_DEALS_VAR  на максим дату ДО рестр = befo_dat
   select 1+nvl(irr0,ir)/100 into befo_ir from PRVN_FLOW_DEALS_VAR  where id = L_id     and zdat = befo_dat;

   afte_ir:= befo_ir;

-- 30.12.2015 Sta При расчете дельты PV если нет потоков в табл prvn_flow_details (напр для ФЛ). то строим их принудительно

   select Nvl ( Sum (decode (mdat, befo_dat, 1, 0) ), 0 ),
          Nvl ( Sum (decode (mdat, befo_dat, 0, 1) ), 0 )
   into    l_befo_count ,  l_afte_count
   from prvn_flow_details  where id = L_id and mdat in ( befo_dat, afte_dat ) ;

   If l_befo_count = 0 then PUL.Set_Mas_Ini( 'DEL_PV', 'DEL_PV', 'DEL_PV' );  PRVN_FLOW.ADD2  ( 0, l_id,  befo_dat, 1 ) ; end if ;
   If l_afte_count = 0 then PUL.Set_Mas_Ini( 'DEL_PV', 'DEL_PV', 'DEL_PV' );  PRVN_FLOW.ADD2  ( 0, l_id,  afte_dat, 1 ) ; end if ;
   ------------------------------------------------------------------------------
   select nvl( sum(
                    ( nvl(ss ,0) + --- Норм.Тіло SS
                      nvl(spd,0) + --- Диск/Преммія
                      nvl(sn ,0) + --- Нар.Відсотки SN
                      nvl(sk ,0) + --- Комісія
                      nvl(spn,0) + --- Прос.Відсотки SPN
                      nvl(sno,0) + --- Відклад.Відсотки
                      nvl(sp ,0) + --- Простр.Тіло SP
                      nvl(SN1,0) + --- Розрах.Відсотки на SS
                      nvl(SN2,0)   --- Розрах.Відсотки на SP
                    ) / power ( befo_ir, (fdat-afte_dat)/365)
                  ),0)
   into befo_pv from prvn_flow_details   where id = L_id  and mdat  = befo_dat and fdat >= afte_dat;

   select nvl( sum(
                    ( nvl(ss ,0) + --- Норм.Тіло SS
                      nvl(spd,0) + --- Диск/Преммія
                      nvl(sn ,0) + --- Нар.Відсотки SN
                      nvl(sk ,0) + --- Комісія
                      nvl(spn,0) + --- Прос.Відсотки SPN
                      nvl(sno,0) + --- Відклад.Відсотки
                      nvl(sp ,0) + --- Простр.Тіло SP
                      nvl(SN1,0) + --- Розрах.Відсотки на SS
                      nvl(SN2,0)   --- Розрах.Відсотки на SP
                    ) / power ( afte_ir, (fdat-afte_dat)/365)
                  ),0)
   into afte_pv from prvn_flow_details   where id = L_id  and mdat  = afte_dat and fdat >= afte_dat;

   L_DEL := afte_pv - befo_pv ; -- абсолютная дельта  PV
   L_DEL := round ( DIV0( L_DEL, befo_pv), 2 ) ;  ---- дельта  PV в проц.отношении

   return ( L_DEL ) ;

end f_del_pv;

----------------------------------------
function Get_nls_b  (p_nd number, p_tip accounts.tip%type )
return varchar2
is --- получение номера лиц.счета
begin
  for k in (select a.kv|| '/' || a.nls NLS from accounts a, nd_acc n where n.nd = p_nd and n.acc = a.acc and a.tip = p_tip
            order by decode ( dazs , null, 1,2 ) , a.acc desc   )
   loop  return  k.NLS ;   end loop; return null;
end Get_nls_b;
----------------------------------------------------------------------------
function G_nd_acc  (p_DAT01 DATE ) return INT IS  --- =1- ND_ACC_arc берем с архива , = 0  нет, БЕРЕМ ПРЯМО ИЗ nd_acc
  l_fl int := 0 ;
  l_dat01 date  ;
begin
    if p_dat01 is null then l_dat01 := to_date(pul.get_mas_ini_val('sFdat1'), 'dd.mm.yyyy') ;
    else                    l_dat01 := p_dat01  ;
    end if;

    if l_dat01 is NOT null then
       begin select 1 into l_fl from nd_acc_arc where MDAT = l_dat01  and rownum = 1;
       exception when no_data_found then null;
       end;
    end if;
    return l_fl ;
end G_nd_acc;

---- Для изменений во вюшке-гляделке но НОСТРО (по счетам !)------------------------------------
procedure nos_ins (p_kv int, p_nls varchar2)
is
  dd1    cc_deal%rowtype;
  wdate_ date := to_date('31/12/2050','dd/mm/yyyy');
  aa1    accounts%rowtype;
begin

  begin
    select * into aa1 from accounts where kv =p_kv and nls = p_nls;
  exception
    when no_data_found then   raise_application_error( -20333,gl.aMfo||':Рах.'||p_nls ||'/'|| p_kv || ' НЕ знайдено ');
  end;

  begin
    select d.* into dd1 from cc_deal d, nd_acc n where d.vidd = 150 and n.acc= aa1.acc and d.nd = n.nd ;
    raise_application_error( -20333,gl.aMfo||':Рах.'||p_nls ||'/'|| p_kv || ' уже прив"язан до угоди ' || dd1.nd);
  exception
    when no_data_found then   null;
  end;

  dd1.nd := bars_sqnc.get_nextval('S_CC_DEAL');

  begin
    select max(d.ndi) into dd1.ndi from cc_deal d, nd_acc n, accounts a where d.vidd = 150 and d.nd = n.nd and n.acc= a.acc and a.nls = p_nls  ;
  exception
    when no_data_found then dd1.ndi := dd1.nd ;
  end;

  insert into cc_deal (rnk, ndi, nd, CC_ID, SDATE, WDATE, LIMIT, SOS, IR, BRANCH, PROD, vidd )
  values (aa1.rnk, dd1.ndi, dd1.nd,  p_nls||'/'||p_kv, aa1.daos, nvl(aa1.mdate,wdate_), 0, 10, acrn.fprocn(aa1.acc,0,gl.bdate), aa1.branch, aa1.nbs||aa1.ob22, 150);

  insert into nd_acc (nd, acc) values (dd1.nd, aa1.acc);

end nos_ins;

-------------
procedure nos_upd (p_nd    number, p_sos   int, p_CC_ID varchar2, p_SDATE date, p_WDATE   date , p_LIMIT number,
                   p_FIN23 int   , p_OBS23 int, p_KAT23 int     , p_pd    int , p_FIN_351 int  )  is
begin
  update cc_deal set sos   = p_sos  , cc_id = p_cc_id, SDATE = p_sdate, WDATE   = p_wdate, limit = p_limit, fin23 = p_FIN23,
                     obs23 = p_OBS23, kat23 = p_KAT23, pd    = p_pd   , FIN_351 = p_FIN_351
  where nd=p_nd and vidd = 150;
end nos_upd;

-------------
procedure nos_del (p_nd number) is
begin
  delete from nd_acc  where nd = p_nd and nd in (select nd from cc_deal where vidd = 150) ;
  delete from cc_deal where nd = p_nd and vidd = 150 ;
end nos_del;

  --
  --
  --
  procedure CLN_FIN_DEB
  ( p_chg_dt    in     prvn_fin_deb_arch.CHG_DT%type
  , p_cls_dt    in     prvn_fin_deb_arch.cls_dt%type
  ) is
  /**
  <b>CLN_FIN_DEB</b> - Перенесення в архів даних таблиці PRVN_FIN_DEB
  %param

  %version 2.0
  %usage   Перенесення в архів записів з таблиці PRVN_FIN_DEB у випадку невідповідності довіднику FIN_DEBT ( по R020+OB22 ).
  */
    type t_del_type is table of prvn_fin_deb%rowtype;
    t_del_rows      t_del_type;
  begin

    bars_audit.trace( $$PLSQL_UNIT||'.CLN_FIN_DEB: Entry.' );

    insert
      into PRVN_FIN_DEB_ARCH
         ( CHG_ID, CHG_DT, CLS_DT, KF, ACC_SS, ACC_SP, EFFECTDATE, AGRM_ID )
    select S_PRVN_FIN_DEB_ARCH.NextVal, p_chg_dt, p_cls_dt
         , KF, ACC_SS, ACC_SP, EFFECTDATE, AGRM_ID
      from ( select unique t.KF, t.ACC_SS, t.ACC_SP, t.EFFECTDATE, t.AGRM_ID
               from ( select fd.ACC_SS
                           , fd.ACC_SP
                           , fd.KF
                           , fd.EFFECTDATE
                           , fd.AGRM_ID
                           , an.BRANCH       as BRANCH_SS
                           , ap.BRANCH       as BRANCH_SP
                           , an.NBS||an.OB22 as R020_OB22_SS
                           , ap.NBS||ap.OB22 as R020_OB22_SP
                           , an.DAZS         as CLS_DT_SS
                           , ap.DAZS         as CLS_DT_SP
                        from PRVN_FIN_DEB  fd
                        join ACCOUNTS an
                          on ( an.ACC = fd.ACC_SS )
                        left outer -- для перевірки на наявність значення R020_OB22_SS в FIN_DEBT.NBS_N
                        join ACCOUNTS ap
                          on ( ap.ACC = fd.ACC_SP )
                       where fd.ACC_SS <> fd.ACC_SP -- не перевіряємо якщо рах. SS = SP
                         and an.TIP    <> 'SK0'
                         and ap.TIP    <> 'SK9'
                    ) t
               left outer
               join FIN_DEBT d
                 on ( d.NBS_N = t.R020_OB22_SS )
              where d.NBS_N Is Null
                 or lnnvl( d.NBS_P = t.R020_OB22_SP ) -- do not match the dictionary
                 or t.CLS_DT_SS Is Not Null
                 or t.CLS_DT_SP Is Not Null
           )
    ;

    bars_audit.info( $$PLSQL_UNIT||'.CLN_FIN_DEB: '||to_char(sql%rowcount)||' rows created.' );

    delete PRVN_FIN_DEB
     where ( ACC_SS, ACC_SP ) in ( select ACC_SS, ACC_SP
                                     from PRVN_FIN_DEB_ARCH
                                    where CLS_DT = p_cls_dt );

    bars_audit.info( $$PLSQL_UNIT||'.CLN_FIN_DEB: '||to_char(sql%rowcount)||' rows deleted.' );

--  delete PRVN_FIN_DEB
--   where ( ACC_SS, ACC_SP ) in ( select t.ACC_SS, t.ACC_SP
----                                    , t.R020_SS, t.OB22_SS, t.R020_OB22_SS
----                                    , t.R020_SP, t.OB22_SP, t.R020_OB22_SP
----                                    , d.NBS_N, d.NBS_P, d.MOD_ABS
--                                   from ( select fd.ACC_SS
--                                               , fd.ACC_SP
--                                               , fd.KF
--                                               , fd.EFFECTDATE
--                                               , fd.AGRM_ID
--                                               , an.NBS          as R020_SS
--                                               , an.OB22         as OB22_SS
--                                               , an.BRANCH       as BRANCH_SS
--                                               , ap.NBS          as R020_SP
--                                               , ap.OB22         as OB22_SP
--                                               , ap.BRANCH       as BRANCH_SP
--                                               , an.NBS||an.OB22 as R020_OB22_SS
--                                               , ap.NBS||ap.OB22 as R020_OB22_SP
--                                            from PRVN_FIN_DEB  fd
--                                            join ACCOUNTS an
--                                              on ( an.ACC = fd.ACC_SS )
--                                            join ACCOUNTS ap
--                                              on ( ap.ACC = fd.ACC_SP )
--                                           where fd.ACC_SS <> fd.ACC_SP
--                                             and an.TIP    <> 'SK0'
--                                             and ap.TIP    <> 'SK9'
--                                        ) t
--                                      , FIN_DEBT d
--                                  where ( t.R020_OB22_SS = d.NBS_N and t.R020_OB22_SP <> d.NBS_P )
--                                     or ( t.R020_OB22_SP = d.NBS_P and t.R020_OB22_SS <> d.NBS_N )
--                                  -- or ( t.BRANCH_SS <> t.BRANCH_SP )
--                               )
--  RETURN ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID
--    BULK COLLECT
--    INTO t_del_rows
--  ;
--
--  if ( t_del_rows.count > 0 )
--  then
--
--    bars_audit.info( $$PLSQL_UNIT||'.CLN_FIN_DEB: t_del_rows.count='||to_char(t_del_rows.count) );
--
--    forall r in t_del_rows.first .. t_del_rows.last
--    insert
--    into PRVN_FIN_DEB_ARCH
--       ( CHG_ID, CHG_DT, CLS_DT, KF, ACC_SS, ACC_SP, EFFECTDATE, AGRM_ID )
--    values
--       ( S_PRVN_FIN_DEB_ARCH.NextVal, p_chg_dt, p_cls_dt
--       , t_del_rows(r).KF, t_del_rows(r).ACC_SS, t_del_rows(r).ACC_SP
--       , t_del_rows(r).EFFECTDATE, t_del_rows(r).AGRM_ID );
--
--  end if;

    bars_audit.trace( $$PLSQL_UNIT||'.CLN_FIN_DEB: Exit.' );

  end CLN_FIN_DEB;

  ---
  -- ADD_FIN_DEB
  ---
  procedure ADD_FIN_DEB
  ( p_dat       in     date
  ) is
    title   constant   varchar2(64) := $$PLSQL_UNIT||'.ADD_FIN_DEB';
    l_eff_dt           date;
    l_kf               varchar2(6) := sys_context('bars_context','user_mfo');
    l_chg_dt           prvn_fin_deb_arch.chg_dt%type;
    l_cls_dt           prvn_fin_deb_arch.cls_dt%type;
    l_err_tag          varchar2(40) := l_kf||'_'||to_char(p_dat,'yyyymmdd')||'_'||to_char(sysdate,'yyyymmddhh24miss');

    cursor err_log_SS is
           select e.ROWID                         as RID
                , cast( e.ACC_SS as number(24) )  as ACC_SS
                , cast( e.ACC_SP as number(24) )  as ACC_SP
                , cast( e.EFFECTDATE as date )    as EFFECTDATE
                , cast( e.KF as varchar2(6) )     as KF
                , cast( e.AGRM_ID as number(38) ) as AGRM_ID
                , e.ORA_ERR_OPTYP$                as OP_TYP
                , d.ROWID                         as FD_RID
                , d.ACC_SS                        as FD_ACC_SS
                , d.ACC_SP                        as FD_ACC_SP
                , d.EFFECTDATE                    as FD_EFFECTDATE
                , d.AGRM_ID                       as FD_AGRM_ID
             from bars.PRVN_FIN_DEB_ERRLOG e
             left join bars.PRVN_FIN_DEB d on (e.ACC_SS = d.ACC_SS and e.KF = d.KF)
            where e.ORA_ERR_TAG$ like l_err_tag||'%'
              and e.ORA_ERR_OPTYP$ = 'I'
              and e.ORA_ERR_MESG$ like '%UK_PRVNFINDEB_ACCSS%'
              and e.KF = l_kf
              for update;
    fd                 err_log_SS%rowtype;

    cursor err_log_SP is
           select e.ROWID                         as RID
                , cast( e.ACC_SS as number(24) )  as ACC_SS
                , cast( e.ACC_SP as number(24) )  as ACC_SP
                , cast( e.EFFECTDATE as date )    as EFFECTDATE
                , cast( e.KF as varchar2(6) )     as KF
                , cast( e.AGRM_ID as number(38) ) as AGRM_ID
                , e.ORA_ERR_OPTYP$                as OP_TYP
                , d.ROWID                         as FD_RID
                , d.ACC_SS                        as FD_ACC_SS
                , d.ACC_SP                        as FD_ACC_SP
                , d.EFFECTDATE                    as FD_EFFECTDATE
                , d.AGRM_ID                       as FD_AGRM_ID
             from bars.PRVN_FIN_DEB_ERRLOG e
             left join bars.PRVN_FIN_DEB d on (decode(e.ACC_SP, d.ACC_SP, 1, 0) = 1 and e.KF = d.KF)
            where e.ORA_ERR_TAG$ like l_err_tag||'%'
              and e.ORA_ERR_MESG$ like '%UK_PRVNFINDEB_ACCSP%'
              and e.KF = l_kf
              for update;
    r_sp       err_log_SP%rowtype;

  begin

    bars_audit.trace( '%s: Entry with ( p_dat=%s, l_kf=%s ).', title, to_char(p_dat,'dd.mm.yyyy'), l_kf );

--  execute immediate q'[alter session set NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss']';

    l_eff_dt  := nvl(to_date(sys_context('bars_gl','bankdate'),'mm/dd/yyyy'),trunc(sysdate));

    l_chg_dt := sysdate;
    l_cls_dt := GL.BD();

    -- "закриття" зв`язку рахунків
    CLN_FIN_DEB( p_chg_dt => l_chg_dt
               , p_cls_dt => l_cls_dt );

    if ( BARS_LOSS_EVENTS.G_RECEIVABLES )
    then

      bars_audit.info( title || ': BARS_LOSS_EVENTS.G_RECEIVABLES = TRUE' );

      -- clear old errors --
      --delete PRVN_FIN_DEB_ERRLOG
      -- where kf = l_kf; --ORA_ERR_TAG$ like '%'||l_kf||'%';

      bars_audit.info( title || ': '||to_char(sql%rowcount)||' row(s) deleted.' );

      -- Рах. фін. деб. кредитних договорів ('SK0','SK9')
      insert
        into bars.PRVN_FIN_DEB
           ( ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID )
      select nvl(ACC_SS, ACC_SP) as ACC_SS
           , ACC_SP
           , l_eff_dt
           , KF
           , ND
        from ( select r.KF, r.ND
                    , a.ACC, a.TIP, a.KV
                 from bars.ND_ACC   r
                 join bars.ACCOUNTS a
                   on ( r.KF = a.KF and r.ACC = a.ACC )
                 left
                 join bars.PRVN_FIN_DEB d
                   --on ( d.AGRM_ID = r.ND )
                   on ( d.KF = r.KF and d.AGRM_ID = r.ND and r.ACC = any(d.ACC_SS, d.ACC_SP)) --V.Kharin --иначе AGRM_ID может пересечся с БПК
                where a.TIP in ('SK0','SK9')
                  and a.NBS like '3%'
                  and a.DAOS <= p_dat
                  and ( a.DAZS is Null or a.DAZS > p_dat )
                  and d.AGRM_ID IS Null
             ) pivot ( max(ACC) for TIP in ( 'SK0' as ACC_SS, 'SK9' as ACC_SP ) )
         log errors
        into bars.PRVN_FIN_DEB_ERRLOG( l_err_tag||'_CCK' )
      REJECT LIMIT UNLIMITED;

      bars_audit.info( title || ': CCK (SK0+SK9) '||to_char(sql%rowcount)||' row(s) inserted.' );

      -- Рах. фін. деб. Кредитних Договорів ('ODB')
      merge
        into bars.PRVN_FIN_DEB d
       using ( select nvl(ACC_SS,ACC_SP) as ACC_SS
                    , ACC_SP
                    , KF
                    , ND
                 from ( select r.KF
                             , r.ND
                             , a.ACC
                             , t.ROW_NUM
                             , t.ACC_TP
                             , dense_rank() over ( partition by a.NBS, a.OB22, r.ND order by r.ACC ) as ACC_RANK
                          from bars.ND_ACC   r
                          join bars.ACCOUNTS a
                            on ( r.KF = a.KF and r.ACC = a.ACC )
                          left
                          join bars.PRVN_FIN_DEB d
                            on ( d.KF = r.KF and d.AGRM_ID = r.ND and r.ACC = any(d.ACC_SS, d.ACC_SS) )
                          join ( with NBSOB22 as ( select rownum as ROW_NUM
                                                        , NBS_N, NBS_P
                                                        , SubStr(NBS_N,1,4) as SS_NBS
                                                        , SubStr(NBS_N,5,2) as SS_OB22
                                                        , SubStr(NBS_P,1,4) as SP_NBS
                                                        , SubStr(NBS_P,5,2) as SP_OB22
                                                     from bars.FIN_DEBT
                                                    where NBS_N Like '3%'
                                                 )
                                 select ROW_NUM
                                      , 'SS'    as ACC_TP
                                      , SS_NBS  as R020
                                      , SS_OB22 as OB22
                                   from NBSOB22
                                  union
                                 select ROW_NUM
                                      , 'SP' as ACC_TP
                                      , SP_NBS
                                      , SP_OB22
                                   from NBSOB22
                                  where NBS_P Is Not Null
                               ) t
                            on ( t.R020 = a.NBS and t.OB22 = a.OB22 )
                         where a.TIP not in ('SK0','SK9')
                           and a.NBS like '3%'
                           and a.DAOS <= p_dat
                           and lnnvl( a.DAZS <= p_dat )
                           and d.AGRM_ID IS Null
                      ) pivot ( max(ACC) for ACC_TP in ( 'SS' as ACC_SS, 'SP' as ACC_SP ) )
             ) t
          on ( t.ACC_SS = d.ACC_SS )
        when MATCHED
        then update -- зявився рахунок прострочки
                set d.ACC_SP     = t.ACC_SP
                  , d.AGRM_ID    = t.ND
                  , d.EFFECTDATE = l_eff_dt
              where d.ACC_SP  = d.ACC_SS
        when NOT MATCHED
        then insert ( ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID )
             values ( t.ACC_SS, t.ACC_SP, l_eff_dt, t.KF, t.ND )
         log errors
        into bars.PRVN_FIN_DEB_ERRLOG( l_err_tag||'_CCK' )
         REJECT LIMIT UNLIMITED;

      bars_audit.info( title || ': CCK (ODB) '||to_char(sql%rowcount)||' row(s) merged.' );

      -- Рах. фін. деб. БПК
      insert
        into bars.PRVN_FIN_DEB
           ( ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID )
      select ACC_SS, ACC_SP, l_eff_dt, KF, ND
        from ( select w4.ACC_SS, w4.ACC_SP, w4.KF, w4.ND
                 from ( select nvl(ACC_3570,ACC_3579) as ACC_SS
                             , ACC_3579               as ACC_SP
                             , KF, ND
                          from bars.W4_ACC
                         where coalesce( ACC_3570, ACC_3579, 0 ) > 0
                           and DAT_CLOSE Is Null
                         union all
                        select nvl(ACC_3570,ACC_3579) as ACC_SS
                             , ACC_3579               as ACC_SP
                             , KF, ND
                          from bars.BPK_ACC
                         where coalesce( ACC_3570, ACC_3579, 0 ) > 0
                           and DAT_CLOSE Is Null
                      ) w4
                 join bars.ACCOUNTS an
                   on ( an.KF = w4.KF and an.ACC = w4.ACC_SS )
                 left
                 join bars.ACCOUNTS ap
                   on ( ap.KF = w4.KF and ap.ACC = w4.ACC_SP )
                 where an.DAZS is Null
                    or ap.DAZS is Null
             )
       minus
      select ACC_SS, ACC_SP, l_eff_dt, KF, AGRM_ID
        from bars.PRVN_FIN_DEB
       where AGRM_ID is not null
         log errors into bars.PRVN_FIN_DEB_ERRLOG( l_err_tag||'_BPK' ) REJECT LIMIT UNLIMITED;

      bars_audit.info( title || ': BPK '||to_char(sql%rowcount)||' row(s) inserted.' );

      -- Рах. фін. деб. БПК Instolment
      merge into bars.PRVN_FIN_DEB d
      using (
               with
                NBSOB22 as ( select rownum as ROW_NUM
                                  , NBS_N, NBS_P
                                  , SubStr(NBS_N,1,4) as SS_NBS
                                  , SubStr(NBS_N,5,2) as SS_OB22
                                  , SubStr(NBS_P,1,4) as SP_NBS
                                  , SubStr(NBS_P,5,2) as SP_OB22
                               from bars.FIN_DEBT
                              where MOD_ABS = 9 ), 
                  FDEBT as ( select ROW_NUM, 'SS' as ACC_TP, SS_NBS as R020, SS_OB22 as OB22 from NBSOB22
                              union
                             select ROW_NUM, 'SP' as ACC_TP, SP_NBS as R020, SP_OB22 as OB22 from NBSOB22 where NBS_P Is Not Null )
               select coalesce(fn.ACC_SS, fn.ACC_SP) as ACC_SS
                    , fn.ACC_SP
                    , fn.KF
                    , fn.CHAIN_IDT as AGRM_ID
                 from ( select f.KF, f.ACC, f.CHAIN_IDT, f.ACC_TP, f.ROW_NUM, f.ACC_RANK
                          from ( select ac.KF, ac.ACC, ac.CHAIN_IDT, a.NBS, a.OB22, fdebt.ACC_TP, fdebt.ROW_NUM,
                                        dense_rank() over ( partition by ac.CHAIN_IDT, fdebt.ACC_TP, fdebt.ROW_NUM order by ac.acc ) as ACC_RANK
                                   from bars.W4_ACC_INST ac
                                   join bars.ACCOUNTS    a  on ( ac.KF = a.KF and ac.ACC = a.ACC )
                                   join fdebt               on ( a.NBS = fdebt.R020 and a.OB22 = fdebt.OB22 )
                                  where a.DAOS <= p_dat
                                    and lnnvl( a.DAZS <= p_dat )
                                    --and a.TIP in ('IK0','IK9')
                               ) f
                      ) pivot ( max(ACC) for ACC_TP in ( 'SS' as ACC_SS, 'SP' as ACC_SP ) ) fn
                 left join bars.PRVN_FIN_DEB fd  on (  fd.KF = fn.KF and
                                                       fd.AGRM_ID = fn.CHAIN_IDT and
                                                       fd.ACC_SS = coalesce(fn.ACC_SS, fn.ACC_SP) and
                                                       decode(fd.ACC_SP, fn.ACC_SP, 1, 0) = 1)
                where fd.ACC_SS is null
            ) t on ( t.ACC_SS = d.ACC_SS ) -- and t.AGRM_ID = d.AGRM_ID)
       when MATCHED then
            update -- зявився або пропав рахунок прострочки
               set d.ACC_SP  = t.ACC_SP
                 , d.EFFECTDATE = l_eff_dt
                 , d.AGRM_ID = t.AGRM_ID
       when NOT MATCHED then
            insert ( ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID )
            values ( t.ACC_SS, t.ACC_SP, l_eff_dt, t.KF, t.AGRM_ID )
       log errors into bars.PRVN_FIN_DEB_ERRLOG( l_err_tag||'_INS' ) REJECT LIMIT UNLIMITED;

      bars_audit.info( title || ': INS '||to_char(sql%rowcount)||' row(s) inserted.' );

      ----------------------------------------
      -- parsing errors UK_PRVNFINDEB_ACCSS --
      open err_log_SS;
      loop
        fetch err_log_SS into fd;
        exit when err_log_SS%NOTFOUND;
        savepoint SP_ERRLOG_SS;

        begin
          -- 1) delete from PRVN_FIN_DEB for ACC_SS
             delete bars.PRVN_FIN_DEB
              where ACC_SS = fd.ACC_SS
                 or (acc_ss = fd.ACC_SP and acc_ss = acc_sp);

          -- 2) insert into ...
             insert into bars.PRVN_FIN_DEB ( ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID )
              values ( fd.ACC_SS, fd.ACC_SP, fd.EFFECTDATE, fd.KF, fd.AGRM_ID );

             if fd.FD_ACC_SS is not null then
               insert into bars.PRVN_FIN_DEB_ARCH ( CHG_ID, CHG_DT, CLS_DT, KF, ACC_SS, ACC_SP, EFFECTDATE, AGRM_ID )
                 values ( S_PRVN_FIN_DEB_ARCH.NextVal, l_chg_dt, l_cls_dt, fd.KF, fd.FD_ACC_SS, fd.FD_ACC_SP, fd.FD_EFFECTDATE, fd.FD_AGRM_ID );
             end if;

          -- 3) delete from PRVN_FIN_DEB_ERRLOG ( where current of )
             delete bars.PRVN_FIN_DEB_ERRLOG
              where ROWID = fd.RID;
              ---where current of err_log_SS;

        exception
          when OTHERS then
--           bars_audit.error(title || ' SS' ||': ACC_SS='||to_char(fd.ACC_SS)||': ACC_SP='||to_char(fd.ACC_SP)||':'||sqlerrm);
           bars_audit.error(title || ' SS' ||':SS='||to_char(fd.ACC_SS)||':SP='||to_char(fd.ACC_SP)||':'||sqlerrm);
           rollback to SP_ERRLOG_SS;
        end;
      end loop;

      bars_audit.info( title || ': err_log_SS '||err_log_SS%ROWCOUNT||' row(s) processed.' );

      close err_log_SS;
      -- parsing errors UK_PRVNFINDEB_ACCSS --
      ----------------------------------------

      ----------------------------------------
      -- parsing errors UK_PRVNFINDEB_ACCSP --
      open err_log_SP;
      loop
        fetch err_log_SP into r_sp;
        exit when err_log_SP%NOTFOUND;
        savepoint SP_ERRLOG_SP;

        begin
          -- 1) delete from PRVN_FIN_DEB for ACC_SP duplicate
             delete bars.PRVN_FIN_DEB 
              where (r_sp.FD_RID is not null and ROWID  = r_sp.FD_RID)  -- аналогично ACC_SP = r_sp.ACC_SP но по ROWID
                 or ACC_SS = r_sp.ACC_SS;                               -- удаление по SS нужно в случае ошибки update при merge

          -- 2) insert into ...
             insert into bars.PRVN_FIN_DEB ( ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID )
              values ( r_sp.ACC_SS, r_sp.ACC_SP, r_sp.EFFECTDATE, r_sp.KF, r_sp.AGRM_ID );
             if r_sp.FD_ACC_SS is not null then
               insert into bars.PRVN_FIN_DEB_ARCH ( CHG_ID, CHG_DT, CLS_DT, KF, ACC_SS, ACC_SP, EFFECTDATE, AGRM_ID )
                 values ( S_PRVN_FIN_DEB_ARCH.NextVal, l_chg_dt, l_cls_dt, r_sp.KF, r_sp.FD_ACC_SS, r_sp.FD_ACC_SP, r_sp.FD_EFFECTDATE, r_sp.FD_AGRM_ID );
             end if;

          -- 3) delete from PRVN_FIN_DEB_ERRLOG ( where current of )
             delete bars.PRVN_FIN_DEB_ERRLOG
              where ROWID = r_sp.RID;
              --where current of err_log_SP;

        exception
          when OTHERS then
--           bars_audit.error(title || ' SS' ||': ACC_SS='||to_char(r_sp.ACC_SS)||': ACC_SP='||to_char(r_sp.ACC_SP)||':'||sqlerrm);
           bars_audit.error(title || ' SP' ||':SS='||to_char(r_sp.ACC_SS)||':SP='||to_char(r_sp.ACC_SP)||':'||sqlerrm);
           rollback to SP_ERRLOG_SP;
        end;
      end loop;

      bars_audit.info( title || ': err_log_SP '||err_log_SP%ROWCOUNT||' row(s) processed.' );

      close err_log_SP;
      -- parsing errors UK_PRVNFINDEB_ACCSP --
      ----------------------------------------

      -- all ACC_SS
      insert
        into PRVN_FIN_DEB
           ( ACC_SS, EFFECTDATE, KF )
      select a.ACC, l_eff_dt, a.KF
        from ACCOUNTS a
        join ( select SubStr(NBS_N,1,4) as R020
                    , SubStr(NBS_N,5,2) as OB22
                 from FIN_DEBT
             ) t
          on ( t.R020 = a.NBS and t.OB22 = a.OB22 )
        left
        join PRVN_FIN_DEB d
          on ( d.ACC_SS = a.ACC )
       where a.DAZS is Null
         and d.ACC_SS Is Null;

      bars_audit.info( title || ': ACC '||to_char(sql%rowcount)||' row(s) inserted.' );

    else

      bars_audit.info( title || ': BARS_LOSS_EVENTS.G_RECEIVABLES = FALSE' );

    end if;

    for k in ( select a.KF, a.RNK, a.NBS, a.OB22, a.ACC as ACC_SP, a.KV, a.DAOS, a.BRANCH
                    , SubStr(NBS_N,1,4) as SS_NBS
                    , SubStr(NBS_N,5,2) as SS_OB22
                    , f.MOD_ABS
                 from ACCOUNTS a
                 join FIN_DEBT f
                   on ( a.NBS = SubStr(NBS_P,1,4) and a.OB22 = SubStr(NBS_P,5,2) )
                 left
                 join PRVN_FIN_DEB p
                   on ( p.ACC_SP = a.ACC )
                where f.MOD_ABS in ( 0, 1, 4, 5, 6 )
                  and lnnvl( p.ACC_SP <> p.ACC_SS ) -- p.ACC_SP Is Null or p.ACC_SP = p.ACC_SS
              )
    loop

      fd := null;

      -- подбор по модулям и по РНК + ВАЛ
      begin
        if ( k.MOD_ABS = 4 )
        then -- 4 - Абонплата КДИ
          select a.KF, a.ACC
            into fd.KF, fd.ACC_SS
            from ACCOUNTS a
           where a.RNK  = k.RNK
             and a.KV   = k.KV
             and a.NBS  = k.SS_NBS
             and a.OB22 = k.SS_OB22
             and (a.dazs is null or a.dazs> p_dat)
             and not exists (select 1 from PRVN_FIN_DEB where acc_SS = a.acc)
             and exists ( select 1 from e_deal where acc36 = a.acc and accd = k.acc_SP)
             and rownum = 1;
        elsIf ( k.MOD_ABS = 5 )
        then -- 5 - РКО (Женя Суфтин)
          select a.KF, a.ACC
            into fd.KF, fd.ACC_SS
            from ACCOUNTS a
           where a.RNK  = k.RNK
             and a.KV   = k.KV
             and a.NBS  = k.SS_NBS
             and a.OB22 = k.SS_OB22
             and (a.dazs is null or a.dazs> p_dat)
             and not exists (select 1 from PRVN_FIN_DEB where acc_SS = a.acc)
             and exists ( select 1 from rko_lst where acc1 = a.acc and acc2 = k.acc_SP)
             and rownum = 1;
         end if;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          null;
      end;

      -- подбор только по РНК + ВАЛ + БРАНЧ
      If ( fd.ACC_SS is null )
      then
        begin
          select a.KF, a.ACC
            into fd.KF, fd.ACC_SS
            from ACCOUNTS a
           where a.RNK    = k.RNK
             and a.KV     = k.KV
             and a.NBS    = k.SS_NBS
             and a.OB22   = k.SS_OB22
             and a.BRANCH = k.BRANCH
             and a.DAOS  <= k.DAOS
             and (a.dazs is null or a.dazs > p_dat)
             and not exists (select 1 from PRVN_FIN_DEB where ACC_SS = a.ACC)
             and rownum = 1;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            fd.KF     := k.KF;
            fd.ACC_SS := k.ACC_SP;
        end;
      end if;

      If ( fd.ACC_SS is not null )
      then

        fd.EFFECTDATE := l_eff_dt;
        fd.ACC_SP     := k.ACC_SP;

        begin
--          insert into PRVN_FIN_DEB (ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID)
--            values (fd.ACC_SS, fd.ACC_SP, fd.EFFECTDATE, fd.KF, fd.AGRM_ID);
          merge into bars.PRVN_FIN_DEB d
          using ( select fd.ACC_SS as ACC_SS, fd.ACC_SP as ACC_SP, fd.EFFECTDATE as EFFECTDATE, fd.KF as KF, fd.AGRM_ID as AGRM_ID from dual
                ) t on ( t.ACC_SS = d.ACC_SS )
           when MATCHED then
                update -- зявився або пропав рахунок прострочки
                   set d.ACC_SP  = t.ACC_SP
                     , d.EFFECTDATE = t.EFFECTDATE
                     , d.AGRM_ID = t.AGRM_ID
                where decode(d.ACC_SP,  t.ACC_SP,  1, 0) = 0
                   or decode(d.AGRM_ID, t.AGRM_ID, 1, 0) = 0
           when NOT MATCHED then
                insert ( ACC_SS, ACC_SP, EFFECTDATE, KF, AGRM_ID )
                values ( t.ACC_SS, t.ACC_SP, t.EFFECTDATE, t.KF, t.AGRM_ID );

           exception
        when OTHERS then
           bars_audit.error( title ||':SS='||to_char(fd.ACC_SS)||':SP='||to_char(fd.ACC_SP)||':MOD_ABS='||k.MOD_ABS||':'||sqlerrm );
        end;

      Else
        Null; -- BAD
      end if;

    end loop;
    bars_audit.info( title || ': FINISH' );

  end ADD_FIN_DEB;

  --
  --
  --
  function GET_CROSS_RATE
  ( p_ccy_id_1         tabval$global.kv%type
  , p_ccy_id_2         tabval$global.kv%type
  , p_bnk_dt           date
  ) return number
  deterministic
  result_cache
  is
    l_cross_rate       number;
    l_branch           varchar2(8);
  begin

    l_branch := substr( sys_context('bars_context','user_branch'), 1, 8 );

    select t1.RATE/t2.RATE
      into l_cross_rate
      from ( select KV          as CCY_ID
                  , RATE_O/BSUM as RATE
               from CUR_RATES$BASE
              where ( BRANCH, VDATE, KV ) in ( select BRANCH, max(VDATE), KV
                                                 from CUR_RATES$BASE
                                                where VDATE <= p_bnk_dt
                                                  and BRANCH = l_branch
                                                  and KV     = p_ccy_id_1
                                                group by BRANCH, KV )
           ) t1
     cross
      join ( select KV          as CCY_ID
                  , RATE_O/BSUM as RATE
               from CUR_RATES$BASE
              where ( BRANCH, VDATE, KV ) in ( select BRANCH, max(VDATE), KV
                                                 from CUR_RATES$BASE
                                                where VDATE <= p_bnk_dt
                                                  and BRANCH = l_branch
                                                  and KV     = p_ccy_id_2
                                                group by BRANCH, KV )
           ) t2
    ;

    RETURN l_cross_rate;

  end GET_CROSS_RATE;

  --
  -- for all deal ( NEW )
  --
  function GET_ADJ_SHD
  ( p_cur              prvn_flow.c_cur_type
  , p_rpt_dt           date
  , p_adj_f            signtype
  ) return t_shd_type
--parallel_enable ( partition p_cur by HASH ND )
  pipelined
  is
    title   constant   varchar2(64) := $$PLSQL_UNIT||'.GET_ADJ_SHD';

    type r_sno_type is record ( rpt_dt        date
                              , amnt          number(24)
                              );

    type t_sno_type is table of r_sno_type;

    type r_sar_type is record ( sar_id        number(38)  -- ід.
                              , sar_ccy_id    number(3)   -- валюта траншу КД
                              , sar_rate      number(6,3) -- відсоткова ставка
                              , sar_fine      number(6,3) -- відсоткова ставка
                              , gen_ccy_dbt   number(24)  --
                              , dbt           number(24)  -- SS
                              , dbt_odue      number(24)  -- SP
                              , int           number(24)  -- SN
                              , int_odue      number(24)  -- SPN
                              , int_dfr       number(24)  -- SNO
                              , sno_shd       t_sno_type  --
                              , cumulat_SN    number(38,5)-- для накопления суммы %% SN
                              , cumulat_SPN   number(38,5)-- для накопления суммы %% SPN
                              );

    type t_sar_type is table of r_sar_type;

    type r_gen_type is record ( gen_id        number(38) -- ід. КД
                              , gen_ccy_id    number(3)  -- валюта КД
                              , gen_end_dt    date       -- дата погашення на рах. 8999%
                              , tot_dbt       number(24) -- загальний борг (LIM) усіх трашів в вал. gen_ccy_id
                              , gen_shd       t_shd_type -- графік зниження кредитного ліміту
                              , sar_dtl       t_sar_type --
                              );

    cur                p_cur%rowtype;
    agr                r_gen_type;
    r_shd              r_shd_type;

    l_snp_dt           date;
    l_day_qty          pls_integer := 0;
    l_amnt             number(24);
    a                  pls_integer;
  begin

    l_snp_dt := add_months( p_rpt_dt, -1 );

    bars_audit.info( title||': p_rpt_dt='||to_char(p_rpt_dt,'dd/mm/yyyy')
                          ||', l_snp_dt='||to_char(l_snp_dt,'dd/mm/yyyy')
                          ||', p_adj_f=' ||to_char(p_adj_f) );

    << FETCH_CRSR >>
    loop

      fetch p_cur
       into cur;

      exit when p_cur%NOTFOUND;

--    bars_audit.trace( title||': GEN_ID=' ||cur.GEN_ID ||', AGR_ID=' ||cur.AGR_ID
--                           ||', CCY_ID=' ||cur.CCY_ID
--                           ||', AGR_QTY='||cur.AGR_QTY||', AGR_NUM='||cur.AGR_NUM );

--    -- пропускаємо генугоди у яких відсутній активний залишок на 8999
--    continue when cur.LIM_BAL >= 0;

      begin

        if ( cur.GEN_ID Is Null )
        then -- ген. дог. лінії / стандарт

          agr.gen_id      := cur.AGR_ID;
          agr.gen_ccy_id  := cur.CCY_ID;
          agr.gen_end_dt  := cur.END_DT;
          agr.tot_dbt     := 0;

          if ( cur.AGR_TP = 'INS' )
          then -- Instolment
              /* приводим график Instolment к аналогу cc_lim */
              with tot as ( select h.chain_idt,
                                   h.idp,
                                   h.plan_num,
                                   h.sum_int*100 as sum_int,
                                   h.sum_fee*100 as sum_fee,
                                   h.sum_princ*100 as sum_princ,
                                   sum(h.sum_int*100) over   (partition by h.CHAIN_IDT, h.plan_num) as t_int,
                                   sum(h.sum_fee*100) over   (partition by h.CHAIN_IDT, h.plan_num) as t_fee,
                                   sum(h.sum_PRINC*100) over (partition by h.CHAIN_IDT, h.plan_num) as t_PRINC
                              from ( SELECT sph.chain_idt,
                                            sph.idp,
                                            sph.plan_num,
                                            SUM(decode(sph.code, 'INT', sph.total_amount, 0))       AS sum_int,
                                            SUM(decode(sph.code, 'FEE', sph.total_amount, 0))       AS sum_fee,
                                            SUM(decode(sph.code, 'PRINCIPAL', sph.total_amount, 0)) AS sum_PRINC
                                       FROM bars.OW_INST_SUB_P_HIST sph
                                      where sph.PLAN_NUM = (select max(PLAN_NUM) as PLAN_NUM from bars.OW_INST_TOTALS_HIST t where t.CHAIN_IDT = sph.chain_idt and INS_BD <= p_rpt_dt )
                                        and sph.chain_idt = cur.AGR_ID
                                      GROUP BY chain_idt, idp, plan_num) h
                             where h.chain_idt = cur.AGR_ID
                          )
              select g.ND, g.FDAT, g.LMT_INPT, g.LMT_OTPT, g.SS, g.SN, g.SNO, g.SNP, g.SSP, g.DAY_QTY, g.IR, g.SN1, g.SN2
                bulk collect
                into agr.gen_shd
                from ( select distinct /* первый поток графика от даты выдачи кредита */
                              tot.CHAIN_IDT   as ND
                            , th.POSTING_DATE as FDAT
                            , tot.T_PRINC     as LMT_INPT
                            , tot.T_PRINC     as LMT_OTPT
                            , 0               as SS
                            , 0               as SN
                            , 0               as SNO
                            , 0               as SNP
                            , 0               as SSP
                            , 0               as DAY_QTY
                            --, th.SUB_INT_RATE + th.SUB_FEE_RATE as IR
                            , th.SUB_INT_RATE as IR
                            , 0               as SN1
                            , 0               as SN2
                         from tot
                         join bars.OW_INST_TOTALS_HIST th on (th.CHAIN_IDT = tot.CHAIN_IDT and th.PLAN_NUM = tot.PLAN_NUM)
                       union all
                       select tot.CHAIN_IDT as ND
                            , ph.EFF_DATE as FDAT
                            , tot.t_PRINC - sum(tot.SUM_PRINC) over ( partition by tot.CHAIN_IDT order by tot.IDP ) + tot.SUM_PRINC as LMT_INPT
                            , tot.t_PRINC - sum(tot.SUM_PRINC) over ( partition by tot.CHAIN_IDT order by tot.IDP ) as LMT_OTPT
                            , tot.SUM_PRINC as SS --сумма гашения по телу
                            , tot.sum_int + tot.sum_fee as SN --сумма гашения процентов+комиссия
                            , 0 as SNO
                            , 0 as SNP
                            , 0 as SSP
                            , ph.EFF_DATE-lag(ph.EFF_DATE,1,th.POSTING_DATE) over ( partition by tot.CHAIN_IDT order by ph.EFF_DATE ) as DAY_QTY
                            --, th.SUB_INT_RATE + th.SUB_FEE_RATE as IR
                            , th.SUB_INT_RATE as IR
                            , 0 as SN1
                            , 0 as SN2
                         from tot
                         join bars.OW_INST_PORTIONS_HIST ph on (tot.CHAIN_IDT = ph.CHAIN_IDT and tot.PLAN_NUM = ph.PLAN_NUM and tot.IDP = ph.SEQ_NUMBER)
                         join bars.OW_INST_TOTALS_HIST   th on (th.CHAIN_IDT = tot.CHAIN_IDT and th.PLAN_NUM = tot.PLAN_NUM)
                     ) g
               where g.FDAT >= p_rpt_dt
                 and g.ND    = cur.AGR_ID
               order by g.FDAT;
          else -- cur.AGR_TP = 'INS'
            if ( p_adj_f = 1 )
            then -- з архіву ГПК
              select ND
                   , FDAT
                   , LIM2+SUMG as LMT_INPT
                   , LIM2      as LMT_OTPT
                   , SUMG      as SS
                   , SUMO-SUMG as SN
                   , 0         as SNO
                   , 0         as SNP
                   , 0         as SSP
                   , FDAT-lag(FDAT,1,p_rpt_dt-1) over (order by FDAT) as DAY_QTY
                   , null, 0, 0
                bulk collect
                into agr.gen_shd
                from CC_LIM_ARC
               where MDAT  = p_rpt_dt
                 and ND    = cur.AGR_ID
                 and FDAT >= p_rpt_dt
               order by FDAT;
            else -- з поточного ГПК
              select ND, FDAT, LIM2+SUMG, LIM2, SUMG, SUMO-SUMG
                   , 0, 0, 0
                   , FDAT-lag(FDAT,1,p_rpt_dt-1) over (order by FDAT) as DAY_QTY
                   , null, 0, 0
                bulk collect
                into agr.gen_shd
                from CC_LIM
               where ND    = cur.AGR_ID
                 and FDAT >= p_rpt_dt
               order by FDAT;
            end if; --p_adj_f = 1
          end if; --cur.AGR_TP = 'INS'

          agr.sar_dtl := t_sar_type();

          if ( cur.AGR_QTY = 1 )
          then  -- стандарт

            agr.sar_dtl.extend();

            agr.sar_dtl(agr.sar_dtl.last).sar_id      := cur.AGR_ID;
            agr.sar_dtl(agr.sar_dtl.last).sar_ccy_id  := cur.CCY_ID;
            agr.sar_dtl(agr.sar_dtl.last).cumulat_SN  := 0;
            agr.sar_dtl(agr.sar_dtl.last).cumulat_SPN := 0;

            if ( cur.AGR_TP = 'AST' )
            then -- assets

              select nvl( abs( sum( case TIP when 'SS ' then BAL else 0 end ) ), 0 ) as BAL_SS
                   , nvl( abs( sum( case TIP when 'SP ' then BAL else 0 end ) ), 0 ) as BAL_SP
                   , nvl( abs( sum( case TIP when 'SN ' then BAL else 0 end ) ), 0 ) as BAL_SN
                   , nvl( abs( sum( case TIP when 'SPN' then BAL else 0 end ) ), 0 ) as BAL_SPN
                   , nvl( abs( sum( case TIP when 'SNO' then BAL else 0 end ) ), 0 ) as BAL_SNO
                   , max( case TIP when 'SS ' then ACRN.FPROCN( ACC, 0, p_rpt_dt-1 ) else 0 end ) as RATE_SS
                   , max( case TIP when 'SP ' then ACRN.FPROCN( ACC, 0, p_rpt_dt-1 ) else 0 end ) as RATE_SP
                into agr.sar_dtl(agr.sar_dtl.last).dbt      -- SS
                   , agr.sar_dtl(agr.sar_dtl.last).dbt_odue -- SP
                   , agr.sar_dtl(agr.sar_dtl.last).int      -- SN
                   , agr.sar_dtl(agr.sar_dtl.last).int_odue -- SPN
                   , agr.sar_dtl(agr.sar_dtl.last).int_dfr  -- SNO
                   , agr.sar_dtl(agr.sar_dtl.last).sar_rate -- відсоткова ставка
                   , agr.sar_dtl(agr.sar_dtl.last).sar_fine
                from ( select ac.ACC, ac.NBS, ac.TIP, ac.KV
                            , mb.OST  + p_adj_f * ( mb.CrKos  - mb.CrDos  ) as BAL
                         from ND_ACC   da
                         join ACCOUNTS ac
                           on ( ac.ACC = da.ACC )
                         join AGG_MONBALS mb
                           on ( mb.ACC = ac.ACC and mb.FDAT = l_snp_dt )
                        where da.ND = cur.AGR_ID
                          and ac.DAOS < p_rpt_dt
                          and lnnvl( ac.DAZS < p_rpt_dt )
                          and ac.TIP in ('SS ','SP ','SN ','SPN','SNO')
                          and ac.NBS like '2___'
                     );

            elsif ( cur.AGR_TP = 'INS' )
            then --Instolment

              select nvl( abs( sum( case TIP when 'ISS' then BAL else 0 end ) ), 0 ) as BAL_SS  --Кред. інстолмент. #NMS
                   , nvl( abs( sum( case TIP when 'ISP' then BAL else 0 end ) ), 0 ) as BAL_SP  --Простр.заборг. за кред. інстолмент. #NMK
                   , nvl( abs( sum( case TIP when 'IKN' then BAL else 0 end ) ), 0 ) as BAL_SN  --Нарах.дох.за кред. інстолмент. #NMS
                   , nvl( abs( sum( case TIP when 'IPN' then BAL else 0 end ) ), 0 ) as BAL_SPN --Простр.нарах.дох. за кред. інстолмент. #NMK
                   , 0                      as BAL_SNO
                   , max(agr.gen_shd(1).IR) as RATE_SS
                   , max( case TIP when 'ISP ' then ACRN.FPROCN( ACC, 0, p_rpt_dt-1 ) else 0 end ) as RATE_SP
                into agr.sar_dtl(agr.sar_dtl.last).dbt      -- SS
                   , agr.sar_dtl(agr.sar_dtl.last).dbt_odue -- SP
                   , agr.sar_dtl(agr.sar_dtl.last).int      -- SN
                   , agr.sar_dtl(agr.sar_dtl.last).int_odue -- SPN
                   , agr.sar_dtl(agr.sar_dtl.last).int_dfr  -- SNO
                   , agr.sar_dtl(agr.sar_dtl.last).sar_rate -- відсоткова ставка
                   , agr.sar_dtl(agr.sar_dtl.last).sar_fine
                from ( select ac.ACC, ac.NBS, ac.TIP, ac.KV
                            , mb.OST + p_adj_f * ( mb.CrKos  - mb.CrDos  ) as BAL
                         from bars.W4_ACC_INST   da
                         join bars.ACCOUNTS ac
                           on ( ac.ACC = da.ACC )
                         join bars.AGG_MONBALS mb
                           on ( mb.ACC = ac.ACC and mb.FDAT = l_snp_dt )
                        where da.CHAIN_IDT = cur.AGR_ID
                          and ac.DAOS < p_rpt_dt
                          and lnnvl( ac.DAZS < p_rpt_dt )
                          and ac.TIP in ('ISS', 'ISP', 'IKN', 'IPN')
                          and ac.NBS like '2___'
                     );
              
            else -- liabilities

              select nvl( abs( sum( case TIP when 'DEP' then BAL else 0 end ) ), 0 ) as BAL_DEP
--                 , nvl( abs( sum( case TIP when 'SP ' then BAL else 0 end ) ), 0 ) as BAL_SP
                   , nvl( abs( sum( case TIP when 'DEN' then BAL else 0 end ) ), 0 ) as BAL_DEN
--                 , nvl( abs( sum( case TIP when 'SPN' then BAL else 0 end ) ), 0 ) as BAL_SPN
--                 , nvl( abs( sum( case TIP when 'SNO' then BAL else 0 end ) ), 0 ) as BAL_SNO
                   , max( case TIP when 'DEP' then ACRN.FPROCN( ACC, 1, p_rpt_dt-1 ) else 0 end ) as RATE_DEP
--                 , max( case TIP when 'SP ' then ACRN.FPROCN( ACC, 0, p_rpt_dt-1 ) else 0 end ) as RATE_SP
                into agr.sar_dtl(agr.sar_dtl.last).dbt      -- DEP
                   , agr.sar_dtl(agr.sar_dtl.last).int      -- DEN
                   , agr.sar_dtl(agr.sar_dtl.last).sar_rate -- відсоткова ставка
                from ( select ac.ACC, ac.NBS, ac.TIP, ac.KV
                            , mb.OST  + p_adj_f * ( mb.CrKos  - mb.CrDos  ) as BAL
                         from ND_ACC   da
                         join ACCOUNTS ac
                           on ( ac.ACC = da.ACC )
                         join AGG_MONBALS mb
                           on ( mb.ACC = ac.ACC and mb.FDAT = l_snp_dt )
                        where da.ND = cur.AGR_ID
                          and ac.DAOS < p_rpt_dt
                          and lnnvl( ac.DAZS < p_rpt_dt )
                          and ac.TIP in ('DEP','DEN')
                     );

              agr.sar_dtl(agr.sar_dtl.last).dbt_odue := 0;
              agr.sar_dtl(agr.sar_dtl.last).int_odue := 0;
              agr.sar_dtl(agr.sar_dtl.last).int_dfr  := 0;
              agr.sar_dtl(agr.sar_dtl.last).sar_fine := 0;

            end if;

            agr.sar_dtl(agr.sar_dtl.last).gen_ccy_dbt := agr.sar_dtl(agr.sar_dtl.last).dbt;

            agr.tot_dbt := agr.tot_dbt + agr.sar_dtl(agr.sar_dtl.last).dbt;

          end if;

        else -- транш ген.дог.  (cur.GEN_ID Is not Null)

          if ( agr.gen_id = cur.GEN_ID )
          then

            agr.sar_dtl.extend();

            agr.sar_dtl(agr.sar_dtl.last).sar_id      := cur.AGR_ID;
            agr.sar_dtl(agr.sar_dtl.last).sar_ccy_id  := cur.CCY_ID;
            agr.sar_dtl(agr.sar_dtl.last).cumulat_SN  := 0;
            agr.sar_dtl(agr.sar_dtl.last).cumulat_SPN := 0;

            select nvl( abs( sum( case TIP when 'SS ' then BAL else 0 end ) ), 0 ) as BAL_SS
                 , nvl( abs( sum( case TIP when 'SP ' then BAL else 0 end ) ), 0 ) as BAL_SP
                 , nvl( abs( sum( case TIP when 'SN ' then BAL else 0 end ) ), 0 ) as BAL_SN
                 , nvl( abs( sum( case TIP when 'SPN' then BAL else 0 end ) ), 0 ) as BAL_SPN
                 , nvl( abs( sum( case TIP when 'SNO' then BAL else 0 end ) ), 0 ) as BAL_SNO
                 , max( case TIP when 'SS ' then ACRN.FPROCN( ACC, 0, p_rpt_dt-1 ) else 0 end ) as RATE_SS
                 , max( case TIP when 'SP ' then ACRN.FPROCN( ACC, 0, p_rpt_dt-1 ) else 0 end ) as RATE_SP
              into agr.sar_dtl(agr.sar_dtl.last).dbt         -- SS
                 , agr.sar_dtl(agr.sar_dtl.last).dbt_odue    -- SP
                 , agr.sar_dtl(agr.sar_dtl.last).int         -- SN
                 , agr.sar_dtl(agr.sar_dtl.last).int_odue    -- SPN
                 , agr.sar_dtl(agr.sar_dtl.last).int_dfr     -- SNO
                 , agr.sar_dtl(agr.sar_dtl.last).sar_rate    -- відсоткова ставка
                 , agr.sar_dtl(agr.sar_dtl.last).sar_fine
              from ( select ac.ACC, ac.NBS, ac.TIP, ac.KV
                          , mb.OST  + p_adj_f * ( mb.CrKos  - mb.CrDos  ) as BAL
                       from ND_ACC   da
                       join ACCOUNTS ac
                         on ( ac.ACC = da.ACC )
                       join AGG_MONBALS mb
                         on ( mb.ACC = ac.ACC and mb.FDAT = l_snp_dt )
                      where da.ND = cur.AGR_ID
                        and ac.DAOS < p_rpt_dt
                        and lnnvl( ac.DAZS < p_rpt_dt )
                        and ac.TIP in ('SS ','SP ','SN ','SPN','SNO')
                        and ac.NBS like '2___'
                   );

            if ( agr.gen_ccy_id = cur.CCY_ID )
            then -- same currency
              agr.sar_dtl(agr.sar_dtl.last).gen_ccy_dbt := agr.sar_dtl(agr.sar_dtl.last).dbt;
            else -- different currency

              agr.sar_dtl(agr.sar_dtl.last).gen_ccy_dbt := round( agr.sar_dtl(agr.sar_dtl.last).dbt * GET_CROSS_RATE( cur.CCY_ID, agr.gen_ccy_id, p_rpt_dt ) );
/*
              bars_audit.trace( title||': sar_id='     ||to_char(agr.sar_dtl(agr.sar_dtl.last).sar_id)
                                     ||', gen_ccy_id=' ||to_char(agr.gen_ccy_id)
                                     ||', gen_ccy_dbt='||to_char(agr.sar_dtl(agr.sar_dtl.last).gen_ccy_dbt)
                                     ||', sar_ccy_id=' ||to_char(cur.CCY_ID)
                                     ||', sar_ccy_dbt='||to_char(agr.sar_dtl(agr.sar_dtl.last).dbt) );
*/
            end if;

            agr.tot_dbt := agr.tot_dbt + agr.sar_dtl(agr.sar_dtl.last).gen_ccy_dbt;

          end if;

        end if; --(cur.GEN_ID Is Null)
/*
        bars_audit.trace( title||': sar_id='  ||to_char(agr.sar_dtl(agr.sar_dtl.last).sar_id)
                               ||', dbt='     ||to_char(agr.sar_dtl(agr.sar_dtl.last).dbt)
                               ||', dbt_odue='||to_char(agr.sar_dtl(agr.sar_dtl.last).dbt_odue)
                               ||', int='     ||to_char(agr.sar_dtl(agr.sar_dtl.last).int)
                               ||', int_odue='||to_char(agr.sar_dtl(agr.sar_dtl.last).int_odue) );
*/
        if ( agr.sar_dtl.count > 0 and
             agr.sar_dtl(agr.sar_dtl.last).int_dfr > 0 )
        then -- fill schedule of deferred interest

          select FDAT, sum( SUMP1 )
            bulk collect
            into agr.sar_dtl(agr.sar_dtl.last).sno_shd
            from SNO_GPP
           where ND = cur.AGR_ID
             and FDAT >= p_rpt_dt
           group by FDAT
           order by FDAT;

          if ( sql%rowcount = 0 )
          then --

            select a.MDATE
                 , sum( abs( b.OST + p_adj_f * ( b.CrKos - b.CrDos ) ) )
              bulk collect
              into agr.sar_dtl(agr.sar_dtl.last).sno_shd
              from ND_ACC   r
              join ACCOUNTS a
                on ( a.ACC = r.ACC )
              join AGG_MONBALS b
                on ( b.ACC = r.ACC and b.FDAT = l_snp_dt )
             where r.ND = cur.AGR_ID
               and a.DAOS < p_rpt_dt
               and lnnvl( a.DAZS < p_rpt_dt )
               and a.TIP = 'SNO'
             group by a.MDATE
             order by a.MDATE;

          end if;

          bars_audit.trace( title||': sar_id='       ||to_char(cur.AGR_ID)
                                 ||', sno_shd.count='||to_char(agr.sar_dtl(agr.sar_dtl.last).sno_shd.count)
                                 ||', int_dfr='      ||to_char(agr.sar_dtl(agr.sar_dtl.last).int_dfr) );

        end if;

        if ( cur.AGR_QTY = cur.AGR_NUM )
        then -- графіки

          bars_audit.trace( title||': agr.gen_shd.count='||to_char(agr.gen_shd.count)
                                 ||', agr.sar_dtl.count='||to_char(agr.sar_dtl.count) );

          if ( agr.gen_shd.count > 0 )
          then

            l_day_qty := 0;

            << PCS_SHD >>
            for r in agr.gen_shd.first .. agr.gen_shd.last
            loop

              -- make copy of record
              r_shd := agr.gen_shd(r);

              --для розрахунку відсотків накопичуємо кількість днів у періодах до моменту необхідності (наявність відсотків по графіку) розрахунку
              --l_day_qty := l_day_qty + r_shd.DAY_QTY;
              -- необхідно накопичувати не кількість днів, а суму відсотків, оскільки залишок на рахунку змінюється (KVA 14.02.2019)
              l_day_qty := r_shd.DAY_QTY;

              a := agr.sar_dtl.first;

              << CRT_SHD >>
              while ( a Is Not Null )
              loop

                -- override agreement id
                r_shd.ND := agr.sar_dtl(a).sar_id;

                -- override input limit amount ( in the currency of the subcontract )
                r_shd.LMT_INPT := agr.sar_dtl(a).dbt;

                -- interest rate
                r_shd.IR := agr.sar_dtl(a).sar_rate;

                -- SNO
                if ( ( agr.sar_dtl(a).int_dfr > 0 )
                 and ( agr.sar_dtl(a).sno_shd.count > 0 )
                 and ( r_shd.FDAT = agr.sar_dtl(a).SNO_SHD(agr.sar_dtl(a).SNO_SHD.first).RPT_DT )
                   )
                then -- платіжна дата для відкладених %%

                  r_shd.SNO := agr.sar_dtl(a).SNO_SHD(agr.sar_dtl(a).SNO_SHD.first).amnt;
                  agr.sar_dtl(a).int_dfr := greatest( agr.sar_dtl(a).int_dfr - r_shd.SNO, 0 );
                  agr.sar_dtl(a).SNO_SHD.delete(agr.sar_dtl(a).SNO_SHD.first);

                else

                  r_shd.SNO := 0;

                end if;

                 -- SN
                 -- расчет и накопление планируемых %%
                agr.sar_dtl(a).cumulat_SN  := agr.sar_dtl(a).cumulat_SN  + r_shd.LMT_INPT          * r_shd.IR                / 100 / 365 * l_day_qty;
                agr.sar_dtl(a).cumulat_SPN := agr.sar_dtl(a).cumulat_SPN + agr.sar_dtl(a).dbt_odue * agr.sar_dtl(a).sar_fine / 100 / 365 * l_day_qty;

                if ( agr.gen_shd(r).SN > 0 )
                then -- платіжна дата для нарахованих %%

                  -- override interest amount
                  r_shd.SN  := agr.sar_dtl(a).int; -- фактически начисленные проценты заносим в первый поток с погашением процентов (мы оптимисты :-) )
                  r_shd.SN1 := agr.sar_dtl(a).cumulat_SN;
                  r_shd.SN2 := agr.sar_dtl(a).cumulat_SPN;
                  agr.sar_dtl(a).cumulat_SN  := 0;
                  agr.sar_dtl(a).cumulat_SPN := 0;

                  if ( r_shd.SN > 0 )
                  then
                    agr.sar_dtl(a).int := 0;
                    bars_audit.trace( title||': r_shd.FDAT='||to_char(r_shd.FDAT,'dd/mm/yyyy')||', l_day_qty='||to_char(l_day_qty) );
                  end if;

                else

                  r_shd.SN  := 0;
                  r_shd.SN1 := 0;
                  r_shd.SN2 := 0;

                end if;

                -- SS
                if ( agr.gen_shd(r).SS > 0 )
                then -- платіжна дата для тіла кредиту
/*
                  bars_audit.trace( title||': sar_id='||agr.sar_dtl(a).sar_id
                                         ||', agr.gen_shd(r).LMT_INPT='   ||to_char(agr.gen_shd(r).LMT_INPT)
                                         ||', agr.gen_shd(r).LMT_OTPT='   ||to_char(agr.gen_shd(r).LMT_OTPT)
                                         ||', agr.tot_dbt='               ||to_char(agr.tot_dbt)
                                         ||', agr.sar_dtl(a).gen_ccy_dbt='||to_char(agr.sar_dtl(a).gen_ccy_dbt)
                                         ||', agr.sar_dtl(a).sar_ccy_id=' ||to_char(agr.sar_dtl(a).sar_ccy_id)
                                         ||', agr.sar_dtl(a).dbt='        ||to_char(agr.sar_dtl(a).dbt) );
*/
                  case -- override debt amount
                  when ( agr.tot_dbt > agr.gen_shd(r).LMT_INPT )
                  then -- просрочка

                    r_shd.SS := agr.tot_dbt - agr.gen_shd(r).LMT_OTPT;

                  when ( agr.tot_dbt = agr.gen_shd(r).LMT_INPT )
                  then -- точно по графіку

                     r_shd.SS := agr.gen_shd(r).SS;

                  when ( agr.tot_dbt > agr.gen_shd(r).LMT_OTPT )
                  then -- переплата

                    r_shd.SS := agr.tot_dbt - agr.gen_shd(r).LMT_OTPT;

                  else -- значна переплата

                     r_shd.SS := 0;

                  end case;
/*
                  bars_audit.trace( title||': r_shd.ND='||r_shd.ND
                                         ||', r_shd.FDAT='||to_char(r_shd.FDAT,'dd/mm/yyyy')
                                         ||', r_shd.LMT_INPT='||r_shd.LMT_INPT
                                         ||', r_shd.SS='||r_shd.SS );
*/
                  if ( agr.sar_dtl(a).sar_ccy_id = agr.gen_ccy_id )
                  then -- same currency

                    if ( agr.sar_dtl(a).dbt >= r_shd.SS )
                    then -- fully

                      agr.gen_shd(r).SS := 0;

                    else -- partly

                      r_shd.SS := agr.sar_dtl(a).dbt;

                      agr.gen_shd(r).SS := agr.gen_shd(r).SS - r_shd.SS;

                    end if;

                    agr.tot_dbt                := agr.tot_dbt                - r_shd.SS;
                    agr.sar_dtl(a).gen_ccy_dbt := agr.sar_dtl(a).gen_ccy_dbt - r_shd.SS;

                  else -- different currency

                    -- ця умова теоретично спільна умова для обох випадків (same / dif currency)
                    if ( agr.sar_dtl(a).gen_ccy_dbt >= r_shd.SS )
                    then -- fully

                      l_amnt := r_shd.SS;

                      r_shd.SS := round( r_shd.SS * GET_CROSS_RATE( agr.gen_ccy_id, agr.sar_dtl(a).sar_ccy_id, p_rpt_dt ) );

                      agr.gen_shd(r).SS := 0;

                    else -- partly

                      r_shd.SS := agr.sar_dtl(a).dbt;

                      l_amnt := agr.sar_dtl(a).gen_ccy_dbt;

                      agr.gen_shd(r).SS := agr.gen_shd(r).SS - l_amnt;

                    end if;

                    agr.tot_dbt                := agr.tot_dbt                - l_amnt;
                    agr.sar_dtl(a).gen_ccy_dbt := agr.sar_dtl(a).gen_ccy_dbt - l_amnt;

                  end if;

                  -- залишок в валюті траншу
                  agr.sar_dtl(a).dbt := agr.sar_dtl(a).dbt - r_shd.SS;

                else --agr.gen_shd(r).SS > 0

                  r_shd.SS := 0;

                end if;

                -- override output limit amount ( in the currency of the subcontract )
                r_shd.LMT_OTPT := agr.sar_dtl(a).dbt;

                if ( r_shd.LMT_OTPT = 0 )
                then -- set amount of overdue payments in last row

                  r_shd.SSP := agr.sar_dtl(a).dbt_odue;
                  r_shd.SNP := agr.sar_dtl(a).int_odue;

                  if ( agr.sar_dtl(a).int_dfr > 0)
                  then --
                    r_shd.SNO := r_shd.SNO + agr.sar_dtl(a).int_dfr;
                  end if;

                  if ( agr.sar_dtl(a).int > 0 )
                  then -- для випадків коли в графіку відсутнє погашення %%
                    r_shd.SN := agr.sar_dtl(a).int;
                  end if;

                  if ( agr.sar_dtl(a).cumulat_SN != 0 ) --в последнем потоке фиксируем планируемые %% даже если по графику нет погашения %% 
                  then
                     r_shd.SN1 := agr.sar_dtl(a).cumulat_SN; -- фиксируем планируемые %% SN
                     agr.sar_dtl(a).cumulat_SN := 0;
                  end if;
                  if ( agr.sar_dtl(a).cumulat_SPN != 0 ) --в последнем потоке фиксируем планируемые %% даже если по графику нет погашения %% 
                  then
                     r_shd.SN2 := round(agr.sar_dtl(a).cumulat_SPN); -- фиксируем планируемые %% SPN
                     agr.sar_dtl(a).cumulat_SPN := 0;
                  end if;

                  --
                  agr.sar_dtl.delete(a);

                else
                  r_shd.SSP := 0;
                  r_shd.SNP := 0;
                end if;

                if ( r = agr.gen_shd.last )
                then
                  if ( r_shd.LMT_OTPT != 0 )
                  then -- bad schedule
                    bars_audit.error( title || ': bad schedule (exit with LMT_OTPT != 0 ). ND=' || r_shd.ND );
                    r_shd.SS       := r_shd.SS + agr.sar_dtl(a).dbt;
                    r_shd.SN       := r_shd.SN + agr.sar_dtl(a).int;
                    r_shd.SSP      := agr.sar_dtl(a).dbt_odue;
                    r_shd.SNP      := agr.sar_dtl(a).int_odue;
                    r_shd.SNO      := r_shd.SNO + agr.sar_dtl(a).int_dfr;
                    r_shd.LMT_OTPT := r_shd.LMT_INPT - r_shd.SS;
                  end if;
                end if;
/*
                bars_audit.trace( title||': r_shd.ND='      ||r_shd.ND
                                       ||', r_shd.FDAT='    ||to_char(r_shd.FDAT,'dd/mm/yyyy')
                                       ||', r_shd.LMT_OTPT='||to_char(r_shd.LMT_OTPT)
                                       ||', r_shd.SS='      ||to_char(r_shd.SS)
                                       ||', r_shd.SSP='     ||to_char(r_shd.SSP)
                                       ||', r_shd.SN='      ||to_char(r_shd.SN)
                                       ||', r_shd.SNO='     ||to_char(r_shd.SNO)
                                       ||', r_shd.SNP='     ||to_char(r_shd.SNP)
                                       ||', r_shd.SN1='     ||to_char(r_shd.SN1)
                                       ||', r_shd.SN2='     ||to_char(r_shd.SN2) );
*/
                if ( ( r_shd.SS + r_shd.SSP + r_shd.SN + r_shd.SNO + r_shd.SNP + r_shd.SN1 + r_shd.SN2 ) > 0 )
                then --
                  PIPE ROW ( r_shd );
                end if;

                a := agr.sar_dtl.next(a);

              end loop CRT_SHD;

              if ( agr.gen_shd(r).SN > 0 )
              then -- reset number of days
                l_day_qty := 0;
              end if;

            end loop PCS_SHD;

            agr.sar_dtl.delete();

          else -- (agr.gen_shd.count > 0) без графіка (відстутній або повністю прострочений КД)

            << PRC_SAR >>
            for a in 1 .. agr.sar_dtl.count
            loop

              r_shd := null;

              r_shd.ND       := agr.sar_dtl(a).sar_id;
              r_shd.FDAT     := greatest( agr.gen_end_dt, p_rpt_dt );
              r_shd.LMT_INPT := agr.sar_dtl(a).dbt;
              r_shd.LMT_OTPT := 0;
              r_shd.SS       := agr.sar_dtl(a).dbt;
              r_shd.SSP      := agr.sar_dtl(a).dbt_odue;
              r_shd.SN       := agr.sar_dtl(a).int;
              r_shd.SNP      := agr.sar_dtl(a).int_odue;
              r_shd.SNO      := agr.sar_dtl(a).int_dfr;
              r_shd.IR       := agr.sar_dtl(a).sar_rate;
              r_shd.SN1      := 0;
              r_shd.SN2      := 0;

              PIPE ROW ( r_shd );

            end loop PRC_SAR;

          end if;

          agr.gen_shd.delete();

          agr := null;

        end if;

      exception
        when OTHERS then
          bars_audit.error( title || ': AGR_ID='|| to_char(cur.AGR_ID) ||chr(10)
                                  || dbms_utility.format_error_stack()
                                  || dbms_utility.format_error_backtrace() );
      end;

    end loop FETCH_CRSR;

    bars_audit.trace( '%s: Exit.', title );

    CLOSE p_cur;

    RETURN;

  end GET_ADJ_SHD;

  --
  --
  --
  procedure SET_ADJ_SHD
  ( p_rpt_dt    in     date
  , p_adj_flag  in     pls_integer default 0
  ) is
    title   constant   varchar2(64) := $$PLSQL_UNIT||'.SET_ADJ_SHD';
    l_rpt_dt           date;
    l_snp_dt           date;
    l_adj_f            number(1);
    l_ast_cur          prvn_flow.c_cur_type;
    l_lby_cur          prvn_flow.c_cur_type;
    l_bpi_cur          prvn_flow.c_cur_type;
  begin

    bars_audit.info( title||': Entry with ( p_rpt_dt='||to_char(p_rpt_dt,'dd/mm/yyyy')
                          ||', p_adj_flag='||to_char(p_adj_flag)||' ).' );

    if ( sys_context('bars_context','user_branch') = '/' )
    then
      raise_application_error( -20666, gl.aMfo||':Забрононено виконання на рівні "/"!', true );
    end if;

    l_rpt_dt := trunc(nvl(p_rpt_dt,GL.GBD()),'MM');

    l_snp_dt := add_months( l_rpt_dt, -1 );

    l_adj_f := p_adj_flag;

    bars_audit.trace( title||': l_rpt_dt=' ||to_char(l_rpt_dt,'dd/mm/yyyy')
                           ||': l_snp_dt=' ||to_char(l_snp_dt,'dd/mm/yyyy')
                           ||', l_adj_f='  ||to_char(l_adj_f) );

    delete PRVN_FLOW_DETAILS
     where MDAT = l_rpt_dt;

    open l_ast_cur
     for select a8.KV    as CCY_ID
              , r8.ND    as AGR_ID
              , a8.MDATE as END_DT
              , p8.ND    as GEN_ID
--            , b8.OST + l_adj_f * ( b8.CRKOS - b8.CRDOS ) as LIM_BAL
              , count(r8.ND) over ( partition by nvl( a8.ACCC, a8.ACC ) ) as AGR_QTY
              , row_number() over ( partition by nvl( a8.ACCC, a8.ACC ) order by a8.ACC ) as AGR_NUM
              , 'AST' as AGR_TP
          from ACCOUNTS a8
          join ND_ACC   r8
            on ( r8.ACC = a8.ACC )
--        join AGG_MONBALS b8
--          on ( b8.ACC = a8.ACC and b8.FDAT = l_snp_dt )
          left outer
          join ND_ACC   p8
            on ( p8.ACC = a8.ACCC )
         where a8.NLS like '8999%'
           and a8.TIP = 'LIM'
           and a8.DAOS < l_rpt_dt
           and lnnvl( a8.DAZS < l_rpt_dt )
--         and ( b8.OST + l_adj_f * ( b8.CRKOS - b8.CRDOS ) ) < 0
         order by nvl( a8.ACCC, a8.ACC ), a8.ACC;

    insert
      into PRVN_FLOW_DETAILS
         ( MDAT,     ND, FDAT, LIM1,     LIM2,     SS, SN, SNO, SPN, SP,  IR, SN1, SN2, OBJECT_TYPE ) -- , DAT1, DAT2 )
    select l_rpt_dt, ND, FDAT, LMT_INPT, LMT_OTPT, SS, SN, SNO, SNP, SSP, IR, SN1, SN2, g_CCK
      from table( PRVN_FLOW.GET_ADJ_SHD( l_ast_cur, l_rpt_dt, l_adj_f ) );

    bars_audit.trace( '%s: %s rows inserted.', title, to_char(sql%rowcount) );

    open l_lby_cur
     for select a.KV    as CCY_ID
              , r.ND    as AGR_ID
              , a.MDATE as END_DT
              , p.ND    as GEN_ID
--            , b.OST + l_adj_f * ( b.CRKOS - b.CRDOS ) as LIM_BAL
              , 1 as AGR_QTY
              , 1 as AGR_NUM
              , 'LBY' as AGR_TP -- case a.PAP when 2 then 'LBY' else 'AST' end as AGR_TP
          from ACCOUNTS a
          join ND_ACC   r
            on ( r.ACC = a.ACC )
          join AGG_MONBALS b
            on ( b.ACC = a.ACC and b.FDAT = l_snp_dt )
          left outer
          join ND_ACC   p
            on ( p.ACC = a.ACCC )
         where a.NBS in ('1613','1623','2701','3660')
           and a.DAOS < l_rpt_dt
           and lnnvl( a.DAZS < l_rpt_dt )
           and ( b.OST + l_adj_f * ( b.CRKOS - b.CRDOS ) ) > 0;

    insert
      into PRVN_FLOW_DETAILS
         ( MDAT,     ND, FDAT, LIM1,     LIM2,     SS, SN, SNO, SPN, SP,  IR, SN1, SN2, OBJECT_TYPE ) -- , DAT1, DAT2 )
    select l_rpt_dt, ND, FDAT, LMT_INPT, LMT_OTPT, SS, SN, SNO, SNP, SSP, IR, SN1, SN2, g_CCK
      from table( PRVN_FLOW.GET_ADJ_SHD( l_lby_cur, l_rpt_dt, l_adj_f ) );

    bars_audit.trace( '%s: %s rows inserted.', title, to_char(sql%rowcount) );

    --> Instolment
    open l_bpi_cur
     for select 980          as CCY_ID
              , t.CHAIN_IDT  as AGR_ID
              , t.END_DATE_P as END_DT
              , null    as GEN_ID  -- график свой на каждом договоре Instolment -> GEN_ID = null   --, t.ND as GEN_ID
              , 1 as AGR_QTY
              , 1 as AGR_NUM
              , 'INS' as AGR_TP
          from bars.OW_INST_TOTALS t
         where lnnvl(END_DATE_F < l_rpt_dt)
         order by t.nd, t.idn;

    insert
      into PRVN_FLOW_DETAILS
         ( MDAT,     ND, FDAT, LIM1,     LIM2,     SS, SN, SNO, SPN, SP,  IR, SN1, SN2, OBJECT_TYPE ) -- , DAT1, DAT2 )
    select l_rpt_dt, ND, FDAT, LMT_INPT, LMT_OTPT, SS, SN, SNO, SNP, SSP, IR, SN1, SN2, g_BPK_INST
      from table( PRVN_FLOW.GET_ADJ_SHD( l_bpi_cur, l_rpt_dt, l_adj_f ) );

    bars_audit.trace( '%s: %s rows inserted.', title, to_char(sql%rowcount) );
    --< Instolment

    bars_audit.trace( '%s: Exit.', title );

  end SET_ADJ_SHD;

  --
  --
  --
  function HEADER_VERSION
    return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' header '||g_header_version||'.';
  end HEADER_VERSION;

  --
  --
  --
  function BODY_VERSION
    return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' body '||g_body_version||'.';
  end BODY_VERSION;



begin
  null;
end PRVN_FLOW;
/

show errors;

grant execute on PRVN_FLOW to BARS_ACCESS_DEFROLE;
grant execute on PRVN_FLOW to RCC_DEAL;
grant execute on PRVN_FLOW to START1;
grant execute on PRVN_FLOW to BARSUPL, UPLD;
grant execute on PRVN_FLOW to BARSREADER_ROLE;
