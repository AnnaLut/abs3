CREATE OR REPLACE PROCEDURE BARS.rezerv_23 (dat01_   in date) is
/* Версия 3.3  26-02-2018  05-10-2017  30-08-2017  14-07-2017  06-06-2017  11-04-2017  03-02-2017
   Рівчачок з проміжними комітами

15) 26-02-2018(3.3)/COBUMMFO-6811/ - Использование архива PRVN_FIN_DEB --> FIN_DEB_ARC для определения номера договора
14) 05-10-2017(3.2) - Разделение фин.дебиторки (номер договора из табдицы PRVN_FIN_DEB 
13) 30-08-2017  -   Резерв брать по хоз.дебиторке  из REZ39 , если прислал FV
12) 14-07-2017  -   tipa по хоз. дебиторки (21)
11) 06-06-2017  -   При определении ND в prvn_fin_deb не учитывать EFFECTDATE;  COBUSUPABS-6044
10) 11-04-2017  -   При распределении дисконта/SNA не брать 9129
 9) 02-03-2017  -   9129 по БПК через rez_w4_bpk
 8) 29-11-2016 LUDA Если дебиторка есть в PRVN_FIN_DEB --> tipa = 17
 7) 17-05-2016 LUDA Выполнение процедуры UT2 (урегулирования дисконта/невизнаних доходів для договора
                    в разных валютах)
--------------------26-04-2016
 6) 26-04-2016 LUDA Уменьшение бал. стоимости на SNA, SDI перераспределение резерва
 5) 24-02-2016 LUDA Заполнение TIPA - тип актива
--------------------04-02-2016
 4) 04-02-2016 LUDA decode( l_finevare, 1, nvl(n.rezq39,0), NVL(n.rezQ23,0) ) rezq,
 3) 13-01-2016 LUDA Проставление номеров договоров по дебиторке
 2) 13-01-2016 LUDA KAT из 23 (Совещание в Делойте 12-01-2016, Костенко Г.С.)
                    REZ = REZ39, для DEBH (хоз.дебиторка) = REZ23
------------------- 24-12-2015
 1) 24-12-2015 Luda Kat из 23, s250 из 39, rez из 39 по парамеру PARAMS.REZ_FINEVARE
                    (при реальной загрузке из FINEVARE Kat должно быть из 39
------------------- 26-11-2015
    26-11-2015 LUDA Замена KAT из FINEVARE
    26-11-2015 LUDA Добавлен 3578/32,34 (письмо)
    07-09-2015 LUDA Добавлен 3578/33 убрала 3578/24 НАДО СМОТРЕТЬ
    31-07-2015 LUDA Расчет просрочки до 30 дней и после
    ? ?             3119 c NBU NULL не брать в резерв
    20-10-2014 LUDA Добавлено распределение резерва для Крыма (по просьбе Грицай)
    03-04-2014 LUDA Добавила в 3579 налоговый ОВ22='80'
    27-01-2014 LUDA Не налоговый учет добавился 9023
    16-01-2014 LUDA Добавлены изменения по ГОУ (Ценные бумаги и МЕЖБАНК)
    13-03-2013 LUDA Заполнение параметров перенесено в z23
    Процедура формирования налоговый/неналоговый учет в СБЕРБАНКЕ и
    Групповой метод (2401) в НАДРА
*/

l_oschad   BOOLEAN;  l_commit   number:=  0 ;
IDR_       number;   ost_nal    number;   s_kos      number;   n_n        number;   r013_      number;   
rez_       number;   pv_        number;   pv_z       number;   pvz_       number;   mfo_       NUMBER;   mfou_      NUMBER;   
freq_      number;   l_rez      number;   l_rez_30   number;   l_rezq_30  number;   l_rez_0    number;   l_rezq_0   number;   
l_koef     number;   l_tipa     number;   l_diskont  number;   se1_       DECIMAL (24);  l_xoz_fv   number := 1; 
-- ДО 30 ДНЕЙ
o_r013_1   VARCHAR2 (1); o_se_1     DECIMAL (24); o_comm_1   rnbu_trace.comm%TYPE;
-- ПОСЛЕ 30 ДНЕЙ
o_r013_2   VARCHAR2 (1); o_se_2     DECIMAL (24); o_comm_2   rnbu_trace.comm%TYPE;
dat_nal    date  := to_date('01042011','ddmmyyyy');

