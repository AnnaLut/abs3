
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/fin_2.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.FIN_2 IS
   G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 2  28/02/2007';
--------------------------------------------
-- Методика № 2 (КИЕВ)
/*
 28.02.2007 Sta
             Возможность сохранения формы отчета ("М" или " ")
             в привязке к дате (кварталу) отчета и
             к клиенту (ранее было - только к клиенту)

  11.10.2005 STA Добавки по СПД
                 Вместе :PatchF02.fi2 + пакедж FIN_2.kie + Bin\Depo.apd
  22.08.2005   STA Добавила форому 1-М и 2-М
*/

  FZ_ char(1);
  ern CONSTANT POSITIVE   := 208; err EXCEPTION; erm VARCHAR2(80);

  FUNCTION F_FM ( OKPO_ int    , DAT_ date  )                   RETURN char;

  FUNCTION POK25( POK_ varchar2, DAT_ date, KOL_ int , OKPO_ int) RETURN number ;
  FUNCTION Mes_Pl_Kr(FDAT_ date, OKPO_ int)                       RETURN number ;
  FUNCTION OCI17(POK_ varchar2, FDAT_ date, KOL_ int , OKPO_ int) RETURN number ;
  FUNCTION STANF( GRP_ int   , DAT_ date,   OKPO_ int) RETURN number ;
  FUNCTION LOGK ( DAT_ date    , OKPO_ int , IDF_ int )          RETURN number  ;
  FUNCTION LOGK_D (DAT_ date    , OKPO_ int, IDF_  int)          RETURN number;
--  PROCEDURE P_FZ(M_ char) ;
END fin_2;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.FIN_2 IS
 G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 2  28/02/2007';
--------------------------------------------
FUNCTION F_FM ( OKPO_ int, DAT_ date  )   RETURN char IS
  FM_ char(1):=' ';
begin
  begin
    select f.FM into FM_ from FIN_FM f
    where f.okpo=OKPO_
      and (f.okpo,f.fdat)=
          (select okpo,max(fdat) from FIN_FM
           where okpo=f.OKPO and fdat<=DAT_ group by okpo);
  exception when NO_DATA_FOUND THEn FM_:=' ';
  end;
  RETURN FM_;
end F_FM;
-----------

FUNCTION POK25( POK_ varchar2, DAT_ date, KOL_ int, OKPO_ int) RETURN number IS

 FDAT_ date :=  add_months(DAT_, - KOL_) ;

 N1_ number (24,2); N2_ number (24,2); N3_ number (24,2);
 N4_ number (24,2); N5_ number (24,2);
