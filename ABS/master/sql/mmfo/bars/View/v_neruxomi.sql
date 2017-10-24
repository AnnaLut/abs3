

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NERUXOMI.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NERUXOMI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NERUXOMI ("NLS", "NMS", "OSTB", "OP1", "OP2", "OP3", "OP4", "OP5") AS 
  SELECT a.nls,
          a.nms,
          ostb,
          make_docinput_url (
             'HPX',
             'Вiдсотки',
             'Nls_A',
             a.prcn,
             'Nls_B',
             a.nls,
             'ChOst',
             '0',
             'NaznPr',
             'Нараховано та прираховано вiдсотки по Нерухомим вкладам')
             op1,
          make_docinput_url (
             'DP1',
             'Видати',
             'Nls_A',
             a.nls,
             'NaznPr',
             'Видано кошти з закриттям  вкладу')
             op2,
          make_docinput_url ('HPX',
                             'Зарахувати',
                             'Nls_A',
                             a.nls,
                             'Nls_B',
                             a.diut,
                             'NaznPr',
                             'Зараховано в дiючi')
             op3,
          make_docinput_url (
             'HPX',
             'Переказ з ком.',
             'Nls_A',
             a.nls,
             'Nls_B',
             a.pere,
             'reqv_TAROB',
             '33',
             'NaznPr',
             'Списано переказ вкладу (комiciя в т.ч.)')
             op4,
          make_docinput_url ('HPX',
                             'Переказ без ком',
                             'Nls_A',
                             a.nls,
                             'Nls_B',
                             a.pere,
                             'NaznPr',
                             'Списано переказ вкладу')
             op5
     FROM (SELECT nls,
                  nms,
                  fost (acc, gl.BD) / 100 ostb,
                  DECODE (SUBSTR (nls, 3, 2),
                          '20', F_neruxomi ('2628', '05'),
                          '30', F_neruxomi ('2638', '17'),
                          F_neruxomi ('2638', '16'))
                     prcn,
                  DECODE (SUBSTR (nls, 3, 2),
                          '20', F_neruxomi ('2620', '05'),
                          '30', F_neruxomi ('2630', '16'),
                          F_neruxomi ('2638', '02'))
                     diut,
                  F_neruxomi ('2909', '18') pere
             FROM MV_neruxomi a
            WHERE nbs IN ('2620', '2630', '2635')
                  AND branch = SYS_CONTEXT ('bars_context', 'user_branch')
                  AND EXISTS
                        (SELECT 1
                           FROM specparam_int
                          WHERE acc = a.acc
                                AND (a.nbs = '2620'
                                     AND ob22 IN ('08', '09', '11', '12')
                                     OR a.nbs = '2630'
                                       AND ob22 IN ('11', '12', '13', '14')
                                     OR a.nbs = '2635'
                                       AND ob22 IN ('13', '14','15','16')))) a;

PROMPT *** Create  grants  V_NERUXOMI ***
grant FLASHBACK,SELECT                                                       on V_NERUXOMI      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NERUXOMI      to PYOD001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_NERUXOMI      to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on V_NERUXOMI      to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NERUXOMI.sql =========*** End *** ===
PROMPT ===================================================================================== 
