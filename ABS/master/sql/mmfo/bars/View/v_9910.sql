

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_9910.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view V_9910 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_9910 ("TXT", "KOD") AS 
  SELECT 'Списання компенсації по зарахуванню на вклади',
          '9910/01 - Списання компенсації по зарахуванню на вклади'
     FROM DUAL
        UNION ALL
   SELECT 'Змiнна ПIБ/Заповiт/Втрата книжки/Спадщина',
          '9910/01 - Змiнна ПIБ/Заповiт/Втрата книжки/Спадщина'
     FROM DUAL
   UNION ALL
   SELECT 'Мiжрегiональний переказ',
          '9910/06 - Мiжрегiональний переказ'
     FROM DUAL
   UNION ALL
   SELECT 'Внутрiш-регiон. переказ',
          '9910/07 - Внутрiш-регiон. переказ'
     FROM DUAL
   UNION ALL
   SELECT 'Картотека 01', '9760/01 - Картотека 01'
     FROM DUAL;

PROMPT *** Create  grants  V_9910 ***
grant SELECT                                                                 on V_9910          to BARSREADER_ROLE;
grant SELECT                                                                 on V_9910          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_9910          to PYOD001;
grant SELECT                                                                 on V_9910          to UPLD;
grant SELECT                                                                 on V_9910          to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_9910          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_9910.sql =========*** End *** =======
PROMPT ===================================================================================== 
