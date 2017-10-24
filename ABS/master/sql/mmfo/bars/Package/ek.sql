
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/ek.sql =========*** Run *** ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.EK IS

/*
03.09.2007 Sta    PUL- перемен для мод.операций
   После демонстрации в ОБ.
   Врем табл IGRA, признак мод
   Вместе : BIN\FIGURE.APD + пакедж PUL + пакедж EK + patchN26.ek

30.08.2007 Virko  Добавила процедуру p_ek_pok_2day
28.08.2007 Virko  Норматив Н13, H13-1, H13-2
27.08.2007 Virko  Норматив Н7, H8, H9, H10
21.08.2007 Sta    Норматив Н7
*/

   ek6_   DECIMAL(24,2); --* Вторичный (К)  Капiтал банку
   ek60_  DECIMAL(24,2); --* Вторичный (Ст) Статутний капiтал банку
   ek21_  DECIMAL(24,2); --* Первичный (Зс) МАКС Cукуп.заборгов.1 позичальника
   ek22_  DECIMAL(24,2); --* Вторичный  Н7 Макс.ризику на 1 позичальника
   ek23_  DECIMAL(24,2); --* Первичный (Зв) Сукупний розмiр "великих" кредитiв
   ek24_  DECIMAL(24,2); --* Вторичный  Н8 Норматив "великих" кредитних ризикiв
   ek25_  DECIMAL(24,2); --* Первичный (Зiн) МАКС Cук.заборг. 1 iнсайдера
   ek26_  DECIMAL(24,2); --* Вторичный  Н9 Норматив макс.розмiру кр на 1 iнсайдера
   ek27_  DECIMAL(24,2); --* Первичный (СЗiн) Cукупна заборгованнiсть всiх iнсайдерiв
   ek28_  DECIMAL(24,2); --* Вторичный  Н11 Норматив макс.сук.розмiру кр на всiх iнсайдерiв
   ek38_  DECIMAL(24,2); --* Первичный (Вп) Загальна вiдкрита валютна позицiя
   ek39_  DECIMAL(24,2); --* Вторичный  Н13 Норматив загальної вiдкритоi вал поз
   ek381_ DECIMAL(24,2); --* Первичный (Вп-1) Загальна довга вiдкрита валютна позицiя
   ek391_ DECIMAL(24,2); --* Вторичный  Н13-1 Норматив загальна довгої вiдкритоi вал поз
   ek382_ DECIMAL(24,2); --* Первичный (Вп-2) Загальна коротка вiдкрита валютна позицiя
   ek392_ DECIMAL(24,2); --* Вторичный  Н13-2 Норматив заг короткої вiдкритої вал поз
   ek40_  DECIMAL(24,2); --* Первичный (Вiн) МАХ Вiдкрита валютна позицiя у ВКВ
   ek41_  DECIMAL(24,2); --* Вторичный  Н16 Норматив MAX вiдкритоi вал поз у ВКВ
   ek42_  DECIMAL(24,2); --* Первичный (Вн) МАХ Вiдкрита валютна позицiя у HКВ
   ek43_  DECIMAL(24,2); --* Вторичный  Н17 Норматив MAX вiдкритоi вал поз у HКВ
   ek44_  DECIMAL(24,2); --* Первичный (Вм) МАХ Вiдкрита валютна позицiя у БМ
   ek45_  DECIMAL(24,2); --* Вторичный  Н18 Норматив MAX вiдкритоi вал поз у БМ
   exist_42_ boolean;
