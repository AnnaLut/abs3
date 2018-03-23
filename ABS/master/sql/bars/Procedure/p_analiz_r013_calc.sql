CREATE OR REPLACE PROCEDURE BARS.P_ANALIZ_R013_CALC (
-------------------------------------------------------------------------------
-- VERSION: 29.12.2017
-------------------------------------------------------------------------------
-- 26.12.2017 новые значения для r013
-- 25.10.2016 для SN обороты ДТ со счетов SNO сопоставляются оборотам КТ в более
--             поздние даты для расчета R013 >30дн
-- 28.07.2016 для счетов SN обороты ДТ со счетов SNO учитываются с R013 >30дн
-- 11/11/2015 зміни в довіднику KL_R013
-- 20/08/2013 зміни в довіднику KL_R013
-- 17/01/2013 для 1528 не будем разбивать остаток по R013 для ГОУ (замечание Немченко)
-------------------------------------------------------------------------------
   type_calc  in       NUMBER, -- 1 -для C5 та A7, 2 -для резервів та місячних
   mfo_       IN       NUMBER,
   mfou_      IN       NUMBER,
   dat_       IN       DATE,
   acc_       IN       NUMBER,
   tip_       in       VARCHAR2,
   nbs_       IN       VARCHAR2,
   kv_        IN       SMALLINT,
   r013_      IN       VARCHAR2,
   se_        IN       DECIMAL,
   nd_        IN       NUMBER,
   freqp_     in       NUMBER,
   ----------------------------
   --         ДО 30 ДНЕЙ
   o_r013_1   OUT      VARCHAR2,
   o_se_1     OUT      DECIMAL,
   o_comm_1   OUT      rnbu_trace.comm%TYPE,
   --      СВЫШЕ 30 ДНЕЙ
   o_r013_2   OUT      VARCHAR2,
   o_se_2     OUT      DECIMAL,
   o_comm_2   OUT      rnbu_trace.comm%TYPE
)
IS
   s_           NUMBER;
   freq_        NUMBER;
   apl_dat_     DATE;
   comm_        rnbu_trace.comm%TYPE:='';
   dos_         NUMBER;
   dose_        NUMBER;
   dos_kor_     NUMBER;
   dos_korp_    NUMBER;

   l_se_        NUMBER;   --переменная, которая хранит se_ (значение меняется)
   dos_dat_     DATE;     --первая дата оборота ДТ счета SN внутри периода
   dos_sn_      NUMBER;   --сумма оборотов ДТ со счетов SNO, номинал
   dose_sn_     NUMBER;   --сумма оборотов ДТ со счетов SNO, эквивалент
   kos_sn_      NUMBER;   --сумма оборотов КТ счетов SN, номинал

   FUNCTION f_ret_r013 (
      p_nbs_     IN   VARCHAR2,
      p_kv_      IN   NUMBER,
      r013_old   IN   VARCHAR2,
      tp_        IN   NUMBER
   )
      RETURN VARCHAR2
   IS
      r013_new   VARCHAR2 (1) := r013_old;
      find_ok    NUMBER;
   BEGIN
      BEGIN
         SELECT COUNT (*)
           INTO find_ok
           FROM kl_r013
          WHERE trim(prem) = 'КБ'
            AND r020 = p_nbs_
            AND r013 = r013_old
            and d_open < dat_
            AND (d_close IS NULL OR d_close >= dat_);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            find_ok := 0;
      END;

      -- балансовые счета, у которых только 2 значения параметра (2 и 3)
      if p_nbs_ in ('1438','1448','1458')  then
           r013_new := '9';
      else
             IF tp_ = 1
             THEN                                                   -- до 30 дней
                r013_new := '2';
             ELSE                                                 -- свыше 30 дней
                r013_new := '3';
             END IF;
      end if;

      RETURN r013_new;
   END;
BEGIN
   o_r013_2 := '0';
   o_se_2 := 0;
   o_comm_2 := NULL;

   IF SIGN (se_) = -1                                        -- кредиты
   THEN
    -- определяем периодичность гашения процентов
     freq_ := freqp_;

     if nd_ is not null then
       comm_ := comm_ || ' (КП Реф=' || TO_CHAR (nd_) || ')';
     end if;
   ELSE
     freq_ := NULL;
   END IF;

   comm_ := comm_ || ' freq=' || TO_CHAR (freq_);

