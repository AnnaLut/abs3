CREATE OR REPLACE PROCEDURE BARS.int15_N (p_dat DATE)
IS
   l_tax_nls          VARCHAR2 (14);
   l_tax              NUMBER;
   l_s15              NUMBER := 0;
   l_s15q             NUMBER := 0;
   l_mil15            NUMBER := 0;
   l_mil15q           NUMBER := 0;
   nTmp_              INT;
   nTmp2_             INT;
   l_comment          VARCHAR2 (5000);
   l_tax_method       INT      := NVL (TO_NUMBER (GetGlobalOption ('TAX_METHOD')), 1);
BEGIN
   IF l_tax_method IN (1, 2, 3)
   THEN
      l_tax := (18 / 100);                                         -- % налога

      FOR k
         IN (SELECT o.REF,
                    o.S,
                    a.KV,
                    a.rnk,
                    a.nbs,
                    a.acc,
                    ap.nls nlsp,                    
                    ap.ostc,
                     case   when substr (op.nazn, 11,1)= ' '   
                            then substr (op.nazn,12,instr(substr(op.nazn,12,15),' ')-1)
                            when substr (op.nazn, 12,1)= ' '
                            then substr(op.nazn,13,instr(substr(op.nazn,13,15),' ')-1)
                     end as nls,      
                    a.branch                            -- выборка необходимых
               FROM (SELECT *
                       FROM opldok o 
                      WHERE tt IN ('%%1', 'DU%') AND dk = 1 AND fdat = p_dat) o,
                      oper op,
                      accounts a,
                      accounts ap                                        
              WHERE a.nls = (case   when substr (op.nazn, 11,1)= ' '   
                                    then substr (op.nazn,12,instr(substr(op.nazn,12,15),' ')-1)
                                    when substr (op.nazn, 12,1)= ' '
                                    then substr(op.nazn,13,instr(substr(op.nazn,13,15),' ')-1)
                            end)
                    and (substr(a.nbs,1,2)= '26' or substr(ap.nbs,1,2)= '26')
                    and a.kv = op.kv
                    and o.acc = ap.acc                    
                    AND op.ref = o.ref  AND op.NLSB not like '6%'  --- Отсекаем проводки начисл. %%1  Дт2607-Кт6020 
                    AND NOT EXISTS                                 --- по Овердрафтам на 2600 СПД
                               (SELECT 1
                                  FROM opldok
                                 WHERE     tt in ('%15','MIL')
                                       AND dk = 1
                                       AND fdat = p_dat
                                       AND REF = o.REF))
      LOOP
         l_comment := '';
         nTmp_ := NULL;
         nTmp2_ := NULL;
        bars_audit.info ('rnk='||to_char(k.rnk));
         --nTmp_ := 1 - не выполнять вставку дочерней операции, причины: дочерняя уже существует, 2608/18 не принадлежит СПДФО

         BEGIN
            SELECT 1
              INTO nTmp_
              FROM opldok
             WHERE REF = k.REF AND tt in('%15','MIL') AND ROWNUM = 1; --защита от дубля
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               nTmp_ := 0;
         END;
        bars_audit.info ('nTmp_='||to_char(nTmp_));
         --nTmp_ := 0 - не найдено дочерней
         l_comment :=
               l_comment
            || 'Process ref = '
            || TO_CHAR (k.REF)
            || ' acc='
            || TO_CHAR (k.acc)
            || ' '
            || CASE
                  WHEN nTmp_ = 0 THEN ' %15 not exists; '
                  ELSE ' %15 already exists; '
               END;
        
       
            BEGIN
               SELECT 1
                 INTO nTmp2_
                 FROM customer
                WHERE rnk = k.rnk
                      AND (ise IN ('14200', '14100') AND sed = '91'
                           OR ise IN ('14201', '14101')); -- только СПД +нотариусы
             EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  nTmp2_ := 2;
            END;
            bars_audit.info ('nTmp2_='||to_char(nTmp2_)||' rnk ='||to_char(k.rnk));
            l_comment :=
                  l_comment
               || 'NBS = '
               || TO_CHAR (k.nbs)
               || CASE WHEN nTmp2_ = 1 THEN ' Ok, SPDFO; ' ELSE ' Skip; ' END;
        

        
         --nTmp2_ := 2 - счет 2608/18 не принадлежит СПДФО
         --nTmp2_ := 1 - счет 2608/18    принадлежит СПДФО
         BEGIN
          
            l_s15 := ROUND (k.s * l_tax, 0);
            l_s15q := p_icurval (k.kv, l_s15, p_dat);            -- расч сумма
           
          bars_audit.info (to_char(l_s15q)||', l_s15=' || to_char(l_s15)||', s=' || to_char(k.s));
          
            l_mil15 := ROUND (k.s * 0.015, 0);
            l_mil15q := p_icurval (k.kv, l_mil15, p_dat);            -- расч сумма
           
          bars_audit.info (to_char(l_mil15q)||','||' k.ostc ='||to_char(k.ostc));

            IF (NVL (nTmp_, 0) = 0 AND NVL (nTmp2_, 1) = 1)
            THEN
             

               IF l_s15 > 0 AND k.ostc >= l_s15+l_mil15
               THEN
                  IF LENGTH (k.branch) = 15
                  THEN
                     k.branch := k.branch || '06' || SUBSTR (k.branch, -5);
                  END IF;                      -- подбор сч 3622 на 3-м уровне

                  l_comment :=
                     l_comment || 'check branch: ' || TO_CHAR (k.branch);
                  l_tax_nls := nbs_ob22_null ('3622', '37', k.branch);
                  l_comment :=
                        l_comment
                     || '3622/37='
                     || TO_CHAR (l_tax_nls)
                     || '; dates gl.bdate='
                     || TO_CHAR (gl.bdate, 'dd/mm/yyyy')
                     || ' p_dat='
                     || TO_CHAR (p_dat, 'dd/mm/yyyy');
                  gl.payv (1,
                           k.REF,
                           gl.bdate,
                           '%15',
                           1,
                           k.kv,
                           k.nlsp,
                           l_s15,
                           gl.baseval,
                           l_tax_nls,
                           l_s15q);                           
               END IF;
                 IF l_mil15 > 0 AND k.ostc >= l_s15+l_mil15
               THEN
                  IF LENGTH (k.branch) = 15
                  THEN
                     k.branch := k.branch || '06' || SUBSTR (k.branch, -5);
                  END IF;                      -- подбор сч 3622 на 3-м уровне

                  l_comment :=
                     l_comment || 'check branch: ' || TO_CHAR (k.branch);
                  l_tax_nls := nbs_ob22_null ('3622', '36', k.branch);
                  l_comment :=
                        l_comment
                     || '3622/36='
                     || TO_CHAR (l_tax_nls)
                     || '; dates gl.bdate='
                     || TO_CHAR (gl.bdate, 'dd/mm/yyyy')
                     || ' p_dat='
                     || TO_CHAR (p_dat, 'dd/mm/yyyy');
                  gl.payv (1,
                           k.REF,
                           gl.bdate,
                           'MIL',
                           1,
                           k.kv,
                           k.nlsp,
                           l_mil15,
                           gl.baseval,
                           l_tax_nls,
                           l_mil15q);                            -- доч.проводка
               END IF;

            bars_audit.info (l_comment);
               
            END IF;

          

         EXCEPTION
            WHEN OTHERS
            THEN
               bars_audit.error (
                  l_comment || ' Exception:' || SQLCODE || SQLERRM);
         END;
      END LOOP;
   END IF;
END int15_N;
/