---------------------------------
   ek1_   DECIMAL(24,2); --  Первичный (ОЗ) Oсновнi Засоби
   ek2_   DECIMAL(24,2); --  Первичный (В)  Biдвернення
   ek3_   DECIMAL(24,2); --  Первичный (ОК) Oсновний Капiтал
   ek4_   DECIMAL(24,2); --  Первичный (ДК) Додатковий Капiтал
   ek5_   DECIMAL(24,2); --  Вторичный (К1) Невiдкоригований Капiтал
   ek7_   DECIMAL(24,2); --  Первичный (Ар) Сумарнi, по ступеням ризику
   ek8_   DECIMAL(24,2); --  Вторичный  Н3  Норматив платоспоможностi
   ek9_   DECIMAL(24,2); --  Первичный (ЗА) Загальнi активи
   ek10_  DECIMAL(24,2); --  Вторичный  Н6 Норматив короткої лiквiдностi
   ek11_  DECIMAL(24,2); --            (Ккр) Кошти на кореспонтських рахунках
   ek12_  DECIMAL(24,2); --            (Ка) Кошти в касi
   ek13_  DECIMAL(24,2); --  \ Поточнi рахунки для розрахунку Н5
   ek135_ DECIMAL(24,2); --  / Поточнi рахунки для розрахунку Н5
   ek136_ DECIMAL(24,2); --  | Поточнi рахунки для розрахунку Н6
   ek14_  DECIMAL(24,2); --  Вторичный  Н4 Норматив миттевоi лiквiдностi
   ek15_  DECIMAL(24,2); --  Активи перв. та втор. лiквiдностi
   ek16_  DECIMAL(24,2); --  Зобов`язання банку для Н5
   ek166_ DECIMAL(24,2); --  Зобов`язання банку для Н6
   ek17_  DECIMAL(24,2); --             Н5 Норматив поточної лiквiдностi
   ek18_  DECIMAL(24,2); --            (Ал) Лiквiднi активи
   ek19_  DECIMAL(24,2); --  Первичный (Ра) Робочi активи
   ek20_  DECIMAL(24,2); --  Вторичный  Вiднош високолiк. до роб. активiв
   ek29_  DECIMAL(24,2); --  Первичный (МБн) Заг.сума наданих мiжбан позик
   ek30_  DECIMAL(24,2); --  Вторичный  Н12 Норматив макс.розм наданих мб позик
   ek31_  DECIMAL(24,2); --  Первичный (ЦК) Заг сума зал централiзованих коштiв
   ek32_  DECIMAL(24,2); --  Первичный (МБо) Заг сума отр мб позик
   ek33_  DECIMAL(24,2); --  Вторичный  Н13 Норматив макс.розм отрим мб позик
   ek34_  DECIMAL(24,2); --  Первичный (Кiн)Кошти, якi iнв на придбання часток
   ek46_  DECIMAL(24,2); --  Первичный (Ппо) Прибуток пiсля оподаткувення
   ek47_  DECIMAL(24,2); --  Вторичный      Дохiд на активи
   ek48_  DECIMAL(24,2); --  Вторичный      Дохiд на капiтал
   ek49_  DECIMAL(24,2);
   EK50_  DECIMAL(24,2);

---------------
FUNCTION ek_NULL RETURN DECIMAL;
FUNCTION ek_ALL  RETURN DECIMAL;

FUNCTION find_42(dat_ IN DATE) RETURN boolean;

