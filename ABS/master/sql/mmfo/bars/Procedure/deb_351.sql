

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DEB_351.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DEB_351 ***

  CREATE OR REPLACE PROCEDURE BARS.DEB_351 (p_dat01 date, p_mode integer  default 0, p_deb integer  ) IS

/*   Розрахунок кредитного ризику по дебіторці
     -----------------------------------------
    Версия 7.7      23-10-2018  29-01-2018  25-10-2017  03-10-2017  28-09-2017  25-09-2017  

13) 23-10-2018(7.7) - (COBUMMFO-7488) - Добавлено ОКПО в REZ_CR
12) 29-01-2018(7.6) - Определение типа XOZ через ф-цию f_tip_xoz (если нет в картотеке заносится в таблицу rez_xoz_tip)
11) 25-10-2017(7.5) - Хоз.дебиторка из архива XOZ_REF ==> XOZ_REF_ARC
10) 03-10-2017(7.4) - Группа s250=8, всегда fin=1
 9) 28-09-2017(7.3) - LGD = 1
 8) 25-09-2017(7.2) - S180 из ND_VAL
 7) 18-09-2017 - Портфельный метод по фин.дебиторке
 6) 16-05-2017 - если не нашло реальный TIP_FIN (причины: Изменили РНК, внесли остаток корректирующими) - TIP_FIN = 0 (как дебиторка).
                 Нельзя переопеределять как ЮЛ или ФЛ
 5) 27-04-2017 - По ЦБ уточнение условия (cp.active=1 or cp.active = -1 and cp.dazs >= p_dat01)
 4) 21-03-2017 - При погіршені FIN=2 --> PD=1
 3) 15-02-2017 - Вставила дату закрытия в курсор
 2) 24-01-2017 - Добавлены параметры s080,TIP_FIN,ddd_6B
 1) 03-01-2017 Добавила BV02, wdate

   p_deb = 0 - Звичайна дебіторка
           1 - Нова хоз.дебіторка

   l_tip_fin:0 -   Фін.стан 1-2  (дебіторка). Визначення коефіцієнта імовірності дефолту контрагента за дебіторською заборгованістю від кількості днів
                                              прострочки (таблиця №1).
             1 -   Фін.стан 1-5  (ФО, банки+корсчета, бюджет). Визначення коефіцієнта імовірності дефолту контрагента за дебіторською заборгованістю,
                                                               щодо якого наявна інша активна операція боржника – бюджетної установи, банку, фізичної
                                                               особи. (таблиця №3).
             2 -   Фін.стан 1-10 (ЮО). Визначення коефіцієнта імовірності дефолту контрагента за дебіторською заборгованістю, щодо якого наявна інша
                                       активна операція боржника – юридичної особи (крім банку та бюджетної установи) та емітента цінних паперів,
                                       що є юридичною особою (крім банку та бюджетної установи). (таблиця №2).


*/

 cd      cc_deal%rowtype    ; ov     acc_over%rowtype ; w4        v_w4_acc%rowtype     ; bpk   v_bbpk_acc%rowtype; l_s180  specparam.s180%type;
 l_s080  specparam.s080%type; l_ddd  kl_f3_29.ddd%type; l_istval  specparam.istval%type; l_grp rez_cr.grp%type   ; l_s250  rez_cr.s250%type   ;

 l_del    number;  l_EAD  number;  l_del_kv  number;  l_tip_fin number ;  l_RC   number ;  l_pd   number;  l_fin      number;  l_CV  number;
 l_fin23  number;  l_kol  number;  l_CR      number;  l_EADQ    number ;  l_CRQ  number ;  l_RCQ  NUMBER;  l_xoz_new  number;
 l_pd_0  INTEGER;  l_nd  integer;  l_MAX    integer;  l_deb     integer;  l_LGD  integer;

 l_Text  varchar2(250) := '' ;  l_deb_bez varchar2(1) := '0';  l_txt  varchar2(1000);  l_tx  varchar2(30);  l_RNK_FIN char(1);

 l_dat31  date;  l_sdate  date;  l_wdate  date;

 TYPE CurTyp IS REF CURSOR;
 c0   CurTyp;

