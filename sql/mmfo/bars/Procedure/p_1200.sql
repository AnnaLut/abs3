

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_1200.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_1200 ***

  CREATE OR REPLACE PROCEDURE BARS.P_1200 (p_dat01 date) IS

/* Версия 3.5   05-10-2017  21-09-2017  11-09-2017  04-09-2017  18-07-2017  07-02-2017  01-02-2017
   Заполнение PVZ в TMP_REZ_OBESP
   -------------------------------------
 7) 05-10-2017(3.5) -  параметры из таблицы rez_par_9200 (временно, до уточнения алгоритма)
 6) 21-09-2017 - Параметр VNCRR из accountsw
 5) 11-09-2017 - Убрала группу 30* из не ризикових (должен быть pd_0 = 0)
 4) 04-09-2017 - TIPA, TIPA_FV через справочник REZ_DEB
                 Лист від 04-09-2017 - Кузьменко Віталій
                 (валюта та банківські метали до отримання 9200, 9201, 9202, 9203, 9204, 9206, 9207, 9208;
                  активи до отримання 9350, 9351, 9352, 9353, 9354, 9356, 9357, 9358, 9359):
                 1. Визначаємо рахунки за переліком, що наведений вище;
                 2. Класифікуємо, за принципом приведення до найнижчого;
                 3. Проставляємо CCF = 0.
 3) 26-07-2017 - Добавила еще  3049 А, 3143 А, 3144 А , 9359 А (Лист 25-07-2017 18:23 Семенова Виктория)
 2) 18-07-2017 - Добавила рахунки для резервування 3043,3044,9208,9358  (Лист 18-07-2017 18:54 Кузьменко Виталий)
                   До змін	Після змін	Зміст операції
                   3041А	3043А	На суму визнаного активу за валютними своп-контрактами, що оцінюються за справедливою вартістю через прибутки/збитки
                   3041А	3044А	На суму визнаного активу за процентними своп-контрактами, що оцінюються за справедливою вартістю через прибутки/збитки
                   9202А	9208А	На суму вимог щодо отримання валюти за валютними своп-контрактами
                   9352А	9358А	На суму грошових потоків до отримання за процентними своп-контрактами
 1)   07-02-2017 - Добавлен 9 клас
*/
l_s080   specparam.s080%type ; l_DDD_6B nbu23_rez.DDD_6B%type; l_tip_fin  rez_cr.tip_fin%type   ; l_fin  rez_cr.fin%type; l_ccf  rez_cr.CCF%type;
l_ead    rez_cr.ead%type     ; l_eadq   rez_cr.eadq%type     ; l_VNCRR    rez_cr.VKR%type       ; par    rez_par_9200%rowtype;
l_bv     number; l_bvq number; l_idf    number; l_pd   number; l_dat31  date; l_lgd  number  :=1; l_cr     number; l_crq   number;

