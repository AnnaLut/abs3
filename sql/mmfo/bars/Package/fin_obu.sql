
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/fin_obu.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FIN_OBU IS
   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 1.2.4  03.03.2016';


  aOKPO_      int;      -- активный код ОКПО
  aND_        int;      -- активный код ND
  aRNK_       int;      -- активный код RNK
  aDAT_       date;     -- активна дата 
  aDATZ_      date;     -- дата формування розрахунку для звіту
  g_period number; --період 3-кварт, 6- піврічн, 12 річний
  g_kol_dely  int; -- кылькысть дныв прострочки

  ern CONSTANT POSITIVE   := 208; 
  err EXCEPTION; 
  erm VARCHAR2(80);

	--КЫЛЬКЫСТЬ ДНЫВ ПРОСТРОЧКИ
   PROCEDURE days_of_delay (P_ND CC_DEAL.ND%TYPE, DAT_ DATE default GL.BDATE);
   
   FUNCTION ZN_rep (KOD_   char,
                 IDF_   int default 1,
                 DAT_   date default aDAT_,
                 OKPO_  int default aOKPO_
                 ) RETURN  number; 
				 
				 
    FUNCTION GET_VNKR (   DAT_   date default aDAT_,
				          RNK_  int default aRNK_,
						  ND_   int default aND_)
						   RETURN varchar2;

  
    FUNCTION CALC_SCOR_BAL (KOD_   char, 
                          IDF_   int default 1,
				          DAT_   date default aDAT_,
				          RNK_  int default aRNK_,
						  ND_   int default aND_
                 ) RETURN  number;

				 
	FUNCTION MIN_MAX_SCOR ( ID_   int,
                           KOD_  char, 
                           ZN_   char 
                          )
						  RETURN number;
						  
	PROCEDURE calc_points(    ND_   IN  number default aND_,
							  RNK_  IN  number default aRNK_, 
							  DAT_  IN  date default aDAT_);
							  
							  
    FUNCTION SUM_LIM_ND (ND_    int,
     					 RNK_   int,
						 DAT_   date 
						 ) RETURN  number ;						  
---------------------------------------------------------------				 
--
-- Вичитуємо значення показника
--				 
---------------------------------------------------------------				  
  FUNCTION ZN_P (KOD_   char, 
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default  aOKPO_ 
			   ) RETURN  number; 	   

  FUNCTION ZN_P_ND (KOD_   char, 
                    IDF_   int default 1,
				    DAT_   date default aDAT_,
				    ND_    int default  aND_,
                    RNK_   int default aRNK_					
			        ) RETURN  number; 

 FUNCTION ZN_P_ND_REPL (KOD_   char, 
                    IDF_   int default 1,
				    DAT_   date default aDAT_,
				    ND_    int default  aND_,
                    RNK_   int default aRNK_					
			        ) RETURN  fin_question_reply.name%type; 
					
  FUNCTION ZN_P_ND_date (KOD_   char, 
						 IDF_   int default 1,
						 DAT_   date default aDAT_,
						 ND_    int default aND_,
						 RNK_   int default aRNK_
						 ) RETURN  date;
					
  FUNCTION F_GET_FIN_ND (
                             rnk_ int,
                             nd_ int  default 0,
                             kod_ varchar2,
							 idf_ number,
                             dat_p date,                         
                             dat_ date default sysdate
                            )   return number;
							
	PROCEDURE record_fp_ND(KOD_   IN  char, 
                         S_    IN  number,  
                         IDF_  IN  int,
				         DAT_  IN  date default aDAT_,
				         ND_   IN  int default aND_,
                         RNK_  IN  int default aRNK_ );
		
    PROCEDURE record_fp_ND_date(KOD_   IN  char, 
    							 val_date_    IN  date,  
								 IDF_  IN  int,
								 DAT_  IN  date default aDAT_,
								 ND_   IN  int default aND_,
								 RNK_  IN  int default aRNK_ );		
								 
								 
	FUNCTION   CALC_POK_DOP (kod_ IN  char,
                       dat_ IN  date default aDAT_,   
                       okpo_ IN  int default aOKPO_
					   )
	return number;
						 
    FUNCTION   CALC_POK (kod_ IN  char,
                       dat_ IN  date default aDAT_,   
                       okpo_ IN  int default aOKPO_,
					   rnk_  in  int default aRNK_,
					   nd_   in  int default aND_
					   )
	return number;
  
  
    PROCEDURE GET_POK (RNK_ number,
                        ND_  number,
					    DAT_ date);
							 
							 
							 
    FUNCTION GET_Summ_SK (    
						p_sum number ,
						p_pr    number,
						date_v date,
						date_z date,
                        graf number default 0
                                        )
						                     RETURN number;
  PROCEDURE GET_SUBPOK (RNK_ number,
                        ND_ number,
	            		DAT_ in date);

						
----------------------------------
--- збереження дат розрахунків
----------------------------------						
PROCEDURE GET_calc_print (RNK_ number,
                          ND_ number,
					      DAT_ in date,
						  Tip_v_ number,
						  VNKR_ varchar2);
						  
						
    FUNCTION p_zvt ( RNK_ NUMBER, 
	   			     DAT_  date 
				    )
	RETURN number;
				

				
   PROCEDURE init1(OKPO_ NUMBER, 
                   DAT_  date);						
------
--
------
    procedure p_init (
              RNK_  number,
              ND_   number,
              DAT_  date,
              FDAT_ date);  
    
	procedure p_reset;			  
				  
-----
--- Дата розрахунку для звіту
-----
FUNCTION F_GET_FIN_HIST_datd 
  return  date;
   
-------
--  для звітів  /можливо і непотрібний/
-------
 FUNCTION F_GET_FIN_HIST_ND (
                             rnk_ int,
                             nd_ int  default 0,
                             kod_ varchar2,
							 IDF_ number,
                             dat_p date,
                             dat_ date default aDATZ_
                            )
  return number;
  
  
  
	function header_version return varchar2;

    function body_version   return varchar2;
  
END fin_OBU;
/
CREATE OR REPLACE PACKAGE BODY BARS.FIN_OBU IS

 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 1.2.4  03.03.2016';
 --g_period number; --період 3-кварт, 6- піврічн, 12 річний

--------------------------------------------
 /*
   ver 1.2.4  03.03.2016   COBUSUPABS-4025
     (+фактори проблемності та потенційної проблемності
 */