BEGIN
   -- FZ_:= NVL(FZ_,' ');
   FZ_:= fin_2.F_FM (OKPO_, DAT_ ) ;
 begin
   IF substr(POK_,1,1)='1' then

      -- субективние показатели на базе ФОРМЫ 0
      -- 110 120 130 140 150 162 164 165 168 169

      select S into N1_ from fin_rnk
      where idf=0 and OKPO=OKPO_ and FDAT=FDAT_ and kod=POK_;

      If n1_ is NOT null then
         If POK_ in ('110','164') then
            if    n1_ >=5 then n1_:= 5;
            elsif n1_ >=3 then n1_:= 3;
            elsif n1_ >=1 then n1_:= 1;
            else               n1_:= 0.5;
            end if;
         ElsIf POK_ in ('165') then
            if    n1_ >=3 then n1_:= 1;
            elsif n1_ >0  then n1_:= 0.5;
            else               n1_:= 0;
            end if;
         end if;
      end if;

      RETURN N1_;

   ElsIf POK_ = '210' then

      --1.Обсяг реал_зац_ї продукц_ї

      if FZ_='M' then
        select sum( decode(kod,'010',1,-1)*S )  into N1_
        from fin_rnk
        where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
          and kod in ('010','020');
      else
        select sum( decode(kod,'010',1,-1)*S )  into N1_
        from fin_rnk
        where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
          and kod in ('010','015','020','025');
      end if;

      RETURN N1_;

   ElsIf POK_ = '220' then

      --2. Соб_варт_сть реал_зованої продукц_ї

      if FZ_ = 'M' then
         select sum(S)  into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('140');
      else
         select sum(S)  into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('040');
      end if;

      RETURN N1_;

   ElsIf POK_ = '230' then

      --3. Прибуток або збиток

      if FZ_ = 'M' then
         select  Sum (s)  into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('190');
      else
         select  Sum ( decode (kod,'220', 1, -1) * s)  into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('220','225');
      end if;

      RETURN N1_;

   elsif POK_ in ('240','760') then

      -- 4. Рентабельн_сть актив_в  % (Ра)

      if FZ_ = 'M' then
         select greatest(f2.S,0), f1.S
         into N1_, N2_
         from fin_rnk f1,  fin_rnk f2
         where f2.idf=2 and f1.idf=1
           and f2.OKPO=OKPO_ and f2.FDAT=FDAT_
           and f1.OKPO=OKPO_ and f1.FDAT=FDAT_
           and f2.s is not null and f1.s is not null
           and f2.kod='190'     and f1.kod='280';
      else
         select f2.S , f1.S
         into N1_, N2_
         from fin_rnk f1,  fin_rnk f2
         where f2.idf=2 and f1.idf=1
           and f2.OKPO=OKPO_ and f2.FDAT=FDAT_
           and f1.OKPO=OKPO_ and f1.FDAT=FDAT_
           and f2.s is not null and f1.s is not null
           and f2.kod='220'     and f1.kod='280';
      end if;

      if N2_<>0 then RETURN N1_/N2_; end if;

   elsif POK_ in ('250','770') then

      --5. Рентабельн_сть продажу % (Рп)

      if FZ_ = 'M' then
         select sum(decode(kod,'190',greatest(S,0), 0 ) ),
                sum(decode(kod,'190',0, decode(kod,'010',1,-1)*S))
         into N1_, N2_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('190','010','020');
      else
         select sum(decode(kod,'220',S, 0 ) ),
                sum(decode(kod,'220',0, decode(kod,'010',1,-1)*S))
         into N1_, N2_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('220','010','015','020','025');
      end if;

      if N2_<>0 then RETURN N1_/N2_; end if;

   ElsIf POK_ = '310' then

      --1. Запаси _ затрати, у тому числ_:

      if FZ_ = 'M' then
         select  Sum (s)  into N1_
         from fin_rnk  where idf=1 and OKPO=OKPO_ and s is not null and
              FDAT=FDAT_ and kod in ('100','130','270');
      else
         select  Sum (s)  into N1_
         from fin_rnk  where idf=1 and OKPO=OKPO_ and s is not null and
              FDAT=FDAT_ and kod in ('100','110','120','130','140','270');
      end if;

      RETURN N1_;

   ElsIf POK_ = '314' then

      --- готова продукц_я
      --Одинаково для 1 и 1М

      select Sum (s)  into N1_
      from fin_rnk  where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
       and kod in ('130');

      RETURN N1_;

   ElsIf POK_ = '315' then

      --- товари

      if FZ_ = 'M' then
         N1_:=0;
      else
         select  Sum (s)  into N1_
         from fin_rnk
         where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('140');
      end if;

      RETURN N1_;

   ElsIf POK_ = '320' then

      -- 2.Грошов_ кошти, розрахунки та _нш_ оборотн_ активи, у тому числ_:

      if FZ_ = 'M' then
         select  Sum (s) into N1_
         from fin_rnk
         where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in
         ('160','170','210','220','230','240','250');
      else
         select  Sum (s) into N1_
         from fin_rnk
         where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in
         ('150','160','170','180','190','200','210','220','230','240','250');
      end if;

      RETURN N1_;

   ElsIf POK_ = '322' then

      --деб_торська заборгованн_сть
      --Одинаково для 1 и 1М

      select Sum (s)  into N1_
      from fin_rnk  where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
       and kod in ('160');

      RETURN N1_;

   ElsIf POK_ = '330' then

      --3. Довгостроков_ зобов`язання
      --Одинаково для 1 и 1М

      select  Sum (s) into N1_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('480');

      RETURN N1_;

   ElsIf POK_ = '340' then

      --4. Поточн_ зобов`язання, у тому числ_:
      --Одинаково для 1 и 1М

      select Sum (s) into N1_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('620');

      RETURN N1_;

   ElsIf POK_ = '341' then

      --- кредиторська заборгованн_сть
      --Одинаково для 1 и 1М

      select Sum (s) into N1_
      from fin_rnk  where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
       and kod in ('530');

      RETURN N1_;

   Elsif POK_ in ('350','720') then

      --5. Коеф_ц_єнт миттєвої л_кв_дност_ (КЛ1)
      --Одинаково для 1 и 1М

      select sum(decode(kod,'620',0, S ) ),  sum(decode(kod,'620',S, 0 ) )
      into N1_, N2_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('620','220','230','240');

      if N2_<>0 then RETURN N1_/N2_; end if;

   elsif POK_ in ('360','730') then

      --6. Коеф_ц_єнт поточної л_кв_дност_ (КЛ2)
      if FZ_ = 'M' then
         select sum(decode(kod,'620',0, S ) ), sum(decode(kod,'620',S, 0 ) )
         into N1_, N2_
         from fin_rnk
         where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('620',
          '160','170',
          '210','220','230','240');
      else
         select sum(decode(kod,'620',0, S ) ), sum(decode(kod,'620',S, 0 ) )
         into N1_, N2_
         from fin_rnk
         where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('620',
          '150','160','170','180','190',
          '200','210','220','230','240');
      end if;

      if N2_<>0 then RETURN N1_/N2_; end if;

   elsif POK_ in ('370','710') then

      --7. Коеф_ц_єнт загальої л_кв_дност_ (КП)
      --Одинаково для 1 и 1М

      select sum(decode(kod,'620',0, S)), sum(decode(kod,'620',S, 0 ) )
      into N1_, N2_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and
            kod in ('620','260');
      if N2_<>0 then RETURN N1_/N2_; end if;

   ElsIf POK_ = '410' then

      --1. Власний кап_тал
      --Одинаково для 1 и 1М

      select  Sum (s)  into N1_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
       and kod in ('380');

      RETURN N1_;

   ElsIf POK_ = '420' then

      --2. Необоротн_ активи
      --Одинаково для 1 и 1М

      select Sum (s) into N1_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('080');

      RETURN N1_;

   ElsIf POK_ = '430' then

      --3. Залучен_ кошти
      --Одинаково для 1 и 1М

      select  Sum (s) into N1_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('480','620');

      RETURN N1_;

   elsif POK_ in ('440','740') then

      --4. Коеф_ц_єнт маневреност_ власних кошт_в (КМ)
      --Одинаково для 1 и 1М

      select sum(decode(kod,'380',0, S ) ),sum(decode(kod,'380',S, 0 ) )
      into N1_, N2_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('380','080');
      -- 25.11.2005 В присутствии Ларисы Николаевны
      if N2_ <= 0 then return 0; end if;

      N2_:= (N2_-N1_)/N2_;

      If N2_ <0 then return 0; end if;

      RETURN N2_;

   elsif POK_ in ('450','750') then

      --5. Коеф_ц_єнт незалежност_ (КН)
      --Одинаково для 1 и 1М

      select sum(decode(kod,'380',0, S ) ), sum(decode(kod,'380',S, 0 ) )
      into N1_, N2_
      from fin_rnk
      where idf=1 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('380','480','620');

      if N2_<>0 then
         N2_ := N1_/N2_;
	     if N2_ <=0 or N2_ > 1 then
		    N2_:= 0;