--dat31_     date  := Dat_last (dat01_-4,dat01_-1); -- последний рабочий день месяца
dat31_     date  := DAT_LAST_WORK (dat01_-1);     -- новая процедура последний рабочий день месяца
dat_1      date;
l_finevare number;
REZ_CP_    accountsw.value%type;
nbu        NBU23_REZ%rowtype;
l_sed      customer.sed%type;
l_zq       number;
ND_CP_     varchar2(40);
l_mfo      varchar2(6) ;
l_kf       varchar2(6);
begin

   mfo_ := f_ourmfo ();
   -- МФО "родителя"
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
   l_kf := sys_context('bars_context','user_mfo');
   dbms_application_info.set_client_info('CR_351_JOB:'|| l_kf ||': Розподіл резерву ');
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
                    n.rez23 rez23, n.rezq23 rezq23,
                    -- s250 - портфельный метод
                    --(если FINEVARE и то , что получили из FV:
                    --     = 'C' - портфельный метод из FINEVARE, то S250 = '8'- портфельный метод по НБУ,
                    --     = '1' - портфельный метод приняли из таблиц Рыбалки, S250 = '8'
                    -- по остальным счетам S250 сохраняется как по НБУ
                    decode( l_finevare, 1, decode(nvl(n.s250_39,'0'),'C','8','1','8','N'),nvl(n.s250_23,n.s250)) s250
             from   nbu23_rez n, accounts a, specparam s
             where  n.acc = a.acc (+) and n.fdat = dat01_ and a.acc = s.acc(+)
            )
   LOOP
      l_tipa := k.tipa  ;
      begin
         if k.id like 'DEBH%' or k.id like 'XOZ%'  THEN  
            if l_xoz_fv = 0 THEN
               k.rez  := k.rez23 ;    k.rezq := k.rezq23; 
            end if;
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

         s_kos    := 0    ; ND_CP_   := k.nd ; freq_    := NULL; o_r013_1 := null; o_se_1    := 0 ; o_comm_1 := null ; 
         o_r013_2 := null ; o_se_2   := 0    ; o_comm_2 := null; l_rez_30 := 0   ; l_rezq_30 := 0 ; l_rez_0  := k.rez; l_rezq_0 := k.rezq; 

         If l_oschad then  -- только ОЩАДБАНК
            --Тип актива
            if    k.id like 'CCK%' or k.ID like 'MBDK%' or k.ID like '150%' or k.id like '9020%'
               or k.id like '9122%'                   THEN  l_tipa :=  3;
            elsif k.id like 'CACP%'                   THEN  l_tipa :=  9;
            elsif k.id like 'W4%' or k.id like 'BPK%' THEN  l_tipa :=  4;
            elsif k.id like 'OVER%'                   THEN  l_tipa := 10;
            end if;