-------------------------------------------------
----- Для звіту пошук значень для форм в звязку з перекодуванням
-------------------------------------------------
 FUNCTION ZN_rep (KOD_   char,
                 IDF_   int default 1,
                 DAT_   date default aDAT_,
                 OKPO_  int default aOKPO_
                 ) RETURN  number is
 sTmp_ number := 0 ;
 l_sql varchar2(4000) ;
 l_sql2 varchar2(4000) ;
 FM_ fin_fm.fm%type;

 BEGIN

 --   DEB.TRACE(1, KOD_||'-'||'Start',1);

    BEGIN
            select nvl(ss,s)
              into sTmp_
              from fin_rnk
             where okpo = OKPO_
               and fdat = DAT_
               and kod  = KOD_
               and idf  = IDF_;
 --   DEB.TRACE(1, KOD_||'-'||sTmp_||' Return',1);
           RETURN sTmp_;
           
                  exception when NO_DATA_FOUND
                         THEN   null;
    END;






 begin
 select kod_old
  into  l_sql
  from (
         select kod_old from fin_forma1 where kod = KOD_ and 1 = IDF_ and fm = 'N'
         union all
         select kod_old from fin_forma2 where kod = KOD_ and 2 = IDF_ and fm = 'N'
        );
  exception when NO_DATA_FOUND
    then l_sql := 0;
   end;

 --  DEB.TRACE(1, KOD_||'-'||DAT_||'-kod_old-'||l_sql||'='||FIN_NBU.F_FM(OKPO_, DAT_)||'*'||OKPO_,1);
   FM_ := FIN_NBU.F_FM(OKPO_, DAT_);
 
 l_sql :=  nvl(replace(replace(l_sql, '#(','fin_nbu.ZN_sql_p('''),')',''',IDF_, DAT_, OKPO_)'),0);
 l_sql2 := 'Select '||l_sql||' from (select :IDF_ as idf_, :DAT_ as dat_, :OKPO_ as okpo_, :FM_ as FM from dual)';


         begin
          execute immediate l_sql2 into sTmp_ using IDF_, DAT_, OKPO_, FM_;
          exception when NO_DATA_FOUND
                 THEN sTmp_ :=0;
         end;

    return sTmp_;



end ZN_rep;



  FUNCTION GET_VNKR (     DAT_   date default aDAT_,
				          RNK_  int default aRNK_,
						  ND_   int default aND_)
						   RETURN varchar2 IS
	bal_ number;
	ord_ number;
    sTmp_ varchar2(3);
	p_etap_i number :=0;
	zvb_  number :=fin_obu.F_GET_FIN_ND(rnk_, nd_, 'ZVB', 32, dat_);
	zcd_  number :=fin_obu.F_GET_FIN_ND(rnk_, nd_, 'ZCD', 32, dat_);
	kp4_  number :=fin_obu.F_GET_FIN_ND(rnk_, nd_, 'KP4', 5, dat_); -- Проти боржника – юридичної особи порушено справу про банкрутство 1-yes, 2- no
	kp5_  number :=fin_obu.F_GET_FIN_ND(rnk_, nd_, 'KP5', 5, dat_); --Боржника визнано банкрутом у встановленому законодавством України порядку 1-yes, 2- no
    kp3_  number :=fin_obu.F_GET_FIN_ND(rnk_, nd_, 'KP3', 5, dat_); --Фінансової звітності боржника – за останній звітний період 1-yes, 2- no


	BEGIN

	bal_ := round(fin_obu.F_GET_FIN_ND(rnk_, nd_, 'BAL', 35, dat_));



	if (fin_obu.F_GET_FIN_ND(rnk_, nd_, 'INV', 32, dat_) = 2 and fin_obu.F_GET_FIN_ND(rnk_, nd_, 'ETP', 32, dat_) = 1) then
	p_etap_i:= 1;
			Begin
				select CODE, ord
				  into sTmp_, ord_
				  from CCK_RATING
				 where  I_min<= bal_ and bal_<=I_max;
			exception when NO_DATA_FOUND
					 THEN return null;
			End;
	
	else
	p_etap_i:= 0;
			Begin
				select CODE, ord
				  into sTmp_, ord_
				  from CCK_RATING
				 where  min<= bal_ and bal_<=max;
			exception when NO_DATA_FOUND
					 THEN return null;
			End;
	
	end if;

		/*
1.4.	У разі якщо значення показника «Коефіцієнт співвідношення суми заборгованості (наданих зобов’язань) за основною сумою боргу перед Банком та валюти балансу» (ЗВб)
                                     і «Коефіцієнт співвідношення суми чистого доходу та суми зобов’язань за основною сумою боргу перед Банком» (ЗЧд)
	  складають більше 80% та менше – 1,2 відповідно, то VNCRR не може бути вище «ВВВ».

1.5.	У разі якщо значення показника «Коефіцієнт співвідношення суми заборгованості (наданих зобов’язань) за основною сумою боргу перед Банком та валюти балансу» (ЗВб)
                                     і «Коефіцієнт співвідношення суми чистого доходу та суми зобов’язань за основною сумою боргу перед Банком» (ЗЧд),
   	 складають більше 100% і менше 1,0 відповідно, то VNCRR не може бути вище «ГГГ».
1.6.	У разі якщо проти Контрагента порушено справу про банкрутство, то його VNCRR не може бути визначений вище «ГГГ».
1.7.	У разі якщо боржника визнано банкрутом у встановленому законодавством України порядку, то його VNCRR не може бути визначений вище «Г».

2014-08-01
3.10.	Визначення ВКР за кредитними операціями, які пов’язані із фінансуванням інвестиційних проектів контрагентів Банку, здійснюється відповідно до вимог цієї Методики з визначенням ВКР за шкалою, що наведена у Додатку 6.
При визначенні ВКР контрагентів Банку за кредитними операціями, які пов’язані із фінансуванням інвестиційних проектів на «Етапі інвестування», показники ЗВб та ЗЧд не використовуються. 
(в редакції постанови правління АТ «Ощадбанк» №266 від 16.05.2013 р.)


		*/


	if 	(zvb_ > 0.80 and  zcd_ < 1.2 and p_etap_i = 0)  then ord_ := GREATEST(21,ord_);
	end if;

	if 	(zvb_ > 1.00 and  zcd_ < 1.0 and p_etap_i = 0)  then ord_ := GREATEST(31,ord_);
	end if;

	if 	kp4_ = 1  then ord_ := GREATEST(31,ord_);
	end if;

	if 	kp5_ = 1  then ord_ := GREATEST(33,ord_);
	end if;
	
	if 	kp3_ = 2  then ord_ := GREATEST(33,ord_);
	end if;
	

	Begin
		select CODE
		  into sTmp_
		  from CCK_RATING
		 where  ord = ord_;
	exception when NO_DATA_FOUND
	         THEN return null;
	End;


	return sTmp_;
	END GET_VNKR;



  FUNCTION CALC_SCOR_BAL (KOD_   char,
                          IDF_   int default 1,
				          DAT_   date default aDAT_,
				          RNK_  int default aRNK_,
						  ND_   int default aND_
                 ) RETURN  number IS

 sTmp_ number := null ;
 id_ number ;
   l_val number;

      l_mins FIN_OBU_SIGN_TYPES.sign%type;
      l_maxs FIN_OBU_SIGN_TYPES.sign%type;

      l_sql varchar2(4000);

BEGIN


l_val :=F_GET_FIN_ND(RNK_, ND_,  KOD_, IDF_,  DAT_);
  id_ :=F_GET_FIN_ND(RNK_, ND_, 'TIP',   32,  DAT_);
 -- id_ := ZN_P_ND('TIP', 32, DAT_, ND_, RNK_);

for c in (select *
                  from FIN_OBU_SCORING t
                 where t.id = id_
                   and t.kod = kod_
                   order by t.ord) loop
        -- знаки
        select s.sign
          into l_mins
          from FIN_OBU_SIGN_TYPES s
         where s.id = c.min_sign;
        select s.sign
          into l_maxs
          from FIN_OBU_SIGN_TYPES s
         where s.id = c.max_sign;

        -- выражение проверки
		/*
        l_sql := 'select 1 from dual where ';

        l_sql := l_sql || ' '|| to_char(c.min_val,'99999999999990D99') || ' ' || l_mins || ' ' ||to_char(l_val,'999999999999990D99');
        l_sql := l_sql || ' and ' || to_char(l_val,'99999999999990D99') || ' ' || l_maxs || ' ' ||to_char(c.max_val,'999999999999990D99')||'';
        sql_stmt := 'SELECT * FROM emp WHERE empno = :id';
   EXECUTE IMMEDIATE sql_stmt INTO emp_rec USING emp_id;
        */

   
        l_sql := 'select 1 from dual where :min_val '|| l_mins || ':l_val and :l_val '||l_maxs ||' :max_val';
      


        --  logger.info (l_sql); --select 1 from dual where               1.00 <= '-7,17' and '-7,17' <               2.50

		 begin
--		 execute immediate l_sql into sTmp_;
          execute immediate l_sql into sTmp_ using c.min_val, l_val, l_val, c.max_val; 
		  exception when NO_DATA_FOUND
		         THEN null;
				 end;

     if sTmp_ = 1  and (kod_ = 'MZ0' and F_GET_FIN_ND(rnk_, nd_, 'MZ0', 30, dat_)  = 8  ) then return F_GET_FIN_ND(rnk_, nd_, 'MZ1', 30, dat_);
	 elsif sTmp_ = 1  then
	 return c.SCORE;
      	 end if;

	END LOOP;

    return null;

end CALC_SCOR_BAL;

   FUNCTION MIN_MAX_SCOR ( ID_   int,
                           KOD_  char,
                           ZN_   char
                          )
						  RETURN number is
	max_    number;
	min_    number;
    BEGIN

	Begin
				select max(min_val), min(max_val)
				  into   max_,         min_
				  from FIN_OBU_SCORING
				 where  kod = KOD_ and
						id = ID_
			  group by kod;
		exception when NO_DATA_FOUND
					 THEN
						raise_application_error(-(20000),'/' ||'     '||KOD_||'Відсутня скорингова картка для - '||ID_,TRUE);
						  return null;
	end;

	   if ZN_ = 'MAX' then return max_;
	elsif ZN_ = 'MIN' then return min_;
	else  raise_application_error(-(20000),'/' ||'     '||KOD_||' Not correctly specified ZN_ - '||ZN_,TRUE);
	end if;

	END MIN_MAX_SCOR;

	
	--КЫЛЬКЫСТЬ ДНЫВ ПРОСТРОЧКИ
PROCEDURE days_of_delay (P_ND CC_DEAL.ND%TYPE, DAT_ DATE default GL.BDATE)
AS
  --DAT_ DATE := GL.BDATE;

  SP_ number; SL_ number; SPN_ number;SK9_ number;
  KOL_ int  ;  FDAT_ date := DAT_;
  SUM_KOS number;

BEGIN  

 for k in (select d.nd, d.vidd, nvl(d.OBS,0) OBS,d.sdate,d.rnk,d.wdate
                   /*,
                   (select sum(1) from nd_acc n,accounts a
                           where a.tip in ('SP ','SPN','SK9','SL ')
                           and a.dazs is null and a.acc=n.acc and n.nd=D.ND
                   ) SP_ON,
                   ( select max(3) from nd_acc nn , specparam p, accounts a
                      where nn.acc=a.acc and nn.acc=p.acc and nn.nd=d.nd and a.tip in ('SP ','SPN')
                            and (p.s270='08' or p.r013='2') and a.ostc<0 and dat_= gl.bdate
                   ) OBS3*/
            from cc_deal d
            where d.sos >=10 and d.sos<14
              AND ND = P_ND
          )
  LOOP
  
   KOL_:=0;
   
      select 
             Nvl(sum(decode (a.tip,'SP ',gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_),0)),0),
             Nvl(sum(decode (a.tip,'SPN',gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_),0)),0),
             Nvl(sum(decode (a.tip,'SK9 ',gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_),0)),0),
             Nvl(sum(decode (a.tip,'SL ',gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_),0)),0)
      into  SP_,SPN_,SK9_,SL_
      from  saldoa s, accounts a, nd_acc n
      where a.acc=s.acc and a.acc=n.acc and n.nd=K.ND and a.acc=s.acc
        and a.tip in ('SP ','SPN','SK9','SL ')
        and (s.acc,s.fdat)=(select acc,max(fdat) from saldoa
                            where acc=s.acc and fdat<=DAT_ group by acc);

      if SL_=0 or SL_ is null then
            -- УЗНАЕМ НА СКОЛЬКО ДНЕЙ ПРОСРОЧЕНО ТЕЛО КРЕДИТА
        for sp in ( select 'SP ' tip from dual where SP_<>0  union all
                    select 'SPN' tip from dual where SPN_<>0 union all
                    select 'SK9' tip from dual where SK9_<>0
                  )
        loop
        
         FDAT_:= DAT_;
        -- узнаем сумму всех кредитовых оборотов
        select sum(gl.p_icurval(a.kv,(s.kos),dat_))
               into SUM_KOS
                   from saldoa s, accounts a, nd_acc n
                   where a.acc=s.acc and a.acc=n.acc and n.nd=k.ND
                     and a.tip=sp.TIP
                     and s.FDAT<=DAT_ and s.fdat>=k.sdate;


         for p in (select s.fdat,sum(gl.p_icurval(a.kv,(
                                                         (case when fdat=(select min(fdat) from saldoa ss where acc=a.acc) then greatest(-s.ostf,s.dos) else s.dos end)
                                                        ),dat_)) DOS
                   from saldoa s, accounts a, nd_acc n
                   where a.acc=s.acc and a.acc=n.acc and n.nd=k.ND
                     and a.tip=sp.TIP
                     and s.FDAT<DAT_ and s.fdat>=k.sdate
                   group by s.fdat
                   order by s.fdat
                   )
         loop
            SUM_KOS:= SUM_KOS - p.DOS;
            -- -10  для устранения погрешности возник из за использования нац валюты
            If SUM_KOS < -10 then
               KOL_ := greatest(DAT_- p.FDAT,KOL_) ;
               EXIT;
            end if;
         end loop;
         
         END LOOP;
       END IF;
  END LOOP;       
  
  g_kol_dely := KOL_;
 
END; 	

   PROCEDURE calc_points(    ND_   IN  number default aND_,
							 RNK_  IN  number default aRNK_,
							 DAT_  IN  date default aDAT_)
		IS
    s_bal_ number :=0;
	s_b30_ number :=0;
	s_b70_ number :=0;

	l_col number;
	l_tip varchar2(3);
	
	vncrr_ varchar2(3);
	Err_Code number;
	Err_Messag varchar2(4000);
	Begin
             --logger.info('FIN_OBU   calc_points    dat_'||DAT_||' RNK_'||RNK_||' ND_'||ND_);
	FOR k IN(
	  SELECT kod, name, CALC_SCOR_BAL(kod, idf, dat_, rnk_, nd_) as bal
    FROM FIN_QUESTION
   WHERE idf IN (31, 33)
             )
	LOOP
           --  logger.info('FIN_OBU    calc_points   '|| k.kod)  ;

														if k.bal is not null
														then
															record_fp_ND(    KOD_ => k.KOD,
																			 S_   => k.bal,
																			 IDF_ => 34,
																			 DAT_ => DAT_,
																			 ND_  => ND_,
																			 RNK_ => RNK_);
														--logger.trace('FIN_OBU   calc_points2    dat_'||DAT_||' RNK_'||RNK_||' ND_'||ND_||' bal|'||k.bal||'|');
														end if;
	s_bal_  := s_bal_  + nvl(k.bal,  0);
	if k.kod in ( 'KOB', 'KPF','KPZ','VK0','TDP','KZV','KDP','KA0','G00','HP0','DP0','PKR','SD0','MZ0','SZP','AP0')
	   then s_b30_  := s_b30_  + nvl(k.bal,  0);
	   else s_b70_  := s_b70_  + nvl(k.bal,  0);
	end if;

    END LOOP;
 
         --logger.info('FIN_OBU    calc_points   end loop')      ;         

						record_fp_ND(KOD_ => 'SBO',
									 S_   => (s_bal_+fin_obu.F_GET_FIN_ND(rnk_, nd_, 'YZK', 35, dat_)),
									 IDF_ => 35,
									 DAT_ => DAT_,
									 ND_  => ND_,
									 RNK_ => RNK_);


						record_fp_ND(KOD_ => 'ZKR',
									 S_   => ((1100 - (s_bal_+fin_obu.F_GET_FIN_ND(rnk_, nd_, 'YZK', 35, dat_)))/1100),
									 IDF_ => 35,
									 DAT_ => DAT_,
									 ND_  => ND_,
									 RNK_ => RNK_);

    if (s_b30_/s_bal_) >= 0.3 then
	s_bal_ := (s_b70_*100/70);
	end if;



					    record_fp_ND(KOD_ => 'BAL',
									 S_   => s_bal_,
									 IDF_ => 35,
									 DAT_ => DAT_,
									 ND_  => ND_,
									 RNK_ => RNK_);


		vncrr_ := GET_VNKR(DAT_, RNK_,  ND_);
    if nd_ > 0 then
	

	  Begin
	  select tip
	  into l_tip
	  from v_fin_cc_deal
	  where nd = nd_ and rnk = rnk_;
	  exception when NO_DATA_FOUND
		         THEN l_tip := null;
		--raise_application_error(-(20000),'/' ||'     '||ND_||'Не знайдено КД ',TRUE);
    END;
	 
	 
	 if l_tip in ('CCK', 'GAR', 'OVR') then
	  cck_app.Set_ND_TXT( ND_, 'VNCRR', vncrr_);
	  else null;
	 end if;  
	

		
		if rnk_ > 0 then
		   update customerw set value = vncrr_, isp = 0 where rnk=rnk_ and tag='VNCRR' returning count(rnk) into l_col;
			if l_col=0 then
			   insert into customerw (rnk, tag, value, isp) values (rnk_, 'VNCRR', vncrr_, 0);
			end if;

	   else null;
	   end if;

	


 	--Розрахунок Факторів потенційної проблемності
	--розрахуємо кількість днів прострочки
	days_of_delay(nd_);
   --  Зниження виручки більше ніж на 50%
	record_fp_ND(KOD_ => 'FP1',
	             S_   => CALC_POK ('FP1', dat_),
                 IDF_ => 32,
				 DAT_ => DAT_,
				 ND_  => ND_,
                 RNK_ => RNK_);
 --  Зниження показників чистих активів
	record_fp_ND(KOD_ => 'FP2',
	             S_   => CALC_POK ('FP2', dat_),
                 IDF_ => 32,
				 DAT_ => DAT_,
				 ND_  => ND_,
                 RNK_ => RNK_);
  -- зниження внутрішнього кредитного рейтингу
	record_fp_ND(KOD_ => 'FP3',
	             S_   => CALC_POK ('FP3', dat_),
                 IDF_ => 32,
				 DAT_ => DAT_,
				 ND_  => ND_,
                 RNK_ => RNK_);
  -- падіння внутрішнього кредитного рейтингу
	record_fp_ND(KOD_ => 'FP4',
	             S_   => CALC_POK ('FP4', dat_),
                 IDF_ => 32,
				 DAT_ => DAT_,
				 ND_  => ND_,
                 RNK_ => RNK_);	
				 
	record_fp_ND(KOD_ => 'FP5',
	             S_   => CALC_POK ('FP5', dat_),
                 IDF_ => 32,
				 DAT_ => DAT_,
				 ND_  => ND_,
                 RNK_ => RNK_);		
	else null;
	end if;


    BEGIN
    select okpo
	  into aOKPO_
	  from fin_customer
	 where rnk = RNK_;
          exception when NO_DATA_FOUND
		         THEN --sTmp_ := 0;
		raise_application_error(-(20000),'/' ||'     '||RNK_||'Не значдено РНК ',TRUE);
    END;


      fin_nbu.get_class(ND_ , aOKPO_,  DAT_ , RNK_);
      fin_ZP.get_zprk(RNK_,   ND_, DAT_ , vncrr_,  Err_Code, Err_Messag);



	end ;

	
	  FUNCTION SUM_LIM_ND (  ND_    int,
    						 RNK_   int,
							 DAT_   date 
							 ) RETURN  number IS

			 sTmp_ number := 0 ;
			 datz date;

			BEGIN

			
/* 			BEGIN
			select nvl(max(trunc(chgdate)),DAT_) as date_f  
			into datz
			from fin_nd_update 
			where nd = ND_ and idf = 32 and rnk = RNK_ and fdat = DAT_;
			END; */
			
			datz := gl.bd;
			
				BEGIN

			  select abs(sum(s.OSTf - s.DOS + s.KOS)) as limit
				into sTmp_
				from nd_acc n, 
				     accounts a, 
					 saldoa s
				where n.acc = a.acc 
				  and a.acc = s.acc
				  and tip in ('LIM', 'CR9')
				  AND (a.acc, s.fdat) = (  SELECT c.acc, MAX (c.fdat)
												 FROM saldoa c
												WHERE a.acc = c.acc AND c.fdat <= datz
											 GROUP BY c.acc)
				 and n.nd = ND_;
				exception when NO_DATA_FOUND
							 THEN sTmp_ := 0;
							
				END;
				
				if sTmp_ is null then 
				
				 begin
				      select limit *100
					  into sTmp_ 
					  from cc_deal 
					  where nd = ND_;
				 exception when NO_DATA_FOUND
							 THEN sTmp_ := 0;
				 end;
				else 
				null;
				end if;
				
				
				
			  RETURN sTmp_;

end SUM_LIM_ND;




  FUNCTION ZN_P (KOD_   char,
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 OKPO_  int default aOKPO_
                 ) RETURN  number IS

 sTmp_ number := 0 ;

BEGIN

    BEGIN
    select nvl(ss,s)
	  into sTmp_
	  from fin_rnk
	 where okpo = OKPO_
       and fdat = DAT_
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND
		         THEN sTmp_ := 0;
		--raise_application_error(-(20000),'\' ||'     '||KOD_||'Відсутні дані за звітний період - '||DAT_,TRUE);
    END;
  RETURN sTmp_;

end ZN_P;

  FUNCTION ZN_P_ND (KOD_   char,
                 IDF_   int default 1,
				 DAT_   date default aDAT_,
				 ND_    int default aND_,
				 RNK_   int default aRNK_
                 ) RETURN  number IS

 sTmp_ number := 0 ;

BEGIN

    BEGIN
    select s
	  into sTmp_
	  from fin_nd
	 where nd = ND_ and rnk = RNK_
       and (fdat = DAT_ or dat_ = dat_)
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND
		         THEN return null;
		--raise_application_error(-(20000),'/' ||'     '||KOD_||'Відсутні дані за звітний період - '||DAT_,TRUE);
    END;
  RETURN sTmp_;

end ZN_P_ND;


 FUNCTION ZN_P_ND_REPL (KOD_   char,
						IDF_   int default 1,
						DAT_   date default aDAT_,
						ND_    int default  aND_,
						RNK_   int default aRNK_
						) RETURN  fin_question_reply.name%type is

sTmp_ fin_question_reply.name%type;

BEGIN

    BEGIN

/*
    select  nvl(r.namep,R.NAME) as name
     into sTmp_
      from fin_nd f, fin_question_reply r
     where f.nd = ND_ and f.rnk = RNK_
       and (f.fdat = DAT_ or dat_ = dat_)
       and f.kod  = KOD_
       and f.idf  = IDF_
       and f.s = R.VAL and F.KOD = r.kod and f.idf = R.IDF;
*/	   
	   
	select  nvl(r.namep,R.NAME) as name
     into sTmp_
      from fin_question_reply r
     where r.kod = kod_
       and r.idf = idf_
       and r.val = fin_obu.F_GET_FIN_ND(RNK_, ND_, KOD_, IDF_, DAT_);

	   exception when NO_DATA_FOUND
		         THEN return null;
		--raise_application_error(-(20000),'/' ||'     '||KOD_||'Відсутні дані за звітний період - '||DAT_,TRUE);
    END;
  RETURN sTmp_;
end ZN_P_ND_REPL;



  FUNCTION ZN_P_ND_date (KOD_   char,
						 IDF_   int default 1,
						 DAT_   date default aDAT_,
						 ND_    int default aND_,
						 RNK_   int default aRNK_
						 ) RETURN  date IS

 sTmp_ date := null ;

BEGIN

    BEGIN
    select val_date
	  into sTmp_
	  from fin_nd
	 where nd = ND_ and rnk = RNK_
       and (fdat = DAT_ or DAT_ =DAT_)
       and kod  = KOD_
	   and idf  = IDF_;
          exception when NO_DATA_FOUND
		         THEN sTmp_ := null;
		--raise_application_error(-(20000),'/' ||'     '||KOD_||'Відсутні дані за звітний період - '||DAT_,TRUE);
    END;
  RETURN sTmp_;

end ZN_P_ND_date;


 FUNCTION F_GET_FIN_ND (
                             rnk_ int,
                             nd_ int  default 0,
                             kod_ varchar2,
							 IDF_ number,
                             dat_p date,
                             dat_ date default sysdate
                            )
  return number is

  s_ number(24,2);
begin

 select min(s)
      into s_
      from fin_nd_update u
     where idupd = (
                        select max(idupd)
                          from fin_nd_update
                         where nd = nd_
                           and kod = kod_ and idf = idf_
                           and rnk = rnk_
                           and fdat = dat_p
                           and chgdate <= nvl(aDATZ_, sysdate) --dat_ -- and trunc(chgdate) <= dat_
                       );


  IF s_ is null then
    -- берем текущее состояние
    select min(s)
      into s_
      from fin_nd
     where nd = nd_
               and rnk = rnk_ and idf = idf_
               and kod = kod_
               and fdat = dat_p;

  end if;

   /*  IF s_ is null then
    --
 select min(s)
      into s_
      from fin_nd_update u
     where idupd = (
                        select max(idupd)
                          from fin_nd_update
                         where nd = nd_
                           and kod = kod_ and idf = idf_
                           and rnk = rnk_
                           and fdat <=(select max(fdat) from fin_nd where fdat <=dat_p and rnk = rnk_ and kod = kod_ and idf = idf_)--<= dat_p
                           and trunc(chgdate) <= dat_
                       );

  end if;

    IF s_ is null then
    -- берем текущее состояние
    select min(s)
      into s_
      from fin_nd
     where nd = nd_
               and rnk = rnk_
               and kod = kod_ and idf = idf_
               and fdat <= dat_p ;

  end if;
 */



  return s_;
  End f_get_fin_nd;

    PROCEDURE record_fp_ND(KOD_   IN  char,
                         S_    IN  number,
                         IDF_  IN  int,
				         DAT_  IN  date default aDAT_,
				         ND_   IN  int default aND_,
                         RNK_  IN  int default aRNK_ )
	IS
Begin

UPDATE FIN_ND
  SET S = round(S_,2), fdat = DAT_
    WHERE --fdat = DAT_  AND
	  ND = ND_ and rnk = RNK_
	  AND kod = KOD_
	  AND idf = IDF_;
if SQL%rowcount = 0 then
   INSERT INTO FIN_ND (FDAT,  IDF, KOD, S,  ND, RNK) VALUES (DAT_,  IDF_, KOD_, round(S_,2),  ND_, RNK_);
end if;

END record_fp_ND;

    PROCEDURE record_fp_ND_date(KOD_   IN  char,
    							 val_date_    IN  date,
								 IDF_  IN  int,
								 DAT_  IN  date default aDAT_,
								 ND_   IN  int default aND_,
								 RNK_  IN  int default aRNK_ )
	IS
Begin

UPDATE FIN_ND
  SET val_date = val_date_,
      fdat = DAT_
    WHERE
	  ND = ND_ and rnk = RNK_
	  AND kod = KOD_
	  AND idf = IDF_;
if SQL%rowcount = 0 then
   INSERT INTO FIN_ND (FDAT,  IDF, KOD, val_date,  ND, RNK)
      VALUES (DAT_,  IDF_, KOD_, val_date_,  ND_, RNK_);
end if;

END record_fp_ND_date;


   FUNCTION   CALC_POK_DOP (kod_ IN  char,
                       dat_ IN  date default aDAT_,
                       okpo_ IN  int default aOKPO_
					   )
	return number is
	
	FZ_ varchar2(1); --Форма звітності
	
	Begin
	
	
	fin_nbu.aDAT_ :=DAT_;
	fin_nbu.aOKPO_ := OKPO_;
	
	FZ_    := fin_nbu.F_FM (OKPO_, DAT_ ) ;

Begin
	if kod_ = 'FR1' then
	--Виручка від реалізації продукції    FR1
			IF FZ_ = 'N' or FZ_ in ('R','C') THEN
					 return null;
			ELSE
					 return fin_nbu.ZN_F2('010',4,dat_, okpo_);
			END IF;

    elsif 	kod_ = 'FR2' then
	--Непрямі податrи (ПДВ, акциз тощо) FR2
			IF FZ_ = 'N' or FZ_ in ('R','C') THEN
			       return null;
			ELSIF FZ_ = ' ' THEN
 				   return -(fin_nbu.ZN_FDK('015',dat_, okpo_)+fin_nbu.ZN_FDK('020',dat_, okpo_)+fin_nbu.ZN_FDK('025',dat_, okpo_)+fin_nbu.ZN_FDK('030',dat_, okpo_));
			ELSE
 				   return -(fin_nbu.ZN_F2('020',4,dat_, okpo_));
			END IF;

    elsif 	kod_ = 'FR1_2' then			
        -- Чиста виручка від реалізації
			IF FZ_ = 'N'      THEN
						   return fin_nbu.ZN_FDK('2000',dat_, okpo_)- fin_nbu.ZN_FDK('2010',dat_, okpo_);
			ELSIF FZ_ = ' '   THEN
						   return -(fin_nbu.ZN_FDK('015',dat_, okpo_)+fin_nbu.ZN_FDK('020',dat_, okpo_)+fin_nbu.ZN_FDK('025',dat_, okpo_)+fin_nbu.ZN_FDK('030',dat_, okpo_))+fin_nbu.ZN_FDK('010',dat_, okpo_);
			ElsIF FZ_ in ('R','C')   THEN
						   return fin_nbu.ZN_F2('2000',3,dat_, okpo_);
			ELSE
						   return fin_nbu.ZN_F2('030',3,dat_, okpo_);
			END IF;	
			
	elsif 	kod_ = 'FR3' then
	--Собівартість реалізованої продукції FR3
			IF FZ_ = 'N'    THEN
				  return -fin_nbu.ZN_FDK('2050',dat_, okpo_)+ fin_nbu.ZN_FDK('2070',dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
				  return -fin_nbu.ZN_FDK('040',dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
				  return -fin_nbu.ZN_F2('2050',3,dat_, okpo_);

			ELSE
				  return -fin_nbu.ZN_F2('080',3,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'FR4' then
	--Адмін.витрати та витрати на збут FR4
			IF FZ_ = 'N' THEN
			        return -(fin_nbu.ZN_FDK('2130',dat_, okpo_)+fin_nbu.ZN_FDK('2150',dat_, okpo_));
			ELSIF FZ_ = ' ' THEN
        			return -(fin_nbu.ZN_FDK('080',dat_, okpo_)+fin_nbu.ZN_FDK('070',dat_, okpo_));
			ELSE
        			return 0;
			END IF;

	elsif 	kod_ = 'FR5' then
	--Операційні доходи та витрати FR5
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_FDK('2120',dat_, okpo_)+ fin_nbu.ZN_FDK('2105',dat_, okpo_)+ fin_nbu.ZN_FDK('2110',dat_, okpo_)-fin_nbu.ZN_FDK('2180',dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
			        return fin_nbu.ZN_FDK('060',dat_, okpo_)-fin_nbu.ZN_FDK('090',dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F2('2120',3,dat_, okpo_)-fin_nbu.ZN_F2('2180',3,dat_, okpo_);
			ELSE
			        return fin_nbu.ZN_F2('040',3,dat_, okpo_)-fin_nbu.ZN_F2('090',3,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'FR6' then
	--Неопераційні доходи і витрати FR6
			IF FZ_ = 'N' THEN
			        return (fin_nbu.ZN_FDK('2200',dat_, okpo_)+fin_nbu.ZN_FDK('2240',dat_, okpo_))-(fin_nbu.ZN_FDK('2255',dat_, okpo_)+fin_nbu.ZN_FDK('2270',dat_, okpo_));
			ELSIF FZ_ = ' ' THEN
			        return (fin_nbu.ZN_FDK('110',dat_, okpo_)+fin_nbu.ZN_FDK('130',dat_, okpo_))-(fin_nbu.ZN_FDK('150',dat_, okpo_)+fin_nbu.ZN_FDK('160',dat_, okpo_));
			ElsIF FZ_ in ('R','C') THEN
			        return (fin_nbu.ZN_F2('2240',3,dat_, okpo_))-(fin_nbu.ZN_F2('2270',3,dat_, okpo_));
			ELSE
			        return (fin_nbu.ZN_F2('050',3,dat_, okpo_)-fin_nbu.ZN_F2('100',3,dat_, okpo_));
			END IF;

	elsif 	kod_ = 'FR7' then
	--Фінансові доходи і витрати FR7
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_FDK('2220',dat_, okpo_)-fin_nbu.ZN_FDK('2250',dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
			        return fin_nbu.ZN_FDK('120',dat_, okpo_)-fin_nbu.ZN_FDK('140',dat_, okpo_)+fin_nbu.ZN_FDK('165',dat_, okpo_);
			ELSE
			        return 0;
			END IF;

	elsif 	kod_ = 'FR8' then
	--Податок на прибуток FR8
			IF FZ_ = 'N' THEN
			        return -fin_nbu.ZN_FDK('2300',dat_, okpo_)+fin_nbu.ZN_FDK('2455',dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
			        return -fin_nbu.ZN_FDK('180',dat_, okpo_)+fin_nbu.ZN_FDK('185',dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return -fin_nbu.ZN_F2('2300',3,dat_, okpo_);
			ELSE
			        return -fin_nbu.ZN_F2('140',3,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'FR9' then
	--Надзвичайн доходи і витрати FR9
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_FDK('2305',dat_, okpo_)+fin_nbu.ZN_FDK('2450',dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
			        return fin_nbu.ZN_FDK('200',dat_, okpo_)-fin_nbu.ZN_FDK('205',dat_, okpo_)-fin_nbu.ZN_FDK('210',dat_, okpo_);
			ELSE
			        return 0;
			END IF;
			
		elsif 	kod_ = 'FR10' then
	--Фінансові витрати FR10
			IF FZ_ = 'N' THEN
			        return -(fin_nbu.ZN_FDK('2250',dat_, okpo_));
			ELSIF FZ_ = ' ' THEN
			        return -(fin_nbu.ZN_FDK('140',dat_, okpo_));
			ELSE
			        return 0;
			END IF;		
			
        elsif 	kod_ = 'FR11' then
	--Амортизація FR11
			IF FZ_ = 'N' THEN
			       return (fin_nbu.ZN_FDK('2515',dat_, okpo_));
			ELSIF  FZ_ = ' ' THEN
			       return (fin_nbu.ZN_FDK('260',dat_, okpo_));
			ElsIF FZ_ in ('R','C') THEN
			       return (fin_nbu.ZN_F1('1012',4, dat_, OKPO_)-fin_nbu.ZN_F1('1012', 4,add_months(trunc( DAT_),-12), OKPO_));
			ELSE
				   return fin_nbu.ZN_F1('032',4, dat_, OKPO_)-fin_nbu.ZN_F1('032', 4,add_months(trunc( DAT_),-3), OKPO_) +  fin_nbu.ZN_F1('037',4, dat_, OKPO_)-fin_nbu.ZN_F1('037',4,add_months(trunc( DAT_),-3), OKPO_);
			END IF;		
        elsif 	kod_ = 'FR12' then
	--EBITDA FR12
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_FDK('2250',dat_, okpo_) + fin_nbu.ZN_FDK('2515',dat_, okpo_) + fin_nbu.ZN_FDK('2290',dat_, okpo_) - fin_nbu.ZN_FDK('2295',dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
			       return fin_nbu.ZN_FDK('140',dat_, okpo_) + fin_nbu.ZN_FDK('260',dat_, okpo_) + fin_nbu.ZN_FDK('170',dat_, okpo_) - fin_nbu.ZN_FDK('175',dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       --return fin_nbu.ZN_FDK('2350',dat_, okpo_) + fin_nbu.ZN_FDK('2300',dat_, okpo_)+ (fin_nbu.ZN_F1('1012',4, dat_, OKPO_)-fin_nbu.ZN_F1('1012', 4,add_months(trunc( DAT_),-12), OKPO_))/4+fin_nbu.ZN_FDK('3001',dat_, okpo_);
				   return fin_nbu.ZN_F2('2350',3,dat_, okpo_) + fin_nbu.ZN_F2('2300',3,dat_, okpo_)+ (fin_nbu.ZN_F1('1012',4, dat_, OKPO_)-fin_nbu.ZN_F1('1012', 4,add_months(trunc( DAT_),-12), OKPO_))+fin_nbu.ZN_F2('3001',3,dat_, okpo_);
				   
		    ELSE
			       return  fin_nbu.ZN_F2('130',3,dat_, okpo_) + (fin_nbu.ZN_F1('032',4, dat_, OKPO_)-fin_nbu.ZN_F1('032', 4,add_months(trunc( DAT_),-12), OKPO_)) +  (fin_nbu.ZN_F1('037',4, dat_, OKPO_)-fin_nbu.ZN_F1('037',4,add_months(trunc( DAT_),-12), OKPO_));
			END IF;		


	elsif 	kod_ = 'A01' then
	--Незавершене будівництво A01
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_F1('1005',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F1('1005',4,dat_, okpo_);
  		    ELSE
			        return fin_nbu.ZN_F1('020',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A02' then
	--Основні засоби A02
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_F1('1010',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F1('1010',4,dat_, okpo_);
			ELSE
			        return fin_nbu.ZN_F1('030',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A03' then
	--Довгострокові фінансові вкладення A03
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_F1('1030',4,dat_, okpo_)+fin_nbu.ZN_F1('1035',4,dat_, okpo_)+fin_nbu.ZN_F1('1040',4,dat_, okpo_)+ fin_nbu.ZN_F1('1060',4,dat_, okpo_)+ fin_nbu.ZN_F1('1065',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F1('1030',4,dat_, okpo_);
			ELSE
			        return fin_nbu.ZN_F1('040',4,dat_, okpo_)+fin_nbu.ZN_F1('045',4,dat_, okpo_)+fin_nbu.ZN_F1('050',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A04' then
	--Справедлива (залишкова) вартість інвестиційної нерухомост A04
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_F1('1000',4,dat_, okpo_)+fin_nbu.ZN_F1('1015',4,dat_, okpo_)+fin_nbu.ZN_F1('1020',4,dat_, okpo_)+fin_nbu.ZN_F1('1045',4,dat_, okpo_)+fin_nbu.ZN_F1('1050',4,dat_, okpo_)+ fin_nbu.ZN_F1('1090',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F1('1020',4,dat_, okpo_)+ fin_nbu.ZN_F1('1090',4,dat_, okpo_);
			ELSE
			        return fin_nbu.ZN_F1('010',4,dat_, okpo_)+fin_nbu.ZN_F1('035',4,dat_, okpo_)+fin_nbu.ZN_F1('060',4,dat_, okpo_)+fin_nbu.ZN_F1('065',4,dat_, okpo_)+fin_nbu.ZN_F1('070',4,dat_, okpo_);
			END IF;


	elsif 	kod_ = 'A05' then
	--Необоротні активи A05
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_F1('1095',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F1('1095',4,dat_, okpo_);
			ELSE
			        return fin_nbu.ZN_F1('080',4,dat_, okpo_);
			END IF;


	elsif 	kod_ = 'A06' then
	--Запаси A06
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_F1('1100',4,dat_, okpo_)+fin_nbu.ZN_F1('1110',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F1('1100',4,dat_, okpo_)+fin_nbu.ZN_F1('1110',4,dat_, okpo_);
			ELSE
			        return fin_nbu.ZN_F1('100',4,dat_, okpo_)+fin_nbu.ZN_F1('110',4,dat_, okpo_)+fin_nbu.ZN_F1('120',4,dat_, okpo_)+fin_nbu.ZN_F1('130',4,dat_, okpo_)+fin_nbu.ZN_F1('140',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A07' then
	--Дебіторська заборгованість A07
			IF FZ_ = 'N' THEN
			        return fin_nbu.ZN_F1('1120',4,dat_, okpo_)+fin_nbu.ZN_F1('1125',4,dat_, okpo_)+fin_nbu.ZN_F1('1135',4,dat_, okpo_)+fin_nbu.ZN_F1('1130',4,dat_, okpo_)+fin_nbu.ZN_F1('1140',4,dat_, okpo_)+fin_nbu.ZN_F1('1145',4,dat_, okpo_)+fin_nbu.ZN_F1('1155',4,dat_, okpo_)+fin_nbu.ZN_F1('1160',4,dat_, okpo_)+ fin_nbu.ZN_F1('1115',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			        return fin_nbu.ZN_F1('1125',4,dat_, okpo_)+fin_nbu.ZN_F1('1135',4,dat_, okpo_)+fin_nbu.ZN_F1('1155',4,dat_, okpo_)+fin_nbu.ZN_F1('1160',4,dat_, okpo_);
			ELSE
			        return fin_nbu.ZN_F1('150',4,dat_, okpo_)+fin_nbu.ZN_F1('160',4,dat_, okpo_)+fin_nbu.ZN_F1('170',4,dat_, okpo_)+fin_nbu.ZN_F1('180',4,dat_, okpo_)+fin_nbu.ZN_F1('190',4,dat_, okpo_)+fin_nbu.ZN_F1('200',4,dat_, okpo_)+fin_nbu.ZN_F1('210',4,dat_, okpo_)+fin_nbu.ZN_F1('220',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A08' then
	--Грошові кошти A08
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1165',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1165',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('230',4,dat_, okpo_)+fin_nbu.ZN_F1('240',4,dat_, okpo_);
			END IF;
			
	elsif 	kod_ = 'A08.1' then
	--Інші оборотні активи A08.1
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1190',4,dat_, okpo_)+fin_nbu.ZN_F1('1180',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1190',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('250',4,dat_, okpo_);
			END IF;		

	elsif 	kod_ = 'A09' then
	--Оборотні активи A09
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1195',4,dat_, okpo_)- fin_nbu.ZN_F1('1170',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1195',4,dat_, okpo_)- fin_nbu.ZN_F1('1170',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('260',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A10' then
	--Витрати майбутніх періодів A10
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1170',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1170',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('270',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A10.1' then
	--Необоротні активи та групи вибуття A10.1
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1200',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1200',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('275',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'A11' then
	--Актив балансу A11
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1300',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1300',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('280',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'P01' then
	--Статутний капітал P01
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1400',4,dat_, okpo_)+fin_nbu.ZN_F1('1425',4,dat_, okpo_)+fin_nbu.ZN_F1('1430',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1400',4,dat_, okpo_)+fin_nbu.ZN_F1('1425',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('300',4,dat_, okpo_)+fin_nbu.ZN_F1('310',4,dat_, okpo_)+fin_nbu.ZN_F1('360',4,dat_, okpo_)+fin_nbu.ZN_F1('370',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'P02' then
	--Інший власний капітал P02
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1405',4,dat_, okpo_)+fin_nbu.ZN_F1('1410',4,dat_, okpo_)+fin_nbu.ZN_F1('1415',4,dat_, okpo_)+ fin_nbu.ZN_F1('1435',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1410',4,dat_, okpo_)+fin_nbu.ZN_F1('1415',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('320',4,dat_, okpo_)+fin_nbu.ZN_F1('330',4,dat_, okpo_)+fin_nbu.ZN_F1('340',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'P03' then
	--Нерозподілений прибуток (непокритий збуток) P03
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1420',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1420',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('350',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'P04' then
	--Власний капітал P04
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1495',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1495',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('380',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'P05' then
	--Інші довгострокові зобвов'язання P05
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1595',4,dat_, okpo_)-fin_nbu.ZN_F1('1510',4,dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
			       return fin_nbu.ZN_F1('430',4,dat_, okpo_)+fin_nbu.ZN_F1('450',4,dat_, okpo_)+fin_nbu.ZN_F1('460',4,dat_, okpo_)+fin_nbu.ZN_F1('470',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1595',4,dat_, okpo_);
			ELSE 	   
			       return fin_nbu.ZN_F1('430',4,dat_, okpo_);
			END IF;

	elsif 	kod_ = 'P06' then
	--Довгострокові/короткостр. кредити банків P06
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1510',4,dat_, okpo_)+fin_nbu.ZN_F1('1600',4,dat_, okpo_)+fin_nbu.ZN_F1('1610',4,dat_, okpo_);
			ELSIF FZ_ = ' ' THEN
			       return fin_nbu.ZN_F1('440',4,dat_, okpo_)+fin_nbu.ZN_F1('500',4,dat_, okpo_)+fin_nbu.ZN_F1('510',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1595',4,dat_, okpo_)+fin_nbu.ZN_F1('1600',4,dat_, okpo_)+fin_nbu.ZN_F1('1610',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('480',4,dat_, okpo_)+fin_nbu.ZN_F1('500',4,dat_, okpo_);	   
			END IF;

	elsif 	kod_ = 'P07' then
	--Кредиторська заборгованість P07
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1600',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)+fin_nbu.ZN_F1('1700',4,dat_, okpo_)+ fin_nbu.ZN_F1('1800',4,dat_, okpo_)-fin_nbu.ZN_F1('1610',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1600',4,dat_, okpo_)-fin_nbu.ZN_F1('1610',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('620',4,dat_, okpo_)-fin_nbu.ZN_F1('500',4,dat_, okpo_)-fin_nbu.ZN_F1('510',4,dat_, okpo_);
			END IF;


	elsif 	kod_ = 'P08' then
	--Позикові кошти P08
			IF FZ_ = 'N' THEN
			      return fin_nbu.ZN_F1('1595',4,dat_, okpo_)+ fin_nbu.ZN_F1('1695',4,dat_, okpo_) +fin_nbu.ZN_F1('1700',4,dat_, okpo_)+ fin_nbu.ZN_F1('1800',4,dat_, okpo_)- fin_nbu.ZN_F1('1665',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			      return fin_nbu.ZN_F1('1595',4,dat_, okpo_)+ fin_nbu.ZN_F1('1695',4,dat_, okpo_) ;
			ELSE
				   return (fin_nbu.ZN_F1('430',4,dat_, okpo_)+fin_nbu.ZN_F1('450',4,dat_, okpo_)+fin_nbu.ZN_F1('460',4,dat_, okpo_)+fin_nbu.ZN_F1('470',4,dat_, okpo_)) +
					      (fin_nbu.ZN_F1('440',4,dat_, okpo_)+fin_nbu.ZN_F1('500',4,dat_, okpo_)+fin_nbu.ZN_F1('510',4,dat_, okpo_)) +
					      (fin_nbu.ZN_F1('620',4,dat_, okpo_)-fin_nbu.ZN_F1('500',4,dat_, okpo_)-fin_nbu.ZN_F1('510',4,dat_, okpo_));
			END IF;


	elsif 	kod_ = 'P09' then
	--Доходи майбутніх періодів P09
			IF FZ_ = 'N' THEN
			       return fin_nbu.ZN_F1('1665',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			       return fin_nbu.ZN_F1('1665',4,dat_, okpo_);
			ELSE
			       return fin_nbu.ZN_F1('630',4,dat_, okpo_);
			END IF;


	elsif 	kod_ = 'P10' then
	--Пасив балансу P10
			IF FZ_ = 'N' THEN
			      return fin_nbu.ZN_F1('1900',4,dat_, okpo_);
			ElsIF FZ_ in ('R','C') THEN
			      return fin_nbu.ZN_F1('1900',4,dat_, okpo_);
			ELSE
			      return fin_nbu.ZN_F1('640',4,dat_, okpo_);
			END IF;

    else

	return null;
	end if;
 exception
    when others then
return null;
end;	

	end;


  FUNCTION   CALC_POK (kod_ IN  char,
                       dat_ IN  date default aDAT_,
                       okpo_ IN  int default aOKPO_,
					   rnk_  in  int default aRNK_,
					   nd_   in  int default aND_
					   )
	return number is
	sTmp number;
	FZ_ varchar2(1); -- форма звітності
	cl_tip number;   -- тіп клієнта
	dat1_ date;
	tip_kof_ number;
	acc_  accounts.acc%type ;
	kol_fz_ number;
l_t  int;
l_t1 int;
 k number := 12;
 l_ number  :=1;
 s_ number := 0;
 s2_ number := 0;
 k2 number := 0;
 lim_ number := 0;
 pr_ number := 0;
 kol_m number := 0;

   begin
    aOKPO_ := OKPO_;
    aDAT_ := DAT_;
    aRNK_ := RNK_;
    aND_  := ND_;
    
	fin_nbu.aND_ :=ND_;
	fin_nbu.aDAT_ :=DAT_;
	fin_nbu.aRNK_ := RNK_;
	fin_nbu.aOKPO_ := OKPO_;
    
	FZ_    := fin_nbu.F_FM (aOKPO_, aDAT_ ) ;
    cl_tip := F_GET_FIN_ND(aRNK_, aND_, 'TIP', 32, dat_); --ZN_P_ND('TIP', 32, DAT_, aND_, aRNK_);
	tip_kof_:=cl_tip;



			select count(*)
			  into kol_fz_            -- наявність різних форм
			from fin_fm
			where okpo =  OKPO_
			   and fdat between  add_months(trunc( DAT_),-12) and DAT_
			   and Fm  not in ( FZ_, decode(FZ_,'N',' ',' ', 'N', '-') ); --<> FZ_;

			select count(*)*3
			  into kol_m            -- кількість місяців звітності.для 5 кварталів
			from fin_fm
			where okpo =  OKPO_
			   and fdat between  add_months(trunc( DAT_),-12) and DAT_
			   and Fm in ( FZ_, decode(FZ_,'N',' ',' ', 'N', '-'));-- = FZ_;


    if kod_ = 'NSM' then
	/*
	Нсм – середньомісячний чистий дохід (виручки)
	*/

         --    logger.info('Loger fin0'||cl_tip); 
	     if tip_kof_ > 1 then         -- сезонність 1 - сезонний інші ні.

         --    logger.info('Loger fin1 '||((fin_nbu.ZN_FDK('2000',dat_, okpo_)+fin_nbu.ZN_FDK('2010',dat_, okpo_)+fin_nbu.ZN_FDK('2105',dat_, okpo_)+fin_nbu.ZN_FDK('2110',dat_, okpo_)+fin_nbu.ZN_FDK('2120',dat_, okpo_)+fin_nbu.ZN_FDK('2240',dat_, okpo_))/3)); 

					    if FZ_ = ' ' then s_:= ((fin_nbu.ZN_FDK('035',dat_, okpo_)+fin_nbu.ZN_FDK('060',dat_, okpo_)+fin_nbu.ZN_FDK('130',dat_, okpo_))/3);
					 elsif FZ_ = 'N' then s_:= ((fin_nbu.ZN_FDK('2000',dat_, okpo_)+fin_nbu.ZN_FDK('2010',dat_, okpo_)+fin_nbu.ZN_FDK('2105',dat_, okpo_)+fin_nbu.ZN_FDK('2110',dat_, okpo_)+fin_nbu.ZN_FDK('2120',dat_, okpo_)+fin_nbu.ZN_FDK('2240',dat_, okpo_))/3);
					 elsif FZ_ in ('R','C') then s_:= ((fin_nbu.ZN_FDK('2280',dat_, okpo_))/3);
					 else            s_:= ((fin_nbu.ZN_FDK('070',dat_, okpo_))/3);
					 end if;



		 else
        --   logger.info('Loger fin2 '||((fin_nbu.ZN_F2('2000',4, dat_, okpo_)/12 + fin_nbu.ZN_F2('2010',4,dat_, okpo_)/12+fin_nbu.ZN_F2('2105',4,dat_, okpo_)/12+fin_nbu.ZN_F2('2110',4, dat_, okpo_)/12 + fin_nbu.ZN_F2('2120',4,dat_, okpo_)/12+fin_nbu.ZN_F2('2240',4,dat_, okpo_)/12))); 
           			begin
					  if FZ_ = ' '  then s_:=((fin_nbu.ZN_F2('035',4,  dat_, okpo_)/12 + fin_nbu.ZN_F2('060',4,dat_, okpo_)/12+fin_nbu.ZN_F2('130',4,dat_, okpo_)/12));
				   elsif FZ_ = 'N'  then s_:=((fin_nbu.ZN_F2('2000',4, dat_, okpo_)/12 + fin_nbu.ZN_F2('2010',4,dat_, okpo_)/12+fin_nbu.ZN_F2('2105',4,dat_, okpo_)/12+fin_nbu.ZN_F2('2110',4, dat_, okpo_)/12 + fin_nbu.ZN_F2('2120',4,dat_, okpo_)/12+fin_nbu.ZN_F2('2240',4,dat_, okpo_)/12));
				   elsif FZ_ in ('R','C') then s_:= ((fin_nbu.ZN_F2('2280',4, dat_, okpo_))/12);									
				   else s_:= (fin_nbu.ZN_F2('070',4, dat_, okpo_)/12);
					  end if;
					end;

		 end if;

		-- logger.info('Loger fin3 '||s_);
		             return (s_);

	elsif kod_ = 'ZM0' then
	/*
       Зм – щомісячні умовно-постійні витрати Контрагента
	*/

	  select repl_s
	    into l_
        from fin_question_reply
      where kod = 'TIP'
         and val = tip_kof_;


	     if tip_kof_ > 1 then
					     if FZ_ = ' ' then return ((fin_nbu.ZN_FDK('040',dat_, okpo_)*l_ + fin_nbu.ZN_FDK('070',dat_, okpo_)+fin_nbu.ZN_FDK('080',dat_, okpo_))/3);
					  elsif FZ_ = 'N' then return ((fin_nbu.ZN_FDK('2050',dat_, okpo_)*l_ + fin_nbu.ZN_FDK('2070',dat_, okpo_)+fin_nbu.ZN_FDK('2130',dat_, okpo_)+fin_nbu.ZN_FDK('2150',dat_, okpo_))/3);
					  elsif FZ_ in ('R','C') then return ((fin_nbu.ZN_FDK('2050',dat_, okpo_)*l_)/3);
					  else                 return ((fin_nbu.ZN_FDK('080',dat_, okpo_)*l_)/3);
					  end if;
		 else

           			begin

 					     if FZ_ = ' '  then s_:=((fin_nbu.ZN_F2('040',4,  dat_, okpo_)*l_/12 +fin_nbu.ZN_F2('070',4, dat_, okpo_)/12+fin_nbu.ZN_F2('080',4, dat_, okpo_)/12));
					  elsif FZ_ = 'N'  then s_:=((fin_nbu.ZN_F2('2050',4, dat_, okpo_)*l_/12 +fin_nbu.ZN_F2('2070',4, dat_, okpo_)/12+fin_nbu.ZN_F2('2130',4, dat_, okpo_)/12+fin_nbu.ZN_F2('2150',4, dat_, okpo_)/12));
					  elsif FZ_ in ('R','C')  then s_:=((fin_nbu.ZN_F2('2050',4, dat_, okpo_)*l_)/12);					  
						        		else s_:= (fin_nbu.ZN_F2('080',4, dat_, okpo_)*l_/12);
					  end if;
					  return (s_);

					 end;

		 end if;

	elsif kod_ = 'NKD' then
	/*
	Кількість місяців до завершення КД від звітної дати
	*/

	if F_GET_FIN_ND(aRNK_, aND_, 'VIS', 32, dat_) = 2 then

	     if ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_) > ZN_P_ND_date('DAS', 32, DAT_, aND_, aRNK_) then
	     return round(MONTHS_BETWEEN(ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_), ZN_P_ND_date('DAS', 32, DAT_, aND_, aRNK_)),1);
		 else return 0;

		 end if;


	else


	     if ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_) >dat_ then
	     return round(MONTHS_BETWEEN(ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_), gl.bd),1);
		 else return 0;

		 end if;
	end if;


	elsif kod_ = 'TDP' then
	/*
	Термін діяльності підприемства TDP   TDP
	*/



	     if ZN_P_ND_date('DST', 32, DAT_, aND_, aRNK_) < dat_ then
	     return round(MONTHS_BETWEEN(dat_, ZN_P_ND_date('DST', 32, DAT_, aND_, aRNK_) ),1)/12;
		 else return 0;
		 raise_application_error(-(20000),'\-' ||'     '||KOD_||' - '||ZN_P_ND_date('DST', 32, DAT_, aND_, aRNK_)||' Не вірно вказана дата створення підприемства ' ||round(MONTHS_BETWEEN(dat_, ZN_P_ND_date('DSP', 32, DAT_, aND_, aRNK_)),1)   ,TRUE);
		 end if;

	elsif kod_ = 'KKD' then
	/*
	Кількість місяців  КД
	*/

	--raise_application_error(-(20000),'\-' ||'     '||KOD_||' - '||ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_)||' ' ||round(MONTHS_BETWEEN(dat_, ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_)),1)   ,TRUE);




	     if ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_) >ZN_P_ND_date('DAS', 32, DAT_, aND_, aRNK_) then

	     return round(MONTHS_BETWEEN(ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_), ZN_P_ND_date('DAS', 32, DAT_, aND_, aRNK_)),1);
		 else return 0;

		 end if;




	elsif kod_ = 'SK0' then
	/*
	Ск – сума кредиту (заборгованість за кредитом) та проценти за ним з урахуванням строку, що залишився до погашення кредиту
	  (за кредитами в іноземній валюті ця сума приймається до розрахунку з урахуванням зміни валютного курсу порівняно з датою
	  укладання угоди). Строк, що залишився до погашення кредиту визначається з урахуванням строку пролонгації кредиту.
	*/

	--l_,     Вид кредиту  (кредитна лінія, ....)
	--pr_,    % ставка
	--lim_,   Ліміт
	--k2      Залишок кредиту


    if F_GET_FIN_ND(aRNK_, aND_, 'VIS', 32, dat_) = 2 -- попередній
            then
			  null;
			  l_    := ZN_P_ND('GRF', 32, DAT_, aND_, aRNK_);
			  pr_   := ZN_P_ND('PRC', 32, DAT_, aND_, aRNK_);

			  lim_  :=  p_icurval(ZN_P_ND('VAL', 30, DAT_, aND_, aRNK_), ZN_P_ND('SUN', 32, DAT_, aND_, aRNK_), sysdate);
			  k2    :=  lim_;
              dat1_ := 	ZN_P_ND_date('DAS', 32, DAT_, aND_, aRNK_)	;

	else  -- поточний

	      begin
			select  c.vidd
				into l_
				   from  accounts a, cc_deal c,  cc_add d
					 where a.acc = d.accs
					   and c.nd = aND_  and c.nd = d.nd
					   group by c.nd, c.vidd ;
			dat1_ := dat_;
	     	pr_   := ZN_P_ND('PRC', 32, DAT_, aND_, aRNK_);
     		lim_  :=  p_icurval(ZN_P_ND('VAL', 30, DAT_, aND_, aRNK_), ZN_P_ND('SUN', 32, DAT_, aND_, aRNK_), sysdate);
			k2    :=  lim_;
			l_    := ZN_P_ND('GRF', 32, DAT_, aND_, aRNK_);

		   exception when NO_DATA_FOUND
			 THEN
			 -- временно проблема. напевно овердрафт або щось інше
              pr_   := ZN_P_ND('PRC', 32, DAT_, aND_, aRNK_);
    		 lim_  :=  p_icurval(ZN_P_ND('VAL', 30, DAT_, aND_, aRNK_), ZN_P_ND('SUN', 32, DAT_, aND_, aRNK_), sysdate);
			 return (lim_ + (lim_*pr_/12*MONTHS_BETWEEN(ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_), gl.bd))); 
			 null;
			end ;

	end if;


	      
	

	if   l_ = 2 then   -- погашення рівними частинами

        if F_GET_FIN_ND(aRNK_, aND_, 'VIS', 32, dat_) = 2 then-- попередній

		         return (GET_Summ_SK (k2,    pr_,  dat1_,  ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_)));   -- вираховую перебудовую графік в залежності від залишка кредиту

		else   -- поточний

        	Begin
		    	select nvl(sum(sumo),0)
				  into sTmp
				  from CC_W_LIM
				 where fdat >= gl.bd
				   and nd = aND_;
		     exception when NO_DATA_FOUND  THEN
			 sTmp := (GET_Summ_SK (k2,    pr_,  dat1_,  ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_)));
			 end;

/*             begin
                select  A.KV
                into    k2
                   from  accounts a, cc_deal c,  cc_add d
                     where a.acc = d.accs
                       and c.nd = aND_  and c.nd = d.nd
                        ;
           exception when NO_DATA_FOUND
             THEN
             null;
            end ; */
          k2:= nvl(ZN_P_ND ('VAL', 30, DAT_, aND_, aRNK_),980);
             --logger.info('sk0   STMT'||sTmp||' K2'||k2);
             --  LOGGER.INFO('sk0   '||p_icurval(K2, abs(sTmp), sysdate));
          
		return  (p_icurval(K2, abs(sTmp), sysdate));

		end if;




	elsif l_ = 1 then

        if F_GET_FIN_ND(aRNK_, aND_, 'VIS', 32, dat_) = 2 then -- попередній

    	        return (GET_Summ_SK (k2,    pr_,  dat1_,  ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_),1));   -- вираховую антуітет перебудовую графік в залежності від залишка кредиту

		else   -- поточний

			Begin
				 select sum(sumo)
				   into  sTmp
				   from CC_W_LIM
				  where fdat >= gl.bd
					and nd = aND_;
			exception when NO_DATA_FOUND  THEN
				 sTmp := (GET_Summ_SK (k2,    pr_,  dat1_,  ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_)));
			end;

/*             begin
                select  A.KV
                into    k2
                   from  accounts a, cc_deal c,  cc_add d
                     where a.acc = d.accs
                       and c.nd = aND_  and c.nd = d.nd
                        ;
           exception when NO_DATA_FOUND
             THEN
             null;
            end ; */

			k2:= nvl(ZN_P_ND ('VAL', 30, DAT_, aND_, aRNK_),980);
			
		return  (p_icurval(K2, abs(sTmp), sysdate));

		end if;


	else

 if F_GET_FIN_ND(aRNK_, aND_, 'VIS', 32, dat_) = 2 then -- попередній

                  return (lim_ + (lim_*pr_/100/12*MONTHS_BETWEEN(ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_), gl.bd)));   

        else   -- поточний

            Begin
                 select nvl(sum(sumo),0)
                   into  sTmp
                   from CC_W_LIM
                  where fdat >= gl.bd
                    and nd = aND_;
            exception when NO_DATA_FOUND  THEN
                 sTmp := (GET_Summ_SK (k2,    pr_,  dat1_,  ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_)));
            end;


             k2:= nvl(ZN_P_ND ('VAL', 30, DAT_, aND_, aRNK_),980);


			if sTmp =0  then  sTmp := (lim_ + (lim_*pr_/100/12*MONTHS_BETWEEN(ZN_P_ND_date('DAW', 32, DAT_, aND_, aRNK_), gl.bd))); end if;
			
		
        return  (p_icurval(K2, abs(sTmp), sysdate));

        end if;
	end if;


    elsif kod_ = 'KL1' then
        	/*
	1.	Коефіцієнт миттєвої ліквідності (КЛ1)
	       */
          
		IF FZ_ = 'N'    THEN  
			  if (fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
			  else 
			     sTmp := (fin_nbu.ZN_F1('1160',4,dat_, okpo_)+fin_nbu.ZN_F1('1165',4,dat_, okpo_))/(fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
			  end if;
		ElsIF FZ_ in ('R','C')    THEN  
			  if (fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
			  else 
			     sTmp := (fin_nbu.ZN_F1('1160',4,dat_, okpo_)+fin_nbu.ZN_F1('1165',4,dat_, okpo_))/(fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
			  end if;			  
		ELSE
			  if fin_nbu.ZN_F1('620',4,dat_, okpo_) = 0 then sTmp :=0;
			  else
				  sTmp := (fin_nbu.ZN_F1('220',4,dat_, okpo_)+fin_nbu.ZN_F1('230',4,dat_, okpo_)+fin_nbu.ZN_F1('240',4,dat_, okpo_))/fin_nbu.ZN_F1('620',4,dat_, okpo_);
			  end if;
        END IF;
		
		 if sTmp != 0 then return sTmp;
		 else return MIN_MAX_SCOR(tip_kof_, 'KL1', 'MAX');
		 end if;
          

    elsif kod_ = 'KL2' then
   	/*
	2.	Коефіцієнт поточної ліквідності (КЛ2)
	*/
	
	IF FZ_ = 'N'    THEN
	
	    if (fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1115',4,dat_, okpo_)+fin_nbu.ZN_F1('1120',4,dat_, okpo_)+fin_nbu.ZN_F1('1125',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1130',4,dat_, okpo_)+fin_nbu.ZN_F1('1135',4,dat_, okpo_)+fin_nbu.ZN_F1('1140',4,dat_, okpo_)+fin_nbu.ZN_F1('1180',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1145',4,dat_, okpo_)+fin_nbu.ZN_F1('1155',4,dat_, okpo_)+fin_nbu.ZN_F1('1160',4,dat_, okpo_)+fin_nbu.ZN_F1('1165',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		 end if;
	ElsIF FZ_ in ('R','C')    THEN
	
	    if (fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1125',4,dat_, okpo_)+fin_nbu.ZN_F1('1135',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1155',4,dat_, okpo_)+fin_nbu.ZN_F1('1160',4,dat_, okpo_)+fin_nbu.ZN_F1('1165',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		 end if;
		
	
	ELSE
	    if fin_nbu.ZN_F1('620',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('150',4,dat_, okpo_)+fin_nbu.ZN_F1('160',4,dat_, okpo_)+fin_nbu.ZN_F1('170',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('180',4,dat_, okpo_)+fin_nbu.ZN_F1('190',4,dat_, okpo_)+fin_nbu.ZN_F1('200',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('210',4,dat_, okpo_)+fin_nbu.ZN_F1('220',4,dat_, okpo_)+fin_nbu.ZN_F1('230',4,dat_, okpo_)+fin_nbu.ZN_F1('240',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('620',4,dat_, okpo_);
		 end if;
    END IF;
		 if sTmp != 0 then return sTmp;
		 else return MIN_MAX_SCOR(tip_kof_, 'KL2', 'MAX');
		 end if;


  elsif kod_ = 'KP0' then
   	/*
	3.	Коефіцієнт загальної ліквідності (коефіцієнт покриття) (КП)
	*/
	
	IF FZ_ = 'N'    THEN
	    if (fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1195',4,dat_, okpo_)-fin_nbu.ZN_F1('1170',4,dat_, okpo_)) /(fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		 end if;
	ElsIF FZ_ in ('R','C')    THEN
	    if (fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1195',4,dat_, okpo_)-fin_nbu.ZN_F1('1170',4,dat_, okpo_)) /(fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		 end if;
	ELSE
	    if fin_nbu.ZN_F1('620',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('260',4,dat_, okpo_)) /fin_nbu.ZN_F1('620',4,dat_, okpo_);
		 end if;
	END IF;	 

		 if sTmp != 0 then return sTmp;
		 else return MIN_MAX_SCOR(tip_kof_, 'KP0', 'MAX');
		 end if;

  elsif kod_ = 'KA0' then
   	/*
	4.	Коефіцієнт співвідношення ліквідних та необоротних активів (Ка)
	*/
	IF FZ_ = 'N'    THEN
	    if fin_nbu.ZN_F1('1095',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1160',4,dat_, okpo_)+fin_nbu.ZN_F1('1165',4,dat_, okpo_)+fin_nbu.ZN_F1('1125',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1130',4,dat_, okpo_)+fin_nbu.ZN_F1('1135',4,dat_, okpo_)+fin_nbu.ZN_F1('1140',4,dat_, okpo_)+fin_nbu.ZN_F1('1115',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1145',4,dat_, okpo_)+fin_nbu.ZN_F1('1155',4,dat_, okpo_)+fin_nbu.ZN_F1('1120',4,dat_, okpo_)+fin_nbu.ZN_F1('1180',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('1095',4,dat_, okpo_);
		end if;
	ElsIF FZ_ in ('R','C')    THEN
	    if fin_nbu.ZN_F1('1095',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1160',4,dat_, okpo_)+fin_nbu.ZN_F1('1165',4,dat_, okpo_)+fin_nbu.ZN_F1('1125',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1135',4,dat_, okpo_)+fin_nbu.ZN_F1('1155',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('1095',4,dat_, okpo_);
		end if;
    ELSE	
	    if fin_nbu.ZN_F1('080',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('150',4,dat_, okpo_)+fin_nbu.ZN_F1('160',4,dat_, okpo_)+fin_nbu.ZN_F1('170',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('180',4,dat_, okpo_)+fin_nbu.ZN_F1('190',4,dat_, okpo_)+fin_nbu.ZN_F1('200',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('210',4,dat_, okpo_)+fin_nbu.ZN_F1('220',4,dat_, okpo_)+fin_nbu.ZN_F1('230',4,dat_, okpo_)+fin_nbu.ZN_F1('240',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('080',4,dat_, okpo_);
		end if;
    END IF;
	
		 if sTmp != 0 then return sTmp;
		 else return MIN_MAX_SCOR(tip_kof_, 'KA0', 'MAX');
		 end if;

  elsif kod_ = 'KN0' then
   	/*
      5.	Коефіцієнт незалежності (КН)
	*/
	IF FZ_ = 'N'    THEN
	    if fin_nbu.ZN_F1('1495',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1500',4,dat_, okpo_)+fin_nbu.ZN_F1('1510',4,dat_, okpo_)+fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('1495',4,dat_, okpo_);
		end if;	
	ElsIF FZ_ in ('R','C')    THEN
	    if fin_nbu.ZN_F1('1495',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1595',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('1495',4,dat_, okpo_);
		end if;	
		ELSE
	    if fin_nbu.ZN_F1('380',4,dat_, okpo_) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('480',4,dat_, okpo_)+fin_nbu.ZN_F1('620',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('380',4,dat_, okpo_);
		end if;
    END IF;
		 if sTmp > 0 then return sTmp;
		 else return MIN_MAX_SCOR(tip_kof_, 'KN0', 'MAX');
		 end if;

   elsif kod_ = 'KM0' then
   	/*
     6.	Коефіцієнт маневреності власних коштів (КМ)
	*/
	IF FZ_ = 'N'    THEN
	    if fin_nbu.ZN_F1('1495',4,dat_, okpo_) <= 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1495',4,dat_, okpo_)-fin_nbu.ZN_F1('1095',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('1495',4,dat_, okpo_);
		end if;
	ElsIF FZ_ in ('R','C')    THEN
	    if fin_nbu.ZN_F1('1495',4,dat_, okpo_) <= 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1495',4,dat_, okpo_)-fin_nbu.ZN_F1('1095',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('1495',4,dat_, okpo_);
		end if;
	
    ELSE 	
	    if fin_nbu.ZN_F1('380',4,dat_, okpo_) <= 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('380',4,dat_, okpo_)-fin_nbu.ZN_F1('080',4,dat_, okpo_))
		         /fin_nbu.ZN_F1('380',4,dat_, okpo_);
		end if;
    END IF;
		 if sTmp != 0 then return sTmp;
		 else return (MIN_MAX_SCOR(tip_kof_, 'KM0', 'MIN')-0.01);
		 end if;



    elsif kod_ = 'KZV' then
   	/*
     7.	Коефіцієнт забезпечення власними оборотними засобами (Кзв
	*/
	
	IF FZ_ = 'N'    THEN
	    if (fin_nbu.ZN_F1('1500',4,dat_, okpo_)+fin_nbu.ZN_F1('1510',4,dat_, okpo_)+fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1495',4,dat_, okpo_)+fin_nbu.ZN_F1('1595',4,dat_, okpo_)-
		         fin_nbu.ZN_F1('1500',4,dat_, okpo_)-fin_nbu.ZN_F1('1510',4,dat_, okpo_)-
				 fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1665',4,dat_, okpo_)-
		         fin_nbu.ZN_F1('1095',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1500',4,dat_, okpo_)+fin_nbu.ZN_F1('1510',4,dat_, okpo_)+fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		end if;
		
	ElsIF FZ_ in ('R','C')    THEN
	    if (fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1495',4,dat_, okpo_)+fin_nbu.ZN_F1('1595',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1665',4,dat_, okpo_)-fin_nbu.ZN_F1('1095',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		end if;
		
	ELSE
	    if (fin_nbu.ZN_F1('480',4,dat_, okpo_)+fin_nbu.ZN_F1('620',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('380',4,dat_, okpo_)+fin_nbu.ZN_F1('430',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('630',4,dat_, okpo_)-fin_nbu.ZN_F1('080',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('480',4,dat_, okpo_)+fin_nbu.ZN_F1('620',4,dat_, okpo_));
		end if;
	END IF;	

		 if sTmp = 0 then
			 IF FZ_ = 'N'    THEN
			                   if  (fin_nbu.ZN_F1('1495',4,dat_, okpo_)+fin_nbu.ZN_F1('1595',4,dat_, okpo_)-
								    fin_nbu.ZN_F1('1500',4,dat_, okpo_)-fin_nbu.ZN_F1('1510',4,dat_, okpo_)-
									fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1665',4,dat_, okpo_)) < fin_nbu.ZN_F1('1095',4,dat_, okpo_)
									  then return MIN_MAX_SCOR(tip_kof_, 'KZV', 'MIN');
									  else return MIN_MAX_SCOR(tip_kof_, 'KZV', 'MAX');
							   end if;
			 ElsIF FZ_ in ('R','C')    THEN
			                   if  (fin_nbu.ZN_F1('380',4,dat_, okpo_)+fin_nbu.ZN_F1('430',4,dat_, okpo_)+fin_nbu.ZN_F1('630',4,dat_, okpo_)) < fin_nbu.ZN_F1('1095',4,dat_, okpo_)
									  then return MIN_MAX_SCOR(tip_kof_, 'KZV', 'MIN');
									  else return MIN_MAX_SCOR(tip_kof_, 'KZV', 'MAX');
							   end if;							   
			 ELSE
							   if  (fin_nbu.ZN_F1('380',4,dat_, okpo_)+fin_nbu.ZN_F1('430',4,dat_, okpo_)+fin_nbu.ZN_F1('630',4,dat_, okpo_)) < fin_nbu.ZN_F1('080',4,dat_, okpo_)
									  then return MIN_MAX_SCOR(tip_kof_, 'KZV', 'MIN');
									  else return MIN_MAX_SCOR(tip_kof_, 'KZV', 'MAX');
							   end if;
			 END IF;				   
		 else return sTmp;
		 end if;


		 elsif kod_ = 'KDP' then
   	/*
8.	Коефіцієнт забезпечення необоротних активів власним капіталом та довгостроковими пасивами (Кдп)
	*/
	 IF FZ_ = 'N'    THEN
	    if (fin_nbu.ZN_F1('1095',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1495',4,dat_, okpo_)+fin_nbu.ZN_F1('1595',4,dat_, okpo_)+fin_nbu.ZN_F1('1665',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1095',4,dat_, okpo_));
		end if;
	 ElsIF FZ_ in ('R','C')    THEN
	    if (fin_nbu.ZN_F1('1095',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1495',4,dat_, okpo_)+fin_nbu.ZN_F1('1595',4,dat_, okpo_)+fin_nbu.ZN_F1('1665',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1095',4,dat_, okpo_));
		end if;		
	 ELSE
	    if (fin_nbu.ZN_F1('080',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('380',4,dat_, okpo_)+fin_nbu.ZN_F1('430',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('630',4,dat_, okpo_)+fin_nbu.ZN_F1('480',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('080',4,dat_, okpo_));
		end if;
    END IF;
		 if sTmp != 0 then return sTmp;
		 else return  MIN_MAX_SCOR(tip_kof_, 'KDP', 'MAX');
		 end if;


		 elsif kod_ = 'DV0' then
   	/*
9.	Динаміка виручки від реалізації продукції (товарів, робіт, послуг) (ДВ)
	*/

					if cl_tip = 7 or kol_fz_ != 0 then dat1_  := add_months(trunc(DAT_),-3);
								                  else dat1_  := add_months(trunc(DAT_),-(kol_m-3));
					end if;


					if FZ_ = ' ' then
							if (fin_nbu.ZN_FDK('035',dat1_, okpo_)) = 0 then sTmp :=0;
							  else
							sTmp := (fin_nbu.ZN_FDK('035',dat_, okpo_)-fin_nbu.ZN_FDK('035',dat1_, okpo_))
									 /(fin_nbu.ZN_FDK('035',dat1_, okpo_));
							end if;
							
					elsif FZ_ = 'N' then
							if (fin_nbu.ZN_FDK('2000',dat1_, okpo_)+fin_nbu.ZN_FDK('2010',dat1_, okpo_)) = 0 then sTmp :=0;
							  else
							sTmp := ((fin_nbu.ZN_FDK('2000',dat_, okpo_)+fin_nbu.ZN_FDK('2010',dat_, okpo_))
							         -(fin_nbu.ZN_FDK('2000',dat1_, okpo_)+fin_nbu.ZN_FDK('2010',dat1_, okpo_)))
									 /(fin_nbu.ZN_FDK('2000',dat1_, okpo_)+fin_nbu.ZN_FDK('2010',dat1_, okpo_));
							end if;

					elsif FZ_ in ('R','C') then
						    dat1_ :=  add_months(trunc(DAT_),-g_period);   
							if (fin_nbu.ZN_FDK('2000',dat1_, okpo_)) = 0 then sTmp :=0;
							  else
							sTmp := (fin_nbu.ZN_FDK('2000',dat_, okpo_)-fin_nbu.ZN_FDK('2000',dat1_, okpo_))
									 /(fin_nbu.ZN_FDK('2000',dat1_, okpo_));
							end if;
							
					else
					      
						dat1_ :=  add_months(trunc(DAT_),-g_period);   
					  
							if (fin_nbu.ZN_FDK('030',dat1_, okpo_)) = 0 then sTmp :=0;
							  else
							sTmp := (fin_nbu.ZN_FDK('030',dat_, okpo_)-fin_nbu.ZN_FDK('030',dat1_, okpo_))
									 /(fin_nbu.ZN_FDK('030',dat1_, okpo_));
							end if;
					end if;

				    return sTmp*100;


	elsif kod_ = 'KGP' then
 /*
 10.	Показник грошового потоку (Кгп)
 */



      if nvl(ZN_P_ND('SK0', 30, DAT_, aND_, aRNK_),'0') != '0' then

--logger.info ('1-'||(nvl(ZN_P_ND('NSM', 30, DAT_, aND_, aRNK_),0)     )|| ' - '||
--			 '2-'||(nvl(ZN_P_ND('ZM0', 30, DAT_, aND_, aRNK_),0)    )|| ' - '||
--			 '3-'||nvl(ZN_P_ND('ZI0', 30, DAT_, aND_, aRNK_),0)||
--	          ' / '||
--			  nvl(ZN_P_ND('SK0', 30, DAT_, aND_, aRNK_),0));

	  return (
	        (nvl(ZN_P_ND('NSM', 30, DAT_, aND_, aRNK_),0)*nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0)     ) -
			(nvl(ZN_P_ND('ZM0', 30, DAT_, aND_, aRNK_),0)*nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0)     ) -
			 nvl(ZN_P_ND('ZI0', 30, DAT_, aND_, aRNK_),0)
	          ) /
			  (nvl(ZN_P_ND('SK0', 30, DAT_, aND_, aRNK_),0)/1000);

	  else return 0;
	  end if;

 	elsif kod_ = 'KSP' then
 /*
 11.	Коефіцієнт співвідношення дебіторської та кредиторської заборгованості (Ксп)
 */
    
    IF FZ_ = 'N'    THEN
 	    if (fin_nbu.ZN_F1('1500',4,dat_, okpo_)+fin_nbu.ZN_F1('1510',4,dat_, okpo_)+fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1030',4,dat_, okpo_)+fin_nbu.ZN_F1('1035',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1040',4,dat_, okpo_)+fin_nbu.ZN_F1('1120',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('1125',4,dat_, okpo_)+fin_nbu.ZN_F1('1130',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('1135',4,dat_, okpo_)+fin_nbu.ZN_F1('1140',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('1145',4,dat_, okpo_)+fin_nbu.ZN_F1('1155',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1160',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1500',4,dat_, okpo_)+fin_nbu.ZN_F1('1510',4,dat_, okpo_)+fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		end if;

    ElsIF FZ_ in ('R','C')    THEN
 	    if (fin_nbu.ZN_F1('1595',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('1030',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('1125',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('1135',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('1155',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('1160',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('1595',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_)-fin_nbu.ZN_F1('1665',4,dat_, okpo_));
		end if;
		
    ELSE	
 	    if (fin_nbu.ZN_F1('480',4,dat_, okpo_)+fin_nbu.ZN_F1('620',4,dat_, okpo_)) = 0 then sTmp :=0;
          else
		sTmp := (fin_nbu.ZN_F1('160',4,dat_, okpo_)+fin_nbu.ZN_F1('170',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('180',4,dat_, okpo_)+fin_nbu.ZN_F1('190',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('200',4,dat_, okpo_)+fin_nbu.ZN_F1('210',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('220',4,dat_, okpo_)+fin_nbu.ZN_F1('150',4,dat_, okpo_)+
				 fin_nbu.ZN_F1('040',4,dat_, okpo_)+fin_nbu.ZN_F1('045',4,dat_, okpo_)+
		         fin_nbu.ZN_F1('050',4,dat_, okpo_))
		         /(fin_nbu.ZN_F1('480',4,dat_, okpo_)+fin_nbu.ZN_F1('620',4,dat_, okpo_));
		end if;
    END IF;

		 if sTmp > 0 then return sTmp;
		 else return  MIN_MAX_SCOR(tip_kof_, 'KSP', 'MAX');
		 end if;



		 	elsif kod_ = 'DD0' then
 /*
12.	Динаміка дебіторської заборгованості (ДД)
 */

     					if cl_tip = 7 or kol_fz_ != 0 then dat1_  := add_months(trunc(DAT_),-3);
													  else dat1_  := add_months(trunc(DAT_),-(kol_m-3));
					    end if;
						
						
						if (FZ_ = 'M' or FZ_ = 'R' or FZ_ = 'C') then dat1_  := add_months(trunc(DAT_),-g_period);
						end if;
						
						
    IF FZ_ = 'N'    THEN
	         s_ := (fin_nbu.ZN_F1('1030',4,dat1_, okpo_)+fin_nbu.ZN_F1('1035',4,dat1_, okpo_)+
		            fin_nbu.ZN_F1('1040',4,dat1_, okpo_)+fin_nbu.ZN_F1('1120',4,dat1_, okpo_)+
				    fin_nbu.ZN_F1('1125',4,dat1_, okpo_)+fin_nbu.ZN_F1('1130',4,dat1_, okpo_)+
					fin_nbu.ZN_F1('1135',4,dat1_, okpo_)+fin_nbu.ZN_F1('1140',4,dat1_, okpo_)+
					fin_nbu.ZN_F1('1145',4,dat1_, okpo_)+
				    fin_nbu.ZN_F1('1155',4,dat1_, okpo_)+fin_nbu.ZN_F1('1160',4,dat1_, okpo_));
    ElsIF FZ_ in ('R','C')    THEN
	         s_ := (fin_nbu.ZN_F1('1030',4,dat1_, okpo_)+
				    fin_nbu.ZN_F1('1125',4,dat1_, okpo_)+
					fin_nbu.ZN_F1('1135',4,dat1_, okpo_)+
				    fin_nbu.ZN_F1('1155',4,dat1_, okpo_)+
					fin_nbu.ZN_F1('1160',4,dat1_, okpo_));					
	ELSE
	         s_ := (fin_nbu.ZN_F1('160',4,dat1_, okpo_)+fin_nbu.ZN_F1('170',4,dat1_, okpo_)+
		            fin_nbu.ZN_F1('180',4,dat1_, okpo_)+fin_nbu.ZN_F1('190',4,dat1_, okpo_)+
				    fin_nbu.ZN_F1('200',4,dat1_, okpo_)+fin_nbu.ZN_F1('210',4,dat1_, okpo_)+
				    fin_nbu.ZN_F1('220',4,dat1_, okpo_)+fin_nbu.ZN_F1('150',4,dat1_, okpo_));
	END IF;

 	    if s_ = 0 then sTmp :=0;
          else
    IF FZ_ = 'N'    THEN
		sTmp := (((fin_nbu.ZN_F1('1030',4,dat_, okpo_)+fin_nbu.ZN_F1('1035',4,dat_, okpo_)+
		          fin_nbu.ZN_F1('1040',4,dat_, okpo_)+fin_nbu.ZN_F1('1120',4,dat_, okpo_)+
				  fin_nbu.ZN_F1('1125',4,dat_, okpo_)+fin_nbu.ZN_F1('1130',4,dat_, okpo_)+
				  fin_nbu.ZN_F1('1135',4,dat_, okpo_)+fin_nbu.ZN_F1('1140',4,dat_, okpo_)+
				  fin_nbu.ZN_F1('1145',4,dat_, okpo_)+
				  fin_nbu.ZN_F1('1155',4,dat_, okpo_)+fin_nbu.ZN_F1('1160',4,dat_, okpo_)) - s_)
		         /s_)*100;
    ElsIF FZ_ in ('R','C')    THEN
		sTmp := (((fin_nbu.ZN_F1('1030',4,dat_, okpo_)+
				   fin_nbu.ZN_F1('1125',4,dat_, okpo_)+
				   fin_nbu.ZN_F1('1135',4,dat_, okpo_)+
				   fin_nbu.ZN_F1('1155',4,dat_, okpo_)+
				   fin_nbu.ZN_F1('1160',4,dat_, okpo_)) - s_)
		            /s_)*100;
	ELSE
		sTmp := (((fin_nbu.ZN_F1('160',4,dat_, okpo_)+fin_nbu.ZN_F1('170',4,dat_, okpo_)+
		          fin_nbu.ZN_F1('180',4,dat_, okpo_)+fin_nbu.ZN_F1('190',4,dat_, okpo_)+
				  fin_nbu.ZN_F1('200',4,dat_, okpo_)+fin_nbu.ZN_F1('210',4,dat_, okpo_)+
				  fin_nbu.ZN_F1('220',4,dat_, okpo_)+fin_nbu.ZN_F1('150',4,dat_, okpo_)) - s_)
		         /s_)*100;
	END IF;
		end if;

		 if sTmp = 0 or sTmp = 100 then return 0;
		 else return sTmp;
		 end if;



		 		 	elsif kod_ = 'DK0' then
 /*
13.	Динаміка кредиторської заборгованості (ДК)
 */

     					if cl_tip = 7 or kol_fz_ != 0 then dat1_  := add_months(trunc(DAT_),-3);
								                      else dat1_  := add_months(trunc(DAT_),-(kol_m-3));
					    end if;
						
						if (FZ_ = 'M' or FZ_ = 'R' or FZ_ = 'C') then dat1_  := add_months(trunc(DAT_),-g_period);
						end if;
						
						
    IF FZ_ = 'N'    THEN
	         s_ := (fin_nbu.ZN_F1('1500',4,dat1_, okpo_)+fin_nbu.ZN_F1('1510',4,dat1_, okpo_) +
                    fin_nbu.ZN_F1('1515',4,dat1_, okpo_)+fin_nbu.ZN_F1('1695',4,dat1_, okpo_) -
                    fin_nbu.ZN_F1('1665',4,dat1_, okpo_));
    ElsIF FZ_ in ('R','C')    THEN
	         s_ := (fin_nbu.ZN_F1('1595',4,dat1_, okpo_)+fin_nbu.ZN_F1('1695',4,dat1_, okpo_) -
                    fin_nbu.ZN_F1('1665',4,dat1_, okpo_));					
	ELSE
	         s_ := (fin_nbu.ZN_F1('480',4,dat1_, okpo_)+fin_nbu.ZN_F1('620',4,dat1_, okpo_) );
	END IF;


 	    if s_ = 0 then sTmp :=0;
        else
		  
				IF FZ_ = 'N'    THEN
					sTmp := (((fin_nbu.ZN_F1('1500',4,dat_, okpo_)+fin_nbu.ZN_F1('1510',4,dat_, okpo_) +
					           fin_nbu.ZN_F1('1515',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_) -
							   fin_nbu.ZN_F1('1665',4,dat_, okpo_)    ) - s_)/s_)*100;				
				ElsIF FZ_ in ('R','C')    THEN
					sTmp := (((fin_nbu.ZN_F1('1595',4,dat_, okpo_)+fin_nbu.ZN_F1('1695',4,dat_, okpo_) -
							   fin_nbu.ZN_F1('1665',4,dat_, okpo_)    ) - s_)/s_)*100;				

 			    ELSE	
					sTmp := (((fin_nbu.ZN_F1('480',4,dat_, okpo_)+fin_nbu.ZN_F1('620',4,dat_, okpo_)) - s_)/s_)*100;
				END IF;
		end if;

		 if sTmp = 0 or sTmp = 100 then return 0;
		 else return sTmp;
		 end if;


		 elsif kod_ = 'DZP' then

		 /*
14.	Діяльність звітного періоду (Дзп)
	*/


	           if FZ_ = ' ' then s_:=  (fin_nbu.ZN_F2('220', 4, DAT_, okpo_)- fin_nbu.ZN_F2('225', 4,  DAT_, okpo_));
			elsif FZ_ = 'N' then s_:=  (fin_nbu.ZN_F2('2465', 4, DAT_, okpo_));
			elsif FZ_ in ('R','C') then s_:=  (fin_nbu.ZN_F2('2350', 4, DAT_, okpo_));			
			else s_:=   fin_nbu.ZN_F2('150', 4, DAT_, okpo_);
			end if;


		        if s_ > 0 then return 1; -- прибуткова
				          else return 2; -- збиткова
				end if;

	 elsif kod_ = 'G00' then
 /*
15.	Коефіцієнт співвідношення заборгованості за кредитами та власного (акціонерного) капіталу (Гіринг).
 */

    IF FZ_ = 'N'    THEN
      if fin_nbu.ZN_F1('1495',4,dat_, okpo_) > 0 then

	  return (( fin_nbu.ZN_F1('1510',4,dat_, okpo_) + fin_nbu.ZN_F1('1600',4,dat_, okpo_)) /
			  fin_nbu.ZN_F1('1495',4,dat_, okpo_))*100;

	  else return 6000;
	  end if;
    
	ElsIF FZ_ in ('R','C')    THEN
      if fin_nbu.ZN_F1('1495',4,dat_, okpo_) > 0 then

	  return (( fin_nbu.ZN_F1('1595',4,dat_, okpo_) + fin_nbu.ZN_F1('1600',4,dat_, okpo_)) /
			  fin_nbu.ZN_F1('1495',4,dat_, okpo_))*100;

	  else return 6000;
	  end if;
	
	ELSE
      if fin_nbu.ZN_F1('380',4,dat_, okpo_) > 0 then

	  return (( fin_nbu.ZN_F1('440',4,dat_, okpo_) + fin_nbu.ZN_F1('500',4,dat_, okpo_)) /
			  fin_nbu.ZN_F1('380',4,dat_, okpo_))*100;

	  else return 6000;
	  end if;
	END IF;  


	 elsif kod_ = 'RP0' then

		 /*
16.	Рентабельність продажу (Рп)
	*/


	if FZ_ = ' ' then
	              s_  := (fin_nbu.ZN_F2('220', 4, DAT_, okpo_) - fin_nbu.ZN_F2('225',4,  DAT_, okpo_));
				  s2_ :=  fin_nbu.ZN_F2('035', 4, DAT_, okpo_);
	elsif FZ_ = 'N' then
	              s_  := (fin_nbu.ZN_F2('2465', 4, DAT_, okpo_) );
				  s2_ :=  fin_nbu.ZN_F2('2000', 4, DAT_, okpo_)+fin_nbu.ZN_F2('2010', 4, DAT_, okpo_);			  
	elsif FZ_ in ('R','C') then
	              s_  := (fin_nbu.ZN_F2('2350', 4, DAT_, okpo_) );
				  s2_ :=  fin_nbu.ZN_F2('2000', 4, DAT_, okpo_);			  
	else
	              s_  := (fin_nbu.ZN_F2('150', 4, DAT_, okpo_));
				  s2_ :=  fin_nbu.ZN_F2('030', 4, DAT_, okpo_);
	null;

	end if;

		        if s2_ = 0 then return 0;
				           else return (s_/s2_)*100;
				end if;

	 elsif kod_ = 'PA0' then

		 /*
17.	Рентабельність активів (Ра)
	*/


           			begin

/* 						  while  k>=3 and l_ != 0 loop
								select count(*)
								  into l_
								from fin_fm
								where okpo =  OKPO_
								   and fdat between  add_months(trunc( DAT_),-k) and DAT_
								   and Fm <> FZ_;

							   k := k - 3;

						 end loop;
				   */

		k := kol_m;
			if FZ_ = ' ' then
				 if (k) = 15 then
	                    
					                     s_  := (fin_nbu.ZN_F2('220', 4, DAT_, okpo_) - fin_nbu.ZN_F2('225',4,  DAT_, okpo_));

          				
						                 s2_ := ( (fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-12), okpo_))/2 +
										         fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-9), okpo_) +
                                                 fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-6), okpo_)	+
                                                 fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-3), okpo_) +
												 (fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-0), okpo_))/2  )/4;


				 else
					  while k2 < k loop
					                     s_  := s_ + (fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k2), okpo_)- fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k2), okpo_));
					                     s2_ := s2_ + fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-k2), okpo_);

					   k2 := k2 + 3;
					  end loop;
					  s2_ := s2_/(k2/3);
				end if;
			elsif FZ_ = 'N' then
				 if (k) = 15 then
	                    
					                     s_  := (fin_nbu.ZN_F2('2465', 4, DAT_, okpo_));

          				
						                 s2_ := ( (fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-12), okpo_))/2 +
										         fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-9), okpo_) +
                                                 fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-6), okpo_)	+
                                                 fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-3), okpo_) +
												 (fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-0), okpo_))/2  )/4;


			    else
					  while k2 < k loop
					                     s_  := s_ + (fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k2), okpo_));
					                     s2_ := s2_ + fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-k2), okpo_);

					   k2 := k2 + 3;
					  end loop;
					  s2_ := s2_/(k2/3);
				end if;
			else
			         if  FZ_ in ('R','C') then
                              			 s_  :=  fin_nbu.ZN_F2('2350',4,DAT_, okpo_);
									     s2_ :=  (fin_nbu.ZN_F1('1900',4,dat_, okpo_)+fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-12), okpo_))/2;
					 
                     else					 
                              			 s_  :=  fin_nbu.ZN_F2('150',4,DAT_, okpo_);
									     s2_ :=  fin_nbu.ZN_F1('280',4,dat_, okpo_);
                     end if;                    

            end if;
					  end;
		        if s2_ = 0 then return 0;
				           else return (s_/s2_)*100;
				end if;


			 elsif kod_ = 'DA0' then

		 /*
18.	Динаміка рентабельності активів (Да)
	*/


           			begin
/*
 						 while  k>=3 and l_ != 0 loop
								select count(*)
								  into l_
								from fin_fm
								where okpo =  OKPO_
								   and fdat between  add_months(trunc( DAT_),-k) and DAT_
								   and Fm <> FZ_;

							   k := k - 3;

						 end loop; */


    if (kol_m > 3 and FZ_ in (' ', 'N')) then
	      --  logger.info('FIN01  p1=kol_m '||kol_m);


		if  cl_tip = 7
		then
                    if FZ_ = ' ' then
						begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k), okpo_) - fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k), okpo_))/
														((fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-k), okpo_)+
														  fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2));


							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  k:= 3;
							  s2_ :=((fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-(k+3)), okpo_) -fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-(k+3)), okpo_))/
														((fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-(k)), okpo_)+
														  fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2));
							  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;
					elsif FZ_ = 'N' then
						begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_))/
														((fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-k), okpo_)+
														  fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2));


							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  k:= 3;
							  s2_ :=((fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_))/
														((fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-(k)), okpo_)+
														  fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2));
							  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;	

                    ElsIF FZ_ in ('R','C') then
                        begin
                         k:= 0;
                         s_ :=(fin_nbu.zn_f2('2350',4,add_months(trunc( DAT_),-k), okpo_) /
                                                        ((fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-k), okpo_)+
                                                          fin_nbu.ZN_F1('1900',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_))/2));
                            exception when  ZERO_DIVIDE  then s_ := 0;
                        end;

                    
                          begin
                            select 1
                              into kol_m            
                            from fin_fm
                            where okpo =  OKPO_
                               and fdat = add_months(trunc( (DAT_ - 1) , 'Y' ),-12)
                               and Fm in ( FZ_, decode(FZ_,'N',' ',' ', 'N', '-'), decode(FZ_,'R','M','M', 'R', '-') );
                           exception when NO_DATA_FOUND then kol_m := 0;    
                          end;     
                        
                        
                    begin    
                        if kol_m = 1 then
                        k:= 9;
                        s2_ :=(fin_nbu.zn_f2('2350',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
                                                        ((fin_nbu.ZN_F1('1900',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)+
                                                          fin_nbu.ZN_F1('1900',4,add_months(trunc( (DAT_ - 1) , 'Y' ),-12) , okpo_))/2));
                         else 
                         s2_ :=(fin_nbu.zn_f2('2350',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
                                                        (fin_nbu.ZN_F1('1900',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)    ));
                         
                         end if;
                            exception when  ZERO_DIVIDE  then s2_ := 0;
                    end;
						

					else
                        begin
                         k:= 0;
                         s_ :=(fin_nbu.zn_f2('150',4,add_months(trunc( DAT_),-k), okpo_) /
                                                        ((fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-k), okpo_)+
                                                          fin_nbu.ZN_F1('280',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_))/2));
                            exception when  ZERO_DIVIDE  then s_ := 0;
                        end;

                    
                          begin
                            select 1
                              into kol_m            
                            from fin_fm
                            where okpo =  OKPO_
                               and fdat = add_months(trunc( (DAT_ - 1) , 'Y' ),-12)
                               and Fm in ( FZ_, decode(FZ_,'N',' ',' ', 'N', '-'), decode(FZ_,'R','M','M', 'R', '-') );
                           exception when NO_DATA_FOUND then kol_m := 0;    
                          end;     
                        
                        
                    begin    
                        if kol_m = 1 then
                        k:= 9;
                        s2_ :=(fin_nbu.zn_f2('150',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
                                                        ((fin_nbu.ZN_F1('280',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)+
                                                          fin_nbu.ZN_F1('280',4,add_months(trunc( (DAT_ - 1) , 'Y' ),-12) , okpo_))/2));
                         else 
                         s2_ :=(fin_nbu.zn_f2('150',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
                                                        (fin_nbu.ZN_F1('280',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)    ));
                         
                         end if;
                            exception when  ZERO_DIVIDE  then s2_ := 0;
                    end;
						
						
                    end if;

            --        logger.info('FIN0  p3 s-'||s_||' s2-'||s2_||' '||add_months(trunc( DAT_),-(k+3)));
                        return (s_*100 - s2_*100);




        else

		        if FZ_ = ' ' then
						 begin
						 k:= 0;
						 s_ :=(fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k), okpo_) -fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k), okpo_))/
														((fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-k), okpo_)+
														  fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2);
						--logger.info('FIN01  DA0=S_ '||s_||' S1');
							exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						

						select count(*)*3
						  into kol_m
						from fin_fm
						where okpo =  OKPO_
						   and fdat between  add_months(trunc( DAT_),-15) and DAT_
						   and Fm in ( FZ_, decode(FZ_,'N',' ',' ', 'N', '-') );--= FZ_;


						k:= kol_m-6;
                     begin
						s2_ :=((fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k), okpo_)-fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k), okpo_)) /
														((fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-(k)), okpo_)+
														  fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2));

							exception when  ZERO_DIVIDE  then s2_ := 0;
					 end;
				elsif FZ_ = 'N' then
						 begin
						 k:= 0;
						 s_ :=(fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_))/
														((fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-k), okpo_)+
														  fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2);
						--logger.info('FIN01  DA0=S_ '||s_||' S1');
							exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						

						select count(*)*3
						  into kol_m
						from fin_fm
						where okpo =  OKPO_
						   and fdat between  add_months(trunc( DAT_),-15) and DAT_
						   and Fm in ( FZ_, decode(FZ_,'N',' ',' ', 'N', '-') );--= FZ_;


						k:= kol_m-6;
                     begin
						s2_ :=((fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_)) /
														((fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-(k)), okpo_)+
														  fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-(k+3)), okpo_))/2));

							exception when  ZERO_DIVIDE  then s2_ := 0;
					 end;
					 
				ElsIF FZ_ in ('R','C') then
						 begin
						 k:= 0;
						 s_ :=(fin_nbu.zn_f2('2350',4,add_months(trunc( DAT_),-k), okpo_) /
														((fin_nbu.ZN_F1('1900',4,add_months(trunc( DAT_),-k), okpo_)+
														  fin_nbu.ZN_F1('1900',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_))/2));
							exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
                            select 1
                              into kol_m            
                            from fin_fm
                            where okpo =  OKPO_
                               and fdat = add_months(trunc( (DAT_ - 1) , 'Y' ),-12)
                               and Fm = FZ_;
                           exception when NO_DATA_FOUND then kol_m := 0;    
                          end;     
                        
                        
                        begin
                        if kol_m = 1 then
						k:= 9;
						s2_ :=(fin_nbu.zn_f2('2350',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
														((fin_nbu.ZN_F1('1900',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)+
														  fin_nbu.ZN_F1('1900',4,add_months(trunc( (DAT_ - 1) , 'Y' ),-12) , okpo_))/2));
                         else 
                         s2_ :=(fin_nbu.zn_f2('2350',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
                                                        (fin_nbu.ZN_F1('1900',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)    ));
                         
                         end if;
                                                          
							exception when  ZERO_DIVIDE  then s2_ := 0;
                                          
						end;					 
				else
						 begin
						 k:= 0;
						 s_ :=(fin_nbu.zn_f2('150',4,add_months(trunc( DAT_),-k), okpo_) /
														((fin_nbu.ZN_F1('280',4,add_months(trunc( DAT_),-k), okpo_)+
														  fin_nbu.ZN_F1('280',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_))/2));
							exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
                            select 1
                              into kol_m            
                            from fin_fm
                            where okpo =  OKPO_
                               and fdat = add_months(trunc( (DAT_ - 1) , 'Y' ),-12)
                               and Fm = FZ_;
                           exception when NO_DATA_FOUND then kol_m := 0;    
                          end;     
                        
                        
                        begin
                        if kol_m = 1 then
						k:= 9;
						s2_ :=(fin_nbu.zn_f2('150',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
														((fin_nbu.ZN_F1('280',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)+
														  fin_nbu.ZN_F1('280',4,add_months(trunc( (DAT_ - 1) , 'Y' ),-12) , okpo_))/2));
                         else 
                         s2_ :=(fin_nbu.zn_f2('150',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_) /
                                                        (fin_nbu.ZN_F1('280',4,trunc( (DAT_ - 1) , 'Y' ) , okpo_)    ));
                         
                         end if;
                                                          
							exception when  ZERO_DIVIDE  then s2_ := 0;
                                          
						end;
                end if;

			--		logger.info('FIN0  p3 s-'||s_||' s2-'||s2_||' '||add_months(trunc( DAT_),-(k+3)));
						return (s_*100 - s2_*100);

        end if;

	else

	                   s_  := nvl(F_GET_FIN_ND(aRNK_, aND_,'PA0', 33,  DAT_),0);
					   s2_ := nvl(F_GET_FIN_ND(aRNK_, aND_,'PA0', 33, add_months(trunc( DAT_),-g_period)),0);
					   return (s_-s2_);


	end if;


	  end;


elsif kod_ = 'DRP' then

		 /*
19.	Динаміка рентабельності продажу (Дп)
	*/



           			begin
    if (kol_m > 3 and FZ_ in (' ', 'N'))  then


		if  cl_tip = 7
		then
                    if FZ_ = ' ' then
						begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k), okpo_)-fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k), okpo_)) /
														(fin_nbu.ZN_FDK('035',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  k:= 3;
							  s2_ :=((fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k), okpo_)-fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k), okpo_)) /
														abs(fin_nbu.ZN_FDK('035',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;
                    elsif FZ_ = 'N' then
						begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_)) /
														(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)+fin_nbu.ZN_FDK('2010',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  k:= 3;
							  s2_ :=((fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_)) /
														abs(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)+fin_nbu.ZN_FDK('2010',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;
                    elsif FZ_ in ('R','C') then
						begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('2350',add_months(trunc( DAT_),-k), okpo_)) /
														(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  k:= 3;
							  s2_ :=((fin_nbu.ZN_FDK('2350',add_months(trunc( DAT_),-k), okpo_)) /
														abs(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;						
			        else
                        begin
                              k:= 0;
                              s_ :=(fin_nbu.ZN_F2('150',4,add_months(trunc( DAT_),-k), okpo_) /
                                                        abs(fin_nbu.ZN_F2('030',4,add_months(trunc( DAT_),-k), okpo_)));
                              exception when  ZERO_DIVIDE  then s_ := 0;
                        end;

                        begin
                              k:= 3;
                              s2_ :=(fin_nbu.ZN_F2('150',4,add_months(trunc( DAT_),-k), okpo_) /
                                                         (fin_nbu.ZN_F2('030',4,add_months(trunc( DAT_),-k), okpo_)));
                              exception when  ZERO_DIVIDE  then s2_ := 0;
                        end;

                    end if;
	---        logger.trace('FIN01  p2 s-'||s_||' s2-'||s2_||' '||add_months(trunc( DAT_),-k));
						return (s_*100 - s2_*100);




        else

		            if FZ_ = ' ' then
				     	begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k), okpo_)-fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k), okpo_)) /
														(fin_nbu.ZN_FDK('035',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  --k:= 12;
                              k:= kol_m - 3;
							  s2_ :=((fin_nbu.ZN_FDK('220',add_months(trunc( DAT_),-k), okpo_)-fin_nbu.ZN_FDK('225',add_months(trunc( DAT_),-k), okpo_)) /
														abs(fin_nbu.ZN_FDK('035',add_months(trunc( DAT_),-k), okpo_)));
						  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;

    	            elsif FZ_ = 'N' then
				     	begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_)) /
														(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)+fin_nbu.ZN_FDK('2010',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  --k:= 12;
                              k:= kol_m - 3;
							  s2_ :=((fin_nbu.ZN_FDK('2465',add_months(trunc( DAT_),-k), okpo_)) /
														abs(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)+fin_nbu.ZN_FDK('2010',add_months(trunc( DAT_),-k), okpo_)));
						  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;

    	            elsif FZ_ in ('R','C') then
				     	begin
							  k:= 0;
							  s_ :=((fin_nbu.ZN_FDK('2350',add_months(trunc( DAT_),-k), okpo_)) /
														(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  
                              k:= g_period;
							  s2_ :=((fin_nbu.ZN_FDK('2350',add_months(trunc( DAT_),-k), okpo_)) /
														abs(fin_nbu.ZN_FDK('2000',add_months(trunc( DAT_),-k), okpo_)));
						  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;


			        else
					    begin
							  k:= 0;
							  s_ :=(fin_nbu.ZN_F2('150',4,add_months(trunc( DAT_),-k), okpo_) /
														abs(fin_nbu.ZN_F2('030',4,add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s_ := 0;
						end;

						begin
							  k:= g_period;
							  s2_ :=(fin_nbu.ZN_F2('150',4,add_months(trunc( DAT_),-k), okpo_) /
														 (fin_nbu.ZN_F2('030',4,add_months(trunc( DAT_),-k), okpo_)));
							  exception when  ZERO_DIVIDE  then s2_ := 0;
						end;

                    end if;
			    --  logger.info('FIN01  p2f s-'||s_||' s2-'||s2_||' '||add_months(trunc( DAT_),-k));
				--	logger.info('FIN01  p2f s-'||(s_ - s2_));
						return (s_*100 - s2_*100);

        end if;

	else
			           s_  := nvl(F_GET_FIN_ND(aRNK_, aND_,'RP0', 33, DAT_),0);
					   s2_ := nvl(F_GET_FIN_ND(aRNK_, aND_,'RP0', 33, add_months(trunc( DAT_),-g_period)),0);
					 --  logger.info('FIN01  DRP s-'||s_||' s2-'||s2_||' g_period '||g_period);
					   return (s_-s2_);


	end if;


	  end;


	elsif kod_ = 'KOB' then
	/*
	20.	Коефіцієнт співвідношення тривалості обороту оборотних активів та строку надання кредиту (Коб)
	*/

	begin

	k := kol_m;
		--logger.trace('FIN01  p1='||k);
    if (k) = 15 then


		           if FZ_ = ' ' then

						s_ := ( (fin_nbu.ZN_F1('260',4,add_months(trunc( DAT_),-0))/2)+
						        fin_nbu.ZN_F1('260',4,add_months(trunc( DAT_),-3)) +
								fin_nbu.ZN_F1('260',4,add_months(trunc( DAT_),-6)) +
								fin_nbu.ZN_F1('260',4,add_months(trunc( DAT_),-9)) +
						        (fin_nbu.ZN_F1('260',4,add_months(trunc( DAT_),-12))/2)  ) /4*  365;

						s2_ := fin_nbu.ZN_F2('010',4, DAT_);

				   elsif FZ_ = 'N' then

						s_ := ( ( ( fin_nbu.ZN_F1('1195',4,add_months(trunc( DAT_),-0))-fin_nbu.ZN_F1('1170',4,add_months(trunc( DAT_),-0))   )/2)+
						          ( fin_nbu.ZN_F1('1195',4,add_months(trunc( DAT_),-3))-fin_nbu.ZN_F1('1170',4,add_months(trunc( DAT_),-3))   ) +
								  ( fin_nbu.ZN_F1('1195',4,add_months(trunc( DAT_),-6))-fin_nbu.ZN_F1('1170',4,add_months(trunc( DAT_),-6))   ) +
								  ( fin_nbu.ZN_F1('1195',4,add_months(trunc( DAT_),-9))-fin_nbu.ZN_F1('1170',4,add_months(trunc( DAT_),-9))   ) +
						        ( ( fin_nbu.ZN_F1('1195',4,add_months(trunc( DAT_),-12))-fin_nbu.ZN_F1('1170',4,add_months(trunc( DAT_),-12))   )/2)  ) /4*  365;

						s2_ := fin_nbu.ZN_F2('2000',4, DAT_)+fin_nbu.ZN_F2('2010',4, DAT_);

 				   elsif FZ_ in ('R','C') then
					         s_ :=(((   (fin_nbu.ZN_F1('1195',4,DAT_)                       - fin_nbu.ZN_F1('1170',4,DAT_)) + 
							            (fin_nbu.ZN_F1('1195',4,trunc( (DAT_ - 1) , 'Y' ) ) - fin_nbu.ZN_F1('1170',4,trunc( (DAT_ - 1) , 'Y' ) ))
									  )/2) *  365);
						     s2_ := fin_nbu.ZN_F2('2000',4, DAT_) ;

			       else
					         s_ :=(((fin_nbu.ZN_F1('260',4,DAT_) + fin_nbu.ZN_F1('260',4,trunc( (DAT_ - 1) , 'Y' ) ))/2) *  365);
						     s2_ := fin_nbu.ZN_F2('010',4, DAT_) ;
                   end if;

					--logger.info('FIN01  KOB NKD-'||ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_));

					begin
						 return ((s_/abs(s2_))/(nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0)*30));
			              exception when  ZERO_DIVIDE  then return MIN_MAX_SCOR(tip_kof_, 'KOB', 'MAX');
					end;




    else

		            if FZ_ = ' ' then
					         s_ :=(((fin_nbu.ZN_F1('260',4,DAT_) + fin_nbu.ZN_F1('260',4,add_months(trunc( DAT_),-3)))/2)/4 *  365);
						     s2_ := (fin_nbu.ZN_F2('010',3, DAT_) / to_char( (DAT_ - 1) , 'Q'))*4;
		            elsif FZ_ = 'N' then
					         s_ :=(((   
               							 (fin_nbu.ZN_F1('1195',4,DAT_)-fin_nbu.ZN_F1('1170',4,DAT_)) + 
										 (fin_nbu.ZN_F1('1195',4,add_months(trunc( DAT_),-3))-fin_nbu.ZN_F1('1170',4,add_months(trunc( DAT_),-3)))
    								 )/2)/4 *  365);
						     s2_ := ((fin_nbu.ZN_F2('2000',3, DAT_)+fin_nbu.ZN_F2('2010',3, DAT_)) / to_char( (DAT_ - 1) , 'Q'))*4;
		            elsif FZ_ in ('R','C') then
                             s_ :=(((      (fin_nbu.ZN_F1('1195',4,DAT_)                       - fin_nbu.ZN_F1('1170',4,DAT_))+ 
							               (fin_nbu.ZN_F1('1195',4,trunc( (DAT_ - 1) , 'Y' ) ) - fin_nbu.ZN_F1('1170',4,trunc( (DAT_ - 1) , 'Y' ) ) )
								     )/2) *  365);
                             s2_ := fin_nbu.ZN_F2('2000',4, DAT_) ;
					
 				    else
                             s_ :=(((fin_nbu.ZN_F1('260',4,DAT_) + fin_nbu.ZN_F1('260',4,trunc( (DAT_ - 1) , 'Y' ) ))/2) *  365);
                             s2_ := fin_nbu.ZN_F2('010',4, DAT_) ;
                    end if;
			        --logger.trace('FIN01  p2 s-'||s_||' s2-'||s2_||' '||add_months(trunc( DAT_),-k));

						begin
						 return ((s_/abs(s2_))/(nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0)*30));
			              exception when  ZERO_DIVIDE  then return MIN_MAX_SCOR(tip_kof_, 'KOB', 'MAX');
						end;
    end if;




	end;


	elsif kod_ = 'KPF' then
	/*
     21.	Коефіцієнт покриття фінансових витрат EBIDTA (Кпфв)
	*/

	     if FZ_ = ' ' then

				 if fin_nbu.ZN_FDK('140', DAT_, okpo_) <=0   then

					if (fin_nbu.ZN_FDK('220', DAT_, okpo_) - fin_nbu.ZN_FDK('225', DAT_, okpo_) + fin_nbu.ZN_FDK('140', DAT_, okpo_) + fin_nbu.ZN_FDK('180', DAT_, okpo_) + fin_nbu.ZN_FDK('260', DAT_, okpo_))  > 0 then
					   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MAX');

					 else
					   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MIN');
					end if;

				 else

					 s_ := (fin_nbu.ZN_FDK('220', DAT_, okpo_) - fin_nbu.ZN_FDK('225', DAT_, okpo_) + fin_nbu.ZN_FDK('140', DAT_, okpo_) + fin_nbu.ZN_FDK('180', DAT_, okpo_) + fin_nbu.ZN_FDK('260', DAT_, okpo_))*4 /
							   (fin_nbu.ZN_FDK('140', DAT_, okpo_)*4);
							   

				 end if;
	     
		 elsif FZ_ = 'N' then

				 if fin_nbu.ZN_FDK('2250', DAT_, okpo_) <=0   then

					if (fin_nbu.ZN_FDK('2465', DAT_, okpo_) + fin_nbu.ZN_FDK('2250', DAT_, okpo_) + fin_nbu.ZN_FDK('2300', DAT_, okpo_) + fin_nbu.ZN_FDK('2455', DAT_, okpo_) + fin_nbu.ZN_FDK('2515', DAT_, okpo_))  > 0 then
					   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MAX');

					 else
					   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MIN');
					end if;

				 else

					 s_ := (fin_nbu.ZN_FDK('2465', DAT_, okpo_) + fin_nbu.ZN_FDK('2250', DAT_, okpo_) + fin_nbu.ZN_FDK('2300', DAT_, okpo_) + fin_nbu.ZN_FDK('2455', DAT_, okpo_) + fin_nbu.ZN_FDK('2515', DAT_, okpo_))*4 /
							   (fin_nbu.ZN_FDK('2250', DAT_, okpo_)*4);
							   

				 end if;


		 elsif FZ_ in ('R','C') then

			   
				if nvl((nvl(ZN_P_ND('SK0', 30, DAT_, aND_, aRNK_),0)- nvl((p_icurval(ZN_P_ND('VAL', 30, DAT_, aND_, aRNK_), ZN_P_ND('SUN', 32, DAT_, aND_, aRNK_), sysdate)),0)),0) <=0   then
								 --- !!!! врахувать момент призупинено нарахування відсотків (подали на суд)
						if ((fin_nbu.ZN_F2('2350',4, DAT_, okpo_) + fin_nbu.ZN_F2('2300',4, DAT_, okpo_) -(fin_nbu.ZN_F1('1012',3, DAT_, okpo_)-fin_nbu.ZN_F1('1012',4, DAT_, okpo_)) ) )  > 0 then						   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MAX');
						 else
						   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MIN');
						end if;

					 else

				Begin	  
				 s_ := ((fin_nbu.ZN_F2('2350',4, DAT_, okpo_) + fin_nbu.ZN_F2('2300',4, DAT_, okpo_) -(fin_nbu.ZN_F1('1012',3, DAT_, okpo_)-fin_nbu.ZN_F1('1012',4, DAT_, okpo_))  ) )/
						 ( nvl((p_icurval(ZN_P_ND('VAL', 30, DAT_, aND_, aRNK_), ZN_P_ND('SUN', 32, DAT_, aND_, aRNK_), sysdate)),0)/1000*ZN_P_ND('PRC', 32, DAT_, aND_, aRNK_)/100);
				
				exception when  ZERO_DIVIDE  then s_ :=0;
                end;		
				 
				end if;	
				 
		 else
            
			
				if nvl((nvl(ZN_P_ND('SK0', 30, DAT_, aND_, aRNK_),0)- nvl((p_icurval(ZN_P_ND('VAL', 30, DAT_, aND_, aRNK_), ZN_P_ND('SUN', 32, DAT_, aND_, aRNK_), sysdate)),0)),0) <=0   then
								 --- !!!! врахувать момент призупинено нарахування відсотків (подали на суд)
						if ((fin_nbu.ZN_F2('140',4, DAT_, okpo_) + fin_nbu.ZN_F2('150',4, DAT_, okpo_) +(fin_nbu.ZN_F1('032',3, DAT_, okpo_)-fin_nbu.ZN_F1('032',4, DAT_, okpo_)) + (fin_nbu.ZN_F1('037',3, DAT_, okpo_)-fin_nbu.ZN_F1('037',4, DAT_, okpo_)) ) * nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0) )  > 0 then
						   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MAX');

						 else
						   s_ := MIN_MAX_SCOR(tip_kof_, 'KPF', 'MIN');
						end if;

					 else

				Begin	  
				 s_ := ((fin_nbu.ZN_F2('140',4, DAT_, okpo_) + fin_nbu.ZN_F2('150',4, DAT_, okpo_) +(fin_nbu.ZN_F1('032',3, DAT_, okpo_)-fin_nbu.ZN_F1('032',4, DAT_, okpo_)) + (fin_nbu.ZN_F1('037',3, DAT_, okpo_)-fin_nbu.ZN_F1('037',4, DAT_, okpo_)) ) * nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0)/12 )/
						 (nvl(ZN_P_ND('SK0', 30, DAT_, aND_, aRNK_),0)- nvl((p_icurval(ZN_P_ND('VAL', 30, DAT_, aND_, aRNK_), ZN_P_ND('SUN', 32, DAT_, aND_, aRNK_), sysdate)),0));
				 exception when  ZERO_DIVIDE  then s_ :=0;
                 end; 
				 
				end if;

		 end if;

     return s_;

			elsif kod_ = 'KPZ' then
	/*
22.	Агрегований коефіцієнт покриття довгострокових зобов'язань за кредитом EBIDTA (Кпзк)
	*/

	    if FZ_ = ' ' then

               if fin_nbu.ZN_F1('440',4, DAT_) <=0   then

                if (fin_nbu.ZN_FDK('220', DAT_, okpo_) - fin_nbu.ZN_FDK('225', DAT_, okpo_) + fin_nbu.ZN_FDK('140', DAT_, okpo_) + fin_nbu.ZN_FDK('180', DAT_, okpo_) + fin_nbu.ZN_FDK('260', DAT_, okpo_))  > 0 then
                   s_ := MIN_MAX_SCOR(tip_kof_, 'KPZ', 'MAX');

                 else
                   s_ := 0;
                end if;



             else

                 s_ := (fin_nbu.ZN_FDK('220', DAT_, okpo_) - fin_nbu.ZN_FDK('225', DAT_, okpo_) + fin_nbu.ZN_FDK('140', DAT_, okpo_) + fin_nbu.ZN_FDK('180', DAT_, okpo_) + fin_nbu.ZN_FDK('260', DAT_, okpo_)) *4*(nvl(ZN_P_ND('NKO', 32, DAT_, aND_, aRNK_),0)/12)  /
                           fin_nbu.ZN_F1('440',4, DAT_);

             end if;

	    elsif FZ_ = 'N' then

               if fin_nbu.ZN_F1('1510',4, DAT_) <=0   then

                if (fin_nbu.ZN_FDK('2465', DAT_, okpo_) + fin_nbu.ZN_FDK('2250', DAT_, okpo_) + fin_nbu.ZN_FDK('2300', DAT_, okpo_) + fin_nbu.ZN_FDK('2455', DAT_, okpo_) + fin_nbu.ZN_FDK('2515', DAT_, okpo_))  > 0 then
                   s_ := MIN_MAX_SCOR(tip_kof_, 'KPZ', 'MAX');

                 else
                   s_ := 0;
                end if;



             else

                 s_ := (fin_nbu.ZN_FDK('2465', DAT_, okpo_) + fin_nbu.ZN_FDK('2250', DAT_, okpo_) + fin_nbu.ZN_FDK('2300', DAT_, okpo_) + fin_nbu.ZN_FDK('2455', DAT_, okpo_) + fin_nbu.ZN_FDK('2515', DAT_, okpo_)) *4*(nvl(ZN_P_ND('NKO', 32, DAT_, aND_, aRNK_),0)/12)  /
                           fin_nbu.ZN_F1('1510',4, DAT_);

             end if;

         elsif FZ_ in ('R','C') then
                 if fin_nbu.ZN_F1('1595',4, DAT_) <=0   then

                        if ((fin_nbu.ZN_F2('2350',4, DAT_, okpo_) + fin_nbu.ZN_F2('2300',4, DAT_, okpo_) -(fin_nbu.ZN_F1('1012',3, DAT_, okpo_)-fin_nbu.ZN_F1('1012',4, DAT_, okpo_)) )  )  > 0 then
                           s_ := MIN_MAX_SCOR(tip_kof_, 'KPZ', 'MAX');

                         else
                           s_ := 0;
                        end if;
                else
                         s_ := ((fin_nbu.ZN_F2('2350',4, DAT_, okpo_) + fin_nbu.ZN_F2('2300',4, DAT_, okpo_) -(fin_nbu.ZN_F1('1012',3, DAT_, okpo_)-fin_nbu.ZN_F1('1012',4, DAT_, okpo_))  )  )* (nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0)/12)/
                                  fin_nbu.ZN_F1('1595',4, DAT_);
                 end if;


        			 
			 
         else
                 if fin_nbu.ZN_F1('480',4, DAT_) <=0   then

                        if ((fin_nbu.ZN_F2('140',4, DAT_, okpo_) + fin_nbu.ZN_F2('150',4, DAT_, okpo_) +(fin_nbu.ZN_F1('032',3, DAT_, okpo_)-fin_nbu.ZN_F1('032',4, DAT_, okpo_)) + (fin_nbu.ZN_F1('037',3, DAT_, okpo_)-fin_nbu.ZN_F1('037',4, DAT_, okpo_)) ) * nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0) )  > 0 then
                           s_ := MIN_MAX_SCOR(tip_kof_, 'KPZ', 'MAX');

                         else
                           s_ := 0;
                        end if;
                else
                         s_ := ((fin_nbu.ZN_F2('140',4, DAT_, okpo_) + fin_nbu.ZN_F2('150',4, DAT_, okpo_) +(fin_nbu.ZN_F1('032',3, DAT_, okpo_)-fin_nbu.ZN_F1('032',4, DAT_, okpo_)) + (fin_nbu.ZN_F1('037',3, DAT_, okpo_)-fin_nbu.ZN_F1('037',4, DAT_, okpo_)) ) * nvl(ZN_P_ND('NKD', 30, DAT_, aND_, aRNK_),0)/12 )/
                                  fin_nbu.ZN_F1('480',4, DAT_);
                 end if;


         end if;

         return s_;

		elsif kod_ = 'KPK' then
	/*
23.	Коефіцієнт покриття кредитів банків чистим доходом (Кпкчд)
	*/

	 if FZ_ = ' ' then
	     s_  :=   fin_nbu.ZN_F2('035',3, DAT_, okpo_);
		 s2_ :=   fin_nbu.ZN_F1('440',4, DAT_) + fin_nbu.ZN_F1('500',4, DAT_);

	       if  s2_ = 0 and s_ >  0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MAX');
		elsif  s2_ = 0 and s_ <= 0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MIN');
		end if;

	 elsif FZ_ = 'N' then
	     s_  :=   fin_nbu.ZN_F2('2000',3, DAT_, okpo_)+fin_nbu.ZN_FDK('2010', DAT_, okpo_);
		 s2_ :=   fin_nbu.ZN_F1('1510',4, DAT_) + fin_nbu.ZN_F1('1600',4, DAT_);

	       if  s2_ = 0 and s_ >  0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MAX');
		elsif  s2_ = 0 and s_ <= 0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MIN');
		end if;

	 elsif FZ_ in ('R','C') then
	     s_  :=   fin_nbu.ZN_F2('2000',3, DAT_, okpo_);
		 s2_ :=   fin_nbu.ZN_F1('1595',4, DAT_, okpo_) + fin_nbu.ZN_F1('1600',4, DAT_, okpo_);

		--logger.info(s_);
		--logger.info(s2_);
		
		  
	       if  s2_ = 0 and s_ >  0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MAX');
		elsif  s2_ = 0 and s_ <= 0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MIN');
		end if;


	else

	     s_  :=   fin_nbu.ZN_F2('030',3, DAT_, okpo_);
		 s2_ :=   fin_nbu.ZN_F1('480',4, DAT_) + fin_nbu.ZN_F1('500',4, DAT_);

		   if  s2_ = 0 and s_ >  0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MAX');
		elsif  s2_ = 0 and s_ <= 0 then  return  MIN_MAX_SCOR(tip_kof_, 'KPK', 'MIN');
		end if;

	end if;

	 return s_/s2_;



    elsif kod_ = 'ZK0' then
	/*
25.	якість забезпечення кредиту (ЗК)   ZK0
	*/
		Begin

        select sum(abs(sump_e)) 
		  into s_ 
		  from V_FIN_OBU_PAWN 
		 where  rnk = aRNK_ 
		   and nd = aND_ 
		   and pawn != 34;
		 exception when NO_DATA_FOUND THEN s_ := 0;
	    END;

        begin
		s2_ := round((nvl(s_,0) *100 / nvl(ZN_P_ND('SK0', 30, DAT_, aND_, aRNK_),0)) ,2);
		exception when  ZERO_DIVIDE  then s2_ :=0;
		end;

		return s2_;

 elsif kod_ = 'ZVB' then
	/*
37.	Коефіцієнт співвідношення суми заборгованості (наданих зобов’язань) за основною сумою боргу перед Банком та валюти балансу (ЗВб)
	*/
     if FZ_ = 'N' then
	 
	         if fin_nbu.ZN_F1('1900',4, DAT_, okpo_) < (fin_nbu.ZN_F1('1595',4, DAT_, okpo_)+fin_nbu.ZN_F1('1600',4, DAT_, okpo_)+fin_nbu.ZN_F1('1610',4, DAT_, okpo_))
			 then        s_ := 0;
             else 	     s_ := abs(fin_nbu.ZN_F1('1900',4, DAT_, okpo_) - nvl(ZN_P_ND('BZB', 32, DAT_, aND_, aRNK_),0)/1000);
		     end if;
	 
	     
     ElsIf FZ_ in ('R','C') then
	 
	         if fin_nbu.ZN_F1('1900',4, DAT_, okpo_) < (fin_nbu.ZN_F1('1595',4, DAT_, okpo_)+fin_nbu.ZN_F1('1600',4, DAT_, okpo_)+fin_nbu.ZN_F1('1610',4, DAT_, okpo_))
			 then s_ := 0;
             else s_ := abs(fin_nbu.ZN_F1('1900',4, DAT_, okpo_) - nvl(ZN_P_ND('BZB', 32, DAT_, aND_, aRNK_),0)/1000);
			     --logger.info( 'ZVB '||   fin_nbu.ZN_F1('1900',4, DAT_, okpo_) ||'   '|| nvl(ZN_P_ND('BZB', 32, DAT_, aND_, aRNK_),0)  );
		     end if;
     
	 ELSE
	 
    	    s_ := abs(fin_nbu.ZN_F1('640',4, DAT_, okpo_) - nvl(ZN_P_ND('BZB', 32, DAT_, aND_, aRNK_),0)/1000);

	 END IF;
	 
	    if s_ != 0 then
	        --logger.info( 'ZVB '||  nvl(ZN_P_ND('ZB0', 32, DAT_, aND_, aRNK_),0) );
		   return (nvl(ZN_P_ND('ZB0', 32, DAT_, aND_, aRNK_),0)/1000)/s_;
	     else return 1.01;
		end if;

 elsif kod_ = 'ZCD' then
	/*
Коефіцієнт співвідношення суми чистого доходу та суми зобов’язань за основною сумою боргу перед Банком (ЗЧд)
	*/
	if nvl(ZN_P_ND('ZB0', 32, DAT_, aND_, aRNK_),0) != 0 then

    	If FZ_ = 'N' then
			 return ((fin_nbu.ZN_F2('2000',4, DAT_, okpo_)+fin_nbu.ZN_F2('2010',4, DAT_, okpo_))/12* nvl(ZN_P_ND('NKO', 32, DAT_, aND_, aRNK_),0))/(nvl(ZN_P_ND('ZB0', 32, DAT_, aND_, aRNK_),0)/1000);
		ElsIf FZ_ in ('R','C') then
		     --logger.info (  fin_nbu.ZN_F2('2000',4, DAT_, okpo_) ||' '|| nvl(ZN_P_ND('NKO', 32, DAT_, aND_, aRNK_),0)||' '||  nvl(ZN_P_ND('ZB0', 32, DAT_, aND_, aRNK_),0));
			 return ((fin_nbu.ZN_F2('2000',4, DAT_, okpo_))/12* nvl(ZN_P_ND('NKO', 32, DAT_, aND_, aRNK_),0))/(nvl(ZN_P_ND('ZB0', 32, DAT_, aND_, aRNK_),0)/1000);
			 
		Else
			 return (fin_nbu.ZN_F2('030',4, DAT_, okpo_)/12* nvl(ZN_P_ND('NKO', 32, DAT_, aND_, aRNK_),0))/(nvl(ZN_P_ND('ZB0', 32, DAT_, aND_, aRNK_),0)/1000);
		end if;	
	
	else return 1.2;
	end if;

 elsif 	kod_ = 'ZPB_max' then     -- Контроль на максимальну суму по Заборгованість перед Банком за основною сумою боргу, яка обліковується на балансі позичальника станом на звітну дату (БЗб
	
	if FZ_ = ' ' then
	--Max  не повинна перевищувати суму за рядками балансу 500+440 на відповідну звітну дату (Заборгованість перед банком)
	      return (fin_nbu.ZN_F1('500',4,dat_, okpo_)+fin_nbu.ZN_F1('440',4,dat_, okpo_));
	elsif FZ_ = 'N' then
	--Max  не повинна перевищувати суму за рядками балансу 1600+1510 на відповідну звітну дату (Заборгованість перед банком)
	      return (fin_nbu.ZN_F1('1600',4,dat_, okpo_)+fin_nbu.ZN_F1('1510',4,dat_, okpo_) + 
		          fin_nbu.ZN_F1('1605',4,dat_, okpo_)+fin_nbu.ZN_F1('1515',4,dat_, okpo_) + fin_nbu.ZN_F1('1610',4,dat_, okpo_));	  
	elsif FZ_ in ('R','C') then
	--Max  не повинна перевищувати суму за рядками балансу 1600+1510 на відповідну звітну дату (Заборгованість перед банком)
	      return (fin_nbu.ZN_F1('1600',4,dat_, okpo_)+fin_nbu.ZN_F1('1595',4,dat_, okpo_) + 
		          fin_nbu.ZN_F1('1610',4,dat_, okpo_));	  			  
	else  
	--Необхідно зробити контроль на заповнення Бзб по малим формам не як 500+440, а 500+480.
	      return (fin_nbu.ZN_F1('500',4,dat_, okpo_)+fin_nbu.ZN_F1('480',4,dat_, okpo_));
	end if;
	
	

-- http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4025?filter=11830
 elsif 	kod_ = 'FP1' then  --Зниження виручки більше ніж на 50%
     case 
	   when ZN_P_ND ('KP3', 5,dat_, nd_, rnk_) = 2 then return 1;
	   when (fin_nbu.ZN_FDK('2000', add_months(trunc(DAT_),-12), okpo_) = 0 and fin_nbu.ZN_FDK('2000', trunc(DAT_), okpo_) > 0) 
             or fin_nbu.ZN_FDK('2000', add_months(trunc(DAT_),-12), okpo_) = 0	          then return 2;
	   when fin_nbu.ZN_FDK('2000', DAT_, okpo_) / fin_nbu.ZN_FDK('2000', add_months(trunc(DAT_),-12), okpo_)< 0.5
	         and  g_kol_dely> 7                then return 1;
	   else                                         return 2;
	 end case;
	
	
	
 elsif 	kod_ = 'FP2' then  --Зниження  показників чистих активів більше ніж на 50%
     case 
	   when ZN_P_ND ('KP3', 5) = 2 then return 1;
	   when (fin_nbu.ZN_F1('1495',4, add_months(trunc(DAT_),-12), okpo_) = 0 and fin_nbu.ZN_F1('1495',4, DAT_, okpo_) >0) 
            or  fin_nbu.ZN_F1('1495',4, add_months(trunc(DAT_),-12), okpo_) = 0 	   then return 2;
	   when fin_nbu.ZN_F1('1495',4, DAT_, okpo_) <= 0  and  g_kol_dely> 7                then return 1;
	   when  --fin_nbu.ZN_F1('1495',4, DAT_, okpo_) / fin_nbu.ZN_F1('1495',4, add_months(trunc(DAT_),-12), okpo_)< 0.5
	         (fin_nbu.ZN_F1('1495',4, add_months(trunc(DAT_),-12), okpo_) -fin_nbu.ZN_F1('1495',4, DAT_, okpo_)) / fin_nbu.ZN_F1('1495',4, add_months(trunc(DAT_),-12), okpo_)< 0.5 
	         and  g_kol_dely> 7                                                          then return 1;
	   else                                         return 2;
	 end case;	 
	
	
	
 elsif 	kod_ = 'FP3' then  --Зниження  VNKR
      Begin 
	   select num
	     into l_t 
		 from ( SELECT row_number() over(ORDER BY ord) num,  code, ord
		          FROM CCK_RATING)
		         where code =  GET_VNKR(DAT_, aRNK_,  aND_);
         exception when no_data_found then l_t := null;
	end;				 
	Begin
       select num
	     into l_t1
		 from ( SELECT row_number() over(ORDER BY ord) num,  code, ord
		          FROM CCK_RATING)
		         where code = GET_VNKR(add_months(DAT_,- g_period), aRNK_,  aND_); 
      exception when no_data_found then l_t1 := null;
	end;
	  --,cck_app.Get_ND_TXT_ex( ND_, 'VNCRR', add_months(sysdate-3));
  case 
    when ZN_P_ND ('KP3', 5) = 2 then return 1;
    when l_t1-l_t > 2 and  g_kol_dely> 7  then return 1;
	when l_t > 7      and  g_kol_dely> 7  then return 1;
	else                                       return 2;
  end case;
	
	
	
 elsif 	kod_ = 'FP4' then  --Зниження  VNKR
     Begin
       select num
	     into l_t 
		 from ( SELECT row_number() over(ORDER BY ord) num,  code, ord
		          FROM CCK_RATING)
		         where code =  GET_VNKR(DAT_, aRNK_,  aND_);
      exception when no_data_found then l_t := null;
	end;				 
	Begin
       select num
	     into l_t1
		 from ( SELECT row_number() over(ORDER BY ord) num,  code, ord
		          FROM CCK_RATING)
		         where code =  cck_app.Get_ND_TXT_ex( aND_, 'VNCRP');
      exception when no_data_found then l_t1 := null;
	end;				 
  case 
    when l_t-l_t1 > 3 and l_t > 7   then return 1;
	else                                 return 2;
  end case;	
  
  
 elsif 	kod_ = 'FP5' then  --Зниження  VNKR
     Begin
       select num
	     into l_t 
		 from ( SELECT row_number() over(ORDER BY ord) num,  code, ord
		          FROM CCK_RATING)
		         where code =  GET_VNKR(DAT_, aRNK_,  aND_);
      exception when no_data_found then l_t := null;
	end;	
 
  case 
 	when l_t > 9                    then return 1;
	else                                 return 2;
  end case;	  

    else  return null;
  end if;





    return null;
  end calc_pok;


   PROCEDURE GET_POK (   RNK_ number,
                         ND_ number,
					     DAT_ date)
					   IS
	sTmp  number;
	okpo_ number;
	dat1_ date := trunc(dat_);
	dat2_ date :=add_months(trunc(DAT_),-3);
	dat3_ date :=add_months(trunc(DAT_),-6);
	
	p_vidd number;  -- від КД
	p_980 number;   -- % ставка 980 
	p_840 number;   -- % ставка 840
	p_978 number;   -- % ставка 978
	
	BEGIN

				  begin
					select okpo
					  into okpo_
					  from fin_customer
					 where rnk = rnk_;
					 exception when NO_DATA_FOUND THEN okpo_ := 0;
				  END;


	aND_   := ND_;
	aRNK_  := RNK_;
	aOKPO_ := okpo_;
    
    	
	
	
	init1(okpo_, DAT_);
	
	/*
	1.	Коефіцієнт миттєвої ліквідності (КЛ1)
	*/
/*	record_fp_ND(KOD_ => 'KL1',
                 S_   => CALC_POK ('KL1', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KL1',
                 S_   => CALC_POK ('KL1', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);
				 */
	record_fp_ND(KOD_ => 'KL1',
                 S_   => CALC_POK ('KL1', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

		/*
	2.	Коефіцієнт поточної ліквідності (КЛ2)
	*/
/*	record_fp_ND(KOD_ => 'KL2',
                 S_   => CALC_POK ('KL2', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KL2',
                 S_   => CALC_POK ('KL2', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
	record_fp_ND(KOD_ => 'KL2',
                 S_   => CALC_POK ('KL2', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

    /*
	3.	Коефіцієнт загальної ліквідності (коефіцієнт покриття) (КП)
	*/
/*	record_fp_ND(KOD_ => 'KP0',
                 S_   => CALC_POK ('KP0', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KP0',
                 S_   => CALC_POK ('KP0', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
	record_fp_ND(KOD_ => 'KP0',
                 S_   => CALC_POK ('KP0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);


	   /*
		4.	Коефіцієнт співвідношення ліквідних та необоротних активів (Ка)
	*/
/*	record_fp_ND(KOD_ => 'KA0',
                 S_   => CALC_POK ('KA0', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KA0',
                 S_   => CALC_POK ('KA0', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
	record_fp_ND(KOD_ => 'KA0',
	             S_   => CALC_POK ('KA0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	   /*
      5.	Коефіцієнт незалежності (КН)
	*/
/*	record_fp_ND(KOD_ => 'KN0',
                 S_   => CALC_POK ('KN0', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KN0',
                 S_   => CALC_POK ('KN0', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'KN0',
	             S_   => CALC_POK ('KN0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

		   /*
     6.	Коефіцієнт маневреності власних коштів (КМ)
	*/
/*	record_fp_ND(KOD_ => 'KM0',
                 S_   => CALC_POK ('KM0', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KM0',
                 S_   => CALC_POK ('KM0', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'KM0',
	             S_   => CALC_POK ('KM0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	/*
     7.	Коефіцієнт забезпечення власними оборотними засобами (Кзв
	*/
/*	record_fp_ND(KOD_ => 'KZV',
                 S_   => CALC_POK ('KZV', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KZV',
                 S_   => CALC_POK ('KZV', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'KZV',
	             S_   => CALC_POK ('KZV', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

		/*
     8.	Коефіцієнт забезпечення необоротних активів власним капіталом та довгостроковими пасивами (Кдп)
	*/
/*	record_fp_ND(KOD_ => 'KDP',
                 S_   => CALC_POK ('KDP', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KDP',
                 S_   => CALC_POK ('KDP', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'KDP',
	             S_   => CALC_POK ('KDP', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);


			/*
    9.	Динаміка виручки від реалізації продукції (товарів, робіт, послуг) (ДВ)
	*/


	record_fp_ND(KOD_ => 'DV0',
	             S_   => CALC_POK ('DV0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	--NSM
	record_fp_ND(KOD_ => 'NSM',
	             S_   => CALC_POK ('NSM', dat1_, okpo_),
                 IDF_ => 30,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	--ZM0
	record_fp_ND(KOD_ => 'ZM0',
	             S_   => CALC_POK ('ZM0', dat1_, okpo_),
                 IDF_ => 30,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	--NKD

	record_fp_ND(KOD_ => 'NKD',
	             S_   => CALC_POK ('NKD', dat1_, okpo_),
                 IDF_ => 30,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);


    /*
	TDP   термін створення підприемства
	*/

		record_fp_ND(KOD_ => 'TDP',
	             S_   => CALC_POK ('TDP', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	/*
	Кількість місяців  КД  KKD
	*/


		record_fp_ND(KOD_ => 'KKD',
	             S_   => CALC_POK ('KKD', dat1_, okpo_),
                 IDF_ => 30,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



	-- SK0
		record_fp_ND(KOD_ => 'SK0',
	             S_   => CALC_POK ('SK0', dat1_, okpo_),
                 IDF_ => 30,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);


 /*
 10.	Показник грошового потоку (Кгп)
 */

	record_fp_ND(KOD_ => 'KGP',
	             S_   => CALC_POK ('KGP', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



 /*
 11.	Коефіцієнт співвідношення дебіторської та кредиторської заборгованості (Ксп)
 */


 /* 	    record_fp_ND(KOD_ => 'KSP',
                 S_   => CALC_POK ('KSP', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
		 record_fp_ND(KOD_ => 'KSP',
                 S_   => CALC_POK ('KSP', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
		record_fp_ND(KOD_ => 'KSP',
	             S_   => CALC_POK ('KSP', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



 /*
12.	Динаміка дебіторської заборгованості (ДД)
 */

 /*   record_fp_ND(KOD_ => 'DD0',
                 S_   => CALC_POK ('DD0', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'DD0',
	             S_   => CALC_POK ('DD0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



 /*
13.	Динаміка кредиторської заборгованості (ДК)
 */


 /*   record_fp_ND(KOD_ => 'DK0',
                 S_   => CALC_POK ('DK0', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
	record_fp_ND(KOD_ => 'DK0',
	             S_   => CALC_POK ('DK0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);




		 /*
14.	Діяльність звітного періоду (Дзп)
	*/

 /* 	record_fp_ND(KOD_ => 'DZP',
                 S_   => CALC_POK ('DZP', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
   record_fp_ND(KOD_ => 'DZP',
                 S_   => CALC_POK ('DZP', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
	record_fp_ND(KOD_ => 'DZP',
	             S_   => CALC_POK ('DZP', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



 /*
15.	Коефіцієнт співвідношення заборгованості за кредитами та власного (акціонерного) капіталу (Гіринг).
 */


 /*	record_fp_ND(KOD_ => 'G00',
                 S_   => CALC_POK ('G00', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'G00',
                 S_   => CALC_POK ('G00', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'G00',
	             S_   => CALC_POK ('G00', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



		 /*
16.	Рентабельність продажу (Рп)
	*/
/*    record_fp_ND(KOD_ => 'RP0',
                 S_   => CALC_POK ('RP0', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'RP0',
                 S_   => CALC_POK ('RP0', add_months(trunc(DAT1_),-g_period), okpo_),
                 IDF_ => 33,
				 DAT_ => add_months(trunc(DAT1_),-g_period),
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'RP0',
	             S_   => CALC_POK ('RP0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



		 /*
17.	Рентабельність активів (Ра)
	*/

 	record_fp_ND(KOD_ => 'PA0',
                 S_   => CALC_POK ('PA0', add_months(trunc(DAT1_),-g_period), okpo_),
                 IDF_ => 33,
				 DAT_ => add_months(trunc(DAT1_),-g_period),
				 ND_  => ND_,
                 RNK_ => RNK_); 
	record_fp_ND(KOD_ => 'PA0',
	             S_   => CALC_POK ('PA0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);





		 /*
18.	Динаміка рентабельності активів (Да)    DA0
	*/

	record_fp_ND(KOD_ => 'DA0',
	             S_   => CALC_POK ('DA0', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);


		 /*
19.	Динаміка рентабельності продажу (Дп)   DRP
	*/
 /*	record_fp_ND(KOD_ => 'DRP',
                 S_   => CALC_POK ('DRP', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
	record_fp_ND(KOD_ => 'DRP',
	             S_   => CALC_POK ('DRP', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



	/*
	20.	Коефіцієнт співвідношення тривалості обороту оборотних активів та строку надання кредиту (Коб)  KOB
	*/



	record_fp_ND(KOD_ => 'KOB',
	             S_   => CALC_POK ('KOB', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);





	/*
     21.	Коефіцієнт покриття фінансових витрат EBIDTA (Кпфв)
	*/

 /*   record_fp_ND(KOD_ => 'KPF',
                 S_   => CALC_POK ('KPF', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KPF',
                 S_   => CALC_POK ('KPF', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_); */
	record_fp_ND(KOD_ => 'KPF',
	             S_   => CALC_POK ('KPF', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



	/*
22.	Агрегований коефіцієнт покриття довгострокових зобов'язань за кредитом EBIDTA (Кпзк)
	*/

/*	record_fp_ND(KOD_ => 'KPZ',
                 S_   => CALC_POK ('KPZ', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KPZ',
                 S_   => CALC_POK ('KPZ', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'KPZ',
	             S_   => CALC_POK ('KPZ', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);


	/*
23.	Коефіцієнт покриття кредитів банків чистим доходом (Кпкчд)     KPK
	*/

/*	record_fp_ND(KOD_ => 'KPK',
                 S_   => CALC_POK ('KPK', dat3_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT3_,
				 ND_  => ND_,
                 RNK_ => RNK_);
	record_fp_ND(KOD_ => 'KPK',
                 S_   => CALC_POK ('KPK', dat2_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT2_,
				 ND_  => ND_,
                 RNK_ => RNK_);*/
	record_fp_ND(KOD_ => 'KPK',
	             S_   => CALC_POK ('KPK', dat1_, okpo_),
                 IDF_ => 33,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	/*
25.	якість забезпечення кредиту (ЗК)   ZK0
	*/
	record_fp_ND(KOD_ => 'ZK0',
	             S_   => CALC_POK ('ZK0', dat1_, okpo_),
                 IDF_ => 35,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

	record_fp_ND(KOD_ => 'YZK',  -- Сума балів оцінки кредитного ризикуку
	             S_   => CALC_SCOR_BAL ('ZK0', 35,  DAT1_, RNK_,  ND_ ),
				 IDF_ => 35,
				 DAT_ => DAT1_,
				 ND_  => ND_,
				 RNK_ => RNK_);



	/*
37.	Коефіцієнт співвідношення суми заборгованості (наданих зобов’язань) за основною сумою боргу перед Банком та валюти балансу (ЗВб)   ZVB
	*/
	 record_fp_ND(KOD_ => 'ZVB',
	             S_   => CALC_POK ('ZVB', dat1_, okpo_),
                 IDF_ => 32,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);



	/*
Коефіцієнт співвідношення суми чистого доходу та суми зобов’язань за основною сумою боргу перед Банком (ЗЧд)   ZCD
	*/
	record_fp_ND(KOD_ => 'ZCD',
	             S_   => CALC_POK ('ZCD', dat1_, okpo_),
                 IDF_ => 32,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);

				 
/*
відсоткові ставки по договрах
    p_vidd number;  -- від КД
	p_980 number;   -- % ставка 980 
	p_840 number;   -- % ставка 840
	p_978 number;   -- % ставка 978
*/
	begin
      select  c.vidd,
             max(acrN.FPROCN (decode(a.tip,'SS ',decode(a.kv,980,a.ACC, null), null), 0, '')) as p980,  
             max(acrN.FPROCN (decode(a.tip,'SS ',decode(a.kv,840,a.ACC, null), null), 0, '')) as p840,
             max(acrN.FPROCN (decode(a.tip,'SS ',decode(a.kv,978,a.ACC, null), null), 0, '')) as p978  
      into  p_vidd, p_980, p_840, p_978
        from cc_deal c, nd_acc nd, accounts a 
       where c.nd = ND_
         and  c.nd = nd.nd    
         and nd.acc = a.acc
         and a.tip in( 'SS ', 'LIM')
         group by c.vidd;
		 
		 record_fp_ND(KOD_ => 980,
	                  S_   => p_980,
                      IDF_ => 32,
				      DAT_ => DAT1_,
				      ND_  => ND_,
                      RNK_ => RNK_);
		 record_fp_ND(KOD_ => 840,
	                  S_   => p_840,
                      IDF_ => 32,
				      DAT_ => DAT1_,
				      ND_  => ND_,
                      RNK_ => RNK_);
		 record_fp_ND(KOD_ => 978,
	                  S_   => p_978,
                      IDF_ => 32,
				      DAT_ => DAT1_,
				      ND_  => ND_,
                      RNK_ => RNK_);					  
		 
		  exception when NO_DATA_FOUND  then
		
	record_fp_ND(KOD_ => F_GET_FIN_ND(rnk_, nd_, 'VAL', 30, dat_),
	             S_   => F_GET_FIN_ND(rnk_, nd_, 'PRC', 32, dat_),
                 IDF_ => 32,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);		
		  
	end;
/*
	--Розрахунок Факторів потенційної проблемності
	--розрахуємо кількість днів прострочки
	days_of_delay(nd_);
   --  Зниження виручки більше ніж на 50%
	record_fp_ND(KOD_ => 'FP1',
	             S_   => CALC_POK ('FP1', dat1_, okpo_),
                 IDF_ => 32,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);
 --  Зниження показників чистих активів
	record_fp_ND(KOD_ => 'FP2',
	             S_   => CALC_POK ('FP2', dat1_, okpo_),
                 IDF_ => 32,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);
  -- зниження внутрішнього кредитного рейтингу
	record_fp_ND(KOD_ => 'FP3',
	             S_   => CALC_POK ('FP3', dat1_, okpo_),
                 IDF_ => 32,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);
  -- падіння внутрішнього кредитного рейтингу
	record_fp_ND(KOD_ => 'FP4',
	             S_   => CALC_POK ('FP4', dat1_, okpo_),
                 IDF_ => 32,
				 DAT_ => DAT1_,
				 ND_  => ND_,
                 RNK_ => RNK_);				 */
				 
	null;
	END GET_POK;



  FUNCTION GET_Summ_SK (
						p_sum number ,
						p_pr    number,
						date_v date,
						date_z date,
                        graf number default 0) --0 рівними частинами, 1-- антуітет
						                     RETURN number IS

sum_z number :=0;     -- залишок
sum_  number :=0;     -- щомісячна сума
sum_p number :=0;     -- щомісячна%
sum_pl_o  number :=0; --  сума основного боргу
sum_pl_p  number :=0; -- сума відсотків
dat_ date;
dat2_ date;
k_ number :=0;
i_ number :=0;
pr_m    number := 0;


begin

k_ := MONTHS_BETWEEN( date_z, date_v);

if k_ = 0 then
raise_application_error(-(20000),'\ ' ||'     Не вірно заповнено дату видачі і дату закриття угоди ',TRUE);
end if;
--DBMS_OUTPUT.put_line('Кількість місяців - '||k_);

if graf = 0 then    -- звичайний рівними частинами залишок

dat_ := date_v;
sum_z := p_sum;
sum_ := round(sum_z/k_,2);

while  dat_ <  date_z loop

dat2_ := LEAST (add_months(trunc(DAT_),+1),date_z) ;
k_ :=  dat2_ - dat_;

		 begin
			 sum_p:= round(sum_z*p_pr/100/365*k_ , 2);
		 exception when  ZERO_DIVIDE  then sum_p :=0;
		 end;

sum_ := LEAST(sum_,(p_sum-sum_pl_o));
sum_pl_o := sum_pl_o + sum_;    -- сума основного боргу що сплачується з накопиченням
sum_pl_p := sum_pl_p + sum_p;   -- сума відсотків що сплдачується  з накопиченням

sum_z := sum_z - sum_;
dat_ := dat2_;

end loop;
return round((sum_pl_o+sum_pl_p),2);

else                -- антуітетний
pr_m := p_pr/12/100;

i_ := (pr_m *  POWER((pr_m+1),k_)    ) / (POWER((pr_m+1),k_)-1);
sum_ := p_sum*i_;       -- щомісячна сума

sum_pl_o := sum_* k_;   -- сума за весь період
return round(sum_pl_o,2);

end if;

end;


 PROCEDURE GET_SUBPOK (RNK_ number,
                       ND_ number,
					   DAT_ in date)
	is

	okpo_ number;
	datea_ date;
	ip1_ number;
	v_ip1_ number;

	T_diy_ number; -- Строк функціонування підприємства
	v_ip2  number;

	l_       number;
	l_coun_  number;

	k_ved_  number;

	begin
null;
		begin
		select okpo, datea
   		into okpo_, datea_
		from fin_customer
		where rnk = rnk_;
		  exception when NO_DATA_FOUND THEN
					     raise_application_error(-(20000),'\ ' ||'     Не знайдено клієнта з RNK - '||rnk_,TRUE);

		 END;


null;

end get_subpok;

PROCEDURE GET_calc_print (RNK_ number,
                          ND_ number,
					      DAT_ in date,
						  Tip_v_ number,
					      VNKR_ varchar2)
	is
cc_deal_ cc_deal%rowtype;
begin

  begin
     select * 
       into cc_deal_
       from cc_deal
      where rnk = Rnk_
        and nd  = Nd_;   
  EXCEPTION WHEN no_data_found  THEN return;
  End;


 
           Begin
                INSERT INTO FIN_CALCULATIONS (RNK,
                                              ND,
                                              DAT,
                                              FDAT,
                                              DATD,
                                              FIN23,
                                              OBS23,
                                              KAT23,
                                              K23,
                                              VED,
                                              tip_v,
                                              DAT_NEXT,
											  VNKR)
                                      VALUES (Rnk_,
                                              Nd_,
                                              Dat_,
                                              gl.bd,
                                              SYSDATE,
                                              cc_deal_.fin23,
                                              nvl(cc_deal_.obs23, fin_OBU.ZN_P_ND('OBS', 6, DAT_, ND_, RNK_) ),
                                              cc_deal_.kat23,
                                              cc_deal_.k23,
                                              fin_nbu.GET_KVED(Rnk_,Dat_),
                                              tip_v_,
                                              NULL,
											  VNKR_);    
                 
            EXCEPTION WHEN DUP_VAL_ON_INDEX  THEN 
            
                            Update FIN_CALCULATIONS
                               set DATD     = sysdate,
							       FIN23    = cc_deal_.fin23,
                                   OBS23    = nvl(cc_deal_.obs23, fin_OBU.ZN_P_ND('OBS', 6, DAT_, ND_, RNK_) ),
                                   KAT23    = cc_deal_.kat23,
                                   K23      = cc_deal_.k23,
                                   VED      = fin_nbu.GET_KVED(Rnk_,Dat_),
                                   tip_v = tip_v_,
                                   DAT_NEXT = null,
								   VNKR = VNKR_
                             where rnk = Rnk_
                               and nd =  Nd_
                               and dat = Dat_
                               and fdat = gl.bd;   

           End;
end GET_calc_print;



FUNCTION p_zvt ( RNK_ NUMBER, 
                 DAT_  date 
				)
                    RETURN number IS
p_okpo varchar2(12);
BEGIN

		begin
		select okpo
		  into p_okpo
		  from fin_customer
		  where rnk = rnk_;
		 exception
			when others then
		  return 3;
		end;  

init1(p_okpo,dat_);

return g_period;

END p_zvt;

   PROCEDURE init1(OKPO_ NUMBER, DAT_ date)
   IS
   FZ_        varchar2(1);
   kol_fz_    number;
   kol_fz2_   number;
   kol_fz3_   number;
   BEGIN
   FZ_    := fin_nbu.F_FM (OKPO_, DAT_ ) ;
   if (FZ_ = 'M' or FZ_ in ('R','C') or  length(OKPO_) = 12 ) then

            select count(*)
			  into kol_fz_            -- наявність різних форм
			from fin_fm
			where okpo =  OKPO_
			   and fdat between  add_months(trunc( DAT_),-12) and DAT_;
			   --and Fm  in ( FZ_, decode(FZ_,'M','R','R','M')) ;
			   
			  select count(*)
			  into kol_fz2_            -- наявність піврічних форм
			from fin_fm
			where okpo =  OKPO_
			   and fdat in (dat_, add_months(trunc( DAT_),-6), add_months(trunc( DAT_),-12))   ;
			   --and Fm  in ( FZ_, decode(FZ_,'M','R','R','M')) ;

            select count(*)
			  into kol_fz3_            -- наявність річних форм
			from fin_fm
			where okpo =  OKPO_
			   and fdat in (dat_, add_months(trunc( DAT_),-12), add_months(trunc( DAT_),-24)) ;  
			   --and Fm  in ( FZ_, decode(FZ_,'M','R','R','M'),'N',' ') ;
        
        if     kol_fz_  = 5                                   then  g_period := 3; 
        elsif  kol_fz2_ = 3 and to_char(DAT_-1, 'Q') in (2,4) then  g_period := 6; 
		elsif  kol_fz3_ = 3 and to_char(DAT_-1, 'Q') = 4      then  g_period := 12; 
		else                      g_period := 3; 
        end if;  		
   
   else
      g_period := 3;   
   end if;
   
  null;
   
   END init1;
 

 FUNCTION F_GET_FIN_HIST_ND (
                             rnk_ int,
                             nd_ int  default 0,
                             kod_ varchar2,
							 IDF_ number,
                             dat_p date,
                             dat_ date default aDATZ_
                            )
  return number is

  s_ number(24,2);
begin

 select min(s)
      into s_
      from fin_nd_update u
     where idupd = (
                        select max(idupd)
                          from fin_nd_update
                         where nd = nd_
                           and kod = kod_ and idf = idf_
                           and rnk = rnk_
                           and fdat = dat_p
                           and chgdate <= nvl(dat_ , sysdate)
                       );


  IF s_ is null then
   return null;
  end if;

  return s_;

  End F_GET_FIN_HIST_ND;


 FUNCTION F_GET_FIN_HIST_datd 
   return  date
   is
 Begin  
   return aDATZ_;
 end F_GET_FIN_HIST_datd ;  
 
   
 procedure p_init (
              RNK_  number,
              ND_   number,
              DAT_  date,
              FDAT_ date)			  
			  IS
BEGIN

barsweb_session.set_session_id(substr(sys_context('userenv','client_identifier'),-24));

          barsweb_session.SET_NUMBER('RNK',   RNK_);
          BARSWEB_SESSION.SET_NUMBER('ND',    ND_);
          barsweb_session.set_date  ('DAT',   DAT_);
          barsweb_session.set_date  ('FDAT',  FDAT_);

--logger.info ('Fin_start - '||aDATZ_||' --- '||sys_context('userenv','client_identifier'));

END p_init;			  
   
 procedure p_reset
			  IS
BEGIN

          barsweb_session.set_session_id(substr(sys_context('userenv','client_identifier'),-24));

          barsweb_session.SET_NUMBER('RNK',   null);
          BARSWEB_SESSION.SET_NUMBER('ND',    null);
          barsweb_session.set_date  ('DAT',   null);
          barsweb_session.set_date  ('FDAT',  null);
          
		  
          --logger.info ('Fin_reset - '||aDATZ_||' --- '||sys_context('userenv','client_identifier'));
		  
END p_reset;	   
   
 PROCEDURE init 
   IS
   RNK_  number;
   ND_   number;
   DAT_  date;
   FDAT_ date;
   
 BEGIN 
 
      barsweb_session.set_session_id(substr(sys_context('userenv','client_identifier'),-24));
 
       RNK_  := BARSWEB_SESSION.GET_NUMBER ('RNK');
       ND_   := BARSWEB_SESSION.GET_NUMBER ('ND');
       DAT_  := BARSWEB_SESSION.GET_DATE   ('DAT');
       FDAT_ := BARSWEB_SESSION.GET_DATE   ('FDAT');
 
 
		Begin
		   select datd 
			 into aDATZ_
			 from FIN_CALCULATIONS
			where RNK  = RNK_
			  and ND   = ND_
			  and dat  = DAT_ 	  
			  and fdat = FDAT_;
		EXCEPTION WHEN no_data_found  THEN 
			aDATZ_ := null;
		End;	   
	 

     --logger.info ('Fin_init - '||aDATZ_||' --- '||sys_context('userenv','client_identifier'));
	 
 
 END init;
   
   


/**
 * header_version - возвращает версию заголовка пакета fin_OBU
 */
function header_version return varchar2 is
begin
  return 'Package header fin_OBU '||G_HEADER_VERSION;
end header_version;

/**
 * body_version - возвращает версию тела пакета fin_OBU
 */
 
function body_version return varchar2 is
begin
  return 'Package body fin_OBU '||G_BODY_VERSION;
end body_version;
--------------

begin

init();


END fin_OBU;
/
 show err;
 
PROMPT *** Create  grants  FIN_OBU ***
grant EXECUTE                                                                on FIN_OBU         to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/fin_obu.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 