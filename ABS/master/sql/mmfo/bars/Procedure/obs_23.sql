

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OBS_23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OBS_23 ***

  CREATE OR REPLACE PROCEDURE BARS.OBS_23 
 (DAT_ date,
  ND_ int,
  p_mode NUMBER   DEFAULT 0
  ) IS
/* Версия 11-01-2016 (08-10-2015)

 21-07-2016 LUDA Переполнение индекса массива (поменяла на символьный)
 14-07-2016 LUDA Изменена выборка по МБДК + БПК по вьюшкам
 09-12-2015 LUDA Снимки (параметр dat31_, был dat01_)
 ----------------08-10-2015
 08-10-2015 LUDA Визначення внутрішнього кредитного рейтингу в залежності від кількості днів прострочки
                 по портф.методу (№11/1-16-299 Колесникову Ю.В.)
 15-10-2014 LUDA По ОВЕРАМ вставила проверку на остаток по счету 2067,2069
 25-04-2014 LUDA Добавлено обслуживание долга по ОВЕРАМ
 13-02-2014 LUDA для БПК, у которых нет лимита, но вышли в "минус" передернуть OBS.
 27-01-2014 LUDA Параметры DATSP, DASPN. Если есть только один параметр, то второй расчитывается.
 23-11-2012 LUDA Терялись закрые договора на текущий день, но открытые на дату расчета
 07-12-2012 LUDA Обслуживание долга по БПК (по пустым заполнение fin=1 obs=1 и пересчет кат.качества и коэф.риска


p_mode = 0 Для КП. CC_DEAL
p_mode = 1 Для OVR ACC_OVER
p_mode = 2 Для БАНКОВ и КОРРСЧЕТОВ
p_mode = 3 Для БПК в Ощ.банке,  ND_ - не анализируем

*/

  -- автоматичне визначення параметру "обслуговування боргу" по пост.№23.
  -- ND_ =  0 для всех КД
  -- ND_ = -2 для всех КД  ЮЛ
  -- ND_ = -3 для всех КД  ФЛ
  -- ND_ >  0 для 1 КД

  -- (STAN_OBS23)
  -- 1 - високе
  -- 2 - добре
  -- 3 - задовiльне
  -- 4 - слабке
  -- 5 - незадов.


  type t_obs_ is record (rnk     int,
                         obs_old int,
                         obs_new int);
  type t_mas_obs_ is table of t_obs_ index by varchar2(50);
       ND_bad_ varchar2(50);
       i       varchar2(50);
       j       varchar2(50);

  TYPE CurTyp IS REF CURSOR;
  c0 CurTyp;


  l_kat23  number;
  l_fin23  number;
  l_k23    number;
  l_rnk    number;
  l_vkr    number;
  fin_     number;
  SP_      number;
  SL_      number;
  SPN_     number;
  SK9_     number;
  PR_      number;
  KOL_     int   ;
  KOL_N    int   ;
  FDAT_    date  := DAT_;
  DATP_    date  ;
  DATSP_   varchar2(30);
  DASPN_   varchar2(30);
  l_tag    varchar2(5);
  OBS_     int   ;
  OBS_bpk_ int   ;
  OBS_N    int   ;
  OPEN_    int   ;
  SUM_KOS  number;
  dat31_   date  ; -- последний рабочий день месяца
  DP_      Varchar2(20);
  TXT_     varchar2(60):='НЕвизначенВисоке(1) Добре(2) Задовiл(3)Слабке(4) Незадов(5)';
  mas_obs_ t_mas_obs_;
  sSql_    varchar2 (200);
  l_txt    BPK_PARAMETERS.value%type;
  -----------------------------------------------------------------------------------------
  -- Снимки
  sid_     varchar2(64)     ;
  sess_    varchar2(64)     :=bars_login.get_session_clientid;
  l_GET_SNP_RUNNING number  ;
  --------------------------

  begin

     z23.CHEK_modi(DAT_) ;

