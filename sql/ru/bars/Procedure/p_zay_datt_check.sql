

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_DATT_CHECK.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_ZAY_DATT_CHECK ***

  CREATE OR REPLACE PROCEDURE BARS.P_ZAY_DATT_CHECK (p_mode number)
IS
   l_mode   NUMBER;
   l_mfo    VARCHAR2 (10);
   l_url    VARCHAR2 (256);
BEGIN
   SELECT TRIM (val)
     INTO l_mode
     FROM birja
    WHERE par = 'ZAY_MODE';

   IF l_mode = 1
   THEN
      FOR t
         IN (SELECT id
               FROM zayavka
              WHERE     viza <> 2
                    AND sos <> 2
                    AND datt + 1 <= gl.bd
                    AND idback IS NULL)
      LOOP
         UPDATE zayavka
            SET viza = -1, sos = -1, idback = '77'
          WHERE id = t.id;
      END LOOP;
   END IF;

   IF l_mode = 2
   THEN
      SELECT r.url, r.mfo
        INTO l_url, l_mfo
        FROM ZAY_RECIPIENTS r;

      FOR t
         IN (SELECT id
               FROM zayavka
              WHERE     viza <> 2
                    AND sos <> 2
                    AND datt + 1 <= gl.bd
                    AND idback IS NULL)
      LOOP
         UPDATE zayavka
            SET viza = -1, sos = -1, idback = '77'
          WHERE id = t.id;

         INSERT INTO zay_data_transfer (id,
                                        req_id,
                                        url,
                                        mfo,
                                        transfer_type,
                                        transfer_date,
                                        transfer_result,
                                        comm)
                 VALUES (s_zay_data_transfer.NEXTVAL,
                         t.id,
                         l_url,
                         l_mfo,
                         8,
                         SYSDATE,
                         0,
                         'Повернення прострочених заявок на купівлю-продаж валюти');
      END LOOP;
   END IF;
END p_zay_datt_check;
/
show err;

PROMPT *** Create  grants  P_ZAY_DATT_CHECK ***
grant EXECUTE                                                                on P_ZAY_DATT_CHECK to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_ZAY_DATT_CHECK to START1;
grant EXECUTE                                                                on P_ZAY_DATT_CHECK to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_ZAY_DATT_CHECK.sql =========*** 
PROMPT ===================================================================================== 
