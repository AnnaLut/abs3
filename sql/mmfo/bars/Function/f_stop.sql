CREATE OR REPLACE FUNCTION BARS.F_STOP (KOD_     INT,
                                        KV_      INT,
                                        NLS_     VARCHAR2,
                                        S_       NUMERIC,
                                        p_ref    oper.REF%TYPE DEFAULT NULL)
   RETURN NUMERIC
IS
   --
   -- SBER - ������ ��� ���������!!! AW f_stop.kf.fnc f_stop.kf.sbr SBER
   --
   /*
     11.09.2017 GYV 80051 ������ IF l_kk < 7 �������� IF l_kk < 6
     25/09/2016 LSO - KOD_ = 80015
          - � ��������� TMP � TM8 � ������� ���������� ������ (������, �������) ���������� FIO (�������, ���, �� �������) � ������� ����'�������;
          - � ��������� TMP TM8 � ������� ����� �� ���� ����� 150 000 ���., ���������� FIO (�������, ���, �� �������) � ������'�������;

     17/06/2016 SUF - kod=988: �������� ����.����������� ��� 2-� �����: 643 (���.���) � 985 (���.��.)
     26/04/2016     -   161 �������� ���������� �������� �� 3� ������
     20/07/2015 NVV - KOD=158 ��� tt in (025, 016) �������� ���.����������.
     10/04/2015 inga- 160 ����������� ������ ��� ������ �� �����
     27/03/2015 inga- EDP (����-������� "415" �� ������� ���.���. � ����������� <= 150 ���.���)
     29/03/2013 NVV - kod-5 ���� �� � ��������� ���
     05/10/2012 NVV - kod = 80840 �������� ����������� ����������� ��� ������ ������
     07/02/2012 EAY - ��� 988, �������� ����� ����� �� ����� �������
     23.04.2010 qwa - ��� ���� 80000 �������� ��������� ����� �������� �� "���������" �����
                      recode_passport_serial_noex ������ kl.recode_passport_serial
     26.04.2011 EAY - �������� (������) �� ���� 80000 ������ ��� ������� ������
     01.07.2011 EAY - �������� (������) �� ���� 980 �������/������� ����98��
     30.08.2011 ZHENYAS - ����� ��� �������� � ��������. ������� � VSS
     19.09.2011 qwa+ZHENYAS - �������� ���� 278 ��� �������� �� ������. ������������ ���
                              ���� � �� ����� 150 ���. ��������� � ��������� �������
                              �������� ������� 80000 (!!8) ��� �������, ��������� � ��.
                              ������� 80001 (!!W)
     23.09.2011 qwa - ������ �������� �� ��� �������� ��� ������� ��������� �������
                      (�� ���, �� ��������)
     27.09.2011 (v3)qwa - ��������� ��������� �� 23.09.2011 ����������� ��������
                          �������������� ���������� �������� �������� - �� ������ ���,
                          � ������� ���������� ��� �������� !!8
     07.10.2013 mom - �������� ������� ������ �� ���������� > 150000 ���.
     21.10.2013 mom - �������� ������� ������ �� ���������� >= 150000 ���.
     25.11.2014 ing - �������� �������� ������ �������� � �������� �� ���������� 15000 ���.
     14.09.2016 soshko �������� ������ � �������� �� 250000 ��� � �����������
   */
   e_br           VARCHAR2 (100);

   su_            NUMERIC;
   l_ref          NUMBER;
   l_sq           NUMBER;
   l_sq_t         NUMBER;                                  -- ������� ��������
   l_err          NUMBER;
   l_paspn_t      VARCHAR2 (20);
   l_tt           CHAR (3);
   l_fio_t        VARCHAR (250);
   l_fio          VARCHAR (250);
   l_kk           NUMBER;
   l_okpo         VARCHAR (14);
   l_dk           NUMBER;
   l_rezid        NUMBER;
   l_pasp_rezid   NUMBER;
   l_tag          CHAR (5);
   l_natio        VARCHAR (70);
   l_pasp         VARCHAR (30);
   l_rnk          NUMBER;
   l_vidd         NUMBER;
   l_serd         VARCHAR (32);
   l_txt          VARCHAR (1024);
   l_kurs         VARCHAR (32);
   l_nd377        VARCHAR2 (32);
   l_name         VARCHAR (250);
   l_drday        VARCHAR2 (14);
   l_cnt          NUMBER;
   l_cnt_NDC      NUMBER;
   l_cnt_NUC      NUMBER;
   l_dat          DATE;
   val_           VARCHAR (250);
   l_atrt         VARCHAR (250);
   p_value        operw.VALUE%TYPE;
   l_exs          NUMBER := 0;
   l_count_157    NUMBER := 0;
   --1478
  l_deposit   dpt_deposit.deposit_id%type;
  l_term_add  dpt_vidd.term_add%type;
  l_term_add1 number(5);
  l_acc       accounts.acc%type;
  l_dat_begin dpt_deposit.dat_begin%type;
  l_limit     dpt_deposit.limit%type;
  l_res       number(10);
  l_sum       number;
  l_kv        number(3);
  l_count_mm  number(5);
  l_dat_start date;
  l_dat_end   date;
  l_dat_s     date;
  l_dat_po    date;
  l_sum_month oper.s%type;
  l_comproc   dpt_vidd.comproc%type;
  l_is_bnal   number;

   p_value2       operw.VALUE%TYPE;
   n1_            NUMBER;
   ern   CONSTANT POSITIVE := 803;
   err            EXCEPTION;
   erm            VARCHAR2 (1024);
