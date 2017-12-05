CREATE OR REPLACE PACKAGE BARS.T2017 IS

   g_header_version   constant varchar2 (64) := 'version 2.4  21.11.2017';
   g_trace            constant varchar2 (64) := 'T2017:';

--============ Зміни в плані рах 2017 р.=======================

procedure OTCN   (p_mode int)  ; --  Авто-трансформація довідників по звітності
procedure TAG_KF ( p_mode int) ; --  Авто-трансформація додаткових рекв  в ACCOUNTSW
procedure TAG    (p_mode int)  ; --  Авто-трансформація додаткових рекв  в ACCOUNTSW
procedure CLS    (p_mode int, p_kf varchar2) ;  --  Авто-закр рах, що вилучено в НБУ
procedure T_CCk        (p_NBS varchar2 , p_ob22 varchar2)   ;  -- перекодировка CCK_OB22
procedure NNLS         ( p_mode int); -- Прогноз-розрахунок ББББкХХХХХХХХХ для трансформації рахунків
procedure JB           ( p_mode int); -- всеобщий запуск трансформера
procedure OPN          ( p_mode int, aa_OLD accounts%rowtype, tt TRANSFER_2017%rowtype) ; -- p_mode = 1 - замена счета, =2 открытие нового счета
procedure OB           ( p_R020_old varchar2)  ;
procedure OB1          ( TT TRANSFER_2017%rowtype )  ;
procedure nbs          ( p_r020_old varchar2 , p_ob_old varchar2 default '%');
procedure NBS1         ( p_R020_old varchar2, p_R020_new varchar2)  ;
function  Get_NLS      (p_nbs accounts.NBS%type) return accounts.NLS%type   ;
function  OB22_old     (p_R020_new varchar2, p_ob22_new varchar2, p_R020_old varchar2) return accounts.ob22%type   ;
function  Get_OB22_old (p_acc number, p_dat_alt date ) return accounts.ob22%type   ;
procedure nbs_parallel2( p_start_old_nbs number , p_end_old_nbs number, p_start_ob_old varchar2 default '%', p_stop_ob_old varchar2 default '%' );
procedure transfer_accounts(p_nbs varchar2, p_ob22 varchar2, p_nbs_notlike varchar2,p_kf varchar2);
procedure ACC_1x       (p_nbs varchar2, p_ob22 varchar2, p_nbs_notlike varchar2,p_kf varchar2);
procedure T_CP         (p_mode int);
procedure T_Param      (p_mode int, p_kf varchar2);

   FUNCTION header_version   RETURN VARCHAR2;
   FUNCTION body_version     RETURN VARCHAR2;
-------------------
END T2017;
/
CREATE OR REPLACE PACKAGE BODY BARS.T2017 IS  g_body_version   CONSTANT VARCHAR2 (64) := 'version 1.2  21.11.2017-2';
   g_errN number := -20203 ;  nlchr char(2) := chr(13)||chr(10) ;
--------------------------------------------------------------------
procedure E01(p_Er number, p_tbl varchar2 )  is begin if p_Er = -00001 then null;   else raise_application_error(p_ER ,'Помилка '|| p_tbl); end if; end E01;
-----------------------------------------------------------------------------
procedure OTCN   (p_mode int) is --  Авто-трансформація довідників по звітності
    begin
       -- Часть  -1
       for k in ( select * from mv_kf)
       loop  bc.go (k.KF) ; --большая табл счетов, политизированная по KF, потому идем от счета
             update SPECPARAM_INT s set s.R020_FA = (select r020_new from transfer_2017 t where t.r020_old = s.R020_FA and rownum =1 ) where s.R020_FA is not null;
             commit;
             T2017.TAG_KF ( p_mode ) ;
             commit ;
       end loop;
       -------------
       bc.go ('/') ;
       -------------
       -- таблица трансфер - большая, потому идем от нее, и меняем мелкие справочники
    for p in ( select R020_old, min(R020_new) R020_new  from transfer_2017 where r020_old <>  r020_new  GROUP by R020_old )
    loop
       -- Тільки R020
       begin update KL_F20        set r020    = p.r020_new where r020    = p.r020_old ; exception when others then T2017.E01(SQLCODE,'KL_F20'       ); end;
------ begin update KL_F3_29      set r020    = p.r020_new where r020    = p.r020_old ; exception when others then T2017.E01(SQLCODE,'KL_F3_29'     ); end;
------ begin update KL_F3_29_INT  set r020    = p.r020_new where r020    = p.r020_old ; exception when others then T2017.E01(SQLCODE,'KL_F3_29_INT' ); end;
       begin update OTC_RISK_S580 set r020    = p.r020_new where r020    = p.r020_old ; exception when others then T2017.E01(SQLCODE,'OTC_RISK_S580'); end;

       --Трансформація + ручне коригування
       begin update SP_NEW_R011   set r020    = p.r020_new where r020    = p.r020_old ; exception when others then T2017.E01(SQLCODE,'SP_NEW_R011'  ); end;
       begin update SPR_R020_R012 set r020    = p.r020_new where r020    = p.r020_old ; exception when others then T2017.E01(SQLCODE,'SPR_R020_R012'); end;
         ----------------------------------------------------------------------------------------------------------------------------------------------------
       Suda;

       for pp in (select * from transfer_2017 where r020_old <> r020_new and ob_old <> ob_new and r020_old = p.r020_old )
       loop
         -- Разом R020 +Об22
         begin update SB_P0853 set R020_fa = pp.r020_new, ob22 = pp.ob_new  where R020_fa=pp.r020_old and ob22=pp.ob_old ; exception when others then T2017.E01(SQLCODE,'SB_P0853'    ); end; --план рахунків ПО ОБ22 (SB_P0851)                                                                                                                      \
         begin update xoz_ob22     set deb = pp.r020_new||       pp.ob_new  where deb = pp.r020_old||          pp.ob_old ; exception when others then T2017.E01(SQLCODE,'xoz_ob22'    ); end; --Рахунки для закриття Деб.заборг.
         begin update xoz_ob22     set krd = pp.r020_new||       pp.ob_new  where krd = pp.r020_old||          pp.ob_old ; exception when others then T2017.E01(SQLCODE,'xoz_ob22'    ); end; --Рахунки для закриття Деб.заборг.
         begin update xoz_ob22_cl  set deb = pp.r020_new||       pp.ob_new  where deb = pp.r020_old||          pp.ob_old ; exception when others then T2017.E01(SQLCODE,'xoz_ob22_cl' ); end; --XOZ_OB22_CL.Референтні  терміни знаходження на балансі
         begin update Fin_debt   set NBS_N = pp.r020_new||       pp.ob_new where NBS_N= pp.r020_old||          pp.ob_old ; exception when others then T2017.E01(SQLCODE,'xoz_ob22'    ); end; --основа для продукт ФДЗ,
         begin update Fin_debt   set NBS_P = pp.r020_new||       pp.ob_new where NBS_N= pp.r020_old||          pp.ob_old ; exception when others then T2017.E01(SQLCODE,'xoz_ob22'    ); end; --основа для продукт ФДЗ,
         begin update Fin_debt   set NBS_K = pp.r020_new||       pp.ob_new where NBS_N= pp.r020_old||          pp.ob_old ; exception when others then T2017.E01(SQLCODE,'xoz_ob22'    ); end; --основа для продукт ФДЗ,
         begin update GRP_REZ_NBS  set nbs = pp.r020_new, ob22 = pp.ob_new  where nbs = pp.r020_old and ob22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'GRP_REZ_NBS' ); end; --Группа резервирования - бал.счет. - ОБ22
         begin update TMP_NBS_2401 set nbs = pp.r020_new, ob22 = pp.ob_new  where nbs = pp.r020_old and ob22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'TMP_NBS_2401'); end; --Продукти кредитів портфельного методу

         --Не знаю що за таблиці і де використовуються
         begin update STRU1  set R020 = pp.r020_new, OB22 = pp.ob_new  where R020 = pp.r020_old and OB22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'STRU1' ); end;
         begin update STRU2  set R020 = pp.r020_new, OB22 = pp.ob_new  where R020 = pp.r020_old and OB22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'STRU2' ); end;
         begin update STRU2a set R020 = pp.r020_new, OB22 = pp.ob_new  where R020 = pp.r020_old and OB22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'STRU2a'); end;
         begin update STRU3  set R020 = pp.r020_new, OB22 = pp.ob_new  where R020 = pp.r020_old and OB22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'STRU3' ); end;
         begin update STRU3a set R020 = pp.r020_new, OB22 = pp.ob_new  where R020 = pp.r020_old and OB22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'STRU3a'); end;
         begin update STRU4  set R020 = pp.r020_new, OB22 = pp.ob_new  where R020 = pp.r020_old and OB22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'STRU4' ); end;
         begin update STRU5  set R020 = pp.r020_new, OB22 = pp.ob_new  where R020 = pp.r020_old and OB22 = pp.ob_old ; exception when others then T2017.E01(SQLCODE,'STRU5' ); end;

       end loop; -- pp

    end loop ;  -- p;

