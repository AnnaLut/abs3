create or replace package PRVN_FLOW
is
  G_HEADER_VERSION  CONSTANT VARCHAR2(64) := 'ver.2.9 11.04.2017';
  G_SHOW_LOG                 BOOLEAN default false;
  ------------------------------------
  procedure err_23  ( p_dat01 date   ) ; --- n) Перевірка 100%-ї Готовністі   НБУ-23
  procedure SEND_MSG( p_txt varchar2 ) ; --- BMS Признак: 1-установлена рассылка сообщений
  procedure LOC_DAT ( p_bDAT date    ) ; --- d) Установити локальну Банк.Дату
  procedure F02     ( p_dat31 date   ) ; --- 7 ) #02 *Формування #02
  procedure DRAPS02 ( p_dat31 date   ) ; --- *) SNP: Пере-Формування місячного знімоку
  procedure REC_23  ( p_dat01 date   ) ; --- 3) Z23: *Пере-Формування Рез-НБУ-23
  --------------------------
  -- получение dos, kos
  function QDK_12( p_dk int, p_acc number, p_dat1 date, p_dat2 date, p_di number, p_nbs varchar2, p_ZO int ) return number;

  --
  -- получение ост (аналог OST_KORR)
  --
  function QST_12
  ( p_acc  accounts.acc%type
  , p_dat  date
  , p_nbs  accounts.nbs%type
  , p_zo   int
  ) return accounts.ostc%type;

  -- получение суммы однотипных сч
  function Get_sum (p_nd number, p_kv int, p_tip accounts.tip%type, p_dat01 date, p_ZO int ) return number;

  -----------------------
  procedure upd0 ( p_mode int, p_id number, p_add2 int, p_bal0 int , p_eps int, p_dat01 date, p_ZO int )        ; --- для одиночных выховов
  procedure bal0 ( p_mode int, p_nd number, p_tip accounts.tip%type, p_dat01 date, p_ZO int )                   ; -- балансировка - по дон. по типу счета
  --------------------------------------------------------------
  procedure p60    ( p_tipA IN int, p_ND IN number, p_acc_sna IN number, a6 OUT accounts%rowtype ) ;  
  procedure u_SNA  ( p_dat   date ) ; -- урегулирование НЕВИЗНАНИХ. Уменьшение SNA := LEAST ( SNA, -(SN+SPN) )
  procedure D_SNA  ( p_dat01 date ) ; -- SNA от Делойта
  procedure heir39 ( p_dat01 date ) ; -- наследование рез-МСФЗ от промлого месяца
  procedure opl    ( oo IN OUT oper%rowtype ) ; 
  function  BAD_CP ( p_OSA VARCHAR2, z_dat01 date )  return varchar2 ;  
  procedure div39  ( p_mode int, p_dat01 date ); -- разделение рез-39 по КД в НБУ-23-РЕЗ.
  procedure del0   ( p_mode int)               ; -- отладочная процедура очистки всех таблиц

  -- ежедневная процедура добавки новых КД
  procedure add1
  ( p_dat01 date
  , p_mode  int     default 0
  , p_nd    number  default null );

  -- Построение ден.потоков по требованию
  procedure add2( p_mode int, p_id number, p_dat01 date, p_zo int  );

  -- Построение ден.потоков по КП 
  procedure ADD2_SS ( x0 prvn_flow_deals_const%rowtype, 
                      xx prvn_flow_deals_var%rowtype, 
                      p_dat31 date, 
                      p_dat01 date, 
                      p_fla   int ,  p_fl_nd_acc int , p_zo int );

  function F_DEL_PV (p_id number, p_Rdat date ) return number ; --- получение дельты PV по дате ректркутуризации 
  function Get_nls  (p_nd number, p_tip accounts.tip%type ) return varchar2; --- получение номера лиц.счета
  function G_nd_acc (p_DAT01 DATE ) return INT ; --- =1- ND_ACC_arc берем с архива , = 0  нет, БЕРЕМ ПРЯМО ИЗ nd_acc

  ---- Для изменений во вюшке-гляделке но НОСТРО (по счетам !)------------------------------------
  procedure nos_ins (p_kv int, p_nls varchar2 ); 
  procedure nos_upd (p_nd    number, p_sos   int, p_CC_ID varchar2, p_SDATE date, p_WDATE   date , p_LIMIT number, 
                     p_FIN23 int   , p_OBS23 int, p_KAT23 int     , p_pd    int , p_FIN_351 int );
  procedure nos_del (p_nd number);

  ------------------------------------
  procedure ADD_FIN_DEB( p_dat date);

  -----------------------------------
  function header_version return varchar2;
  function body_version   return varchar2;
-------------------

end PRVN_FLOW;
/

show errors

----------------------------------------------------------------------------------------------------

create or replace package body PRVN_FLOW
is
  g_body_version  constant varchar2(64) := 'version 9.7  26.10.2017';
  
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
  set_bankdate(p_bDAT);
  PRVN_FLOW.SeND_MSG( p_txt => 'Установлено ЛОКальну Банк.Дату='||to_char(p_bDAT,'dd.mm.yyyy') );
end LOC_DAT;

-----------------------------------------------------------
procedure F02 ( p_dat31 date ) is     l_dat31  date ;  l_msg varchar(250) ;
 begin    If    p_dat31 is null then  l_dat31 := to_date( pul.Get_Mas_Ini_Val('zFdat1') ,'dd-mm-yyyy') ;
          else                        l_dat31 := p_dat31 ;
          end if;

     l_msg:= '7 ) #02 *Формування #02 '||l_dat31;
     PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
     P_F02_NC ( l_dat31 ) ;
     PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );

 end F02;

procedure DRAPS02( p_dat31 date  )  is      l_dat31 date;
 l_msg varchar2 (250);
 begin
     l_dat31 := NVL ( p_dat31, trunc( z23.DAT_END,'M' ) ) ;
     l_msg:= '*) SNP: Пере-Формування місячного знімоку '||l_dat31;
     PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
     MDRAPS ( l_dat31 ) ;
     PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );
 end DRAPS02 ;

procedure REC_23  ( p_dat01 date)  is
   l_res_kf  varchar2(13); sid_    varchar2(64) ;   sess_   varchar2(64) :=bars_login.get_session_clientid;
   l_dat31   date        ; l_msg   varchar2(250);
begin
   l_msg:= '3) CR-351: *Пере-Формування Кредитного ризику НБУ-351';
   PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
   l_res_kf := trim('RESERVE'||sys_context('bars_context','user_mfo')); 
   -- защита от двойного старта
   SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
   sid_:=SYS_CONTEXT('BARS_GLPARAM',l_res_kf);
   SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

   begin
      select sid into sid_ from v$session    where  sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
      raise_application_error(-20000,'Формування резерву вже виконується SID '|| sid_);
   exception  when no_data_found THEN NULL;
   end;

   l_dat31 := p_dat01-1 ;
   PRVN_FLOW.SeND_MSG (p_txt => 'BEG DRAPS:'||l_dat31||l_msg );
   --MDRAPS ( l_dat31 ) ;
   PRVN_FLOW.SeND_MSG (p_txt => 'END DRAPS:'||l_dat31||l_msg );

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

   PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );

-------------------------------------------------------------------
end REC_23 ;
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