FUNCTION ek6  (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek60 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek21 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek22 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek23 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek24 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek25 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek26 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek27 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek28 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek38 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek39 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek381 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek391 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek382 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek392 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;

FUNCTION ek40 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek41 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek42 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek43 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek44 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek45 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
-----------------
PROCEDURE p_ek_pok_day(dat_ DATE);
PROCEDURE p_ek_pok_2day(kol_ number default 1);
-------------------

/*
FUNCTION ek1 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek2 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek3 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek4 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek5 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek15 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek16 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek166 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek18 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek19 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek20 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek29 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek30 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek31 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek32 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek33 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek34 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek46 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek48 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
FUNCTION ek49 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL;
*/

END ek;
/
CREATE OR REPLACE PACKAGE BODY BARS.EK IS
/*
30.08.2007 Virko  Добавила процедуру p_ek_pok_2day
28.08.2007 Virko  Норматив Н13, H13-1, H13-2
27.08.2007 Virko  Норматив Н7, H8, H9, H10
21.08.2007 Sta    Норматив Н7
17/11/2015 Virko  Добавила проверку на наличие С5 файла
*/
------------
FUNCTION ek_null RETURN DECIMAL IS
  -- очистка всех переменных для повторного их расчета
BEGIN
   ek6_   :=null; --* Вторичный (К)  Капiтал банку
   ek60_  :=null;--* Вторичный (Ст) Статутний капiтал банку
   ek21_  :=null; --* Первичный (Зс) МАКС Cукуп.заборгов.1 позичальника
   ek22_  :=null; --* Вторичный  Н7 Макс. ризику на одного позичальника
   ek23_  :=null; --* Первичный (Зв) Сукупний розмiр "великих" кредитiв
   ek24_  :=null; --* Вторичный  Н8 Норматив "великих" кредитних ризикiв
   ek25_  :=null; --* Первичный (Зін) МАКС Cук.заборг. 1 iнсайдера
   ek26_  :=null; --* Вторичный  Н9 Норматив макс.розмiру кр на 1 iнсайдера
   ek27_  :=null; --* Первичный (СЗін) Cукупна заборгованнiсть всiх iнсайдерiв
   ek28_  :=null; --* Вторичный  Н10 Норматив макс.сук.розмiру кр на всiх iнсайдерiв

   ek38_  :=null; --* Первичный (Вп) Загальна вiдкрита валютна позицiя
   ek39_  :=null; --* Вторичный  Н13 Норматив загальної вiдкритоi вал поз

   ek381_ :=null; --* Первичный (Вп-1) Загальна довга вiдкрита валютна позицiя
   ek391_ :=null; --* Вторичный  Н13-1 Норматив загальна довгої вiдкритоi вал поз

   ek382_ :=null; --* Первичный (Вп-2) Загальна коротка вiдкрита валютна позицiя
   ek392_ :=null; --* Вторичный  Н13-2 Норматив заг короткої вiдкритої вал поз

   ek40_  :=null; --* Первичный (Вiн) МАХ Вiдкрита валютна позицiя у ВКВ
   ek41_  :=null; --* Вторичный  Н16 Норматив MAX вiдкритоi вал поз у ВКВ
   ek42_  :=null; --* Первичный (Вн) МАХ Вiдкрита валютна позицiя у HКВ
   ek43_  :=null; --* Вторичный  Н17 Норматив MAX вiдкритоi вал поз у HКВ
   ek44_  :=null; --* Первичный (Вм) МАХ Вiдкрита валютна позицiя у БМ
   ek45_  :=null; --* Вторичный  Н18 Норматив MAX вiдкритоi вал поз у БМ
   exist_42_ := false;
-------------------
   ek1_   :=null; --  Первичный (ОЗ) Oсновнi Засоби
   ek2_   :=null; --  Первичный (В)  Biдвернення
   ek3_   :=null; --  Первичный (ОК) Oсновний Капiтал
   ek4_   :=null; --  Первичный (ДК) Додатковий Капiтал
   ek5_   :=null; --  Вторичный (К1) Невiдкоригований Капiтал
   ek7_   :=null; --  Первичный (Ар) Сумарнi, по ступеням ризику
   ek8_   :=null; --  Вторичный  Н3  Норматив платоспоможностi
   ek9_   :=null; --  Первичный (ЗА) Загальнi активи
   ek10_  :=null; --  Вторичный  Н6 Норматив короткої лiквiдностi
   ek11_  :=null; --            (Ккр) Кошти на кореспонтських рахунках
   ek12_  :=null; --            (Ка) Кошти в касi
   ek13_  :=null; --  \ Поточнi рахунки для розрахунку Н5
   ek135_ :=null; --  / Поточнi рахунки для розрахунку Н5
   ek136_ :=null; --  | Поточнi рахунки для розрахунку Н6
   ek14_  :=null; --  Вторичный  Н4 Норматив миттевоi лiквiдностi
   ek15_  :=null; --  Активи перв. та втор. лiквiдностi
   ek16_  :=null; --  Зобов`язання банку для Н5
   ek166_ :=null; --  Зобов`язання банку для Н6
   ek17_  :=null; --             Н5 Норматив поточної лiквiдностi
   ek18_  :=null; --           (Ал) Лiквiднi активи
   ek19_  :=null; --  Первичный (Ра) Робочi активи
   ek20_  :=null; --  Вторичный  Вiднош високолiк. до роб. активiв
   ek29_  :=null; --  Первичный (МБн) Заг.сума наданих мiжбан позик
   ek30_  :=null; --  Вторичный  Н12 Норматив макс.розм наданих мб позик
   ek31_  :=null; --  Первичный (ЦК) Заг сума зал централiзованих коштiв
   ek32_  :=null; --  Первичный (МБо) Заг сума отр мб позик
   ek33_  :=null; --  Вторичный  Н13 Норматив макс.розм отрим мб позик
   ek34_  :=null; --  Первичный (Кiн)Кошти, якi iнв на придбання часток
   ek46_  :=null; --  Первичный (Ппо) Прибуток пiсля оподаткувення
   ek47_  :=null; --  Вторичный      Дохiд на активи
   ek48_  :=null; --  Вторичный      Дохiд на капiтал
   ek49_  :=null;
   EK50_  :=null;
   RETURN 0;
END ek_null;
------------
FUNCTION ek_all RETURN DECIMAL IS
BEGIN
   exist_42_ := find_42(null);
   ek6_ :=ek6 (NULL,0);
   ek60_:=ek60 (NULL,0);
   ek21_:=ek21(NULL,0);
   ek22_:=ek22(NULL,0);
   ek23_:=ek23(NULL,0);
   ek24_:=ek24(NULL,0);
   ek25_:=ek25(NULL,0);
   ek26_:=ek26(NULL,0);
   ek27_:=ek27(NULL,0);
   ek28_:=ek28(NULL,0);

   ek38_:=ek38(NULL,0);
   ek39_:=ek39(NULL,0);

   ek381_:=ek381(NULL,0);
   ek391_:=ek391(NULL,0);

   ek382_:=ek382(NULL,0);
   ek392_:=ek392(NULL,0);

   ek40_:=ek40(NULL,0);
   ek41_:=ek41(NULL,0);
   ek42_:=ek42(NULL,0);
   ek43_:=ek43(NULL,0);
   ek44_:=ek44(NULL,0);
   ek45_:=ek45(NULL,0);
   RETURN 0;
END ek_all;
------------
FUNCTION find_42(dat_ IN DATE) RETURN boolean is
  datf_ date:=nvl(dat_, gl.bDATE);
  exist_42 number:=0;
  exist_C5 number:=0;
BEGIN
  -- проверяем формировался ли 42 файл за эту дату
     select decode(cnt, 0, 0, 1)
	 into exist_42
	 from (
         select count(*) cnt
         from tmp_nbu
         where datf=datf_ and
            kodf='42');

    -- если файл не формировался или текущий банковский день, то попытаемся его сформировать
     if exist_42 = 0 or datf_=gl.bDATE then
      -- проверяем формировался ли 42 файл за эту дату
       select count(*)
       into exist_C5
       from otc_c5_proc
       where datf = dat_;
       
       if exist_C5 = 0 then
          P_FC5(dat_=>datf_);
       end if;
       
       P_F42_Nn(dat_=>datf_, pmode_=>1);
     end if;

    return true;
end find_42;
------------
FUNCTION ek6 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Вторичный (К) Капiтал банку
  d_ date;
BEGIN /* Расчет капитала  по функции из отчетности, ее нам дал Овчарук */
   if dat_ is null then d_:=gl.bDATE; else d_:=dat_; end if;
   RETURN Rkapital (d_,NULL,NULL,3);
END ek6;
------------
FUNCTION ek60 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Первичный  статутний капiтал
  d_ date;
  sum_SK_ number:=0;
  nn_ number;
BEGIN /* Расчет капитала  по функции из отчетности, ее нам дал Овчарук */

IF ek60_ IS NULL THEN
If PR_=0 then
   if dat_ IS NOT NULL THEN
      -- за определенную дату по фактич ост из SALDOA
      SELECT nvl(SUM(s.ostf-s.dos+s.kos),0)INTO ek60_
      FROM  accounts a, saldoa s
      WHERE  a.acc=s.acc
        and a.kv= gl.baseval and a.nbs IN ('5000','5001','5002')
        and (s.acc,s.fdat)=
            (select acc, max(fdat) from saldoa
             where acc=s.acc and fdat<=DAT_ group by acc);
   else
      -- по плановым ост из ACCOUNTS
      SELECT nvl(SUM(ostB),0)   INTO ek60_
      FROM accounts WHERE kv=gl.baseval and nbs IN ('5000','5001','5002');
          -- + игровые оп из ACC_PLUS1
      SELECT nvl(SUM(ostB),0) INTO nn_ FROM ACC_PLUS1
      WHERE kv=gl.baseval and nbs IN ('5000','5001','5002');

Logger.info('EK Set_Mas_Ini - 60 do' );
      PUL.Set_Mas_Ini( 'EK60', TO_CHAR(ek60_+nn_), 'EK60' );
Logger.info('EK Set_Mas_Ini - 60 oposlja' );

   end if;
end if;
end if;
   RETURN ek60_;
END ek60;
------------
FUNCTION ek21 (DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_   decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- проверяем формировался ли 42 файл за эту дату
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- выбираем максимальный показатель (т.к. их может быть несколько по
         -- разным контрагентам)
         for cur in (select kodp, znap
                     from (
                        SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '01%'
                           AND t.datf = datf_
                           AND t.kodf = '42'
                           AND NOT EXISTS (
                                  SELECT 1
                                    FROM tmp_nbu n
                                   WHERE n.kodp = '05' || SUBSTR (t.kodp, 3)
                                     AND n.datf = datf_
                                     AND n.kodf = '42'
                                     AND n.znap = t.znap)
                        order by 2 desc)
                    where rownum=1) loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek21_:=nn_;

   RETURN ek21_;
END ek21;
----------------
FUNCTION ek22 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --Вторичный  Н7 Макс.ризику на 1 позичальника
  nn_ decimal;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek21(dat_,pr_)*10000/nn_ ; end if;
   ek22_:=nn_;
   RETURN ek22_;
END ek22;
--------------
FUNCTION ek23 (DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_ decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- проверяем формировался ли 42 файл за эту дату
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- выбираем показатель
         for cur in (SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '02%'
                           AND t.datf = datf_
                           AND t.kodf = '42') loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek23_:=nn_;

   RETURN ek23_;
END ek23;
----------------
FUNCTION ek24 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Вторичный  Н8 Норматив "великих" кредитних ризикiв
  nn_ decimal;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek23(dat_,pr_)*10000/nn_ ; end if;
   ek24_:=nn_;
   RETURN ek24_;
END ek24;
--------------
FUNCTION ek25(DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_ decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- проверяем формировался ли 42 файл за эту дату
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- выбираем максимальный показатель (т.к. их может быть несколько по
         -- разным контрагентам)
         for cur in (select kodp, znap
                     from (
                        SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '03%'
                           AND t.datf = datf_
                           AND t.kodf = '42'
                        order by 2 desc)
                    where rownum=1) loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek25_:=nn_;

   RETURN ek25_;
END ek25;
----------------
FUNCTION ek26 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Вторичный  Н9 Норматив макс.розмiру кр на 1 iнсайдера
  nn_ decimal;
BEGIN
   nn_:= ek60(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek25(dat_,pr_)*10000/nn_; end if;
   ek26_:=nn_;
   RETURN ek26_;
END ek26;
--------------
FUNCTION ek27(DAT_ IN DATE, PR_ in numeric) RETURN DECIMAL IS
  nn_ decimal :=0;
  datf_ date:=nvl(dat_, gl.bDATE);
BEGIN
   If PR_=0 then
         -- проверяем формировался ли 42 файл за эту дату
         if not exist_42_ then
           exist_42_ := find_42(datf_);
         end if;

         -- выбираем максимальный показатель (т.к. их может быть несколько по
         -- разным контрагентам)
         for cur in (   SELECT kodp, TO_NUMBER (znap) znap
                          FROM tmp_nbu t
                         WHERE t.kodp LIKE '04%'
                           AND t.datf = datf_
                           AND t.kodf = '42') loop
            nn_ := cur.znap;
         end loop;
   end if;

   ek27_:=nn_;

   RETURN ek27_;
END ek27;
----------------
FUNCTION ek28 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --Вторичный  Н7 Макс.ризику на 1 позичальника
  nn_ decimal;
BEGIN
   nn_:= ek60(dat_,pr_) ;
   if nn_ <> 0 THEN nn_:=  ek27(dat_,pr_)*10000/nn_; end if;
   ek28_:=nn_;
   RETURN ek28_;
END ek28;
--------------
FUNCTION ek38 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Первичный (Вп) Загальна вiдкрита валютна позицiя
  nn_ decimal;
BEGIN
IF ek38_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- за определенную дату по фактич ост из SALDOA
         SELECT nvl(SUM( ABS( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_))),0)
         INTO ek38_
         FROM  accounts a, saldoa s
         WHERE  a.acc=s.acc
           and a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc);
      else
         -- по плановым ост из ACCOUNTS
         SELECT nvl(SUM( ABS( EQV(kv,ostB) )),0)   INTO ek38_
         FROM   accounts WHERE  kv<> gl.baseval
           and acc in (select ACC3800 from vp_list);

         -- + игровые оп из ACC_PLUS1
         SELECT nvl(SUM(ABS(ostb)),0) INTO nn_ FROM ACC_PLUS1  WHERE nbs='3800';
         PUL.Set_Mas_Ini( 'EK38', TO_CHAR(ek38_+nn_), 'EK38' );
      end if;
   end if;
end if;
   RETURN ek38_;
END ek38;
------------
FUNCTION ek39 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --Вторичный Н13 Норматив загальної вiдкритоi вал поз
  nn_ decimal;  mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek39_:=ek38(dat_,pr_)*10000/nn_;


      If pr_=0 and dat_ IS NULL then
Logger.info('EK- 1 ' );
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK38'));
Logger.info('EK- 2 ' ||mm_ || ' '||nn_ );
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK39', TO_CHAR( mm_*10000/nn_), 'EK39' );
Logger.info('EK- 3 ' ||mm_ || ' '||nn_ );
         end if;
      end if;

   end if;
   RETURN ek39_;
END ek39;
------------
FUNCTION ek381 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Первичный (Вп-1) Загальна довга вiдкрита валютна позицiя
  nn_ decimal;
BEGIN
IF ek381_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- за определенную дату по фактич ост из SALDOA
         SELECT ABS( SUM( nvl(gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_),0)))
         INTO ek381_
         FROM  accounts a, saldoa s
         WHERE  a.acc=s.acc
           and a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
	   and s.ostf-s.dos+s.kos>0;
      else
         -- по плановым ост из ACCOUNTS
         SELECT abs(nvl(SUM(EQV(kv,ostB)),0))   INTO ek381_
         FROM   accounts WHERE  kv<> gl.baseval
           and acc in (select ACC3800 from vp_list)
	   and ostB>0;
         -- + игровые оп из ACC_PLUS1
         SELECT nvl(SUM(ostB),0) INTO nn_
         FROM ACC_PLUS1 WHERE nbs='3800' and ostB>0;
         PUL.Set_Mas_Ini( 'EK381', TO_CHAR(ek381_+nn_), 'EK381' );
      end if;
   end if;
end if;
   RETURN ek381_;
END ek381;
------------
FUNCTION ek391 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Вторичный  Н13-1 Норматив загальна довгої вiдкритоi вал поз
  nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek391_:=  ek381(dat_,pr_)*10000/nn_ ;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK381'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK391', TO_CHAR( mm_*10000/nn_), 'EK391' );
         end if;
      end if;

   end if;
   RETURN ek391_;
END ek391;
------------
FUNCTION ek382 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Первичный (Вп-2) Загальна коротка вiдкрита валютна позицiя
  nn_ decimal;
BEGIN
IF ek382_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- за определенную дату по фактич ост из SALDOA
         SELECT nvl(SUM( ABS( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_))),0)
         INTO ek382_
         FROM  accounts a, saldoa s
         WHERE  a.acc=s.acc
           and a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
	   and s.ostf-s.dos+s.kos <0;
      else
         -- по плановым ост из ACCOUNTS
         SELECT nvl(SUM(EQV(kv,ostB)),0)   INTO ek382_
         FROM   accounts WHERE  kv<> gl.baseval
           and acc in (select ACC3800 from vp_list)
	   and ostB<0;

         -- + игровые оп из ACC_PLUS1
         SELECT nvl(SUM(ostB),0) INTO nn_
	 FROM ACC_PLUS1 WHERE nbs='3800' and ostB<0;
         PUL.Set_Mas_Ini( 'EK382', TO_CHAR(ek382_+nn_), 'EK382' );
      end if;
   end if;