end OTCN ;


-------------------------------
--
--
-------------------------------
procedure TAG_KF ( p_mode int) is --  Авто-трансформація додаткових рекв  в ACCOUNTSW
begin
 for k in (select * from mv_kf)
 loop
  bc.go(k.kf);
  For w in  (select  Rowid RI,  value from accountsW where tag in ( 'S6110' )  )
  loop begin select  nls into w.value from accounts  where nlsalt = w.value;
             update accountsW set value = w.value where rowid = w.RI;
       EXCEPTION WHEN NO_DATA_FOUND   THEN null;
       end ;
  end loop ; --w
  end loop; -- k
  bc.home;
end TAG_KF ;


-------------------------------
--
--
-------------------------------
procedure TAG    ( p_mode int) is --  Авто-трансформація додаткових рекв  в ACCOUNTSW
begin for k in   ( select * from mv_kf)   loop bc.go ( k.KF); T2017.TAG_KF ( p_mode ) ;    end loop ; --k
end TAG ;
-------------------------------
procedure CLS   (p_mode int, p_kf varchar2)   is  l_dazs date ;  --  Авто-закр рах, що вилучено в НБУ
begin
   bars_audit.info('T2017:CLS Start для '||p_kf);
 
   bc.go (p_kf); 
   l_dazs := gl.bdate +1 ;   
   for Z in (select Rowid RI from accounts A where A.dazs is null and A.ostc = 0 and exists (select 1 from PS x where x.nbs = A.nbs and x.d_close is not null) )
   loop  update accounts set dazs = greatest ( l_dazs , dapp+1)  where rowid = z.RI;   end loop; -- z

   bars_audit.info('T2017:CLS Finish для '||p_kf);

end CLS;
-------------------
procedure T_CCk   (p_NBS  varchar2,   p_ob22 varchar2  ) is  -- перекодировка CCK_OB22
                   l_NBS  varchar2(9) := Nvl(p_NBS ,'%') ;
                   l_OB22 varchar2(9) := Nvl(p_OB22,'%') ;
                   l_trace     varchar2(500) := g_trace||'.T_CCk: ';
  NEW  cck_ob22%rowtype;
  BBBBOO  varchar2(6)  ;
  l_NBS60 varchar2(4)  ;
  ----
  Function TRN ( OLD_NBS varchar2, OLD_OB22 varchar2 )   return varchar2 IS   l_BBBBOO varchar2(6);
  begin begin select r020_new || ob_new into l_BBBBOO from transfer_2017 where r020_old = OLD_NBS and ob_old = OLD_OB22 ;
        EXCEPTION WHEN NO_DATA_FOUND    THEN l_BBBBOO := OLD_NBS || OLD_OB22 ;
        end ;                         RETURN l_BBBBOO ;
  end;
  ------
begin

 for OLD in ( select r.* from cck_ob22 r where NBS like L_NBS and OB22 like L_OB22 and d_close is null and nbs like '2%' and exists(select 1 from transfer_2017 x where r.nbs = x.r020_old and r.ob22 = x.ob_old) )
 loop

    NEW     := OLD ;
    l_NBS60 := CASE WHEN OLD.NBS in ('2202', '2203') then '6042'
                    WHEN OLD.NBS in ('2212', '2213') then '6043'
                    WHEN OLD.NBS in ('2232', '2233') then '6046'
                    WHEN OLD.NBS like '22%'          then '6043'
                    --------------------------------------------
                    WHEN OLD.NBS in ('2020'        ) then '6022'
                    WHEN OLD.NBS in ('2062', '2063') then '6026'
                    WHEN OLD.NBS in ('2072', '2073') then '6027'
                    WHEN OLD.NBS in ('2082', '2083') then '6029'
                    WHEN OLD.NBS like '20%'          then '6026'
                    --------------------------------------------
                    else null
                    end ;

    BBBBOO  := TRN (        OLD.NBS             , OLD.OB22    ) ; NEW.Ob22    := Substr(BBBBOO,5,2) ; NEW.NBS := Substr(BBBBOO,1,4); -- NBS        БР  ~тiла~кр, OB22    C    ob22~SS~тiла~кр
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '5' , OLD.SPI     ) ; NEW.SPI     := Substr(BBBBOO,5,2) ;                                -- SPI        ob22~SPI~прем~***5
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '6' , OLD.SDI     ) ; NEW.SDI     := Substr(BBBBOO,5,2) ;                                -- SDI        ob22~SDI~диск~***6
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '7' , OLD.SP      ) ; NEW.SP      := Substr(BBBBOO,5,2) ;                                -- SP        ob22~SP~прс.T~***7
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '8' , OLD.SN      ) ; NEW.SN      := Substr(BBBBOO,5,2) ;                                -- SN        ob22~SN~нар.% ~***8
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '9' , OLD.SPN     ) ; NEW.SPN     := Substr(BBBBOO,5,2) ;                                -- SPN        ob22~SPN~прс.%~***9
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '9' , OLD.SPN_31  ) ; NEW.SPN_31  := Substr(BBBBOO,5,2) ;                                -- SPN_31    ob22~SPN~прс%~>30 дн
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '9' , OLD.SPN_61  ) ; NEW.SPN_61  := Substr(BBBBOO,5,2) ;                                -- SPN_61    ob22~SPN~прс%~>60 дн
    BBBBOO  := TRN ( Substr(OLD.NBS,1,3) || '9' , OLD.SPN_181 ) ; NEW.SPN_181 := Substr(BBBBOO,5,2) ;                                -- SPN_181    ob22~SPN~прс%~>181 дн
    BBBBOO  := TRN (           '3579'           , OLD.SK9     ) ; NEW.SK9     := Substr(BBBBOO,5,2) ;                                -- SK9        ob22~SK9~прс.K~3579
    BBBBOO  := TRN (           '3579'           , OLD.SK9_31  ) ; NEW.SK9_31  := Substr(BBBBOO,5,2) ;                                -- SK9_31    ob22~SK9~прсK~>30 дн
    BBBBOO  := TRN (           '3579'           , OLD.SK9_61  ) ; NEW.SK9_61  := Substr(BBBBOO,5,2) ;                                -- SK9_61    ob22~SK9~прсK~>60 дн
    BBBBOO  := TRN (           '3579'           , OLD.SK9_181 ) ; NEW.SK9_181 := Substr(BBBBOO,5,2) ;                                -- SK9_181    ob22~SK9~прсK~>181 дн
    BBBBOO  := TRN (          l_NBS60           , OLD.SD_N    ) ; NEW.SD_N    := Substr(BBBBOO,5,2) ;                                -- SD_N        ob22~SD~%  н~6***
    BBBBOO  := TRN (          l_NBS60           , OLD.SD_I    ) ; NEW.SD_I    := Substr(BBBBOO,5,2) ;                                -- SD_I        ob22~SD$~%  i~6***
    BBBBOO  := TRN (          l_NBS60           , OLD.SD_M    ) ; NEW.SD_M    := Substr(BBBBOO,5,2) ;                                -- SD_M        ob22~АM~ н~6***
    BBBBOO  := TRN (          l_NBS60           , OLD.SD_J    ) ; NEW.SD_J    := Substr(BBBBOO,5,2) ;                                -- SD_J        ob22~АM$~ i~6***
    BBBBOO  := TRN (           '6111'           , OLD.SD_SK0  ) ; NEW.SD_SK0  := Substr(BBBBOO,5,2) ;                                -- SD_SK0    OB22~ рах. доходiв ~ для щомiсячної ~комiсiї 61* для 3578
    BBBBOO  := TRN (           '6118'           , OLD.SD_9129 ) ; NEW.SD_9129 := Substr(BBBBOO,5,2) ;                                -- SD_9129    OB22~ рах. доходiв ~ для комiсiї~ на 9129'   61* для 9129
    BBBBOO  := TRN (           '6110'           , OLD.SD_SK4  ) ; NEW.SD_SK4  := Substr(BBBBOO,5,2) ;                                -- SD_SK4    OB22~ рах. доходiв ~ для комiсiї~ за достр. пог.

    update cck_ob22 set  D_CLOSE  = nvl(BARS.glb_bankdate,sysdate)  where nbs = OLD.NBS and ob22 = OLD.OB22 ;
    
    bars_audit.info(l_trace||'  обнолвнеие таблицы CCK_OB22  NEW.NBS = '||NEW.NBS||'NEW.Ob22 = '||NEW.Ob22);
    
    begin
     insert into CCK_OB22 values NEW;
    exception when others then    E01(SQLCODE,'CCK_OB22');
    end;

