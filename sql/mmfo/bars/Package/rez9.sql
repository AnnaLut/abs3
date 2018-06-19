create or replace package REZ9 is
  --
  -- constants
  --
  G_HEADER_VERSION  CONSTANT VARCHAR2(64) := 'version 1.0  21.05.2018';
  G_SHOW_LOG                 BOOLEAN      := false;

  procedure rez_23_9      ( dat01_  in date);
  PROCEDURE PAY_23        ( P_dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null, nal_ number);
  PROCEDURE PAY_23_OB22   ( dat01_   DATE, mode_ NUMBER DEFAULT 0, p_user number default null, nal_  varchar2);
  PROCEDURE PAY_23_OB22_5 ( dat01_   DATE, mode_ NUMBER DEFAULT 0, p_user number default null, nal_  varchar2);
  procedure p_error       ( p_dat01_      date    ,   p_user_id     number    ,    p_error_type  NUMBER  ,   p_nbs         VARCHAR2,    
                            p_s080        VARCHAR2,   p_custtype    VARCHAR2  ,    p_kv          VARCHAR2,   p_branch      VARCHAR2,
                            p_nbs_rez     VARCHAR2,   p_nbs_7f      VARCHAR2  ,    p_nbs_7r      VARCHAR2,   p_sz          NUMBER  ,
                            p_error_txt   VARCHAR2,    p_desrc      VARCHAR2) ;
  procedure pap_77        ( p_acc  NUMBER,p_pap NUMBER); 
  procedure POCI          ( p_dat01 date );
  procedure FROM_SRR_XLS  (p_ID_CALC_SET srr_xls.id_calc_set%type);
  procedure div9_old      ( p_mode int, p_dat01 date );
  procedure div9          ( p_mode int, p_dat01 date ); 

end rez9;
/

show errors;