end if;
   RETURN ek382_;
END ek382;
------------
FUNCTION ek392 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  -- Вторичный  Н13-2 Норматив заг короткої вiдкритої вал поз
  nn_ decimal;  mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek392_:=  ek382(dat_,pr_)*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK382'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK392', TO_CHAR( mm_*10000/nn_), 'EK392' );
         end if;
      end if;

   end if;
   RETURN ek392_;
END ek392;
------------
FUNCTION ek40 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --Первичный (Вiн) МАХ Вiдкрита валютна позицiя у ВКВ
  nn_ decimal;
BEGIN
IF ek40_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- за определенную дату по фактич ост из SALDOA
         SELECT nvl(MAX(ABS(SUM(gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_)))),0)
         INTO ek40_
         FROM   accounts a,saldoa s, kl_r030 r
         WHERE  a.acc in (select acc3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='2' and
                a.acc=s.acc and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
         GROUP BY a.kv ;
      else
         -- по плановым ост из ACCOUNTS
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)    INTO ek40_
         FROM   accounts a, kl_r030 r WHERE  a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='2'
         GROUP BY a.kv ;

         -- + игровые оп из ACC_PLUS1
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)
         INTO nn_ FROM ACC_PLUS1 a, kl_r030 r
         WHERE a.nbs='3800' and a.kv=r.r030+0 and r.r031='2'
         GROUP BY a.kv ;

         PUL.Set_Mas_Ini( 'EK40', TO_CHAR(ek40_+nn_), 'EK40' );
      end if;
   end if;
