

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/PAR_PROVODKI.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view PAR_PROVODKI ***

  CREATE OR REPLACE FORCE VIEW BARS.PAR_PROVODKI ("D", "K", "Z", "X", "V", "TAG", "T", "NAZN", "Y", "BD") AS 
  SELECT NVL (pul.GET ('D'), '%') D,
          NVL (pul.GET ('K'), '%') K,
          'ҳ���� "����������"' Z,
          'ҳ���� "������"' X,
          'ҳ���� "���.���"' V,
          NVL (pul.GET ('T'), 'TAG') TAG,
          '�� "���.�����."' T,              -- = ��� ���.��������
          NVL (pul.GET ('Y'), '%�������%') NAZN,
          '�� "�����������"' Y,         -- = �������.�� ����� ��,
         fdat   BD
     FROM fdat where fdat = PUL_BD;

PROMPT *** Create  grants  PAR_PROVODKI ***
grant SELECT                                                                 on PAR_PROVODKI    to BARSREADER_ROLE;
grant SELECT                                                                 on PAR_PROVODKI    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAR_PROVODKI    to START1;
grant SELECT                                                                 on PAR_PROVODKI    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/PAR_PROVODKI.sql =========*** End *** =
PROMPT ===================================================================================== 