/* Убраны снимки. Должны быть сформированы
     begin
        select BARS_UTL_SNAPSHOT.GET_SNP_RUNNING into l_GET_SNP_RUNNING from dual;
     EXCEPTION WHEN NO_DATA_FOUND THEN l_GET_SNP_RUNNING := 0;
     end;
     if l_GET_SNP_RUNNING = 1 THEN

        SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
        sid_:=SYS_CONTEXT('BARS_GLPARAM','MONBAL');
        SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

        begin
           select sid into sid_ from v$session
            where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
           raise_application_error(-20000,'Формується знімок балансу. Зачекайте і повторіть знову SID '|| sid_);
        exception
           when no_data_found THEN   BARS_UTL_SNAPSHOT.stop_running;
        end;

     end if;

     if sysdate>dat_ THEN
        BARS_UTL_SNAPSHOT.sync_month(dat31_);
     end if;
     BARS_UTL_SNAPSHOT.start_running;
*/

     dat31_ := Dat_last (dat_ - 4, dat_-1 ) ;
     z23.to_log_rez (user_id , 30 , dat_ ,'Начало Обслуживание долга '||p_mode);

     l_tag  := 'VNCRR';

     -- Обслуживание долга по БПК
     if p_mode=3 THEN -- and ( getglobaloption('MFOP') = '300465' or gl.aMfo = '300465' ) then

        -- obs23 = 1 для договоров где нет счетов просрочки 2207,2209
        -- для портфельного метода kat23=1, k23=0.02, kol_sp=0
        -- для определения к-ва дней просрочки добавлен счет 3579 и 2625 (OSTC<0) (письмо Петращук Иван 06-11-2015)
        begin
           -- обычные договора
           for k in (select 'BPK' tip, b.nd, b.acc_2207,b.acc_2209,b.acc_3579,nvl(s250,'0') s250 from v_bbpk_acc b
                     where acc_2207 is null and acc_2209 is null and acc_3579 is null and obs23<>1
                           -- and acc_pk  not in (select acc_pk from v_bbpk_acc b4  where ost_korr(b4.acc_pk,dat31_,null,'2625')<0 )
                           and nvl(s250,'0')<>'8'  union all
                     select 'W4'     , w.nd, w.acc_2207,w.acc_2209,w.acc_3579,nvl(s250,'0') s250 from v_w4_acc w
                     where acc_2207 is null and acc_2209 is null and acc_3579 is null and obs23<>1
                           --and acc_pk not in (select acc_pk from v_w4_acc w4 where ost_korr(w4.acc_pk,dat31_,null,'2625')<0 )
                           and nvl(s250,'0')<>'8'
                    )
           loop

              if k.tip = 'BPK' THEN
                 update bpk_acc set obs23=1,kol_sp=0 where nd=k.nd;
              end if;
              if k.tip = 'W4' THEN
                 update w4_acc set obs23=1,kol_sp=0 where nd=k.nd;
              end if;

           end loop;
           commit;

           -- портфельный метод и нет счетов просрочки  ---> fin=1, obs=1, kat=1 k=0.02 VKR='ААА'
           for k in (select 'BPK' tip, b.nd, b.acc_2207, b.acc_2209,b.acc_3579, nvl(s250,'0') s250, a.rnk
                     from   v_bbpk_acc b, accounts a
                     where  acc_2207 is null and acc_2209 is null and b.acc_3579 is null and nvl(s250,'0') = '8'
                            --and acc_pk not in (select acc_pk from  v_bbpk_acc b4 where ost_korr(b4.acc_pk,dat31_,null,'2625')<0 )
                            and b.acc_pk = a.acc
                     union all
                     select 'W4'     , w.nd, w.acc_2207, w.acc_2209,w.acc_3579,nvl(s250,'0') s250, a.rnk
                     from   v_w4_acc w , accounts a
                     where  acc_2207 is null and acc_2209 is null and w.acc_3579 is null and nvl(s250,'0') = '8'
                            --and acc_pk  not in (select acc_pk from v_w4_acc w4 where ost_korr(w4.acc_pk,dat31_,null,'2625')<0 )
                            and w.acc_pk = a.acc
                    )

           loop
              begin
                  select bp.value into l_txt from  BPK_PARAMETERS bp where bp.nd = k.nd and bp.tag = l_tag;
              EXCEPTION WHEN NO_DATA_FOUND THEN l_txt := '0';
              end;
              if l_txt <> 'ААА' THEN
                 FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ААА');
              end if;

              if k.tip = 'BPK' THEN
                 update bpk_acc set fin23 = 1, obs23 = 1   where nd=k.nd and (fin23 <> 1 or obs23 <> 1);
                 update bpk_acc set kat23 = 1, k23 = 0.02, kol_sp=0 where nd=k.nd and (kat23 <> 1 or k23 <> 0.02 or kol_sp <>0);
              end if;
              if k.tip = 'W4' THEN
                 update w4_acc  set fin23 = 1, obs23 = 1   where nd=k.nd and (fin23 <> 1 or obs23 <> 1);
                 update w4_acc  set kat23 = 1, k23 = 0.02, kol_sp=0 where nd=k.nd and (kat23 <> 1 or k23 <> 0.02 or kol_sp <>0);
              end if;
           end loop;
           commit;
        end;
        -- расчет по договорам , где есть счета просрочки
        begin
           for k in (select 'BPK' tip, b.nd, b.acc_2207,b.acc_2209,b.acc_3579,b.acc_pk,nvl(s250,'0') s250, a.rnk
                     from   v_bbpk_acc b, accounts a
                     where (acc_2207 is not null OR acc_2209 is not null OR acc_3579 is not null
                            --OR (acc_pk is not null and ost_korr(b.acc_pk,dat31_,null,'2625')<0)
                           ) and b.acc_pk = a.acc union all
                     select 'W4'     , w.nd, w.acc_2207,w.acc_2209,w.acc_3579,w.acc_pk,nvl(s250,'0') s250, a.rnk
                     from   v_w4_acc w , accounts a
                     where (acc_2207  is not null OR acc_2209 is not null OR acc_3579 is not null
                            --OR (acc_pk is not null and ost_korr(w.acc_pk,dat31_,null,'2625')<0)
                           ) and w.acc_pk = a.acc
                    )
           loop

              kol_:=0;
              obs_bpk(dat_,k.acc_2207,k.acc_2209,k.acc_3579,k.acc_pk,obs_bpk_,kol_);

              if k.s250 = '8' THEN
                 If    nvl(kol_,0)  =  0  then l_kat23 :=1; l_k23 := 0.02; l_fin23 := 1; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ААА');
                 ElsIf nvl(kol_,0) <=  3  then l_kat23 :=1; l_k23 := 0.02; l_fin23 := 1; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'АА');
                 ElsIf nvl(kol_,0) <=  7  then l_kat23 :=1; l_k23 := 0.02; l_fin23 := 1; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'А');
                 ElsIf nvl(kol_,0) <= 15  then l_kat23 :=2; l_k23 := 0.10; l_fin23 := 2; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'БББ');
                 ElsIf nvl(kol_,0) <= 24  then l_kat23 :=2; l_k23 := 0.10; l_fin23 := 2; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ББ');
                 ElsIf nvl(kol_,0) <= 30  then l_kat23 :=2; l_k23 := 0.10; l_fin23 := 2; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'Б');
                 ElsIf nvl(kol_,0) <= 50  then l_kat23 :=3; l_k23 := 0.40; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ВВВ');
                 ElsIf nvl(kol_,0) <= 70  then l_kat23 :=3; l_k23 := 0.40; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ВВ');
                 ElsIf nvl(kol_,0) <= 90  then l_kat23 :=3; l_k23 := 0.40; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'В');
                 ElsIf nvl(kol_,0) <=120  then l_kat23 :=4; l_k23 := 0.80; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ГГГ');
                 ElsIf nvl(kol_,0) <=150  then l_kat23 :=4; l_k23 := 0.80; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ГГ');
                 ElsIf nvl(kol_,0) <=180  then l_kat23 :=4; l_k23 := 0.80; l_fin23 := 4; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'Г');
                 Else                          l_kat23 :=5; l_k23 := 1   ; l_fin23 := 4; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'Г');
                 end if;
                 if k.tip = 'BPK' THEN

                    update bpk_acc set fin23 = l_fin23 where nd=k.nd;
                    update bpk_acc set kat23 = l_kat23, k23 = l_k23, kol_sp = kol_ where nd=k.nd;
                 else
                    update w4_acc  set fin23 = l_fin23 where nd=k.nd;
                    update w4_acc  set kat23 = l_kat23, k23 = l_k23, kol_sp = kol_ where nd=k.nd;

                 end if;
              else
                 if k.tip = 'BPK' THEN
                    update bpk_acc set obs23=obs_bpk_,kol_sp=kol_ where nd=k.nd;
                 else
                    update w4_acc set obs23=obs_bpk_,kol_sp=kol_ where nd=k.nd;
                 end if;
              end if;

           end loop;
           commit;
        end;

        begin

           ---- не заполнены парметры (счет новый)
           for k in (select 'BPK' BPK, b.nd, b.FIN23, b.OBS23, b.KAT23, b.K23, b.ACC_PK, b.ACC_OVR, b.ACC_2208,
                            b.aCC_2207, b.ACC_2209, b.ACC_9129, nvl(b.s250,'0') s250, a.rnk from v_bbpk_acc b, accounts a
                     where (b.fin23 is null or b.obs23 is null or b.kat23 is null) and b.acc_pk = a.acc union all
                     select 'W4'  BPK, w.nd, w.FIN23, w.OBS23, w.KAT23, w.K23, w.ACC_PK, nvl(w.ACC_OVR,w.acc_2203), w.ACC_2208,
                            w.aCC_2207, w.ACC_2209, w.ACC_9129, nvl(w.s250,'0') s250, a.rnk from v_w4_acc w , accounts a
                     where (w.fin23 is null or w.obs23 is null or w.kat23 is null or (w.acc_9129 is null
                           and ost_korr(w.acc_pk,dat31_,null,'2625')<0) ) and w.acc_pk = a.acc)
                     -- для БПК, у которых нет лимита но вышли в "минус" передернуть OBS.
           loop

              fin_:=1;
              obs_:=1;

              if k.bpk='BPK' THEN
                 if k.s250 = '8' THEN
                    FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ААА');
                    update bpk_acc set kat23=1, k23=0.02,kol_sp=0 where nd=k.nd;
                 else
                    update bpk_acc set obs23=nvl(k.obs23,obs_), fin23=nvl(k.fin23,fin_) where nd=k.nd;
                 end if;
              else
                 if k.s250 = '8' THEN
                    FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ААА');
                    update w4_acc set kat23=1, k23=0.02,kol_sp=0 where nd=k.nd;
                 else
                    update W4_acc set obs23=nvl(k.obs23,obs_), fin23=nvl(k.fin23,fin_) where nd=k.nd;
                 end if;
              end if;
           end loop;
           commit;
        end;

        z23.to_log_rez (user_id , -30 , dat_ ,'Конец Обслуживание долга '||p_mode);
        RETURN;
     end if;
     ------------------------------------------------------------------------------------

     if p_mode not in (0,1,2) THEN
        RETURN;
     end if;

     -- обслуживание долга для банков и коррсчетов
     If p_mode = 2 THEN

        begin
