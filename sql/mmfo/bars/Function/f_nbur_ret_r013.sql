
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_ret_r013.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_RET_R013 (
  p_dat         in      date,
  p_nbs         IN      VARCHAR2,
  p_kv          IN      NUMBER,
  p_r013_old    IN      VARCHAR2,
  p_tp          IN      NUMBER
)
  RETURN VARCHAR2
IS
  l_r013_new   VARCHAR2 (1) := p_r013_old;
  l_find_ok    NUMBER;
BEGIN

  BEGIN
     SELECT COUNT (*)
       INTO l_find_ok
       FROM kl_r013
      WHERE trim(prem) = 'สม'
        AND r020 = p_nbs
        AND r013 = p_r013_old
        AND (d_close IS NULL OR d_close >= p_dat);
  EXCEPTION
     WHEN NO_DATA_FOUND
     THEN
        l_find_ok := 0;
  END;

  IF p_nbs NOT IN
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
      p_nbs IN
        ('2108',
         '2118',
         '2128',
         '2138') and
      p_dat <  to_date('12092015','ddmmyyyy')
  THEN
     if p_nbs = '1438' then -- "ianoaiaa?oiee" ?aooiie, aey yeiai iaia? ?iciia?eo ii R013
        l_r013_new := '0';
     else
         IF p_tp = 1
         THEN                                                   -- ai 30 aiae
            l_r013_new := '3';
         ELSE                                                 -- nauoa 30 aiae
            l_r013_new := '4';
         END IF;
     end if;
  ELSE
     -- iaiaiicia?iua eiiaeiaoee ia?aiao?ia
     IF p_nbs IN ('1408', '1418', '1428')
     THEN
        IF l_find_ok = 1
        THEN                                  -- anou oaeea a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              IF p_r013_old IN ('3', '5', '9')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) - 1);
              END IF;
           ELSE                                           -- nauoa 30 aiae
              IF p_r013_old IN ('2', '4', '8')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) + 1);
              END IF;
           END IF;
        ELSE         -- iao a ni?aai?ieea - oiaaa iaecaanoii, ?oi noaaeou?
           NULL;                                      -- ia iaiyai ie?aai
        END IF;
     END IF;

     IF p_nbs IN ('1508', '2068')
     THEN
        IF l_find_ok = 1
        THEN                                  -- anou oaeea a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              IF p_r013_old IN ('4', '6')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) - 1);
              END IF;
           ELSE                                           -- nauoa 30 aiae
              IF p_r013_old IN ('3', '5')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) + 1);
              END IF;
           END IF;
        ELSE         -- iao a ni?aai?ieea - oiaaa iaecaanoii, ?oi noaaeou?
           NULL;                                      -- ia iaiyai ie?aai
        END IF;
     END IF;

     IF p_nbs IN ('1518', '1528', '2088')
     THEN
        IF l_find_ok = 1
        THEN                                  -- anou oaeea a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              IF p_r013_old IN ('7', '8')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) - 2);
              END IF;
           ELSE                                           -- nauoa 30 aiae
              IF p_r013_old IN ('5', '6')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) + 2);
              END IF;
           END IF;
        ELSE                                          -- iao a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              l_r013_new := '5';
           ELSE                                           -- nauoa 30 aiae
              l_r013_new := '7';
           END IF;
        END IF;
     END IF;

     IF p_nbs IN ('2108', '2118', '2128')
     THEN
        IF l_find_ok = 1
        THEN                                  -- anou oaeea a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              IF p_r013_old IN ('6', '8')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) - 1);
              ELSIF p_r013_old IN ('A')
              THEN
                 l_r013_new := '9';
              END IF;
           ELSE                                           -- nauoa 30 aiae
              IF p_r013_old IN ('5', '7')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) + 1);
              ELSIF p_r013_old IN ('9')
              THEN
                 l_r013_new := 'A';
              END IF;
           END IF;
        ELSE                                          -- iao a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              l_r013_new := '7';
           ELSE                                           -- nauoa 30 aiae
              l_r013_new := '8';
           END IF;
        END IF;
     END IF;

     IF p_nbs IN ('2138')
     THEN
        IF l_find_ok = 1
        THEN                                  -- anou oaeea a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              IF p_r013_old IN ('6', '8')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) - 1);
              END IF;
           ELSE                                           -- nauoa 30 aiae
              IF p_r013_old IN ('5', '7')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) + 1);
              END IF;
           END IF;
        ELSE                                          -- iao a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              l_r013_new := '7';
           ELSE                                           -- nauoa 30 aiae
              l_r013_new := '8';
           END IF;
        END IF;
     END IF;

     IF p_nbs IN ('2238')
     THEN
        IF l_find_ok = 1
        THEN                                  -- anou oaeea a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              IF p_r013_old IN ('4', '6', '9')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) - 1);
              END IF;
           ELSE                                           -- nauoa 30 aiae
              IF p_r013_old IN ('3', '5', '8')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) + 1);
              END IF;
           END IF;
        ELSE                                          -- iao a ni?aai?ieea
           IF p_kv <> 980
           THEN
              IF p_tp = 1
              THEN                                          -- ai 30 aiae
                 l_r013_new := '8';
              ELSE                                        -- nauoa 30 aiae
                 l_r013_new := '9';
              END IF;
           ELSE
              NULL;                                   -- ia iaiyai ie?aai
           END IF;
        END IF;
     END IF;

     IF p_nbs IN ('3018', '3118', '3218') and p_r013_old <> '9'
     THEN
        IF l_find_ok = 1
        THEN                                  -- anou oaeea a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              IF p_r013_old IN ('4', '6', '8')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) - 1);
              elsif p_r013_old IN ('C', 'E', 'G') then
                 l_r013_new := (case when p_r013_old = 'C' then 'B' when p_r013_old = 'E' then 'D' else 'F' end);
              END IF;
           ELSE                                           -- nauoa 30 aiae
              IF p_r013_old IN ('3', '5', '7')
              THEN
                 l_r013_new := TO_CHAR (TO_NUMBER (p_r013_old) + 1);
              elsif p_r013_old IN ('B', 'D', 'F') then
                 l_r013_new := (case when p_r013_old = 'B' then 'C' when p_r013_old = 'D' then 'E' else 'G' end);
              END IF;
           END IF;
        ELSE                                          -- iao a ni?aai?ieea
           IF p_tp = 1
           THEN                                             -- ai 30 aiae
              l_r013_new := '3';
           ELSE                                           -- nauoa 30 aiae
              l_r013_new := '4';
           END IF;
        END IF;
     END IF;
  END IF;

  RETURN l_r013_new;

END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_ret_r013.sql =========*** En
 PROMPT ===================================================================================== 
 