begin
   l_xoz_new := nvl(F_Get_Params('XOZ_NEW', 0) ,0);
   if p_deb = 1 and l_xoz_new = 0 THEN RETURN; end if;
   if p_deb=0 THEN l_tx := ' (фін.+госп.звичайна) ';
   else            l_tx := ' (госп.з модуля) ';
   end if;
   z23.to_log_rez (user_id , 351 , p_dat01 ,'Начало Дебиторка 351' || l_tx );
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   pul_dat(to_char(p_dat01,'dd-mm-yyyy'),'');
   --delete from REZ_CR where tipa=17 and fdat = p_dat01;
   DECLARE
      TYPE r0Typ IS RECORD
         ( TIPa      number,
           custtype  customer.custtype%type,
           cus       customer.custtype%type,
           nmk       varchar2(35),
           prinsider customer.prinsider%type,
           country   customer.country%type,
           ise       customer.ise%type,
           nbs       accounts.nbs%type,
           tip       accounts.tip%type,
           NLS       accounts.nls%type,
           kv        accounts.kv%type,
           acc       accounts.acc%type,
           ob22      accounts.ob22%type,
           bv        rez_cr.bv%type,
           rnk       accounts.rnk%type,
           branch    accounts.branch%type,
           RZ        number,
           wdate     date,
           nd        accounts.acc%type,
           sdate     date,
           deb       rez_deb.deb%type,
           okpo      customer.okpo%type
          );
   k r0Typ;

   begin
      if    p_deb = 0   THEN
         OPEN c0 FOR
            select 17 tipa, decode(c.custtype,3,3,2) custtype, c.custtype cus, substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK,
                   c.PRINSIDER, c.COUNTRY, c.ISE, a.nbs, a.tip, a.nls, a.kv, a.acc, a.ob22, -ost_korr(a.acc,l_dat31,null,a.nbs) bv,a.rnk, a.branch,
                   DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, a.mdate wdate, a.acc nd, null sdate,d.deb, c.okpo
            from   accounts a,customer c, rez_deb d
            where  a.nbs = d.nbs and d.deb in (1,2) and d.deb is not null and a.nbs is not null and (a.dazs is null or a.dazs >= p_dat01)
                   and a.acc not in ( select accc from accounts where nbs is null and substr(nls,1,4)='3541' and accc is not null) and a.rnk = c.rnk and  ( f_tip_xoz(p_dat01, a.acc, a.tip) not in ('XOZ','W4X')   or l_xoz_new != 1 )
            union  all
            select 17 tipa,decode(c.custtype,3,3,2) custtype, c.custtype cus, substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK,
                   c.PRINSIDER, c.COUNTRY, c.ISE, nvl(nbs,substr(nls,1,4)) nbs, a.tip, a.nls, a.kv, a.acc, a.ob22, -ost_korr(a.acc,l_dat31,null,a.nbs) bv,
                   a.rnk, a.branch, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, a.mdate wdate, a.acc nd, null sdate,1 deb, c.okpo
            from   accounts a, cp_deal cp, customer c
            where  (cp.active=1 or cp.active = -1 and cp.dazs >= p_dat01) and substr(a.nls,1,4)='3541'  and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and  a.acc in  (cp.accr,cp.acc) and
                   a.rnk = c.rnk  and a.acc not in ( select accc from accounts where nbs is null  and  substr(nls,1,4)='3541'  and accc is not null);
      else
         OPEN c0 FOR
            select 21 tipa, decode(c.custtype,3,3,2) custtype, c.custtype cus, substr( decode(c.custtype,3, c.nmk, nvl(c.nmkk,c.nmk) ) , 1,35) NMK,
                   c.PRINSIDER, c.COUNTRY, c.ISE, a.nbs, a.tip, a.nls, a.kv, a.acc, a.ob22, x.s0 bv,a.rnk, a.branch,
                   DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, a.mdate wdate, x.id nd, x.fdat sdate, d.deb, c.okpo
            from   xoz_ref_arc x, accounts a, customer c, rez_deb d
            where  x.mdat = p_dat01 and a.nbs = d.nbs and d.deb in (2) and d.deb is not null and x.fdat < p_dat01 and (x.datz >= p_dat01 or x.datz is null) and s0<>0 and s<>0 and x.acc=a.acc
                   and  ( f_tip_xoz(p_dat01, a.acc, a.tip) in ('XOZ','W4X')  and  l_xoz_new = 1 ) and a.rnk=c.rnk;
      end if;
      loop
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;

         if k.bv >0 THEN
            l_grp   := f_get_port (k.nd, k.rnk);
            if  l_grp <>0 THEN  l_s250 := '8';
            else                l_s250 := null; l_grp := null;
            end if;

            l_Text := ''; l_sdate := k.sdate; l_wdate := NULL;  l_fin := NULL; l_pd_0 := 0; l_nd := k.nd; l_tip_fin := 0;

            if k.kv = 980 THEN l_istval := 0;
            else
               begin
                  select nvl(istval,0) into l_istval from specparam where acc = k.acc;
               EXCEPTION  WHEN NO_DATA_FOUND  THEN l_istval := 0;
               end;
            end if;
            begin
               select s180 into l_s180 from nd_val where fdat = p_dat01 and nd = k.nd and rnk = k.rnk and tipa = k.tipa;
            EXCEPTION  WHEN NO_DATA_FOUND  THEN l_s180 := null;
            end;

            l_ddd := f_ddd_6B(k.nbs);
            --l_tip_fin := f_get_nd_tip_fin (k.nd, p_dat01,k.rnk, k.tipa);
            l_tip_fin := f_get_nd_val_n ('TIP_FIN',k.nd, p_dat01, k.tipa, k.rnk);
             if l_tip_fin is null THEN
               if k.deb in (1,2) THEN l_tip_fin := 0; end if;
                 -- если не нашло реальный TIP_FIN нельзя переопеределять как ЮЛ или ФЛ (причины: Изменили РНК, внесли остаток корректирующими)
                 -- if k.cus=2 THEN                   l_tip_fin := 2;
                 -- else                              l_tip_fin := 1;
                -- end if;
            end if;
            l_max := 1;
            begin
               select substr(value,1,1) into l_RNK_FIN from accountsw nt  where nt.acc = k.acc and nt.tag ='RNK_FIN'; -- Враховувати в єдину категорію
            EXCEPTION  WHEN NO_DATA_FOUND  THEN l_RNK_FIN :='1';
            end;

            if l_RNK_FIN = '0' THEN l_MAX := 0 ; -- не враховувати в єдину категорію
            end if;

            l_kol    := f_get_nd_val_n ('KOL', k.nd, p_dat01, k.tipa, k.rnk);
            l_fin    := f_rnk_maxfin (p_dat01, k.rnk  , l_tip_fin, k.nd, l_max);
            --logger.info('XOZ 1 : acc = ' || k.acc || 'k.deb = ' || k.deb || ' k.nbs = ' || k.nbs  ) ;
            case WHEN k.deb = 1 and l_s250 = 8 THEN l_deb := 3; l_fin:=1;
            else                                    l_deb := k.deb;
            end case;
            if    l_tip_fin = 0 and l_fin = 1 THEN l_pd := f_rez_kol_fin_pd(l_deb, 2, l_kol); --f_rez_kol_fin_pd(2, l_kol);
            elsif l_tip_fin = 0 and l_fin = 2 THEN l_pd := 1;
            else                                   l_pd := f_rez_fin_pd (l_tip_fin, nvl(l_fin,f_fin23_fin351(l_fin23,l_kol)), l_kol);
            end if;

            if k.nbs in ('2805','2806') THEN
               begin
                  select substr(value,1,1) into l_DEB_BEZ from accountsw nt  where nt.acc = k.acc and nt.tag ='DEB_BEZ'; -- 1 Безнадійна дебіторська заборгованість
               EXCEPTION  WHEN NO_DATA_FOUND  THEN l_DEB_BEZ :='0';
               end;
               if l_DEB_BEZ = '1' THEN l_fin := 2; l_pd := 1;
               else                    l_fin := 1; l_pd := 0; l_pd_0 := 1;
               end if;
            end if;
            if k.rnk = 909311 and sys_context('bars_context','user_mfo') = '300465' THEN  -- COBUSUPABS-5538
               l_fin := 1;
               l_PD  := 0;
            end if;
            if k.nbs = '3541' THEN l_fin := 2; l_pd := 1; end if;
            l_s080 := f_get_s080 (p_dat01,l_tip_fin, l_fin);
            l_EAD  := k.bv/100;
            l_EADQ := p_icurval(k.kv,k.bv,l_dat31)/100;
            l_RC   := 0;
            l_RCQ  := 0;
            l_CV   := 0;
            l_LGD  := 1;
            l_CR   := round(greatest(0,l_pd * (l_EAD - (l_CV + l_RC))),2);
            l_CRQ  := p_icurval(k.kv,L_CR*100,l_dat31)/100;
            INSERT INTO REZ_CR (fdat   , RNK  , NMK   , ND   , SDATE   , KV    , NLS   , ACC      , EAD   , EADQ   , FIN  , PD      , BV     ,
                                CR     , CRQ  , TIPA  , bv02 , bv02q   , s180  , pd_0  , rz       , RC    , RCQ    , nbs  , custtype, BVQ    ,
                                okpo   , LGD  , s250  , grp  , istval  , s080  , ddd_6B, tip_fin  , ob22  , wdate  , tip  , KOL     , FIN23  , TEXT  )
                        VALUES (p_dat01, k.RNK, k.NMK , k.nd , l_sdate , k.kv  , k.nls , k.acc    , l_ead , l_eadq , l_fin, l_pd    , l_ead  ,
                                l_CR   , l_CRQ, k.tipa, l_ead, l_eadq  , l_s180, l_pd_0, k.rz     , l_RC  , l_RCQ  , k.nbs, k.cus   , l_eadq ,
                                k.okpo , l_LGD, l_s250, l_grp, l_istval, l_s080, l_ddd , l_tip_fin, k.ob22, k.wdate, k.tip, l_kol   , l_fin23, l_TEXT || ' Фин.= ' || l_fin);
         end if;
      END loop;
      z23.to_log_rez (user_id , 351 , p_dat01 ,'Конец Дебиторка 351 ');
   end;
end;
/
show err;

PROMPT *** Create  grants  DEB_351 ***
grant EXECUTE                                                                on DEB_351         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DEB_351         to RCC_DEAL;
grant EXECUTE                                                                on DEB_351         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DEB_351.sql =========*** End *** =
PROMPT ===================================================================================== 