end if;
   RETURN ek40_;
END ek40;
------------
FUNCTION ek41 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --Вторичный Н16 Норматив MAX вiдкритоi вал поз у ВКВ
  nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek41_:=ABS(ek40(dat_,pr_))*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK40'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK41', TO_CHAR( mm_*10000/nn_), 'EK41' );
         end if;
      end if;

   end if;
   RETURN ek41_;
END ek41;
-------------------
FUNCTION ek42 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --Первичный Вн МАХ Вiдкрита валютна позицiя у HКВ
  nn_ decimal;
BEGIN
IF ek42_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- за определенную дату по фактич ост из SALDOA
         SELECT   nvl(MAX( ABS(SUM( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_) ))),0)
         INTO ek42_
         FROM   accounts a,saldoa s,  kl_r030 r
         WHERE  a.acc in (select acc3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='3'
           and a.acc=s.acc and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
         GROUP BY a.kv ;
      else
         -- по плановым ост из ACCOUNTS
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)    INTO ek42_
         FROM   accounts a, kl_r030 r WHERE  a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='3'
         GROUP BY a.kv ;

         -- + игровые оп из ACC_PLUS1
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)
         INTO nn_ FROM ACC_PLUS1 a, kl_r030 r
         WHERE a.nbs='3800' and a.kv=r.r030+0 and r.r031='3'
         GROUP BY a.kv ;

         PUL.Set_Mas_Ini( 'EK42', TO_CHAR(ek42_+nn_), 'EK42' );
      end if;
   end if;