/*
            if k.id = 'CCK2' THEN
               N_N:= cck_app.Get_ND_TXT (k.nd,'N_NAL');

               begin
                  select 1 into ARJK_
                  from  (select to_date(cck_app.get_nd_txt (k.nd,'DINDU'),'dd-mm-yyyy') d1,
                                to_date(cck_app.get_nd_txt (k.nd,'DO_DU'),'dd-mm-yyyy') d2
                         from   cc_deal c,arjk j
                         where  to_date(cck_app.get_nd_txt (k.nd,'DINDU'),'dd-mm-yyyy') is not null
                                and cck_app.get_nd_txt (k.nd, 'ARJK') =j.id and j.datf is null and c.nd=k.nd) x
                  WHERE x.d1<=dat31_ and nvl(x.d2, dat31_+1) > dat31_;
               EXCEPTION WHEN NO_DATA_FOUND THEN  ARJK_ := 0;
               end;

               if N_N = 1 or ARJK_=1  THEN  -- АРЖК или есть судебное решение (не вкл. в налоговый)
                  szn_  := k.rez; sznq_ := k.rezq;
               else

                  begin
                     select  abs(nvl(s1.ostf,0)-nvl(s1.dos,0)+nvl(s1.kos,0)) into ost_nal
                     from   (SELECT r020, SUBSTR (r020, 4, 1) sb FROM kl_r011 kk
                     WHERE  trim(prem) = 'КБ' AND SUBSTR (r020, 4, 1) in ('8','9')
                          and  d_close is null and kk.REM = 'D5'
                     group by r020, SUBSTR (r020, 4, 1)
                     union
                    (select '2480' r020, '9' sb from dual union all   select '1518' r020, '8' sb from dual union all
                     select '1519' r020, '9' sb from dual union all   select '1780' r020, '9' sb from dual union all
                     select '3589' r020, '9' sb from dual union all   select '2239' r020, '9' sb from dual union all
                     select '2238' r020, '8' sb from dual union all   select '3578' r020, '8' sb from dual union all
                     select '3579' r020, '9' sb from dual union all   select '3570' r020, '8' sb from dual union all
                     select '2607' r020, '8' sb from dual union all   select '2627' r020, '8' sb from dual union all
                     select '2028' r020, '8' sb from dual union all   select '2029' r020, '9' sb from dual union all
                     select '2039' r020, '9' sb from dual union all   select '2089' r020, '9' sb from dual )) n8
                     left join (SELECT acc, MAX (fdat) fdat FROM saldoa where fdat <dat_nal group by acc)  sn on k.acc=sn.acc
                     left join saldoa s1 on s1.acc = sn.acc and s1.fdat = sn.fdat
                     where k.nbs=n8.r020;

                     szn_:=0;

                     begin  select ost_nal + s into ost_nal  from rez_spn  where acc=k.acc;
                     EXCEPTION WHEN NO_DATA_FOUND THEN  NULL;
                     end;

                     if ost_nal>0 then -- был остаток на 01-04-2011 и не погашен (не вкл.в налоговый)
                        select NVL( sum (kos),0) into s_kos from saldoa  where fdat>=dat_nal and fdat<=dat31_ and acc=k.acc;
                        if ost_nal >= s_kos then szn_:= ost_nal - s_kos;
                        else                     szn_:=0;
                        end if;
                        sznq_:= gl.p_icurval (k.kv, szn_, dat31_);    szn_ := szn_ /100;    sznq_:= sznq_/100;
                     else  szn_ := 0;    sznq_:= 0;
                     end if;
                  EXCEPTION  WHEN NO_DATA_FOUND  THEN      szn_ := 0;  sznq_:= 0;
                  end;
               end if;

            -- дебиторка, ценные бумаги, гарантии (не включается в налоговый)
            elsif (k.nbs='3579' and k.ob22 in ('07','08','09','19','23','24','31','33','35','37','39','57','66','67','68','69',
                                               '70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85',
                                               '86','87','88','90','92','94','95')) or
                  (k.nbs='3578' and k.ob22 in ('01','05','09','15','17','26','32','33','34','35','38')) or
                  (k.nbs     IN ('1410','1412','1414','1415','1417','1418','1420','1428','1819','2800','2801','2809','3102','3103',
                                 '3105','3110','3111','3112','3113','3114','3115','3117','3118','3214','3510','3519','3540','3541',
                                 '3548','3550','3551','3552','3559','3570','3710','9001','9020','9023','9122','9129')
              and  k.nls not in ('31148011314426','31141039596966')) THEN
                  --  3578(24), Вкл.в налоговый (письмо 25-11-2015 Шевченко С.і.)
                  --  3578(32,34) - добавлены   (письмо 25-11-2015 Шевченко С.і.)
                  --  1527 и 1517 перевели в налоговый (Притуп Ю.Н.)
                  szn_  := k.rez; sznq_ := k.rezq; l_rez_0  := 0; l_rezq_0  := 0;
            else  szn_  := 0;     sznq_ := 0;
            end if;

            if szn_ > k.rez Then      szn_  := k.rez;         sznq_ := k.rezq;
            end if;
*/
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
                     l_rez_0  := k.rez  - l_rez_30  ;
                     l_rezq_0 := k.rezq - l_rezq_30 ;
                  end if;
