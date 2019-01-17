

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_23.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_23 ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_23 (P_dat01_ DATE, mode_ NUMBER DEFAULT 0, p_user number default null, nal_ number)  IS

/* Версия 3.1 03-07-2018  19-06-2017 20-01-2017   26-07-2016  18-05-2016 (24-02-2016, 04-01-2016, 18-09-2015)

   Формування макету/проводок по резерву
   -------------------------------------
9) 03-07-2017 (3.1) При переносе в NBU23_REZ_OTCN добавлены REZ9, REZQ9 
8) 19-06-2017  -   Списание с капитала уценки по ЦБ перенесено в PRVN_FLOW (cp_ucenka)
----------------- 351 --------------------
7) 20-01-2017  -   Зміни по постанові 351
----------------- 23  --------------------
6) 26-07-2016 LUDA Немає даних в довіднику (error_type = 1)
5) 18-05-2016 LUDA Списание с капитала уценки по ЦБ (уточнение условий) + оплата по факту.
4) 13-05-2016 LUDA Списание с капитала уценки по ЦБ (уточнение условий)
3) 24-02-2016 LUDA Списание с капитала уценки по ЦБ
2) 04-01-2016 LUDA Перевірка на прийом данних з FINEVARE - повідомлення про помилку
1) 04-01-2016 LUDA При переносе в NBU23_REZ_OTCN добавлена DAT_MI
   26-08-2015 LUDA ВСТАВЛЕНО update rez_protocol set crc = null where dat=dat31_;
   07-05-2015 LUDA Проверка на категорию качества пустая не брать ценные бумаги
   11-03-2015 LUDA Дбавлены проверки на корректность выполнения функций
   10-12-2014 LUDA Добавлен портфельный метод
   22-04-2014 LUDA Перенесла REZERV_23 и убрала его из PAY_23_ob22
------------------
   p_user   -  В норме NULL
------------------
   Mode_= 0 -  с проводками
        = 1 -  Макет проводок
------------------
   nal_ = 0 -  Не врах.в податковий облік {индивидуал.}(для нарах.% не погаш. < 30 днів) +ЦП
          1 -  Врах.   в податковий облік {индивидуал.}(для нарах.% не погаш. < 30 днів)
          2 -  АРЖК
          5 -  Врах.   в податковий облік {индивидуал.}(для нарах.% не погаш. > 30 днів)
          6 -  Не врах.в податковий облік {индивидуал.}(для нарах.% не погаш. > 30 днів)
          7 -  Цінні папери (для нарах.% не погаш. >30 днів)
          8 -  Портфельний метод (Врах.   в податковий облік)
          9 -  Портфельний метод (Не врах.в податковий облік)
          A -  Не врах.в податковий облік {портфельный}(для нарах.% не погаш. < 30 днів)
          B -  Врах.   в податковий облік {портфельный}(для нарах.% не погаш. < 30 днів)
          C -  Врах.   в податковий облік {портфельный}(для нарах.% не погаш. > 30 днів)
          D -  Не врах.в податковий облік {портфельный}(для нарах.% не погаш. > 30 днів)

*/

oo           oper%rowtype  ;

l_finevare   NUMBER ;  l_row_id14   NUMBER ;  l_row_id13   NUMBER ;  l_row_id18   NUMBER ;  l_user       NUMBER ;  l_user_id    NUMBER ;
l_user_err   NUMBER ;  l_kat        NUMBER ;  l_rez        NUMBER ;  l_fl         NUMBER ;  l_rez_pay    NUMBER ;  l_pay        NUMBER ;
l_rnk        NUMBER ;  l_ref        INT    ;  l_kf     varchar2(6);

dat31_       date   ;  dat01_       date   ;  l_dat        date   ;