procedure upd0 ( p_mode int, p_id number, p_add2 int, p_bal0 int , p_eps int, p_dat01 date, p_ZO int ) is --- для одиночных выховов
    l_dat01 date ;
    l_nd number  ;
begin
    if p_dat01 is null then l_dat01 := to_date(pul.get_mas_ini_val('sFdat1'), 'dd.mm.yyyy') ;
    else                    l_dat01 := p_dat01 ;
    end if;

    if p_add2 = 1 then       PRVN_FLOW.ADD2    ( 0, p_id,    l_dat01, p_ZO ) ; end if ;
    if p_bal0 = 1 or p_eps = 1 then
       begin select nd into  L_ND from PRVN_FLOW_DEALS_CONST where id  = p_id   ;
          If p_bal0 = 1 then PRVN_FLOW.bal0    ( 0, L_ND,'', l_dat01, p_ZO ) ; end if ;
--        If p_eps  = 1 then PRVN_FLOW.BAB_ALL ( l_ND ,   0, l_dat01       ) ; end if ;
       exception when no_data_found then NULL;
       END;
    END IF;
end upd0;

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

procedure D_SNA  ( p_dat01 date ) is -- SNA от Делойта
  oo  oper%rowtype;  a6  accounts%rowtype;
  sn1 accounts%rowtype; sn2 accounts%rowtype; p4_ int;  l_kol number;  l_ost number; l_prod char(6);
  ss specparam%rowtype;

  z_dat01 date  ; -- отчетная дата
  s_dat01 varchar2(10) ; -- она же. симdольная
  l_commit number := 0 ;
  ----------------
  l_msg varchar2(250);

  procedure not_sna (x_tip int, x_nd number, x_RI varchar2, x_Err varchar2) is
  begin
    update PRVN_OSAQ set comm = x_Err where tip = x_tip and nd = x_nd ;
    update PRVN_OSA  set comm = x_Err where rowid = x_RI ;
  end not_sna;

begin
  if p_dat01 is null then     s_dat01 := pul.get_mas_ini_val('sFdat1') ;
     if s_dat01 is null then  raise_application_error( -20333,'   PRVN_FLOW : Не задано звітну дату = 01.mm.yyyy');   end if;
     z_dat01 := to_date( s_dat01, 'dd.mm.yyyy') ;
  else  z_dat01 := p_dat01;   s_dat01 := to_char(z_dat01, 'dd.mm.yyyy')  ;  pul_dat(s_dat01, null ) ;
  end if;

  l_msg := '2) IRR: Формування проводок  по "НеВизнаним" '||z_dat01 ;
  PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );

  oo.nd    := 'FV IRC';
  oo.id_a  := gl.aOkpo;
  oo.tt    := 'IRR'   ;
  oo.vob   := 96;
  oo.kv2   := gl.baseval;
  select max(fdat) into oo.vdat from fdat where fdat < z_dat01 ;

  update PRVN_OSAq set comm = null ;
  commit;

  for x in ( select rnk, tip, ND, kv, AIRC_CCY , rowid RI  from PRVN_OSA where tip in (3,9,10) )
  loop  oo.kv := x.kv ;  oo.nazn := 'Отримано з Finevare. Корекція доходів на суму НЕвизнаних по дог= '||x.tip||'/'||x.ND;    l_kol := 0;

    If x.TIP = 9 then
       declare             cpD cp_deal%rowtype;   cpA cp_accc%rowtype;
       begin select * into cpD from cp_deal where ref = x.nd;
          If cpD.ACCUNREC is null then ------------------------------ Неприз дох по ЦБ
             select * into sn1  from accounts where acc  = cpD.acc  ;
             select * into sn1  from accounts where acc  = sn1.accc ;
             select * into cpa  from cp_accc  where nlsA = sn1.nls  and UNREC is not null and rownum = 1;
             select * into sn1  from accounts where nls  = cpA.UNREC and kv = x.kv ;  -- родит счет невизнаных

             SN2.nls := vkrzn( substr(gl.aMfo,1,5),  substr(sn1.nls,1,4)||'09'|| substr( '000000000'||x.nd, -8)  );
             SN2.nms := 'НЕвизн.дох. Угода='|| x.TIP ||'/'||x.nd ;
             l_ost   :=0;
             OP_REG_EX (99,0,0,sn1.GRP,p4_, sn1.RNK , sn2.nls, x.kv, sn2.NMS,'ODB', gl.aUid, sn2.acc, NULL);
             insert into cp_accounts ( CP_REF ,  CP_ACCTYPE ,  CP_ACC ) values ( cpD.ref, 'UNREC', sn2.acc );
             update cp_deal set ACCUNREC= sn2.acc  where ref = x.nd;
             update accounts set pap = 2, tobo = sn1.branch, daos = oo.vdat , accc = sn1.acc  where acc = SN2.acc;

          else select acc, ostc into sn2.acc, l_ost from accounts where acc = cpD.ACCUNREC ;
          end if;
          l_kol := 1 ;
       EXCEPTION WHEN NO_DATA_FOUND THEN   not_sna (x.tip, x.nd, x.RI, 'NOT in ACC.CP_deal') ;  goto Rec_Next;
       end;

    Else                     -- nd_acc
       -- Сколько есть незакрытых SNA ?
       select min(acc), count(*), NVL(sum(ostc),0) into sn2.acc, l_kol, l_ost from accounts
       where tip = 'SNA' and kv = x.KV  and acc in (select acc from nd_acc where nd = x.ND ) AND dazs is null ;

       -- Еще нет ни одного. откроем   рах типу SNA
       If l_kol = 0  and x.AIRC_CCY > 0 then

          begin
             -- найти какой-нибудь счет
             select * into sn1  from accounts  where dazs is null and (nbs like '1%' or nbs like '2%' ) and kv = x.KV
                and acc in (select acc from nd_acc where nd = x.ND)  and rownum = 1;
             -- найти код продукта
             select substr (prod, 1,6) into l_prod from cc_deal where nd = x.ND;
          EXCEPTION WHEN NO_DATA_FOUND THEN   not_sna (x.tip, x.nd, x.RI, 'NOT SNA') ;  goto Rec_Next;
          end;
          -- Бал счет = ***8
          sn2.NBS   := substr( l_prod,1,3) ||'8' ;
          SN2.nls   := F_NEWNLS ( SN1.acc, 'SN ', sn2.NBS ) ;
          SN2.nms   := 'НЕвизн.дох. Угода=3/'||x.nd ;
          SN2.kv    := x.kv ;
          op_reg (1, x.nd, 0, 0, p4_, sn1.Rnk, sn2.nls, SN2.kv, sn2.nms, 'SNA', SN1.isp, SN2.acc);

          -- об22
          If  SN2.nls like '2%'  then
              begin select sn into sn2.ob22 from cck_ob22  where nbs||ob22 = l_prod ;
              EXCEPTION WHEN NO_DATA_FOUND THEN sn2.ob22 := null ;
              end;
          else                                  sn2.ob22 := '01' ; -- для М.Б - константа
          end if;
          Accreg.setAccountSParam(SN2.Acc, 'OB22', sn2.ob22 );