----------------------------------------------------------------------------¬
   l_se_ :=se_;         --включено для возможности корректировки остатка
   dose_sn_ :=0;
   dos_sn_ :=0;
   kos_sn_ :=0;

   -- для счетов SN дополнительно определяются ДТ обороты в корреспонденции
   -- со счетами SNO для отображения в разрезе R013 >30дн
   if type_calc =1 and trim(tip_) ='SN'  then
      begin
          select nvl(sum(od.s),0),
                 min(od.fdat)
          into dos_sn_, dos_dat_
          from opldok od, opldok ok, accounts ak
          where od.fdat  between dat_ -29 and dat_
            and od.acc = acc_
            and od.dk = 0
            and od.sos = 5
            and od.ref = ok.ref
            and od.fdat = ok.fdat
            and od.stmt = ok.stmt
            and ok.fdat  between dat_ -29 and dat_
            and ok.dk = 1
            and ok.sos = 5
            and ok.acc = ak.acc
            and ak.tip = 'SNO';
      exception
         when others  then  dos_sn_ :=0;
                            dos_dat_ :=NULL;
      end;

      if dos_sn_ != 0 and dos_dat_ is not null  then
           begin
              select sum(ok.s)
              into kos_sn_
              from opldok ok
              where ok.fdat  between dos_dat_  and dat_
                and ok.acc = acc_
                and ok.dk = 1
                and ok.sos = 5
              group by ok.acc;
           exception
              when others  then  kos_sn_ :=0;
           end;

           if dos_sn_ > kos_sn_  then
              dos_sn_ := (-1)* (dos_sn_-kos_sn_);

              if kv_ !=980  then
                  dose_sn_ := gl.p_icurval(kv_, dos_sn_, dat_);
              else
                  dose_sn_ := dos_sn_;
              end if;

           else
              dos_sn_ := 0;
              dose_sn_ := 0;
           end if;
      end if;
   end if;

   IF NVL(freq_, 400) = 5 and
      not (300465 IN (mfo_, mfou_) and tip_ in ('SNO')) and
      tip_ not in ('SPN', 'SK9', 'OFR', 'KK9', 'KPN') 
   THEN                                             -- погашение % ежемесячное
      -----------------------------------------------------------------------------
      --   корректировка остатка с учетом наличия оборотов ДТ с SNO
      if type_calc =1 and trim(tip_) ='SN' and dose_sn_ !=0  then
         if abs(dose_sn_) >= abs(l_se_)  then
            dose_sn_ := l_se_ ;
            l_se_ := 0;
         else
            l_se_ := l_se_ -dose_sn_;
         end if;

--    свыше 30 дней  -создать o_r013_2, заполнив  o_se_2  значением  dose_sn
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);
         o_comm_2 := comm_ || ' оборот з SNO';
         o_se_2 := dose_sn_;

--    до 30 дней
         o_r013_1 := NULL;
         o_comm_1 := NULL;
         o_se_1 := 0;

         if l_se_ !=0  then
            o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);
            o_comm_1 := comm_ || ' без обороту(погашений) SNO';
            o_se_1 := l_se_;
         end if;