begin
   l_dat31 := Dat_last_work (p_dat01 - 1);  -- последний рабочий день месяца
   for k in ( select p_dat01 fdat,c.custtype,substr(c.nmk,1,35) nmk, 'NEW/' || acc id, - ost_korr(a.acc,l_dat31,null,a.nbs) bv, 1 fin, 1 kat,
                     c.OKPO, DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) RZ, case when d.tipa in (12, 93) then 1 else 0 end PD_0,
                     d.tipa, a.*, d.tipa_FV
              from accounts a, customer c, rez_deb d
              where d.tipa in (12, 30, 92, 93) and ost_korr(a.acc,l_dat31,null,a.nbs) < 0 and a.rnk = c.rnk and d.nbs = a.nbs )
   LOOP
      l_ccf    := null;  l_pd := 0;  l_fin    := k.fin;
      l_bvq    := p_icurval(k.kv,k.bv,l_dat31)/100; l_bv     := k.bv/100;
      l_eadq   := l_bvq; l_ead  := l_bv;
      /*
      if k.tipa = 92 THEN
         l_fin    := f_rnk_maxfin(p_dat01, k.rnk, l_tip_fin, k.acc, 1);
         l_s080   := f_get_s080 (p_dat01, l_tip_fin, l_fin);
         l_CCF := 0; l_ead  := 0; l_eadq := 0;
         if       k.custtype = 1 and k.RZ = 1   THEN l_idf := 80; l_tip_fin := 1;
            elsif k.custtype = 1 and k.RZ = 2   THEN l_idf := 81; l_tip_fin := 1;
            elsif k.custtype = 2                THEN l_idf := 50; l_tip_fin := 2;
            elsif k.custtype = 3 and k.kv<>980  THEN l_idf := 60; l_tip_fin := 1;
            else                                     l_idf := 60; l_tip_fin := 1;
         end if;
         begin
            select trim(value) into l_VNCRR from accountsw  where acc = k.acc and tag = 'VNCRR';
         exception when no_data_found then l_VNCRR := null;
         end;
          l_pd := fin_nbu.get_pd(k.rnk, k.acc, p_dat01, l_fin, l_VNCRR, l_idf);
      end if;
      */
      begin
         select * into par from rez_par_9200 where fdat = p_dat01 and rnk = k.rnk and nd = k.acc;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN 
         par.VKR := null; par.pd := 0; par.fin := 1; l_ead := l_bv; l_eadq := l_bvq; l_CCF := 100;
      end;
      if par.not_lim = 1 THEN l_ead := 0   ; l_eadq := 0    ; l_CCF := 0;
      else                    l_ead := l_bv; l_eadq := l_bvq; l_CCF := 100;
      end if;
      l_fin := par.fin;
      l_pd  := par.pd;
      l_tip_fin:= f_pd ( p_dat01, k.rnk, k.acc, k.custtype, k.kv, k.nbs, 1, 1);
      l_s080   := f_get_s080 (p_dat01, l_tip_fin, l_fin);
      p_get_nd_val(p_dat01, k.acc, k.tipa, 0, k.rnk, l_tip_fin, nvl(k.fin,1), l_s080);
      l_DDD_6B := f_ddd_6B(k.nbs);
      l_lgd    := 1;
      l_cr     := round(l_ead * l_lgd * l_pd,2);
      l_crq    := p_icurval(k.kv,l_cr*100,l_dat31)/100;
      if k.tipa in (30,12) THEN  l_CCF := 100;  end if;
      INSERT INTO NBU23_REZ ( ob22   , tip  , acc   , FDAT   , branch    , nls       , nmk      , RNK   , NBS      , KV    , ND    , ID    ,
                              BV     , BVQ  , FIN   , KAT    , sdate     , custtype  , rez      , rezq  , REZ23    , REZQ23, cr    , crq   ,
                              vkr    , ead  , eadq  , fin_351, s080      , DDD_6B    , OKPO     , pd_0  , tipa     )
                     values ( k.ob22 , k.tip, k.acc , p_dat01, k.branch  , k.nls     , k.nmk    , k.rnk , k.nbs    , k.kv  , k.acc , k.id  ,
                              l_BV   , l_BVQ, l_fin , k.kat  , k.daos    , k.custtype, l_cr     , l_crq , l_cr     , l_crq ,l_cr   , l_crq ,
                              par.vkr, l_ead, l_eadq, l_fin  , l_s080    , l_DDD_6B  , k.OKPO   , k.pd_0, k.tipa_fv);
      INSERT INTO REZ_CR    ( fdat   , RNK  , NMK   , ND     , KV        , NLS       , ACC      , EAD   , EADQ     , FIN   , PD    , CR    ,
                              CRQ    , bv   , bvq   , LGD    , CUSTTYPE  , nbs       , tip      , sdate , RZ       , s080  , ob22  , pd_0  ,
                              vkr    , idf  , ccf   , istval , wdate     , ddd_6B    , tip_fin  , tipa  )
                  VALUES    ( p_dat01, k.RNK, k.NMK , k.acc  , k.kv      , k.nls     , k.acc    , l_ead , l_eadq   , l_fin , l_pd  , l_cr  ,
                              l_crq  , l_bv , l_bvq , l_lgd  , k.CUSTTYPE, k.nbs     , k.tip    , k.daos, k.RZ     , l_s080, k.ob22, k.pd_0,
                              par.vkr, l_idf, l_ccf , 0      , k.mdate   , l_ddd_6B  , l_tip_fin, k.tipa) ;

   end LOOP;
   commit;
end;
/
show err;

PROMPT *** Create  grants  P_1200 ***
grant EXECUTE                                                                on P_1200          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_1200          to RCC_DEAL;
grant EXECUTE                                                                on P_1200          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_1200.sql =========*** End *** ==
PROMPT ===================================================================================== 
