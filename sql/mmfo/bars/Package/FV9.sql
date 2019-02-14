CREATE OR REPLACE PACKAGE BARS.FV9 IS   
 g_header_version   constant varchar2 (64) := 'version 0  21.09.2018';   
 g_trace     constant varchar2 (64) := 'FV9:';
 ----------------------------------------------------
 procedure CALC_SET    ( p_CALC_SET number, p_mode int ); 
 procedure BEK_REZ     ( p_PX varchar2,  p_Dat01 date, p_KF varchar2   ); 
 procedure Del_ROW     ( p_PX varchar2,  p_Dat01 date, p_KF varchar2   ); 
 procedure Start0      ( p_Dat01 date, p_KF varchar2 ); 
 procedure DEL_SDI     ( p_Dat01 date, p_KF varchar2 ); 
 procedure DEL_REZ_OST ( p_Dat01 date, p_KF varchar2 );
 PROCEDURE p_close_sdi ( p_Dat01 date, p_kf varchar2 );
 procedure MAX_REZ     ( p_Dat01 date, p_KF varchar2 );
 procedure MAX_SDI     ( p_Dat01 date, p_KF varchar2 );  ----------- проверка не НЕПРЕВЫШЕНИЕ допустимого расходжения
 procedure Set_OK      ( p_CALC_SET number, p_Dat01 date, p_KF varchar2, p_NPP varchar2 ); 

 function  Get_Job     ( p_Name varchar2, p_mode int, p_dat01 date, p_kf varchar2) return varchar2;
 function  Get_Run     ( p_Dat01 date, p_KF varchar2) return integer;
 ----------------------------------------------------
 procedure BEK         ( p_TT varchar2, p_DAT     date,                 p_KF varchar2 ) ;  -- откат операций 
 procedure REPAY       ( p_TT varchar2, p_DAT_BAK date, p_DAT_PAY date, p_KF varchar2 ) ; --  Переплата в другом дне 
 ----------------------------------------------------

end FV9 ;
/

CREATE OR REPLACE PACKAGE BODY BARS.FV9  IS
  g_body_version   CONSTANT VARCHAR2(64) := 'version 1.2  11.02.2019';
/*
 11-02-2019(1.2) Операция дооценки ЦБ на сумму резерва FXP --> RXP
 31-01-2019(1.1) БЕК уценки за счет резерва 
 14.01.2019 Sta  Отключила контроль на макс.дельту для 2018 года  / Работает только для :sysdate > to_date ('01.02.2019', 'dd.mm.yyyy');           
 25.09.2018 Sta  Добавила во все эксепшены gl.aMfo
 21.09.2018      Разное по замечаниям Фастовановой
 10.09.2018 Sta  добавлены процедуры отката операций( procedure BEK  ) и  и Переплаты в другом дне (procedure REPAY) - частые ош при работе в вых.день
*/
  g_errN  number  := -20203;
  nlchr   char(2) := chr(13)||chr(10);
  G_Dat31 date   ;
  ---------------
  code_   NUMBER;
  status_ VARCHAR2(10);
  erm_    VARCHAR2(2048);
  trm_    VARCHAR2(2048);

 -------------------------------------------------------------
 --------- p_mode = 1 предназначена для установки отметки о поставленном блоке информации. Выполняется  со стороны FV или вручную
 procedure CALC_SET ( p_CALC_SET number, p_mode int ) is
   FF PRVN_FV_REZ_IFRS9%rowtype;
   QQ PRVN_FV9%rowtype;
   f_Dat31 date ;
   z_Dat01 date := Trunc (sysdate, 'MM');
   l_job_name varchar2 (15);
   l_Run int ;
 begin

   begin select * into FF from PRVN_FV_REZ_IFRS9 x where x.ID_CALC_SET = p_CALC_SET and rownum = 1;
   EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error( g_errN,gl.aMfo||':Не знайдено жодного запису Вітрини для ID_CALC_SET = '|| p_CALC_SET );
   end;

   If p_mode = 0 then  -- Вилучення з дипетчера з ручним відкатом проводок - НЕ используем
      RETURN ;
   end if; 

   f_Dat31  := to_date ( substr( to_char(p_CALC_SET) ,1,6 ),  'YYMMDD') ;
   QQ.Dat01 := Last_day( f_Dat31 ) + 1 ;


   If QQ.Dat01 <> z_Dat01 then 
      If sysdate < to_date ( '10-01-2019', 'dd-mm-yyyy' ) then     null ;
      else raise_application_error( g_errN, gl.aMfo||':'||to_char(f_Dat31, 'dd.mm.yyyy' ) || ' НЕ є звітною датою на '|| to_char(z_Dat01, 'dd.mm.yyyy' ) ||'. ID_CALC_SET = '|| p_CALC_SET ); 
      end if ;
   end if ;

   For k in (SELECT r.kf, r.name 
             from regions r, mv_kf k , (select distinct id_Branch from PRVN_FV_REZ_IFRS9 x where x.ID_CALC_SET = p_CALC_SET ) xx
             where xx.id_branch = r.id and r.kf = k.Kf
            )

   loop QQ.KF      := k.KF   ;
        QQ.name_KF := k.NAME ;
        begin select * into QQ from PRVN_FV9 where dat01 = QQ.dat01 and kf = QQ.kf;
        EXCEPTION WHEN NO_DATA_FOUND THEN     QQ.ID_CALC_SET := p_CALC_SET ;  delete from prvn_fv9 where dat01 <> QQ.dat01;  insert into PRVN_FV9 values QQ ;
        end ;
   end loop ;
   commit;
 end  CALC_SET ;