create or replace package body REZ9 is

  g_body_version  constant varchar2(64) := 'version 1.0  21.05.2018';


  procedure rez_23_9 (dat01_  in date) is
   l_oschad   BOOLEAN;  l_commit   number:=  0 ;
   IDR_       number;   ost_nal    number;   s_kos      number;   n_n        number;   ARJK_      number;   r013_      number;   
   rez_       number;   pv_        number;   pv_z       number;   pvz_       number;   mfo_       NUMBER;   mfou_      NUMBER;   
   freq_      number;   l_rez      number;   l_rez_30   number;   l_rezq_30  number;   l_rez_0    number;   l_rezq_0   number;   
   l_finevare number;   l_koef     number;   l_tipa     number;   l_diskont  number;   l_zq       number;   se1_       DECIMAL (24);  
   l_xoz_fv   number := 1; 
   -- ДО 30 ДНЕЙ
   o_r013_1   VARCHAR2 (1); o_se_1     DECIMAL (24); o_comm_1   rnbu_trace.comm%TYPE;
   -- ПОСЛЕ 30 ДНЕЙ
   o_r013_2   VARCHAR2 (1); o_se_2     DECIMAL (24); o_comm_2   rnbu_trace.comm%TYPE;
   ND_CP_     varchar2(40); l_mfo      varchar2(6) ;

   dat_nal    date  := to_date('01042011','ddmmyyyy');  dat_1      date;
   dat31_     date  := DAT_LAST_WORK (dat01_-1);     -- новая процедура последний рабочий день месяца
  
   REZ_CP_    accountsw.value%type;  nbu        NBU23_REZ%rowtype;  l_sed      customer.sed%type;

  begin

     mfo_ := f_ourmfo ();   -- МФО "родителя"
     BEGIN  SELECT mfou INTO mfou_ FROM banks WHERE mfo = mfo_;
     EXCEPTION WHEN NO_DATA_FOUND THEN mfou_ := mfo_;
     END;

     l_finevare := nvl(F_Get_Params('REZ_FINEVARE', 0) ,0);  -- резерв из FINEVARE
     l_rez      := 0;

     if l_finevare = 1 THEN
        begin select sum(nvl(rez9,0)) into l_rez from nbu23_rez where fdat=dat01_;
        EXCEPTION WHEN NO_DATA_FOUND THEN l_finevare := 0;
        end;
        if l_rez = 0 THEN
           l_finevare := 0; -- пока не загрузили FINEVARE, беру REZ23
        end if;
        begin
           select sum(nvl(rez9,0)) into l_rez from nbu23_rez where fdat=dat01_ and (id like 'DEBH%' or id like 'XOZ%') ;
        EXCEPTION WHEN NO_DATA_FOUND THEN l_rez := 0;
        end;
        if l_rez = 0 THEN
           l_xoz_fv := 0; -- пока не загрузили FINEVARE по хоз.дебиторке, беру REZ23
        end if;
     end if;
     z23.BV_upd(dat01_); -- BVu = зкориг. бал.варт на суму невизнаних дох.SDI,SNA
     ut2(dat01_); -- Процедура урегулирования дисконта/невизнаних доходів для договора в разных валютах (NBU23_REZ (DISKONT <--> REZ23)
     l_commit := 0 ;
     z23.to_log_rez (user_id , 33 , dat01_ ,'Рівчачок - Початок ');
     l_mfo := gl.aMfo;
     If (getglobaloption('MFOP') = '300465' ) or l_mfo = '300465' THEN l_oschad := true; else l_oschad := false; end if; -- ОЩАД
     for k in (select /*+ INDEX (s PK_SPECPARAM) */
                      substr(n.id,1,4) ID, n.id idkod, n.nd    , n.acc     , n.bvu bv, a.tip     , n.ob22  , n.rz  , n.cc_id   , n.rnk, a.accc, nd_cp,
                      n.kv, n.nbs, n.nls , n.r013    , n.branch, n.ROWID RI, 1 kat   , s.istval, n.tipa, n.custtype,
                      -- Если FINEVARE в резерв берется рез.39, только по DEBH - REZ23
                      -- (Совещание в Делойте 12-01-2016, Костенко Г.С.)
                      decode( l_finevare, 1, nvl(n.rez9 ,0), NVL(n.rez23 ,0) ) rez ,
                      decode( l_finevare, 1, nvl(n.rezq9,0), NVL(n.rezq23,0) ) rezq,
                      n.rez39 rez23, n.rezq39 rezq23,
                      decode( l_finevare, 1, decode(nvl(n.s250_39,'0'),'C','8','1','8','N'),nvl(n.s250_23,n.s250)) s250
               from   nbu23_rez n, accounts a, specparam s
               where  a.kf = sys_context('bars_context','user_mfo') and n.acc = a.acc and n.fdat = dat01_ and a.acc = s.acc(+)
              )
     LOOP
        l_tipa := k.tipa  ;
        begin
           if k.id like 'DEBH%' or k.id like 'XOZ%'  THEN  
              --if l_xoz_fv = 0 THEN 
              k.rez  := k.rez23 ;    k.rezq := k.rezq23; 
              --end if;
           end if;

           if (k.id like 'DEBH%' or k.id like 'DEBF%' or k.id like 'XOZ%' or k.ID like 'CACP%' or k.ID like 'MBDK%' or k.ID like '15%') and k.s250='8' THEN
               k.s250 := 'N';
           end if;

           if  k.nbs = '1500'                                                    THEN k.s250:='0'; -- по настоянию ПЕТРОКОММЕРЦ ???
           elsif substr(k.id,1,3)='MBD' or k.nbs in ('1502','1509','1510')       THEN k.s250:='9'; -- Заборгованість за кредитними операціями на міжбанківському ринку
           elsif k.nbs in ('2625','2627') and l_mfo = '300120'                   THEN k.s250:='8'; -- портфельный метод для ПЕТРОКОММЕРЦ (2401)
           ELSIF k.nbs||k.r013 in ('91299','90231') and substr(k.id,1,2)<>'RU'   THEN k.s250:='C'; -- Заборгованість за операціями, за якими немає ризику
           ELSif substr(k.nbs,1,2)='90' and substr(k.id,1,2)<>'RU'               THEN k.s250:='A'; -- Заборгованість за наданими фінансовими зобов`язаннями, щодо наданих гарантій
           ELSif substr(k.nbs,1,2)='91' and substr(k.id,1,2)<>'RU'               THEN k.s250:='B'; -- Заборгованість за наданими фінансовими зобов`язаннями з кредитування
           ELSif k.istval='1' and substr(k.id,1,2)<>'RU' and
                 k.kv<>980 and (k.s250<>'8' or k.s250 is null)                   THEN k.s250:='6'; -- Заборгованість за кредитними операціями з позичальниками, у яких є джерела надходження валютної виручки
           ELSif k.istval<>'1' and substr(k.id,1,2)<>'RU' and
                 (k.s250<>'8' or k.s250 is null)                                 THEN k.s250:='7'; -- Заборгованість за кредитними операціями з позичальниками, у яких немає джерела надходження валютної виручки
           ELSif substr(k.id,1,2)<>'RU' and (k.s250<>'8' or k.s250 is null)      THEN k.s250:='7';
           end if;
           ARJK_    := 0    ; s_kos     := 0 ; ND_CP_   := k.nd ; freq_    := NULL; o_r013_1  := null ; o_se_1  := 0    ; o_comm_1 := null  ; 
           o_r013_2 := null ; o_se_2    := 0 ; o_comm_2 := null ; l_rez_30 := 0   ; l_rezq_30 := 0    ; l_rez_0 := k.rez; l_rezq_0 := k.rezq; 

           If l_oschad then  -- только ОЩАДБАНК
              if    k.id like 'CCK%' or k.ID like 'MBDK%' or k.ID like '150%' or k.id like '9020%'
                 or k.id like '9122%'                   THEN  l_tipa :=  3;
              elsif k.id like 'CACP%'                   THEN  l_tipa :=  9;
              elsif k.id like 'W4%' or k.id like 'BPK%' THEN  l_tipa :=  4;
              elsif k.id like 'OVER%'                   THEN  l_tipa := 10;
              end if;

              if k.nbs in ('3570','3578') THEN
                 begin
                    select nd into k.nd from nd_acc where acc = k.acc and rownum = 1;
                 EXCEPTION WHEN NO_DATA_FOUND THEN null;
                 end;
              end if;

              -- определение по начисленным процентам не погашенные до 30 дней и более 30 дней
              if (k.tip in ('SN ','SNO') or 
                 (k.nbs in ('3570') and k.ob22 in ('01','02','03','04','09','11','13','14','15','16','17','18','19','20','21','22',
                                                   '23','24','25','26','27','28','29','30','31','32','33','34','35','36')) or 
                 (k.nbs in ('3578') and k.ob22 in ('01','05','09','15','17','19','21','24','26','28','30','32','33','34','35','36',
                                                   '37','38'))) and k.rez<>0 THEN
                  se1_ := -k.bv*100;

                 begin
                    -- определяем периодичность гашения процентов
                    SELECT i.freq INTO freq_ FROM   nd_acc n8, accounts a8, int_accn i
                    WHERE  n8.nd = k.nd AND n8.acc = a8.acc AND a8.tip='LIM' AND a8.acc = i.acc AND i.ID = 0 AND ROWNUM = 1;
                 EXCEPTION WHEN NO_DATA_FOUND THEN freq_ := NULL;
                 end;
                 p_analiz_r013_new(mfo_,mfou_,dat01_,k.acc,k.tip,k.nbs,k.kv,k.r013,se1_,k.nd,freq_,
                 -------- до 30 дней
                 o_r013_1,  o_se_1,  o_comm_1,
                 -------- после 30 дней
                 o_r013_2,  o_se_2,  o_comm_2);

                 if k.bv<>0 THEN
                    if k.bv = -o_se_2/100 THEN
                       l_rez_30 := k.rez; l_rezq_30:= k.rezq;
                       l_rez_0  := 0    ; l_rezq_0 := 0     ;
                    else
                       l_koef   := -o_se_2/k.bv/100;   l_rez_30 := round(k.rez * l_koef,2);
                       l_rezq_30:= gl.p_icurval (k.kv, l_rez_30*100, dat31_)/100;
                       l_rez_0  := greatest(k.rez  - l_rez_30  , 0);
                       l_rezq_0 := greatest(k.rezq - l_rezq_30 , 0);
                    end if;
                 end if;

              elsif k.tip='SPN' and k.rez<>0 THEN 

                 o_se_2   := -k.bv*100;
                 l_rez_30 := k.rez;
                 l_rezq_30:= gl.p_icurval (k.kv, (k.rez)*100, dat31_)/100;
                 l_rez_0  := 0;  l_rezq_0 := 0;

              elsif (k.tip in ('SK9','OFR') or k.nbs in ('3570','3578')) and k. nbs not in ('3548') and k.rez<>0  THEN 
                 o_se_2   := -k.bv*100; l_rez_30 := k.rez; l_rezq_30:= k.rezq;
                 l_rez_0  := 0        ; l_rezq_0 := 0    ; 

              else    
                 o_se_2   := 0; l_rez_30 := 0; l_rezq_30:= 0;

              end if;

              begin
                 select 1 into R013_ from ps_sparam where spid=280 and nbs=k.nbs;
              EXCEPTION  WHEN NO_DATA_FOUND  THEN  r013_:=0;
              end;

              if r013_ = 1 THEN
                 begin
                    select value into REZ_CP_ from accountsw where acc=k.accc and tag='REZ_CP';
                    ND_CP_:= REZ_CP_||REZ_CP_||REZ_CP_;
                 EXCEPTION  WHEN NO_DATA_FOUND THEN NULL;
                 end;
              end if;

              if l_Mfo = '300465'   THEN  -- Деленеие по РНК
                 if k.nbs in ('3118','3119','1418','1419')                        THEN   ND_CP_ :=k.rnk;
                 end if;
                 if k.nbs in ('3119','1419') or k.nbs in ('3118') and k.ob22='02' THEN   ND_CP_ :=1000000+k.rnk;
                 end if;
                 if k.nbs in ('3119','1419') and k.id like'NLO%'                  THEN   k.idkod := 'CACP'|| k.idkod;
                 end if;
              end if;

              if k.id in ('DEBF') THEN
                 if k.nbs='3541' THEN
                    begin
                       select cp.ref into k.nd from cp_deal cp where k.acc in  (cp.accr,cp.acc) and rownum=1;
                       l_tipa := 9;
                    EXCEPTION WHEN NO_DATA_FOUND THEN k.nd := k.acc; l_tipa := 17;
                    end;
                 else
                    --begin
                       --select acc_ss into k.nd from fin_deb_arc where mdat = dat01_ and k.acc in (acc_ss,acc_sp) and rownum=1; 
                    --   select acc_ss into k.nd from FIN_DEB_ARC 
                    --   where (acc_ss = k.acc or acc_sp = k.acc) and mdat = (select min(mdat) from FIN_DEB_ARC where mdat >= dat01_ and  (acc_ss = k.acc or acc_sp = k.acc) ) and rownum=1;
                    --EXCEPTION WHEN NO_DATA_FOUND THEN
                    --   k.nd := k.acc;
                    --end;
                    l_tipa := 17;
                 end if;
              end if;
           end if;

           idr_ := nvl(rez1.id_nbs(k.nbs),0);

           if length(k.branch) = 8 THEN k.branch := k.branch||'000000/'; end if;
 
           if k.custtype = 3 THEN  
              begin
                 select c.sed into l_sed from  customer c where c.rnk = k.rnk and sed='91'; 
                 k.custtype := 2; 
              EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
              end;
           end if;

           update nbu23_rez set idr    = idr_ , ARJK  = ARJK_  , rz      = k.rz       , cc_id    = k.cc_id    , rez    = k.rez      , rezq     = k.rezq  ,
                                kat    = k.kat, s250  = k.s250 , nd      = k.nd       , nd_cp    = nd_cp_     , id     = k.idkod    , branch   = k.branch,
                                rezn   = 0    , reznq = 0      , bv_30   = -o_se_2/100, custtype = k. custtype,
                                bvq_30 = -gl.p_icurval (k.kv, o_se_2 , dat31_)/100, rez_30 = l_rez_30,rezq_30 = l_rezq_30  , tipa     = l_tipa  ,
                                rez_0  = l_rez_0               ,rezq_0  = l_rezq_0
           where rowid = k.RI ;

           l_commit :=  l_commit + 1 ;
           If l_commit >= 5000 then  commit;  l_commit:= 0 ;  end if;
        end;

     end LOOP;
     commit ;
     IF l_Mfo = '324805'  THEN
        begin
           z23.to_log_rez (user_id , 34 , dat01_ ,'КРИМ - ФОП');
           for k in (select n.*,n.ROWID RI from nbu23_rez n where fdat=dat01_ and NMK like '%ФОП%')
           LOOP
              update nbu23_rez set custtype=2 where rowid = k.RI and  fdat=dat01_;
           End LOOP;
        end;
     end if;

     begin -- заполнение по счетам дисконта для портфельного метода s250='8'
        z23.to_log_rez (user_id , 35 , dat01_ ,'Дисконт - S250');
        for k in (select distinct nd from nbu23_rez where  fdat= dat01_ and s250='8' and id like 'CCK%')
        LOOP
          update nbu23_rez set s250='8' where nd=k.nd and bv<0 and fdat=dat01_;
        end LOOP;
     end;

     begin
        l_commit := 0;
        z23.to_log_rez (user_id , 36 , dat01_ ,'9129 - БПК (W4)');
        for k in (select n.rowid RI, decode(t.tip_kart,41,'BPK/','W4/') ida from nbu23_rez n, rez_w4_bpk t
                  where n.fdat = dat01_ and n.nbs='9129' and n.tipa<>4 and n.acc=t.acc)
        LOOP
           update nbu23_rez set tipa=4, id= k.ida || id where  rowid=k.RI;
           l_commit := l_commit + 1 ;
           If l_commit > 1000 then commit; l_commit := 0; end if;
        end loop;
     end;
     begin
        z23.to_log_rez (user_id , 37 , dat01_ ,'Распределение дисконта');
        for k in (select nd, sum(-bv) over  (partition by nd) bv_sna from nbu23_rez where fdat = dat01_ and bv<0)
        LOOP
            for s in (select rowid ri,nd, bv, sum(bv) over  (partition by nd) bv_all  from   nbu23_rez
                      where fdat = dat01_ and  bv>0 and nd=k.nd and nbs not in ('9129'))
            LOOP
               L_diskont := round(s.bv/s.bv_all*k.bv_sna,2);
               update nbu23_rez set diskont  = l_diskont  where rowid=s.ri;
            end loop;
        end LOOP;
     commit;
     end;
     z23.to_log_rez (user_id , 38 , dat01_ ,'Рівчачок - Кінець ');
  end;

  PROCEDURE PAY_23 (P_dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null, nal_ number)  IS

  oo           oper%rowtype  ;
  l_finevare   NUMBER ;  l_row_id14   NUMBER ;  l_row_id13   NUMBER ;  l_row_id18   NUMBER ;  l_user       NUMBER ;  l_user_id    NUMBER ;
  l_user_err   NUMBER ;  l_kat        NUMBER ;  l_rez        NUMBER ;  l_fl         NUMBER ;  l_rez_pay    NUMBER ;  l_pay        NUMBER ;
  l_rnk        NUMBER ;  l_ref        INT    ;

  dat31_       date   ;  dat01_       date   ;  l_dat        date   ;
  ---------------------------------------
  begin
     if MODE_ = 1 THEN
        --logger.info('PAY23 0 : mode_ = ' || mode_) ;
        DELETE FROM srezerv_errors;
        commit;
     end if;

     IF P_DAT01_ IS NULL then  dat01_ := ROUND(SYSDATE,'MM');
     else                      dat01_ := p_dat01_;
     end if;

     -- Дата для корригуючих річних
     --   dat01_   := to_date('01-01-2016','dd-mm-yyyy'); -- Звітна дата
     --   gl.bdate := to_date('29-01-2016','dd-mm-yyyy'); -- Банківська дата для річних коригуючих

     l_fl := 0;

     if p_user is null and nal_ = 0 THEN
        -- перевірка на прийом данних з FINEVARE
        l_finevare := nvl(F_Get_Params('REZ_FINEVARE', 0) ,0);  -- резерв из FINEVARE
        if l_finevare = 1 THEN
           begin
              select sum(nvl(rez9,0)) into l_rez from nbu23_rez where fdat=dat01_;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              z23.to_log_rez (user_id , 99 , dat01_ ,'Не завантажені данні з FINEVARE на '||dat01_);
              raise_application_error(-20007,'Не завантажені данні з FINEVARE на '||dat01_);
           end;
           if l_rez = 0 THEN
              z23.to_log_rez (user_id , 99 , dat01_ ,'Не завантажені данні з FINEVARE на '||dat01_);
              raise_application_error(-20007,'Не завантажені данні з FINEVARE на '||dat01_);
           end if;
        end if;
        --выборка счетов для которых нет информации в справочнике
        insert into srezerv_errors (dat,userid, error_type, nbs, s080, custtype, kv, branch,  sz, error_txt, nbs_7f)
        select dat01_, user_id, 3, r.nbs||'/'||r.ob22, null,null ,r.kv,
               rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
               --rtrim(substr(r.branch,1,8)) branch,
               sum(nvl(r.rez*100,0)) sz,
               substr('S080 = '||r.kat||', Тип клієнта - '||decode(r.custtype,2, 'Юр.ос.',3, 'Фіз.ос.','')||'. Рахунки - '
                    ||ConcatStr(r.nls),1,999),r.kv
        from  nbu23_rez r
        where fdat = dat01_ and nvl(r.rez,0) <> 0
              and not exists (select 1 from srezerv_ob22 o
                              where r.nbs = o.nbs and r.ob22 = decode(o.ob22,'0',r.ob22,o.ob22) and
                                    decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                    r.custtype = decode(o.custtype,'0',r.custtype,o.custtype) and
                                    r.kv = decode(o.kv,'0',r.kv,o.kv) )
        group by r.nbs,r.ob22, r.kat,r.custtype ,r.kv,rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/'
                 --rtrim(substr(r.branch,1,8)) branch 
              ;
        commit;
     end if;
     dat31_ := Dat_last_work(p_dat01_ - 1);
     if mode_ = 0 THEN z23.to_log_rez (user_id , 17 , dat01_ ,'Начало Проводки - Реальные ');
     else              z23.to_log_rez (user_id , 18 , dat01_ ,'Начало Проводки - МАКЕТ ');
     end if;
     delete from srezerv_errors;
     if mode_ = 0 and (p_user is null or p_user = -1) THEN
        update rez_protocol set crc = null where dat=dat31_;
     END IF;
     -- определение параметров
     rez9.rez_23_9(dat01_);
     if dat01_ = to_date('01-01-2018','dd-mm-yyyy') THEN
        -- налоговый/не налоговый
        --PAY_23_ob22(dat01_, mode_, p_user,'0');
        rez9.PAY_23_ob22_5(dat01_, mode_, p_user,'1');
        rez9.PAY_23_ob22_5(dat01_, mode_, p_user,'5');
        --PAY_23_ob22(dat01_, mode_, p_user,'6');
        -- портфельный метод
        --PAY_23_ob22(dat01_, mode_, p_user,'A');
        rez9.PAY_23_ob22_5(dat01_, mode_, p_user,'B');
        rez9.PAY_23_ob22_5(dat01_, mode_, p_user,'C');
        --PAY_23_ob22(dat01_, mode_, p_user,'D');
       -- ценные бумаги
        rez9.PAY_23_ob22_5(dat01_, mode_, p_user,'3');
        rez9.PAY_23_ob22_5(dat01_, mode_, p_user,'4');
        rez9.PAY_23_ob22_5(dat01_, mode_, p_user,'7');
     else
        -- налоговый/не налоговый
        --PAY_23_ob22(dat01_, mode_, p_user,'0');
        rez9.PAY_23_ob22(dat01_, mode_, p_user,'1');
        rez9.PAY_23_ob22(dat01_, mode_, p_user,'5');
        --PAY_23_ob22(dat01_, mode_, p_user,'6');
        -- портфельный метод
        --PAY_23_ob22(dat01_, mode_, p_user,'A');
        rez9.PAY_23_ob22(dat01_, mode_, p_user,'B');
        rez9.PAY_23_ob22(dat01_, mode_, p_user,'C');
        --PAY_23_ob22(dat01_, mode_, p_user,'D');
       -- ценные бумаги
        rez9.PAY_23_ob22(dat01_, mode_, p_user,'3');
        rez9.PAY_23_ob22(dat01_, mode_, p_user,'4');
        rez9.PAY_23_ob22(dat01_, mode_, p_user,'7');
     end if;
     -- заполнение счетов резерва
     P_2400_23(dat01_);

     if mode_ = 0 THEN
        l_ref := bars_sqnc.get_nextval('s_REZ_OTCN');
        insert INTO NBU23_REZ_OTCN
            (ref        , FDAT , ID    , RNK    , NBS     , KV       , ND     , CC_ID   , ACC    , NLS     , BRANCH  , FIN       , OBS       ,
             KAT        , K    , IRR   , ZAL    , BV      , PV       , REZ    , REZQ    , DD     , DDD     , BVQ     , CUSTTYPE  , IDR       ,
             WDATE      , OKPO , NMK   , RZ     , ISTVAL  , R013     , REZN   , REZNQ   , ARJK   , PVZ     , PVZQ    , ZALQ      , PVQ       ,
             SDATE      , IR   , R011  , S180   , NLS_REZ , NLS_REZN , S250   , ACC_REZ , FIN_R  , ACC_REZN, ZAL_BL  , ZAL_BLQ   , DISKONT   ,
             ISP        , OB22 , TIP   , SPEC   , OB22_REZ, OB22_REZN, IR0    , IRR0    , ND_CP  , SUM_IMP , SUMQ_IMP, PV_ZAL    , VKR       ,
             S_L        , SQ_L , ZAL_SV, ZAL_SVQ, GRP     , KOL_SP   , PVP    , BV_30   , BVQ_30 , REZ_30  , REZQ_30 , NLS_REZ_30, ACC_REZ_30,
             OB22_REZ_30, BV_0 , BVQ_0 , REZ_0  , REZQ_0  , REZ39    , KAT39  , REZQ39  , S250_39, REZ23   , KAT23   , REZQ23    , S250_23   ,
             DAT_MI     , TIPA , BVU   , BVUQ   , EAD     , EADQ     , CR     , CRQ     , KOL_351, FIN_351 , KPZ     , KL_351    , LGD       ,
             OVKR       , P_DEF, OVD   , OPD    , RC      , RCQ      , ZAL_351, ZALQ_351, CCF    , TIP_351 , PD_0    , FIN_Z     , ISTVAL_351,
             REZ9       , REZQ9, RPB
            )
        select l_ref      , FDAT , ID    , RNK    , NBS     , KV       , ND     , CC_ID   , ACC    , NLS     , BRANCH  , FIN       , OBS       ,
             KAT        , K    , IRR   , ZAL    , BV      , PV       , REZ    , REZQ    , DD     , DDD     , BVQ     , CUSTTYPE  , IDR       ,
             WDATE      , OKPO , NMK   , RZ     , ISTVAL  , R013     , REZN   , REZNQ   , ARJK   , PVZ     , PVZQ    , ZALQ      , PVQ       ,
             SDATE      , IR   , R011  , S180   , NLS_REZ , NLS_REZN , S250   , ACC_REZ , FIN_R  , ACC_REZN, ZAL_BL  , ZAL_BLQ   , DISKONT   ,
             ISP        , OB22 , TIP   , SPEC   , OB22_REZ, OB22_REZN, IR0    , IRR0    , ND_CP  , SUM_IMP , SUMQ_IMP, PV_ZAL    , VKR       ,
             S_L        , SQ_L , ZAL_SV, ZAL_SVQ, GRP     , KOL_SP   , PVP    , BV_30   , BVQ_30 , REZ_30  , REZQ_30 , NLS_REZ_30, ACC_REZ_30,
             OB22_REZ_30, BV_0 , BVQ_0 , REZ_0  , REZQ_0  , REZ39    , KAT39  , REZQ39  , S250_39, REZ23   , KAT23   , REZQ23    , S250_23   ,
             DAT_MI     , TIPA , BVU   , BVUQ   , EAD     , EADQ     , CR     , CRQ     , KOL_351, FIN_351 , KPZ     , KL_351    , LGD       ,
             OVKR       , P_DEF, OVD   , OPD    , RC      , RCQ      , ZAL_351, ZALQ_351, CCF    , TIP_351 , PD_0    , FIN_Z     , ISTVAL_351,
             REZ9       , REZQ9, RPB
        From nbu23_rez
        where  fdat=dat01_ and nd = decode(p_user, null, nd, -1, nd, p_user);

        if p_USER IS NULL or p_user = -1 then
           INSERT INTO rez_protocol (userid, dat,dat_bank,dat_sys,ref,crc)  VALUES ( user_id, dat31_, gl.bdate, SYSDATE,l_ref,'1');
        END IF;
        commit;

        z23.to_log_rez (user_id , -17 , dat01_ ,'Конец Проводки - Реальные ');
     else
        z23.to_log_rez (user_id , -18 , dat01_ ,'Конец Проводки - МАКЕТ ');
     end if;
  end;

  PROCEDURE PAY_23_OB22 (dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null,nal_  varchar2)  IS

     doform_nazn      varchar2(100); doform_nazn_korr      varchar2(100);  doform_nazn_korr_year  varchar2(100);
     rasform_nazn     varchar2(100); rasform_nazn_korr     varchar2(100);  rasform_nazn_korr_year varchar2(100);

     b_date     date  ; dat31_     date  ;
     vv_        int   ; p4_        int   ;  l_MMFO     int;
     l_day_year NUMBER; r7702_acc  number;  mon_       NUMBER;  year_      NUMBER;  vob_       number;  otvisp_    number; fl         number(1);
     s_old_     number; s_old_q    number;  s_new_     number;  s_val_     number;  userid_    number;  l_user     number; diff_      number;
     ref_       number; nn_        number;  l_rez_pay  number;  l_pay      number;  REZPROV_   NUMBER         DEFAULT 0;

     r7702_     varchar2(20);  nazn_      varchar2(500);  tt_        varchar2(3) ;  nam_a_     varchar2(50)  ;  nam_b_     varchar2(50);
     r7702_bal  varchar2(50);  kurs_      varchar2(500);  okpoa_     varchar2(14);  error_str  varchar2(1000);  ru_        varchar2(50);
     sdat01_    char(10);

     par        NBS_OB22_PAR_REZ%rowtype;  l_absadm   staff$base.logname%type;  GRP_       accounts.grp%type:= 21;  rnk_b      accounts.rnk%type;
     acc_       accounts.acc%type       ;  nls_       accounts.nls%type      ;  maska_     accounts.nls%type     ;  isp_       accounts.isp%type;
     nms_       accounts.nms%type       ;  l_acc      accounts.acc%type      ;  rnk_       accounts.rnk%type     ;  nmk_       customer.nmk%type;
     nmkl_      customer.nmk%type       ;  nmklk_     customer.nmk%type      ;  k050_      customer.k050%type    ;  s080_      specparam.s080%type;
     s090_      specparam.s090%type     ;  r013_      specparam.r013%type    ;  l_code     regions.code%type     ;  name_mon_  META_MONTH.name_plain%type;
     rz_        nbu23_rez.rz%type       ;  l_nd       oper.nd%type           ;  

     e_nofound_7form    exception;  e_nofound_7rasform exception;

     TYPE CurTyp IS REF CURSOR;
     c0 CurTyp;
     ---------------------------------------
  BEGIN
     l_rez_pay   := nvl(F_Get_Params('REZ_PAY', 0) ,0); -- Формирование  резерва по факту (1 - ФАКТ)
     select id into l_absadm from staff$base where logname = 'ABSADM';
     logger.info('PAY1 : l_rez_pay= ' || l_rez_pay) ;
     if l_rez_pay = 1 THEN  l_pay := 1;
     else                   l_pay := 0;
     end if;
     sdat01_    := to_char( DAT01_,'dd.mm.yyyy');
     PUL_dat(sdat01_,'');
     l_day_year := 27; -- к-во дней с начала года, после которого корректирующие не месячные , а годовые
     nn_        := 22;
     if mode_ = 0 THEN  z23.to_log_rez (user_id , nn_ , dat01_ ,'Начало Проводки - Реальные '||'nal='||nal_);
     else               z23.to_log_rez (user_id , nn_ , dat01_ ,'Начало Проводки - МАКЕТ '||'nal='||nal_);
     end if;
     dat31_ := Dat_last_work(dat01_-1); -- Последний рабочий день месяца
     -- Трансформационные проводки
     if p_user  = -1 THEN l_user := -1;
     else                 l_user := p_user;
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
     if nal_='1' and l_user is null THEN
        --выбираем не оплаченные документы
        --проверка, есть ли за текущую дату расчета непроведенные проводки по резервам
        SELECT count(*) INTO s_new_ FROM oper
        WHERE tt = 'ARE' and vdat = dat31_ AND sos not in (5, -1); --выбираем не оплаченные документы

        if s_new_ > 0 then  bars_error.raise_error('REZ',4);  end if;
     end if;

     if nal_='1' THEN DELETE FROM rez_doc_maket; end if;

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
        if nal_ in ('1','5','7','B','C') THEN

           OPEN c0 FOR
           select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz    , t.branch, t.sz,
                  t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp ,
                  ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc  ,
                  ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls  , count(*) cnt
           from ( select c.country, o.NBS_REZ , o.OB22_REZ, o.NBS_7f  , o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr , o.r013 , nvl(r.rz,1) rz, r.KV,
                         null nd  , null cc_id, null nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                         sum(nvl(r.rez   *100,0)) sz      , sum(nvl(r.rezn*100,0)) szn  ,
                         sum(nvl(r.rez_30*100,0)) sz_30   , decode(r.kat,1,1,9,9,2) s080, to_char(r.kat) r_s080
                  from nbu23_rez r
                  join customer     c on (r.rnk = c.rnk)
                  join srezerv_ob22 o on (r.nbs = o.nbs and o.nal=nal_ AND 
                                          r.s250=decode(nal_,'A','8','B','8','C','8','D','8',decode(r.s250,'8','Z',r.s250)) and
                                          nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                          decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                          nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                          r.kv = decode(o.kv,'0',r.kv,o.kv) )
                  where fdat = dat01_  and substr(r.id,1,4) not in ('CACP','DEBH') 
                        and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                        and nvl(decode(nal_,'5',rez_30,'C',rez_30,'D',rez_30,'8',r.rez,rez_0),0) <> 0
                  group by c.country,o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, r.KV, r.rz,
                           rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',decode(r.kat,1,1,9,9,2),to_char(r.kat)
                ) t
           --счет резерва
           left join v_gls080 ar on ( t.NBS_REZ = ar.nbs    and t.OB22_REZ = ar.ob22  and ar.rz    = t.rz    and t.KV = ar.kv  and
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
                  where fdat = dat01_ and nvl(decode(nal_,'3',rez-rez_30,rez_30),0) <> 0 and id like 'CACP%' AND substr(r.id,1,4) not in ('DEBH') and
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
                  where fdat = dat01_ and nvl(r.rez,0) <> 0 and substr(r.id,1,4) not in ('DEBH') and
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
           --проверка корректности данных
           if k.cnt > 1 then
              -- для одного счета резерва найдено несколько лицевых счетов
              if instr(k.r_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 12, k.NBS_REZ||'/'||k.OB22_REZ,null, null, k.kv, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.r_nls||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
                 fl := 1;
              end if;
              -- для одного счета 7 класса (для формирования) найдено несколько лицевых счетов
              if instr(k.f7_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 12, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.f7_nls, 'Рахунок резерву - '||k.r_nls);
                 fl := 2;
              end if;
              -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
              if instr(k.r7_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 12, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.r7_nls, 'Рахунок резерву - '||k.r_nls);
                 fl := 3;
              end if;
           end if;
           if fl <> 1 THEN  acc_ := k.r_acc;  end if;

           -- Определение параметров клиента и счета
           begin
              select * into par from NBS_OB22_PAR_REZ  where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=k.rz;
           EXCEPTION  WHEN NO_DATA_FOUND THEN
              par.par_rnk   := 'REZ_RNK_UL';   par.nmk       := 'ЮО (неизвестен)';    par.cu        := 2   ;   par.Codcagent := 3;
              par.ISE       := '11002'     ;   par.ved       := '51900'          ;    par.sed       := '12';   par.nazn      := '(?)';
           END;
           nazn_ := par.nazn;
           if l_user is not null and l_user <> -1 THEN   nazn_ := nazn_ ||' (перенос)';
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
                    update customer set date_off = NULL where rnk = rnk_b and date_off is not null;
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
                 end;

                 if k.r_s080='0' then s080_:=k.s080;
                 else                 s080_:=k.r_s080;
                 end if;

                 SELECT UPPER(NVL(k.NBS_REZ,SUBSTR(MASK,1,4))||SUBSTR(MASK,5,8))||k.OB22_REZ INTO maska_ FROM   nlsmask WHERE  maskid='REZ';
                 nls_ := f_newnls2 (NULL, 'REZ' ,k.NBS_REZ, RNK_b, S080_, k.kv, maska_);
                 nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
                 k.r_nls := nls_;
                 select substr(trim('('||k.ob22_rez||')'|| decode(mode_,3,trim(k.CC_ID),'') || nmk_ || substr(k.branch,8,8)),1,70) into nms_ from dual;
                 begin
                    select isp into isp_  from v_gl  where kv = k.kv and branch = k.branch and nbs = k.NBS_REZ and dazs is null and isp <> l_absadm and rownum = 1;
                 EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm;
                 end;

                 begin
                    select acc into l_acc from v_gl where nls=nls_ and kv=k.kv and dazs is not null;
                    update accounts set dazs = null where acc=l_acc;
                 EXCEPTION WHEN NO_DATA_FOUND THEN null;
                 END;
                 if isp_ = 20094 THEN isp_ := l_absadm; end if;
                 --logger.info('PAY1 : nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' isp_=' || isp_ || ' NLS_=' || nls_ || ' KV=' || k.kv) ;
                 op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,k.kv,nms_,'REZ',isp_,acc_);
                 --logger.info('PAY55 : nls_= ' || nls_||' '||acc_) ;
                 k.r_acc:=acc_;
                 update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                 update accounts set tobo = k.branch             where acc= acc_ and tobo <> k.branch ;
                 update specparam_int set ob22=k.OB22_REZ where acc=acc_;
                 if sql%rowcount=0 then
                    insert into specparam_int(acc,ob22) values(acc_, k.OB22_REZ);
                 end if;
                 update accounts set ob22 = k.OB22_REZ where acc= acc_ and (ob22 <> k.OB22_REZ or ob22 is null) ;
                 if k.kv=980 THEN  s090_:='1';
                 ELSE              s090_:='5';
                 END IF;
                 update specparam set s080=s080_,s090=s090_,nkd=k.nd_cp where acc=acc_;
                 if sql%rowcount=0 then
                    insert into specparam (acc,s080,s090,nkd) values(acc_, s080_,s090_,k.nd_cp);
                 end if;
              else
                 rez9.p_error( dat01_, user_id, 11, k.NBS_REZ||'/'||k.OB22_REZ,k.r_s080, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null,
                          k.sz, k.NBS_REZ||'/'||k.OB22_REZ||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
                 fl := 4;
              end if;
              if k.r_s080='0' then  s080_:=k.s080;
              else                   s080_:=k.r_s080;
              end if;
           end if;
           if k.r_acc is not null and fl = 0 THEN
              update accounts set tip='REZ'         where acc= k.r_acc and tip<>'REZ'; 
           end if;
           -- Для отчетности заполнение R013 для 2400
           if    acc_ is not null and k.nbs_rez = '3190' and k.r013=1 THEN
                 k.r013 := 'A';
           elsif acc_ is not null and k.nbs_rez = '3190' and k.r013=2 THEN
                 k.r013 := 'B';
           end if;
           if mode_ = 0 THEN
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
                 rez9.p_error( dat01_, user_id, 8, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
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
                 rez9.p_error( dat01_, user_id, 8, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null,  k.sz, k.NBS_7r||'/'|| k.OB22_7r,  'Рахунок резерву - '||k.r_nls);
                  fl := 4;
              end if;
           end if;

           begin
              savepoint sp;
              error_str :=null;
              --формирование проводок
              if fl = 0 then
                 tt_ := 'ARE';
                 if l_user is not null THEN
                    vob_    := 6;
                    s_old_  := 0;  -- Предыдущий резерв
                 else
                    vob_    := 6; 
                    select ostc INTO s_old_ from accounts where acc=k.r_acc; -- Текущий остаток
                 end if;
                 --новая сумма резерва
                 if    nal_  in ('3','4','8')      THEN  s_new_ := k.sz;
                 elsif nal_  in ('5','C')          THEN  s_new_ := k.sz_30;
                 elsif nal_  in ('6','D')          THEN  s_new_ := k.sz_30;
                 elsif nal_ ='7'                   THEN  s_new_ := k.sz_30;
                 else
                    if    k.sz_30<>0               THEN  s_new_ := k.sz-k.sz_30;
                    else                                 s_new_ := k.sz;
                    end if;
                 end if;

                 error_str := error_str||'1';
                 --резерв изменился
                 --logger.info('PAY11 : s_new_= ' || s_new_) ;
                 --logger.info('PAY11 : s_old_= ' || s_old_) ;
                 --logger.info('KORR99-11: vob_= ' || vob_||'s_old_='||s_old_||':s_new-'||s_new_||'-'||k.r_nls) ;
                 if s_new_ - s_old_ <> 0 then
                    if s_new_ > s_old_ then-- увеличение резерва
                       r7702_acc := k.f7_acc;
                       r7702_    := k.f7_nls;
                       r7702_bal := k.NBS_7f||'/'||k.OB22_7f;
                       rez9.pap_77 (k.f7_acc,1); -- Корректировка признака актива-пассива по 7 кл.
                    else--уменьшение резерва
                       r7702_acc := k.r7_acc;
                       r7702_    := k.r7_nls;
                       r7702_bal := k.NBS_7r||'/'||k.OB22_7r;
                       rez9.pap_77 (k.r7_acc,2);
                    end if;
                    error_str := error_str||'2';
                    IF mode_ = 0 THEN
                       gl.REF (ref_);
                       --l_nd := substr(to_char(ref_),-10);
                       l_nd := 'FRS9-FR';
                    end if;
                    -- узнать название нужных счетов для вставки в OPER
                    SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO nam_a_, nam_b_
                    FROM v_gl a, v_gl b WHERE a.acc = k.r_acc and b.acc = r7702_acc;

                    if s_new_ > s_old_ then
                       diff_ := (-s_old_ + s_new_);
                       error_str := error_str||'6';
                       -- увеличение резерва
                       IF    vob_ = 99 THEN nazn_ := doform_nazn_korr_year || nazn_;
                       ElsIf vob_ = 96 THEN nazn_ := doform_nazn_korr      || nazn_;
                       Else                 nazn_ := doform_nazn           || nazn_;
                       END IF;
                       error_str := error_str||'7';
                       IF mode_ = 0 THEN
                          INSERT INTO oper (REF   , tt    , vob   , nd     , dk    , pdat   , vdat  , datd  , datp  , nam_a , nlsa   ,   mfoa,
                                            id_a  , nam_b , nlsb  , mfob   , id_b  , kv     , s     , kv2   , s2    , nazn  , userid)
                                    VALUES (ref_  , tt_   , vob_  , l_nd   , 0     , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls,gl.amfo,
                                            okpoa_, nam_b_, r7702_, gl.amfo, okpoa_, k.kv   , diff_ , 980   , gl.p_icurval (k.kv, diff_, dat31_),
                                            nazn_ , otvisp_) ;
                          error_str := error_str||'8';
                          gl.payv (l_pay, ref_, dat31_, tt_, 0, k.kv, k.r_nls, diff_, 980, r7702_, gl.p_icurval (k.kv, diff_, dat31_) );
                          error_str := error_str||'9';
                       end if;
                       -- logger.info('KORR99-12+: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                       INSERT INTO rez_doc_maket (tt    , vob    , pdat   , vdat     , datd  , datp  , nam_a , nlsa   , mfoa  , id_a   , nam_b, nlsb      ,
                                                  mfob  , id_b   , kv     , s        , kv2   , s2    , nazn  , userid , dk   , branch_a, ref  )
                                          VALUES (tt_   , k.s080 , SYSDATE, dat31_   , b_date, b_date, nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez        ,
                                                  okpoa_, nam_b_ , r7702_ , r7702_bal, okpoa_, k.kv  , diff_ , 980    , gl.p_icurval (k.kv, diff_, dat31_),
                                                  nazn_ , userid_, 1      , k.branch , ref_ );
                       error_str := error_str||' 10';
                    else
                       --уменьшение резерва
                       diff_ := (s_old_ - s_new_);
                       error_str := error_str||' 11';
                       IF    vob_ = 99 THEN nazn_ := rasform_nazn_korr_year || nazn_;
                       ElsIf vob_ = 96 THEN nazn_ := rasform_nazn_korr      || nazn_;
                       Else                 nazn_ := rasform_nazn           || nazn_;
                       END IF;
                       error_str := error_str||' 12';
                       IF mode_ = 0 THEN
                          INSERT INTO oper (REF   , tt    , vob   , nd     , dk    , pdat   , vdat  , datd  , datp  , nam_a , nlsa   , mfoa   ,
                                            id_a  , nam_b , nlsb  , mfob   , id_b  , kv     , s     , kv2   , s2    , nazn  , userid )
                                    VALUES (ref_  , tt_   , vob_  , l_nd   , 1     , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls, gl.amfo,
                                            okpoa_, nam_b_, r7702_, gl.amfo, okpoa_, k.kv   , diff_ , 980   , gl.p_icurval (k.kv, diff_, dat31_),
                                            nazn_ , otvisp_ );
                          error_str := error_str||' 13';
                          gl.payv (l_pay, ref_, dat31_, tt_, 1, k.kv, k.r_nls, diff_, 980, r7702_, gl.p_icurval (k.kv, diff_, dat31_));
                          error_str := error_str||' 14';
                       end if;
                       -- logger.info('KORR99-13-: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                       INSERT INTO rez_doc_maket (tt    , vob    , pdat   , vdat     , datd  , datp  , nam_a , nlsa   , mfoa, id_a    , nam_b , nlsb       ,
                                                  mfob  , id_b   , kv     , s        , kv2   , s2    , nazn  , userid , dk  , branch_a, ref   )
                                         VALUES  (tt_   , k.s080 , SYSDATE, dat31_   , b_date, b_date, nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez         ,
                                                  okpoa_, nam_b_ , r7702_ , r7702_bal, okpoa_, k.kv  , diff_ , 980    , gl.p_icurval (k.kv, diff_, dat31_) ,
                                                  nazn_ , userid_, 0      , k.branch , ref_  );
                       error_str := error_str||' 15';
                    END IF;
                    -- резерв не поменялся - все равно запишем в rez_doc_maket с признаком dk = -1
                    -- чтобы впоследствии при полном расформировании не учитывать этот счет
                 else
                    -- logger.info('KORR99-14-0: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                    INSERT INTO rez_doc_maket (tt     , vob   , pdat     , vdat  , datd  , datp  , nam_a , nlsa   , mfoa    , id_a    , nam_b , nlsb  ,
                                               mfob   , id_b  , kv       , s     ,kv2    , s2    , nazn  , userid , dk      , branch_a, ref   )
                                       VALUES (tt_    , k.s080, SYSDATE  , dat31_, b_date, b_date, null  , k.r_nls, k.nbs_rez||'/'||k.ob22_rez, okpoa_,
                                               null   , null  , r7702_bal, okpoa_, k.kv  , diff_ , 980   , gl.p_icurval (k.kv, diff_, dat31_) , null  ,
                                               userid_, -1    , k.branch ,ref_   );
 
                    error_str := error_str||' 16';
                 end if;
              end if;
           exception when others then
              rollback to sp;
              rez9.p_error( dat01_, user_id, 5, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
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
                  pr       srezerv_ob22.pr%TYPE);
        k r0Typ;
     begin
        if l_user is null THEN
           if nal_ in ('1','5','B','C') THEN
              OPEN c0 FOR
              select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                     a.nls r_nls, a.kv, a.ostc sz, o.NBS_7R, o.OB22_7R, ConcatStr(a7.acc) r7_acc, ConcatStr(a7.nls) r7_nls,o.pr
              from v_gl a
              left join srezerv_ob22 o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
              left join v_gl a7 on (o.NBS_7R = a7.nbs and a7.nbs like '77%'  and o.OB22_7R = a7.ob22 and '980' = a7.kv and
                                    rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' = a7.BRANCH and a7.dazs is null )
              where a.nbs in (select distinct nbs_rez from srezerv_ob22 where substr(nbs_rez,1,2) not in ('14','31','32') and nbs_rez<>'3590') and
                    o.nal = decode(nal_, '3', '1', '4', '1', nal_) and a.dazs is null and a.ostc <> 0
                    --не формировались проводки
                    and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
                    --нет ошибок
                    and not exists (select 1 from srezerv_errors r
                                    where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_
                                          and r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
              group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                       a.nls, a.kv, o.NBS_7R, a.ostc,o.OB22_7R,o.pr ;
           else
              OPEN c0 FOR
              select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                     a.nls r_nls, a.kv, a.ostc sz, o.NBS_7R, o.OB22_7R, ConcatStr(a7.acc) r7_acc, ConcatStr(a7.nls) r7_nls,o.pr
              from v_gl a
              left join srezerv_ob22 o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
              left join v_gl a7 on (o.NBS_7R = a7.nbs and a7.nbs like '77%'  and o.OB22_7R = a7.ob22 and '980' = a7.kv and
                                    rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' = a7.BRANCH and a7.dazs is null )
              where a.nbs in (select distinct nbs_rez from srezerv_ob22 where substr(nbs_rez,1,2) in ('14','31','32')) 
                and o.nal=decode(nal_,'3','1','4','1',nal_) and a.dazs is null and a.ostc <> 0
                --не формировались проводки
                and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
                --нет ошибок
                and not exists (select 1 from srezerv_errors r
                                where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_ and
                                      r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
              group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                       a.nls, a.kv, o.NBS_7R, o.OB22_7R,o.pr, a.ostc;
           end if;
           loop
              FETCH c0 INTO k;
              EXIT WHEN c0%NOTFOUND;
              fl := 0;
              if k.NBS_7R is null then
                 rez9.p_error( dat01_, user_id, 8, k.NBS_rez||'/'|| k.OB22_rez,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.r7_nls,  'Рахунок резерву - '||k.r_nls);
                 fl := 5;
              -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
              elsif instr(k.r7_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 7, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
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
              --logger.info('PAY1 : nbs_rez/ob22= ' || k.nbs_rez||'/'||k.ob22_rez|| ' NLS='||k.r_nls) ;
              begin
                 savepoint sp;
                 -- Определение параметров клиента и счета
                 error_str :=null;
                 --формирование проводок
                 if fl = 0 then
                    begin
                       select * into par from NBS_OB22_PAR_REZ  where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=1;
                    EXCEPTION  WHEN NO_DATA_FOUND THEN  par.nazn      := '(?)';
                    END;
                    nazn_ := par.nazn;
                    --тип операции
                    tt_ := 'ARE';
                    vob_ := 6;  -- обычные
                    -- узнать предыдущие остатки
                    s_old_ := k.sz;
                    -- logger.info('KORR99-3: vob_= ' || vob_||'ostc='||s_old_||'-'||k.r_acc||'-'||k.r_nls) ;
                 END IF;
                 --новая сумма резерва
                 s_new_ := 0;
                 error_str := error_str||'1';
                 r7702_acc := k.r7_acc;
                 r7702_ := k.r7_nls;
                 -- узнать название нужных счетов для вставки в OPER
                 SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO nam_a_, nam_b_ FROM v_gl a, v_gl b
                 WHERE a.acc = k.r_acc and b.acc = r7702_acc;
                 error_str := error_str||'2';
                 -- проводка по расформированию резерва
                 IF mode_ = 0  THEN
                    gl.REF (ref_);
                    --l_nd := substr(to_char(ref_),-10);
                    l_nd := 'FRS9-FR';
                 END IF;
   
                 error_str := error_str||'4';
                 --уменьшение резерва
                 diff_ := (s_old_ - s_new_);
                 -- logger.info('KORR99-5: vob_= ' || vob_||'old ='||s_old_||':new-'||s_new_||'-'||k.r_nls) ;
                 error_str := error_str||'5';
                 IF    vob_ = 99 THEN nazn_ := rasform_nazn_korr_year || nazn_;
                 ElsIf vob_ = 96 THEN nazn_ := rasform_nazn_korr      || nazn_;
                 Else                 nazn_ := rasform_nazn           || nazn_;
                 END IF;
                 error_str := error_str||'6';
                 if diff_ <> 0 THEN
                    IF mode_ = 0 then
                       INSERT INTO oper (REF   , tt    , vob    , nd    , dk  , pdat   , vdat  , datd  , datp  , nam_a , nlsa      , mfoa   , id_a   ,
                                         nam_b , nlsb  , mfob   , id_b  , kv  , s      , kv2   , s2    , nazn  , userid)
                                 VALUES (ref_  , tt_   , vob_   , l_nd  , 1   , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls   , gl.amfo, okpoa_ ,
                                         nam_b_, r7702_, gl.amfo, okpoa_, k.kv, diff_  , 980   , gl.p_icurval (k.kv, diff_, dat31_), nazn_  , otvisp_);
                       error_str := error_str||'7';
                       gl.payv (l_pay, ref_, dat31_, tt_, 1, k.kv, k.r_nls, diff_, 980, r7702_, gl.p_icurval (k.kv, diff_, dat31_));
                       error_str := error_str||'8';
   
                    end if;
   
                    INSERT INTO rez_doc_maket (tt   , vob , pdat , vdat   , datd  , datp      , nam_a , nlsa   , mfoa, id_a      , nam_b , nlsb,
                                               mfob , id_b, kv   , s      , kv2   , s2        , nazn  , userid , dk  , branch_a  , ref   )
                                       VALUES (tt_  , nvl(k.pr,0), SYSDATE, dat31_, b_date    , b_date, nam_a_ , k.r_nls,
                                               k.nbs_rez||'/'||k.ob22_rez , okpoa_, nam_b_    , r7702_, k.NBS_7R||'/'||k.OB22_7R , okpoa_, k.kv,
                                               diff_, 980 , gl.p_icurval (k.kv, diff_, dat31_), nazn_ , userid_, 2   , k.branch  , ref_  );
                    error_str := error_str||'9';
                 end if;
              exception when others then rollback to sp;
                 rez9.p_error( dat01_, user_id, 9, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
                          k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7r||'/'|| k.OB22_7r|| substr(sqlerrm,instr(sqlerrm,':')+1),error_str );
              end;
           end loop;
           CLOSE c0;
        end if;
     END;
     if mode_ = 0 THEN  z23.to_log_rez (user_id , -nn_ , dat01_ ,'Конец Проводки - Реальные '||'nal='||nal_);
     else               z23.to_log_rez (user_id , -nn_ , dat01_ ,'Конец Проводки - МАКЕТ '||'nal='||nal_);
     end if;
     rez.p_unload_data;
  END;

  PROCEDURE PAY_23_OB22_5 (dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null,nal_  varchar2)  IS

     doform_nazn      varchar2(100); doform_nazn_korr      varchar2(100);  doform_nazn_korr_year  varchar2(100);
     rasform_nazn     varchar2(100); rasform_nazn_korr     varchar2(100);  rasform_nazn_korr_year varchar2(100);

     b_date     date  ; dat31_     date  ;
     vv_        int   ; p4_        int   ;  l_MMFO     int;
     l_day_year NUMBER; r7702_acc  number;  mon_       NUMBER;  year_      NUMBER;  vob_       number;  otvisp_    number; fl         number(1);
     s_old_     number; s_old_q    number;  s_new_     number;  s_val_     number;  userid_    number;  l_user     number; diff_      number;
     ref_       number; nn_        number;  l_rez_pay  number;  l_pay      number;  REZPROV_   NUMBER         DEFAULT 0;

     r7702_     varchar2(20);  nazn_      varchar2(500);  tt_        varchar2(3) ;  nam_a_     varchar2(50)  ;  nam_b_     varchar2(50);
     r7702_bal  varchar2(50);  kurs_      varchar2(500);  okpoa_     varchar2(14);  error_str  varchar2(1000);  ru_        varchar2(50);
     sdat01_    char(10);

     par        NBS_OB22_PAR_REZ%rowtype;  l_absadm   staff$base.logname%type;  GRP_       accounts.grp%type:= 21;  rnk_b      accounts.rnk%type;
     acc_       accounts.acc%type       ;  nls_       accounts.nls%type      ;  maska_     accounts.nls%type     ;  isp_       accounts.isp%type;
     nms_       accounts.nms%type       ;  l_acc      accounts.acc%type      ;  rnk_       accounts.rnk%type     ;  nmk_       customer.nmk%type;
     nmkl_      customer.nmk%type       ;  nmklk_     customer.nmk%type      ;  k050_      customer.k050%type    ;  s080_      specparam.s080%type;
     s090_      specparam.s090%type     ;  r013_      specparam.r013%type    ;  l_code     regions.code%type     ;  name_mon_  META_MONTH.name_plain%type;
     rz_        nbu23_rez.rz%type       ;  l_nd       oper.nd%type           ;  

     e_nofound_7form    exception;  e_nofound_7rasform exception;

     TYPE CurTyp IS REF CURSOR;
     c0 CurTyp;
     ---------------------------------------
  BEGIN
     l_rez_pay   := nvl(F_Get_Params('REZ_PAY', 0) ,0); -- Формирование  резерва по факту (1 - ФАКТ)
     select id into l_absadm from staff$base where logname = 'ABSADM';
     logger.info('PAY1 : l_rez_pay= ' || l_rez_pay) ;
     if l_rez_pay = 1 THEN  l_pay := 1;
     else                   l_pay := 0;
     end if;
     sdat01_    := to_char( DAT01_,'dd.mm.yyyy');
     PUL_dat(sdat01_,'');
     l_day_year := 27; -- к-во дней с начала года, после которого корректирующие не месячные , а годовые
     nn_        := 22;
     if mode_ = 0 THEN  z23.to_log_rez (user_id , nn_ , dat01_ ,'Начало Проводки - Реальные '||'nal='||nal_);
     else               z23.to_log_rez (user_id , nn_ , dat01_ ,'Начало Проводки - МАКЕТ '||'nal='||nal_);
     end if;
     dat31_ := Dat_last_work(dat01_-1); -- Последний рабочий день месяца
     -- Трансформационные проводки
     if p_user  = -1 THEN l_user := -1;
     else                 l_user := p_user;
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
     if nal_='1' and l_user is null THEN
        --выбираем не оплаченные документы
        --проверка, есть ли за текущую дату расчета непроведенные проводки по резервам
        SELECT count(*) INTO s_new_ FROM oper
        WHERE tt = 'ARE' and vdat = dat31_ AND sos not in (5, -1); --выбираем не оплаченные документы

        if s_new_ > 0 then  bars_error.raise_error('REZ',4);  end if;
     end if;

     if nal_='1' THEN DELETE FROM rez_doc_maket; end if;

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
           NBS_REZ  SREZERV_OB22_5.NBS_REZ%TYPE,
           OB22_REZ SREZERV_OB22_5.OB22_REZ%TYPE,
           NBS_7f   SREZERV_OB22_5.NBS_7f%TYPE,
           OB22_7f  SREZERV_OB22_5.OB22_7f%TYPE,
           NBS_7r   SREZERV_OB22_5.NBS_7r%TYPE,
           OB22_7r  SREZERV_OB22_5.OB22_7r%TYPE,
           kv       accounts.kv%TYPE,
           rz       nbu23_rez.rz%TYPE,
           branch   accounts.branch%TYPE,
           sz       number,
           szn      number,
           sz_30    number,
           s080     specparam.s080%TYPE,
           pr       SREZERV_OB22_5.pr%TYPE,
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
        if nal_ in ('1','5','7','B','C') THEN

           OPEN c0 FOR
           select t.country, t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv   , t.rz    , t.branch, t.sz,
                  t.szn    , t.sz_30  , t.s080    , t.pr    , t.r_s080 , t.r013  , t.nd     , t.cc_id, t.nd_cp ,
                  ConcatStr(ar.acc) r_acc         , ConcatStr(ar.nls) r_nls      , ConcatStr(a7_f.acc) f7_acc  ,
                  ConcatStr(a7_f.nls) f7_nls      , ConcatStr(a7_r.acc) r7_acc   , ConcatStr(a7_r.nls) r7_nls  , count(*) cnt
           from ( select c.country, o.NBS_REZ , o.OB22_REZ, o.NBS_7f  , o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr , o.r013 , nvl(r.rz,1) rz, r.KV,
                         null nd  , null cc_id, null nd_cp, rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
                         sum(nvl(r.rez   *100,0)) sz      , sum(nvl(r.rezn*100,0)) szn  ,
                         sum(nvl(r.rez_30*100,0)) sz_30   , decode(r.kat,1,1,9,9,2) s080, to_char(r.kat) r_s080
                  from nbu23_rez r
                  join customer     c on (r.rnk = c.rnk)
                  join SREZERV_OB22_5 o on (r.nbs = o.nbs and o.nal=nal_ AND 
                                          r.s250=decode(nal_,'A','8','B','8','C','8','D','8',decode(r.s250,'8','Z',r.s250)) and
                                          nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                          decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                          nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                          r.kv = decode(o.kv,'0',r.kv,o.kv) )
                  where fdat = dat01_  and substr(r.id,1,4) not in ('CACP','DEBH') 
                        and r.nd = decode(l_user,null,r.nd,-1,r.nd,l_user)
                        and nvl(decode(nal_,'5',rez_30,'C',rez_30,'D',rez_30,'8',r.rez,rez_0),0) <> 0
                  group by c.country,o.NBS_REZ, o.OB22_REZ, o.NBS_7f, o.OB22_7f, o.NBS_7r, o.OB22_7r, o.pr, o.r013, r.KV, r.rz,
                           rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/',decode(r.kat,1,1,9,9,2),to_char(r.kat)
                ) t
           --счет резерва
           left join v_gls080 ar on ( t.NBS_REZ = ar.nbs    and t.OB22_REZ = ar.ob22  and ar.rz    = t.rz    and t.KV = ar.kv  and
                                      t.branch  = ar.BRANCH and ar.dazs is null       and t.r_s080 = ar.s080 and t.country = ar.country)
           --счет 7 класса формирования
           left join v_gl a7_f   on (a7_f.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02') and  a7_f.kv=980)
           --счет 7 класса уменьшения
           left join v_gl a7_r   on (a7_r.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02') and  a7_r.kv=980)
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
                  join SREZERV_OB22_5 o on (r.nbs = o.nbs and o.nal=decode(nal_,'3','1',nal_) AND 
                                          nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                          decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                          nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                          r.kv = decode(o.kv,'0',r.kv,o.kv) )
                  where fdat = dat01_ and nvl(decode(nal_,'3',rez-rez_30,rez_30),0) <> 0 and id like 'CACP%' AND substr(r.id,1,4) not in ('DEBH') and
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
           left join v_gl a7_f   on (a7_f.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02') and  a7_f.kv=980)
           --счет 7 класса уменьшения
           left join v_gl a7_r   on (a7_r.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02') and  a7_r.kv=980)
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
                  join SREZERV_OB22_5 o on (r.nbs = o.nbs and o.nal=decode(nal_,'3','1','4','1',nal_) AND 
                                          nvl(r.ob22,0)= decode(o.ob22,'0',nvl(r.ob22,0),o.ob22) and
                                          decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                          nvl(r.custtype,0)= decode(o.custtype,'0',nvl(r.custtype,0),o.custtype) and
                                          r.kv = decode(o.kv,'0',r.kv,o.kv) )
                  where fdat = dat01_ and nvl(r.rez,0) <> 0 and substr(r.id,1,4) not in ('DEBH') and
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
           left join v_gl a7_f   on (a7_f.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02') and  a7_f.kv=980)
           --счет 7 класса уменьшения
           left join v_gl a7_r   on (a7_r.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02') and  a7_r.kv=980)
           group by t.country,t.NBS_REZ, t.OB22_REZ, t.NBS_7f, t.OB22_7f, t.NBS_7r, t.OB22_7r, t.kv, t.rz, t.branch, t.sz, t.szn,
                    t.sz_30  , t.s080  , t.pr      , t.nd    , t.cc_id  , t.nd_cp , t.r_s080 , t.r013;
        end if;

        loop
           FETCH c0 INTO k;
           EXIT WHEN c0%NOTFOUND;
           fl   := 0;
           --проверка корректности данных
           if k.cnt > 1 then
              -- для одного счета резерва найдено несколько лицевых счетов
              if instr(k.r_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 12, k.NBS_REZ||'/'||k.OB22_REZ,null, null, k.kv, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.r_nls||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
                 fl := 1;
              end if;
              -- для одного счета 7 класса (для формирования) найдено несколько лицевых счетов
              if instr(k.f7_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 12, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.f7_nls, 'Рахунок резерву - '||k.r_nls);
                 fl := 2;
              end if;
              -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
              if instr(k.r7_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 12, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.r7_nls, 'Рахунок резерву - '||k.r_nls);
                 fl := 3;
              end if;
           end if;
           if fl <> 1 THEN  acc_ := k.r_acc;  end if;

           -- Определение параметров клиента и счета
           begin
              select * into par from NBS_OB22_PAR_REZ  where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=k.rz;
           EXCEPTION  WHEN NO_DATA_FOUND THEN
              par.par_rnk   := 'REZ_RNK_UL';   par.nmk       := 'ЮО (неизвестен)';    par.cu        := 2   ;   par.Codcagent := 3;
              par.ISE       := '11002'     ;   par.ved       := '51900'          ;    par.sed       := '12';   par.nazn      := '(?)';
           END;
           nazn_ := par.nazn;
           if l_user is not null and l_user <> -1 THEN   nazn_ := nazn_ ||' (перенос)';
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
                    update customer set date_off = NULL where rnk = rnk_b and date_off is not null;
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
                 end;

                 if k.r_s080='0' then s080_:=k.s080;
                 else                 s080_:=k.r_s080;
                 end if;

                 SELECT UPPER(NVL(k.NBS_REZ,SUBSTR(MASK,1,4))||SUBSTR(MASK,5,8))||k.OB22_REZ INTO maska_ FROM   nlsmask WHERE  maskid='REZ';
                 nls_ := f_newnls2 (NULL, 'REZ' ,k.NBS_REZ, RNK_b, S080_, k.kv, maska_);
                 nls_ := vkrzn( substr(gl.aMfo,1,5), NLS_);
                 k.r_nls := nls_;
                 select substr(trim('('||k.ob22_rez||')'|| decode(mode_,3,trim(k.CC_ID),'') || nmk_ || substr(k.branch,8,8)),1,70) into nms_ from dual;
                 begin
                    select isp into isp_  from v_gl  where kv = k.kv and branch = k.branch and nbs = k.NBS_REZ and dazs is null and isp <> l_absadm and rownum = 1;
                 EXCEPTION WHEN NO_DATA_FOUND THEN isp_ := l_absadm;
                 end;

                 begin
                    select acc into l_acc from v_gl where nls=nls_ and kv=k.kv and dazs is not null;
                    update accounts set dazs = null where acc=l_acc;
                 EXCEPTION WHEN NO_DATA_FOUND THEN null;
                 END;
                 if isp_ = 20094 THEN isp_ := l_absadm; end if;
                 --logger.info('PAY1 : nbs_rez= ' || k.nbs_rez||' ob22_rez='||k.ob22_rez || ' isp_=' || isp_ || ' NLS_=' || nls_ || ' KV=' || k.kv) ;
                 op_reg(99,0,0,GRP_,p4_,rnk_b,nls_,k.kv,nms_,'REZ',isp_,acc_);
                 --logger.info('PAY55 : nls_= ' || nls_||' '||acc_) ;
                 k.r_acc:=acc_;
                 update accounts set                 daos=dat31_ where acc= acc_ and daos > dat31_ ;
                 update accounts set tobo = k.branch             where acc= acc_ and tobo <> k.branch ;
                 update specparam_int set ob22=k.OB22_REZ where acc=acc_;
                 if sql%rowcount=0 then
                    insert into specparam_int(acc,ob22) values(acc_, k.OB22_REZ);
                 end if;
                 update accounts set ob22 = k.OB22_REZ where acc= acc_ and (ob22 <> k.OB22_REZ or ob22 is null) ;
                 if k.kv=980 THEN  s090_:='1';
                 ELSE              s090_:='5';
                 END IF;
                 update specparam set s080=s080_,s090=s090_,nkd=k.nd_cp where acc=acc_;
                 if sql%rowcount=0 then
                    insert into specparam (acc,s080,s090,nkd) values(acc_, s080_,s090_,k.nd_cp);
                 end if;
              else
                 rez9.p_error( dat01_, user_id, 11, k.NBS_REZ||'/'||k.OB22_REZ,k.r_s080, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null,
                          k.sz, k.NBS_REZ||'/'||k.OB22_REZ||(case k.r_s080 when 0 then '' else ' s080='||k.r_s080 end), null);
                 fl := 4;
              end if;
              if k.r_s080='0' then  s080_:=k.s080;
              else                   s080_:=k.r_s080;
              end if;
           end if;
           if k.r_acc is not null and fl = 0 THEN
              update accounts set tip='REZ'         where acc= k.r_acc and tip<>'REZ'; 
           end if;
           -- Для отчетности заполнение R013 для 2400
           if    acc_ is not null and k.nbs_rez = '3190' and k.r013=1 THEN
                 k.r013 := 'A';
           elsif acc_ is not null and k.nbs_rez = '3190' and k.r013=2 THEN
                 k.r013 := 'B';
           end if;
           if mode_ = 0 THEN
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
                 rez9.p_error( dat01_, user_id, 8, k.NBS_7f||'/'|| k.OB22_7f,null, null, 980, k.branch, k.NBS_REZ||'/'||k.OB22_REZ,
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
                 rez9.p_error( dat01_, user_id, 8, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null,  k.sz, k.NBS_7r||'/'|| k.OB22_7r,  'Рахунок резерву - '||k.r_nls);
                  fl := 4;
              end if;
           end if;

           begin
              savepoint sp;
              error_str :=null;
              --формирование проводок
              if fl = 0 then
                 tt_ := 'ARE';
                 if l_user is not null THEN
                    vob_    := 6;
                    s_old_  := 0;  -- Предыдущий резерв
                 else
                    vob_    := 6; 
                    select ostc INTO s_old_ from accounts where acc=k.r_acc; -- Текущий остаток
                 end if;
                 --новая сумма резерва
                 if    nal_  in ('3','4','8')      THEN  s_new_ := k.sz;
                 elsif nal_  in ('5','C')          THEN  s_new_ := k.sz_30;
                 elsif nal_  in ('6','D')          THEN  s_new_ := k.sz_30;
                 elsif nal_ ='7'                   THEN  s_new_ := k.sz_30;
                 else
                    if    k.sz_30<>0               THEN  s_new_ := k.sz-k.sz_30;
                    else                                 s_new_ := k.sz;
                    end if;
                 end if;

                 error_str := error_str||'1';
                 --резерв изменился
                 --logger.info('PAY11 : s_new_= ' || s_new_) ;
                 --logger.info('PAY11 : s_old_= ' || s_old_) ;
                 --logger.info('KORR99-11: vob_= ' || vob_||'s_old_='||s_old_||':s_new-'||s_new_||'-'||k.r_nls) ;
                 if s_new_ - s_old_ <> 0 then
                    if s_new_ > s_old_ then-- увеличение резерва
                       r7702_acc := k.f7_acc;
                       r7702_    := k.f7_nls;
                       r7702_bal := k.NBS_7f||'/'||k.OB22_7f;
                       rez9.pap_77 (k.f7_acc,1); -- Корректировка признака актива-пассива по 7 кл.
                    else--уменьшение резерва
                       r7702_acc := k.r7_acc;
                       r7702_    := k.r7_nls;
                       r7702_bal := k.NBS_7r||'/'||k.OB22_7r;
                       rez9.pap_77 (k.r7_acc,2);
                    end if;
                    error_str := error_str||'2';
                    IF mode_ = 0 THEN
                       gl.REF (ref_);
                       --l_nd := substr(to_char(ref_),-10);
                       l_nd := 'FRS9-FR';
                    end if;
                    -- узнать название нужных счетов для вставки в OPER
                    SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO nam_a_, nam_b_
                    FROM v_gl a, v_gl b WHERE a.acc = k.r_acc and b.acc = r7702_acc;

                    if s_new_ > s_old_ then
                       diff_ := (-s_old_ + s_new_);
                       error_str := error_str||'6';
                       -- увеличение резерва
                       IF    vob_ = 99 THEN nazn_ := doform_nazn_korr_year || nazn_;
                       ElsIf vob_ = 96 THEN nazn_ := doform_nazn_korr      || nazn_;
                       Else                 nazn_ := doform_nazn           || nazn_;
                       END IF;
                       error_str := error_str||'7';
                       IF mode_ = 0 THEN
                          INSERT INTO oper (REF   , tt    , vob   , nd     , dk    , pdat   , vdat  , datd  , datp  , nam_a , nlsa   ,   mfoa,
                                            id_a  , nam_b , nlsb  , mfob   , id_b  , kv     , s     , kv2   , s2    , nazn  , userid)
                                    VALUES (ref_  , tt_   , vob_  , l_nd   , 0     , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls,gl.amfo,
                                            okpoa_, nam_b_, r7702_, gl.amfo, okpoa_, k.kv   , diff_ , 980   , gl.p_icurval (k.kv, diff_, dat31_),
                                            nazn_ , otvisp_) ;
                          error_str := error_str||'8';
                          gl.payv (l_pay, ref_, dat31_, tt_, 0, k.kv, k.r_nls, diff_, 980, r7702_, gl.p_icurval (k.kv, diff_, dat31_) );
                          error_str := error_str||'9';
                       end if;
                       -- logger.info('KORR99-12+: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                       INSERT INTO rez_doc_maket (tt    , vob    , pdat   , vdat     , datd  , datp  , nam_a , nlsa   , mfoa  , id_a   , nam_b, nlsb      ,
                                                  mfob  , id_b   , kv     , s        , kv2   , s2    , nazn  , userid , dk   , branch_a, ref  )
                                          VALUES (tt_   , k.s080 , SYSDATE, dat31_   , b_date, b_date, nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez        ,
                                                  okpoa_, nam_b_ , r7702_ , r7702_bal, okpoa_, k.kv  , diff_ , 980    , gl.p_icurval (k.kv, diff_, dat31_),
                                                  nazn_ , userid_, 1      , k.branch , ref_ );
                       error_str := error_str||' 10';
                    else
                       --уменьшение резерва
                       diff_ := (s_old_ - s_new_);
                       error_str := error_str||' 11';
                       IF    vob_ = 99 THEN nazn_ := rasform_nazn_korr_year || nazn_;
                       ElsIf vob_ = 96 THEN nazn_ := rasform_nazn_korr      || nazn_;
                       Else                 nazn_ := rasform_nazn           || nazn_;
                       END IF;
                       error_str := error_str||' 12';
                       IF mode_ = 0 THEN
                          INSERT INTO oper (REF   , tt    , vob   , nd     , dk    , pdat   , vdat  , datd  , datp  , nam_a , nlsa   , mfoa   ,
                                            id_a  , nam_b , nlsb  , mfob   , id_b  , kv     , s     , kv2   , s2    , nazn  , userid )
                                    VALUES (ref_  , tt_   , vob_  , l_nd   , 1     , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls, gl.amfo,
                                            okpoa_, nam_b_, r7702_, gl.amfo, okpoa_, k.kv   , diff_ , 980   , gl.p_icurval (k.kv, diff_, dat31_),
                                            nazn_ , otvisp_ );
                          error_str := error_str||' 13';
                          gl.payv (l_pay, ref_, dat31_, tt_, 1, k.kv, k.r_nls, diff_, 980, r7702_, gl.p_icurval (k.kv, diff_, dat31_));
                          error_str := error_str||' 14';
                       end if;
                       -- logger.info('KORR99-13-: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                       INSERT INTO rez_doc_maket (tt    , vob    , pdat   , vdat     , datd  , datp  , nam_a , nlsa   , mfoa, id_a    , nam_b , nlsb       ,
                                                  mfob  , id_b   , kv     , s        , kv2   , s2    , nazn  , userid , dk  , branch_a, ref   )
                                         VALUES  (tt_   , k.s080 , SYSDATE, dat31_   , b_date, b_date, nam_a_, k.r_nls, k.nbs_rez||'/'||k.ob22_rez         ,
                                                  okpoa_, nam_b_ , r7702_ , r7702_bal, okpoa_, k.kv  , diff_ , 980    , gl.p_icurval (k.kv, diff_, dat31_) ,
                                                  nazn_ , userid_, 0      , k.branch , ref_  );
                       error_str := error_str||' 15';
                    END IF;
                    -- резерв не поменялся - все равно запишем в rez_doc_maket с признаком dk = -1
                    -- чтобы впоследствии при полном расформировании не учитывать этот счет
                 else
                    -- logger.info('KORR99-14-0: vob_= ' || vob_||'diff_='||diff_||':s_new-'||s_new_||'-'||k.r_nls) ;
                    INSERT INTO rez_doc_maket (tt     , vob   , pdat     , vdat  , datd  , datp  , nam_a , nlsa   , mfoa    , id_a    , nam_b , nlsb  ,
                                               mfob   , id_b  , kv       , s     ,kv2    , s2    , nazn  , userid , dk      , branch_a, ref   )
                                       VALUES (tt_    , k.s080, SYSDATE  , dat31_, b_date, b_date, null  , k.r_nls, k.nbs_rez||'/'||k.ob22_rez, okpoa_,
                                               null   , null  , r7702_bal, okpoa_, k.kv  , diff_ , 980   , gl.p_icurval (k.kv, diff_, dat31_) , null  ,
                                               userid_, -1    , k.branch ,ref_   );
 
                    error_str := error_str||' 16';
                 end if;
              end if;
           exception when others then
              rollback to sp;
              rez9.p_error( dat01_, user_id, 5, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
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
                  OB22_REZ SREZERV_OB22_5.OB22_REZ%TYPE,
                  NBS_REZ  SREZERV_OB22_5.NBS_REZ%TYPE,
                  branch   accounts.branch%TYPE,
                  r_nls    accounts.nls%TYPE,
                  kv       accounts.kv%TYPE,
                  sz       accounts.ostc%TYPE,
                  NBS_7r   SREZERV_OB22_5.NBS_7r%TYPE,
                  OB22_7r  SREZERV_OB22_5.OB22_7r%TYPE,
                  r7_acc   VARCHAR2(1000),
                  r7_nls   VARCHAR2(1000),
                  pr       SREZERV_OB22_5.pr%TYPE);
        k r0Typ;
     begin
        if l_user is null THEN
           if nal_ in ('1','5','B','C') THEN
              OPEN c0 FOR
              select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                     a.nls r_nls, a.kv, a.ostc sz, o.NBS_7R, o.OB22_7R, ConcatStr(a7.acc) r7_acc, ConcatStr(a7.nls) r7_nls,o.pr
              from v_gl a
              left join SREZERV_OB22_5 o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
              left join v_gl a7 on (a7.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02') and  a7.kv = 980)
              where a.nbs in (select distinct nbs_rez from SREZERV_OB22_5 where substr(nbs_rez,1,2) not in ('14','31','32') and nbs_rez<>'3590') and
                    o.nal = decode(nal_, '3', '1', '4', '1', nal_) and a.dazs is null and a.ostc <> 0
                    --не формировались проводки
                    and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
                    --нет ошибок
                    and not exists (select 1 from srezerv_errors r
                                    where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_
                                          and r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
              group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                       a.nls, a.kv, o.NBS_7R, a.ostc,o.OB22_7R,o.pr ;
           else
              OPEN c0 FOR
              select a.acc r_acc, a.ob22 OB22_REZ, a.nbs NBS_REZ, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' branch,
                     a.nls r_nls, a.kv, a.ostc sz, o.NBS_7R, o.OB22_7R, ConcatStr(a7.acc) r7_acc, ConcatStr(a7.nls) r7_nls,o.pr
              from v_gl a
              left join SREZERV_OB22_5 o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez
              left join v_gl a7 on (a7.nls = vkrzn( substr(gl.aMfo,1,5), '5031_02'))
              where a.nbs in (select distinct nbs_rez from SREZERV_OB22_5 where substr(nbs_rez,1,2) in ('14','31','32')) 
                and o.nal=decode(nal_,'3','1','4','1',nal_) and a.dazs is null and a.ostc <> 0
                --не формировались проводки
                and not exists (select 1 from rez_doc_maket r  where r.userid = userid_ and r.nlsa = a.nls and  r.kv = a.kv)
                --нет ошибок
                and not exists (select 1 from srezerv_errors r
                                where r.error_type <> 1 and  r.nbs_rez = a.nbs||'/'||a.ob22 and r.nbs_7f = a.kv and r.userid = userid_ and
                                      r.branch = rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' )
              group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
                       a.nls, a.kv, o.NBS_7R, o.OB22_7R,o.pr, a.ostc;
           end if;
           loop
              FETCH c0 INTO k;
              EXIT WHEN c0%NOTFOUND;
              fl := 0;
              if k.NBS_7R is null then
                 rez9.p_error( dat01_, user_id, 8, k.NBS_rez||'/'|| k.OB22_rez,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ,
                          k.kv, null, k.sz,k.r7_nls,  'Рахунок резерву - '||k.r_nls);
                 fl := 5;
              -- для одного счета 7 класса (для уменьшения) найдено несколько лицевых счетов
              elsif instr(k.r7_nls,',') > 0 then
                 rez9.p_error( dat01_, user_id, 7, k.NBS_7r||'/'|| k.OB22_7r,null, null, 980, k.branch,  k.NBS_REZ||'/'||k.OB22_REZ,
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
              --logger.info('PAY1 : nbs_rez/ob22= ' || k.nbs_rez||'/'||k.ob22_rez|| ' NLS='||k.r_nls) ;
              begin
                 savepoint sp;
                 -- Определение параметров клиента и счета
                 error_str :=null;
                 --формирование проводок
                 if fl = 0 then
                    begin
                       select * into par from NBS_OB22_PAR_REZ  where nbs_rez = k.nbs_rez and ob22_rez in (k.ob22_rez,'0') and rz=1;
                    EXCEPTION  WHEN NO_DATA_FOUND THEN  par.nazn      := '(?)';
                    END;
                    nazn_ := par.nazn;
                    --тип операции
                    tt_ := 'ARE';
                    vob_ := 6;  -- обычные
                    -- узнать предыдущие остатки
                    s_old_ := k.sz;
                    -- logger.info('KORR99-3: vob_= ' || vob_||'ostc='||s_old_||'-'||k.r_acc||'-'||k.r_nls) ;
                 END IF;
                 --новая сумма резерва
                 s_new_ := 0;
                 error_str := error_str||'1';
                 r7702_acc := k.r7_acc;
                 r7702_ := k.r7_nls;
                 -- узнать название нужных счетов для вставки в OPER
                 SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38) INTO nam_a_, nam_b_ FROM v_gl a, v_gl b
                 WHERE a.acc = k.r_acc and b.acc = r7702_acc;
                 error_str := error_str||'2';
                 -- проводка по расформированию резерва
                 IF mode_ = 0  THEN
                    gl.REF (ref_);
                    --l_nd := substr(to_char(ref_),-10);
                    l_nd := 'FRS9-FR';
                 END IF;
   
                 error_str := error_str||'4';
                 --уменьшение резерва
                 diff_ := (s_old_ - s_new_);
                 -- logger.info('KORR99-5: vob_= ' || vob_||'old ='||s_old_||':new-'||s_new_||'-'||k.r_nls) ;
                 error_str := error_str||'5';
                 IF    vob_ = 99 THEN nazn_ := rasform_nazn_korr_year || nazn_;
                 ElsIf vob_ = 96 THEN nazn_ := rasform_nazn_korr      || nazn_;
                 Else                 nazn_ := rasform_nazn           || nazn_;
                 END IF;
                 error_str := error_str||'6';
                 if diff_ <> 0 THEN
                    IF mode_ = 0 then
                       INSERT INTO oper (REF   , tt    , vob    , nd    , dk  , pdat   , vdat  , datd  , datp  , nam_a , nlsa      , mfoa   , id_a   ,
                                         nam_b , nlsb  , mfob   , id_b  , kv  , s      , kv2   , s2    , nazn  , userid)
                                 VALUES (ref_  , tt_   , vob_   , l_nd  , 1   , SYSDATE, dat31_, b_date, b_date, nam_a_, k.r_nls   , gl.amfo, okpoa_ ,
                                         nam_b_, r7702_, gl.amfo, okpoa_, k.kv, diff_  , 980   , gl.p_icurval (k.kv, diff_, dat31_), nazn_  , otvisp_);
                       error_str := error_str||'7';
                       gl.payv (l_pay, ref_, dat31_, tt_, 1, k.kv, k.r_nls, diff_, 980, r7702_, gl.p_icurval (k.kv, diff_, dat31_));
                       error_str := error_str||'8';
   
                    end if;
   
                    INSERT INTO rez_doc_maket (tt   , vob , pdat , vdat   , datd  , datp      , nam_a , nlsa   , mfoa, id_a      , nam_b , nlsb,
                                               mfob , id_b, kv   , s      , kv2   , s2        , nazn  , userid , dk  , branch_a  , ref   )
                                       VALUES (tt_  , nvl(k.pr,0), SYSDATE, dat31_, b_date    , b_date, nam_a_ , k.r_nls,
                                               k.nbs_rez||'/'||k.ob22_rez , okpoa_, nam_b_    , r7702_, k.NBS_7R||'/'||k.OB22_7R , okpoa_, k.kv,
                                               diff_, 980 , gl.p_icurval (k.kv, diff_, dat31_), nazn_ , userid_, 2   , k.branch  , ref_  );
                    error_str := error_str||'9';
                 end if;
              exception when others then rollback to sp;
                 rez9.p_error( dat01_, user_id, 9, null,null, null, k.kv, k.branch,k.NBS_REZ||'/'||k.OB22_REZ, k.kv, null, k.sz,
                          k.NBS_REZ||'/'||k.OB22_REZ||','||k.NBS_7r||'/'|| k.OB22_7r|| substr(sqlerrm,instr(sqlerrm,':')+1),error_str );
              end;
           end loop;
           CLOSE c0;
        end if;
     END;
     if mode_ = 0 THEN  z23.to_log_rez (user_id , -nn_ , dat01_ ,'Конец Проводки - Реальные '||'nal='||nal_);
     else               z23.to_log_rez (user_id , -nn_ , dat01_ ,'Конец Проводки - МАКЕТ '||'nal='||nal_);
     end if;
     rez.p_unload_data;
  END;

  procedure p_error( p_dat01_      date,
                     p_user_id     number,
                     p_error_type  NUMBER,
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
     insert into srezerv_errors ( dat ,userid, error_type, nbs, s080, custtype, kv, branch, nbs_rez, nbs_7f, nbs_7r,
                                  sz, error_txt, desrc)
                         values (p_dat01_ , 
                                 p_user_id, p_error_type, p_nbs, p_s080, p_custtype, p_kv, p_branch, p_nbs_rez,
                                 p_nbs_7f, p_nbs_7r, p_sz, substr(p_error_txt,1,999), p_desrc
                                 ) ;
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
  procedure POCI ( p_dat01 date )   is   -- Изменение балансового счета
     begin
        for k in (select  n.rowid ri, n.nbs||n.ob22 nbs_ob22, x.sdate, x.ND, x.PROD, x.IFRS, x.POCI , FN_K9 (x.IFRS, x.POCI)  kk9, r.TO_K9 , r.TO_PROD, 
                          substr( r.TO_PROD,1,4) nbs_n, substr( r.TO_PROD,5,2) ob22_n
                  From    RECLASS9 r, nbu23_rez n, 
                         (select d.sdate, d.ND, d.prod, t.txt IFRS,  NVL( (select decode (txt, 'Так',1, '1',1,0)  from nd_txt  where tag = 'POCI' and nd = d.nd), 0) POCI
                          from (select * from nd_txt    where tag = 'IFRS') t,
                               (select * from cc_deal c where c.vidd in (1,2,3) and c.nd <> NVL(ndg,0) and c.sos >=10 and c.sos<=14 and c.sdate< p_dat01 ) d
                          where d.nd = t.nd ) x 
                  where   FN_K9 (x.IFRS, x.POCI) = r.TO_K9 and x.nd=n.nd and n.fdat> x.sdate and r.FROM_PROD  = n.nbs||n.ob22  )
        LOOP
           update nbu23_rez set nbs=k.nbs_n, ob22=k.ob22_n where rowid=k.RI;
        end LOOP;
     end;   
  ----------------------------------------
procedure FROM_SRR_XLS(p_ID_CALC_SET srr_xls.id_calc_set%type)  is
begin
   delete from PRVN_FV_REZ_IFRS9 where ID_CONTRACT = 'PREMIY' and id_calc_set = p_id_calc_set and id_branch = (select id from regions where kf = sys_context('bars_context','user_mfo'));
   for xls in (select x.* from SRR_XLS x, regions r  where x.id_branch = r.id and r.kf = sys_context('bars_context','user_mfo') and x.id_calc_set = p_id_calc_set)
   loop
      insert into PRVN_FV_REZ_IFRS9 (     ID_CALC_SET,     UNIQUE_BARS_IS,     ID_BRANCH,     ID_CURRENCY,     DELTA_FV_CCY, ID_CONTRACT,     RNK_CLIENT)
                             values ( xls.ID_CALC_SET, xls.UNIQUE_BARS_IS, xls.ID_BRANCH, xls.ID_CURRENCY, xls.FV_CCY      , 'PREMIY'   , xls.RNK_CLIENT);          
   end LOOP;
end FROM_SRR_XLS;
--------------------------------------
procedure div9_old ( p_mode int, p_dat01 date )   is   -- разделение рез-39 по КД в НБУ-23-РЕЗ.
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
   s_nls varchar2(15);  s_RI    varchar2(254) ;         s_tp  varchar2(1)  ;  s_tp_next varchar2(2) ;
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

      select max (ID_CALC_SET)   into l_num   from PRVN_FV_REZ_IFRS9 o, regions r
      where ID_CALC_SET >= l_min and ID_CALC_SET <= l_max and o.id_branch = r.id and r.kf = sys_context('bars_context','user_mfo') ;

      if l_num is null
      then
        raise_application_error( -20333,'Вітрини з рез.МСФЗ PRVN_FV_REZ_IFRS9 на дату='||to_char(l_dat31_fv,'dd.mm.yyyy') ||
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

      PRVN_FLOW.SeND_MSG (p_txt => 'END-KV:'||l_msg );

      -- сжатие витрины делойта в целом по дог в экв. для vidd not in (3,13)
      --execute immediate 'truncate table PRVN_OSAQ';
      
      delete PRVN_OSA;
      
      insert 
        into PRVN_OSA ( rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT,  REZB, REZ9, AIRC_CCY, vidd )
      select rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT, SUM ( gl.p_icurval( KV,REZB    *100 ,l_dat31 ) ) /100 , 
             SUM ( gl.p_icurval( KV,REZ9    *100 ,l_dat31 ) ) /100 , SUM ( gl.p_icurval( KV,AIRC_CCY*100 ,l_dat31 ) ) /100 , vidd 
        from PRVN_OSAq 
       where vidd not in (3,13) or vidd is null or 
                nd in (select distinct nd 
                       from (select n.nd, kv from cc_deal e, accounts a, nd_acc n  
                             where   e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and  tip in ('SK9','SK0','CR9')  ) x
                       where x.kv not in (select distinct kv from cc_deal e, accounts a, nd_acc n  
                                          where  e.nd=x.nd and e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and 
                                                 a.tip in ('SN ','SNO','SP ','SPN','SS '))
                      )
        group by rnk, tip, ND, ID_PROV_TYPE,  IS_DEFAULT, vidd;

      -- сжатие витрины делойта по KV и дог в экв. для vidd in (3,13)
      insert into PRVN_OSA ( rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT,  REZB, REZ9, AIRC_CCY ,vidd,kv)
         select rnk, tip, ND, ID_PROV_TYPE, IS_DEFAULT, SUM ( gl.p_icurval( KV,REZB    *100 ,l_dat31 ) ) /100 , 
                SUM ( gl.p_icurval( KV,REZ9 * 100 ,l_dat31 ) ) /100 , SUM ( gl.p_icurval( KV,AIRC_CCY*100 ,l_dat31 ) ) /100 , vidd, kv  
         from   PRVN_OSAq 
         where  vidd in (3,13) and 
                nd not in ( select distinct nd 
                            from  (select n.nd, kv from cc_deal e, accounts a, nd_acc n  
                                   where  e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and tip in ('SK9','SK0','CR9') ) x
                            where x.kv not in (select distinct kv from cc_deal e, accounts a, nd_acc n  
                                               where  e.nd=x.nd and e.VIDD IN (3,13)  AND e.SDATE < z_dat01  and  e.nd=n.nd  and  n.acc=a.acc and 
                                                      a.tip in ('SN ','SNO','SP ','SPN','SS ')) )
         group by kv, rnk, tip, ND, ID_PROV_TYPE,  IS_DEFAULT, vidd ;      
      commit;
      PRVN_FLOW.SeND_MSG (p_txt => 'END-eqv:'||l_msg );
   end if;
   -------------------

end div9_old;
-----------------------------------------------------
  procedure div9 ( p_mode int, p_dat01 date )   is   -- разделение рез-39 по КД в НБУ-23-РЕЗ.
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
   s_nls varchar2(15);  s_RI    varchar2(254) ;         s_tp  varchar2(1)  ;  s_tp_next varchar2(2) ;
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

     -------------------
     If p_mode in (2) then ---------------------------------- разнести по НБУ23 
        z23.to_log_rez (user_id , 55 , p_dat01 ,'Розподіл FINEVARE - Початок ');
        update PRVN_OSAq set comm = null where rezb <> 0 or rez9<> 0;
        commit;

        If p_mode = 2 then l_msg:= '4) RR-351:  Тільки Розподіл + Рівчачок для проводок';
        end if;
        PRVN_FLOW.SeND_MSG (p_txt => 'BEG-eqv:'||l_msg );
        update nbu23_rez  set rez9 = 0,  rezq9 = 0 , s250_39 = null  where fdat = z_dat01;
        commit;
        LOGGER.INFO('OSA-1:Цикл по ND' );
        l_commit := 0; l_all := 0 ;
        for x in ( select kv, rnk, tip, ND, REZB rezb, REZ9 rez9, ID_PROV_TYPE, IS_DEFAULT, rowid RI, REZB_R, REZ9_R, FV_ABS from PRVN_OSA  )
        loop
           l_count := 0 ;
           l_SNA01 := 0 ;

        if   x.TIP = 3 and x.kv is null     THEN
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9',    0, BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,    0 )) over (partition by 1))
                         from nbu23_rez where fdat = z_dat01 and BVuq >= 0  and nd =  x.ND and ( rezq9 = 0 or p_mode = 12)
                          AND ( id like 'CCK%' or id like 'MBDK%' or id like '150%' or id like '9000%' or id like '9122%' or id like 'DEBF%' )
                          and tipa = 3 ;
       ElsIf x.TIP = 3 and x.kv is not null THEN
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', 0   , BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,    0 )) over (partition by 1))
                         from nbu23_rez where fdat = z_dat01 and BVuq >= 0  and nd =  x.ND and ( rezq9 = 0 or p_mode = 12)
                          AND ( id like 'CCK%' or id like 'MBDK%' or id like '150%' or id like '9000%' or id like '9122%' or id like 'DEBF%' )
                          and tipa = 3 and kv=x.kv ;
       ElsIf x.TIP = 9   then
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu, Div0( BVuq , sum(BVuq) over (partition by 1)), 0
                         from nbu23_rez where fdat = z_dat01 and BVuq >= 0  and nd =  x.ND    and ( rezq9 = 0 or p_mode = 12)
                          AND ( id like 'CACP%' or id like 'DEBF%' )      and tipa = 9 ;

       ElsIf x.TIP = 4   then
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', 0   ,BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,   0 )) over (partition by 1))
                         from nbu23_rez where fdat= z_dat01 and BVuq >= 0 and ( rezq9 = 0 or p_mode = 12 )
                          and tipa = 4  and nd = x.ND  AND (id like 'W4%'  or id like 'BPK%' or id like 'DEBF%') ;

       ElsIf x.TIP = 10  then
             OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu,
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', 0   ,BVuq )) over (partition by 1)),
                                       Div0( BVuq, sum(decode(substr(nls,1,1),'9', BVuq,   0 )) over (partition by 1))
                         from nbu23_rez
                         where fdat= z_dat01 and BVuq >= 0 and nd = x.ND and (rezq9 = 0 or p_mode = 12)
                           AND (id like 'OVER%' or id like 'DEBF%' )  and tipa = 10;

      ElsIf x.TIP = 17   then

         begin
            --select ACC_SP  into l_acc from FIN_DEB_ARC  where ACC_SS = x.nd  and ACC_SS <> ACC_SP and mdat = z_dat01;
             -- ACC_SP is not null
             --and EFFECTDATE < z_dat01;
             select acc_sp into l_acc from FIN_DEB_ARC 
             where acc_ss = x.nd  and mdat = (select min(mdat) from FIN_DEB_ARC where mdat >= z_dat01 and  acc_ss = x.nd );

         exception  when NO_DATA_FOUND  then l_acc := x.nd;
         end;

         OPEN s1 FOR select ROWID, nls, BVuq, KV, BVu, Div0 (BVuq, sum(BVuq) over (partition by 1)), 0  from nbu23_rez
                     where fdat= z_dat01 and BVuq >= 0 and ( rez9 = 0 or p_mode = 12 ) and acc in (x.ND,l_acc) AND ( id like 'DEB%') and tipa = 17;

      ElsIf x.TIP = 21 then

         OPEN s1 FOR
            select ROWID, nls, BVuq, KV, BVu, Div0 (BVuq, sum(BVuq) over (partition by 1)), 0  from   nbu23_rez
            where  fdat= z_dat01 and BVuq >= 0 and ( rez9 = 0 or p_mode = 12 ) and nd in (x.ND) AND ( id like 'DEBH%')  and tipa in ( 21, 17 );

      else
        update prvn_osa  SET COMM = 'NOT tip='||x.tip , FV_ABS = REZB+REZ9  where rowid = x.RI;
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

            update nbu23_rez set rezq9 = q_REZ , rez9 = n_REZ, s250_39 = x.ID_PROV_TYPE where rowid = s_RI;
            x.FV_ABS := x.FV_ABS + q_REZ ;
            l_count  := l_count  + 1 ;
       end loop;

       CLOSE s1;

       If  l_count > 0 then sErr_ := 'OK '|| s_nls    ;
       else                 sErr_ := 'NOT NBU23_rez'  ; x.FV_ABS := 0;
       end if ;

       update  prvn_osa  SET COMM = sErr_, FV_ABS = (x.REZB + x.REZ9) - x.FV_ABS  where rowid = x.RI  ;
     
           l_commit := l_commit + 1; l_all := l_all    + 1 ;
           If l_commit >= 1000 then  commit;  l_commit:= 0 ;  LOGGER.INFO('OSA-2.1:Обработано '||l_all||' дог.');    end if;
        
           <<NEXT_>> null;
        end loop;
        ----------------
        commit;  LOGGER.INFO('OSA-2.2:Обработано ВСЕГО '||l_all||' дог ' || to_char( z_dat01, 'dd.mm.yyyy' ) );
        PRVN_FLOW.SeND_MSG (p_txt => 'END:'||l_msg );
     end if;
     z23.to_log_rez (user_id , 55 , p_dat01 ,'Розподіл FINEVARE - Кінець ');
     z23.to_log_rez (user_id , 55 , p_dat01 ,'Заповнення нових SNA, SDI, ..... - Початок ');
     SNA_SDI_ADD (p_DAT01 );
     z23.to_log_rez (user_id , 55 , p_dat01 ,'Заповнення нових SNA, SDI, ..... - Кінець ');
  end;
end;
/
show err

grant execute on REZ9 to BARS_ACCESS_DEFROLE;
grant execute on REZ9 to RCC_DEAL;
grant execute on REZ9 to START1;
grant execute on REZ9 to BARSUPL, UPLD;
