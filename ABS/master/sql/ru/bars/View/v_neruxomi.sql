

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NERUXOMI.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NERUXOMI ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NERUXOMI ("NLS", "NMS", "OSTB", "OP1", "OP2", "OP3", "OP4", "OP5") AS 
  SELECT a.nls, a.nms, ostb,
          make_docinput_url
               ('HPX',
                '�i������',
                'Nls_A',
                a.prcn,
                'Nls_B',
                a.nls,
                'ChOst',
                '0',
                'NaznPr',
                '���������� �� ����������� �i������ �� ��������� �������'
               ) op1,
          make_docinput_url ('DP1',
                             '������',
                             'Nls_A',
                             a.nls,
                             'NaznPr',
                             '������ ����� � ���������  ������'
                            ) op2,
          make_docinput_url ('HPX',
                             '����������',
                             'Nls_A',
                             a.nls,
                             'Nls_B',
                             a.diut,
                             'NaznPr',
                             '���������� � �i��i'
                            ) op3,
          make_docinput_url ('HPX',
                             '������� � ���.',
                             'Nls_A',
                             a.nls,
                             'Nls_B',
                             a.pere,
                             'reqv_TAROB',
                             '33',
                             'NaznPr',
                             '������� ������� ������ (���ici� � �.�.)'
                            ) op4,
          make_docinput_url ('HPX',
                             '������� ��� ���',
                             'Nls_A',
                             a.nls,
                             'Nls_B',
                             a.pere,
                             'NaznPr',
                             '������� ������� ������'
                            ) op5
     FROM (SELECT nls, nms, fost (acc, gl.bd) / 100 ostb,
                  DECODE (SUBSTR (nls, 3, 2),
                          '20', f_neruxomi ('2628', '05'),
                          '30', f_neruxomi ('2638', '17'),
                          f_neruxomi ('2638', '16')
                         ) prcn,
                  DECODE (SUBSTR (nls, 3, 2),
                          '20', f_neruxomi ('2620', '05'),
                          '30', f_neruxomi ('2630', '16'),
                          f_neruxomi ('2638', '02')
                         ) diut,
                  f_neruxomi ('2909', '18') pere
             FROM mv_neruxomi a
            WHERE nbs IN ('2620', '2630', '2635')
              AND branch = SYS_CONTEXT ('bars_context', 'user_branch')
              AND (   a.nbs = '2620' AND a.ob22 IN ('08', '09', '11', '12')
                   OR a.nbs = '2630' AND a.ob22 IN ('11', '12', '13', '14')
                   OR a.nbs = '2635' AND a.ob22 IN ('13', '14', '15', '16')
                  )) a ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NERUXOMI.sql =========*** End *** ===
PROMPT ===================================================================================== 