/*		 else                      --   было до 14/11/06
		    N2_:= 1 - N2_; */
		 end if;
    	 return N2_;
      end if;

   ElsIf POK_ = '510' then

      --1. Виручка в_д реал_зац_ї
      if FZ_ = 'M' then
         select Sum (s) into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
          and kod in ('030');
      else
         select Sum (s) into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
          and kod in ('035');
      end if;

      RETURN N1_;

   ElsIf POK_ = '520' then

      --2. _нш_ доходи позичальника

      if FZ_ = 'M' then
         select Sum (s) into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('070');
      else
         select Sum (s) into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('060','110',120,'130','200');
      end if;

      RETURN N1_;

   ElsIf POK_ = '530' then

      --3. Витрати в_д операц_йної д_яльност_ позичальника , у тому числ_:

      if FZ_ = 'M' then
         select Sum (s)  into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        --   and kod in ('090','100','110','120','130');  убираем 24/03/2006 по звонку Ларисы Николаевны
           and kod in ('100','110');
      else
         select Sum (s)  into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('070','080');
      end if;

      RETURN N1_;

   ElsIf POK_ = '531' then

      --- щом_сячн_ умовно-пост_йн_ зобов`язання позичальника (Зм)
      -- Одинаково-расчетный

      N1_ := fin_2.POK25('530',FDAT_,0,OKPO_)/
             to_number( to_char(FDAT_-1,'mm'));

      RETURN N1_;

   ElsIf POK_ = '540' then

      --4. Податков_ платеж_ та сума _нших витрат та зобов`язань, у т.ч.:
      if FZ_ = 'M' then
         select  Sum (s) into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('130','150','160','170');
      else
         select  Sum (s) into N1_
         from fin_rnk
         where idf=2 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
           and kod in ('090','140','160','180','205','210');
      end if;

      RETURN N1_;

   ElsIf POK_ = '541' then

     -- - кр_м зобов`язань, строк погашення яких > строк д_ї кр.угоди (Зi)

      select Sum (s)  into N1_
      from fin_rnk  where idf=3 and OKPO=OKPO_ and FDAT=FDAT_
       and kod in ('041');

      RETURN N1_;

   ElsIf POK_ = '550' then

      --5. Грошовий пот_к (стр.1+2) - (стр.3+4)
      --Рсчетно-одинаков?й

      N1_ := fin_2.POK25('510',FDAT_,0,OKPO_) +
             fin_2.POK25('520',FDAT_,0,OKPO_) -
             fin_2.POK25('530',FDAT_,0,OKPO_) -
             fin_2.POK25('540',FDAT_,0,OKPO_) ;

      RETURN N1_ ;

   ElsIf POK_ = '560' then

      -- 6. Надходження на поточн_ рахункиб у тому числ_:

      N1_ := fin_2.POK25('561',FDAT_,0,OKPO_) +
             fin_2.POK25('562',FDAT_,0,OKPO_) ;

      RETURN N1_ ;

   ElsIf POK_ = '561' then

      --- на рахунки, в_дкрит_ в нашому банку

      select Sum (s)  into N1_
      from fin_rnk
      where idf=3 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('061');

      RETURN N1_;

   ElsIf POK_ = '562' then

      --- на рахунки, в_дкрит_ в _нщих банках

      select Sum (s)  into N1_
      from fin_rnk
      where idf=3 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('062');

      RETURN N1_;

   ElsIf POK_ = '570' then

      --7. "Чист_" середньо-м_с. надходження (3 м_с) на рах.позичальника

      select Sum (decode(kod,'041',-1,1)*s)  into N1_
      from fin_rnk
      where idf=3 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('061','062');

      RETURN N1_;

   ElsIf POK_ = '580' then

      -- 8. Надходження до каси позичальника (для с/г та закуп.п_дприємств)

      select  Sum (s)  into N1_
      from fin_rnk
      where idf=3 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('080');

      RETURN N1_;

   elsif POK_ in ('590','780') then

      -- 9. Коеф_ц_єнт сп_вв_дношення чистих надходжень до суми боргу (К):
      --  ( Нсм - Зм - Зi ) * n / Ск

      -- Нсм
      N1_:= fin_2.POK25('570',FDAT_,0,OKPO_);

      --n
      select S into N2_ from fin_rnk  where idf=4 and OKPO=OKPO_
         and FDAT=FDAT_ and s is not null and kod='012';

      -- Зм
      N3_:= fin_2.POK25('531',FDAT_,0,OKPO_);

      --Зi
      N4_:= fin_2.POK25('541',FDAT_,0,OKPO_);

      --Ск
      select sum(S) into N5_
      from fin_rnk
      where idf=4 and OKPO=OKPO_
        and FDAT=FDAT_ and s is not null  and kod in ('010','011');

      if N5_<>0 then RETURN ( N1_- N3_ - N4_ ) * N2_ / N5_ ; end if;
-----------------------------------------

   elsif POK_ in (790) then

      -- 9. Коеф_ц_єнт забезпечення кредиту (КЗК)

      select sum(decode(kod,'010',0,'011',0,S)),
             sum(decode(kod,'010',S,'011',S,0))
      into N1_, N2_
      from fin_rnk
      where idf=4 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('001','002','003','004','005','010','011');

      if N2_<>0 then RETURN N1_/N2_; end if;

------ физ лица---------------------
   elsif POK_ in (905,906,907,908,909) then
      -- СПД
      -- 905 1.0.5. Перiод функцiонування СПД (рокiв)
      -- 906 1.0.6. Наявнiсть бiзнес-плану СПД
      -- 907 1.0.7. Залежнiсть СПД вiд сезон.та стр.змiн
      -- 908 1.0.8. Позит.досвiд роботи з банком у СПД
      -- 909 1.0.9. Є Програма подадьшого розвитку СПД
      select Nvl(S,0) into N1_ from fin_rnk
      where idf=10 and OKPO=OKPO_ and FDAT=FDAT_ and kod=to_char(POK_);
      RETURN N1_;

   elsif POK_ in (911,912,913,914,915) then

      -- 911 1.1. Працездатний вiк
      -- 912 1.2. Страховий полiс
      -- 913 1.3. Власна нерухомiсть, ЦП, ...
      -- 914 1.4. Депозити в нашому банку
      -- 915 1.5. Постiйна робота (рокiв)

      select Nvl(S,0) into N1_ from fin_rnk
      where idf=10 and OKPO=OKPO_ and FDAT=FDAT_ and kod=to_char(POK_+80);
      RETURN N1_;

   elsif POK_ in (941,942) then

      select S into N1_ from fin_rnk
      where idf=10 and OKPO=OKPO_ and FDAT=FDAT_ and kod=to_char(POK_+55);
      RETURN N1_;

   elsif POK_ in (951) then

      select S into N1_ from fin_rnk
      where idf=10 and OKPO=OKPO_ and FDAT=FDAT_ and kod='998';
      RETURN N1_;

   elsif POK_ in (929) then

      select S into N1_ from fin_rnk
      where idf=10 and OKPO=OKPO_ and FDAT=FDAT_ and kod=POK_;
      RETURN N1_;

   elsif POK_ in (931) then

      select S into N1_ from fin_rnk
      where idf=4 and OKPO=OKPO_ and FDAT=FDAT_ and s is not null
        and kod in ('001','002','003','004','005');

      select sum(S) into N2_ from fin_rnk
      where idf=4 and OKPO=OKPO_ and FDAT=FDAT_ and kod in ('010','011');

      if n2_>0 then N1_:=N1_*100/N2_; else N1_:=0; end if;
      RETURN N1_;

   elsif POK_ in (921) then
      -- КПП
      -- месячный доход заемщика
      SELECT sum(Nvl(S,0)) into N1_ from fin_rnk r
       where r.idf=10 and r.OKPO=OKPO_ and r.FDAT=FDAT_
         and r.kod in ('911','914','917','920','923');

      --месячный расход заемщика
      SELECT sum(Nvl(S,0)) into N2_ from fin_rnk  r
       where r.idf=10 and r.OKPO=OKPO_ and r.FDAT=FDAT_
         and r.kod in ('931','934','937','940','943','946','949');

      --месячные платежи по кредиту
      n3_:= Mes_Pl_Kr(FDAT_ ,OKPO_ );

      if N2_+N3_>0 and N1_>0 then N1_:= N1_/(N2_+N3_);
      else                        N1_:= 0;
      end if;

      RETURN N1_;

   elsif POK_ in (922) then
      -- КПС
      -- месячный доход семьи
      SELECT sum(Nvl(S,0)) into N1_ from fin_rnk r
       where r.idf=10 and r.OKPO=OKPO_ and r.FDAT=FDAT_  and r.kod in
        ('911','914','917','920','923',
         '912','915','918','921','924');

      --месячный расход семьи
      SELECT sum(Nvl(S,0)) into N2_ from fin_rnk  r
       where r.idf=10 and r.OKPO=OKPO_ and r.FDAT=FDAT_ and r.kod in
         ('931','934','937','940','943','946','949',
          '932','935','938','941','944','947','950');

      --месячные платежи по кредиту
      n3_:= Mes_Pl_Kr(FDAT_ ,OKPO_ );

      if N2_+N3_>0 and N1_>0 then N1_:= N1_/(N2_+N3_);
      else                        N1_:= 0;
      end if;
      RETURN N1_;

   elsif POK_ in (923) then
      -- КППp поручителя

      -- месячный доход поручителя
      SELECT sum(Nvl(S,0)) into N1_ from fin_rnk r
       where r.idf=10 and r.OKPO=OKPO_ and r.FDAT=FDAT_
         and r.kod in ('913','916','919','922','925');

      --месячный расход поручителя

      SELECT sum(Nvl(S,0)) into N2_ from fin_rnk  r
       where r.idf=10 and r.OKPO=OKPO_ and r.FDAT=FDAT_
         and r.kod in ('933','936','939','942','945','948','951');

      --месячные платежи по кредиту
      n3_:= Mes_Pl_Kr(FDAT_ ,OKPO_ );

      if N2_+N3_>0 and N1_>0 then N1_:= N1_/(N2_+N3_);
      else                        N1_:= 0;
      end if;

      RETURN N1_;


   end if;

 exception when NO_DATA_FOUND THEn

   if POK_>900 then return 0; else  NULL; end if;

 end;

 RETURN to_number(null);

end POK25;
-------------------------------------
FUNCTION Mes_Pl_Kr(FDAT_ date, OKPO_ int) RETURN number IS
 --месячные платежи по кредиту
  N3_ number (24,2);  N4_ number (24,2);
begin
   -- FZ_:= NVL(FZ_,' ');
   FZ_:= fin_2.F_FM (OKPO_, FDAT_ ) ;
  begin
    SELECT sum( decode( kod,'012', 0, Nvl(S,0) ) ),
           sum( decode( kod,'012', Nvl(S,0), 0 ) )
    into N3_, n4_
    from fin_rnk
    where idf=4 and OKPO=OKPO_ and FDAT=FDAT_ and kod in ('010','011','012');
    if N4_>0 then N3_:= N3_/N4_; else N3_:=0; end if;
  exception when NO_DATA_FOUND THEn  N3_:=0;
  end;
  RETURN N3_;
end Mes_Pl_Kr;

-----
FUNCTION OCI17( POK_ varchar2, FDAT_ date, KOL_ int, OKPO_ int) RETURN number IS
 N1_ number (24,2); N2_ int :=0;
BEGIN
   -- FZ_:= NVL(FZ_,' ');
   FZ_:= fin_2.F_FM (OKPO_, FDAT_ ) ;
   If Substr(POK_,1,1) in ('1','7','9') then
      N1_:=FIN_2.POK25( POK_,FDAT_,KOL_,OKPO_);

      If N1_ is null then return null; end if;

      If    POK_ like '1__' then  n2_:=N1_;
      Elsif POK_  ='710'    then  N2_:= IIF_N ( N1_, 2  , 0, 2, 2 );
      ElsIf POK_  ='720'    then  N2_:= IIF_N ( N1_, 0.2, 0, 2, 2 );
      ElsIf POK_  ='730'    then  N2_:= IIF_N ( N1_, 0.5, 0, 2, 2 );
      ElsIf POK_  ='740'    then  N2_:= IIF_N ( N1_, 0.5, 0, 2, 2 );
      --ElsIf POK_  ='750'    then  N2_:= IIF_N ( N1_, 1  , 2, 2, 0 );
      ElsIf POK_  ='750'    then
	    If N1_<=0 or N1_>1 then N2_:=0;
            Else                    N2_:=2;
            End if;
      ElsIf POK_  ='760'    then  N2_:= IIF_N ( N1_, 5  , 0, 1, 2 );
      ElsIf POK_  ='770'    then  N2_:= IIF_N ( N1_, 10 , 0, 1, 2 );
      ElsIf POK_  ='780'    then  N2_:= IIF_N ( N1_, 1.5, 0, 2, 2 );
      ElsIf POK_  ='790'    then  N2_:= IIF_N ( N1_, 1.5, 0, 1, 2 );

      -- физ лица
      elsif POK_  ='905'    then
         -- 1.0.5. Перiод функцiонування СПД (рокiв)
            If    N1_<1 then n2_:= 0 ;
            elsIf n1_<3 then N2_:= 5 ;
            else             N2_:= 10;
            end if;

      elsif POK_  ='915'    then
         -- 1.5. Постiйна робота (рокiв)
            If    N1_<1 then n2_:= 0;
            elsIf n1_<3 then N2_:= 5;
            elsIf n1_<5 then N2_:= 10;
            else             N2_:= 20;
            end if;

      elsif POK_ in (906,907,908,909,
                     911,912,913,914,929, 941,942,951) then
            IF n1_ = 1 then
               select VZ into N2_ from fin_pok where ord=POK_ ;
            end if;

      elsif POK_  ='921'    then  N2_:= IIF_N ( N1_, 1.3, 0, 20, 20 );
      elsif POK_  ='922'    then  N2_:= IIF_N ( N1_, 1.5, 0, 20, 20 );
      elsif POK_  ='923'    then  N2_:= IIF_N ( N1_, 1.3, 0, 20, 20 );
      elsif POK_  ='931'    then  N2_:= IIF_N ( N1_, 1.3, 0, 20, 20 );
            begin
              select 70 into N2_ from fin_rnk
              where idf=4 and OKPO=OKPO_ and FDAT=FDAT_ and kod='930' and s=1;

            exception when NO_DATA_FOUND THEn
               if    n1_<=  0  then  N2_:= 0;
               elsif n1_<= 50  then  N2_:=10;
               elsif n1_<=100  then  N2_:=30;
               elsIf N1_<=150  then  N2_:=50;
               else                  N2_:=70;
               end if;
            end;

      END IF;

   end if;

   RETURN to_number(N2_);

end OCI17;
--------------
FUNCTION STANF( GRP_ int , DAT_ date, OKPO_ int) RETURN number IS
 N1_ number (24,2);
 FIN_ int :=null;
-- GRP_  - управляющий параметр:
-- Если GRP_ = 5, то это ЮЛ
-- Если GRP_ = 3, то это ФЛ
-- Если GRP_ =23, то это СПД

begin
   --FZ_:= NVL(FZ_,' ');
   FZ_:= fin_2.F_FM (OKPO_, DAT_ ) ;
 begin
   n1_:=0;

   If GRP_ in (3,23) then /* ФЛ в т.ч. и СПД */
      select sum(nvl(FIN_2.OCI17(ORD,DAT_,0,OKPO_),0))  into N1_
      from FIN_pok  WHERE ORD>=900;
      N1_:=nvl(N1_,0);

      If n1_<0 then n1_:= 0; end if ;

      select FIN into FIN_ from (select FIN,IP3 from stan_fin ORDER BY fin)
      where n1_>=IP3 and rownum=1;

   ElsIf GRP_ =5 then
      for k in (select f.POK,
                 Nvl( g.VK *
                     (FIN_2.pok25(f.ORD, DAT_, 0, OKPO_ ) * f.VZ +
                      FIN_2.OCI17(f.ORD, DAT_, 0, OKPO_ ) ),0)  N1
                FROM FIN_pok f, FIN_GRP g
                WHERE g.ORD = f.GRP and g.ORD<=GRP_  ORDER BY f.POK
               )
      loop
        If k.POK in ('710','720','730','780') and k.N1>100 then N1_:=N1_+100 ;
        else                                                    N1_:=N1_+k.n1;
        end if;
      end loop;
      if n1_ is not null then  If n1_<0 then n1_:= 0; end if ;
         select FIN into FIN_ from (select FIN,IP from stan_fin ORDER BY fin)
         where n1_>=IP and rownum=1;
      end if;
   end if;
 exception when NO_DATA_FOUND THEn null;
 end;

 Return(FIN_);

end STANF ;
-------------
FUNCTION LOGK ( DAT_ date, OKPO_ int , IDF_ int ) RETURN number is
 n2_ number :=0;
begin
 --    FZ_:= NVL(FZ_,' ');
 FZ_:= fin_2.F_FM (OKPO_, DAT_ ) ;

 If IDF_ = 2 then

    If FZ_ = 'M' then /* Лог_чний контроль форми 2-M */
       select count (*) into N2_
       from (select 1 KOL, NVL(SUM(decode(KOD,'010',S,0)),0) SL,
                           NVL(SUM(decode(KOD,'010',0,S)),0) SR
             from fin_rnk
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_
               and  kod in ('030','010','020')
             having NVL(SUM(decode(KOD,'010',S,0)),0)<>
                    NVL(SUM(decode(KOD,'010',0,S)),0)
          UNION ALL
             select 1,NVL(SUM(decode(KOD,'070',S,0)),0),
                      NVL(SUM(decode(KOD,'070',0,S)),0)
             from fin_rnk
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_
               and kod in ('070','030','040','050','060')
             having NVL(SUM(decode(KOD,'070',S,0)),0)<>
                    NVL(SUM(decode(KOD,'070',0,S)),0)
          UNION ALL
             select 1,NVL(SUM(decode(KOD,'180',S,0)),0),
                      NVL(SUM(decode(KOD,'180',0,S)),0)
             from fin_rnk
             where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_
               and kod in ('180','090','100','110','120','130','140',
                           '150','080','160','170')
             having NVL(SUM(decode(KOD,'180',S,0)),0)<>
                    NVL(SUM(decode(KOD,'180',0,S)),0)
        );
    else /* Лог_чний контроль форми 2 */

       select count (*) into N2_
       from ( /* 1) 035 = 010 - 015 - 020 - 030. */
         select 1 KOL,
           NVL(SUM( decode(KOD,'035',S,0)),0) SL,
           NVL(SUM( decode(KOD,'035',0, Decode(KOD,'010',1,-1)*S)),0) SR
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('030','010','020','035','015')
         having
           NVL(SUM( decode(KOD,'035',S,0)),0) <>
           NVL(SUM( decode(KOD,'035',0, Decode(KOD,'010',1,-1)*S)),0)
       UNION ALL  /*  2) 050 = 035-040+055 */
         select 1,
           NVL(SUM(decode(KOD,'050',S,0)), 0) ,
           NVL(SUM(decode(KOD,'050',0,decode(KOD,'040',-1,1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('050','055','035','040')
           having
             NVL(SUM(decode(KOD,'050',S,0)), 0) <>
             NVL(SUM(decode(KOD,'050',0,decode(KOD,'040',-1,1)*S)),0)
       UNION ALL /* 3) 100= 050-055 + 060 - 070 - 080 - 090+105 */
         select 1 ,
           NVL(SUM(decode(KOD,'100',S,0)),0),
           NVL(SUM(decode(KOD,'100',0,decode(kod,'050',1,'060',1,'105',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('050','060','105', '100','055','070','080','090')
           having
           NVL(SUM(decode(KOD,'100',S,0)),0)<>
           NVL(SUM(decode(KOD,'100',0,decode(kod,'050',1,'060',1,'105',1,-1)*S)),0)
       UNION ALL /*  4) */
         select 1 ,
           nvl(SUM(decode(KOD,'170',S,0)),0),
           nvl(SUM(decode(KOD,'170',0,decode(kod,'100',1,'110',1,'120',1,'130',1,'175',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('170','105','140','150','160',
                   '100','110','120','130','175')
           having
           nvl(SUM(decode(KOD,'170',S,0)),0)<>
           nvl(SUM(decode(KOD,'170',0,decode(kod,'100',1,'110',1,'120',1,'130',1,'175',1,-1)*S)),0)
       UNION ALL /*  5) 190 = 170-175 - 180+195 */
         select 1 ,
           nvl(SUM(decode(KOD,'190',S,0)),0),
           nvl(SUM(decode(KOD,'190',0,decode(kod,'170',1,'195',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
           kod in ('170','195','190','175','180')
           having
           nvl(SUM(decode(KOD,'190',S,0)),0)<>
           nvl(SUM(decode(KOD,'190',0,decode(kod,'170',1,'195',1,-1)*S)),0)
       UNION ALL /* 6)  220-225 = 190-195 + 200 - 205 - 210+225 */
         select 1 ,
          nvl(SUM(decode(KOD,'220',S,0)),0),
          nvl(SUM(decode(KOD,'220',0,decode(kod,'190',1,'200',1,'225',1,-1)*S)),0)
         from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
          kod in ('220','195','205','210','190','200','225')
          having
          nvl(SUM(decode(KOD,'220',S,0)),0) <>
          nvl(SUM(decode(KOD,'220',0,decode(kod,'190',1,'200',1,'225',1,-1)*S)),0)
       );
   end if;
   return N2_;
end if;
If IDF_<> 1 then RETURN 0; end if;
------------
---Форма № 1 на 8 условий раветства
select count (*) into N2_
from (
select 1 KOL, NVL(SUM(decode(KOD,'080',S,0)),0) SL,
              NVL(SUM(decode(KOD,'080',0,S)),0) SR
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('080','010','020','030','040','045','050','060','065','070')
       having NVL(SUM(decode(KOD,'080',S,0)),0)<>
              NVL(SUM(decode(KOD,'080',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'260',S,0)),0),
         NVL(SUM(decode(KOD,'260',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('260','100','110','120','130','140','150','160','170',
             '180','190','200','210','220','230','240','250')
  having NVL(SUM(decode(KOD,'260',S,0)),0)<>
         NVL(SUM(decode(KOD,'260',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'280',S,0)),0),
         NVL(SUM(decode(KOD,'280',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('280', '080','260','270')
  having NVL(SUM(decode(KOD,'280',S,0)),0)<>
         NVL(SUM(decode(KOD,'280',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'380',S,0)),0),
         NVL(SUM(decode(KOD,'380',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('380','300','310','320','330','340','350','360','370')
  having NVL(SUM(decode(KOD,'380',S,0)),0)<>
         NVL(SUM(decode(KOD,'380',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'430',S,0)),0),
         NVL(SUM(decode(KOD,'430',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and FZ_<>'M' and
     kod in ('430','400','410','420')
  having NVL(SUM(decode(KOD,'430',S,0)),0)<>
         NVL(SUM(decode(KOD,'430',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'480',S,0)),0),
         NVL(SUM(decode(KOD,'480',0,S)),0)
from fin_rnk
where NVL(FZ_,' ')<>'M' and OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('480','440','450','460','470')
  having NVL(SUM(decode(KOD,'480',S,0)),0)<>
         NVL(SUM(decode(KOD,'480',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'620',S,0)),0),
         NVL(SUM(decode(KOD,'620',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('620','500','510','520','530','540','550','560','570','580','590','600','610')
  having NVL(SUM(decode(KOD,'620',S,0)),0)<>
         NVL(SUM(decode(KOD,'620',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'640',S,0)),0),
         NVL(SUM(decode(KOD,'640',0,S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('640','380','430','480','620','630')
  having NVL(SUM(decode(KOD,'640',S,0)),0)<>
         NVL(SUM(decode(KOD,'640',0,S)),0)
UNION ALL
select 1,NVL(SUM(decode(KOD,'030',S,0)),0),
         NVL(SUM(decode(KOD,'030',0,decode(KOD,'031',1,-1)*S)),0)
from fin_rnk where OKPO=OKPO_ and FDAT=DAT_ and idf=IDF_ and
     kod in ('030','031','032')
  having NVL(SUM(decode(KOD,'030',S,0)),0)<>
         NVL(SUM(decode(KOD,'030',0,decode(KOD,'031',1,-1)*S)),0)
) ;

RETURN N2_;

end LOGK;
----

---------------
FUNCTION LOGK_D (DAT_ date    , OKPO_ int, IDF_  int)  RETURN number Is
 N1_ int :=0; KOL_ int :=0;
 M0_ char(1); M1_  char(1); M2_ char(1); M3_ char(1); M4_ char(1);
begin

  If IDF_ <> 2 then return 0; end if;

  M0_:= fin_2.F_FM(OKPO_,           DAT_    );
  M1_:= fin_2.F_FM(OKPO_,add_months(DAT_,- 3));
  M2_:= fin_2.F_FM(OKPO_,add_months(DAT_,- 6));
  M3_:= fin_2.F_FM(OKPO_,add_months(DAT_,- 9));
  M4_:= fin_2.F_FM(OKPO_,add_months(DAT_,-12));
  ---Форма № 2 на возрастание кроме первого кв
  If M0_ = M1_  then
     select count(*) into KOL_
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = DAT_  and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3)
       and f1.idf  = f0.idf  and f0.kod  = f1.kod
       and f0.s    < f1.s
       and to_char( DAT_-1,'Q')<>'1'
       and (f0.kod<>'190' or M0_<>'M');
  end if;
  N1_:= N1_ + KOL_;

  If M1_ = M2_   then
     select count(*) into KOL_
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = add_months(DAT_,-3)  and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3)
       and f1.idf  = f0.idf  and f0.kod  = f1.kod
       and f0.s    < f1.s
       and to_char( DAT_-1,'Q')<>'2'
       and (f0.kod<>'190' or M1_<>'M');
  end if;
  N1_:= N1_ + KOL_;

  If M2_ = M3_   then
     select count(*) into KOL_
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = add_months(DAT_,-6)  and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3)
       and f1.idf  = f0.idf  and f0.kod  = f1.kod
       and f0.s    <f1.s
       and to_char( DAT_-1,'Q')<>'3'
       and (f0.kod<>'190' or M2_<>'M');
  end if;
  N1_:= N1_ + KOL_;

  If M3_ = M4_   then
     select count(*) into KOL_
     from fin_rnk f0 , fin_rnk f1
     where f0.OKPO = OKPO_   and f0.FDAT = add_months(DAT_,-9)    and f0.idf=IDF_
       and f1.OKPO = f0.OKPO and f1.FDAT = add_months(f0.FDAT,-3)
       and f1.idf  = f0.idf  and f0.kod  = f1.kod
       and f0.s    < f1.s
       and to_char( DAT_-1,'Q')<>'4'
       and (f0.kod<>'190' or M3_<>'M');
  end if;
  N1_:= N1_ + KOL_;
  RETURN N1_;

end LOGK_D;

------------------------------

--PROCEDURE P_FZ(M_ char)  is
--begin
-- FZ_:=M_;
--end P_FZ;
-----------
/**
 * header_version - возвращает версию заголовка пакета FIN2
 */
function header_version return varchar2 is
begin
  return 'Package header FIN_2 '||G_HEADER_VERSION;
end header_version;

/**
 * body_version - возвращает версию тела пакета FIN2
 */
function body_version return varchar2 is
begin
  return 'Package body FIN_2 '||G_BODY_VERSION;
end body_version;
--------------
END fin_2; 
/
 show err;
 
PROMPT *** Create  grants  FIN_2 ***
grant EXECUTE                                                                on FIN_2           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on FIN_2           to RCC_DEAL;
grant EXECUTE                                                                on FIN_2           to R_FIN2;
grant EXECUTE                                                                on FIN_2           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/fin_2.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 