/*
           for k in (select d.nd, d.vidd, 1 OBS,d.SDATE sdate,d.rnk, d.WDATE wdate,s.ostf-s.dos+s.kos ost
                     from   cc_deal d,saldoa s,cc_add ad,v_gl a
                     where  d.sos >=10 and d.sos<14 and  d.vidd >1000  and ad.accs=a.acc and d.nd=ad.nd
                            and ad.adds=0 and ad.accs=s.acc and s.ostf-s.dos+s.kos<>0 and d.wdate = a.mdate --   and d.obs23 is null
                            and (s.acc,s.fdat)=(select acc,max(fdat) from saldoa where acc=s.acc and fdat<=DAT_31 group by acc)
                    )
           LOOP
*/
           for k in (SELECT d.nd, d.vidd, 1 obs, d.sdate, D.RNK, d.wdate, - ost_korr(a.acc,dat31_,null,a.nbs) ost
                     FROM  (select * from accounts where  nbs >='1500'  and nbs < '1600') a,
                           (select * from cc_deal  where  ((vidd> 1500  and vidd<  1600) or vidd=150) and sdate <  dat_
                                                     and  (sos> 9       and sos <  15    or  wdate >= dat31_ )) d, nd_acc ad
                     WHERE  a.acc = ad.acc and d.nd = ad.nd  and  ost_korr(a.acc,dat31_,null,a.nbs)<0
                       and  d.nd  =(select max(n.nd) from nd_acc n,cc_deal d1
                                    where  n.acc   = a.acc and  n.nd = d1.nd and  ((d1.vidd> 1500  and d1.vidd  <  1600) or d1.vidd=150 )
                                      and  d1.sdate< dat_  and ( sos > 9     and  sos      < 15    or  d1.wdate >= dat31_ ) )
                   )

           LOOP

              begin

                 OBS_:=0;
                 KOL_:=dat_-k.wdate;

                 if (k.wdate+30 <= DAT_) then OBS_:=5; end if;
                 IF obs_<5 THEN
                    If KOL_>0 then
                       If    KOL_<= 3  then OBS_:=greatest(1,OBS_);
                       ElsIf KOL_<= 7  then OBS_:=greatest(2,OBS_);
                       ElsIf KOL_<=14  then OBS_:=greatest(3,OBS_);
                       ElsIf KOL_<=30  then OBS_:=greatest(4,OBS_);
                       Else                 OBS_:=greatest(5,OBS_);
                       end if;
                    else
                       OBS_:=1;
                    end if;
                 END if;
              end;
              mas_obs_(k.nd).rnk:=k.rnk;
              mas_obs_(k.nd).obs_old:=k.obs;
              mas_obs_(k.nd).obs_new:=OBS_;
           END LOOP;

           i:=mas_obs_.first;
           LOOP
              EXIT WHEN i IS NULL;
              OBS_:=mas_obs_(i).obs_new;
              j:=mas_obs_.first;
              loop
                 EXIT WHEN j IS NULL;
                 if mas_obs_(i).rnk=mas_obs_(j).rnk and mas_obs_(j).obs_new>=OBS_ then
                    ND_BAD_:=j;
                    OBS_:= mas_obs_(j).obs_new;
                 end if;
                 j:=mas_obs_.NEXT(j);
              END LOOP;

              if mas_obs_(i).obs_new=OBS_ THEN --and mas_obs_(i).obs_old <> mas_obs_(i).obs_new  then
                 update cc_deal set obs23=OBS_ where nd=i;
              else
                 -- в следствии обс других договоровдоговор
                 -- у наслўдок ослуговування боргу дог №=
                 If nvl(mas_obs_(i).obs_old,0) <> OBS_ then
                    update cc_deal set obs23=OBS_ where nd=i;
                 end if;
              end if;
              i:=mas_obs_.NEXT(i);
           end loop;
        end;
     end if;
     --Обслуживание долга для кредитов
     ------------------------------------------
     if p_mode=0 THEN
        for k in (select d.nd, d.vidd, d.OBS23 OBS,d.SDATE sdate,d.rnk, d.WDATE wdate, d.kprolog, s250, kat23, k23, fin23
                  from  cc_deal d
                  where (d.vidd in (1,2,3,11,12,13) and ND_ in (0, d.ND) OR d.vidd in (1,2,3) and ND_=-2
                         OR d.vidd in (11,12,13) and  ND_=-3)
                 )
        LOOP

           OBS_   :=1;
           OBS_N  :=1;
           --logger.INFO('OBS23 - nd='||k.nd||'Обс.='||obs_);
           KOL_   :=0;
           kol_n  :=0;
           DATP_  :=NULL;
           l_fin23:=k.fin23;
           l_kat23:=k.kat23;
           l_k23  :=k.k23;
           begin
              begin
                 SELECT 1 into OPEN_  FROM   ND_ACC N, ACCOUNTS A
                 WHERE  N.ND = k.ND  AND N.ACC = A.ACC AND A.TIP='LIM' and  (DAZS is NULL or DAZS>=DAT_);
              EXCEPTION WHEN NO_DATA_FOUND THEN
                 OPEN_ := 0;
              END;
              if OPEN_=1 THEN

                 DATSP_:= nvl(cck_app.Get_ND_TXT(K.ND,'DATSP'),'9');
                 DASPN_:= nvl(cck_app.Get_ND_TXT(K.ND,'DASPN'),'9');

                 if DATSP_ <>'9' and DASPN_ <>'9'  THEN
                    DATP_:=least(to_date(DATSP_,'dd/mm/yyyy'),to_date(DASPN_,'dd/mm/yyyy'));
                    pr_:=4;
                 ELSIF DATSP_ <>'9' THEN
                    DATP_ := to_date(DATSP_,'dd/mm/yyyy');
                    pr_:=2;
                 ELSIF DASPN_ <>'9' THEN
                    DATP_ := to_date(DASPN_,'dd/mm/yyyy');
                    pr_:=3;
                 ELSe
                    DATP_ := NULL; -- to_date('01-01-1900','dd-mm-yyyy');
                    pr_:=1;
                 end if;

                 if DATP_ is not null THEn
                    KOL_ := DAT_- DATP_;
                    If KOL_>0 then
                       kol_n:=greatest(kol_n,kol_);
                       If    KOL_<= 7  then OBS_:=greatest(1,OBS_);
                       ElsIf KOL_<=30  then OBS_:=greatest(2,OBS_);
                       ElsIf KOL_<=90  then OBS_:=greatest(3,OBS_);
                       ElsIf KOL_<=180 then OBS_:=greatest(4,OBS_);
                       Else                 OBS_:=greatest(5,OBS_);
                       end if;
                    end if;
                    if pr_=4 THEN
                       goto M1;
                    end if;
                 end if;

                 OBS_n:= 1 ;  ---nvl(k.obs,1);
                 if (k.wdate+180 <= DAT_) then
                    OBS_  := 5;
                    KOL_n := dat_-k.wdate;
                    KOL_  := kol_n;
                    GOTO M1;
                 end if;
                 --узнать тек остаток
                 begin
                    select Nvl(sum(decode (a.tip,'SP ',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
                           Nvl(sum(decode (a.tip,'SPN',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
                           Nvl(sum(decode (a.tip,'SK9',ost_korr(a.acc,dat31_,null,a.nbs),0)),0),
                           Nvl(sum(decode (a.tip,'SL ',ost_korr(a.acc,dat31_,null,a.nbs),0)),0)
                     into  SP_,SPN_,SK9_,SL_
                     from  accounts a, nd_acc n
                     where a.acc=n.acc and n.nd=k.nd
                       and (trim(tip) = decode (pr_, 1 , 'SP' ,2,'SP',3,'SPN' ) or
                            trim(tip) = decode (pr_, 1 , 'SL' ,2,'SL',3,'SK9' ) or
                            trim(tip) = decode (pr_, 1 , 'SPN',2, '' ,3, ''   ) or
                            trim(tip) = decode (pr_, 1 , 'SK9',2, '' ,3, ''   ));
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    SP_  := 0;
                    SPN_ := 0;
                    SK9_ := 0;
                    SL_  := 0;
                 end;

                 if SP_<> 0 or SPN_ <> 0 or SK9_ <> 0 or SL_ <> 0 THEN
                    -- УЗНАЕМ НА СКОЛЬКО ДНЕЙ ПРОСРОЧЕНО ТЕЛО КРЕДИТА
                    DECLARE
                    TYPE r0Typ IS RECORD ( TIP accounts.TIP%type);
                    sp r0Typ;
                    begin
                       If pr_ = 1 THEN
                          OPEN c0 FOR
                          select 'SP ' tip from dual where SP_ <>0 union all
                          select 'SPN' tip from dual where SPN_<>0 union all
                          select 'SK9' tip from dual where SK9_<>0 union all
                          select 'SL ' tip from dual where SL_ <>0;
                       elsif pr_ = 2 THEN
                          OPEN c0 FOR
                          select 'SP ' tip from dual where SP_ <>0 union all
                          select 'SL ' tip from dual where SL_ <>0;
                       else
                          OPEN c0 FOR
                          select 'SPN' tip from dual where SPN_<>0 union all
                          select 'SK9' tip from dual where SK9_<>0;
                       end if;
                       loop
                          FETCH c0 INTO sp;
                          EXIT WHEN c0%NOTFOUND;

                          KOL_:=0;
                          FDAT_:= DAT_;

                          -- узнаем сумму всех кредитовых оборотов
                          begin
                             select sum(s.kos) into   SUM_KOS from   saldoa s, v_gl a, nd_acc n
                             where  a.acc=s.acc and a.acc=n.acc and n.nd=k.ND and a.tip=sp.TIP and s.FDAT<DAT_
                                    and s.fdat>=k.sdate;
                          EXCEPTION WHEN NO_DATA_FOUND THEN SUM_KOS := 0;
                          end;
                          -- case введен из за  пост миграционных баз данный в которых остаток появляется без оборотов
                          for p in (select s.fdat,sum(case when fdat=(select min(fdat) from saldoa ss where acc=a.acc) then
                                                         greatest(-s.ostf,s.dos)
                                                      else
                                                         s.dos end) DOS
                                    from   saldoa s, v_gl a, nd_acc n
                                    where  a.acc=s.acc and a.acc=n.acc and n.nd=k.ND and a.tip=sp.TIP and s.FDAT<DAT_
                                           and s.fdat>=k.sdate
                                    group by s.fdat
                                    order by s.fdat
                                   )
                          loop
                             SUM_KOS:= SUM_KOS - p.DOS;
                             If SUM_KOS < 0 then
                                KOL_ := DAT_- p.FDAT;
                                EXIT;
                             end if;
                          end loop;
                          If KOL_>0 then
                             kol_n:=greatest(kol_n,kol_);
                             If    KOL_<= 7  then OBS_n:=greatest(1,OBS_n);
                             elsIf KOL_<=30  then OBS_n:=greatest(2,OBS_n);
                             ElsIf KOL_<=90  then OBS_n:=greatest(3,OBS_n);
                             ElsIf KOL_<=180 then OBS_n:=greatest(4,OBS_n);
                             Else                 OBS_n:=greatest(5,OBS_n);
                             end if;
                          end if;
                       end loop;
                    end;
                 else
                    OBS_:=1;  --- obs_=1???
                 end if;
                 << m1 >> NULL;
                 obs_:=greatest(obs_n,OBS_);
                 if k.s250 = '8' THEN
                    If    nvl(kol_n,0)  =  0  then l_kat23 :=1; l_k23 := 0.02; l_fin23 := 1; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ААА');
                    ElsIf nvl(kol_n,0) <=  3  then l_kat23 :=1; l_k23 := 0.02; l_fin23 := 1; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'АА');
                    ElsIf nvl(kol_n,0) <=  7  then l_kat23 :=1; l_k23 := 0.02; l_fin23 := 1; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'А');
                    ElsIf nvl(kol_n,0) <= 15  then l_kat23 :=2; l_k23 := 0.10; l_fin23 := 2; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'БББ');
                    ElsIf nvl(kol_n,0) <= 24  then l_kat23 :=2; l_k23 := 0.10; l_fin23 := 2; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ББ');
                    ElsIf nvl(kol_n,0) <= 30  then l_kat23 :=2; l_k23 := 0.10; l_fin23 := 2; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'Б');
                    ElsIf nvl(kol_n,0) <= 50  then l_kat23 :=3; l_k23 := 0.40; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ВВВ');
                    ElsIf nvl(kol_n,0) <= 70  then l_kat23 :=3; l_k23 := 0.40; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ВВ');
                    ElsIf nvl(kol_n,0) <= 90  then l_kat23 :=3; l_k23 := 0.40; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'В');
                    ElsIf nvl(kol_n,0) <=120  then l_kat23 :=4; l_k23 := 0.80; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ГГГ');
                    ElsIf nvl(kol_n,0) <=150  then l_kat23 :=4; l_k23 := 0.80; l_fin23 := 3; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'ГГ');
                    ElsIf nvl(kol_n,0) <=180  then l_kat23 :=4; l_k23 := 0.80; l_fin23 := 4; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'Г');
                    Else                           l_kat23 :=5; l_k23 := 1   ; l_fin23 := 4; FIN_ZP.SET_ND_VNCRR(k.nd, k.rnk, 'Г');
                    end if;

                 end if;
                 update cc_deal set obs23 = OBS_, fin23 = l_fin23, kol_sp = kol_n where nd=k.nd;
                 if k.s250 = '8' THEN
                    update cc_deal set kat23=l_kat23, k23=l_k23 where nd=k.nd;
                 end if;
              end if;
              commit;
           end;
        end loop;
     end if;
     if p_mode=1 THEN
        --Обслуживание долга для ОВЕРДРАФТОВ
        begin
           for k in (select distinct nd from acc_over)
           LOOP
              obs_:=1;
              begin
                 for d in ( select * from (select acc,ost_korr(acc,dat31_,null,nbs) ost from accounts
                                           where acc in (select acco from acc_over where nd=k.nd) AND NBS IN ('2067','2069')  union all
                                           select acc,ost_korr(acc,dat31_,null,nbs) ost from accounts
                                           where NBS IN ('2067','2069')
                                                 AND acc in  (select acra from int_accn
                                                              where id=0 and acc in (select acco from acc_over
                                                                                     where nd=k.nd)) and nbs not like '8%')
                            where ost<0 )

                 LOOP
                    begin
                       select sum(s.kos) into SUM_KOS from saldoa s, accounts a where a.acc=s.acc and a.acc = d.acc  and s.FDAT<DAT_;
                       for p in ( select s.fdat,sum(case when fdat=(select min(fdat) from saldoa ss  where acc=a.acc) then
                                                       greatest(-s.ostf,s.dos)
                                                    else
                                                       s.dos end) DOS
                                  from   saldoa s,accounts a
                                  where  a.acc=s.acc and a.acc =d.acc  and s.FDAT<DAT_
                                  group by s.fdat
                                  order by s.fdat)
                       LOOP
                          SUM_KOS:= SUM_KOS - p.DOS;
                          If SUM_KOS < 0 then
                             KOL_ := DAT_- p.FDAT;
                             EXIT;
                          end if;
                       end loop;
                       If KOL_>0 then
                          If    KOL_<= 7  then OBS_:=greatest(1,OBS_);
                          ElsIf KOL_<=30  then OBS_:=greatest(2,OBS_);
                          ElsIf KOL_<=90  then OBS_:=greatest(3,OBS_);
                          ElsIf KOL_<=180 then OBS_:=greatest(4,OBS_);
                          Else                 OBS_:=greatest(5,OBS_);
                          end if;
                       end if;
                    end;
                 end loop;
              end;
              update acc_over set obs23=OBS_ where nd=k.nd;
           end loop;
        end;
     end if;
     z23.to_log_rez (user_id , 30 , dat_ ,'Конец Обслуживание долга '||p_mode);
     -- Снимки
     BARS_UTL_SNAPSHOT.stop_running;
end OBS_23;
/
show err;

PROMPT *** Create  grants  OBS_23 ***
grant EXECUTE                                                                on OBS_23          to BARSUPL;
grant EXECUTE                                                                on OBS_23          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OBS_23          to RCC_DEAL;
grant EXECUTE                                                                on OBS_23          to START1;
grant EXECUTE                                                                on OBS_23          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OBS_23.sql =========*** End *** ==
PROMPT ===================================================================================== 