-----------------------------------------------------------------------------
      else
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);

         IF o_r013_1 <> r013_
         THEN
            o_comm_1 := comm_ || ' заміна R013 (0) ';
         END IF;

         o_se_1 := se_;
      end if;
   elsif 300465 IN (mfo_, mfou_) and tip_ = 'SNO' then
      -- Долинченко и Сухова: относить с таким типом к R013 = 4
      if r013_ = '2' then
         o_r013_1 := r013_;
         o_comm_1 := comm_ || ' (SNO) не міняємо R013='||r013_;
         o_se_1 := se_;
      elsif r013_ = '3' then
         o_r013_2 := r013_;
         o_comm_2 := comm_ || ' (SNO) не міняємо R013='||r013_;
         o_se_2 := se_;
      else
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);

         if o_r013_1 = r013_ then
            o_se_1 := se_;
            o_comm_1 := comm_ || ' (SNO) не міняємо R013='||r013_;
            o_r013_2 := null;
         elsif o_r013_2 = r013_ then
            o_se_2 := se_;
            o_comm_2 := comm_ || ' (SNO) не міняємо R013='||r013_;
            o_r013_1 := null;
         else
            o_se_1 := se_;
            o_comm_1 := comm_ || ' (SNO) міняємо R013='||r013_||' на '||o_r013_1;
            o_r013_2 := null;
         end if;
      end if;
   elsif tip_ in ('SPN', 'SK9', 'OFR', 'KK9', 'KPN') then -- після переходу на новий ПР відносимо простроченівідсотки  до > 30 днів
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);
         o_comm_2 := comm_ || ' (SPN, тобто > 30 днів) міняємо R013='||r013_||' на '||o_r013_2;
         o_se_2 := se_;
   ELSE                                          -- погашение % НЕ ежемесячное
      -- ищем обороты по начислению % на протяжении 30 дней
      SELECT (-1) * NVL (SUM (dos), 0)
        INTO dos_
        FROM saldoa
       WHERE acc = acc_ AND fdat BETWEEN dat_ - 29 AND dat_;

      if ABS (se_) > ABS(gl.p_icurval (kv_, dos_, dat_)) and type_calc = 2 then
          -- корректирующие обороты отчетного месяца
          dos_kor_ := f_get_dos_kor(acc_, dat_ + 1, dat_ + 28);

          if dos_ <> 0 then
              -- корректирующие обороты предыдущего месяца
             dos_korp_ := f_get_dos_kor(acc_, dat_ - 29, dat_);
          else
             dos_korp_ := 0;
          end if;

          if ABS(dos_korp_) > ABS(dos_) then
             dos_korp_ := 0;
          end if;

          dos_ := dos_ - dos_kor_ + dos_korp_;
      end if;

      IF kv_ <> 980
      THEN
         dose_ := gl.p_icurval (kv_, dos_, dat_);
      ELSE
         dose_ := dos_;
      END IF;

-----------------------------------------------------------------------------
--   корректировка остатка/оборота с учетом наличия оборотов ДТ с SNO
      if type_calc =1 and trim(tip_) ='SN' and dose_sn_ !=0  then
         if abs(dose_sn_) >= abs(l_se_)  then
            dose_sn_ := l_se_ ;
            l_se_ := 0;
            dose_ := 0;
         else
            l_se_ := l_se_ -dose_sn_;
            dose_ := dose_ -dose_sn_;
         end if;
      end if;
-----------------------------------------------------------------------------
      -- если не начислялись % на протяжении 30 дней,
      -- то все остатки относим к свыше 30 дней
      IF dose_ = 0
      THEN
         -- до 30 дней
         o_r013_1 := NULL;
         o_comm_1 := NULL;
         o_se_1 := 0;

         -- свыше 30 дней
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);

         IF o_r013_2 <> r013_
         THEN
            o_comm_2 := comm_ || ' заміна R013 (1) ';
         END IF;

         o_se_2 := l_se_;

      ELSIF ABS (l_se_) >= ABS (dose_)
      -- если остаток больше оборотов - нужно его разбивать
      THEN
         -- если обороты на протяжении 30 дней были
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);
         o_comm_1 := comm_ || ' розбивка залишку';
         o_se_1 := dose_;

         -- остальная часть остатка
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);
         o_comm_2 := comm_ || ' розбивка залишку';
         o_se_2 := l_se_ - dose_;

      ELSE
         -- если остаток меньше оборотов, то просто относим его к до 30 дней
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);

         IF o_r013_1 <> r013_
         THEN
            o_comm_1 := comm_ || ' заміна R013 (2) ';
         END IF;

         o_se_1 := l_se_;
      END IF;
----------------------------------------------------------------------------¬
--   создать/дополнить o_r013_2,o_se_2 ненулевой суммой dose_sn (оборотоы ДТ с SNO
      if dose_sn_ !=0  then

         if o_r013_2 is null  then

            o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);
            o_comm_2 := comm_ || ' оборот з рахунку SNO';
            o_se_2 := dose_sn_;
         else

            o_comm_2 := comm_ || '+оборот з рахунку SNO';
            o_se_2 := o_se_2+dose_sn_;
         end if;

      end if;
-----------------------------------------------------------------------------
   END IF;

END;
/