-----------------------------
procedure BEK_REZ ( p_PX varchar2,  p_Dat01 date, p_KF varchar2   ) Is 
 SQL_ varchar2 (3000) ;  l_job_name varchar2 (15);   s_Dat01    varchar2(12) ;
 
begin 
   s_Dat01 := '''' || to_char (p_dat01, 'dd.mm.yyyy') || '''' ;
   logger.info('BEK_REZ 1 p_PX =''' || p_Px || ''' p_KF = ' || p_KF );
   l_job_name := 'BEK_REZ_'||p_kf;
   begin  
      dbms_scheduler.drop_job(job_name => l_job_name );  -- удалить, если есть
   exception when others then  if sqlcode = -27475 then null; else raise; end if;
   end;    
   SQL_:= 'Begin 
              bars_login.login_user(sys_guid(),'||gl.aUid||', null, null);
              gl.param; 
              BC.GO('|| p_kf ||'); 
              PUL_DAT(' || s_Dat01|| ',null); 
              fv9.Del_ROW ( ''' || p_PX || ''', to_date('||s_Dat01||',''dd.mm.yyyy'') ,' || p_KF ||'); 
              commit;
           end;'; 
   bars_login.set_long_session;

   --запуск JOB
   dbms_scheduler.create_job( job_name   => l_job_name,
                              job_type   => 'PLSQL_BLOCK',
                              job_action => SQL_ ,
                              start_date => sysdate,-- перший запуск
                              repeat_interval => null ,  -- НЕ повторять 
 --repeat_interval => 'FREQ=MONTHLY;BYMONTHDAY=24;BYHOUR=12;BYMINUTE=50;BYSECOND=0',
                              enabled    => true,
                              auto_drop  => true,
                              comments => 'БЭК документов при формировании резервов для ' || p_KF 
                            );
end;
-----------------------------

 procedure Del_ROW   ( p_PX varchar2,  p_Dat01 date, p_KF varchar2   ) Is 
    l_job_name varchar2 (15);     l_Run int ;    FDAT_  date ;    DAT31_ date ; l_kf  PRVN_FV9.kf%type; 
    l_Upd varchar2 (2000);
 begin
    
    If p_PX not in ('P01', 'P02', 'P03', 'P04', 'P05', 'P06', 'P07', 'P08', 'P09', 'P10', 'P11', 'P12') then    raise_application_error( g_errN,  gl.aMfo||': Не вказано Рх' );  end if; 
    l_kf := sys_context('bars_context','user_mfo');
    logger.info(' DEL 1 p_px = ' || p_Px);
    For ZZ in (select * from PRVN_FV9 where dat01 = p_dat01 and kf = p_kf )
    loop  
          bc.go(zz.kf); 
          l_job_name :=  'FV9_'||ZZ.KF ; 
          begin SELECT 1 into l_Run FROM dba_scheduler_running_jobs  where job_name =  l_job_name ;
                raise_application_error( g_errN, gl.aMfo||':НЕ ЗАВЕРШЕНО  Процес '|| l_job_name|| ' обробки Вітрини з ID_CALC_SET = '|| ZZ.ID_CALC_SET );
          EXCEPTION WHEN NO_DATA_FOUND THEN null ;
          end;

          DAT31_ := DAT_NEXT_U ( zz.Dat01, -1) ;

/*
P1	Прийом~FV9~P1        |
P2	Проводки~SD*~P2      | Полный БЭК
P3	"Звіт~Del SD*~P3
P4	Допуст~Del SD*~P4
P5	Розрах~(351)~P5
P6	Розподіл~МСФЗ-9~P6
P7	Проводки~ARE~P7
P8	P8 
P9	P9

*/

          l_run := 0;
          If p_PX < 'P03' then -- 
             begin select fdat into FDAT_ from opldok p, oper o where o.ref= p.ref and o.tt='IRR' and o.vdat= DAT31_ and o.vob= 96 and o.sos=5 and p.fdat> DAT31_ and rownum= 1;
                   dbms_application_info.set_client_info(':'|| gl.aMfo ||':БЕК документів IRR');
                   FV9.BEK ( 'IRR', FDAT_, zz.KF )  ; commit ; ----  	:TT(SEM=Код_ОП: IRR або ARE,TYPE=С),:D(SEM=Банківська_дата,TYPE=D)
                   l_Run := 1;
             EXCEPTION WHEN NO_DATA_FOUND THEN Null ;
             end ;
          end if ;

          If p_PX < 'P10'  then 
             begin 
                if sys_context('bars_context','user_mfo')='300465' THEN
                   delete from nbu23_rez where fdat=p_dat01 and nbs in ('1415','3115') and tip='SR';
                end if; 
                begin
                   select fdat into FDAT_ from opldok p, oper o where o.ref= p.ref and o.tt='RXP' and o.vdat= DAT31_ and o.vob= 96 and o.sos=5 and p.fdat> DAT31_ and rownum= 1;
                   dbms_application_info.set_client_info(':'|| gl.aMfo ||':БЕК документів RXP');
                   FV9.BEK ( 'RXP', FDAT_, zz.KF )   ; 
                   l_Run := 1;
                EXCEPTION WHEN NO_DATA_FOUND THEN Null;
                end ;
                select fdat into FDAT_ from opldok p, oper o where o.ref= p.ref and o.tt='ARE' and o.vdat= DAT31_ and o.vob= 96 and o.sos=5 and p.fdat> DAT31_ and rownum= 1;
                dbms_application_info.set_client_info(':'|| gl.aMfo ||':БЕК документів ARE');
                FV9.BEK ( 'ARE', FDAT_, zz.KF )   ; 
                update rez_protocol set crc = null where dat = dat31_ and crc = 1; 
                commit ;  ----  	:TT(SEM=Код_ОП: IRR або ARE,TYPE=С),:D(SEM=Банківська_дата,TYPE=D)
                l_Run := 1;
             EXCEPTION WHEN NO_DATA_FOUND THEN Null;
             end ;
          end if  ;

          l_Upd   := ' update PRVN_FV9 set '||  
                       CASE WHEN p_PX <= 'P12'  THEN '  P12 =null '           else null end ||
                       CASE WHEN p_PX <= 'P11'  THEN ' ,P11 =null '           else null end ||
                       CASE WHEN p_PX <= 'P10'  THEN ' ,P10 =null '           else null end ||
                       CASE WHEN p_PX <= 'P09'  THEN ' ,P09 =null '           else null end ||
                       CASE WHEN p_PX <= 'P08'  THEN ' ,P08 =null '           else null end ||
                       CASE WHEN p_PX <= 'P07'  THEN ' ,P07 =null '           else null end ||
                       CASE WHEN p_PX <= 'P06'  THEN ' ,P06 =null '           else null end ||
                       CASE WHEN p_PX <= 'P05'  THEN ' ,P05 =null '           else null end ||
                       CASE WHEN p_PX <= 'P04'  THEN ' ,P04 =null '           else null end ||
                       CASE WHEN p_PX <= 'P03'  THEN ' ,P03 =null '           else null end ||
                       CASE WHEN p_PX <  'P03'  THEN ' ,P02 =null, p01=null ' else null end || 
                     ' where Dat01 = :Dat01 and KF =:KF ' ;
         logger.info(l_Upd );
         if l_run=1 THEN
            MDRAPS(DAT31_) ;  
         end if;
         EXECUTE IMMEDIATE l_Upd  using p_Dat01, p_KF ;
         commit ;
    end loop;
    bc.go(l_kf); 
    commit;

  end Del_ROW ;

 --------- предназначена для формирования SQL-строки паровозика НЕвфполненных процедур JOB, и его запуска
 procedure Start0  ( p_Dat01 date, p_KF varchar2 ) Is
   SQL_ varchar2 (3000) ;
   s_Dat01    varchar2(12) ;
   l_job_name varchar2(15) ;
   l_res_kf   varchar2(13) ;
   s_Dat31    varchar2(12) ;
   bc_        varchar2(25) ;
   log_ varchar2(150);

 begin log_    :='Begin bars_login.login_user(sys_guid(),'||gl.aUid||', null, null); gl.param; ' ;
       s_Dat01 := '''' || to_char (p_dat01, 'dd.mm.yyyy') || '''' ;
       s_Dat31 := '''' || to_char (p_dat01-1, 'dd.mm.yyyy') || '''' ;
logger.info('START_FV 1 p_kf =' || p_kf || ' dat01 = ' || p_dat01);
   for qq in ( select x.* from PRVN_FV9 x where x.dat01 = p_dat01 and x.kf = NVL( p_KF, x.KF) ) 
   loop  
logger.info('START_FV 2 p_kf =' || p_kf || ' dat01 = ' || p_dat01 || ' qq.kf = ' || qq.kf);
         bc_ := 'BC.GO('|| QQ.KF ||');';
       

         SQL_ := log_|| bc_ || 'logger.info(''START_FV 3'');' || 
              ' PUL_DAT(' || s_Dat01|| ',null); ' ;
         If qq.P01 is null then -- 1) Прийом та стиснення інформації від FINEVARE  
            SQL_ := SQL_ || 'PRVN_FLOW.div39(1,to_date('||s_Dat01||',''dd.mm.yyyy'')) ; '
                         || 'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  ''01'' ) ; '
                         || 'commit ; ' ;
         end if ;  -- 1) OSA: 

         If qq.P02 is null then  -- 2) IRR: Формування проводок  по SD*, SNA, SRR
            SQL_ := SQL_ || bc_|| 'IF sys_context(''bars_context'',''user_mfo'') = ''300465'' THEN
                                      MDRAPS(to_date('||s_Dat31||',''dd.mm.yyyy'')) ; 
                                   END IF;
                                   PRVN_FLOW.D_SNA(to_date('||s_Dat01||',''dd.mm.yyyy'')) ; ' || 
                                'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  ''02'' ) ; '||
                                'commit ; ' ;
         end if ;  

         If qq.P03 is null then  -- 3) Формування місячного знімку
            SQL_ := SQL_ || bc_|| 'MDRAPS(to_date('||s_Dat31||',''dd.mm.yyyy'')) ; ' || 
                            'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  ''03'' ) ; '||
                            'commit ; ' ;
         end if ;  

         If qq.P04 is null then   -- 4) Формування звіту по розбіжностям по SD*, SNA, SRR 
            SQL_ := SQL_ || bc_|| 'FV9.DEL_SDI(to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||'''); ' ||
                            'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  ''04'' ) ; '||
                            'commit ; ' ;
         end if ;  

         If qq.P05 is null then   -- 5) Перевірка допустимих розбіжностей по SD*, SNA, SRR 
            SQL_ := SQL_ || bc_|| 'FV9.MAX_SDI(to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||'''); ' ;
         end if ;  

         -------------------------------------------------------------------------------------------------------
         If qq.P06 is null then  --6) Розрахунок кредитного ризику (351)
            SQL_ := SQL_ || bc_|| 'CR(to_date('||s_Dat01 ||',''dd.mm.yyyy''));' ||              
                            'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  ''06'' ) ; '||
                            'commit ; ' ;
         end if ;  
         
         If qq.P07 is null then   -- 7) Розподіл МСФЗ-9
            
            SQL_ := SQL_ || bc_||'PRVN_FLOW.Div39(2,to_date('||s_Dat01||',''dd.mm.yyyy'')) ; ' || 
                           'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  ''07'' ) ; '||
                           'commit ; ';
         end if ;

         If qq.P08 is null then  --  8) Перевірка допустимих розбіжностей по REZ
            SQL_ := SQL_ || bc_||'fv9.MAX_REZ ( to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''' ) ; ' || 
                                 'commit ; ' ;         
         end if ;
           
         If qq.P09 is null then  --  9) ARE: Формування проводок по "МСФЗ-9"
            SQL_ := SQL_ || bc_||'PAY_23(to_date('||s_Dat01||',''dd.mm.yyyy''),0,NULL,0) ; ' || 
                                 'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  ''09'' ) ; '||
                           'commit ; ' ;         
         end if ;

         If qq.P10 is null then  -- 10) Формування місячного знімку
            SQL_ := SQL_ || bc_|| 'MDRAPS(to_date('||s_Dat31||',''dd.mm.yyyy'')) ; ' || 
                            'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''',  10 ) ; '||
                            'commit ; ' ;
         end if ;  
 
         If qq.P11 is null then  -- 11) Форм.звіту по розбіжн.прийнятого резерву та залишками на рахунках
            SQL_ := SQL_ || bc_|| 'FV9.DEL_REZ_OST ( to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''' )     ; ' || 
                                  'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''||QQ.KF||''', 11 ) ; ' ||
                                  'commit ; ' ;
         end if ;  

         If qq.P12 is null then  -- 12) Форм.звіту Договорf, по яким відсутня заборгованість та ризикові позабалансові зобов'язання, але сформовано SNA, дисконт/премію та уцінку/дооцінку
            SQL_ := SQL_ || bc_|| 'FV9.P_CLOSE_SDI ( to_date('||s_Dat01||',''dd.mm.yyyy''), '''|| QQ.KF ||''' )     ; ' || 
                                  'FV9.Set_OK (null, to_date('||s_Dat01||',''dd.mm.yyyy''), '''|| QQ.KF ||''', 12 ) ; ' ||
                                  'commit ; ' ;
         end if ;  

         SQL_ := SQL_ || ' bars_login.logout_user; End ; ' ;
         LOGGER.info  ( SQL_);

         l_job_name := 'FV9_'||QQ.KF ;

         begin  dbms_scheduler.drop_job(job_name => l_job_name );  -- удалить, если есть
         exception when others then  if sqlcode = -27475 then null; else raise; end if;
         end;    

         bars_login.set_long_session;

         --запуск JOB
         
         dbms_scheduler.create_job( job_name   => l_job_name,
                                    job_type   => 'PLSQL_BLOCK',
                                    job_action => SQL_ ,
                                    start_date => sysdate,-- перший запуск
                                    repeat_interval => null ,  -- НЕ повторять 
                                    enabled    => true,
           --repeat_interval => 'FREQ=MONTHLY;BYMONTHDAY=03;BYHOUR=13;BYMINUTE=30;BYSECOND=0',
                                    --auto_drop  => true,
                                    comments   => 'Обробка Вітрини FV9 для ' || QQ.KF || ' ' || QQ.Name_KF || ' '||  to_char(p_Dat01, 'dd.mm.yyyy') 
                                   );
         --dbms_scheduler.run_job (job_name => 'l_job_name');
        logger.info('START_FV 4  p_KF = ' || QQ.KF ); 
   end loop ;  -- QQ

 end Start0;

 --------- предназначена для -- 3) Формування звіту про розбіжностям по SD*, SNA, SRR
 procedure DEL_SDI ( p_Dat01 date, p_KF varchar2 ) is
 begin 
    dbms_application_info.set_client_info(':'|| gl.aMfo ||':4) Формування звіту по розбіжностям по SD*, SNA, SRR');
    z23.to_log_rez (user_id , 4 , p_dat01 ,'4) Формування звіту по розбіжностям по SD*, SNA, SRR');
    delete from PRVN_DEL1  where Dat01 = p_Dat01 and  KF = p_KF ;
       commit;

        Insert into PRVN_DEL1 ( Dat01, KF, tip,nd,vidd,kv,   b1,  SDF,  DEL_SDF ,   B3,  SDM,  DEL_SDM ,   B5,  SDI,  DEL_SDI ,   B7,  SDA,  DEL_SDA ,   A9,  SNA,  DEL_SNA ,   I9,  SRR,DEL_SRR,
q_SDF, q_SDM, q_SDI, q_SDA, q_SNA, q_SRR, ndg, nmk  ) 
          Select p_Dat01, p_KF, x.tip, x.nd, x.vidd, x.kv, x.B1,a.SDF,x.B1-a.SDF, x.B3,a.SDM,x.B3-a.SDM, x.B5,a.SDI,x.B5-a.SDI, x.B7,a.SDA,x.B7-a.SDA, x.A9,a.SNA,x.A9-a.SNA, x.I9,a.SRR,x.I9-a.SRR,
gl.p_icurval( x.kv , x.B1-a.SDF , p_Dat01 -1 ) ,
gl.p_icurval( x.kv , x.B3-a.SDM , p_Dat01 -1 ) ,
gl.p_icurval( x.kv , x.B5-a.SDI , p_Dat01 -1 ) ,
gl.p_icurval( x.kv , x.B7-a.SDA , p_Dat01 -1 ) ,
gl.p_icurval( x.kv , x.A9-a.SNA , p_Dat01 -1 ) ,
gl.p_icurval( x.kv , x.I9-a.SRR , p_Dat01 -1 ) , a.ndg, x.nmk
          From (select (select ndg from cc_deal where nd=nn.nd ) ndg, nn.ND, aa.KV,  
                        NVL(sum(decode(aa.tip,'SDF',aa.ostc,0)),0) SDF,   NVL(sum(decode(aa.tip,'SDM',aa.ostc,0)),0) SDM,   NVL(sum(decode(aa.tip,'SDI',aa.ostc,0)),0) SDI, 
                        NVL(sum(decode(aa.tip,'SDA',aa.ostc,0)),0) SDA,   NVL(sum(decode(aa.tip,'SNA',aa.ostc,0)),0) SNA,   NVL(sum(decode(aa.tip,'SRR',aa.ostc,0)),0) SRR
                from nd_acc nn, accounts aa 
                where aa.acc = nn.acc and aa.tip in ( 'SDF', 'SDM', 'SDI', 'SDA', 'SNA', 'SRR' ) and aa.kf = p_kf and aa.kf = nn.kf and nn.kf = p_kf 
                group by nn.ND, aa.KV
               ) A,
               (select q.kf, TIP, q.nd,vidd,KV,c.nmk, 
                       NVL(Round(b1*100,0),0) b1, NVL(Round(b3*100,0),0) B3, NVL(Round(b5*100,0),0) B5, NVL(Round(b7*100,0),0) B7, NVL(Round(AIRC_CCY*100,0),0) A9, NVL(Round(FV_CCY *100,0),0) I9
                from PRVN_Osaq  q, customer c where q.TIP = 3 and q.kf = p_kf and q.rnk=c.rnk 
               ) X
          WHERE x.ND = a.ND and x.kv = a.KV and ( x.B1 <> a.SDF  OR  x.B3 <> a.SDM  OR  x.B5 <> a.SDI  OR  x.B7 <> a.SDA  OR x.A9 <> a.SNA OR  x.I9 <> a.SRR  ) ;

      begin  EXECUTE IMMEDIATE ' begin FV9.Set_OK ( p_CALC_SET=> null, p_Dat01 => :Dat01,  p_KF => :KF, p_NPP => ''05'' ) ; end ; ' using p_Dat01 , p_KF ;
      exception when others then  null; 
      end;
      commit;
  end DEL_SDI;

 ----------- проверка не НЕПРЕВЫШЕНИЕ допустимого расходжения
 procedure MAX_SDI ( p_Dat01 date, p_KF varchar2 ) is
    xx PRVN_DEL_MAX%rowtype;
    dd PRVN_DEL1%rowtype;
 begin  
    dbms_application_info.set_client_info(':'|| gl.aMfo ||':Перевірка допустимих розбіжностей по SD*, SNA, SRR');
    z23.to_log_rez (user_id , 4 , p_dat01 ,'Перевірка допустимих розбіжностей по SD*, SNA, SRR');

    begin select * into xx from PRVN_DEL_MAX where kf = p_KF;
    EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error( g_errN,gl.aMfo||':Не знайдено обмежень для МФО='|| p_KF );
    end;

    begin select * into dd from PRVN_DEL1 where dat01= p_dat01 and kf = p_kf 
             AND ( abs(q_SDF) >  xx.DEL_SDF  OR  abs(q_SDM) >  xx.DEL_SDM  or   abs(q_SDI) >  xx.DEL_SDI  or
                   abs(q_SDA) >  xx.DEL_SDA  or  abs(q_SNA) >  xx.DEL_SNA  or   abs(q_SRR) >  xx.DEL_SRR  
                 ) 
             and rownum = 1 
             and sysdate > to_date ('01.02.2019', 'dd.mm.yyyy');           

          raise_application_error( g_errN,gl.aMfo||':Порушено обмеження '||
CASE WHEN abs(dd.q_SDF) > xx.DEL_SDF THEN 'SDF:' || abs(dd.q_SDF) ||'>'||  xx.DEL_SDF  
     WHEN abs(dd.q_SDM) > xx.DEL_SDM THEN 'SDM:' || abs(dd.q_SDM) ||'>'||  xx.DEL_SDM
     WHEN abs(dd.q_SDI) > xx.DEL_SDI THEN 'SDI:' || abs(dd.q_SDI) ||'>'||  xx.DEL_SDI
     WHEN abs(dd.q_SDA) > xx.DEL_SDA THEN 'SDA:' || abs(dd.q_SDA) ||'>'||  xx.DEL_SDA
     WHEN abs(dd.q_SNA) > xx.DEL_SNA THEN 'SNA:' || abs(dd.q_SNA) ||'>'||  xx.DEL_SNA
     WHEN abs(dd.q_SRR) > xx.DEL_SRR THEN 'SRR:' || abs(dd.q_SRR) ||'>'||  xx.DEL_SRR
     ELSE null 
END  || ' дог.ND='|| dd.ND|| ', kv='||dd.KV );
    EXCEPTION WHEN NO_DATA_FOUND THEN   
       FV9.Set_OK (null, p_dat01, p_KF,  '05' ) ; commit ; 
    end;

 end MAX_SDI;
 --------- предназначена для -- 11) Формування звіту про розбіжностям по резерву та залишками на рахунку

 procedure DEL_REZ_OST ( p_Dat01 date, p_KF varchar2 ) is
 begin 
    dbms_application_info.set_client_info(':'|| gl.aMfo ||':11) Форм.звіту по розбіжн.прийнятого резерву та залишками на рахунках');
    z23.to_log_rez (user_id , 4 , p_dat01 ,'11) Форм.звіту по розбіжн.прийнятого резерву та залишками на рахунках');
    delete from PRVN_DEL_REZ  where fdat = p_Dat01 and  KF = p_KF ;
    commit;
    Insert into PRVN_DEL_REZ ( fdat, kf, kv, rez, ost, del) 
                     select p_dat01, gl.aMfo, x.kv, x.rez, y.ost, x.rez-y.ost del 
                     from ( select kv kv,sum(rez) rez from nbu23_rez where fdat=p_dat01 
                            group by kv ) x,
                          (select kv kv_b,sum(ostc)/100 ost from accounts a where nbs||ob22 in (select nbs_rez||ob22_rez from srezerv_ob22)
                           group by kv) y
                     where x.kv = y.kv_b and x.rez <> y.ost;
     begin  EXECUTE IMMEDIATE ' begin FV9.Set_OK ( p_CALC_SET=> null, p_Dat01 => :Dat01,  p_KF => :KF, p_NPP => ''11'') ; end ; ' using p_Dat01 , p_KF ;
     exception when others then  null; 
     end;
     commit;
  end DEL_REZ_OST;
-------------------------
 procedure MAX_REZ ( p_Dat01 date, p_KF varchar2 ) is
    xx        PRVN_DEL_MAX%rowtype;
    dd        prvn_fv_abs%rowtype;
    l_rez     number;
    l_fv_abs  number;   
 begin  
    dbms_application_info.set_client_info(':'|| gl.aMfo ||':Перевірка допустимих розбіжностей по REZ');
    z23.to_log_rez (user_id , 4 , p_dat01 ,'Перевірка допустимих розбіжностей по REZ');
    begin select * into xx from PRVN_DEL_MAX where kf = p_KF;
    EXCEPTION WHEN NO_DATA_FOUND THEN  raise_application_error( g_errN,gl.aMfo||':Не знайдено обмежень для МФО='|| p_KF );
    end;

    begin select sum(rezb+rez9), sum(fv_abs) into l_rez, l_fv_abs  from PRVN_osaq where kf = p_KF;
    EXCEPTION WHEN NO_DATA_FOUND THEN l_rez := 0; l_fv_abs := 0;
    end;

    begin select *  into dd from prvn_fv_abs where ( fv_abs > xx.del_rez_sum or l_fv_abs*100/l_rez > xx.del_rez_prc)  and rownum = 1 ;           
          logger.info(' MAZ_REZ 1 l_fv_abs = ' || l_fv_abs || ' l_rez = ' || l_rez || ' l_fv_abs*100/l_rez = ' || l_fv_abs*100/l_rez || ' xx.del_rez_prc = ' || xx.del_rez_prc);
          raise_application_error( g_errN,gl.aMfo||':Порушено обмеження REZ '||
                CASE WHEN l_fv_abs*100/l_rez > xx.del_rez_prc THEN '(%),' 
                ELSE null 
                END  || ' дог.ND='|| dd.ND|| ', kv='||dd.KV );
    EXCEPTION WHEN NO_DATA_FOUND THEN   
       FV9.Set_OK (null, p_dat01, p_KF,  '08' ) ; commit ; 
    end;

 end MAX_REZ;
----------
 PROCEDURE p_close_sdi ( p_dat01 date, p_kf varchar2)  IS

begin
    dbms_application_info.set_client_info(':'|| gl.aMfo ||':12) Форм.звіту Договорa, по яким немає активів, але є дисконти');
    z23.to_log_rez (user_id , 4 , p_dat01 ,'12) Форм.звіту Договорa, по яким немає активів, але є дисконти');
   delete from REZ_CLOSE_SDI where kf = p_kf;
   for k in (select a.kf, d.sos, d.nd, a.acc, a.nls, a.kv, a.tip, a.ostc, a.dazs  from cc_deal d, nd_acc n,accounts a 
              where d.nd in (select nd from (select d.nd, sum(ostc) s from cc_deal  d, nd_acc n,accounts a 
                                             where d.nd in (select distinct d.nd from cc_deal d, nd_acc n,accounts a 
                                                            where d.nd=n.nd and n.acc=a.acc and tip in ('SNA','SDF','SDA','SDI','SDM') and ostc<>0) 
                                                   and  d.nd=n.nd and n.acc=a.acc and tip in ('SS ','SP ','SN','SNO','SPN')  
                                             group by d.nd  )
                             where s=0)
                    and d.nd=n.nd and n.acc= a.acc and substr(nls,1,1) not in ('6','8') and tip not in ('DEP','SG ','ZAL')           
              order by nd  )
   LOOP
      insert into REZ_CLOSE_SDI (fdat, kf, sos, nd, acc, nls, kv, tip, ostc, dazs) 
                         values (sysdate, k.kf, k.sos, k.nd, k.acc, k.nls, k.kv, k.tip, k.ostc, k.dazs);
   end loop;
end p_close_sdi;
 --------- предназначена для простановки положительной отметки на одну из процедур с № p_NPP из списка JOB
 procedure Set_OK      ( p_CALC_SET number, p_Dat01 date, p_KF varchar2, p_NPP varchar2 ) Is
 begin  

     If p_CALC_SET is not null then   EXECUTE IMMEDIATE ' update PRVN_FV9 set P'  || p_NPP || ' = 1 where id_CALC_SET =' || p_CALC_SET ;
     Else                             EXECUTE IMMEDIATE ' update PRVN_FV9 set P'  || p_NPP || ' = 1 where Dat01 = :Dat01 and KF =:KF ' using p_Dat01, p_KF ;
     end if ;

 end Set_OK; 
-------------------------
 function Get_Job   ( p_Name varchar2, p_mode int, p_dat01 date, p_kf varchar2) return varchar2 is 
   l_Ret varchar2 (2000);
   l_log_ID int;
 begin 
   If p_mode = 0 then  
      select max(Log_Id) into l_Log_Id from ALL_SCHEDULER_JOB_RUN_DETAILS where job_name = p_Name ;
      if l_Log_Id  is not null then
         select Substr (STATUS || ' '|| to_char(Log_date, 'dd.mm.yy HH24:mi:ss') || ' '|| ADDITIONAL_INFO ,1,2000)
         into l_Ret 
         from ALL_SCHEDULER_JOB_RUN_DETAILS 
         where job_name = p_Name and Log_id = l_Log_Id ;
      end if ;
   else

      Begin select decode(substr(p_name,1,3),'BEK','Yes_BEK','Yes') into l_Ret  from dba_scheduler_running_jobs where job_name = p_Name ;
      EXCEPTION WHEN NO_DATA_FOUND THEN  l_Ret := 'No'; 
      end ;
   
   end if ;
   if l_ret not in ('Yes_BEK','Yes') and fv9.Get_Run ( p_Dat01, p_KF ) = 1 THEN l_ret := 'Ok!';  end if;
   RETURN l_Ret ;
 End Get_Job ;
 -------------------------------------------------------------
 function  Get_Run     ( p_Dat01 date, p_KF varchar2) return integer is
  l_run integer := 0; 
 begin
    begin 
       select p01+p02+p03+p04+p05+p06+p07+p08+p09+p10+p11+p12 into l_run from prvn_fv9 where dat01 = p_Dat01 and  kf = p_kf;
    EXCEPTION WHEN NO_DATA_FOUND THEN  l_Run := 0; 
    end;
    if l_run = 12 Then l_run := 1; end if;
    return l_run; 
 end;

 -------------------------------------------------------------
 procedure BEK   ( p_TT varchar2, p_DAT date, p_KF varchar2 ) is -- откат операций 
 begin    BC.go  ( p_KF ) ;
   for z in (select distinct ref  from opldok where fdat = p_DAT and tt = p_TT and sos = 5 )
   loop ful_bak( z.REF); end loop ;
   commit; 
 end BEK;
 
 procedure REPAY ( p_TT varchar2, p_DAT_BAK date, p_DAT_PAY date, p_KF varchar2 ) IS  --  Переплата в другом дне 
 begin     BC.go ( p_KF ) ;
   for oo in (select * from oper where ref in ( select distinct ref  from opldok where  tt = p_TT  and fdat =  p_DAT_BAK ) )
   loop gl.bdate := p_DAT_BAK ; 
        ful_bak( oo.REF) ;
        update oper set sos = 1 where ref = oo.ref ;
       
        gl.bdate := p_DAT_PAY ; 
        gl.payv (flg_ => 0, 
                ref_  => oo.REF, 
                dat_  => oo.vdat,
                 tt_  => oo.TT,
                 dk_  => oo.dk, 
                kv1_  => oo.kv,
               nls1_  => oo.nlsa, 
               sum1_  => oo.S,
                kv2_  => oo.kv2,
               nls2_  => oo.nlsb, 
               sum2_  => oo.S2
                ) ;
        gl.pay (2,  oo.REF, gl.bdate) ;
   end loop; -- oo
   Commit;
 end  REPAY ;
 ----------------------------------------------------

BEGIN null ;
end FV9 ;
/
show errors;

grant execute on FV9  to BARS_ACCESS_DEFROLE;
grant execute on FV9  to RCC_DEAL;
grant execute on FV9  to START1;
                 