end if;
   RETURN ek42_;
END ek42;
-------------------
FUNCTION ek43 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
   --Вторичный Н17 Норматив MAX вiдкритоi вал поз у HКВ
   nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek43_:=ABS(ek42(dat_,pr_))*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK42'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK43', TO_CHAR( mm_*10000/nn_), 'EK43' );
         end if;
      end if;

   end if;
   RETURN ek43_;
END ek43;
---------------
FUNCTION ek44 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
   --Первичный Вм МАХ Вiдкрита валютна позицiя у БМ
   nn_ decimal;
BEGIN
IF ek44_ IS NULL THEN
   IF pr_=0 THEN
      if dat_ IS NOT NULL THEN
         -- за определенную дату по фактич ост из SALDOA
         SELECT   nvl(MAX( ABS(SUM( gl.p_icurval(a.kv,s.ostf-s.dos+s.kos,dat_) ))),0)
         INTO ek44_
         FROM   accounts a, saldoa s, kl_r030 r
         WHERE  a.acc in (select acc3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='4'
                and a.acc=s.acc and (s.acc,s.fdat)=
               (select acc, max(fdat) from saldoa
                where acc=s.acc and fdat<=DAT_ group by acc)
         GROUP BY a.kv ;
      else
         -- по плановым ост из ACCOUNTS
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)    INTO ek44_
         FROM   accounts a, kl_r030 r WHERE  a.kv<> gl.baseval
           and a.acc in (select ACC3800 from vp_list)
           and a.kv=r.r030+0 and r.r031='4'
         GROUP BY a.kv ;

         -- + игровые оп из ACC_PLUS1
         SELECT nvl(MAX(ABS( SUM( a.ostB ))),0)
         INTO nn_ FROM ACC_PLUS1 a, kl_r030 r
         WHERE a.nbs='3800' and a.kv=r.r030+0 and r.r031='4'
         GROUP BY a.kv ;

         PUL.Set_Mas_Ini( 'EK44', TO_CHAR(ek44_+nn_), 'EK44' );
      end if;
   end if;
