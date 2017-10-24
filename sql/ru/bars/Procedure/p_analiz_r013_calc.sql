

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ANALIZ_R013_CALC.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ANALIZ_R013_CALC ***

  CREATE OR REPLACE PROCEDURE BARS.P_ANALIZ_R013_CALC (
   ------------------------------------------------------------------------------------
   -- VERSION: 09/12/2015 (11/11/2015)
   ------------------------------------------------------------------------------------
   -- 11/11/2015 ���� � �������� KL_R013
   -- 20/08/2013 ���� � �������� KL_R013
   -- 17/01/2013 ��� 1528 �� ����� ��������� ������� �� R013 ��� ��� (��������� ��������)
   ------------------------------------------------------------------------------------
   type_calc  in       NUMBER, -- 1 - ��� C5 �� A7, 2 - ��� ������� �� �������
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
   -- �� 30 ����
   o_r013_1   OUT      VARCHAR2,
   o_se_1     OUT      DECIMAL,
   o_comm_1   OUT      rnbu_trace.comm%TYPE,
   -- ����� 30 ����
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
          WHERE trim(prem) = '��'
            AND r020 = p_nbs_
            AND r013 = r013_old
            AND (d_close IS NULL OR d_close >= dat_);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            find_ok := 0;
      END;

      -- ���������� �����, � ������ ������ 2 �������� ��������� (3 � 4)
      IF p_nbs_ NOT IN
            ('1408',
             '1418',
             '1428',
             '1508',
             '1518',
             '1528',
             '2068',
             '2088',
             '2108',
             '2118',
             '2128',
             '2138',
             '2238',
             '3018',
             '3118',
             '3218',
             '3328',
             '3338',
             '3348'
            ) or
          p_nbs_ IN
            ('2108',
             '2118',
             '2128',
             '2138') and
          dat_ <  to_date('12092015','ddmmyyyy')
      THEN
         if p_nbs_ = '1438' then -- "�������������" �������, ��� ����� ���� �������� �� R013
            r013_new := '0';
         else
             IF tp_ = 1
             THEN                                                   -- �� 30 ����
                r013_new := '3';
             ELSE                                                 -- ����� 30 ����
                r013_new := '4';
             END IF;
         end if;
      ELSE
         -- ������������� ���������� ����������
         IF p_nbs_ IN ('1408', '1418', '1428')
         THEN
            IF find_ok = 1
            THEN                                  -- ���� ����� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  IF r013_old IN ('3', '5', '9')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- ����� 30 ����
                  IF r013_old IN ('2', '4', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE         -- ��� � ����������� - ����� ����������, ��� �������?
               NULL;                                      -- �� ������ ������
            END IF;
         END IF;

         IF p_nbs_ IN ('1508', '2068')
         THEN
            IF find_ok = 1
            THEN                                  -- ���� ����� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  IF r013_old IN ('4', '6')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- ����� 30 ����
                  IF r013_old IN ('3', '5')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE         -- ��� � ����������� - ����� ����������, ��� �������?
               NULL;                                      -- �� ������ ������
            END IF;
         END IF;

         IF p_nbs_ IN ('1518', '1528', '2088')
         THEN
            IF find_ok = 1
            THEN                                  -- ���� ����� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  IF r013_old IN ('7', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 2);
                  END IF;
               ELSE                                           -- ����� 30 ����
                  IF r013_old IN ('5', '6')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 2);
                  END IF;
               END IF;
            ELSE                                          -- ��� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  r013_new := '5';
               ELSE                                           -- ����� 30 ����
                  r013_new := '7';
               END IF;
            END IF;
         END IF;

         IF p_nbs_ IN ('2108', '2118', '2128')
         THEN
            IF find_ok = 1
            THEN                                  -- ���� ����� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  IF r013_old IN ('6', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  ELSIF r013_old IN ('A')
                  THEN
                     r013_new := '9';
                  END IF;
               ELSE                                           -- ����� 30 ����
                  IF r013_old IN ('5', '7')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  ELSIF r013_old IN ('9')
                  THEN
                     r013_new := 'A';
                  END IF;
               END IF;
            ELSE                                          -- ��� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  r013_new := '7';
               ELSE                                           -- ����� 30 ����
                  r013_new := '8';
               END IF;
            END IF;
         END IF;

         IF p_nbs_ IN ('2138')
         THEN
            IF find_ok = 1
            THEN                                  -- ���� ����� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  IF r013_old IN ('6', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- ����� 30 ����
                  IF r013_old IN ('5', '7')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE                                          -- ��� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  r013_new := '7';
               ELSE                                           -- ����� 30 ����
                  r013_new := '8';
               END IF;
            END IF;
         END IF;

         IF p_nbs_ IN ('2238')
         THEN
            IF find_ok = 1
            THEN                                  -- ���� ����� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  IF r013_old IN ('4', '6', '9')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  END IF;
               ELSE                                           -- ����� 30 ����
                  IF r013_old IN ('3', '5', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  END IF;
               END IF;
            ELSE                                          -- ��� � �����������
               IF kv_ <> 980
               THEN
                  IF tp_ = 1
                  THEN                                          -- �� 30 ����
                     r013_new := '8';
                  ELSE                                        -- ����� 30 ����
                     r013_new := '9';
                  END IF;
               ELSE
                  NULL;                                   -- �� ������ ������
               END IF;
            END IF;
         END IF;

         IF p_nbs_ IN ('3018', '3118', '3218') and r013_old <> '9'
         THEN
            IF find_ok = 1
            THEN                                  -- ���� ����� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  IF r013_old IN ('4', '6', '8')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) - 1);
                  elsif r013_old IN ('C', 'E', 'G') then
                     r013_new := (case when r013_old = 'C' then 'B' when r013_old = 'E' then 'D' else 'F' end);
                  END IF;
               ELSE                                           -- ����� 30 ����
                  IF r013_old IN ('3', '5', '7')
                  THEN
                     r013_new := TO_CHAR (TO_NUMBER (r013_old) + 1);
                  elsif r013_old IN ('B', 'D', 'F') then
                     r013_new := (case when r013_old = 'B' then 'C' when r013_old = 'D' then 'E' else 'G' end);
                  END IF;
               END IF;
            ELSE                                          -- ��� � �����������
               IF tp_ = 1
               THEN                                             -- �� 30 ����
                  r013_new := '3';
               ELSE                                           -- ����� 30 ����
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

   IF SIGN (se_) = -1                                        -- �������
   THEN
    -- ���������� ������������� ������� ��������
     freq_ := freqp_;

     if nd_ is not null then
       comm_ := comm_ || ' (�� ���=' || TO_CHAR (nd_) || ')';
     end if;
   ELSE
     freq_ := NULL;
   END IF;

   comm_ := comm_ || ' freq=' || TO_CHAR (freq_);

   IF NVL(freq_, 400) = 5 and
      not (300465 IN (mfo_, mfou_) and tip_ = 'SNO')
   THEN                                             -- ��������� % �����������
      o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);

      IF o_r013_1 <> r013_
      THEN
         o_comm_1 := comm_ || ' ����� R013 (0) ';
      END IF;

      o_se_1 := se_;
   elsif 300465 IN (mfo_, mfou_) and tip_ = 'SNO' then
      -- ���������� � ������: �������� � ����� ����� � R013 = 4
      if r013_ = '3' then
         o_r013_1 := r013_;
         o_comm_1 := comm_ || ' (SNO) �� ������ R013='||r013_;
         o_se_1 := se_;
      elsif r013_ = '4' then
         o_r013_2 := r013_;
         o_comm_2 := comm_ || ' (SNO) �� ������ R013='||r013_;
         o_se_2 := se_;
      else
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);

         if o_r013_1 = r013_ then
            o_se_1 := se_;
            o_comm_1 := comm_ || ' (SNO) �� ������ R013='||r013_;
            o_r013_2 := null;
         elsif o_r013_2 = r013_ then
            o_se_2 := se_;
            o_comm_2 := comm_ || ' (SNO) �� ������ R013='||r013_;
            o_r013_1 := null;
         else
            o_se_1 := se_;
            o_comm_1 := comm_ || ' (SNO) ������ R013='||r013_||' �� '||o_r013_1;
            o_r013_2 := null;
         end if;
      end if;
   ELSE                                          -- ��������� % �� �����������
      -- ���� ������� �� ���������� % �� ���������� 30 ����
      SELECT (-1) * NVL (SUM (dos), 0)
        INTO dos_
        FROM saldoa
       WHERE acc = acc_ AND fdat BETWEEN dat_ - 29 AND dat_;

      if type_calc = 2 then
          -- �������������� ������� ��������� ������
          dos_kor_ := f_get_dos_kor(acc_, dat_ + 1, dat_ + 28);

          if dos_ <> 0 then
              -- �������������� ������� ����������� ������
             dos_korp_ := f_get_dos_kor(acc_, dat_ - 29, dat_);
          else
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

      -- ���� �� ����������� % �� ���������� 30 ����,
      -- �� ��� ������� ������� � ����� 30 ����
      IF dose_ = 0
      THEN
         -- �� 30 ����
         o_r013_1 := NULL;
         o_comm_1 := NULL;
         o_se_1 := 0;

         -- ����� 30 ����
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);

         IF o_r013_2 <> r013_
         THEN
            o_comm_2 := comm_ || ' ����� R013 (1) ';
         END IF;

         o_se_2 := se_;
      ELSIF ABS (se_) >= ABS (dose_)
      -- ���� ������� ������ �������� - ����� ��� ���������
      THEN
         -- ���� ������� �� ���������� 30 ���� ����
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);
         o_comm_1 := comm_ || ' �������� �������';
         o_se_1 := dose_;
         -- ��������� ����� �������
         o_r013_2 := f_ret_r013 (nbs_, kv_, r013_, 2);
         o_comm_2 := comm_ || ' �������� �������';
         o_se_2 := se_ - dose_;
      ELSE
         -- ���� ������� ������ ��������, �� ������ ������� ��� � �� 30 ����
         o_r013_1 := f_ret_r013 (nbs_, kv_, r013_, 1);

         IF o_r013_1 <> r013_
         THEN
            o_comm_1 := comm_ || ' ����� R013 (2) ';
         END IF;

         o_se_1 := se_;
      END IF;
   END IF;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ANALIZ_R013_CALC.sql =========**
PROMPT ===================================================================================== 
