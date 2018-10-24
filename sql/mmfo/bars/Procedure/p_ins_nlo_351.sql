

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INS_NLO_351.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INS_NLO_351 ***

  CREATE OR REPLACE PROCEDURE BARS.P_INS_NLO_351 (p_dat01 date) IS

/* Версия 3.2  23-10-2018  22-11-2017  14-07-2017  09-03-2017  27-01-2017
   НЕОПОЗНАННЫе СЧЕТа
   -------------------------------------

 4) 23-10-2018(3.2) - (COBUMMFO-7488) - Добавлено ОКПО в REZ_CR
 3) 22-11-2017(3.1) - Новый план счетов
 2) 14-07-2017 - проверка по хоз дбиторке (может быть несколько строк с одним и тем же ACC)
 1) 09-03-2017 - custtype,OKPO в NBU23_REZ FIN -- ? ? ?
*/

 l_nd    nbu23_rez.nd%type;
 dat31_  date;

begin

   dat31_ := Dat_last_work (p_dat01 - 1 ) ;  -- последний рабочий день месяца
   z23.DI_SNP;

   for k in ( select distinct acc from accounts a, kl_f3_29 f
              where  ost_korr(a.acc,dat31_,z23.di_,a.nbs)<0 and a.nbs=f.r020 and f.kf='1B' and (dazs is null or dazs >= p_dat01)
                     and f.r020 not in ('2805','2806','1410','1412','1413','1414','1415','1416','1417','1418','1419','1420','1426','1427','1428','3103',
                                        '3102','3105','3107','3110','3111','3113','3114','3115','3116','3117','3118','3119','3214')
                     and a.acc  not in ( select accc from accounts  where nbs is null and substr(nls,1,4)='3541' and accc is not null)
             )

   LOOP
      begin
         select nd into l_nd from nbu23_rez n where n.acc = k.acc and fdat = p_dat01 and rownum=1;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN
         insert into acc_nlo (acc) values (k.acc);
      end;
   end LOOP;

   INSERT INTO REZ_CR (fdat   , RNK   , NMK  , ND  , KV      , NLS   , ACC          , EAD   , EADQ   , FIN    , PD   , VKR ,
                       IDF    , KOL   , FIN23, TEXT, CR      , CRQ   , tipa         , pawn  , zal    , zalq   , kpz  , vidd,
                       tip_zal, bv    , bvq  , LGD , CUSTTYPE, CR_LGD, nbs          , zal_bv, zal_bvq, S250   , dv   , RC  ,
                       RCQ    , KL_351, sdate, RZ  , tip     , OVKR  , BV02         , bv02q , ob22   , grp    , cc_id, pd_0,
                       okpo   , P_DEF , OVD  , OPD , istval  , wdate , ddd_6B       , CCF   , rpb    , tip_fin, s080 )
                SELECT p_dat01, rnk   , NMK  , nd  , KV      , nls   , ND           , BV    , BVQ    , fin    , PD   , NULL,
                       NULL   , 0     , NULL , NULL, REZ     , REZQ  , 99           , NULL  , 0      , 0      , null , NULL,
                       NULL   , BV    , BVQ  , LGD , CUSTTYPE, REZ   , nbs          , 0     , 0      , NULL   , 0    , 0   ,
                       0      , 0     , NULL , RZ  , tip     , NULL  , BV           , BVQ   , ob22   , null   , null , 0   ,
                       okpo   ,null   , null , null, istval  , null  , f_ddd_6B(nbs), null  , 0      , tip_fin, s080
                 from  V_rez_NLO_351;

   INSERT INTO NBU23_REZ ( ob22  , tip, acc , FDAT   , branch, nls  , nmk  , RNK   , NBS, KV  , ND , ID       , BV  , BVQ   , custtype,
                           istval, rz , OKPO, FIN    , KAT   , sdate, REZ23, REZQ23, cr , crq , ead, eadq     , s080, ddd_6B)
                    SELECT ob22  , tip, nd  , p_dat01, branch, nls  , nmk  , rnk   , nbs, kv  , nd , 'NLO'||ND, BV  , BVQ   , custtype,
                           istval, rz , OKPO, fin    , kat   , sdate, REZ  , REZQ  , rez, REZq, BV , BVQ      , s080, f_ddd_6B(nbs)
                    from   V_rez_NLO_351;

   commit;

--  id23_:='NLO';
--  z23.kontrol1  (p_dat01 =>DAT01_ , p_id =>id23_||'%' );
--  commit;

end;
/
show err;

PROMPT *** Create  grants  P_INS_NLO_351 ***
grant EXECUTE                                                                on P_INS_NLO_351   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_INS_NLO_351   to RCC_DEAL;
grant EXECUTE                                                                on P_INS_NLO_351   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INS_NLO_351.sql =========*** End
PROMPT ===================================================================================== 
