
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_kasdoc.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_KASDOC (bdate_ IN DATE, edate_ IN DATE, type_tt_ in NUMBER)
-- функция возвращает документы, которые создал пользователь на протяжениии 1-3 минут
-- bdate_   - дата начала периода
-- edate_   - дата окончания периода
-- type_tt_ - 0-операции с покупки ин. валюты, 1-операции с продажи ин. валюты
   RETURN T_KASDOC_TABLE
AS
   l_tab       T_KASDOC_TABLE := T_KASDOC_TABLE ();
   l_pdat      DATE;
   l_ref       NUMBER (38);
   l_vdat      DATE;
   l_tt        CHAR (3);
   l_fio       VARCHAR (60);
   l_ptime     VARCHAR (8);
   l_sq        NUMBER (24);
   l_s         NUMBER (24);
   l_br_name   VARCHAR2 (70);
   l_diff1     NUMBER;
   l_diff2     NUMBER;
   l_cnt       NUMBER;
BEGIN
   FOR i IN (SELECT DISTINCT userid l_uid
               FROM oper
              WHERE pdat BETWEEN bdate_ AND edate_ + 1
                AND ((type_tt_ = 0 and tt in ('AA3','AA5','AA7','AA9','AAB','AAC','AAK','AAM','AAN')) or (type_tt_ = 1 AND tt in ('AA0','AA4','AA6','AA8','AAE','AAL'))))
   LOOP
      SELECT COUNT (REF)
        INTO l_cnt
        FROM oper
       WHERE pdat BETWEEN bdate_ AND edate_ + 1
             AND ((type_tt_ = 0 and tt in ('AA3','AA5','AA7','AA9','AAB','AAC','AAK','AAM','AAN')) or (type_tt_ = 1 AND tt in ('AA0','AA4','AA6','AA8','AAE','AAL')))
             AND userid = i.l_uid;

      l_diff1 := 0;
      l_diff2 := 0;

      FOR j
         IN (  SELECT ROW_NUMBER () OVER (ORDER BY o.userid, o.pdat) num,
                      o.REF,
                      o.pdat,
                      o.vdat,
                      o.tt,
                      (SELECT s.fio
                         FROM staff$base s
                        WHERE s.id = o.userid)
                         fio,
                      TO_CHAR (pdat, 'hh24:mi:ss') ptime,
                      (SELECT p.sq
                         FROM opldok p, accounts a, oper t
                        WHERE     p.REF = o.REF
                              AND p.acc = a.acc
                              AND p.REF = t.REF
                              AND a.nls = t.nlsa
                              AND a.kv = t.kv
                              AND rownum = 1)
                         sq,
                      o.s,
                      (SELECT b.name
                         FROM branch b
                        WHERE b.branch = o.branch)
                         br_name
                 FROM oper o
                WHERE     o.pdat BETWEEN bdate_ AND edate_ + 1
                      AND o.userid = i.l_uid
                      AND ((type_tt_ = 0 and o.tt in ('AA3','AA5','AA7','AA9','AAB','AAC','AAK','AAM','AAN')) or (type_tt_ = 1 AND o.tt in ('AA0','AA4','AA6','AA8','AAE','AAL')))
             ORDER BY o.pdat)
      LOOP
         IF j.num = 1
         THEN
            l_pdat := j.pdat;
            l_ref := j.REF;
            l_vdat := j.vdat;
            l_tt := j.tt;
            l_fio := j.fio;
            l_ptime := j.ptime;
            l_sq := j.sq;
            l_s := j.s;
            l_br_name := j.br_name;
         ELSE
            l_diff1 := (j.pdat - l_pdat) * 1440;

            IF (l_diff1 <= 3 AND l_diff1 > 0)
            THEN
               l_tab.EXTEND;
               l_tab (l_tab.LAST) :=
                  T_KASDOC_REC (l_pdat,
                                l_ref,
                                l_vdat,
                                l_tt,
                                l_fio,
                                l_ptime,
                                l_sq/100,
                                l_s/100,
                                l_br_name);
               l_pdat := j.pdat;
               l_ref := j.REF;
               l_vdat := j.vdat;
               l_tt := j.tt;
               l_fio := j.fio;
               l_ptime := j.ptime;
               l_sq := j.sq;
               l_s := j.s;
               l_br_name := j.br_name;
               l_diff2 := l_diff1;
            ELSE
               IF (l_diff2 <= 3 AND l_diff2 > 0)
               THEN
                  l_tab.EXTEND;
                  l_tab (l_tab.LAST) :=
                     T_KASDOC_REC (l_pdat,
                                   l_ref,
                                   l_vdat,
                                   l_tt,
                                   l_fio,
                                   l_ptime,
                                   l_sq/100,
                                   l_s/100,
                                   l_br_name);
                  l_pdat := j.pdat;
                  l_ref := j.REF;
                  l_vdat := j.vdat;
                  l_tt := j.tt;
                  l_fio := j.fio;
                  l_ptime := j.ptime;
                  l_sq := j.sq;
                  l_s := j.s;
                  l_br_name := j.br_name;
                  l_diff2 := 0;
               ELSE
                  l_pdat := j.pdat;
                  l_ref := j.REF;
                  l_vdat := j.vdat;
                  l_tt := j.tt;
                  l_fio := j.fio;
                  l_ptime := j.ptime;
                  l_sq := j.sq;
                  l_s := j.s;
                  l_br_name := j.br_name;
               END IF;
            END IF;

            IF (l_diff1 <= 3 AND l_diff1 > 0 AND j.num = l_cnt)
            THEN
               l_tab.EXTEND;
               l_tab (l_tab.LAST) :=
                  T_KASDOC_REC (j.pdat,
                                j.REF,
                                j.vdat,
                                j.tt,
                                j.fio,
                                j.ptime,
                                j.sq/100,
                                j.s/100,
                                j.br_name);
            END IF;
         END IF;
      END LOOP;
   END LOOP;

   RETURN l_tab;
END;
/
 show err;
 
PROMPT *** Create  grants  GET_KASDOC ***
grant EXECUTE                                                                on GET_KASDOC      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_KASDOC      to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_kasdoc.sql =========*** End ***
 PROMPT ===================================================================================== 
 