/*           2208, 2238, 2068, 2088 з тип=SNA,
             присвоюється параметри: R011, R013, S080, S180, S190, S200, S240, S260, S270
             по замовчуванню
             R020   R011	R013	S080	S180	S190	S200	S240	S260	S270	mDate
             2208	E	4	SS/SN   SS/SN   SS/SN   Нет     SS/SN   SS/SN    нет    SS/SN
             2238	1	4 НВ
                                9 ІВ
             2068	A	4
             2088	5	8
*/
          If sn2.NBS in ( '2208', '2238', '2068', '2088' ) then
             begin  select xx.S080, xx.S180, xx.S190, xx.S240, xx.S260, xx.mDate
                    into   ss.S080, ss.S180, ss.S190, ss.S240, ss.S260, sn2.mdate
                    from ( select    s.S080,  s.S180,  s.S190,  s.S240, s.S260, a.mDate  from accounts a, specparam s , nd_acc n
                           where n.nd = x.ND and a.kv = sn2.kv and n.acc = a.acc and a.acc = s.acc and a.tip in ('SS ', 'SN ', 'SP ', 'SPN' ) and a.dazs is null
                           order by a.tip desc
                         ) xx
                    where rownum = 1 ;

                    If    sn2.nbs = '2208'                   then  ss.R011 := 'E' ;  ss.R013 := '4' ;
                    elsIf sn2.nbs = '2238' and sn2.kv =  980 then  ss.R011 := '1' ;  ss.R013 := '4' ;
                    elsIf sn2.nbs = '2238' and sn2.kv <> 980 then  ss.R011 := '1' ;  ss.R013 := '9' ;
                    elsIf sn2.nbs = '2068'                   then  ss.R011 := 'A' ;  ss.R013 := '4' ;
                    elsIf sn2.nbs = '2088'                   then  ss.R011 := '5' ;  ss.R013 := '8' ;
                    end if;

                    update accounts  set mdate = sn2.mdate  where acc = sn2.acc;

                    Accreg.setAccountSParam(SN2.Acc, 'R011', ss.R011 );
                    Accreg.setAccountSParam(SN2.Acc, 'R013', ss.R013 );
                    Accreg.setAccountSParam(SN2.Acc, 'S080', ss.S080 );
                    Accreg.setAccountSParam(SN2.Acc, 'S180', ss.S180 );
                    Accreg.setAccountSParam(SN2.Acc, 'S190', ss.S190 );
                    Accreg.setAccountSParam(SN2.Acc, 'S240', ss.S240 );
                    Accreg.setAccountSParam(SN2.Acc, 'S260', ss.S260 );

             EXCEPTION WHEN NO_DATA_FOUND THEN Accreg.setAccountSParam(SN2.Acc, 'R013', '4' );
             end;
          end if;

          update accounts set pap = 2, tobo = sn1.branch, daos = oo.vdat  where acc = SN2.acc;
          l_kol := 1 ;

       elsIf l_kol > 1 then not_sna (x.tip, x.nd, x.RI, 'NOT uniq SNA') ;  goto Rec_Next;
       end if;

    end if;

    Update accounts set pap = 2 where acc = sn2.acc and pap <> 2 and l_kol > 0 ;
    if l_kol  > 0 and sn2.acc is not null  then   select * into sn2 from accounts where acc = sn2.acc;    end if;

    oo.s := x.AIRC_CCY *100 - l_ost ;
    If oo.s > 0 then oo.dk := 0  ;
    Else             oo.dk := 1  ; oo.s := - oo.s ;
    end if ;
    if oo.s >= 1 then
       oo.nlsa  := sn2.nls ;
       oo.nam_a := substr(sn2.nms, 1,38);
       oo.ref   := null ;
       prvn_flow.p60 ( x.tip, x.ND, sn2.acc, a6 ) ;
       If a6.acc is null then not_sna (x.tip, x.nd, x.RI, 'NOT 60**'); end if;

       oo.nlsb := a6.nls; oo.nam_b := substr(a6.nms,1,38);
       If oo.kv <> oo.kv2  then  oo.s2 := gl.p_icurval ( oo.kv, oo.s, oo.vdat);
       else                      oo.s2 := oo.s;
       end if;

       savepoint DO_OPLATA;
       --------------------
       begin     prvn_flow.opl (oo);  gl.pay( 2, oo.ref, gl.bdate );
       exception when others then     rollback to DO_OPLATA;    not_sna (x.tip, x.nd, x.RI, 'NOT opl SNA ') ;  goto Rec_Next;
       end;

    end if ;

    l_commit := l_commit + 1 ;
    If l_commit > 1000 then commit; l_commit := 0; end if;
    <<Rec_Next>> null;
  end loop ;

  PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );

end  D_SNA ;

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
         raise_application_error( -20333,'   PRVN_FLOW.heir39 : Не задано звітну дату = 01.mm.yyyy');
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
procedure div39 ( p_mode int, p_dat01 date )   is   -- разделение рез-39 по КД в НБУ-23-РЕЗ.
   -- Прийом витрины резервов по МСФЗ
   -- !!!! уже НЕТ p_mode = 0 -- принять файл и разнести по НБУ23
   --              p_mode = 1 -- только принять файл
   --              p_mode = 2 -- только разнести по НБУ23
   z_dat01 date   ; l_dat31 date  ; l_dat31_fv date  ; 
   l_max    number; l_min   number; l_num      number; l_nd  number; l_commit number; l_all   number; 
   nTmp_    number; l_rez   number; l_acc      number; s_KB  number; s_BV     number; s_BVN   number; 
   l_SNA01  number; q_Rez   number; s_k9       number; n_Rez number;
   s_KV     int   ; l_MMFO  int   ; l_count    int   ;        
   l_id  varchar2(25);  sErr_   varchar2(100) := ''  ;  l_msg varchar2(250);    s_dat01  varchar2(10);    
   s_nls varchar2(15);  s_RI    varchar2(254) ;
  s1         SYS_REFCURSOR; 