--
BEGIN
   bars_audit.trace (
         'F_STOP(KOD_ => '
      || KOD_
      || ', KV_ => '
      || KV_
      || ', NLS_ => '''
      || NLS_
      || ''', S_ => '
      || S_
      || ')');

   IF KOD_ = 1 AND KV_ = 980 AND SUBSTR (NLS_, 1, 4) = '2600'
   THEN
      BEGIN
         SELECT ostc
           INTO su_
           FROM accounts
          WHERE     nbs = 9803
                AND ostc < 0
                AND SUBSTR (nls, 6, 9) = SUBSTR (NLS_, 6, 9);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      erm := '9803- ' || NLS_ || ' KAPTOTEKA 2 ' || su_;
      RAISE err;
   ELSIF KOD_ = 2
   THEN
      BEGIN
         SELECT pos
           INTO su_
           FROM accounts
          WHERE pos <> 1 AND nls = NLS_ AND kv = KV_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      erm := '9804- ' || NLS_ || '/' || KV_ || ' HE OCHOBH. ';
      RAISE err;
   ELSIF KOD_ = 3
   THEN
      --  ���� = ���� � ���
      --  KV_  - MFOA
      --  NLS_ - TT
      --  S_   - MFOB
      IF KV_ <> S_ + 0
      THEN
         RETURN 0;
      END IF;

      erm := '9805- BHYTPEH. ! ' || KV_ || '=' || S_;
      RAISE err;
   ELSIF KOD_ = 4
   THEN
      --  nlsb 1xxx - 1-� ����� � ���
      --  KV_  -
      --  NLS_ - nlsb
      --  S_   -
      IF SUBSTR (NLS_, 1, 1) <> '1'
      THEN
         RETURN 0;
      END IF;

      erm := '9806- 1 KLASS ! ' || NLS_;
      RAISE err;
   ELSIF KOD_ = 5
   THEN
      -- ���� �� � ��������� ���
      -- KV_ - MFOB
      BEGIN
         SELECT 1
           INTO l_tt
           FROM banks$base
          WHERE     blk = 0
                AND mfou IN (SELECT mfou
                               FROM banks$base
                              WHERE mfo = f_ourmfo)
                AND mfo = KV_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            erm :=
                  '9807- �����!!!!!   ��� ���������� '
               || KV_
               || ' �� � ��������� ��� !!!!';
            RAISE err;
      END;

      RETURN 0;
   ELSIF KOD_ = 10
   THEN
      BEGIN
         SELECT LENGTH (nazn)
           INTO su_
           FROM oper
          WHERE REF = KV_ AND LENGTH (nazn) < 5;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      erm := '9855- dl <5 ';
      RAISE err;
   ELSIF KOD_ = 11
   THEN
      BEGIN
         SELECT ostc
           INTO su_
           FROM accounts
          WHERE ostc - S_ >= 0 AND nls = NLS_ AND kv = KV_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      erm :=
            '����������� ����� �� �������'
         || NLS_
         || '='
         || su_;
      RAISE err;
   /*
     elsif KOD_=12 then
       BEGIN
         SELECT a2.ostb+a8.ostb+nvl(l.s,0)
         INTO   su_
         FROM   over_v   o ,
                accounts a2,
                accounts a8,
                oper     p ,
                opldok   l
         WHERE  p.ref=nls_                    and
                o.nls_2600=p.nlsa             and
                o.kv=p.kv                     and
                o.acc_2600=a2.acc             and
                o.acc_8000=a8.acc             and
                a2.ostb+a8.ostb+nvl(l.s,0)<s_ and
                o.acc_2600(+)=l.acc           and
                l.ref=nls_                   and
                l.dk=0;
       EXCEPTION WHEN NO_DATA_FOUND THEN
         RETURN 0;
       END;
       erm := '������������ ������� ��� ������ ����������, ���.2600+���.8000 ='||to_char(su_/100,'9999999999999.99');
       RAISE err;
   */


   ELSIF kod_ = 33
   THEN                              ---   ��� �������� �� ������. ����������:
                                  --- �������� ������� � ����.�������� CC_DEAL
                                           --- �������� � � ���� ����.��������
      BEGIN
         SELECT TRIM (w.VALUE), TRIM (w2.VALUE)
           INTO p_value, p_value2
           FROM operw w, operw w2, oper o
          WHERE     w.REF = o.REF
                AND w2.REF = o.REF
                AND o.REF = p_ref
                AND w.TAG = 'N_CRD'
                AND w2.TAG = 'D_CRD';


         IF LENGTH (p_value2) = 10
         THEN
            l_dat :=
               TO_DATE (
                     SUBSTR (p_value2, 1, 2)
                  || '/'
                  || SUBSTR (p_value2, 4, 2)
                  || '/'
                  || SUBSTR (p_value2, 7, 4),
                  'dd/mm/yyyy');
         ELSE
            l_dat :=
               TO_DATE (
                     SUBSTR (p_value2, 1, 2)
                  || '/'
                  || SUBSTR (p_value2, 4, 2)
                  || '/'
                  || SUBSTR (p_value2, 7, 2),
                  'dd/mm/yy');
         END IF;

         SELECT 1
           INTO l_kk
           FROM CC_DEAL
          WHERE    (TRIM (CC_ID) = p_value AND SDATE = l_dat)
                OR p_value = '*' AND ROWNUM = 1;

         RETURN 0;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            erm :=
               '       ���������� �������� � �����  �  � �� ���� ���� � ���������� ������� ���� !';
            RAISE err;
      END;
   -----------------  ��������� ��� 140 (���), 342 (���)  --------------------

   ELSIF kod_ = 540
   THEN
      -- �� �� ;29.09.2014 �. �14/2-01/ID-2072  ��������� ��� � 540

      --    f540 = 0  - �� ��������� � 500 ���
      --         = 1  - ��������� � 500 ���


      ------------------------------------
      ---  ����, ��������� ��������� ���.�������� "������ ��� ������
      ---  ��.������" (ED_VN):
      ---  ������������� �������� ����� ��������� = 0.
      ---  ��� ���=40 ��� NAZN like '%���%����%'  ��������� ������� ������
      ---  �������� ��������� �������� �� 0.

      IF     (gl.doc.SK = 40 OR UPPER (gl.doc.NAZN) LIKE '%���%����%')
         AND NVL (pul.get_mas_ini_val ('ED_VN'), '0') = '0'
      THEN
         erm :=
            '       �� ��������� ������� ������� ��� ������ ��.������.  ���� �� ����� �� ��������, �� ������:  ��� ��� ��� ������, ��� 1 - ���� � �볺��� ����� ����.�����. ��� �������. �������';
         RAISE err;
      END IF;

      ------------------------------------

      RETURN 0; --��������� ��� 81

      IF kv_ = 980
      THEN                                 -----  1).  ��� - ��������� ��� 140
         ---------
         IF f540 (gl.doc.SK,
                  gl.doc.NAZN,
                  GL.DOC.REF,
                  1,
                  kv_) = 0
         THEN
            RETURN S_;
         END IF;

         -- �� �����.
         -- � ��� ��� ���� �������  ����� �� ����� ?

         BEGIN
            SELECT c.OKPO, c.RNK
              INTO l_okpo, l_kk
              FROM accounts a, customer c
             WHERE a.kv = 980 AND a.nls = nls_ AND a.rnk = c.rnk;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN S_;
         END;

         IF l_okpo = '000000000' OR l_okpo = '0000000000'
         THEN
            SELECT NVL (SUM (o.s), 0) + S_               ---  ��������� �� RNK
              INTO n1_
              FROM opldok o, accounts a
             WHERE     a.RNK = l_kk
                   AND a.kv = 980
                   AND o.fdat = gl.bdate
                   AND o.acc = a.acc
                   AND o.dk = 0
                   AND EXISTS
                          (SELECT 1
                             FROM oper
                            WHERE     REF = o.REF
                                  AND f540 (SK,
                                            NAZN,
                                            REF,
                                            0,
                                            980) = 1);
         ELSE
            SELECT NVL (SUM (o.s), 0) + S_              ---  ��������� �� OKPO
              INTO n1_
              FROM opldok o, accounts a, customer c
             WHERE     c.OKPO = l_okpo
                   AND c.rnk = a.rnk
                   AND a.kv = 980
                   AND o.fdat = gl.bdate
                   AND o.acc = a.acc
                   AND o.dk = 0
                   AND EXISTS
                          (SELECT 1
                             FROM oper
                            WHERE     REF = o.REF
                                  AND f540 (SK,
                                            NAZN,
                                            REF,
                                            0,
                                            980) = 1);
         END IF;

         -- If n1_ <  50000000 then

         RETURN S_;

         -- End if;

         erm :=
            '       ˳�i� ������ = 500 ��� ��� � �Ѳ� ���. �볺��� - ����. ��� � 140.  �������: �� 40,50,59,61-�� ���������� (������� ���� ������ � ����������), �������� ��������� ������';
         RAISE err;
      ELSE                            -----  2).  ������ - ��������� ��� � 342
         SELECT COUNT (*)
           INTO l_kk
           FROM OperW
          WHERE REF = GL.DOC.REF AND TAG = 'NB758' AND TRIM (VALUE) = '1';

         IF l_kk = 1
         THEN
            BEGIN
               SELECT 1
                 INTO l_kk
                 FROM OperW
                WHERE     REF = GL.DOC.REF
                      AND TAG = 'OP758'
                      AND VALUE IS NOT NULL;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  erm :=
                     '       �� ��������� "���� ������� � 342 ��������� ���" !  ���� ����� ������� � ��������';
                  RAISE err;
            END;
         END IF;


         IF f540 (gl.doc.SK,
                  gl.doc.NAZN,
                  GL.DOC.REF,
                  1,
                  kv_) = 0
         THEN
            RETURN S_;
         END IF;

         -- �� �����.
         -- � ��� ��� ���� �������  ����� �� ����� ?

         BEGIN
            SELECT c.OKPO, c.RNK
              INTO l_okpo, l_kk
              FROM accounts a, customer c
             WHERE a.kv = kv_ AND a.nls = nls_ AND a.rnk = c.rnk;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN S_;
         END;

         IF l_okpo = '000000000' OR l_okpo = '0000000000'
         THEN
            ---  ��������� �� RNK:
            SELECT   NVL (SUM (GL.P_ICURVAL (a.kv, o.s, SYSDATE)), 0)
                   + GL.P_ICURVAL (kv_, S_, SYSDATE)
              INTO n1_
              FROM opldok o, accounts a
             WHERE     a.RNK = l_kk
                   AND a.kv <> 980
                   AND o.fdat = gl.bdate
                   AND o.acc = a.acc
                   AND o.dk = 0
                   AND EXISTS
                          (SELECT 1
                             FROM oper
                            WHERE     REF = o.REF
                                  AND f540 (SK,
                                            NAZN,
                                            REF,
                                            0,
                                            KV) = 1);
         ELSE                                          ---  ��������� �� OKPO:
            SELECT   NVL (SUM (GL.P_ICURVAL (a.kv, o.s, SYSDATE)), 0)
                   + GL.P_ICURVAL (kv_, S_, SYSDATE)
              INTO n1_
              FROM opldok o, accounts a, customer c
             WHERE     c.OKPO = l_okpo
                   AND c.rnk = a.rnk
                   AND a.kv <> 980
                   AND o.fdat = gl.bdate
                   AND o.acc = a.acc
                   AND o.dk = 0
                   AND EXISTS
                          (SELECT 1
                             FROM oper
                            WHERE     REF = o.REF
                                  AND f540 (SK,
                                            NAZN,
                                            REF,
                                            0,
                                            KV) = 1);
         END IF;

         IF n1_ < 25000000
         THEN
            RETURN S_;
         END IF;

         erm :=
            '       ˳�i� ������ ��������� ���i��� = 250 ��� � ���-��� �� ���� � �Ѳ� ������� �볺��� !   ��������� ��� � 386';
         RAISE err;
      END IF;
   --------------  758  (������ ��� 863 ���������) :

   ELSIF kod_ = 758
   THEN RETURN 0;  --��������� ���  81
      SELECT COUNT (*)
        INTO l_kk
        FROM OperW
       WHERE REF = GL.DOC.REF AND TAG = 'NB758' AND TRIM (VALUE) = '1';

      IF l_kk = 1
      THEN
         BEGIN
            SELECT 1
              INTO l_kk
              FROM OperW
             WHERE REF = GL.DOC.REF AND TAG = 'OP758' AND VALUE IS NOT NULL;

            RETURN 0;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '       �� ��������� "���� ������� � 140 ��������� ���" !  ���� ����� ������� � ��������';
               RAISE err;
         END;
      END IF;

      RETURN 0;
   -----------------------  End 140 (540,758)  -------------------------------


   ELSIF KOD_ = 541
   THEN
      -- ��� STOP-�������� !!�  (����������� � 00�):
      -- ������������, ��� �� ���� �� ������ ����.��������
      SELECT tt              -- (��������, ���, ���������...) ��������� ������
        INTO l_tt                     -- ���������� 066,067,069,072, � �� 00�.
        FROM oper
       WHERE REF = p_ref;


      IF l_tt = '00C'
      THEN
         BEGIN
            SELECT r.KODK
              INTO l_kk
              FROM RNKP_KOD r, Accounts a
             WHERE     a.NLS = NLS_
                   AND a.KV = KV_
                   AND a.RNK = r.RNK
                   AND r.RNK IS NOT NULL
                   AND r.KODK IS NOT NULL
                   AND ROWNUM = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_kk := 0;
         END;

         IF l_kk = 1
         THEN
            erm :=
               '       ��� ������ ������ � ������� ��� �������������� �������� 069';
            RAISE err;
         ELSIF l_kk = 2
         THEN
            erm :=
               '       ��� ������ ������ � ������� "��������" �������������� �������� 066,067';
            RAISE err;
         ELSIF l_kk = 5
         THEN
            erm :=
               '       ��� ������ ������ � ������� "���������" �������������� �������� 072';
            RAISE err;
         ELSIF l_kk = 6
         THEN
            erm :=
               '       ��� ������ ������ � ������� "���" �������������� �������� 073';
            RAISE err;
         ELSIF l_kk = 8
         THEN
            erm :=
               '       ��� ������ ������ � ������� "���" �������������� �������� 075';
            RAISE err;
         ELSIF l_kk = 11
         THEN
            erm :=
               '       ��� ������ ������ � ������� "���������" �������������� �������� 074';
            RAISE err;
         ELSIF l_kk = 17
         THEN
            erm :=
               '       ��� ������ ������ � ������� "�����������" �������������� �������� 085';
            RAISE err;
         END IF;
      END IF;

      RETURN 0;
   --------------------------------------------------------


   --  �������� ���i��i/������� �����i � ���������i���� ������i��
   ELSIF KOD_ = 980
   THEN
      IF kv_ <> '980'
      THEN
         RETURN 0;
      END IF;

      erm :=
            '980- ���������� �� �����/������ ������ ! '
         || KV_;
      RAISE err;
   ELSIF KOD_ = 988
   THEN
      --  ������ �� ����� ������� ���������� �� �����
      IF kv_ IN (840,
                 978,
                 826,
                 124,
                 756,
                 643,
                 985)
      THEN
         RETURN 0;
      END IF;

      erm :=
         '988- ���������� �� ����� ������ ! ' || KV_;
      RAISE err;
   ELSIF KOD_ = 989
   THEN
      --  ����������� ��� �� ���� ������
      IF kv_ <> nls_
      THEN
         RETURN 0;
      END IF;

      erm :=
            ' *******�����! ������ �('
         || KV_
         || ')=����� �('
         || nls_
         || ')!';
      RAISE err;
   ELSIF KOD_ = 102
   THEN
      --  kv_  - ref
      --  nls_ - tt
      --  �������� ���������� ���� ������� �������� (�� ����� 150���.���)
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT eqv_obs (kv_,
                         s_,
                         bankdate,
                         0)
           INTO l_sq
           FROM DUAL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      IF l_sq >= 15000000
      THEN
         erm :=
            '******���i������ ���� �������� > 150000.00 ���! ������� �����i��� ������ ������i�����!';
         RAISE err;
      END IF;

      BEGIN
         BEGIN
            SELECT w.VALUE fio, w2.VALUE pasp
              INTO l_fio, l_pasp
              FROM operw w, operw w2, oper o
             WHERE     o.REF = w.REF
                   AND w2.REF = o.REF
                   AND o.REF = p_ref
                   AND w.tag = 'FIO'
                   AND w2.tag = 'PASPN';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '******��������� ������������� �볺���!!!******';
               RAISE err;
         END;

         /*
               begin
                 select nvl(sum(gl.p_icurval(o.kv,o.s,gl.bd)),0)
                 into   l_sq
                 from   oper  o,
                        operw w
                 where  o.ref=w.ref                                         and
                        o.pdat>=trunc(sysdate)                              and
                        o.pdat<trunc(sysdate)+1                             and
                        trim(upper(f_translate_kmu(replace(w.value,' '))))=
                        trim(upper(f_translate_kmu(replace(l_fio,' '))))    and
                        sos>=1                                              and
                        o.tt in (select tt
                                 from   perekaz_tt
                                 where  flag='O');
               exception when no_data_found then
                 l_sq := 0;
               end;
               if l_sq>=5000000 then
                 erm := '******������� '||l_fio||' ���������� �i�i� 50000 ���. ��� ��������';
                 RAISE err;
               end if;
         */
         BEGIN
            SELECT NVL (SUM (gl.p_icurval (o.kv, o.s, gl.bd)), 0)
              INTO l_sq
              FROM oper o, operw w
             WHERE     o.REF = w.REF
                   AND o.pdat >= TRUNC (SYSDATE)
                   AND o.pdat < TRUNC (SYSDATE) + 1
                   AND    recode_passport_serial_noex (
                             SUBSTR (REPLACE (w.VALUE, ' '), 1, 2))
                       || SUBSTR (REPLACE (w.VALUE, ' '),
                                  3,
                                  LENGTH (REPLACE (w.VALUE, ' '))) =
                             recode_passport_serial_noex (
                                SUBSTR (REPLACE (l_pasp, ' '), 1, 2))
                          || SUBSTR (REPLACE (l_pasp, ' '),
                                     3,
                                     LENGTH (REPLACE (l_pasp, ' ')))
                   AND sos >= 1
                   AND o.tt IN (SELECT tt
                                  FROM perekaz_tt
                                 WHERE flag = 'O');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_sq := 0;
         END;

         IF l_sq >= 15000000
         THEN
            erm :=
                  '******������� '
               || l_pasp
               || ' ���������� �i�i� 150000 ���. ��� ��������';
            RAISE err;
         END IF;
      END;
   --
   ELSIF KOD_ = 103
   THEN                                                                     --
      IF s_ > 500000
      THEN
         erm :=
            '******���������� ����������� ��������� ���� �������� ( 5000.00 )******';
         RAISE err;
      END IF;
   ELSIF KOD_ = 414
   THEN      RETURN 0; --��������� ���  81        -- ������ �������� � ������ (� �����������) �� 20 ���.���
      bars_audit.info (
         'f_stop#414: start check for p_ref = ' || TO_CHAR (p_ref));

      -- ��������� ������ ������
      IF KV_ = 980
      THEN
         RETURN 0;
         bars_audit.info (
               'f_stop#414: KV_ = 980 - OK. finished for p_ref = '
            || TO_CHAR (p_ref));
      END IF;

      -- �������� ���������� �������� ���������
      BEGIN
         SELECT ROUND (o.s * f_ret_rate (o.kv, TRUNC (SYSDATE), 'O'), 0),
                   recode_passport_serial_noex (
                      SUBSTR (REPLACE (w.VALUE, ' '), 1, 2))
                || SUBSTR (REPLACE (w.VALUE, ' '),
                           3,
                           LENGTH (REPLACE (w.VALUE, ' ')))
           INTO l_sq, l_pasp
           FROM oper o, operw w
          WHERE     o.REF = p_ref
                AND o.REF = w.REF
                AND o.sos > 0
                AND w.tag = 'PASPN'
                AND NOT EXISTS
                           (SELECT 1
                              FROM operw ow
                             WHERE     ow.REF = o.REF
                                   AND ow.tag = 'EXCFL'
                                   AND ow.VALUE = '1'
                                   AND EXISTS
                                          (SELECT 1
                                             FROM operw
                                            WHERE     REF = ow.REF
                                                  AND tag = 'REZID'
                                                  AND VALUE = '2'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_sq := 0;
      END;

      bars_audit.info (
            'f_stop#414: l_sq='
         || TO_CHAR (l_sq)
         || 'passp = '
         || l_pasp
         || ' for p_ref = '
         || TO_CHAR (p_ref));

      BEGIN
         SELECT ROUND (SUM (o.s * f_ret_rate (o.kv, TRUNC (SYSDATE), 'O')),
                       0)
           INTO l_sq_t
           FROM oper o, operw w
          WHERE     o.REF = w.REF
                AND O.TT IN ('DPG',
                             'DPV',
                             'DP9',
                             'DM1',
                             'DM4',
                             'PKF') --, 'EDP') -- 25/03/2015 inga ��� ��� �������� � ���/���, � EDP ���/���!
                AND o.sos > 0
                AND kv != 980
                AND pdat >= TRUNC (SYSDATE)
                AND pdat < TRUNC (SYSDATE) + 1
                AND    recode_passport_serial_noex (
                          SUBSTR (REPLACE (w.VALUE, ' '), 1, 2))
                    || SUBSTR (REPLACE (w.VALUE, ' '),
                               3,
                               LENGTH (REPLACE (w.VALUE, ' '))) = l_pasp
                AND NOT EXISTS
                           (SELECT 1
                              FROM operw ow
                             WHERE     ow.REF = o.REF
                                   AND ow.tag = 'EXCFL'
                                   AND ow.VALUE = '1'
                                   AND EXISTS
                                          (SELECT 1
                                             FROM operw
                                            WHERE     REF = ow.REF
                                                  AND tag = 'REZID'
                                                  AND VALUE = '2'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_sq_t := 0;
      END;

      bars_audit.info ('f_stop#414,l_sq_t =' || TO_CHAR (l_sq_t));
      --��� ��������� ��������� ����� ��������
      l_sq_t := l_sq_t - l_sq;
      bars_audit.info (
         'f_stop#414,l_sq_t - l_sq =' || TO_CHAR (l_sq_t - l_sq));

      IF l_sq_t + l_sq >= 25000000
      THEN
         erm :=
            '******���������� ���� 250 000 ��� � ���������. ��������� ��� �386';
         RAISE err;
      END IF;

      bars_audit.info (
         'f_stop#414: finish check p_ref = ' || TO_CHAR (p_ref));
   ELSIF KOD_ = 415
   THEN
      -- �������� ������ �����, ��� � ��������� EDP ���/���!
      bars_audit.info (
            'KOD_'
         || TO_CHAR (KOD_)
         || 'KV_'
         || TO_CHAR (KV_)
         || 'NLS_'
         || TO_CHAR (NLS_)
         || 'S_'
         || TO_CHAR (S_)
         || 'p_ref = '
         || TO_CHAR (p_ref));

      BEGIN
         SELECT ROUND (o.s * f_ret_rate (o.kv, TRUNC (SYSDATE), 'O'), 0),
                w.VALUE
           INTO l_sq, l_pasp
           FROM oper o, operw w
          WHERE     o.REF = p_ref
                AND o.REF = w.REF
                AND o.sos > 0
                AND w.tag = 'PASPN';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_sq := 0;
      END;

      BEGIN
         SELECT ROUND (SUM (o.s * f_ret_rate (o.kv, TRUNC (SYSDATE), 'O')),
                       0)
           INTO l_sq_t
           FROM oper o, operw w
          WHERE     o.REF = w.REF
                AND O.TT IN ('EDP')
                AND o.sos > 0
                AND pdat >= TRUNC (SYSDATE)
                AND pdat < TRUNC (SYSDATE) + 1
                AND w.VALUE = l_pasp;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_sq_t := 0;
      END;

      --��� ��������� ��������� ����� ��������
      l_sq_t := l_sq_t - l_sq;

      IF l_sq_t + l_sq >= 50000000
      THEN                                                     -- ��� 300 ���.
         erm :=
            '******������� ���� �� �������� ������� �������� �������� 500 000 ��� � ��������� (����.��� �626 �� 03 ������ 2014 �).';
         RAISE err;
      END IF;
   /*�������� �� ����������� ���� ����������� �� ������� � �������� �� ����
   BRSMAIN-2762 */
   ELSIF KOD_ = 440
   THEN
      IF web_utl.is_web_user = 1
         THEN e_br := '<br>';
         ELSE e_br := '';
      END IF;

      BEGIN
         SELECT SUM (TO_NUMBER (VALUE))
           INTO l_sq_t
           FROM operw
          WHERE REF = p_ref AND tag LIKE 'S_DZ%';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_sq_t := 0;
      END;

      IF l_sq_t * 100 = s_
      THEN   NULL;
      ELSE   erm :='     ���� �� ����� ����������� �� ���������� �������� ��� ��������� '|| TRIM (TO_CHAR (l_sq_t, '9999990D00'))
                   || '<>'|| TRIM (TO_CHAR (s_ / 100, '9999990.00'));
              RAISE err;
      END IF;

          -- �������� �� ��������� ���� ���������� �� ��� ��� ����.
       for k in (
                    select   w.tag  tag1,  w.value value1,
                             w2.tag tag2, w2.value value2
                      FROM (select * from operw  where ref = p_ref and  tag  LIKE 'K_DZ%') w
                          full join  (select * from operw  where ref = p_ref and  tag  LIKE 'S_DZ%') w2
                               on (substr(w.tag,5,2) = substr(w2.tag,5,2))
                      where  w.value is null or w2.value is null
                )
        loop

          if k.value1 is null
               then p_value :=p_value|| '��� ����='||k.value2||' �� ������� ���  ����.�������' ||e_br;
          elsif k.value2 is null
               then p_value :=p_value|| '��� ���� ����.�������='||k.value1||' �� ������� ����' ||e_br;
          end if;

        end loop;

      IF p_value IS NULL
         THEN NULL;
         ELSE erm :='     '|| '�� ��������: '||e_br|| p_value;
              RAISE err;
      END IF;

    -- �������� �� ���� ���� �����������
          SELECT SUBSTR (MAX (SYS_CONNECT_BY_PATH (VALUE, ',')) || ',', 2)
            INTO p_value
            FROM (SELECT ROWNUM rn, VALUE
                    FROM (  SELECT    e_br||  VALUE|| '- '|| REPLACE (NVL (K.N2,'�� ���������� ���'),',',' ') AS VALUE
                              FROM operw w, KOD_DZ k
                             WHERE     REF = p_ref
                                   AND w.VALUE = K.N1(+)
                                   AND tag LIKE 'K_DZ%'
                          GROUP BY w.VALUE, k.n2
                            HAVING COUNT (1) > 1))
           CONNECT BY PRIOR rn + 1 = rn
           START WITH rn = 1;

      IF p_value IS NULL
          THEN   NULL;
          ELSE   erm :='     '|| '������������ ���� �������������: '|| p_value|| e_br;
                 RAISE err;
      END IF;
   ------ ********************************************************************************************************
   ELSIF KOD_ = 80000
   THEN                                     -- ��������� 538, 278 (11.08.2011)
      --  kv_  - ref
      --  nls_ - tt
      --  �� ���� ����� f_stop(80000,#(ref),'',0)

      BEGIN                          -- �������� ���������� �������� ���������
         SELECT s2,
                REF,
                tt,
                dk
           INTO l_sq_t,
                l_ref,
                l_tt,
                l_dk
           FROM oper
          WHERE REF = kv_ AND kv2 = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      IF l_sq_t >= 50000000 AND l_dk = 0
      THEN
         erm :=
            '******����������� ���� ������ �������� 500000.00 ���.******';
         RAISE err;
      END IF;

      --  ������� ����� ���
      --  ��� �����

      BEGIN
         --    bars_audit.info('f_stop_8000=03='||l_fio_t||'='||l_fio);
         SELECT f_translate_kmu (REPLACE (VALUE, ' ')), VALUE
           INTO l_fio_t, l_fio
           FROM operw
          WHERE REF = l_ref AND tag = 'FIO';
      --    bars_audit.info('f_stop_8000=04='||l_fio_t||'='||l_fio);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            erm := '******  ����i�� �I�  ******';
            RAISE err;
      END;

      IF l_sq_t >= 5000000
      THEN
         l_kk := 0;

         BEGIN                 -- �������� ������������ ��� 50000.00 ���������
            SELECT COUNT (*)
              INTO l_kk
              FROM operw
             WHERE     REF = l_ref
                   AND tag IN ('FIO',
                               'PASP',
                               'PASPN',
                               'ATRT',
                               'REZID',
                               'ADRES',
                               'RNOKP');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '******������ ������!��������� ��������� ����i���� ϲ�, ��������, ���i� �� ����� ���������,��� i ���� �������';
               RAISE err;
         END;

         IF l_kk < 7
         THEN
            erm :=
               '******������ ������!��������� ��������� ����i���� ϲ�, ��������, ���i� �� ����� ���������,��� i ���� �������';
            RAISE err;
         END IF;

         BEGIN
            SELECT VALUE
              INTO l_pasp
              FROM operw
             WHERE REF = l_ref AND tag IN ('PASP');

            logger.trace ('f_stop_80000: l_pasp=%s', l_pasp);
         EXCEPTION
            WHEN OTHERS
            THEN
               IF SQLCODE = -1403
               THEN
                  logger.trace ('f_stop_80000: l_pasp not found');
               END IF;
         END;
      /*
            BEGIN
              select value
              into   l_rezid
              from   operw
              where  ref=l_ref and
                     tag in ('REZID');
              if l_rezid='2' and l_natio is null then
                erm := '*******�����! �� ��������� ������������ ��� ��i����-�����������!';
                RAISE err;
              end if;
            end;
      */
      END IF;

      l_paspn_t := ' ';                  -- �������� ����.�������� ��� >50���.

      --  if l_sq_t>5000000 then
      BEGIN
         SELECT VALUE
           INTO l_rezid
           FROM operw
          WHERE REF = l_ref AND tag = 'REZID';

         logger.trace ('f_stop_80000: l_rezid=%s', TO_CHAR (l_rezid));

         IF l_sq_t >= 5000000
         THEN
            IF l_rezid = 1
            THEN
               IF UPPER (l_pasp) = '�������'
               THEN
                  SELECT    kl.recode_passport_serial (
                               SUBSTR (REPLACE (VALUE, ' '), 1, 2))
                         || SUBSTR (REPLACE (VALUE, ' '),
                                    3,
                                    LENGTH (REPLACE (VALUE, ' ')))
                    INTO l_paspn_t
                    FROM operw
                   WHERE REF = l_ref AND tag = 'PASPN';
               ELSE
                  SELECT VALUE
                    INTO l_paspn_t
                    FROM operw
                   WHERE REF = l_ref AND tag = 'PASPN';
               END IF;
            END IF;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            erm :=
               '*****������ ������,����i�� ���i� �� ����� ��������!';
            RAISE err;
      END;

      --  end if;
      logger.trace ('f_stop_80000: l_paspn_t=%s, ascii(%s)=%s, ascii(%s)=%s',
                    l_paspn_t,
                    SUBSTR (l_paspn_t, 1, 1),
                    TO_CHAR (ASCII (SUBSTR (l_paspn_t, 1, 1))),
                    SUBSTR (l_paspn_t, 2, 1),
                    TO_CHAR (ASCII (SUBSTR (l_paspn_t, 2, 1))));

      --  �������� ���� �� ������� ��� ������ � ����� ��������
      --
      BEGIN
         --    bars_audit.info('f_stop_8000=1='||l_sq||' = '||l_dk);
         SELECT NVL (SUM (o.s2), 0), SUM (o.dk)
           INTO l_sq, l_dk
           FROM oper o,
                (SELECT REF, tag, VALUE
                   FROM operw
                  WHERE REF IN (SELECT DISTINCT REF
                                  FROM opldok
                                 WHERE     fdat = gl.bDATE
                                       AND tt IN (SELECT tt
                                                    FROM ttsap
                                                   WHERE ttap = '!!8'))) w
          WHERE     w.tag = 'PASPN'
                AND o.REF = w.REF
                AND CASE
                       WHEN l_rezid = 1 AND UPPER (l_pasp) = '�������'
                       THEN
                             recode_passport_serial_noex (
                                SUBSTR (REPLACE (w.VALUE, ' '), 1, 2))
                          || SUBSTR (REPLACE (w.VALUE, ' '),
                                     3,
                                     LENGTH (REPLACE (w.VALUE, ' ')))
                       ELSE
                          w.VALUE
                    END = l_paspn_t
                AND sos >= 1;

         --    bars_audit.info('f_stop_8000=2='||l_sq||' = '||l_dk);
         logger.trace ('f_stop_80000: l_sq=%s, l_dk=%s',
                       TO_CHAR (l_sq),
                       TO_CHAR (l_dk));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            logger.trace (
               'f_stop_80000: ����� ������ � ��������� %s �� ���� %s �� ������',
               l_paspn_t,
               TO_CHAR (gl.bDATE, 'dd.mm.yyyy'));
            RETURN 0;
      END;

      --

      IF l_sq >= 15000000 AND l_dk = 0
      THEN
         erm :=
               '******������� '
            || l_paspn_t
            || ' ���������� �i�i� 150 000.00 ���.';
         logger.trace ('f_stop_80000: %s', erm);
         RAISE err;
      END IF;

      IF TRIM (l_paspn_t) IS NULL
      THEN
         --    �������� ���� �� ������� ��� ������ � ���� ��������
         BEGIN
            --      bars_audit.info('f_stop_8000=3='||l_sq);
            SELECT NVL (SUM (o.s2), 0)
              INTO l_sq
              FROM oper o,
                   (SELECT REF, tag, VALUE
                      FROM operw
                     WHERE REF IN (SELECT DISTINCT REF
                                     FROM opldok
                                    WHERE     fdat = gl.bDATE
                                          AND tt IN (SELECT tt
                                                       FROM ttsap
                                                      WHERE ttap = '!!8'))) w
             WHERE     w.tag = 'FIO'
                   AND o.REF = w.REF
                   AND f_translate_kmu (REPLACE (w.VALUE, ' ')) = l_fio_t
                   AND --             w.value not like 'Գ������ (�� 50 ��� ���)%'  and
                       --             l_fio_t not like 'Գ������ (�� 50 ��� ���)%'  and
                       sos >= 1;
         --      bars_audit.info('f_stop_8000=4='||l_sq);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN 0;
         END;

         IF l_sq >= 15000000
         THEN
            erm :=
                  '******�I� '
               || l_fio
               || ' ���������� �i�i� 150000.00 ��� ********';
            RAISE err;
         END IF;
      END IF;
   --
   ELSIF KOD_ = 80001
   THEN                            -- 278 (11.08.2011), �������� �������������
      --  �� 50��� ���     - FIO (�� ���� �������������� ��������� � �����. ���������)
      --  ����� 50 ��� ��� - FIO, �������, ����, �����, ���� ���������, ����
      --  ��� �������� �������, ��������� � �������

      --  kv_  - ref
      --  nls_ - tt
      --  �� ���� ����� f_stop(80001,#(ref),'',0)
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT s2,
                REF,
                tt,
                dk
           INTO l_sq_t,
                l_ref,
                l_tt,
                l_dk
           FROM oper
          WHERE REF = kv_ AND kv2 = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      --  ���� ���.>150000.00 ��� ������� ����� ��������. ��������� 172 � 28.03.2014 �� 01.05.2014�.
      --  �������  ��������
      IF l_sq_t >= 15000000
      THEN
         l_kk := 0;

         BEGIN                 -- �������� ������������ ��� 50000.00 ���������
            SELECT COUNT (*)
              INTO l_kk
              FROM operw
             WHERE     REF = l_ref
                   AND tag IN ('FIO',
                               'PASPV',
                               'PASPN',
                               'ATRT',
                               'REZID',
                               'ADRES',
                               'RNOKP');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****������ ������!��������� > 150000���. ��������� ����� ������������� �볺���';
               RAISE err;
         END;

         IF l_kk < 7
         THEN
            erm :=
               '*****������ ������!��������� > 150000���. ��������� ����� ������������� �볺���';
            RAISE err;
         END IF;
      /*
            begin
              select value
              into   l_natio
              from   operw
              where  ref=l_ref and
                     tag in ('NATIO');
            exception when others then
              if sqlcode=-1403 then
                null;
              end if;
            end;

            BEGIN
              select value
              into   l_rezid
              from   operw
              where  ref=l_ref and
                     tag in ('REZID');
              if l_rezid='2' and l_natio is null then
                erm := '*******�����! �� ��������� ������������ ��� ��i����-�����������!';
                RAISE err;
              end if;
            end;
      */
      END IF;
   --
   /*
   COBUSUPABS-3241
     ������� ������������ �� ��� ����� Millenium� ��� ���������
     ������������ ���������� ��� ���������� �������� �볺���
     ��� ���������� ��������� �������� �� ���� ���� �� ����� 150000 ���.
   */

   ELSIF KOD_ = 80014
   THEN
      --
      -- ����� f_stop(80014,#(ref),'',0)
      --
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT CASE
                   WHEN kv2 = 980 THEN s2
                   WHEN kv2 != 980 THEN gl.p_icurval (kv2, s2, gl.bd)
                   ELSE 0
                END
                   sq_t,
                REF,
                tt,
                dk
           INTO l_sq_t,
                l_ref,
                l_tt,
                l_dk
           FROM oper
          WHERE REF = kv_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.REF = l_ref AND ow.tag IN ('FIO');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: ��i�����, I�`�, ��-�������i';
               RAISE err;
         END;

         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE     ow.REF = l_ref
                   AND ow.tag IN ('PASP',
                                  'PASPD',
                                  'NAMED',
                                  'PASNR',
                                  'NAMET');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: ��������';
               RAISE err;
         END;

         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.REF = l_ref AND ow.tag IN ('PASPN');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: ���� � ����� ���������';
               RAISE err;
         END;

         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.REF = l_ref AND ow.tag IN ('ATRT');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: ��� � ���� ������ ��������';
               RAISE err;
         END;

         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.REF = l_ref AND ow.tag IN ('DT_R', 'DATN');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: ���� ����������';
               RAISE err;
         END;

         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.REF = l_ref AND ow.tag IN ('REZID');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: 1-��������,2-����������';
               RAISE err;
         END;

         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.REF = l_ref AND ow.tag IN ('ADRES');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: ������';
               RAISE err;
         END;

         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.REF = l_ref AND ow.tag IN ('KODPL', 'IDA', 'POKPO');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: ��� ��������';
               RAISE err;
         END;
      END IF;
   ---------------------------------------------------------------------------------
   -- kod=80015 ������������� �볺���, �� ��������� ������� ��������>150000 --
   ---------------------------------------------------------------------------------
   --BRSMAIN-2376

   ELSIF KOD_ = 80015
   THEN
      --
      -- ����� f_stop(80015,#(ref),'',0)
      --
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT CASE
                   WHEN kv2 = 980 THEN s2
                   WHEN kv2 != 980 THEN gl.p_icurval (kv2, s2, gl.bd)
                   ELSE 0
                END
                   sq_t,
                REF,
                tt,
                dk
           INTO l_sq_t,
                l_ref,
                l_tt,
                l_dk
           FROM oper
          WHERE REF = kv_;                                    --AND kv2 = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      BEGIN
         SELECT COUNT (1)
           INTO l_exs --  l_exs > 0 ������ ��� ������, ����  l_exs = 0 - ��� ������� ��� ������
           FROM oper o
          WHERE     EXISTS
                       (SELECT *
                          FROM accounts a
                         WHERE     a.nbs IN ('1101', '1102')
                               AND a.ob22 IN ('02', '04')
                               AND a.dazs IS NULL
                               AND a.nls = o.nlsa
                               AND a.kv = o.kv)
                AND REF = l_ref
                AND tt IN ('TMP', 'TM8');
      END;

      BEGIN
         SELECT VALUE
           INTO l_rezid
           FROM operw
          WHERE REF = l_ref AND tag = 'REZID';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_rezid := 0;
      END;

      -- bars_audit.info('F_STOP l_exs - '||l_exs);

      IF l_exs = 0 AND l_tt IN ('TMP', 'TM8')
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'FIO' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                     '*****����� ����� ��������� 342, ��� ������ ������ ��� �������, ��������� ��������� �������:'
                  || q'[ "��i�����, I�''�, ��-�������i".]';
               RAISE err;
         END;
      END IF;

      --  ���� ���.>150000.00 ��� ������� ����� ��� ����������
      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'FIO' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                     '*****���� �������� > 150 000,00. ��������� ��������� �������:'
                  || q'[ "��i�����, I�''�, ��-�������i".]';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE     (   ow.tag = 'PASP'
                        OR ow.tag = 'PASPV'
                        OR ow.tag = 'PASNR'
                        OR ow.tag = 'NAMED'
                        OR ow.tag = 'PASCH'
                        OR ow.tag = 'NAMET')
                   AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "��������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'PASPN' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "���� � ����� ���������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'ATRT' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "��� � ���� ������ ��������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag IN ('DRDAY', 'DT_R') AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "���� ����������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'BPLAC' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "̳��� ����������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000 AND l_rezid = 2
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'NATIO' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "������������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'WORK' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "̳��� ������, ������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'PHONE' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "����� ��������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'PHONW' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "������� �������, ����".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'O_REP' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "������ ��������� �볺���".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'RIZIK' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "г���� ������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'PUBLP' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "��������� �� �������� �����".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'FSVSN' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "������ ����������� �����".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'DJER' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "���-�� ������ ����������� �����".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'ADRES' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "������".';
               RAISE err;
         END;
      END IF;

      IF l_sq_t >= 15000000 AND l_rezid = 1
      THEN
         BEGIN
            SELECT ow.tag
              INTO l_txt
              FROM operw ow
             WHERE ow.tag = 'KODPL' AND ow.REF = l_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� �������� > 150 000,00. ��������� ��������� �������: "��� ��������".';
               RAISE err;
         END;
      END IF;
   ELSIF KOD_ = 80051
   THEN                            -- 278 (30.10.2013), �������� �������������
      --  �� 50 ���. ���.     -  FIO (�� ���� �������������� ��������� � �����. ���������)
      --  ����� 50 ���. ���.  -  FIO, �������, ����, �����, ���� ���������, ����
      --  ��� �������� �������, ��������� � �������

      --  kv_  - ref
      --  nls_ - tt
      --  �� ���� ����� - f_stop(80051,#(ref),'',0)
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT s2,
                REF,
                tt,
                dk
           INTO l_sq_t,
                l_ref,
                l_tt,
                l_dk
           FROM oper
          WHERE REF = kv_ AND kv2 = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      --  ���� ���. > 150000.00 ���., ������� ����� ��������  ��������� 172, � 28.03.2014 �� 01.05.2014
      --  ������� ��������
      IF l_sq_t >= 15000000
      THEN
         l_kk := 0;

         BEGIN                 -- �������� ������������ ��� 50000.00 ���������
            SELECT COUNT (*)
              INTO l_kk
              FROM operw
             WHERE     REF = l_ref
                   AND tag IN ('FIO',
                               'PASNR',
                               'PASPN',
                               'ATRT ',
                               'REZID',
                               'ADRES');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****������ ������! ��������� > 150000.00 ��������� ����� ������������� �볺���';
               RAISE err;
         END;

         IF l_kk < 6
         THEN
            erm :=
               '*****������ ������! ��������� > 150000.00 ��������� ����� ������������� �볺���';
            RAISE err;
         END IF;
      /*    begin
              select value
              into   l_natio
              from   operw
              where  ref=l_ref and
                     tag in ('NATIO');
            exception when others then
              if sqlcode=-1403 then
                null;
              end if;
            end;

            BEGIN
              select value
              into   l_rezid
              from   operw
              where  ref=l_ref and
                     tag in ('REZID');
              if l_rezid='2' and l_natio is null then
                erm := '*******�����! �� ��������� ������������ ��� ��i����-�����������!';
                RAISE err;
              end if;
            end;
      */
      END IF;
   ----------------------------------------------------------------------
   ---kod = 80840 �������� ����������� ����������� ��� ������ ������
   ----------------------------------------------------------------------
   ELSIF KOD_ = 80840
   THEN
      --  �� ���� ����� f_stop(80840,#(ref),'',0)
      --  ���� ������� ��� ��������
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT eqv_obs (kv2, s2, gl.bd),
                REF,
                tt,
                dk
           INTO l_sq_t,
                l_ref,
                l_tt,
                l_dk
           FROM oper
          WHERE REF = kv_ AND kv2 <> 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      IF l_sq_t >= 15000000
      THEN
         l_kk := 0;

         BEGIN
            SELECT COUNT (*)
              INTO l_kk
              FROM operw
             WHERE     REF = l_ref
                   AND tag IN ('FIO',
                               'PASP',
                               'PASPS',
                               'PASPN',
                               'ATRT',
                               'PASP2',
                               'REZID',
                               'POKPO');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****���� ��������� > 150000. ��������� ����� ������������� �볺���';
               RAISE err;
         END;

         IF l_kk < 8
         THEN
            erm :=
               '*****���� ��������� > 150000. ��������� ����� ������������� �볺���';
            RAISE err;
         END IF;
      END IF;
   -----------------------------------------------------------------------------------------
   ---kod = 100 ���������� ������� ������ � �������� �������� (��������� 127 �������� �����)
   -----------------------------------------------------------------------------------------
   ELSIF KOD_ = 100
   THEN
      BEGIN
         SELECT eqv_obs (
                   kv_,
                   DECODE (kv_,
                           840, MOD (s_, 100),
                           978, MOD (s_, 500),
                           643, MOD (s_, 500),
                           826, MOD (s_, 500),
                           124, MOD (s_, 500),
                           756, MOD (s_, 1000),
                           985, MOD (s_, 1000),
                           643, MOD (s_, 1000),
                           0),
                   bankdate,
                   1)
           INTO l_sq
           FROM DUAL;
      END;

      IF kv_ <> gl.baseval AND l_sq = 0
      THEN
         RETURN 0;
      END IF;

      erm :=
            '      ���� �� ������ �������� ����� (��������� 127 ���������): ��� = '
         || kv_
         || ' ���� = '
         || TO_CHAR (s_ / 100, '9999990D99');
      RAISE err;
   ----------------------------------------------------------------------------------------
   ---kod = 104 ��� ����������� �������� �� ����.������� ��
   --- W4R - ����������� �������� �� ����.������� �� (���.<150 ���)
   --- M4Y - ����������� �������� �� ����.������� �� (2900/01 - ���.>=150 ���)
   ----------------------------------------------------------------------------------------
   ELSIF KOD_ = 104
   THEN
      BEGIN
         SELECT tt, gl.p_icurval (kv, s, gl.bd)
           INTO l_tt, l_sq
           FROM oper
          WHERE REF = kv_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      IF l_tt = 'W4R' AND l_sq >= 15000000
      THEN
         erm :=
            '     ���� ��������� > 150���.���., �������������� ��� ����� �������� M4Y';
         RAISE err;
      ELSIF l_tt = 'M4Y' AND l_sq < 15000000
      THEN
         erm :=
            '     ���� ��������� < 150���.���., �������������� ��� ����� �������� W4R';
         RAISE err;
      END IF;
   ----------------------------------------------------
   ---kod = 111 ����� ������ ����� � �������� ��������
   ----------------------------------------------------
   ELSIF KOD_ = 111
   THEN
      BEGIN
         SELECT DECODE (kv_,
                        840, FLOOR (s_ / 100),
                        978, FLOOR (s_ / 500),
                        643, FLOOR (s_ / 500),
                        826, FLOOR (s_ / 500),
                        124, FLOOR (s_ / 500),
                        756, FLOOR (s_ / 1000),
                        985, FLOOR (s_ / 1000),
                        643, FLOOR (s_ / 1000),
                        0)
           INTO l_sq
           FROM DUAL;
      END;

      IF kv_ <> 980 AND l_sq = 0
      THEN
         RETURN 0;
      END IF;

      erm :=
            '      �������� ������ ������ � ��� ����� ����������� ������� ������: ��� = '
         || kv_
         || ' ���� = '
         || TO_CHAR (s_ / 100, '9999990D99');
      RAISE err;
   --------------------------------------------------------------------
   ---kod = 150 �������� ����� >150000 ���. � ��������� �� ����� ���
   --------------------------------------------------------------------
   ELSIF KOD_ = 150
   THEN
      --  select eqv_obs(kv_,s_,trunc(sysdate),0)
      --  into   l_sq
      --  from   dual;
      --  select eqv_obs(kv_,s_,bankdate,0)
      --  into   l_sq
      --  from   dual;

      SELECT tt
        INTO l_tt
        FROM oper
       WHERE REF = p_ref;

      BEGIN
         SELECT COUNT (1)
           INTO l_exs
           FROM oper o
          WHERE     EXISTS
                       (SELECT *
                          FROM accounts a
                         WHERE     a.nbs IN ('1101', '1102')
                               AND a.ob22 IN ('02', '04')
                               AND a.dazs IS NULL
                               AND a.nls = o.nlsa
                               AND a.kv = o.kv)
                AND REF = p_ref
                AND tt IN ('TMP', 'TM8');
      END;

      IF l_exs = 1
      THEN
         --bars_audit.info('F_STOP_TMP 1');
         RETURN 0;
      ELSE
         --bars_audit.info('F_STOP_TMP 2');
         BEGIN
            -- ��� ��4 � ��6 �������� ϲ� �� ���� ����������
            IF l_tt IN ('AA4',
                        'AA6',
                        'TMP',
                        'TTI',
                        'TM8',
                        'TIP',
                        'TI8',
                        'TM2')
            THEN
               SELECT NVL (p.passp, 1),
                      CASE
                         WHEN p.passp = 7 THEN ' '
                         ELSE SUBSTR (REPLACE (TRIM (w.VALUE), ' '), 1, 2)
                      END,
                      CASE
                         WHEN p.passp = 7 THEN REPLACE (TRIM (w.VALUE), ' ')
                         ELSE SUBSTR (REPLACE (TRIM (w.VALUE), ' '), 3)
                      END,
                      TO_NUMBER (REPLACE (w2.VALUE, ',', '.')),
                      CASE
                         WHEN l_tt IN ('TTI') THEN s_
                         ELSE TO_NUMBER (REPLACE (w2.VALUE, ',', '.')) * s_
                      END,
                      w3.VALUE fio,
                      w4.VALUE drday
                 INTO l_vidd,
                      l_serd,
                      l_pasp,
                      l_kurs,
                      l_sq,
                      l_fio,
                      l_drday
                 FROM operw w,
                      passpv p,
                      operw w1,
                      operw w2,
                      operw w3,
                      operw w4
                WHERE     w.REF = p_ref
                      AND w.tag = 'PASPN'
                      AND w1.REF = p_ref
                      AND w1.tag = CASE
                                      WHEN l_tt IN ('TTI',
                                                    'TMP',
                                                    'TM8',
                                                    'TM2')
                                      THEN
                                         'PASP '
                                      ELSE
                                         'PASPV'
                                   END
                      AND w2.REF = p_ref
                      AND w2.tag = CASE
                                      WHEN l_tt IN ('TTI',
                                                    'TMP',
                                                    'TM8',
                                                    'TM2')
                                      THEN
                                         'MKURS'
                                      ELSE
                                         'KURS '
                                   END
                      AND w3.REF = p_ref
                      AND w3.tag = 'FIO  '
                      AND w4.REF = p_ref
                      AND w4.tag = 'DRDAY'
                      AND p.name(+) = w1.VALUE;
            ELSE
               SELECT NVL (p.passp, 1),
                      CASE
                         WHEN p.passp = 7 THEN ' '
                         ELSE SUBSTR (REPLACE (TRIM (w.VALUE), ' '), 1, 2)
                      END,
                      CASE
                         WHEN p.passp = 7 THEN REPLACE (TRIM (w.VALUE), ' ')
                         ELSE SUBSTR (REPLACE (TRIM (w.VALUE), ' '), 3)
                      END,
                      TO_NUMBER (REPLACE (w2.VALUE, ',', '.')),
                      CASE
                         WHEN l_tt IN ('TTI') THEN s_
                         ELSE TO_NUMBER (REPLACE (w2.VALUE, ',', '.')) * s_
                      END
                 INTO l_vidd,
                      l_serd,
                      l_pasp,
                      l_kurs,
                      l_sq
                 FROM operw w,
                      passpv p,
                      operw w1,
                      operw w2
                WHERE     w.REF = p_ref
                      AND w.tag = 'PASPN'
                      AND w1.REF = p_ref
                      AND w1.tag = CASE
                                      WHEN l_tt IN ('TTI',
                                                    'TMP',
                                                    'TM8',
                                                    'TM2')
                                      THEN
                                         'PASP '
                                      ELSE
                                         'PASPV'
                                   END
                      AND w2.REF = p_ref
                      AND w2.tag = CASE
                                      WHEN l_tt IN ('TTI',
                                                    'TMP',
                                                    'TM8',
                                                    'TM2')
                                      THEN
                                         'MKURS'
                                      ELSE
                                         'KURS '
                                   END
                      AND p.name(+) = w1.VALUE;

               l_fio := 'FIO';
               l_drday := '01.01.0001';
            END IF;
         --    bars_audit.info('zzzzzzzz: l_serd='||l_serd||', l_pasp='||l_pasp);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '      �� ������ ����''����� ��� ������-���i��� ������i�)';
               RAISE err;
         END;

         SELECT val_service.get_eq (l_vidd,
                                    l_serd,
                                    l_pasp,
                                    bankdate,
                                    kv_,
                                    l_kurs,
                                    l_sq,
                                    l_fio,
                                    l_drday,
                                    l_tt)
           INTO l_txt
           FROM DUAL;

         IF l_txt IS NULL OR l_txt = ''
         THEN
            RETURN 0;
         END IF;

         -- �� ���������� �������� �� �������� � ��� ����� ��������� ������� ������� �� bars_error.raise_error
         -- erm := '      ��������� ��� ' || to_char(limeq.G_KQ/100) || ' ������-���i��� ������i�)';
         -- erm := '      ' || l_txt;
         -- RAISE err;
         bars_error.raise_error ('DOC', 47, '   ' || l_txt);
      END IF;
   -----------------------------------------------
   ---kod = 151 �������� ��� �� ������ ���������
   ---          �������� "��� � ���� ������ ��������" ��� ��������� "������� ID-������"
   -----------------------------------------------
   ELSIF KOD_ = 151
   THEN
      BEGIN
         /*
         select nvl(p.passp,1),
                replace(trim(w.value),' ')
         into   l_vidd,
                val_
         from   operw  w ,
                 passpv p
         where  w.ref=p_ref    and
                w.tag='PASPN'   and
                w1.ref=p_ref   and
               (w1.tag='PASPV' or w1.tag='PASNR') and
                p.name(+)=w1.value;
           */


         l_name :=
            NVL (
               NVL (
                  NVL (TRIM (f_dop (p_ref, 'PASPV')),
                       TRIM (f_dop (p_ref, 'PASNR'))),
                  TRIM (f_dop (p_ref, 'NAMET'))),
               TRIM (f_dop (p_ref, 'PASP ')));
         val_ := TRIM (f_dop (p_ref, 'PASPN'));

         BEGIN
            SELECT VALUE
              INTO l_rezid
              FROM operw
             WHERE REF = p_ref AND tag = 'REZID';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_rezid := NULL;
         END;

         BEGIN
            SELECT tag
              INTO l_tag
              FROM operw
             WHERE     tag IN ('PASPV',
                               'PASNR',
                               'NAMET',
                               'PASP ')
                   AND REF = p_ref;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_tag := NULL;
         END;

         IF (l_tag = 'PASPV' OR l_tag = 'PASNR')
         THEN
            SELECT rezid, passp
              INTO l_pasp_rezid, l_vidd
              FROM passpv
             WHERE name = l_name;
         ELSIF l_tag = 'NAMET'
         THEN
            SELECT resid, passpt
              INTO l_pasp_rezid, l_vidd
              FROM passpt
             WHERE name = l_name;
         ELSIF l_tag = 'PASP '
         THEN
            SELECT rezid, passp
              INTO l_pasp_rezid, l_vidd
              FROM passp
             WHERE name = l_name;
         END IF;

         IF (    l_rezid <> l_pasp_rezid
             AND l_rezid IS NOT NULL
             AND l_pasp_rezid IS NOT NULL)
         THEN
            erm :=
               '*****������������ �������� "��������" �� �������� "��������"!!!';
            RAISE err;
         END IF;

         IF (l_name IS NOT NULL)
         THEN
            IF val_ IS NULL
            THEN
               erm := '      ������� ��� ���������';
               RAISE err;
            ELSE
               NULL;
            END IF;
         ELSE
            RETURN 0;
         END IF;

         IF (    l_vidd NOT IN (5,
                                16,
                                17,
                                91)
             AND l_rezid = '1')
         THEN
            IF      INSTR (val_, '-')
                  + INSTR (val_, '_')
                  + INSTR (val_, '*')
                  + INSTR (val_, '=')
                  + INSTR (val_, '+')
                  + INSTR (val_, '!')
                  + INSTR (val_, '#')
                  + INSTR (val_, '%')
                  + INSTR (val_, '\')
                  + INSTR (val_, '/')
                  + INSTR (val_, '"')
                  + INSTR (val_, ':')
                  + INSTR (val_, ';')
                  + INSTR (val_, '|')
                  + INSTR (val_, '?')
                  + INSTR (val_, '<')
                  + INSTR (val_, '>')
                  + INSTR (val_, '.')
                  + INSTR (val_, ',')
                  + INSTR (val_, '~')
                  + INSTR (val_, '`')
                  + INSTR (val_, '@')
                  + INSTR (val_, '$')
                  + INSTR (val_, '^')
                  + INSTR (val_, '&')
                  + INSTR (val_, '(')
                  + INSTR (val_, ')')
                  + INSTR (val_, '{')
                  + INSTR (val_, '}')
                  + INSTR (val_, '[')
                  + INSTR (val_, ']')
                  + INSTR (val_, '''') > 0
               OR (NVL (LENGTH (REPLACE (val_, ' ')), 0) <> 8 AND l_vidd <> 7)
            THEN
               erm :=
                  '      ������� ��� �� (��) ������ ���������';
               RAISE err;
            ELSIF l_vidd = 7
            THEN
               BEGIN
                  IF LENGTH (REPLACE (val_, ' ')) = 9
                  THEN
                     n1_ := TO_NUMBER (SUBSTR (REPLACE (val_, ' '), -9)) + 1;
                  ELSE
                     erm :=
                           '      ������� ������ ��������� ('
                        || l_name
                        || '), ����� �� ������ 9 ���� ';
                     RAISE err;
                  END IF;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     erm :=
                           '      ������� ������ ��������� ('
                        || l_name
                        || '), ����� �� ������ 9 ���� ';
                     RAISE err;
               END;
            /*               BEGIN
                             l_atrt :=  TRIM (f_dop (p_ref, 'ATRT'));
                             IF LENGTH(REPLACE (l_atrt, ' ')) = 4 THEN
                                 n1_ := TO_NUMBER (SUBSTR (REPLACE (l_atrt, ' '), -4)) + 1;
                              ELSE
                                 erm := '      ������� ��������� �������� (��� � ���� ������ ��������), ������� �� ������ 4 ����� ';
                                 RAISE err;
                              END IF;
                           EXCEPTION
                              WHEN OTHERS
                              THEN erm := '      ������� ��������� �������� (��� � ���� ������ ��������), ������� �� ������ 4 ����� ';
                                   RAISE err;
                           END;*/
            ELSE
               BEGIN
                  n1_ := TO_NUMBER (SUBSTR (REPLACE (val_, ' '), -6)) + 1;
               EXCEPTION
                  WHEN OTHERS
                  THEN
                     erm :=
                        '      ������� ������ ���������';
                     RAISE err;
               END;

               IF    (    SUBSTR (REPLACE (val_, ' '), 1, 1) >= '0'
                      AND SUBSTR (REPLACE (val_, ' '), 1, 1) <= '9')
                  OR (    SUBSTR (REPLACE (val_, ' '), 2, 1) >= '0'
                      AND SUBSTR (REPLACE (val_, ' '), 2, 1) <= '9')
               THEN
                  erm := '      ������� ��� ���������';
                  RAISE err;
               END IF;
            END IF;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            erm :=
               '      ������� ��� �� (��) ������ ���������)';
            RAISE err;
      END;

      RETURN 0;
   ----------------------------------------------------------------------------------
   ---kod = 152 �������� ND377 �� ������
   ----------------------------------------------------------------------------------

   ELSIF KOD_ = 152
   THEN
      /*  begin
            select trim(value) into l_nd377 from operw
               where ref=p_ref
                       and tag='ND377';
                 exception when no_data_found then
              erm:='******�������� ������� "����� ������ �� ������ 377"';
                          raise err;

        end;
             if l_nd377 is null then
          erm:='*****�������� ������� "����� ������ �� ������ 377"';
                      raise err;
        end if;
    */
      DECLARE
         l_sum_ascii   NUMBER := 0;
      BEGIN
         BEGIN
            SELECT VALUE
              INTO l_nd377
              FROM operw
             WHERE REF = p_ref AND tag = 'ND377';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               RETURN 0;
         END;

         FOR i IN 1 .. LENGTH (l_nd377)
         LOOP
            l_sum_ascii := l_sum_ascii + ASCII (SUBSTR (l_nd377, i, 1));
         END LOOP;

         IF l_sum_ascii / 32 = LENGTH (l_nd377)
         THEN
            erm :=
               '*****���������� ����������� �������� "����� ������ �� ������ 377"';
            RAISE err;
         END IF;
      END;

      RETURN 0;
   ----------------------------------------------------------------------------------
   ---kod = 153 ������� � ��� �� ������ 2-� ������
   --- ������������ ��� ������ ������� � ����� ������ ���
   ----------------------------------------------------------------------------------

   ELSIF KOD_ = 153
   THEN
      BEGIN
         SELECT TRIM (SUBSTR (VALUE, 1, INSTR (VALUE, ' ', 1) - 1)),
                TRIM (SUBSTR (VALUE, INSTR (VALUE, ' ', 1) + 1))
           INTO l_fio, l_name
           FROM operw
          WHERE REF = p_ref AND tag = 'FIO';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            erm := '******�������� ������� "ϲ�"';
            RAISE err;
      END;

      logger.info ('f_stop: l_fio=>' || l_fio || ', l_name=>' || l_name);

      IF NVL (LENGTH (l_fio), 0) < 2
      THEN
         erm :=
            '*****������� ������� ����� 2-� ����';
         RAISE err;
      END IF;

      IF NVL (LENGTH (l_name), 0) < 2
      THEN
         erm := '*****������� ���� ����� 2-� ����';
         RAISE err;
      END IF;

      logger.info (
            'f_stop(length): l_fio=>'
         || LENGTH (l_fio)
         || ', l_name=>'
         || LENGTH (l_name));

      RETURN 0;
   --------------------------------------------------------------------------------
   -- KOD=154 ��� �������� �����. �������� ���.����������.
   --------------------------------------------------------------------------------
   ELSIF KOD_ = 154
   THEN
      BEGIN
         SELECT TO_NUMBER (VALUE)
           INTO l_cnt
           FROM operw
          WHERE REF = p_ref AND tag = 'PO_KK';
      EXCEPTION
         WHEN OTHERS
         THEN
            erm :=
               '*****������ ���������� ������� "�������� �������"';
            RAISE err;
      END;

      SELECT COUNT (*)
        INTO l_cnt_NDC
        FROM operw
       WHERE REF = p_ref AND tag LIKE 'NDC%';

      SELECT COUNT (*)
        INTO l_cnt_NUC
        FROM operw
       WHERE REF = p_ref AND tag LIKE 'NUC%';

      IF l_cnt_NDC != l_cnt
      THEN
         erm :=
            '*****�� ������� ������� �������� "������ ��������� ����" � ��������� "�������� �������"';
         RAISE err;
      END IF;

      IF l_cnt_NUC != l_cnt
      THEN
         erm :=
            '*****�� ������� ������� �������� "����� ��������� ����" � ��������� "�������� �������"';
         RAISE err;
      END IF;

      RETURN 0;
   --------------------------------------------------------------------------------
   -- KOD=155 ��� �����. �������� ������������� �������� ��� s>50000���(����������)
   --------------------------------------------------------------------------------
   ELSIF KOD_ = 155
   THEN
      --  kv_  - ref
      --  nls_ - tt
      --  �������� ���������� ���� ������� �������� (�� ����� 50���.���)
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT eqv_obs (kv_,
                         s_,
                         bankdate,
                         0)
           INTO l_sq
           FROM DUAL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      BEGIN
         IF l_sq >= 5000000
         THEN
            l_kk := 0;

            BEGIN              -- �������� ������������ ��� 50000.00 ���������
               SELECT COUNT (*)
                 INTO l_kk
                 FROM operw
                WHERE     REF = gl.aref
                      AND tag IN ('FIO',
                                  'PASCH',
                                  'PASPN',
                                  'ATRT',
                                  'REZID',
                                  'ADRES',
                                  'RNOKP');
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  erm :=
                     '***** ��������� > 50000. ��������� ����� ������������� �볺���';
                  RAISE err;
            END;

            IF l_kk < 7
            THEN
               erm :=
                  '*****��������� > 50000. ��������� ����� ������������� �볺���';
               RAISE err;
            END IF;
         END IF;
      END;

      BEGIN
         SELECT TO_NUMBER (VALUE)
           INTO l_rezid
           FROM operw
          WHERE REF = p_ref AND tag = 'REZID';

         BEGIN
            SELECT w.VALUE
              INTO l_name
              FROM operw w, passpv p
             WHERE     w.tag = 'PASCH'
                   AND w.REF = p_ref
                   AND w.VALUE = p.name
                   AND p.passp IN (SELECT passp
                                     FROM passpv
                                    WHERE rezid = l_rezid);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '*****������������ �������� "��������" �� �������� "��������"';
               RAISE err;
         END;
      END;

      RETURN 0;
   --------------------------------------------------------------------------------
   -- KOD=156 ��� ������� �����. �������� ���.����������.
   --------------------------------------------------------------------------------
   ELSIF KOD_ = 156
   THEN
      BEGIN
         SELECT TO_NUMBER (VALUE)
           INTO l_cnt
           FROM operw
          WHERE REF = p_ref AND tag = 'PO_KK';
      EXCEPTION
         WHEN OTHERS
         THEN
            erm :=
               '*****������ ���������� ������� "�������� �������"';
            RAISE err;
      END;

      SELECT COUNT (*)
        INTO l_cnt_NDC
        FROM operw
       WHERE REF = p_ref AND tag LIKE 'NOC%';

      SELECT COUNT (*)
        INTO l_cnt_NUC
        FROM operw
       WHERE REF = p_ref AND tag LIKE 'NNC%';

      IF l_cnt_NDC != l_cnt
      THEN
         erm :=
            '*****�� ������� ������� �������� "������ ��������� ����" � ��������� "�������� �������"';
         RAISE err;
      END IF;

      IF l_cnt_NUC != l_cnt
      THEN
         erm :=
            '*****�� ������� ������� �������� "����� ��������� ����" � ��������� "�������� �������"';
         RAISE err;
      END IF;

      RETURN 0;
   ----------------------------------------------------------------------------------
   ---kod = 157 ��������� ����� ���������, ��� � ����� ����� �� ������
   ---��� ������ ������������� �������
   ----------------------------------------------------------------------------------
   ELSIF kod_ = 157
   THEN
      BEGIN
         SELECT NVL (eqv_obs (kv_,
                              s_,
                              bankdate,
                              1),
                     0)
           INTO l_sq
           FROM DUAL;
      END;

      --bars_audit.info('F_STOP_157 l_sq = '|| l_sq);
      IF l_sq > 1500000                                              --2514000
      THEN
         BEGIN
            SELECT COUNT (1)
              INTO l_count_157
              FROM operw
             WHERE REF = p_ref AND tag IN ('ATRT', 'PASPN');
         END;

         IF l_count_157 < 2
         THEN
            erm :=
               '*****��������� ��������� ��������(����,�����,��� ������� ��������)';
            --bars_audit.info('F_STOP_157 erm = '|| erm);
            RAISE err;
         END IF;
      END IF;

      RETURN 0;
   --------------------------------------------------------------------------------
   -- KOD=158 ��� tt in (025, 016) �������� ���.����������.
   --------------------------------------------------------------------------------
   ELSIF KOD_ = 158
   THEN
      BEGIN
         SELECT TO_NUMBER (VALUE)
           INTO l_cnt
           FROM operw
          WHERE REF = p_ref AND tag = 'PO_KK';
      EXCEPTION
         WHEN OTHERS
         THEN
            erm :=
               '*****������ ���������� ������� "�������� �������"';
            RAISE err;
      END;

      SELECT COUNT (*)
        INTO l_cnt_NDC
        FROM operw
       WHERE REF = p_ref AND tag LIKE 'NOM%';

      SELECT COUNT (*)
        INTO l_cnt_NUC
        FROM operw
       WHERE REF = p_ref AND tag LIKE 'NNS%';

      IF l_cnt_NDC != l_cnt
      THEN
         erm :=
            '*****�� ������� ������� �������� "������ ��������" � ��������� "�������� �������"';
         RAISE err;
      END IF;

      IF l_cnt_NUC != l_cnt
      THEN
         erm :=
            '*****�� ������� ������� �������� "����� �� ���� ��������" � ��������� "�������� �������"';
         RAISE err;
      END IF;

      RETURN 0;
   ----------------------------------------------------------------------------------
   ---kod = 101 �������� ������� �������� � ��������� ����� 15000 ��� � ���� ����
   ----------------------------------------------------------------------------------
   ELSIF KOD_ = 101
   THEN
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT eqv_obs (kv_,
                         s_,
                         bankdate,
                         0)
           INTO l_sq
           FROM DUAL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      IF l_sq >= 1500000
      THEN
         erm :=
            '******�����! ���i������ ���� �������� >= 15000.00 ���******';
         RAISE err;
      END IF;

      BEGIN
         BEGIN
            SELECT w.VALUE fio, w2.VALUE pasp
              INTO l_fio, l_pasp
              FROM operw w, operw w2, oper o
             WHERE     o.REF = w.REF
                   AND w2.REF = o.REF
                   AND o.REF = p_ref
                   AND w.tag = 'FIO'
                   AND w2.tag = 'PASPN';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               erm :=
                  '******��������� ������������� �볺���!!!******';
               RAISE err;
         END;

         BEGIN
            SELECT NVL (SUM (gl.p_icurval (o.kv, o.s, gl.bd)), 0)
              INTO l_sq
              FROM oper o, operw w
             WHERE     o.REF = w.REF
                   AND o.pdat >= TRUNC (SYSDATE)
                   AND o.pdat < TRUNC (SYSDATE) + 1
                   AND w.tag = 'FIO'
                   AND TRIM (
                          UPPER (f_translate_kmu (REPLACE (w.VALUE, ' ')))) =
                          TRIM (
                             UPPER (f_translate_kmu (REPLACE (l_fio, ' '))))
                   AND sos >= 1
                   AND o.tt IN (SELECT tt
                                  FROM perekaz_tt
                                 WHERE flag = 'I');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_sq := 0;
         END;

         IF l_sq >= 1500000
         THEN
            erm :=
                  '******������� '
               || l_fio
               || ' ���������� �i�i� 15000 ���. ��� ��������';
            RAISE err;
         END IF;

         BEGIN
            SELECT NVL (SUM (gl.p_icurval (o.kv, o.s, gl.bd)), 0)
              INTO l_sq
              FROM oper o, operw w
             WHERE     o.REF = w.REF
                   AND o.pdat >= TRUNC (SYSDATE)
                   AND o.pdat < TRUNC (SYSDATE) + 1
                   AND    recode_passport_serial_noex (
                             SUBSTR (REPLACE (w.VALUE, ' '), 1, 2))
                       || SUBSTR (REPLACE (w.VALUE, ' '),
                                  3,
                                  LENGTH (REPLACE (w.VALUE, ' '))) =
                             recode_passport_serial_noex (
                                SUBSTR (REPLACE (l_pasp, ' '), 1, 2))
                          || SUBSTR (REPLACE (l_pasp, ' '),
                                     3,
                                     LENGTH (REPLACE (l_pasp, ' ')))
                   AND sos >= 1
                   AND o.tt IN (SELECT tt
                                  FROM perekaz_tt
                                 WHERE flag = 'I');
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               l_sq := 0;
         END;

         IF l_sq >= 1500000
         THEN
            erm :=
                  '******������� '
               || l_pasp
               || ' ���������� �i�i� 15000 ���. ��� ��������';
            RAISE err;
         END IF;
      END;
   --

   ELSIF KOD_ = 80102
   THEN
      --  kv_  - ref
      --  nls_ - tt
      --  �������� ���������� ���� ������� �������� (�� ����� 50���.���)
      BEGIN                          -- �������� ���������� �������� ���������
         SELECT eqv_obs (kv_,
                         s_,
                         bankdate,
                         0)
           INTO l_sq
           FROM DUAL;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN 0;
      END;

      BEGIN
         IF l_sq >= 15000000
         THEN
            l_kk := 0;

            BEGIN             -- �������� ������������ ��� 150000.00 ���������
               SELECT COUNT (*)
                 INTO l_kk
                 FROM operw
                WHERE     REF = gl.aref
                      AND tag IN ('FIO',
                                  'PASP',
                                  'PASPN',
                                  'ATRT',
                                  'REZID',
                                  'ADRES',
                                  'RNOKP');
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  erm :=
                     '***** ��������� > 150000. ��������� ����� ������������� �볺���';
                  RAISE err;
            END;

            IF l_kk < 7
            THEN
               erm :=
                  '*****��������� > 150000. ��������� ����� ������������� �볺���';
               RAISE err;
            END IF;
         END IF;
      END;
   /*  ��������a �������� ��� �� 03 ������� 2015 ���� � 160
       COBUSUPABS-3353
       �������� ������ ��� �� �������� �볺��� ������� �������� ������� ����� �� ���������, ��� � ������� ����,
    �� �������� ���, ������������ ��� (����� ����������� �������� �볺��� �� ����� ��������,
    ��� �� ����������� ������� ����� �� ��������).
       ��������� ���������� �������� ������� ��������� ����� � ������� ������� ����� � �������� ����� ��� ���������� �������,
    �������� �� ����� ��������� �������� ��� �� 03 ������� 2015 ���� � 160, ��������� ������� ����� �� �������� ������ �볺���
    � ����� ����������� ����� (15 000). �������� ��������� ���������� �� ���������� DM1, DMF, DPG, DPF, DP9, DPV �������� ������ ������������ ���.
       PABS-814
      ��������a �������� ��� �� 03 ������� 2015 ���� � 160
      ��� ���� �����, �� ������ 15000 �� 20000*/

   ELSIF KOD_ = 160
   THEN   RETURN 0;  --��������� ���  81
      IF KV_ = 980                --� �������� ����� ��� ���������� �������
      THEN
         RETURN 0;
      END IF;

      -- �������� ���������� �������� ���������
      BEGIN
         SELECT ROUND (o.s * f_ret_rate (o.kv, TRUNC (SYSDATE), 'O'), 0),
                a.rnk
           INTO l_sq, l_rnk
           FROM oper o, accounts a
          WHERE     o.REF = p_ref
                AND a.nls = NLS_
                AND a.kv = KV_
                AND A.NLS = DECODE (o.dk, 1, o.nlsa, o.nlsb)
                AND o.sos > 0
                AND NOT EXISTS
                           (SELECT 1
                              FROM operw ow
                             WHERE     ow.REF = o.REF
                                   AND ow.tag = 'EXCFL'
                                   AND ow.VALUE = '1'
                                   AND EXISTS
                                          (SELECT 1
                                             FROM operw
                                            WHERE     REF = ow.REF
                                                  AND tag = 'REZID'
                                                  AND VALUE = '2'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_sq := 0;
      END;

      bars_audit.info (
            '!f_stop#160 l_sq='
         || TO_CHAR (l_sq)
         || ', l_rnk='
         || TO_CHAR (l_rnk));

      BEGIN
         SELECT NVL (
                   ROUND (
                      SUM (o.s * f_ret_rate (o.kv, TRUNC (SYSDATE), 'O')),
                      0),
                   0)
           INTO l_sq_t
           FROM oper o, accounts a
          WHERE     A.NLS = DECODE (o.dk, 1, o.nlsa, o.nlsb)
                AND A.KV = DECODE (o.dk, 1, o.kv, o.kv2)
                AND o.sos > 0
                AND SUBSTR (a.nls, 4, 1) != '8'
                AND a.kv != 980
                AND SUBSTR (DECODE (o.dk, 0, o.nlsa, o.nlsb), 1, 4) IN ('1001',
                                                                        '1002')
                AND pdat >= TRUNC (SYSDATE)
                AND pdat < TRUNC (SYSDATE) + 1
                AND a.rnk = l_rnk
                AND NOT EXISTS
                           (SELECT 1
                              FROM operw ow
                             WHERE     ow.REF = o.REF
                                   AND ow.tag = 'EXCFL'
                                   AND ow.VALUE = '1'
                                   AND EXISTS
                                          (SELECT 1
                                             FROM operw
                                            WHERE     REF = ow.REF
                                                  AND tag = 'REZID'
                                                  AND VALUE = '2'));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            l_sq_t := 0;
      END;

      bars_audit.info (
            '!f_stop#160 ����� ����� �� ���� �� �������� ������ ������� l_sq_t='
         || TO_CHAR (l_sq_t));

      --��� ��������� ��������� ����� ��������
      l_sq_t := l_sq_t - l_sq;

      bars_audit.info (
            '!f_stop#160 ����� ����� �������� l_sq_t + l_sq='
         || TO_CHAR (l_sq_t + l_sq));

      IF l_sq_t + l_sq >= 25000000
      THEN
         erm :=
            '******������� ���� �� �������� ������� �������� �������� 250000 ��� � ��������� (����.��� �386 �� 14 ������� 2016 �).';
         RAISE err;
      END IF;
   /*
   ������ ���������� �������� �� 3� ������
   */

   ELSIF KOD_ = 161
   THEN
      e_br := LENGTH (SYS_CONTEXT ('bars_context', 'user_branch'));

      IF e_br > 15
      THEN
         bars_audit.info (
               '!f_stop#161 �������� ���������� �������� �� �������� ��� '
            || SYS_CONTEXT ('bars_context', 'user_branch'));
         erm :=
            '******�������� ���������� �������� �� �������� ���';
         RAISE err;
      END IF;
   /*
   �� ��� ��������� �������� ���� �� �������� ���������� � ���� � ������ ������ ��
   ˳�� ��������� � �������� REf_ � �������

   */

   ELSIF KOD_ = 8888 THEN
      select nvl(gl.p_icurval(kv_, sum(decode(dk, 0, s, 1, s2, 0)), gl.bd), 0)
        into l_sq_t
        from oper t
       where t.pdat between trunc(sysdate, 'mm') and
             trunc(sysdate) + 1 - interval '1' second and
             ((t.dk = 1 and t.nlsb = nls_ and t.kv2 = kv_ and t.nlsa like '10%') or
             (t.dk = 0 and t.nlsa = nls_ and t.kv = kv_ and t.nlsb like '10%'))and
             sos >= 0;

      l_sq := p_ref - l_sq_t;

      IF l_sq < 0
      THEN
         bars_audit.info ('!f_stop#8888 ���������� ��� �������� �� ������� #'||nls_||'# �� ����: '|| abs(l_sq)/100 ||' ���.');
         erm := '˳�� �������� ��� ��� ���������� �� ����: '|| abs(l_sq)/100 ||' ���.';
         RAISE err;
      END IF;



       /*
    COBUSUPABS-6352 ���� ��������� ���������� ����� ��������� ������
    */

  elsif kod_ = 1478 then

    begin
      l_kv := kv_;

      -- 1.��������� ��������� ���� ���������, ���� ��� ����� = �������
      begin
  select dd.deposit_id, dd.acc, v.term_add, dd.dat_begin, dd.limit, v.comproc
      into l_deposit, l_acc, l_term_add, l_dat_begin, l_limit, l_comproc
      from dpt_deposit dd, accounts a, dpt_vidd v
     where dd.acc = a.acc
       and a.nls = NLS_
       and a.kv = l_kv
       and dd.vidd = v.vidd;
exception when no_data_found then 
return 0;
end ; 
      l_term_add1 := to_number(floor(l_term_add));

      bars_audit.trace('1478 ' || l_deposit || ' ' || l_term_add1 || ' ' ||
                      l_dat_begin || ' ' || l_limit);

      --���������� ��� ������
      if nvl(l_term_add1, 0) = 0 then
        bars_audit.trace('1478 ' || '���������� ��� ������');
        return 0;
      end if;

      -- 2.��������� ��� ������, �������� �� �����������
      l_res := dpt_web.forbidden_amount(l_acc, s_);
      bars_audit.trace('1478 ' || 'l_res0: ' || l_res);
      if (l_res = 0) then
        bars_audit.trace('1478 ' || 'l_res1: ' || l_res);
        null;
      elsif (l_res = 1) then
        bars_audit.trace('1478 ' ||
                        '����� �� ��������� ����������! l_res2: ' ||
                        l_res);
        erm := '******����� �� ��������� ����������!';
        raise err;
      else
        bars_audit.trace('1478 ' ||
                        'C��� ����������� �� ���������� �������');
        erm := '******C��� ����������� �� ���������� ������� #' ||
               to_char(l_acc) ||
               ' ����� �� �������� ���� ���������� ������ (' ||
               to_char(l_res / 100) || ' / ' || l_kv || ')';
        raise err;
      end if;

      -- 3.��������� ����� �� ��� ��������� � ��������� ������ �� ���� ������
      l_dat_start := l_dat_begin;
      l_dat_end   := add_months(l_dat_begin, l_term_add1) - 1;

      bars_audit.trace('1478 ' ||
                      '��������� ����� �� ��� ��������� � ��������� ������ �� ���� ������ ' ||
                      l_dat_start || ' ' || l_dat_end);

      if --��� ��, ��������� �����
       trunc(sysdate) between l_dat_start and l_dat_end then
        bars_audit.trace('1478 ' || '��� ��, ��������� ����� ');
        null;
      else
        bars_audit.trace('1478 ' || '���������� ���� ����������');
        -- ���������� ���� ����������
        erm := '******�� ������ �������� ����� ����������! ����� ������� ���� ����������� �������� ' ||
               to_char(l_term_add1) || ' �c����.';
        raise err;
      end if;

      -- 4.��������� ��������� ����  ������
      select floor(months_between(trunc(sysdate), (l_dat_begin)))
        into l_count_mm
        from dual;

      bars_audit.trace('1478 ' || 'l_count_mm ' || l_count_mm);

      l_dat_s  := add_months(l_dat_begin, l_count_mm);
      l_dat_po := add_months(l_dat_s, 1) - 1;

      bars_audit.trace('1478 ' || l_dat_s || ' - ' || l_dat_po);

      --5.��������� �� ���� ������ ����� ���������� �� ������
    if nvl(l_comproc, 0) = 0 then
     --��� �������������-�� ��������� ����� ���������� �������� 'DP5' � 'DPL
    select nvl(sum(o.s), 0)
      into l_sum_month
      from dpt_payments p, oper o
     where p.ref = o.ref
       and o.ref !=  p_ref
       and p.dpt_id = l_deposit
       and o.sos >= 0
       and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DP5', 'DPD', 'DPI', 'DPL', 'W2D', 'DBF', 'ALT',
                   '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
       and o.pdat between l_dat_s and l_dat_po;

     else
       --���� �������������-�� �� ��������� � ����� ���������� �������� 'DP5' � 'DPL'
         select nvl(sum(o.s), 0)
      into l_sum_month
      from dpt_payments p, oper o
     where p.ref = o.ref
       and o.ref !=  p_ref
       and p.dpt_id = l_deposit
       and o.sos >=0
       and o.tt in ('PKD', 'OW4', 'PK!', '215', '015', '515', '013', 'R01', 'DP0', 'DP2', 'DPD', 'DPI', 'W2D', 'DBF', 'ALT',
                   '24', '190', '191', '901', 'BAK', 'I00', 'IB1', 'IB1', 'OW1', 'OW5', 'SMO', 'ST2', 'PS1', 'ZMO')
       and o.pdat between l_dat_s and l_dat_po;

    end if;

      bars_audit.trace('1478 ' || 'l_sum_month ' || l_sum_month);

      -- ��������� ����� ����� � ����� ���������
      l_sum := l_sum_month + s_;

      --6.�������� ����� �������� � ���������� ������
      -- ���� ����� ����� �� ��������� ����� = ��������� �������� ��������, ���� ��� = ������ ��������� ��� ������� ���������
      bars_audit.trace('1478 l_sum:' || l_sum || ' l_limit: ' || l_limit);

      select count(*)
      into l_is_bnal
      from bars.dpt_depositw dw
      where dw.dpt_id = l_deposit
        and dw.tag = 'NCASH'
        and dw.value = 1;

      bars_audit.trace('1478 ������: ' || l_is_bnal);

      if (l_count_mm = 0) and (l_is_bnal > 0) then -- ������ ����� � ������

        if l_sum > l_limit * 2 then
          bars_audit.trace('1478 ' || '���������� ����� ����!');
          erm := '******���������� ����� ���� ' || to_char(l_limit) ||
               ' �� ���� � ' || to_char(l_dat_s) || ' �� ' ||
               to_char(l_dat_po);
          raise err;
        else
          null;
        end if;

      elsif l_sum > l_limit then
        bars_audit.trace('1478 ' || '���������� ����� ����!');
        erm := '******���������� ����� ���� ' || to_char(l_limit) ||
               ' �� ���� � ' || to_char(l_dat_s) || ' �� ' ||
               to_char(l_dat_po);
        raise err;
      else
        null;
      end if;

    end; -- end of 1478

  end if;


   RETURN 0;
EXCEPTION
   WHEN err
   THEN
      raise_application_error (- (20000 + ern), '\' || erm, TRUE);
   WHEN OTHERS
   THEN
      raise_application_error (
         - (20000 + ern),
            DBMS_UTILITY.format_error_stack ()
         || CHR (10)
         || DBMS_UTILITY.format_error_backtrace (),
         TRUE);
END f_STOP;
/



grant execute on f_stop to bars_access_defrole; 