end if;
   RETURN ek44_;
END ek44;
---------------
FUNCTION ek45 (dat_ IN DATE, pr_ in numeric) RETURN DECIMAL IS
  --Вторичный Н18 Норматив MAX вiдкритоi вал поз у БМ-----
  nn_ decimal; mm_ number;
BEGIN
   nn_:= ek6(dat_,pr_) ;
   if nn_ <> 0 THEN
      ek45_:=ABS(ek44(dat_,pr_))*10000/nn_;

      If pr_=0 and dat_ IS NULL then
         mm_:=to_number(PUL.Get_Mas_Ini_Val('EK44'));
         If mm_ is not null then
            PUL.Set_Mas_Ini( 'EK45', TO_CHAR( mm_*10000/nn_), 'EK45' );
         end if;
      end if;

   end if;
   RETURN ek45_;
END ek45;
---------
PROCEDURE  p_ek_pok_day(dat_ DATE) IS
  --Накопление показателей за день в ek_pok_day
  nn_ decimal;
BEGIN
  DELETE FROM ek_pok_day WHERE fdat=dat_;
  nn_  :=ek_null;
  exist_42_ := find_42(dat_);
  ek6_ :=ek6 (dat_,0);
  ek60_ :=ek60 (dat_,0);
  ek21_:=ek21(dat_,0);
  ek22_:=ek22(dat_,0);
  ek23_:=ek23(dat_,0);
  ek24_:=ek24(dat_,0);
  ek25_:=ek25(dat_,0);
  ek26_:=ek26(dat_,0);
  ek27_:=ek27(dat_,0);
  ek28_:=ek28(dat_,0);

  ek38_:=ek38(dat_,0);
  ek39_:=ek39(dat_,0);

  ek381_:=ek381(dat_,0);
  ek391_:=ek391(dat_,0);

  ek382_:=ek382(dat_,0);
  ek392_:=ek392(dat_,0);

  ek40_:=ek40(dat_,0);
  ek41_:=ek41(dat_,0);
  ek42_:=ek42(dat_,0);
  ek43_:=ek43(dat_,0);
  ek44_:=ek44(dat_,0);
  ek45_:=ek45(dat_,0);

  insert into ek_pok_day(fdat,pok,s) values (dat_,6 ,ek6_ );
  insert into ek_pok_day(fdat,pok,s) values (dat_,60 ,ek60_ );

  insert into ek_pok_day(fdat,pok,s) values (dat_,21,ek21_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,22,ek22_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,23,ek23_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,24,ek24_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,25,ek25_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,26,ek26_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,27,ek27_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,28,ek28_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,38,ek38_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,39,ek39_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,381,ek381_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,391,ek391_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,382,ek382_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,392,ek392_);

  insert into ek_pok_day(fdat,pok,s) values (dat_,40,ek40_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,41,ek41_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,42,ek42_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,43,ek43_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,44,ek44_);
  insert into ek_pok_day(fdat,pok,s) values (dat_,45,ek45_);
  commit;
END p_ek_pok_day;
------------------
PROCEDURE p_ek_pok_2day(kol_ number default 1) is
-- пересчет и накопление в архив данных за несколько дней от тек. банк. даты
	cdat_   date:=gl.bDATE;
begin
    for i in (select fdat
	          from (
    	          select fdat
    	          from (
    	            SELECT fdat
                	FROM fdat
                	WHERE fdat<=cdat_
    				order by 1 desc)
    			  where rownum<=kol_)
			order by 1) loop
	    p_ek_pok_day(i.fdat);
	end loop;

end p_ek_pok_2day;
------------------
END ek;
/
 show err;
 
PROMPT *** Create  grants  EK ***
grant EXECUTE                                                                on EK              to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on EK              to START1;
grant EXECUTE                                                                on EK              to TECH006;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/ek.sql =========*** End *** ========
 PROMPT ===================================================================================== 
 