begin -- OSA_V_PROV_RESULTS_OSH = PRVN_FV_REZ => PRVN_OSA= > PRVN_OSAq

   If p_mode = 12 and gl.amfo <> '300465' then
      raise_application_error(-20000,'Дана опція - лише для ЦА,  МФО = 300045 ');
   end if;

   if p_dat01 is null then   s_dat01 := pul.get_mas_ini_val('sFdat1')   ; z_dat01 := to_date( s_dat01, 'dd.mm.yyyy') ;
   else  z_dat01 := p_dat01; s_dat01 := to_char(z_dat01, 'dd.mm.yyyy')  ; pul_dat(s_dat01, null ) ;
   end if     ;
   l_dat31    := Dat_last_work(z_dat01 -1 ); -- для курса
   l_dat31_fv := z_dat01 -1 ; -- дата приема витрины


   If p_mode in (1) then   --------------------------------------------- принять файл
      -- p_mode = 1 -- только принять файл

      l_msg := '1) OSA: Прийом та стиснення '||z_dat01 ;
      PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );

      l_min := to_number ( to_char( l_dat31_fv , 'YYMMDD')||'00') ;
      l_max := to_number ( to_char( l_dat31_fv , 'YYMMDD')||'99') ;
      ---------------------------------------- XXYYZZ-----WW -------------

      select max (ID_CALC_SET)   into l_num   from OSA_V_PROV_RESULTS_OSH o, regions r
      where ID_CALC_SET >= l_min and ID_CALC_SET <= l_max and o.id_branch = r.id and r.kf = sys_context('bars_context','user_mfo') ;

      if l_num is null
      then
        raise_application_error( -20333,'Вітрини з рез.МСФЗ OSA_V_PROV_RESULTS_OSH на дату='||to_char(l_dat31_fv,'dd.mm.yyyy') ||
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

      -- сжатие витрины делойта по дог с учетом вал . Выбрасывание нулей
--    execute immediate 'truncate table PRVN_OSA';
      
      delete PRVN_OSA;
      
      if l_MMFO = 1 THEN 
         insert into PRVN_OSA ( rnk,   tip,   ND,   kv,              REZB,              REZ9,                  AIRC_CCY,                 IRC_CCY,  
                                                    ID_PROV_TYPE,                    IS_DEFAULT,                             vidd )
                       select f.rnk, f.tip, f.ND, t.kv, sum (F.rezb) REZB, sum (F.rez9) REZ9, sum (F.AIRC_CCY) AIRC_CCY, sum (F.IRC_CCY) IRC_CCY, 
                              min (f.ID_PROV_TYPE ) ID_PROV_TYPE, max (f.IS_DEFAULT) IS_DEFAULT, decode(f.tip,3,d.vidd,null) vidd
                       from  (select Id_currency LCV, 
                                     --Rnk_client||decode(l_MMFO,1,r.code,'') RNK, 
                                     Rnk_client RNK,
                                     substr(Unique_Bars_is , 1 , instr(Unique_Bars_is, '/',1) -1 ) TIP,
                                     --substr(Unique_Bars_is||decode(l_MMFO,1,r.code,''), instr(Unique_Bars_is||decode(l_MMFO,1,r.code,''), '/',1) +1 ) ND, 
                                     substr(Unique_Bars_is, instr(Unique_Bars_is, '/',1) +1 ) ND, 
                                     nvl(Prov_Balance_CCY,0)    REZB, 
                                     nvl(Prov_OffBalance_CCY,0) REZ9, 
                                     nvl(AIRC_CCY,0) AIRC_CCY, 
                                     nvl(IRC_CCY,0)  IRC_CCY , 
                                     ID_PROV_TYPE, -- Метка расчета резерва на индивидуальной или коллективной основе. "С" - колл, "І" - индивид
                                     IS_DEFAULT    -- Метка наличия дефолта по договору. 1 - дефолт, 0 - нет дефолта. Расчетный параметр Finevare
                              from OSA_V_PROV_RESULTS_OSH o, regions r
                              where o.id_branch = r.id and r.kf = sys_context('bars_context','user_mfo') and 
                                  ( Prov_Balance_CCY > 0  or  Prov_OffBalance_CCY > 0 or AIRC_CCY > 0  or  IRC_CCY <> 0 ) and ID_CALC_SET = l_num
                              ) F, tabval T,cc_deal d
                        where t.lcv = f.lcv and f.nd=d.nd (+) 
                        group by f.rnk, f.tip, f.ND, t.kv, d.vidd ;
      else
         insert into PRVN_OSA ( rnk,   tip,   ND,   kv,              REZB,              REZ9,                  AIRC_CCY,                 IRC_CCY,  
                                                    ID_PROV_TYPE,                    IS_DEFAULT,                             vidd )
                       select f.rnk, f.tip, f.ND, t.kv, sum (F.rezb) REZB, sum (F.rez9) REZ9, sum (F.AIRC_CCY) AIRC_CCY, sum (F.IRC_CCY) IRC_CCY, 
                              min (f.ID_PROV_TYPE ) ID_PROV_TYPE, max (f.IS_DEFAULT) IS_DEFAULT, decode(f.tip,3,d.vidd,null) vidd
                       from  (select Id_currency LCV, 
                                     Rnk_client  RNK, 
                                     substr(Unique_Bars_is , 1 , instr(Unique_Bars_is, '/',1) -1 ) TIP,
                                     substr(Unique_Bars_is, instr(Unique_Bars_is, '/',1) +1 ) ND, 
                                     nvl(Prov_Balance_CCY,0)    REZB, 
                                     nvl(Prov_OffBalance_CCY,0) REZ9, 
                                     nvl(AIRC_CCY,0) AIRC_CCY, 
                                     nvl(IRC_CCY,0)  IRC_CCY , 
                                     ID_PROV_TYPE, -- Метка расчета резерва на индивидуальной или коллективной основе. "С" - колл, "І" - индивид
                                     IS_DEFAULT    -- Метка наличия дефолта по договору. 1 - дефолт, 0 - нет дефолта. Расчетный параметр Finevare
                              from OSA_V_PROV_RESULTS_OSH o
                              where ( Prov_Balance_CCY > 0  or  Prov_OffBalance_CCY > 0 or AIRC_CCY > 0  or  IRC_CCY <> 0 ) and ID_CALC_SET = l_num
                              ) F, tabval T,cc_deal d
                        where t.lcv = f.lcv and f.nd=d.nd (+) 
                        group by f.rnk, f.tip, f.ND, t.kv, d.vidd ;
      end if;

      commit;

      PRVN_FLOW.SeND_MSG (p_txt => 'END-KV:'||l_msg );

      -- сжатие витрины делойта в целом по дог в экв. для vidd not in (3,13)
--    execute immediate 'truncate table PRVN_OSAQ';
      
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
   end if;
   -------------------
   If p_mode in (2 , 12 ) then ---------------------------------- разнести по НБУ23 через екв

      update PRVN_OSAq set comm = null where rezb <> 0 or rez9<> 0;
      commit;

      If p_mode = 2 then l_msg:= '4) RR-351:  Тільки Розподіл + Рівчачок для проводок';
      else               l_msg :='4.1 для ЦА =  Тільки ПЕРЕ-Розподіл ручних + Рівчачок';
      end if;
      PRVN_FLOW.SeND_MSG (p_txt => 'BEG-eqv:'||l_msg );

      -- p_mode = 2 -- только разнести по НБУ23
      -- p_mode = 12 -- -- Технічний пункт =  Тільки ПЕРЕ-Розподіл ручних в ЦА
      -- обнуление рез-39 , кроме хоз.деб


      If p_mode <> 12 then
         update nbu23_rez  set rez39 = 0,  rezq39 = 0 , s250_39 = null
          where fdat = z_dat01;
            --and id not like 'DEBH%'
            --and id not like 'XOZ% ' ;
      end if;

      commit;
      LOGGER.INFO('OSA-1:Цикл по ND' );
      l_commit := 0; l_all := 0 ;
      for x in ( select kv, rnk, tip, ND, REZB, REZ9, ID_PROV_TYPE, IS_DEFAULT, rowid RI, REZB_R, REZ9_R, FV_ABS from PRVN_OSAq  )
      loop
        If p_mode = 12 then
           If x.REZB_R is     null and x.REZ9_R is     null then   goto NEXT_;       end if;
           If x.REZB_R is NOT null                          then x.REZB := x.REZb_r; end if;
           If                          x.REZ9_R is NOT null then x.REZ9 := x.REZ9_r; end if;
        end if;

        l_count := 0 ;
        l_SNA01 := 0 ;

        if   x.TIP = 3 and x.kv is null     THEN
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9',    0, BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,    0 )) over (partition by 1))
                         from nbu23_rez where fdat = z_dat01 and BVuq >= 0  and nd =  x.ND and ( rezq39 = 0 or p_mode = 12)
                          AND ( id like 'CCK%' or id like 'MBDK%' or id like '150%' or id like '9020%' or id like '9122%' or id like 'DEBF%' )
                          and tipa = 3 ;
       ElsIf x.TIP = 3 and x.kv is not null THEN
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', 0   , BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,    0 )) over (partition by 1))
                         from nbu23_rez where fdat = z_dat01 and BVuq >= 0  and nd =  x.ND and ( rezq39 = 0 or p_mode = 12)
                          AND ( id like 'CCK%' or id like 'MBDK%' or id like '150%' or id like '9020%' or id like '9122%' or id like 'DEBF%' )
                          and tipa = 3 and kv=x.kv ;
       ElsIf x.TIP = 9   then
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu, Div0( BVuq , sum(BVuq) over (partition by 1)), 0
                         from nbu23_rez where fdat = z_dat01 and BVuq >= 0  and nd =  x.ND    and ( rezq39 = 0 or p_mode = 12)
                          AND ( id like 'CACP%' or id like 'DEBF%' )      and tipa = 9 ;

       ElsIf x.TIP = 4   then
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', 0   ,BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,   0 )) over (partition by 1))
                         from nbu23_rez where fdat= z_dat01 and BVuq >= 0 and ( rezq39 = 0 or p_mode = 12 )
                          and tipa = 4  and nd = x.ND  AND (id like 'W4%'  or id like 'BPK%' or id like 'DEBF%') ;

       ElsIf x.TIP = 10  then
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', 0   ,BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,   0 )) over (partition by 1))
                         from nbu23_rez
                         where fdat= z_dat01 and BVuq >= 0 and nd = x.ND and (rezq39 = 0 or p_mode = 12)
                           AND (id like 'OVER%' or id like 'DEBF%' )  and tipa = 10;

      ElsIf x.TIP = 17   then

         begin
            select ACC_SP  into l_acc from PRVN_FIN_DEB  where ACC_SS = x.nd  and ACC_SS <> ACC_SP; 
             -- ACC_SP is not null
             --and EFFECTDATE < z_dat01;
         exception  when NO_DATA_FOUND  then l_acc := x.nd;
         end;

         OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu, Div0 (BVuq, sum(BVuq) over (partition by 1)), 0  from nbu23_rez
                     where fdat= z_dat01 and BVuq >= 0 and ( rez39 = 0 or p_mode = 12 ) and acc in (x.ND,l_acc) AND ( id like 'DEB%') and tipa = 17;

      ElsIf x.TIP = 21 then
        
         OPEN s1 FOR 
            select ROWID, nls, BVuq, KV, BVu, Div0 (BVuq, sum(BVuq) over (partition by 1)), 0  from   nbu23_rez
            where  fdat= z_dat01 and BVuq >= 0 and ( rez39 = 0 or p_mode = 12 ) and nd in (x.ND) AND ( id like 'DEBH%')  and tipa in ( 21, 17 );

      else
        update prvn_osaq  SET COMM = 'NOT tip='||x.tip , FV_ABS = REZB+REZ9  where rowid = x.RI;
        goto NEXT_;
      end if;
       
       x.FV_ABS := 0;

       LOOP FETCH s1 into s_RI , s_nls,  s_BV, s_KV, s_BVN, s_KB , s_k9 ;
       EXIT WHEN s1%NOTFOUND;

            If s_nls like '9%' then nTmp_ := round ( x.REZ9 * s_K9, 2) ;
            else                    nTmp_ := round ( x.REZb * s_Kb, 2) ;
            end if;

            q_REZ := LEAST ( nTmp_, s_BV)  ;                       -- приблизительны экв
            n_REZ := gl.p_Ncurval( s_kv, q_REZ*100, l_dat31)/100 ; -- приблизительный номинал
            n_REZ := Least ( n_REZ, s_BVN) ;                       -- выровняный номинал
            q_REZ := gl.p_Icurval( s_kv, n_REZ*100, l_dat31)/100 ; -- расчетный экв выровняного ном

            update nbu23_rez set rezq39 = q_REZ , rez39 = n_REZ, s250_39 = x.ID_PROV_TYPE where rowid = s_RI;
            x.FV_ABS := x.FV_ABS + q_REZ ;
            l_count  := l_count  + 1 ;
       end loop;
       
       CLOSE s1;

       If  l_count > 0 then sErr_ := 'OK '|| s_nls    ;
       else                 sErr_ := 'NOT NBU23_rez'  ; x.FV_ABS := 0;
       end if ;

       update  prvn_osaq  SET COMM = sErr_, FV_ABS = (x.REZB + x.REZ9) - x.FV_ABS  where rowid = x.RI  ;

       l_commit := l_commit + 1; l_all := l_all    + 1 ;
       If l_commit >= 1000 then  commit;  l_commit:= 0 ;  LOGGER.INFO('OSA-2.1:Обработано '||l_all||' дог.');    end if;

       <<NEXT_>> null;
     end loop;
     ----------------
     commit;  LOGGER.INFO('OSA-2.2:Обработано ВСЕГО '||l_all||' дог ' || to_char( z_dat01, 'dd.mm.yyyy' ) );
     PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );
  end if;

  If p_mode in (12,2 ) then ---------------------------------- разнести по НБУ23
     -- p_mode = 0 -- принять файл и разнести по НБУ23
     --Рівчачок

     l_msg:= ' ... Рівчачок для проводок';
     PRVN_FLOW.SeND_MSG (p_txt => 'BEG:'||l_msg );
     Rezerv_23 ( z_dat01 );
     commit;
     PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );
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
    into prvn_flow_deals_const
       ( id, nd, acc, dat_add, vidd,  rnk,  tip,  daos, kv, sdate, acc8, dazs, kv8, wdate, i_cr9, pr_tr, fl2 )
  select bars_sqnc.get_nextval('PRVN_FLOWDEALS')
       , d.ND, SS.ACC, sysdate, d.VIDD, d.RNK, SS.TIP, SS.DAOS, SS.kv, d.sdate, SS.accc, SS.dazs, LIM.KV kv8,
               NVL( (select min(mdate) from cc_prol where nd= d.nd and npp = 0), d.wdate )       WDATE,
       decode( d.vidd,1,0,11,0, (select txt from nd_txt   where nd = d.nd and tag = 'I_CR9') )   I_CR9,
                                (select txt from nd_txt   where nd = d.nd and tag = 'PR_TR')     PR_TR,
                 1- (select substr(txt,2,1) from nd_txt   where nd = d.nd and tag = 'FLAGS')     FL2
   from cc_deal d, nd_acc n,
        (select * from accounts where tip = 'SS ' and nls like '2%') SS,
        (select * from accounts where tip = 'LIM' and nls like '8999%' and (dazs is null or dazs > l_dat31 ) ) LIM
  where d.vidd in (1, 2, 3, 11, 12, 13)  and d.sdate <= l_dat31  and d.sos >= 10
    and d.nd = n.nd and n.acc = SS.acc   and SS.accc = LIM.acc
    and not exists ( select 1 from prvn_flow_deals_const  where nd = d.nd and acc = SS.acc);

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
    and nvl( substr( PRVN_FLOW.get_nls ( d.nd, 'SS ') ,5,1),'*')  <> '9'     ;

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
    and not exists ( select 1 from bars.prvn_flow_deals_const where nd = d.nd and acc = ad.accs );

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
  ( dd          cc_deal%rowtype,
    p_dat01     date, p_k1 number,  p_acc number, p_kv number,  p_zo int,
    p_SD1  OUT  PRVN_FLOW_DEALS_VAR.SD1%type,
    p_SD2  OUT  PRVN_FLOW_DEALS_VAR.SD2%type,
    p_SNA  OUT  PRVN_FLOW_DEALS_VAR.SNA%type
  ) is
    G_DATE01 date ;
    G_DATE31 date ;
    sd1_  number  ;
    dStop_ date   ;
  begin
    G_DATE31 := p_dat01 - 1 ;
    G_DATE01 := trunc(G_DATE31,'Y')  ;
    p_SD1 := 0;
    p_SD2 := 0;
    p_SNA := 0;
    for k in ( select a.acc, a.tip from accounts a, nd_acc n
               where n.nd=dd.nd and n.acc=a.acc and a.tip in ('SDI','SPI','SNA','SP ','SS ') and kv = p_kv  )
    loop
       If    k.tip in ( 'SP ','SS ')  then
             begin
                select least ( nvl( STP_DAT, G_DATE31) , G_DATE31) 
                  into dStop_ from int_accn where id = 0 and acc= k.acc;
                acrn.p_int ( k.acc, 0, G_DATE01, dStop_, sd1_, null, 0) ;   P_SD1 := P_SD1 + sd1_ ;
             exception when no_data_found then   null;
             end ;

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
    raise_application_error( -20333,'Пока работаем только с числами 01. Ост с корр');
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
if p_mode in (20, 22, 0 )  then    l_first_dt := add_months(l_dat01,-1);
   for x0 in ( select * from prvn_flow_deals_const
                where (id=p_id or nvl(p_id,0)=0)
                  and ( vidd in ( 1, 2, 3) and p_mode in (20,0) 
                     or vidd in (11,12,13) and p_mode in (22,0) )
              order by nd, kv, id )
   loop
      delete from prvn_flow_deals_var  where id = x0.id  and zdat = l_dat01 ;  -- заголовки
      delete from prvn_flow_details    where id = x0.id  and mdat = l_dat01 ;  -- детали
      begin 
        select dazs into l_DAZS from accounts  where acc=              x0.acc8 ; -- Вопрос : когда прекратить обработку  суб/дог ? КД ЗАКРЫТ ПО ВСЕМ СВОИМ ТРАНШАМ !!!!
                                                                                 -- Ответ  : КД ЗАКРЫТ ПО ВСЕМ СВОИМ ТРАНШАМ !!!!
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

      If x0.acc is null  then xx.ost  := 0;  xx.ostq := 0;
                              xx.k    := 1;  xx.k1 := 1;
                              xx.ir   := acrn.fprocn(x0.acc8,0,l_dat31);

      else                    xx.ost  := - prvn_flow.qst_12(x0.acc,l_dat01,'2',l_ZO);
                              xx.ostq := gl.p_icurval(x0.kv, xx.ost,l_dat31 );
                              xx.ir   := acrn.fprocn(x0.acc, 0,l_dat31);
         If nd1_  <> x0.nd   then sum_k := 0 ;
            select  sum ( gl.p_icurval( a.kv, - prvn_flow.qst_12( a.acc, l_dat01, a.nbs, l_zo ), l_dat31 ) )
              into SUM_SS
              from accounts a, nd_acc n
            where n.nd = x0.nd and n.acc= a.acc and nbs like '2%'
              and ( a.tip in ( 'SS '       ) and x0.tip =  'SS ' or  a.tip in ( 'SP ','SL ' ) and x0.tip <> 'SS '  );
            SUM_SS := nvl( SUM_SS,0 ) ;
         end if;

         If sum_k  < 1 then
            if SUM_SS =0 then xx.k := 1;
            else              xx.k := least( 1-sum_k , xx.ostq/SUM_SS );
            end if;
            sum_k   := sum_k + xx.k;
         else  xx.k := 0;
         end if ;

         If nd1_  <> x0.nd OR kv1_  <> x0.kv  then sum_k1 := 0 ;
            select sum ( - prvn_flow.qst_12( a.acc, l_dat01, a.nbs, l_zo ) )
              into SUM_SS1
            from accounts a, nd_acc n
            where n.nd = x0.nd and nbs like '2%' and n.acc= a.acc and a.kv = x0.kv
              and ( a.tip in ( 'SS '       ) and x0.tip =  'SS ' or a.tip in ( 'SP ','SL ' ) and x0.tip <> 'SS '  );
            SUM_SS1 := nvl( SUM_SS1, 0);
         end if;

         If sum_k1 < 1 then
            if SUM_SS1 = 0 then xx.k1 := 1;
            else                xx.k1 := least( 1-sum_k1, xx.ost /SUM_SS1);
            end if;
            sum_k1 :=  sum_k1 + xx.k1 ;
         else                   xx.k1 := 0;
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

      insert into prvn_flow_deals_var ( sd1, sd2, sna, id, zdat, ost, ost8, ostq, ost8q, k1, k, ir, irr0, wdate, vidd, rnk, i_cr9, pr_tr )
      select G_SD1, G_SD2, G_SNA, x0.id,l_dat01,xx.ost,xx.ost8,xx.ostq,xx.ost8q,xx.k1,xx.k,xx.ir,xx.irr0,xx.wdate,xx.vidd,xx.rnk,
             (select txt from nd_txt where nd = dd.nd and tag  = 'I_CR9'),
             (select txt from nd_txt where nd = dd.nd and tag  = 'PR_TR')
      from dual ;

      -- детали
     if xx.k + xx.k1 > 0   then
        prvn_flow.add2_ss ( x0, xx, l_dat31, l_dat01, l_fla, l_fl_nd_acc, l_ZO ) ;
      end if;

      <<NOT_>> null ;
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
    l_ZO    int   := NVL(p_ZO, 1);      ii int_accn%rowtype           ; 
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
  If pul.Get_Mas_Ini_Val('sFdat1') = 'DEL_PV' then null ;
  ElsIf ( F_Cust = 3 and individuals_shd = 0 )  then GOTO End_FLOW_1;
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
                           WHEN a.tip = 'ODB' and a.NBS = '3579' THEN 'SK9' -- "ліва" фін.дебіторка (прострочений борг)
                           WHEN a.tip = 'ODB'  THEN 'SK0'                   -- "ліва" фін.дебіторка (нормальний   борг)
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
                   OR   a.nbs like '3%' and a.tip in ('SK0','SK9','ODB') and l_rcvb = 0
                   OR   a.nbs like '8%' and a.tip in ('SN8','SLK','SLK') 
                   OR   a.nbs = '3600' and ob22 = (CASE WHEN x0.vidd < 11  THEN '09' ELSE  '10' END ) -- для Корпор.Бизн 3600 с ОБ22 09, а для РБ - 3600 с ОБ22 10
                      )
             )
    loop

      If p_fla = 1
      then  --- из архива ( из снимков )
        If k.nbs like '8%' or k.nbs is null 
        then k.ost := fost ( k.acc, p_dat31) ;
        else k.ost := prvn_flow.qst_12 ( k.acc, p_dat01, k.nbs, l_ZO) ;
        end if ;
        k.ost := nvl( k.ost,0 ) ;
      end if ;
      
      If    x0.kv = k.kv or x0.kv is null     then  null  ;
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
          If    k.tip  in ('SDI')    then   l_sdi := l_sdi - k.ost ;
          ElsIf k.tip  in ('CR9')    then   l_cr9 := l_cr9 - k.ost ;
          ElsIf k.tip  in ('SN8')    then   l_sn8 := l_sn8 - k.ost ;
          ElsIf k.tip  in ('SK0')    then   l_sk0 := l_sk0 - k.ost ;
          ElsIf k.tip  in ('SK9')    then   l_sk9 := l_sk9 - k.ost ;
          ElsIf k.tip  in ('S36')    then   l_s36 := l_s36 - k.ost ;
          ----------------------------------------------------------------
          ElsIf k.tip  in ('SN '      )    then   l_sn  := l_sn  - k.ost ;
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
                  l_SpI       := l_SpI - tmp(d8).sn2  ;
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
 l_pv := 0  ; l_pv0 := 0; l_ki := 1 + nvl( xx.irr0, xx.ir ) / 100  ;
 d8   := tmp.first      ; -- установить курсор на  первую запись
 while d8 is not null loop
   tmp(d8).ss   := nvl( tmp(d8).ss  ,0) ;
   tmp(d8).sn   := nvl( tmp(d8).sn  ,0) ;
   tmp(d8).spn  := nvl( tmp(d8).spn ,0) ;
   tmp(d8).sno  := nvl( tmp(d8).sno ,0) ;
   tmp(d8).lim1 := nvl( tmp(d8).lim1,0) ;
   tmp(d8).lim2 := nvl( tmp(d8).lim2,0) ;
   tmp(d8).sp   := nvl( tmp(d8).sp  ,0) ;
   tmp(d8).sn1  := nvl( tmp(d8).sn1 ,0) ;
   tmp(d8).sn2  := nvl( tmp(d8).sn2 ,0) ;
   ---------------------------------------