---------------------------------------
procedure p_error( p_error_type  NUMBER,
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
   insert into srezerv_errors ( dat      , userid  , error_type  , nbs  , s080                     , custtype  , kv  , branch  ,
                                nbs_rez  , nbs_7f  , nbs_7r      , sz   , error_txt                , desrc     )
                       values ( dat01_   , user_id , p_error_type, p_nbs, p_s080                   , p_custtype, p_kv, p_branch,
                                p_nbs_rez, p_nbs_7f, p_nbs_7r    , p_sz , substr(p_error_txt,1,999), p_desrc   );
   COMMIT;
end;
---------------------------------------

begin
   dbms_application_info.set_client_info(':'|| gl.aMfo ||':8) ARE: Формування проводок по МСФЗ-9');
   DELETE FROM srezerv_errors;
   commit;

   IF P_DAT01_ IS NULL then  dat01_ := ROUND(SYSDATE,'MM');
   else                      dat01_ := p_dat01_;
   end if;

   -- Дата для корригуючих річних
   --   dat01_   := to_date('01-01-2016','dd-mm-yyyy'); -- Звітна дата
   --   gl.bdate := to_date('29-01-2016','dd-mm-yyyy'); -- Банківська дата для річних коригуючих

   l_fl := 0;

   if p_user is null and nal_ = 0 THEN
      begin
         select max(row_id) into l_row_id14 from rez_log where fdat=dat01_ and kod=-14;
         --logger.info('ZAL23-0 : l_row_id14= ' || l_row_id14) ;
         if l_row_id14 is NULL THEN
            --logger.info('ZAL23-1 : l_row_id14= ' || l_row_id14) ;
            z23.to_log_rez (user_id , 99 , dat01_ ,'Не виконан розрахунок забезпечення на '||dat01_);
            raise_application_error(-20001,'Не виконан розрахунок забезпечення на '||dat01_);
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         --logger.info('ZAL23-2 : l_row_id14= ' || l_row_id14) ;
         z23.to_log_rez (user_id , 99 , dat01_ ,'Не виконан розрахунок забезпечення на '||dat01_);
         raise_application_error(-20001,'Не виконан розрахунок забезпечення на '||dat01_);
      END;

      begin
         select max(row_id) into l_row_id13 from rez_log where fdat=dat01_ and kod=-13;
         if l_row_id13 is null THEN
            z23.to_log_rez (user_id , 99 , dat01_ ,'Не виконан п. 1.1. Розрахунок кредитного ризику по постанові 351 (ЗАГАЛЬНА) на '||dat01_);
            raise_application_error(-20002,'Не виконан п. 1.1. Розрахунок кредитного ризику по постанові 351 (ЗАГАЛЬНА) на '||dat01_);
         end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         z23.to_log_rez (user_id , 99 , dat01_ ,'Не виконан п. 1.1. Розрахунок кредитного ризику по постанові 351 (ЗАГАЛЬНА) на '||dat01_);
         raise_application_error(-20002,'Не виконан п. 1.1. Розрахунок кредитного ризику по постанові 351 (ЗАГАЛЬНА) на '||dat01_);
      END;
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
/*
      begin
         for k in (select * from nbu23_rez where fdat=dat01_ and kat is null and id not like 'CACP%')
         LOOP
            p_error( 10, k.NBS||'/'||k.OB22,null, null, k.kv, k.branch,null,
                     null, null, k.bv*100,k.nls||'/'||k.nd||' Немає кат.кач.'|| k.id, null);
            l_FL:=1;
         END LOOP;
         if l_fl=1 THEN
            raise_application_error(-20006,'Немає категорії якості, переглянте звіт 2902 - Звіт -помилки за дату ' ||dat01_);
         end if;
      END;
*/
      if l_row_id13 < l_row_id14 THEN
         z23.to_log_rez (user_id , 99 , dat01_ ,'Після розрахунку забезпечення не виконано 1.1. Розрахунок кредитного ризику по постанові 351 на '||dat01_);
         raise_application_error(-20003,'Після розрахунку забезпечення не виконано 1.1. Розрахунок кредитного ризику по постанові 351 на '||dat01_);
      end if;

 /*
      begin
         select max(row_id), user_id into l_row_id18,l_user_id from rez_log
         where  fdat=dat01_ and kod=-18  and rownum=1 group by user_id ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         if mode_ = 0 THEN
            z23.to_log_rez (user_id , 99 , dat01_ ,'Не виконан 98. Макет проводок на '||dat01_);
            raise_application_error(-20004,'Не виконан 98. Макет проводок на '||dat01_);
         end if;
      END;
*/
      --выборка счетов для которых нет информации в справочнике
      insert into srezerv_errors (dat,userid, error_type, nbs, s080, custtype, kv, branch,  sz, error_txt, nbs_7f)
      select dat01_, user_id, 3, r.nbs||'/'||r.ob22, null,null ,r.kv,
             rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/' branch,
             sum(nvl(r.rez*100,0)) sz,
             substr('S080 = '||r.kat||', Тип клієнта - '||decode(r.custtype,2, 'Юр.ос.',3, 'Фіз.ос.','')||'. Рахунки - '
                    ||ConcatStr(r.nls),1,999),r.kv
      from nbu23_rez r
      where fdat = dat01_ and nvl(r.rez,0) <> 0
            and not exists (select 1 from srezerv_ob22 o
                            where r.nbs = o.nbs and r.ob22 = decode(o.ob22,'0',r.ob22,o.ob22) and
                                  decode(r.kat,1,1,2) = decode(o.s080,'0',decode(r.kat,1,1,2),o.s080) and
                                  r.custtype = decode(o.custtype,'0',r.custtype,o.custtype) and
                                  r.kv = decode(o.kv,'0',r.kv,o.kv) )
      group by r.nbs,r.ob22, r.kat,r.custtype ,r.kv,rtrim(substr(r.branch||'/',1,instr(r.branch||'/','/',1,3)-1),'/')||'/';
      commit;

      begin
         select userid into l_user_err from srezerv_errors where userid=user_ID and rownum=1;
         raise_application_error(-20005,'Є ПОМИЛКИ при формуванні проводок (ПЕРЕГЛЯНЬTЕ звіт 2902 звіт-помилки) за '||dat01_);
      EXCEPTION WHEN NO_DATA_FOUND THEN  null;
      END;
   end if;
   dat31_ := Dat_last_work(p_dat01_ - 1);
   l_kf := sys_context('bars_context','user_mfo');
   if mode_ = 0 THEN
      z23.to_log_rez (user_id , 17 , dat01_ ,'Начало Проводки - Реальные ');
      dbms_application_info.set_client_info('REZ:'|| l_kf ||': Проводки - Реальные ');
   else
      z23.to_log_rez (user_id , 18 , dat01_ ,'Начало Проводки - МАКЕТ ');
      dbms_application_info.set_client_info('REZ:'|| l_kf ||': Проводки - МАКЕТ ');
   end if;
   delete from srezerv_errors;
   if mode_ = 0 and (p_user is null or p_user = -1) THEN
      -- при новом формировании проводок снимается отметка, что проводки сформированы
      -- в конце проводок отметка проставляется.
      update rez_protocol set crc = null where dat=dat31_;
   END IF;
   -- определение параметров
   --rezerv_23(dat01_); --  делается в распределении резерва
   -- 
   begin
      for k in ( select * from accounts where tip = 'REZ' and ostc < 0 and pap <> 1 ) 
      LOOP
         PAP_ACC (k.acc, 1);   
      end LOOP;
   end;
   begin
      for k in ( select * from accounts where tip = 'REZ' and ostc > 0 and pap <> 2 ) 
      LOOP
         PAP_ACC (k.acc, 2);   
      end LOOP;
   end;

   -- налоговый/не налоговый
   --PAY_23_ob22(dat01_, mode_, p_user,'0');
   PAY_23_ob22(dat01_, mode_, p_user,'0');
   PAY_23_ob22(dat01_, mode_, p_user,'1');
   PAY_23_ob22(dat01_, mode_, p_user,'2');
   PAY_23_ob22(dat01_, mode_, p_user,'5');
   --PAY_23_ob22(dat01_, mode_, p_user,'6');
   -- портфельный метод
   --PAY_23_ob22(dat01_, mode_, p_user,'A');
   PAY_23_ob22(dat01_, mode_, p_user,'B');
   PAY_23_ob22(dat01_, mode_, p_user,'C');
   --PAY_23_ob22(dat01_, mode_, p_user,'D');
   -- ценные бумаги
   PAY_23_ob22(dat01_, mode_, p_user,'3');
   PAY_23_ob22(dat01_, mode_, p_user,'4');
   PAY_23_ob22(dat01_, mode_, p_user,'7');
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
             RPB        , REZ9 , REZQ9
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
             RPB        , REZ9 , REZQ9
      From   nbu23_rez
      where  fdat=dat01_ and nd = decode(p_user, null, nd, -1, nd, p_user);

      if p_USER IS NULL or p_user = -1 then
         INSERT INTO rez_protocol (userid, dat,dat_bank,dat_sys,ref,crc)  VALUES ( user_id, dat31_, gl.bdate, SYSDATE,l_ref,'1');
      END IF;
      commit;

      z23.to_log_rez (user_id , -17 , dat01_ ,'Конец Проводки - Реальные ');
   else
      z23.to_log_rez (user_id , -18 , dat01_ ,'Конец Проводки - МАКЕТ ');
   end if;
   -- ?? Есть ошибки надо ли сообщение ??
   -- s_new_ := 0;
   -- select count(*) into s_new_ from  srezerv_errors;
end;
/
show err;

PROMPT *** Create  grants  PAY_23 ***
grant EXECUTE                                                                on PAY_23          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PAY_23          to RCC_DEAL;
grant EXECUTE                                                                on PAY_23          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_23.sql =========*** End *** ==
PROMPT ===================================================================================== 