--S903    C    ob22~ZZI~для~903*
--S950    C    ob22~ZAL~для~950*
--S952    C    ob22~ZAL~для~952*
--SLN    C    ob22~SLN~сом.%~***?
--CR9    C    ob22~CR9~для~9129
--SK0    C    ob22~SK0~нар.K~3578
--SG    C    ob22~SG~пог.~3739
--SLK    C    ob22~SLK~сом.K~***?
--S260    C    Продукт~ НБУ ~ S260
--ISG    C    ob22~ISG~дох майб період

 end loop ;

 -- перекодировка спец.справочника w4_nbs_ob22 (В.Хомида)

declare
  l_sql    varchar2(32000);
  l_new_ob varchar2(2);
begin
  for i in (select *
              from w4_nbs_ob22 unpivot(atr_vallue for attribute_name in(ob_9129,
                                                                        ob_ovr,
                                                                        ob_2207,
                                                                        ob_2208,
                                                                        ob_2209,
                                                                        ob_3570,
                                                                        ob_3579,
                                                                        ob_2627,
                                                                        ob_2625x,
                                                                        ob_2627x,
                                                                        ob_2625d,
                                                                        ob_2628))) loop
    if i.attribute_name in ('OB_2207', 'OB_2209', 'OB_3579') then
      l_sql := null;
      begin
        select t.ob_new
          into l_new_ob
          from transfer_2017 t
         where t.r020_old = substr(i.attribute_name, 4, 4)
           and t.ob_old = i.atr_vallue;
      exception
        when no_data_found then
          continue;
      end;
      l_sql := 'update w4_nbs_ob22 set '||i.attribute_name||' = '''||l_new_ob||''' where nbs = :nbs2 and ob22 = :ob222 and tip = :tip2';
      execute immediate l_sql
        using substr(i.attribute_name, 4, 4), i.ob22, i.tip;
    elsif i.tip = 'W4C' and i.attribute_name = 'OB_OVR' then
      l_sql := null;
      begin
        select t.ob_new
          into l_new_ob
          from transfer_2017 t
         where t.r020_old = '2202'
           and t.ob_old = i.atr_vallue;
      exception
        when no_data_found then
          continue;
      end;
      l_sql := 'update w4_nbs_ob22 set '||i.attribute_name||' = '''||l_new_ob||''' where nbs = :nbs2 and ob22 = :ob222 and tip = :tip2';
      execute immediate l_sql
        using substr(i.attribute_name, 4, 4), i.ob22, i.tip;
    end if;

  end loop;
end;

end T_CCk;
-------------------------------------------------------------------------------------

procedure NNLS         ( p_mode int) is -- Прогноз-розрахунок ББББкХХХХХХХХХ для трансформації рахунків
begin delete from NLS_2017; ----   execute immediate ' TRUNCATE TABLE NLS_2017 ';
  for k in (select * from mv_kf ) --- union select '300465' kf  from dual )
  loop bc.go (k.kf);
     FOR S IN (SELECT  distinct  a.NLS,   t.r020_new,     t.r020_new||'_'|| SUBSTR(A.NLS,6,9)  nls_new
               from accounts a , TRANSFER_2017 t    where a.dazs is null and a.nbs = t.r020_old and a.ob22 = t.ob_old )
     LOOP
         BEGIN select NULL into S.nls_new from accounts where nls like S.nls_new and rownum = 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
               begin select NULL into S.nls_new from NLS_2017 where kf = k.kf and nls_new like S.nls_new and rownum = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN null;
               end;
         end ;
         If S.nls_new is not null then
            S.nls_new := Vkrzn( substr( k.Kf,1,5) , S.nls_New );
            insert into nls_2017 ( nls_old, nls_new, kf) values ( S.nls, S.nls_new, k.KF) ;
         end if;
     end loop ; -- s
  END LOOP;  -- k
end NNLS;
---------------

procedure JB  ( p_mode int) is  -- всеобщий запуск трансформера
  l_job_name varchar2(20) :=  'BARS.JB_2017' ;
begin
--  RETURN;

  begin  dbms_scheduler.drop_job(job_name => l_job_name ) ;  -- удалить, если есть
  exception when others then  if sqlcode  = -27475 then null ; else raise; end if;
  end;


  dbms_scheduler.create_job(   job_name   => l_job_name,    job_type => 'PLSQL_BLOCK',
                               job_action => 'begin t2017.NBS_JOB; end ;',
                               start_date => sysdate,-- перший запуск
------------------------- repeat_interval => 'FREQ=DAILY;BYHOUR=03;BYMINUTE=00;BYSECOND=0', ------
                               enabled => true,
                               auto_drop => false,
                               comments => 'Одноразовий загальний запуск трансформера-2017 по переходу на новий план рах в 2017 р.'
                             );
  dbms_scheduler.run_job(l_job_name, false ) ;

end JB;

-----------------------------
--
-- Процедура по модификации счета
-- p_mode = 1 - замена счета, =2 открытие нового счета
--
---------------------------
procedure opn     ( p_mode int,  aa_old accounts%rowtype,  tt transfer_2017%rowtype) is
      aa_new      accounts%rowtype ;
      ii          int_accn%rowtype;
      p4_         int ;
      sp          specparam%rowtype;
      si          specparam_int%rowtype;
      sTmp_       varchar2(250); nTmp_ number;
      oo          oper%rowtype;
      DPA         ree_tmp%rowtype;
      cc          customer%rowtype;
      l_mod       char(3);
      l_choosen   number;
      l_count     number :=0;

begin

      If aa_old.NBS ='3579' then      
         If aa_old.tip  = 'ODB'  then   aa_NEW.tip := 'OFR' ; else aa_NEW.tip := aa_OLD.tip ;  end if;  
      end if;

      -- сохраняем старый хвост
      AA_NEW.NLS :=  Vkrzn( substr( gl.amfo,1,5), tt.r020_new||'0' || substr( aa_OLD.nls, 6,9) );


      l_count := 0; 
      while l_count < 100   
      loop
         begin
            update accounts set tip = aa_NEW.tip, NLS = AA_NEW.NLS, nbs = tt.R020_NEW, nlsalt = aa_old.NLS, DAT_ALT = sysdate, ob22 = tt.ob_new where acc = aa_old.ACC ;
            l_count    := 0;
            EXIT ;
         exception when others then     
            if sqlcode=-1 then AA_NEW.NLS := vkrzn ( substr(gl.aMfo,1,5) , tt.R020_NEW ||'0'|| trunc ( dbms_random.value (1, 999999999 ) ) );
                               l_count := l_count + 1;
            end if;

         end;

      end loop;

      if l_count > 0 then   bars_audit.info( 'T2017.OPN: для old.NLS='||aa_old.NLS ||' не найден NEW.NLS' );
      Else
         update SPECPARAM set OB22_alt = aa_OLD.ob22  where acc = aa_old.ACC ;
         -- сохраняем АСС
         AA_NEW.ACC := aa_old.Acc;

         If NVL( aa_OLD.vid,0) <> 0 then  -- DPA
            delete from ree_tmp where kv = aa_old.KV and nls = aa_old.NLs and mfo= gl.aMfo;

            select * into  cc from customer where rnk = aa_old.rnk ; cc.nmk := nvl(cc.nmkk,substr(cc.nmk,1,38));
            -- закрыть
            Insert into ree_tmp ( mfo,    id_a,     rt, ot,        nls,     odat,        kv,    c_ag,   nmk,   nmkw,   c_reg,    c_dst, prz) --  закрытие
                      select  gl.aMfo, cc.Okpo, cc.tgr,'3', AA_OLD.NLS, Nvl(BARS.glb_bankdate,sysdate) , aa_old.KV, G.rezid,cc.nmk,cc.nmk, cc.c_reg, cc.c_dst, 1
                      from codcagent G  where codcagent = cc.codcagent and exists (select 1 from DPA_NBS where nbs = tt.R020_OLD and TYPE='DPA' and TAXOTYPE=3) ;
            -- открыть
            Insert into ree_tmp ( mfo,    id_a,     rt, ot,        nls,     odat,        kv,    c_ag,   nmk,   nmkw,   c_reg,    c_dst, prz) -- открытие
                       select gl.aMfo, cc.Okpo, cc.tgr,'1', AA_NEW.NLS, nvl(BARS.glb_bankdate , sysdate) , aa_old.KV, G.rezid,cc.nmk,cc.nmk, cc.c_reg, cc.c_dst, 1
                       from codcagent G  where codcagent = cc.codcagent and exists (select 1 from DPA_NBS where nbs = tt.R020_NEW and TYPE='DPA' and TAXOTYPE=1) ;
         end if ; -- DPA

         --- Журнал счетов
         delete from accounts_update where acc = aa_old.acc and trim(chgdate)  = trim(sysdate);
         ----- закрыть
         INSERT INTO   accounts_update
             (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
              chgdate , chgaction , doneby ,idupd  , effectdate, branch,ob22, globalbd,send_sms  )
         VALUES (aa_old.acc   ,aa_old.nls  ,aa_old.nlsalt,aa_old.kv    ,tt.R020_OLD   ,aa_old.nbs2,aa_old.daos  ,aa_old.isp   ,aa_old.nms   ,aa_old.pap,
              aa_old.grp   ,aa_old.sec  ,aa_old.seci  ,aa_old.seco  ,aa_old.vid   ,aa_old.tip , nvl(BARS.glb_bankdate,sysdate) ,  -- дата закр
              aa_old.blkd  ,aa_old.blkk  ,aa_old.lim,   aa_old.pos   ,aa_old.accc ,aa_old.tobo  ,aa_old.mdate ,aa_old.ostx  ,aa_old.rnk ,aa_old.kf    ,
              sysdate      ,3,user_name ,bars_sqnc.get_nextval('s_accounts_update',aa_old.kf) , nvl(BARS.glb_bankdate ,sysdate), aa_old.branch, aa_old.ob22 , 
              nvl(BARS.glb_bankdate , sysdate) , aa_old.send_sms);
         ----- открыть
         INSERT INTO   accounts_update
             (acc, nls, nlsalt, kv, nbs, nbs2, daos, isp, nms  , pap, grp, sec, seci, seco, vid, tip, dazs, blkd, blkk, lim, pos, accc, tobo, mdate, ostx, rnk, kf ,
              chgdate , chgaction , doneby,idupd  , effectdate, branch,ob22,globalbd,send_sms  )
         VALUES (aa_old.acc  ,aa_new.nls  ,aa_old.nls ,aa_old.kv ,tt.R020_NEW,aa_old.nbs2, nvl(BARS.glb_bankdate,sysdate)  ,-- дата откр
                 aa_old.isp  ,aa_old.nms  ,aa_old.pap ,aa_old.grp,aa_old.sec ,aa_old.seci, aa_old.seco,aa_old.vid  ,aa_NEW.tip ,  -- yjdsq nbg cx
                 aa_old.dazs ,aa_old.blkd ,aa_old.blkk,aa_old.lim, aa_old.pos,aa_old.accc,aa_old.tobo ,aa_old.mdate,aa_old.ostx,aa_old.rnk ,aa_old.kf   ,
                 sysdate     ,1,user_name ,bars_sqnc.get_nextval('s_accounts_update',aa_old.kf), nvl(BARS.glb_bankdate ,sysdate) , aa_old.branch, aa_old.ob22 , 
                 nvl(BARS.glb_bankdate , sysdate), aa_old.send_sms   );
       ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      end if;  -- l_count > 0 

end OPN ;


------------------------------------------------------------------------------
procedure OB      ( p_R020_old varchar2)   IS
begin for tt in (select * from TRANSFER_2017 where r020_old like p_R020_old and ob_old is not null and R020_new is not null and ob_new is not null )
       loop T2017.OB1(TT); end loop;
end OB;


------------------------------------------------
--
-- обновление операций
--
------------------------------------------------
procedure ob1 ( tt transfer_2017%rowtype )  is
  l_txt    varchar2(100) := 'Новий-2017р.' ;
  y_like   varchar(15);
  n_like   varchar(15);
  l_trace  varchar(500) := g_trace||'.'||'ob1:';
begin
   bars_audit.info('T2017.OB1 Start '||tt.R020_old||' -> '||tt.R020_new||'. ob22:'||tt.ob_old||' -> '||tt.ob_new);
   suda;

   insert into SB_OB22(R020,    OB22,    TXT,               D_OPEN)
   select tt.R020_new, tt.ob_new, NVL(tt.comm,l_txt), nvl(BARS.glb_bankdate,sysdate)  from dual where not exists (select 1 from sb_ob22 where r020=tt.r020_new and ob22=tt.ob_new); -- Коди OB22 для рахунків

   update SB_OB22 set D_CLOSE = nvl(BARS.glb_bankdate,sysdate) where r020 = tt.r020_old and ob22 = tt.ob_old and D_CLOSE is     null ;
   update SB_OB22 set D_CLOSE = null     where r020 = tt.r020_new and ob22 = tt.ob_new and D_CLOSE is NOT null ;

   update tts      set nlsm = REPLACE (nlsm , '''' || tt.r020_old || ''',''' || tt.ob_old||'''',''''|| tt.r020_new||''','''||tt.ob_new||'''' ),  -- Справочник типов транзакций
                     nlsk = REPLACE (nlsk , '''' || tt.r020_old || ''',''' || tt.ob_old||'''',''''|| tt.r020_new||''','''||tt.ob_new||'''' ),
                     nlsa = REPLACE (nlsa , '''' || tt.r020_old || ''',''' || tt.ob_old||'''',''''|| tt.r020_new||''','''||tt.ob_new||'''' ),
                     nlsb = REPLACE (nlsb , '''' || tt.r020_old || ''',''' || tt.ob_old||'''',''''|| tt.r020_new||''','''||tt.ob_new||'''' ) ;

   update tts      set nlsm = REPLACE (nlsm , tt.r020_old||tt.ob_old, tt.r020_new||tt.ob_new ),
                     nlsk = REPLACE (nlsk , tt.r020_old||tt.ob_old, tt.r020_new||tt.ob_new ),
                     nlsa = REPLACE (nlsa , tt.r020_old||tt.ob_old, tt.r020_new||tt.ob_new ),
                     nlsb = REPLACE (nlsb , tt.r020_old||tt.ob_old, tt.r020_new||tt.ob_new ) ;

   y_like := '%'''||tt.r020_old||'''%';
   n_like := '%'''||tt.ob_old  ||'''%';

   update tts set nlsm = REPLACE (nlsm , ''''||tt.r020_old||'''', ''''||tt.r020_new||'''' ) where  nlsm  like y_like and nlsm not like n_like;
   update tts set nlsk = REPLACE (nlsk , ''''||tt.r020_old||'''', ''''||tt.r020_new||'''' ) where  nlsk  like y_like and nlsm not like n_like;
   update tts set nlsa = REPLACE (nlsa , ''''||tt.r020_old||'''', ''''||tt.r020_new||'''' ) where  nlsa  like y_like and nlsm not like n_like;
   update tts set nlsb = REPLACE (nlsb , ''''||tt.r020_old||'''', ''''||tt.r020_new||'''' ) where  nlsb  like y_like and nlsm not like n_like;
 
   begin update PS_TTS       set nbs  =  tt.r020_new, ob22 =tt.ob_new  where nbs    = tt.r020_old and ob22 = tt.ob_old ; exception when others then T2017.E01(SQLCODE,'PS_TTS'      ); end; --БалРахунки  <->   Операцiї
   begin update tarif        set nbs  =  tt.r020_new, ob22 =tt.ob_new  where nbs    = tt.r020_old and ob22 = tt.ob_old ; exception when others then T2017.E01(SQLCODE,'tarif'       ); end; --0. БАЗОВI тарифи
   begin update RAZ_KOM      set KOD  =  tt.r020_new||      tt.ob_new  where KOD    = tt.r020_old||          tt.ob_old ; exception when others then T2017.E01(SQLCODE,'RAZ_KOM'     ); end; --<<ФО:Комiсiя за послуги>>
   begin update MONEY2       set nbs  =  tt.r020_new, ob22 =tt.ob_new  where nbs    = tt.r020_old and ob22 = tt.ob_old ; exception when others then T2017.E01(SQLCODE,'MONEY2'      ); end; --Закордоннi перекази ФО. Котловi рах обiлiку

 --begin update DPU_TYPES_OB22 set NBS_DEP = tt.r020_new, OB22_DEP=tt.ob_new  where NBS_DEP= tt.r020_old and OB22_DEP= tt.ob_old ; exception when others then T2017.E01(SQLCODE,'DPU_TYPES_OB22'); end; --Depozit UL
 --begin update DPU_TYPES_OB22 set NBS_int = tt.r020_new, OB22_int=tt.ob_new  where NBS_int= tt.r020_old and OB22_int= tt.ob_old ; exception when others then T2017.E01(SQLCODE,'DPU_TYPES_OB22'); end;
 --begin update DPU_TYPES_OB22 set NBS_EXP = tt.r020_new, OB22_EXP=tt.ob_new  where NBS_EXP= tt.r020_old and OB22_EXP= tt.ob_old ; exception when others then T2017.E01(SQLCODE,'DPU_TYPES_OB22'); end;
 --begin update DPU_TYPES_OB22 set NBS_RED = tt.r020_new, OB22_RED=tt.ob_new  where NBS_RED= tt.r020_old and OB22_RED= tt.ob_old ; exception when others then T2017.E01(SQLCODE,'DPU_TYPES_OB22'); end;

   begin update NBS_TIPS     set nbs  = tt.r020_new, ob22    =tt.ob_new  where nbs    = tt.r020_old and ob22    = tt.ob_old ; exception when others then T2017.E01(SQLCODE,'NBS_TIPS'      ); end; --Звязок БР <->Типи рахунків

   If tt.r020_old = '6110' then
      begin EXECUTE IMMEDIATE         -- кліринг по пл.системам -- только в ГОУ = ММФО
           'update MONEX_MV_UO set OB22_KOM = decode (OB22_KOM, :r020_old || :ob_old, :r020_new || :ob_new, OB22_KOM ) ' using tt.r020_old, tt.ob_old, tt.R020_new, tt.OB_new ;
      exception when others then  if SQLCODE = - 00942 then null;   else raise; end if; -- ORA-00942: table or view does not exist
      end;
      update  SWI_MTI_LIST set OB22_KOM = TT.OB_NEW where  OB22_KOM = TT.OB_OLD ;
    end if;

  --If tt.r020_old = '3579' and tt.ob_old ='24' then      update E_TARIF set ob22_3579 = '02' ;   end if ;
    If tt.r020_old = '3579'  then  update E_TARIF set ob22_3579 = tt.ob_new where ob22_3579 = tt.ob_old;   end if ;
    If tt.r020_old = '6110'  then  update E_TARIF set OB22_6110 = tt.ob_new where OB22_6110 = tt.ob_old;   end if ;

    begin  EXECUTE IMMEDIATE 'update BRANCH_TAGS set nbs = :R020_new, ob22 = :OB_NEW where nbs = :R020_OLD and ob22 = :OB_OLD ' using   tt.r020_new,  tt.ob_new,   tt.R020_OLD,   tt.OB_OLD ;
    exception when others then null;
    end;


    -- политизированные табл
    for k in (select * from MV_KF )
    loop  bc.go (k.KF);
        -- bars_audit.info(l_trace||'старт обработки для '||k.KF);
        update OPE_LOT  set bs1= tt.r020_new, ob1    = tt.ob_new  where bs1 = tt.r020_old and ob1  = tt.ob_old ; --Рiзнi перекриття, макети, лотереi, iнше

        begin  update NBS_PROFNAM set nbs = tt.r020_new  where nbs   = tt.r020_old ;
        exception when others then   bars_audit.error(l_trace||'ошибка обновление справочника NBS_PROFNAM:'|| dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
        end;

        begin  update NBS_PROF    set nbs = tt.r020_new  where nbs   = tt.r020_old ;
        exception when others then   bars_audit.error(l_trace||'ошибка обновление справочника NBS_PROF:'|| dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
        end;
    end loop; -- k

    suda;
    update TRANSFER_2017 set dat_beg = nvl(BARS.glb_bankdate ,sysdate)  where r020_old = tt.r020_old and ob_old = tt.ob_old and r020_new = tt.r020_new and ob_new = tt.ob_new;
    commit;
   
exception when others then
    suda;
    bars_audit.error(l_trace||'ошибка быполнения:'||sqlerrm||', стек:'||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
   raise;
end ob1;



-------------------------------------------------
--
--  Основная процедура трансформации  по номеру балансового и obb22
--  Запускается в основном режиме трансформации с p_r020_old = номер балансового ,  p_ob_old   = '%'
--
--  Для тест режима возможен запуск с маской балансового и имской об22
--
-------------------------------------------------

procedure nbs ( p_r020_old varchar2, p_ob_old varchar2 default '%')   is
    l_r020_old varchar2(10) := nvl(p_r020_old , '%');
    l_ob_old   varchar2(10) := nvl(p_ob_old   , '%');
begin

  bars_audit.info('T2017.NBS Start ');

  for bb in (select distinct r020_new, r020_old
             from transfer_2017
             where r020_old like l_r020_old
               and r020_new is not null
               and ob_old like l_ob_old
               and ob_new is not null
               and dat_beg is  null
             order by r020_old
             )
  loop
    If bb.r020_old in (   -- исключения по резрвам
                '1490' ,    --Резерви пiд знецiнення боргових цiнних паперiв, що рефiнансуються Нацiональним банком Укра•ни, у портфелi банку на продаж
                '1491' ,    --Резерви пiд знецiнення боргових цiнних паперiв, що рефўнансуються Нацўональним банком Укра•ни, у портфелi банку до погашення
                '1590' ,        --Резерви пiд заборгованiсть iнших банкiв за кредитними операцiями
                '1592' ,    --Резерви за коштами, розмiщеними на кореспондентських рахунках в iнших банках
                '1890' ,    --Резерви пiд дебiторську заборгованiсть за операцўями з банками
                '2400' ,    --Резерви пiд кредити, що наданi клўїнтам та оцiнюються на iндивiдуальнiй основi
                '2401' ,    --Резерви пiд кредити, що наданi клўїнтам та оцiнюються на портфельнiй основi
                '2890' ,    --Резерви пўд дебўторську заборгованўсть за операцўями з клўїнтами банку
                '3190' ,    --Резерви пўд знецўнення фўнансових ўнвестицўй у портфелў банку на продаж
                '3290' ,    --Резерви пўд знецўнення цўнних паперўв у портфелў банку до погашення
                '3590' ,    --Резерви пiд дебўторську заборгованiсть за операцiями банку
                '3599' ,    --Резерви пiд заборгованўсть за iншими нарахованими доходами
                '3690'              --Резерви за виданими фўнансовими зобов'язаннями
                --,
                --'7700' ,    --Вўдрахування в резерви пўд дебiторську заборгованўсть за операцўями з банками
                --'7701' ,    --Вўдрахування в резерви пўд заборгованўсть ўнших банкўв
                --'7702' ,    --Вўдрахування в резерви пўд заборгованўсть за наданими кредитами клўїнтам
                --'7703' ,    --Вўдрахування в резерви пўд знецўнення цўнних паперўв у портфелў банку на продаж
                --'7704' ,    --Вўдрахування в резерви пўд знецўнення цўнних паперўв у портфелў банку до погашення
                --'7705' ,    --Вўдрахування в резерви за дебўторською заборгованўстю та iншими активами банку
                --'7706' ,    --Вўдрахування в банкiвськi резерви на покриття ризикiв та втрат
                --'7720'
     ) then null ;   --Вiдрахування в резерви пiд заборгованiсть за нарахованими доходами
    else

        -- обновление справочников
        t2017.nbs1( bb.r020_old, bb.r020_new );

        -- обновление справочников, зависящих от об22
        for tt in (select * from transfer_2017
                     where r020_old = bb.R020_old
                       and R020_new is not null
                       and ob_old like L_ob_old
                       and ob_new is not null AND DAT_BEG IS NULL )
        loop
            t2017.ob1(tt) ;
            commit;
        end loop;


    end if;  -- исключения по резрвам

  end loop; -- b


   If p_R020_old is null and p_ob_old is null and getglobaloption ('BMS') = '1'  then -- BMS Признак: 1-установлена рассылка сообщений
      bms.enqueue_msg( 'Рекомендовано виконати збір статистики по табл.ACCOUNTS  ',  dbms_aq.no_delay, dbms_aq.never, gl.aUid  );
   end if;
   bars_audit.info( 'T2017.NBS Finish ');

end NBS;

------------------------------------
--
-- Основаня процедура трансформации
--
------------------------------------

procedure nbs_parallel2( p_start_old_nbs number , p_end_old_nbs number, p_start_ob_old varchar2 default '%', p_stop_ob_old varchar2 default '%' )
is
begin
    nbs (p_r020_old => p_start_old_nbs, p_ob_old => p_start_ob_old) ;

end nbs_parallel2;


------------------------------------
--
-- Основаня процедура трансформации
-- обновление справочников, содержащих балансовые счета
--
------------------------------------
procedure NBS1( p_R020_old varchar2, p_R020_new varchar2)  is

   l_txt   varchar2(100) := 'Новий-2017р.';
   tps     tips%rowtype ;
   l_trace varchar2(500) := g_trace||'.nbs1';

begin

    bars_audit.info('T2017.NBS1 Start '||p_R020_old||'->'||p_R020_new);
    suda; ----  if gl.aMfo is null then raise_application_error(g_errn,'На рівні / це неможниво')  ;  end if ;

    If p_r020_old ='3579' then
       tps.name := 'OFR.Прострочена Фін.дебіторка';
       tps.tip  := 'OFR';
       update  tips set name = tps.name where tip = tps.tip ; if SQL%rowcount = 0 then
       Insert into tips (tip,NAME) values (tps.tip, tps.name) ; end if;
    end if;


    begin
        savepoint my_savepoint;
        bars_context.set_policy_group('WHOLE'); -- уходим на группу политик доступную для "/"

        insert into PS         (NBS,PAP,NAME,CLASS)  select p_R020_new,x.pap,l_txt,x.CLASS  from ps x           where nbs=p_R020_old and not exists (select 1 from ps             where nbs=p_r020_new); -- План рахунків
        update PS set D_CLOSE = nvl(BARS.glb_bankdate,sysdate)  where nbs = p_R020_old  and D_CLOSE is null ;

        insert into RKO_NBS       (NBS)  select p_R020_new   from RKO_NBS        where nbs=p_R020_old and not exists (select 1 from RKO_NBS        where nbs=p_r020_new); -- РКО:  Балансові рахунки
      insert into DEB_REG_NBS   (NBS)  select p_R020_new   from DEB_REG_NBS    where nbs=p_R020_old and not exists (select 1 from DEB_REG_NBS    where nbs=p_r020_new); -- Перелік бал рахунків простроченого боргу
       insert into NBS_PRINT_BANK(NBS)  select p_R020_new   from NBS_PRINT_BANK where nbs=p_R020_old and not exists (select 1 from NBS_PRINT_BANK where nbs=p_r020_new); -- Балансові рахунки для друку реквізитів банку
       insert into NBS_DEB_POG   (NBS)  select p_R020_new   from NBS_DEB_POG    where nbs=p_R020_old and not exists (select 1 from NBS_DEB_POG    where nbs=p_r020_new); -- БС ДЕБЕТ по погашению  ПРОЦ и ТЕЛА
       insert into GROUPS_NBS (NBS,ID)              select p_R020_new, ID                  from GROUPS_NBS where nbs=p_R020_old and not exists (select 1 from GROUPS_NBS where nbs=p_r020_new); -- Групи доступу до рахунків <-> Балансові рахунки
       insert into E_NBS      (NBS,FL)              select p_R020_new, FL                  from E_NBS      where nbs=p_R020_old and not exists (select 1 from E_NBS      where nbs=p_r020_new); -- Балансові рахунки під абонплату

       If p_r020_old ='6110' then update E_TARIF$BASE set nls6 ='6510' ; end if;

       insert into NBS_K014   (NBS,K014)            select p_R020_new, K014                from NBS_K014   where nbs=p_R020_old and not exists (select 1 from NBS_K014   where nbs=p_r020_new); -- допустимих БР для типів клієнтів
       insert into ZAY_BAL    (NBS,FL_AUTOPEN )     select p_R020_new, FL_AUTOPEN          from ZAY_BAL    where nbs=p_R020_old and not exists (select 1 from ZAY_BAL    where nbs=p_r020_new); --  доп бал.счетов модуля "Биржевые операции"
       insert into DPA_NBS    (NBS,TYPE,TAXOTYPE)   select p_R020_new,TYPE,TAXOTYPE        from DPA_NBS    where nbs=p_R020_old and not exists (select 1 from DPA_NBS    where nbs=p_r020_new); -- Класифікатор рахунків для реестру @F
       insert into PS_SPARAM  (NBS,SPID,OPT,SQLVAL) select p_r020_new,SPID,OPT,SQLVAL      from PS_SPARAM  where nbs=p_r020_old and not exists (select 1 from PS_SPARAM  where nbs=p_r020_new); -- Розподіл спецпараметрів по бал.рахунках
       insert into PS_TTS   (NBS,TT,DK,OB22)   select p_r020_new,tt,dk,null   from PS_TTS   where nbs=p_r020_old and ob22 is null and not exists (select 1 from PS_TTS   where nbs=p_r020_new and ob22 is null);  -- БалРахунки  <->   Операцiї
       insert into NBS_TIPS (NBS,TIP,OPT,OB22) select p_r020_new,TIP,OPT,OB22 from NBS_TIPS where nbs=p_r020_old and ob22 is null and not exists (select 1 from NBS_TIPS where nbs=p_r020_new and ob22 is null); --Звязок БР <->Типи рахунків
       insert into CC_VIDD (VIDD,CUSTTYPE,TIPD,NAME,SPS) select p_r020_new,CUSTTYPE,TIPD,NAME,SPS from CC_VIDD where vidd=p_r020_old and not exists (select 1 from CC_VIDD where vidd=p_r020_new);

       --update dpt_vidd set bsD    = p_r020_new  where bsD   = p_r020_old ;  -- Виды вкладов
           --update dpt_vidd set bsN    = p_r020_new  where bsN   = p_r020_old ;
           --update dpt_vidd set bsA    = p_r020_new  where bsA   = p_r020_old ;

       update CC_AIM     set nbs    = p_r020_new  where nbs   = p_r020_old and D_CLOSE is null; -- Цільове призначення договору
       update CC_AIM     set nbs2   = p_r020_new  where nbs2  = p_r020_old and D_CLOSE is null;
       update CC_AIM     set nbsf   = p_r020_new  where nbsf  = p_r020_old and D_CLOSE is null;
       update CC_AIM     set nbsf2  = p_r020_new  where nbsf2 = p_r020_old and D_CLOSE is null;
       ---update W4_SPARAM  set nbs    = p_r020_new  where nbs   = p_r020_old ;

       update ACC_OVER_NBS set  NBS2600 = decode ( NBS2600, p_r020_old, p_r020_new, NBS2600),  -- БР оверд
                                NBS2000 = decode ( NBS2000, p_r020_old, p_r020_new, NBS2000),
                                NBS2607 = decode ( NBS2607, p_r020_old, p_r020_new, NBS2607),
                                NBS2067 = decode ( NBS2067, p_r020_old, p_r020_new, NBS2067),
                                NBS2069 = decode ( NBS2069, p_r020_old, p_r020_new, NBS2069),
                                NBS2096 = decode ( NBS2096, p_r020_old, p_r020_new, NBS2096),
                                NBS2480 = decode ( NBS2480, p_r020_old, p_r020_new, NBS2480),
                                NBS9129 = decode ( NBS9129, p_r020_old, p_r020_new, NBS9129),
                                NBS3579 = decode ( NBS3579, p_r020_old, p_r020_new, NBS3579);

        update NLSMASK set  MASK =  p_r020_new || substr(MASK, 6,9) where  substr(MASK, 1,4)  = p_r020_old;
        EXECUTE IMMEDIATE 'insert into NOTPORTFOLIO_NBS(NBS,USERID,PORTFOLIO_CODE) select :p_r020_new,USERID, PORTFOLIO_CODE from NOTPORTFOLIO_NBS where nbs= :p_r020_old and not exists (select 1 from NOTPORTFOLIO_NBS where nbs= :p_r020_new )'  ----  Непортвельні nbs
                  using p_r020_new , p_r020_old,  p_r020_new ;
        bars_context.set_context(); -- возвращаемся в свой контекст
    exception  when others then
          rollback to my_savepoint;
          bars_context.set_context();
          bars_audit.error(l_trace||'ошибка бвыполнения:'||sqlerrm||', стек:'||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
          raise; -- возвращаемся в свой контекст и  показываем пользователю, что произошла ошибка
    end;
    bars_audit.info('T2017.NBS1 Finish '||p_R020_old||'->'||p_R020_new);
end NBS1;


-------------------------------
--
--
-------------------------------
function  Get_NLS (p_nbs accounts.NBS%type) return accounts.NLS%type   is   --получение № лиц.сч по случ.числам
  nTmp_ number;    l_nls accounts.NLS%type ;
Begin   While 1<2        loop nTmp_ := trunc ( dbms_random.value (1, 999999999 ) ) ;
           begin select 1 into nTmp_ from accounts where nls like p_NBS||'_'||nTmp_  ;
           EXCEPTION WHEN NO_DATA_FOUND THEN EXIT ;
           end;
        end loop;
         l_nls := vkrzn ( substr(gl.aMfo,1,5) , p_NBS||'0'||nTmp_ );
  RETURN l_Nls ;
end Get_Nls ;

--------------------
function OB22_old (p_R020_new varchar2, p_ob22_new varchar2, p_R020_old varchar2) return accounts.ob22%type   is
 l_OB22_old accounts.ob22%type;
begin

  begin select ob_old into l_OB22_old from TRANSFER_2017 where r020_new = p_R020_new and ob_new= p_ob22_new and r020_old = p_r020_old and ob_new is not null and rownum = 1 ;
  EXCEPTION WHEN NO_DATA_FOUND THEN null; end;
  RETURN l_OB22_old ;
end OB22_old;
-----------------------

function  Get_OB22_old (p_acc number, p_dat_alt date ) return accounts.ob22%type  is l_ob22 accounts.ob22%type ;
    aa accounts%rowtype ;
begin
    If p_dat_alt is not null then
       begin select ob22_alt into l_ob22 from specparam where acc = p_acc and ob22_alt is not null;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          begin select * into aa from accounts where acc=p_acc;
                l_ob22 := T2017.OB22_old(aa.nbs,aa.ob22,substr(aa.nlsalt,1,4) );
          EXCEPTION WHEN NO_DATA_FOUND THEN null;
          end ;
       end;
    else
       begin select ob22 into l_ob22 from accounts where acc = p_acc ;
       EXCEPTION WHEN NO_DATA_FOUND THEN null;
       end ;
    end if ;

    RETURN l_ob22 ;

end Get_OB22_old ;

  FUNCTION header_version RETURN VARCHAR2 is BEGIN RETURN 'Package header T2017'|| g_header_version; END header_version;
  FUNCTION body_version   RETURN VARCHAR2 is BEGIN RETURN 'Package body T2017'  || g_body_version;   END body_version;





------------------------------------------------
--
-- обновление счетов
--
------------------------------------------------


procedure transfer_accounts(p_nbs varchar2, p_ob22 varchar2, p_nbs_notlike varchar2,p_kf varchar2) is 

  l_trace  varchar(500) := g_trace||'.'||'transfer_accounts: ';
  l_tt     transfer_2017%rowtype;
  l_nbs    varchar2(4):= 'xxxx' ;
  l_ob22   varchar2(2):= 'xx';

begin
   ------------------------------------------
   ACC_1x (p_nbs, p_ob22, p_nbs_notlike, p_KF ) ;   RETURN ;
   ------------------------------------------
   bars_audit.info(l_trace||'старт процедуры');
   suda;
   -- политизированные табл
   for k in (select * from MV_KF )
   loop  bc.go (k.KF);
         bars_audit.info(l_trace||'старт обработки для '||k.KF);
         -- выборка пула счетов по балансовому и об22
         for aa in (select a.* from accounts a, transfer_2017 t
                     where a.dat_alt is null and a.dazs is null
                        and a.nbs = t.r020_old
                        and a.ob22 = t.ob_old
                        and a.nbs     like p_nbs ||'%' 
                        and a.nbs NOT LIKE p_nbs_notlike||'%'
-----------------------and t.dat_end is null
                      order by nbs, ob22
                   )
         loop
            if aa.nbs <> l_nbs  or aa.ob22 <> l_ob22  then
               -- закомитить обработку балансового + об22
               bars_audit.info(l_trace||'обнолвнеие таблицы TRANSFER_2017 dat_beg = '||BARS.glb_bankdate||' r020_old = '||aa.nbs||' ob_old = '||aa.ob22);
               update TRANSFER_2017 set dat_end = BARS.glb_bankdate   where r020_old =  l_nbs and ob_old = l_ob22;
               commit;

               l_nbs  := aa.nbs;
               l_ob22 := aa.ob22;
               select * into l_tt from transfer_2017 t where t.r020_old = l_nbs and t.ob_old  = l_ob22;
            end if;
            t2017.opn( 1, aa, l_tt );
         end loop ;

   end loop;
   update TRANSFER_2017 set dat_end = nvl(BARS.glb_bankdate,sysdate)   where r020_old =  l_nbs and ob_old = l_ob22;
   commit;

   suda;
   bars_audit.info(l_trace||'финиш процедуры');

exception when others then
   suda;
   bars_audit.error(l_trace||'ошибка быполнения:'||sqlerrm||', стек:'||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
   raise;
end transfer_accounts;
------------------------



procedure ACC_1x (p_nbs varchar2, p_ob22 varchar2, p_nbs_notlike varchar2 ,p_kf varchar2) is 
  l_trace  varchar(500) := g_trace||'.'||'ACC1: ';
  l_tt     transfer_2017%rowtype;
  l_nbs    varchar2(4)  := 'xxxx'   ;
  l_ob22   varchar2(2)  := 'xx'     ;
  l_kf     varchar2(6)  := 'xxxxxx' ;
  l_count int := 0 ;
begin bc.go( p_KF) ;

   bars_audit.info('T2017.ACC_1X Start kf=' ||p_kf);
   ----------------------------------------------- выборка пула счетов по балансовому и об22
   for aa in (select a.* from accounts a     where a.dat_alt is null and a.dazs is null 
                and exists (select 1 from transfer_2017 t where nbs=t.r020_old and a.ob22=t.ob_old )
and a.nbs like p_nbs||'%' 
and a.ob22 like p_ob22||'%' 
-- and a.nbs NOT LIKE p_nbs_notlike||'%' --and KF like p_kf ||'%' 
              order by KF, nbs, ob22 )
   loop

      If aa.nbs <> l_nbs  or aa.ob22 <> l_ob22 then   --------------------------------------------------------------------------- закомитить обработку балансового + об22
         bars_audit.info('T2017.ACC_1X Work kf=' ||p_kf || ' r020_old = '||aa.nbs||' ob_old = '||aa.ob22);
         update TRANSFER_2017 set dat_end = nvl(BARS.glb_bankdate,sysdate), col = nvl(col,0) + 1  where r020_old =  l_nbs and ob_old = l_ob22;
         commit;
         l_nbs  := aa.nbs;
         l_ob22 := aa.ob22;
         select * into l_tt from transfer_2017 t where t.r020_old = l_nbs and t.ob_old  = l_ob22;
      end if;

      t2017.opn( 1, aa, l_tt );
      l_count := l_count  +1 ;

      If l_count  > 1000 then commit;     l_count := 0 ; end if;

   end loop ; --

   update TRANSFER_2017 set dat_end = NVL(BARS.glb_bankdate, sysdate)   where r020_old =  l_nbs and ob_old = l_ob22;

   commit;

   suda;

   bars_audit.info('T2017.ACC_1X Finish kf=' ||p_kf);


--exception when others then  suda;  bars_audit.error(l_trace||'ошибка быполнения:'||sqlerrm||', стек:'||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());  raise;
end ACC_1x;

procedure T_CP (p_mode int) is
begin  
  bars_audit.info('T2017.T_CP Start');

  bc.go('300465');
  for k in (select acc, NLS, NLSALT, NBS from accounts where  dat_alt is not null and dazs is null 
              and nbs IN ('1416','1426','3116','3328','3216','3118','3320',
                          '6128','6122','6124','6120','6127','6126','6223','6121','6125') 
            )
  LOOP Update cp_accc set
              NLSA    = decode  (nlsA   , K.NLSALT, K.NLS, NLSA   ),
              NLSD    = decode  (nlsD   , K.NLSALT, K.NLS, NLSD   ),
              NLSP    = decode  (nlsP   , K.NLSALT, K.NLS, NLSP   ),
              NLSR    = decode  (nlsR   , K.NLSALT, K.NLS, NLSR   ),
              NLSR2   = decode  (nlsR2  , K.NLSALT, K.NLS, NLSR2  ),
              NLSS    = decode  (nlsS   , K.NLSALT, K.NLS, NLSS   ),
              NLSZ    = decode  (nlsZ   , K.NLSALT, K.NLS, NLSZ   ),
              NLSG    = decode  (nlsG   , K.NLSALT, K.NLS, NLSG   ),
              NLS_FXP = decode  (NLS_FXP, K.NLSALT, K.NLS, NLS_FXP),
              S605    = decode  (S605   , K.NLSALT, K.NLS, S605   ),
              S605P   = decode  (S605P  , K.NLSALT, K.NLS, S605P  ),
              NLS_PR  = decode  (NLS_PR , K.NLSALT, K.NLS, NLS_PR ),
              S2VD    = decode  (S2VD   , K.NLSALT, K.NLS, S2VD   ),
              S2VP    = decode  (S2VP   , K.NLSALT, K.NLS, S2VP   ),
              S2VD0   = decode  (S2VD0  , K.NLSALT, K.NLS, S2VD0  ),
              S2VP0   = decode  (S2VP0  , K.NLSALT, K.NLS, S2VP0  ),
              S2VD1   = decode  (S2VD1  , K.NLSALT, K.NLS, S2VD1  ),
              S2VP1   = decode  (S2VP1  , K.NLSALT, K.NLS, S2VP1  ),
              S6499   = decode  (S6499  , K.NLSALT, K.NLS, S6499  ),
              S7499   = decode  (S7499  , K.NLSALT, K.NLS, S7499  )
        where d_close is null ;                        

        If k.NBS <> SUBSTR(k.nlsalt,1,4) then
           for  DOCH in (select Rowid RI , nls  from accounts where accc = k.Acc and dazs is null )
           loop DOCH.nls := VKRZN ( Substr( gl.AMFO,1,5), k.NBS ||'0'|| Substr (DOCH.NLS,6,9) );
                begin update accounts set nls = DOCH.nls where Rowid  = DOCH.RI;  
                exception  when others then  null;
                end;
           end loop; -- DOCH
        end if;
  end loop; -- k
  commit ;

  bars_audit.info('T2017.T_CP Finish');

end T_CP;


procedure T_Param      (p_mode int, p_kf varchar2) is
begin  
  bars_audit.info('T2017.T_Param Start kf='|| p_kf );

  bc.go(p_kf);
  for aa in (select *
             from accounts 
             where dat_alt is not null and dazs is null and nbs in ('6025','6514','6052','6519','6340','6350','3570','3578' )
             ) 
  loop
      If substr(aa.nlsalt,1,4) ='6114' then 
         /* 
            NLS_611415	6114	Комісійні доходи за прийом
            NLS_611406	6114	Комісійні доходи за зовн-економ перекази ЮО
            DOH_KONV	6114	Комісія по операціях з конвертації готівки ІВ
            NLS_611412	6114	Комісія за ПРОДАЖ дорожних ЧЕКІВ
            DINKAS	        6114	Рахунок доходів від  інкасо банкнот інвалюти
            DOR_KOMIS	6114	Комісія по операціях з дорожніми чеками
            NLS_611430	6114	Комісійні доходи за виплату коштів по іменних чеках
            NLS_611413	6114	Комісія за КУПІВЛЮ дорожних ЧЕКІВ
            NLS_611414	6114	Комісійні доходи за прийом переказу по с.МВПС
          */
         begin  EXECUTE IMMEDIATE ' update BRANCH_ATTRIBUTE_VALUE 
                                       set ATTRIBUTE_VALUE = :NEW_NLS  
                                     where ATTRIBUTE_CODE  in (''NLS_611415'',''NLS_611406'',''DOH_KONV'',''NLS_611412'',''DINKAS'', ''DOR_KOMIS'',''NLS_611430'',''NLS_611413'',''NLS_611414'' )
                                      and ATTRIBUTE_VALUE  = :OLD_NLS 
                                      and  BRANCH_CODE     = :BRANCH '  using aa.branch , aa.NLS, aa.NLSalt  ;

         exception when others then   
                EXECUTE IMMEDIATE ' update BRANCH_PARAMETERS
                                        set VAL            = :NEW_NLS  
                                      where tag            in (''NLS_611415'',''NLS_611406'',''DOH_KONV'',''NLS_611412'',''DINKAS'', ''DOR_KOMIS'',''NLS_611430'',''NLS_611413'',''NLS_611414'' )
                                        and VAL            = :OLD_NLS
                                        and  BRANCH        = :BRANCH '  using aa.branch , aa.NLS, aa.NLSalt  ;
         end;
  
    Else 
         /* 
           DEP_S3	        6119	Рахунок 6119
           NLS_611001	6119	Комісійні доходи за операціями з лотерейними білетами
           GNLS_6026	6026	
           GNLS_6042	6042	
           M_6399_14	6399	Дохід від реалізації юв.монет
           DEP_S6    	3579	Рахунок 3579 загальний для деп.сейфів
        */
         begin   EXECUTE IMMEDIATE ' update BRANCH_ATTRIBUTE_VALUE 
                                        set ATTRIBUTE_VALUE = :NEW_NLS  
                                      where ATTRIBUTE_CODE  in (''DEP_S3'',''NLS_611001'',''GNLS_6026'',''GNLS_6042'',''M_6399_14'',''DEP_S6'')
                                        and ATTRIBUTE_VALUE = :OLD_NLS 
                                        and  BRANCH_CODE    = :BRANCH '  using aa.branch, aa.NLS, aa.NLSalt  ;

         exception when others then   

                EXECUTE IMMEDIATE ' update BRANCH_PARAMETERS
                                        set VAL             = :NEW_NLS  
                                      where tag             in  (''DEP_S3'',''NLS_611001'',''GNLS_6026'',''GNLS_6042'',''M_6399_14'',''DEP_S6'')
                                        and VAL             = :OLD_NLS 
                                        and  BRANCH         = :BRANCH '  using aa.branch||'%', aa.NLS, aa.NLSalt  ;
         end;
      end if;

  end loop; -- k
  commit ;

  bars_audit.info('T2017.T_Param Finish kf='|| p_kf );

end T_Param  ;   



---Аномимный блок --------------
begin null ;
END T2017  ;
/