If tmp(d8).ss  <> 0 OR tmp(d8).sn  <> 0 OR tmp(d8).lim1 <> 0 OR tmp(d8).lim2 <> 0 or
   tmp(d8).spn <> 0 OR tmp(d8).sno <> 0 OR tmp(d8).sp   <> 0 OR tmp(d8).sn1  <> 0 OR tmp(d8).sn2 <> 0 then

   insert into prvn_flow_details (mdat,fdat,ss,spd,sn,sk,lim1,lim2, dat1, dat2, spn, sno, sp, sn1, sn2, nd,id , IR)
     values ( p_dat01, tmp(d8).fdat, tmp(d8).ss, 0, tmp(d8).sn, 0, tmp(d8).lim1, tmp(d8).lim2, tmp(d8).dat1, tmp(d8).dat2,
              tmp(d8).spn, tmp(d8).sno, tmp(d8).sp , tmp(d8).sn1, tmp(d8).sn2, x0.nd ,x0.id ,  tmp(d8).ir );
End If;

   if tmp(d8).fdat >=  p_dat01 then
      l_s0  := round( tmp(d8).ss + tmp(d8).sp + tmp(d8).sn + tmp(d8).sn1 + tmp(d8).sn2 + tmp(d8).spn + tmp(d8).sno , 0 ) ;
      l_pv0 := l_pv0  + l_s0 ;  -- просто сумма потока