/*
                  if k.nbs in ('3570','3578','3118') THEN
                     szn_     := greatest(szn_ - l_rez_30,0);
                     sznq_    := gl.p_icurval (k.kv, szn_*100, dat31_)/100;
                  end if;
                  if k.nbs in ('2068') and szn_<> 0 THEN
                     l_rez_30 := greatest(l_rez_30-szn_,0);
                     l_rezq_30:= gl.p_icurval (k.kv, l_rez_30*100, dat31_)/100;
                  end if;
*/
               end if;

             elsif k.tip='SPN' and k.rez<>0 THEN 

                  o_se_2   := -k.bv*100;
                  l_rez_30 := k.rez;
                  l_rezq_30:= gl.p_icurval (k.kv, (k.rez)*100, dat31_)/100;
                  l_rez_0  := 0;  l_rezq_0 := 0;

            elsif (k.tip in ('SK9','OFR') or k.nbs in ('3570','3578')) and k. nbs not in ('3548') and k.rez<>0  THEN 
                  o_se_2   := -k.bv*100; l_rez_30 := k.rez; l_rezq_30:= k.rezq;
                  l_rez_0  := 0        ; l_rezq_0 := 0    ; 

            else                   o_se_2   := 0; l_rez_30 := 0; l_rezq_30:= 0;

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
                  begin
                     select acc_ss into k.nd from fin_deb_arc where mdat = dat01_ and k.acc in (acc_ss,acc_sp) and rownum=1; --acc_ss = k.nd ???
                     --l_tipa := 17;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     k.nd := k.acc;
                     --begin
                     --   select nd into k.nd from nd_acc where acc=k.acc and rownum=1;
                     --   begin
                     --      select nd into k.nd from acc_over where nd=k.nd and rownum=1;
                     --      l_tipa := 10;
                     --   EXCEPTION WHEN NO_DATA_FOUND THEN
                     --      l_tipa := 3;
                     --   end;
                     --EXCEPTION WHEN NO_DATA_FOUND THEN
                        --begin
                        --   select nd into k.nd from rez_w4_bpk where acc= k.acc;
                        --   l_tipa := 4;
                        --EXCEPTION WHEN NO_DATA_FOUND THEN
                           --l_tipa := 17;
                           --begin
                           --   select acc_ss into k.nd from prvn_fin_deb where acc_sp=k.acc;  --and EFFECTDATE < dat01_; COBUSUPABS-6044
                           --EXCEPTION WHEN NO_DATA_FOUND THEN k.nd := k.acc;
                           --end;
                        --end;
                    --end;
                  end;
                  l_tipa := 17;
               end if;
            end if;
         end if;

         idr_ := nvl(rez1.id_nbs(k.nbs),0);

         if length(k.branch) = 8 THEN
           k.branch := k.branch||'000000/';
         end if;

         if k.custtype = 3 THEN  
            begin
               select c.sed into l_sed from  customer c where c.rnk = k.rnk and sed='91'; 
               k.custtype := 2; 
            EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
            end;
         end if;

         update nbu23_rez set idr    = idr_    , rz     = k.rz       , cc_id    = k.cc_id    , rez    = k.rez      , rezq   = k.rezq  , kat    = k.kat, 
                              s250   = k.s250  , nd     = k.nd       , nd_cp    = nd_cp_     , id     = k.idkod    , branch = k.branch, rezn   = 0    , 
                              reznq  = 0       , bv_30  = -o_se_2/100, custtype = k. custtype, bvq_30 = -gl.p_icurval (k.kv,  o_se_2  , dat31_)/100   , 
                              rez_30 = l_rez_30,rezq_30 = l_rezq_30  , tipa     = l_tipa     ,  rez_0 = l_rez_0    , rezq_0 = l_rezq_0
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
      for k in (select nd, sum(-bv) over  (partition by nd) bv_sna from nbu23_rez where fdat = dat01_
                and tip in ('SNA','SDI','SDA','SDM','SDF')  and nbs not in ('3648','3666') )
      LOOP
          for s in (select rowid ri,nd, bv, sum(bv) over  (partition by nd) bv_all  from   nbu23_rez
                    where fdat = dat01_ and  tip not in ('SNA','SDI','SDA','SDM','SDF','SRR') and bv>0 and nd=k.nd and nbs not in ('9129'))
          LOOP
             L_diskont := round(s.bv/s.bv_all*k.bv_sna,2);
             update nbu23_rez set diskont  = l_diskont  where rowid=s.ri;
          end loop;
      end LOOP;
   commit;
   end;
/*
   begin
      z23.to_log_rez (user_id , 37 , dat01_ ,'Распределение SDF');
      for k in (select nd, sum(-bv) over  (partition by nd) bv_sna from nbu23_rez where fdat = dat01_
                and tip in ('SDF')  and nbs not in ('3648','3666') )
      LOOP
          for s in (select rowid ri,nd, bv, sum(bv) over  (partition by nd) bv_all  from   nbu23_rez
                    where fdat = dat01_ and  tip not in ('SNA','SDI','SDA','SDM','SDF','SRR') and bv>0 and nd=k.nd and nbs not in ('9129'))
          LOOP
             L_diskont := round(s.bv/s.bv_all*k.bv_sna,2);
             update nbu23_rez set zpr  = l_diskont  where rowid=s.ri;
          end loop;
      end LOOP;
   commit;
   end;
*/
/*
   begin
      z23.to_log_rez (user_id , 37 , dat01_ ,'Распределение SNA');
      for k in (select nd, sum(-bv) over  (partition by nd) bv_sna from nbu23_rez where fdat = dat01_
                and tip in ('SNA')  and nbs not in ('3648','3666') )
      LOOP
          for s in (select rowid ri,nd, bv, sum(bv) over  (partition by nd) bv_all  from   nbu23_rez
                    where fdat = dat01_ and  tip not in ('SNA','SDI','SDA','SDM','SDF','SRR') and bv>0 and nd=k.nd and nbs not in ('9129'))
          LOOP
             L_diskont := round(s.bv/s.bv_all*k.bv_sna,2);
             update nbu23_rez set pv  = l_diskont  where rowid=s.ri;
          end loop;
      end LOOP;
   commit;
   end;
 */
   z23.to_log_rez (user_id , 38 , dat01_ ,'Рівчачок - Кінець ');
end;
/
show err;
/
grant EXECUTE  on rezerv_23  to BARS_ACCESS_DEFROLE;
grant EXECUTE  on rezerv_23  to RCC_DEAL;
grant EXECUTE  on rezerv_23  to START1;
