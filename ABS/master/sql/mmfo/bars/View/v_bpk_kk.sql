

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_KK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_KK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_KK ("GRP_CODE", "PRODUCT_CODE", "CODE", "SUB_CODE", "KK_CODE", "KK_SUB_CODE", "KK_SUB_NAME") AS 
  SELECT DISTINCT
            p.grp_code,
            w.product_code,
            w.code,
            w.sub_code,
            CASE
               WHEN UPPER (k.code) LIKE '_DOP' THEN k.code
               ELSE k.code || '_DOP'
            END
               kk_code,
            k.sub_code kk_sub_code,
            (select name from w4_subproduct where flag_kk = 1 and code = k.sub_code) kk_sub_name
       FROM w4_card w,
            w4_card k,
            w4_subproduct s,
            w4_product p
      WHERE     w.product_code = k.product_code
       AND k.sub_code in (select code from w4_subproduct where flag_kk = 1)
            AND s.flag_kk = 1
            -- для карти киянина використовуються наступні карти Gold, World, Platinum, World Elite, Infinite, Visa Classic та MasterCard Debit Standard
            AND (   LOWER (s.name) LIKE LOWER ('%Gold%')
                 OR LOWER (s.name) LIKE LOWER ('%World%')
                 OR LOWER (s.name) LIKE LOWER ('%Platinum%')
                 OR LOWER (s.name) LIKE LOWER ('%World Elite%')
                 OR LOWER (s.name) LIKE LOWER ('%Infinite%')
                 OR LOWER (s.name) LIKE LOWER ('%Visa Classic%')
                 OR LOWER (s.name) LIKE LOWER ('%MasterCard Debit%'))
            AND w.product_code = p.code
            -- додаткова Картка Киянина випускається за тарифними пакетами «Зарплатний», «Зарплатний співробітники» (це групи продуктів SALARY, STANDARD - виключено з переліку)
            AND p.grp_code IN ('SALARY')
           /* AND (   LOWER (w.code) LIKE LOWER ('%Gold%')
                 OR LOWER (w.code) LIKE LOWER ('%World%'))*/
   ORDER BY w.code;

PROMPT *** Create  grants  V_BPK_KK ***
grant SELECT                                                                 on V_BPK_KK        to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_KK.sql =========*** End *** =====
PROMPT ===================================================================================== 