If l_ki >= 1 and l_ki <=2 then l_sd := round  ( l_s0 / power( l_ki, (tmp(d8).fdat - p_dat01 )/365 ),0) ;
else                           l_sd := 0;
end if ;
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
function Get_nls  (p_nd number, p_tip accounts.tip%type )
return varchar2
is --- получение номера лиц.счета
begin
  for k in (select a.kv|| '/' || a.nls NLS from accounts a, nd_acc n where n.nd = p_nd and n.acc = a.acc and a.tip = p_tip
            order by decode ( dazs , null, 1,2 ) , a.acc desc   )
   loop  return  k.NLS ;   end loop; return null;
end Get_nls;
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
    when no_data_found then   raise_application_error( -20333,'Рах.'||p_nls ||'/'|| p_kv || ' НЕ знайдено ');
  end;

  begin
    select d.* into dd1 from cc_deal d, nd_acc n where d.vidd = 150 and n.acc= aa1.acc and d.nd = n.nd ;
    raise_application_error( -20333,'Рах.'||p_nls ||'/'|| p_kv || ' уже прив"язан до угоди ' || dd1.nd);
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
                        from PRVN_FIN_DEB  fd
                        join ACCOUNTS an
                          on ( an.ACC = fd.ACC_SS )
                        left outer -- для перевірки на наявність значення R020_OB22_SS в FIN_DEBT.NBS_N
                        join ACCOUNTS ap
                          on ( ap.ACC = fd.ACC_SP )
                       where fd.ACC_SS <> fd.ACC_SP
                         and an.TIP    <> 'SK0'
                         and ap.TIP    <> 'SK9'
                    ) t
               left outer
               join FIN_DEBT d
                 on ( d.NBS_N = t.R020_OB22_SS )
              where d.NBS_N Is Null
                 or lnnvl ( d.NBS_P = t.R020_OB22_SP )
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
    
    commit;
    
    bars_audit.trace( $$PLSQL_UNIT||'.CLN_FIN_DEB: Exit.' );
    
  end CLN_FIN_DEB;

  ---
  -- ADD_FIN_DEB
  ---
  procedure ADD_FIN_DEB( p_dat date)
  is
    title   constant   varchar2(64) := $$PLSQL_UNIT||'.ADD_FIN_DEB';
    fd                 prvn_fin_deb%rowtype;
    l_eff_dt           date;
    l_chg_dt           prvn_fin_deb_arch.chg_dt%type;
    l_cls_dt           prvn_fin_deb_arch.cls_dt%type;
    l_err_tag          varchar2(30) := to_char(p_dat,'yyyymmdd')||'_'||to_char(sysdate,'yyyymmddhh24miss');
    cursor err_log
    is
    select cast( ACC_SS as number(24) )  as ACC_SS
         , cast( ACC_SP as number(24) )  as ACC_SP
         , cast( EFFECTDATE as date )    as EFFECTDATE
         , cast( KF as varchar2(6) )     as KF
         , cast( AGRM_ID as number(38) ) as AGRM_ID
      from PRVN_FIN_DEB_ERRLOG
     where ORA_ERR_TAG$ like '%'||l_err_tag
       and ORA_ERR_OPTYP$ = 'I'
       and ORA_ERR_MESG$ like '%UK_PRVNFINDEB_ACCSS%'
       for update;
  begin
    
    bars_audit.trace( '%s: Entry with ( p_dat=%s ).', title, to_char(p_dat,'dd.mm.yyyy') );
    
    l_eff_dt  := nvl(to_date(sys_context('bars_gl','bankdate'),'mm/dd/yyyy'),trunc(sysdate));
    
    l_chg_dt := sysdate;
    l_cls_dt := GL.BD();
    
    -- "закриття" зв`язку рахунків
    CLN_FIN_DEB( p_chg_dt => l_chg_dt 
               , p_cls_dt => l_cls_dt );
    
    if ( BARS_LOSS_EVENTS.G_RECEIVABLES )
    then
      
      bars_audit.info( title || ': BARS_LOSS_EVENTS.G_RECEIVABLES = TRUE' );
      
      -- Рах. фін. деб. кредитних договорів ('SK0','SK9')
      insert 
        into PRVN_FIN_DEB
           ( ACC_SS, ACC_SP, KF, AGRM_ID )
      select nvl(ACC_SS,ACC_SP) as ACC_SS
           , ACC_SP
           , KF
           , ND
        from ( select r.KF, r.ND
                    , a.ACC, a.TIP
                 from ND_ACC   r
                 join ACCOUNTS a
                   on ( r.KF = a.KF and r.ACC = a.ACC )
                 left 
                 join PRVN_FIN_DEB d
                   on ( d.AGRM_ID = r.ND )
                where a.TIP in ('SK0','SK9')
                  and a.NBS like '3%'
                  and a.DAOS <= p_dat
                  and ( a.DAZS is Null or a.DAZS > p_dat )
                  and d.AGRM_ID IS Null 
             ) pivot ( max(ACC) for TIP in ( 'SK0' as ACC_SS, 'SK9' as ACC_SP ) )
         log errors
        into PRVN_FIN_DEB_ERRLOG( 'CCK_'||l_err_tag )
      REJECT LIMIT UNLIMITED;
      
      bars_audit.info( title || ': CCK (SK0+SK9) '||to_char(sql%rowcount)||' row(s) inserted.' );
      
      -- Рах. фін. деб. Кредитних Договорів ('ODB')
      merge
        into PRVN_FIN_DEB d
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
                          from ND_ACC   r
                          join ACCOUNTS a
                            on ( r.KF = a.KF and r.ACC = a.ACC )
                          left 
                          join PRVN_FIN_DEB d
                            on ( d.KF = r.KF and d.AGRM_ID = r.ND )
                          join ( with NBSOB22 as ( select rownum as ROW_NUM
                                                        , NBS_N, NBS_P
                                                        , SubStr(NBS_N,1,4) as SS_NBS
                                                        , SubStr(NBS_N,5,2) as SS_OB22 
                                                        , SubStr(NBS_P,1,4) as SP_NBS
                                                        , SubStr(NBS_P,5,2) as SP_OB22
                                                     from FIN_DEBT
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
                         where a.TIP = 'ODB'
                           and a.NBS like '3%'
                           and a.DAOS <= p_dat
                           and lnnvl( a.DAZS <= p_dat )
                           and d.AGRM_ID IS Null
                      ) pivot ( max(ACC) for ACC_TP in ( 'SS' as ACC_SS, 'SP' as ACC_SP ) )
             ) t
          on ( t.ACC_SS = d.ACC_SS )
        when MATCHED
        then update -- зявився рахунок прострочки
                set d.ACC_SP  = t.ACC_SP
--                , d.AGRM_ID = t.ND
--                , d.EFFECTDATE = 
              where d.ACC_SP  = d.ACC_SS
        when NOT MATCHED 
        then insert ( ACC_SS, ACC_SP, KF, AGRM_ID )
             values ( t.ACC_SS, t.ACC_SP, t.KF, t.ND )
         log errors
        into PRVN_FIN_DEB_ERRLOG( 'CCK_'||l_err_tag )
         REJECT LIMIT UNLIMITED;
      
      bars_audit.info( title || ': CCK (ODB) '||to_char(sql%rowcount)||' row(s) merged.' );
      
      -- Рах. фін. деб. БПК
      insert 
        into PRVN_FIN_DEB
           ( ACC_SS, ACC_SP, KF, AGRM_ID )
      select nvl(ACC_3570,ACC_3579) as ACC_SS
           , ACC_3579
           , KF
           , ND
        from ( select ACC_3570, ACC_3579
                    , sys_context('bars_context','user_mfo') as KF
                    , ND
                 from W4_ACC
                where coalesce( ACC_3570, ACC_3579, 0 ) > 0
                  and DAT_CLOSE Is Null
                union all
               select ACC_3570, ACC_3579, KF, ND
                 from BPK_ACC
                where coalesce( ACC_3570, ACC_3579, 0 ) > 0
                  and DAT_CLOSE Is Null
             )
         log errors
        into PRVN_FIN_DEB_ERRLOG( 'BPK_'||l_err_tag )
      REJECT LIMIT UNLIMITED;
      
      bars_audit.info( title || ': BPK '||to_char(sql%rowcount)||' row(s) inserted.' );
      
      --------------------
      -- parsing errors --
      --------------------
      
      open err_log;
      
      loop
        
        fetch err_log
         into fd;
         
        exit when err_log%NOTFOUND;
        
        savepoint SP_ERRLOG;
        
        begin
          
          -- 1) insert into PRVN_FIN_DEB_ARCH from PRVN_FIN_DEB
          insert
            into PRVN_FIN_DEB_ARCH
               ( CHG_ID, CHG_DT, CLS_DT, KF, ACC_SS, ACC_SP, EFFECTDATE, AGRM_ID )
          values
               ( S_PRVN_FIN_DEB_ARCH.NextVal, l_chg_dt, l_cls_dt
                , fd.KF, fd.ACC_SS, fd.ACC_SP, fd.EFFECTDATE, fd.AGRM_ID );
          
          -- 2) delete from PRVN_FIN_DEB
          delete
            from PRVN_FIN_DEB
           where ACC_SS = fd.ACC_SS;
          
          -- 3) insert into PRVN_FIN_DEB from PRVN_FIN_DEB_ERRLOG
          insert
            into PRVN_FIN_DEB
          values fd;
          
          -- 4) delete from PRVN_FIN_DEB_ERRLOG ( where current of )
          delete 
            from PRVN_FIN_DEB_ERRLOG
           where current of err_log;
          
        exception
          when OTHERS then
           bars_audit.error( title ||': ACC_SS='||to_char(fd.ACC_SS)||chr(10)||sqlerrm );
           rollback to SP_ERRLOG;
        end;
        
      end loop;
      
      close err_log;
      
      -- all ACC_SS
      insert 
        into PRVN_FIN_DEB
           ( ACC_SS, EFFECTDATE, KF )
      select a.ACC, l_eff_dt, a.KF
        from ACCOUNTS a
        join ( select SubStr(NBS_N,1,4) as R020
                    , SubStr(NBS_N,5,2) as OB22
                 from FIN_DEBT
                where NBS_N Like '3%'
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
    
    for k in ( select a.RNK, a.NBS, a.OB22, a.ACC as ACC_SP, a.KV, a.DAOS, a.BRANCH
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
      
      fd.ACC_SS := null;
      
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
             and rownum = 1 ;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            null;
        end;
      end if;
      
      If ( fd.ACC_SS is not null )
      then
        
        fd.EFFECTDATE := l_eff_dt;
        fd.ACC_SP     := k.ACC_SP;
        
        insert into PRVN_FIN_DEB values FD;
        
      Else
        Null; -- BAD
      end if;
      
    end loop;
    
    bars_audit.trace( '%s: Exit.', title );
    
  end ADD_FIN_DEB;
    
  --
  --
  --
  function HEADER_VERSION 
    return varchar2
  is
  begin
    return 'Package header PRVN_FLOW '||g_header_version;
  end HEADER_VERSION;
  
  --
  --
  --
  function BODY_VERSION
    return varchar2
  is
  begin
    return 'Package body PRVN_FLOW '||g_body_version;
  end BODY_VERSION;



begin
  null;
end PRVN_FLOW;
/

show err

grant execute on PRVN_FLOW to BARS_ACCESS_DEFROLE;
grant execute on PRVN_FLOW to RCC_DEAL;
grant execute on PRVN_FLOW to START1;
grant execute on PRVN_FLOW to BARSUPL, UPLD;
