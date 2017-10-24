

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ANALIZ_R013.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ANALIZ_R013 ***

  CREATE OR REPLACE PROCEDURE BARS.P_ANALIZ_R013 (
   ------------------------------------------------------------------------------------
   -- VERSION: 20/08/2013 (15/08/2013)
   ------------------------------------------------------------------------------------
   -- 20/08/2013 зміни в довіднику KL_R013
   -- 17/01/2013 для 1528 не будем разбивать остаток по R013 для ГОУ (замечание Немченко)
   -- 15/11/2012 для бал.рах. 3018, 3118, 3218 i R013='9' розбивку не виконуємо
   --            (зауваження УПБ)
   -- 22/05/2012 для банку УКООП розбивати завжди по оборотам
   -- 20.12.2011 Доопрацювала по зауваження ГОУ після впровадження кредитного модуля ЮО
   -- 13.12.2011 Доопрацювала по зауваження ГОУ після впровадження кредитного модуля ЮО
   -- 04.05.2011 к Дт оборотам за отчетный месяц добавляем корректирующие проводки
   -- 06.05.2011 для корпроводок вместо VIEW PROVODKI будем использовать табл.OPLDOK
   ------------------------------------------------------------------------------------
   mfo_       IN       NUMBER,
   mfou_      IN       NUMBER,
   dat_       IN       DATE,
   acc_       IN       NUMBER,
   nbs_       IN       VARCHAR2,
   kv_        IN       SMALLINT,
   r013_      IN       VARCHAR2,
   se_        IN       DECIMAL,
   ----------------------------
   nd_        OUT      NUMBER,
   -- ДО 30 ДНЕЙ
   o_r013_1   OUT      VARCHAR2,
   o_se_1     OUT      DECIMAL,
   o_comm_1   OUT      rnbu_trace.comm%TYPE,
   -- ПОСЛЕ 30 ДНЕЙ
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
   tip_        accounts.tip%type;

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
            AND (d_close IS NULL OR d_close >= dat_);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            find_ok := 0;
      END;

      -- балансовые счета, у котрых только 2 значения параметра (3 и 4)
      IF p_nbs_ NOT IN
            ('1408',
             '1418',
             '1428',
             '1518',
             '1528',
             '2108',
             '2118',
             '2128',
             '2138',
             '2238',
             '3018',
             '3118',
             '3218'
            ) or
          p_nbs_ IN
            ('2108',
             '2118',
             '2128',
             '2138') and
          dat_ < to_date('20082013','ddmmyyyy')
      THEN
         IF tp_ = 1
         THEN                                                   -- до 30 дней
            r013_new := '3';
         ELSE                                                 -- свыше 30 дней
            r013_new := '4';
         END IF;
      ELSE
         -- неоднозначные комбинации параметров
         IF p_nbs_ IN ('1408', '1418', '1428')
         THEN
            IF find_ok = 1
            THEN                                  -- есть такие в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  IF r013_old IN ('3', '5', '9')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- свыше 30 дней
                  IF r013_old IN ('2', '4', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE         -- нет в справочнике - тогда неизвестно, что ставить?
               --r013_new := '0';
               NULL;                                      -- не меняем ничего
            END IF;
         END IF;

         IF p_nbs_ IN ('1518', '1528')
         THEN
            IF find_ok = 1
            THEN                                  -- есть такие в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  IF r013_old IN ('7', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 2);
                  END IF;
               ELSE                                           -- свыше 30 дней
                  IF r013_old IN ('5', '6')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 2);
                  END IF;
               END IF;
            ELSE                                          -- нет в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  r013_new := '5';
               ELSE                                           -- свыше 30 дней
                  r013_new := '7';
               END IF;
            END IF;
         END IF;

         IF p_nbs_ IN ('2108', '2118', '2128', '2138')
         THEN
            IF find_ok = 1
            THEN                                  -- есть такие в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  IF r013_old IN ('6', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- свыше 30 дней
                  IF r013_old IN ('5', '7')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE                                          -- нет в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  r013_new := '7';
               ELSE                                           -- свыше 30 дней
                  r013_new := '8';
               END IF;
            END IF;
         END IF;

         IF p_nbs_ IN ('2238')
         THEN
            IF find_ok = 1
            THEN                                  -- есть такие в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  IF r013_old IN ('4', '9')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- свыше 30 дней
                  IF r013_old IN ('3', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE                                          -- нет в справочнике
               IF kv_ <> 980
               THEN
                  IF tp_ = 1
                  THEN                                          -- до 30 дней
                     r013_new := '8';
                  ELSE                                        -- свыше 30 дней
                     r013_new := '9';
                  END IF;
               ELSE
                  NULL;                                   -- не меняем ничего
               END IF;
            END IF;
         END IF;

         IF p_nbs_ IN ('3018', '3118', '3218') and r013_old <> '9'
         THEN
            IF find_ok = 1
            THEN                                  -- есть такие в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  IF r013_old IN ('4', '6', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- свыше 30 дней
                  IF r013_old IN ('3', '5', '7')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE                                          -- нет в справочнике
               IF tp_ = 1
               THEN                                             -- до 30 дней
                  r013_new := '3';
               ELSE                                           -- свыше 30 дней
                  r013_new := '4';
               END IF;
            END IF;
         END IF;
      END IF;

      RETURN r013_new;
   END;
BEGIN
   o_r013_2 := '0';
   o_se_2 := 0;
   o_comm_2 := NULL;

   if mfo_ = 300465 and nbs_ = '1528' then
      o_r013_1 := r013_;
      o_comm_1 := comm_ || ' для 1528 не міняємо R013';
      o_se_1 := se_;

      return;
   end if;

   BEGIN
     IF SIGN (se_) = -1                                        -- кредиты
     THEN
        SELECT nd
          INTO nd_
          FROM nd_acc
         WHERE acc = acc_ AND ROWNUM = 1;

        -- определяем периодичность гашения процнтов
        SELECT i.freq
          INTO freq_
          FROM nd_acc n8, accounts a8, int_accn i
         WHERE n8.nd = nd_
           AND n8.acc = a8.acc
           AND a8.nls LIKE '8999%'
           AND a8.acc = i.acc
           AND i.ID = 0
           AND ROWNUM = 1;

        comm_ := comm_ || ' (КП Реф=' || TO_CHAR (nd_) || ')';
     ELSE
        freq_ := NULL;
     END IF;
   EXCEPTION
     WHEN NO_DATA_FOUND
     THEN
        freq_ := NULL;
   END;

   comm_ := comm_ || ' freq=' || TO_CHAR (freq_);

   if mfo_ = 300465 then
      select tip
      into tip_
      from accounts
      where acc = acc_;
   end if;

   IF 322625 NOT IN (mfo_, mfou_)  AND
      306566 NOT IN (mfo_, mfou_)  AND
      353575 NOT IN (mfo_, mfou_)  AND
      NVL(freq_, 400) = 5 and
      not (mfo_ = 300465 and tip_ = 'SNO')
   THEN                                             -- погашение % ежемесячное
      o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);

      IF o_r013_1 <> r013_
      THEN
         o_comm_1 := comm_ || ' заміна R013 (0) ';
      END IF;

      o_se_1 := se_;
   elsif mfo_ = 300465 and tip_ = 'SNO' then
      -- Долинченко и Сухова: относить с таким типом к R013 = 4
      if r013_ = '3' then
         o_r013_1 := r013_;
         o_comm_1 := comm_ || ' (SNO) не міняємо R013='||r013_;
         o_se_1 := se_;
      elsif r013_ = '4' then
         o_r013_2 := r013_;
         o_comm_2 := comm_ || ' (SNO) не міняємо R013='||r013_;
         o_se_2 := se_;
      else
         o_r013_1 := '3';
         o_comm_1 := comm_ || ' (SNO) міняємо R013='||r013_||' на 3';
         o_se_1 := se_;
      end if;
   elsif 322625 IN (mfo_, mfou_)  AND r013_ = '4' then
      -- до 30 дней
      o_r013_1 := NULL;
      o_comm_1 := NULL;
      o_se_1 := 0;

      -- свыше 30 дней
      o_r013_2 := r013_;
      o_comm_2 := comm_ || ' не міняємо R013';
      o_se_2 := se_;
   ELSE                                          -- погашение % НЕ ежемесячное
      -- ищем обороты по начислению % на протяжении 30 дней
      SELECT (-1) * NVL (SUM (dos), 0)
        INTO dos_
        FROM saldoa
       WHERE acc = acc_ AND fdat BETWEEN dat_ - 29 AND dat_;

      -- 18/09/2009 По просьбе Демарка для счетов у которых было перенесение остатка
      -- с одного счета на другой в пределах договора и балансового счета
      -- нужно считать обороты до 30 дней по старому счету
      if 353575 in (mfo_, mfou_) and dos_<>0 then
         declare
            acc2_ number;
            mindat_   date;
            dosO_ number:=0;
            dosN_ number:=0;
         begin
           select min(fdat)
           into mindat_
           from saldoa
           WHERE acc = acc_ AND
                 fdat BETWEEN dat_ - 29 AND dat_ and
                 ostf = 0;

           dbms_output.put_line('mindat='||to_char(mindat_, 'dd.mm.yyyy'));

           select n2.acc
           into acc2_
           from nd_acc n1, nd_acc n2, accounts a
           WHERE n1.acc = acc_ AND
                 n1.nd = n2.nd and
                 n2.acc <> acc_ AND
                 n2.acc = a.acc and
                 a.nbs = nbs_ and
                 a.kv = kv_ and
                 exists (select 1
                         from saldoa s
                         where s.acc = n2.acc and
                               s.fdat = mindat_ and
                               s.ostf-s.dos+s.kos=0);

           dbms_output.put_line('acc2='||to_char(acc2_));

           if acc2_ is not null then
             -- обороты по старому счету
             SELECT (-1) * NVL (SUM (dos), 0)
               INTO dosO_
               FROM saldoa
              WHERE acc = acc2_ AND fdat BETWEEN dat_ - 29 AND dat_;

             -- плюс обороты по новому счету
             SELECT (-1) * NVL (SUM (dos), 0)
               INTO dosN_
               FROM saldoa
              WHERE acc = acc_ AND fdat BETWEEN mindat_ + 1 AND dat_;

              dos_ := dosO_ + dosN_;
           end if;

           dbms_output.put_line('dos='||to_char(dos_));

         exception
            when no_data_found then
                null;
         end;
      end if;

      -- корректирующие обороты отчетного месяца
      SELECT NVL (SUM (o.s), 0)
         INTO dos_kor_
      FROM opldok o, oper p
      WHERE o.acc = acc_
        AND o.fdat between dat_+1 and dat_+28
        AND o.sos = 5
        AND o.dk = 0
        AND o.ref = p.ref
        and p.vob = 96;

      -- корректирующие обороты предыдущего месяца
      SELECT NVL (SUM (o.s), 0)
         INTO dos_korp_
      FROM opldok o, oper p
      WHERE o.acc = acc_
        AND o.fdat BETWEEN dat_ - 29 AND dat_
        AND o.sos = 5
        AND o.ref = p.ref
        and p.vob = 96;

      dos_ := dos_ - dos_kor_ + dos_korp_;

      IF kv_ <> 980
      THEN
         dose_ := gl.p_icurval (kv_, dos_, dat_);
      ELSE
         dose_ := dos_;
      END IF;

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

         o_se_2 := se_;
      ELSIF ABS (se_) >= ABS (dose_)
      -- если остаток больше оборотов - нужно его разбивать
      THEN
         -- если обороты на протяжении 30 дней были
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);
         o_comm_1 := comm_ || ' розбивка залишку';
         o_se_1 := dose_;
         -- остальная часть остатка
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);
         o_comm_2 := comm_ || ' розбивка залишку';
         o_se_2 := se_ - dose_;
      ELSE
         -- если остаток меньше оборотов, то просто относим его к до 30 дней
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);

         IF o_r013_1 <> r013_
         THEN
            o_comm_1 := comm_ || ' заміна R013 (2) ';
         END IF;

         o_se_1 := se_;
      END IF;
   END IF;
END;
/
show err;

PROMPT *** Create  grants  P_ANALIZ_R013 ***
grant EXECUTE                                                                on P_ANALIZ_R013   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ANALIZ_R013.sql =========*** End
PROMPT ===================================================================================== 
