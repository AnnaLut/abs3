
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rkapital_v1.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RKAPITAL_V1 (dat_ DATE,
	   	  		  		   			 kodf_ varchar2 default null,
									 userid_  Number default null) RETURN NUMBER IS
--------------------------------------------------
--- Функція розрахунку регулятивного капіталу  ---
--- по новому (від 01.10.2004) алгоритму	   ---
--------------------------------------------------
----- Версія від 21.10.2009 (25.02.2005)	   ---
--------------------------------------------------
--  21.10.2009 - замена KL_R020 на KOD_R020
--------------------------------------------------
    k_		 number; -- поправочний коефіцієнт
	k_SB_	 number; -- процент від субординованого боргу

    ek4b_    Number;
	ek4_     Number;
	ek2_     Number;
	ek1_     Number;
	sum_k	 Number;

	s5999_   Number;
	sumnd_   Number; ---сума нарахованих доходiв строк отримання >3 мiсяцiв
	sumpnd_  Number; ---сума прострочених нарахованих доходiв
	sumsnd_  Number; ---сумнiвна заборгованiсть за нарахованими доходами
	sumrez_  Number; ---сума резерву за простроч.>31 дня i сумнiв. до отримання Нд
	rez3190_ Number; ---сума резерву по цінним паперам (файл #84 строка 91722)
	sump1_   Number;
	sump11_  Number;
	sump2_   Number;
	sump3_   Number;
	sum6a_   Number;
	sum6p_   Number;

	kf1_     varchar2(2):='01';
	kf2_     varchar2(2):='42';
	kf3_     varchar2(2):='84';
	kf4_	 varchar2(2):='C5';

	DatN_    date:=Dat_;

	par_     params.PAR%type;
	flag_    number;

	dat2_    Date;
	mes_     Varchar2(2);
	god_     Varchar2(4);
	count_	 number:=0;

	mfo_	 number:=f_ourmfo();

	sql_ varchar2(200);

  	datD_    Date;        -- дата начала декады !!!
  	dc_      integer;

   	fmt_ varchar2(30):='999G999G999G990D99';

	procedure p_ins(p_kod_ varchar2, p_val_ number) is
	begin
	   if kodf_ is not null and userid_ is not null then
		   insert into otcn_log (kodf, userid, txt)
		   values(kodf_,userid_,p_kod_||to_char(p_val_/100, fmt_));
	   end if;
	end;
BEGIN
   flag_ := f_get_params('NOR_A7_F',1);

   -- поправочний коефіцієнт
   k_ := f_get_params('NOR_KOEF',0.4);

   k_SB_ := f_get_params('NOR_P_SB',1);

   IF kodf_ is not null THEN
	   delete from otcn_log
	   where userid = userid_ and
	   		 kodf = kodf_;
   END IF;

   p_ins('Дата формування : '||to_char(dat_,'dd.mm.yyyy'),null);

   if flag_ = 0 then
	   sum_k := f_get_params('NORM_A7');

   	   p_ins('Регулятивний капітал (константа): ',sum_k);
   else
   	   if mfo_=300465 THEN
		   sql_ := 'SELECT a.sumrk '||
			  	   'FROM REGCAPITAL a '||
		      	   'WHERE a.fdat=(select max(fdat) from REGCAPITAL where fdat<=:Dat_)';

		   execute immediate sql_ into sum_k using dat_;

		   p_ins('Регулятивний капітал (із REGCAPITAL): ',sum_k);
	   else

		   if kodf_ is not null then
			   -- перевірка того, чи сформований №01 файл за звітну дату
			   p_ins('-------- Перевірка наявності в БД файлів, що використовуються при розрахунку ------',null);

			   count_ := f_perevirka(kodf_, kf1_, dat_, userid_);
			   count_ := count_ + f_perevirka(kodf_, kf4_, dat_, userid_);

			   if count_ = 0 then
			   	  p_ins('Всі файли сформовано.',null);
			   end if;
		   end if;

		   p_ins(' --------------------------------- РОЗРАХУНОК --------------------------------- ',null);

		   DatN_ := dat_;
		   -------------------------------------------------------
			-- начало декады
			dc_:=to_number(ltrim(to_char(dat_,'DD'),'0'));

			if dc_ < 10 then
			   datD_:=last_day(add_months(dat_, -1));
			elsif dc_ < 20 then
			   datD_:=to_date('10'||to_char(dat_,'mmyyyy'),'ddmmyyyy');
			else
			   datD_:=to_date('20'||to_char(dat_,'mmyyyy'),'ddmmyyyy');
			end if;

			 select max(w.datf)
			 into datD_
			 from tmp_nbu w
			 where w.kodf=kf1_ and w.datf <= datD_;
			-------------------------------------------------------

		   -- розрахунок основного капіталу
		   BEGIN
		      SELECT sum(DECODE(substr(s.kodp,1,2),'20',to_number(s.znap),0)),
		             sum(DECODE(substr(s.kodp,1,2),'10',to_number(s.znap),0))
		      INTO sump1_, sump11_
		      FROM v_banks_report1 s, ek3_ok a
		      WHERE s.datf=DatN_ and
			  		s.kodf=kf1_ and
		            substr(s.kodp,1,2) in ('20','10')  and
					substr(s.kodp,3,4)=a.nbs;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sump1_:=0 ;
		      sump11_:=0 ;
		   END ;

		   -- протокол
	   	   p_ins('Основний капітал: ', sump1_-sump11_);

		   -- розрахунок додаткового капіталу
		   BEGIN
		      SELECT sum(to_number(znap))
		      INTO sump2_
		      FROM  v_banks_report1
		      WHERE datf=DatN_ and
			  		kodf=kf1_ and
		            substr(kodp,2,5) in ('01591','01593','02401');
					-- +1593 згідно листа НБУ N40-117/35 11.01.2005
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sump2_:=0 ;
		   END;

		   if kodf_ is not null then
			   -- протокол
			   insert into otcn_log (kodf, userid, txt)
			   SELECT kodf_,userid_,'ДК (БС '||nbs||'): '||to_char(val/100, fmt_)
			   from (select substr(kodp,3,4) nbs, sum(to_number(znap)) val
		       		FROM  v_banks_report1
		       		WHERE datf=DatN_ and
			  		 	  kodf=kf1_ and
		             	  substr(kodp,2,5) in ('01591','01593','02401')
			   		group by substr(kodp,3,4));
		   end if;

		   -- результат переоцінки основних засобів
		   BEGIN
		      SELECT sum(to_number(znap))
		      INTO ek2_
		      FROM   v_banks_report
		      WHERE  kodf=kf4_                and
		             substr(kodp,2,5)='51001'    and
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek2_:=0 ;
		   END ;

	   	   p_ins('ДК (БС 5100 r013=1): ', ek2_);

		   sump2_:=nvl(sump2_,0)+nvl(ek2_,0);

		   -- резерв під стандартну заборгованість
		   BEGIN
		      SELECT sum(to_number(znap))
		      INTO ek2_
		      FROM   v_banks_report
		      WHERE  kodf=kf4_                and
		             substr(kodp,2,5)='36901'    and
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek2_:=0 ;
		   END ;

	   	   p_ins('ДК (БС 3690 r013=1): ', ek2_);

		   sump2_:=sump2_+NVL(ek2_,0) ;

		   -- прибуток поточного року
		   BEGIN
		      SELECT sum(DECODE(substr(kodp,1,2),'10',to_number(znap),0)),
		             sum(DECODE(substr(kodp,1,2),'20',to_number(znap),0))
		      INTO sum6a_, sum6p_
		      FROM   v_banks_report1
		      WHERE  datf=DatN_ and
		             kodf=kf1_ and
					 substr(kodp,1,3) in ('106','107','206','207');
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sum6p_:=0 ;
		      sum6a_:=0 ;
		   END ;

		   -- розрахунок відвернення
		   BEGIN
		      SELECT sum(to_number(s.znap))
		      INTO sump3_
		      FROM   v_banks_report1 s, ek2_v a
		      WHERE  s.datf=DatN_ and
		             s.kodf=kf1_  and
		             substr(s.kodp,2,1)='0' and
			  		 substr(s.kodp,3,4)=a.nbs;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      sump3_:=0 ;
		   END ;

		   -- додаток 1 до розрахунку відвернення
		   BEGIN
		   	  --Боргові цінні папери, випущені банками, в портфелі банку на інвестиції
		      SELECT sum(to_number(znap))
		      INTO ek1_
		      FROM   v_banks_report
		      WHERE  kodf=kf4_                and
		             substr(kodp,2,5)='32121'    and
		             datf=Dat_;
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      ek1_:=0 ;
		   END ;

		   sump3_:=nvl(sump3_,0) + nvl(ek1_,0);

		   -- додаток 2 до розрахунку відвернення
		   SELECT sum(gl.p_icurval( s.kv, s.ost, s.fdat))
		   INTO ek2_
		   FROM   sal s, specparam p
		   WHERE  s.fdat=DatN_ and
		   		  s.nbs in ('3103','3105','3203','3205','1516','1524') and
		          s.acc=p.acc(+) and
				  nvl(p.r013,'2')='2';

		   ek2_ := -NVL(ek2_,0);

		   -- субординований борг
		   SELECT sum(to_number(s.znap))
		   INTO  ek4_
		   FROM  v_banks_report1 s
		   WHERE s.datf=DatD_ and
		   		 s.kodf=kf1_ and
		   		 substr(s.kodp,2,5)='03660';

		   ek4_ := NVL(ek4_,0)*k_SB_;

		   -- сумнівна заборгованість за нарахованими доходами
		   SELECT sum(to_number(s.znap))
		   INTO sumsnd_
		   FROM   v_banks_report1 s
		   WHERE  s.datf=DatN_ and
		   		  s.kodf=kf1_ and
		   		  substr(s.kodp,2,5) in ('01780','02480','03589');

		   -- фактично сформована сума резерву за просроченими понад 31 день та сумнівними НД
		   SELECT sum(to_number(s.znap))
		   INTO sumrez_
		   FROM   v_banks_report1 s
		   WHERE  s.datf=DatN_ and
		   		  s.kodf=kf1_ and
		   		  substr(s.kodp,1,6) in ('201790','202490','203191','203291','203599');

		   --- резерв по ценным бумагам б/с 3190 (показатель в #84 91722)  до 13 числа
		   --- месяца выбирается из файла #84 за месяц минус 2 от даты формирования
		   --- после 13 числа за предыдущий месяц
           mes_:=to_char(Dat_,'MM');
           god_:=to_char(Dat_,'YYYY');

	       IF to_number(to_char(Dat_,'dd'))<=13 THEN
		   	  IF to_char(Dat_,'MM')='01' THEN
		         mes_:='12';
		         god_:=to_char(to_number(to_char(Dat_,'YYYY'))-1);

	          	 dat2_:=to_date('01'||lpad(to_char(to_number(mes_)),2,'0')||god_,'ddmmyyyy');
			  else
			  	 dat2_:=to_date('01'||lpad(to_char(to_number(mes_)-1),2,'0')||god_,'ddmmyyyy');
			  end if;
	       ELSE
	          dat2_:=to_date('01'||mes_||god_,'ddmmyyyy');
	       END IF;

	       BEGIN
		      SELECT sum(to_number(znap))
		      INTO rez3190_
		      FROM   v_banks_report1
		      WHERE  kodf=kf3_                 and
		             substr(kodp,1,5)='91722'  and
		             datf=(select max(datf)
					 	   from v_banks_report1
	                       where kodf=kf3_ and
						   		 datf<=Dat2_);
		   EXCEPTION WHEN NO_DATA_FOUND THEN
		      rez3190_:=0 ;
		   END ;

		   -- нараховані доходи
		   SELECT sum(to_number(znap))
		   INTO sumnd_
		   FROM   v_banks_report1 s
		   WHERE s.datf=DatN_ and
		   		 s.kodf=kf4_ and
				 --substr(s.kodp,2,4) in (select r020 from kl_r020 where f_c5='1' and lower(txt) like '%нарах%доход%') and
                 substr(s.kodp,2,4) in (select r020
                                        from kl_r020
                                        where r020 in (select r020 from kod_r020 where a010='C5') and
                                              lower(txt) like '%нарах%доход%') and
				 ((substr(s.kodp,2,4) in ('1518','1528') and
	               substr(s.kodp,6,1) in ('3','4')) or
				  (substr(s.kodp,2,4) not in ('1518','1528') and
				   substr(s.kodp,6,1)='2'));

		   if nvl(sumnd_,0)=0 then
	     	  SELECT -sum(gl.p_icurval( s.kv, s.ost, s.fdat))
		      INTO sumnd_
		      FROM   sal s, kl_r020 k, specparam p
		      WHERE s.fdat=DatN_ and
			  		s.nbs=k.r020 and
					--k.f_c5='1' and
                    k.r020 in (select r020 from kod_r020 where a010='C5') and
		            s.acc=p.acc(+) and
					lower(k.txt) like '%нарах%доход%' and
			       ((s.nbs in ('1518','1528') and p.r013 in ('3','4')) or
				    (s.nbs not in ('1518','1528') and p.r013='2'));
		   end if;

		   -- просрочені нараховані доходи
		   SELECT sum(to_number(s.znap))
		   INTO sumpnd_
		   FROM   v_banks_report1 s
		   WHERE  s.datf=DatN_ and
		   		  s.kodf=kf1_ and
		   		  substr(s.kodp,1,6) in ('101509','101519','101529','102029','102039',
		          '102049','102059','102069','102079','102109','102119','102209','102219',
		          '103119','103219','103579');

		   -- прибуток поточного року
		   s5999_:=nvl(sum6p_,0)-nvl(sum6a_,0)-ROUND((nvl(sumnd_,0)+nvl(sumpnd_,0)+
		   		   nvl(sumsnd_,0)-nvl(sumrez_,0))*k_,0) ;

		   sump1_ := nvl(sump1_,0);
		   sump11_ := nvl(sump11_,0);

		   IF s5999_ > 0 THEN
		      sump2_:=nvl(sump2_,0)+s5999_;
		   else
		      sump1_:=nvl(sump1_,0)-abs(s5999_);
		   END IF ;

       	   ek4b_:=ek4_;

		   IF ek4_>(sump1_-sump11_)*0.5 THEN
		      ek4_:=ROUND((sump1_-sump11_)*0.5,0) ;
		   END IF;

		   --- сума регулятивного капiталу
		   sum_k:=nvl(sump1_,0)-nvl(sump11_,0)+nvl(sump2_,0)+nvl(ek4_,0)-nvl(sump3_,0)-nvl(ek2_,0)+nvl(rez3190_,0);

		   IF sum_k <= 0 THEN
		      sum_k:=1000000000 ;
		   END IF ;
	   end if;
   end if;

   if kodf_ is not null and mfo_<>300465 and flag_ = 1 then

	   p_ins('Субординований борг ('||to_char(k_SB_*100)||'%): ', ek4_);

	   p_ins('Додатковий капітал: ', sump2_ + ek4_);

	   p_ins('Відвернення: ', sump3_ + ek2_);

	   p_ins('Нараховані доходи: ', sumnd_);

	   p_ins('Просрочені нараховані доходи: ', sumpnd_);

	   p_ins('Сумнівна заборгованість за нарахованими доходами: ', sumsnd_);

	   p_ins('Фактично сформована сума резерву за просроченими понад 31 день та сумнівними НД: ', sumrez_);

	   p_ins('Прибуток/збиток поточного року (5999) (поправочний коефіцієнт = '||to_char(k_,'0.0')||'): ', s5999_);

	   p_ins('резерв по ценным бумагам б/с 3190: ', rez3190_);

	   p_ins(' ----------------------------------------------------------------------- ',null);

	   p_ins('Регулятивний капітал (РК): ',sum_k);

	   p_ins(' --------------------------------- НОРМАТИВИ --------------------------------- ',null);

	   p_ins('Максимальний ризик на 1 контрагента (25% від РК): ',sum_k * 0.25);

	   p_ins('Розмір "великих" кредитів (10% від РК): ',sum_k * 0.1);

	   p_ins('Максимальна заборгованість позичальника-інсайдера (5% від РК): ',sum_k * 0.05);

	   p_ins('Заборгованість за коштами, що інвестуються  (15% від РК): ',sum_k * 0.15);
   end if;

   RETURN sum_k;
END Rkapital_v1;
/
 show err;
 
PROMPT *** Create  grants  RKAPITAL_V1 ***
grant EXECUTE                                                                on RKAPITAL_V1     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rkapital_v1.sql =========*** End **
 PROMPT ===================================================================================== 
 