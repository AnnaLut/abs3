

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_INS_NLO_351_1414.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_INS_NLO_351_1414 ***

  CREATE OR REPLACE PROCEDURE BARS.P_INS_NLO_351_1414 (p_dat01 date) IS 

/* Версия 2.0  09-03-2017  27-01-2017   
   НЕОПОЗНАННЫе СЧЕТа
   -------------------------------------

 1) 09-03-2017 - custtype,OKPO в NBU23_REZ FIN -- ? ? ?
*/

 l_nd    nbu23_rez.nd%type;
 dat31_  date; 

begin
   pul_dat('01-04-2017','');
   dat31_ := Dat_last_work (p_dat01 - 1 ) ;  -- последний рабочий день месяца
   z23.DI_SNP;
   delete from acc_nlo_1414;
   for k in ( select * from accounts a where substr(a.nls,1,4) in  ('1418','1438') and a.nbs is null and ost_korr(a.acc,dat31_ ,null,'1414') <>0
              and not exists (select 1 from nbu23_rez r  where r. FDAT = p_dat01 and r.acc = a.acc) 
             )

   LOOP                     
      begin
         select nd into l_nd from nbu23_rez n where n.acc = k.acc and fdat = p_dat01;
      EXCEPTION  WHEN NO_DATA_FOUND  THEN 
         insert into acc_nlo_1414 (acc) values (k.acc);   commit;
      end;
   end LOOP;

   INSERT INTO REZ_CR (fdat   , RNK   , NMK  , ND    , KV      , NLS          , ACC , EAD   , EADQ   , FIN    , PD   , VKR , 
                       IDF    , KOL   , FIN23, TEXT  , CR      , CRQ          , tipa, pawn  , zal    , zalq   , kpz  , vidd, 
                       tip_zal, bv    , bvq  , LGD   , CUSTTYPE, CR_LGD       , nbs , zal_bv, zal_bvq, S250   , dv   , RC  , 
                       RCQ    , KL_351, sdate, RZ    , tip     , OVKR         , BV02, bv02q , ob22   , grp    , cc_id, pd_0, 
                       P_DEF  , OVD   , OPD  , istval, wdate   , ddd_6B       , CCF , rpb   , tip_fin, s080   )                                           
                SELECT p_dat01, rnk   , NMK  , nd    , KV      , nls          , ND  , BV    , BVQ    , fin    , PD   , NULL, 
                       NULL   , 0     , NULL , NULL  , REZ     , REZQ         , 99  , NULL  , 0      , 0      , null , NULL, 
                       NULL   , BV    , BVQ  , LGD   , CUSTTYPE, REZ          , nbs , 0     , 0      , 7      , 0    , 0   , 
                       0      , 0     , NULL , RZ    , tip     , NULL         , BV  , BVQ   , ob22   , null   , null , 0   , 
                       null   , null  , null , istval, null    , f_ddd_6B(nbs), null, 0     , tip_fin  , s080 
                 from  V_rez_NLO_351_1414;

   INSERT INTO NBU23_REZ ( ob22, tip, acc , FDAT   , branch, nls , nmk, RNK, NBS  , KV   , ND    , ID       , BV  , BVQ, custtype,
                           s250, dd , ddd , istval , rz    , OKPO, FIN, KAT, sdate, REZ23, REZQ23, cr       , crq , ead, eadq    , 
                           s080, ddd_6B)    
                    SELECT ob22, tip, nd  , p_dat01, branch, nls , nmk, rnk, nbs  , kv   , nd    , 'NLO'||ND, BV  , BVQ, custtype,
                           7   , decode(nbs,'1430',null,2) , decode(nbs,'1430',null,211) , istval , rz    , OKPO, fin, kat, sdate, REZ  , REZQ  , rez      , REZq, BV , BVQ     , 
                           s080, f_ddd_6B(nbs)     
                    from   V_rez_NLO_351_1414;
  
   commit;

--  id23_:='NLO';
--  z23.kontrol1  (p_dat01 =>DAT01_ , p_id =>id23_||'%' );
--  commit; 

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_INS_NLO_351_1414.sql =========**
PROMPT ===================================================================================== 
