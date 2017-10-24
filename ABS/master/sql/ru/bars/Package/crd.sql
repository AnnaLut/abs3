
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/crd.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CRD IS

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  := 'version 14  29/10/2008';

-----------
  PROCEDURE KREDIT(id_ int,DAT_ date);
  -- Марценюк Л.
  -- Формирование печатного отчета по кредитам.
  -- Кредитнi рахунки та стан формув.резерву за ними
-----------
  PROCEDURE NSV(id_ int,DAT1_ date, DAT2_ date,VIDD_ int);
  -- Марценюк Л.
  -- Печатный отчет по кредитам.
  -- Нарахованi та сплаченi вiдсотки
-----------
  PROCEDURE SOM_PR(id_ int,DAT_ date);
  -- Сухова Т.А.
  -- Печатный отчет по сомнительным и
  -- просроченным процентам.
-----------
  PROCEDURE ipoteka(id_ int,DAT1_ date, DAT2_ date);
  -- Марценюк Л.
  -- Печатный отчет по наданим ипотечным кредитам.
-----------
  PROCEDURE ipoteka_ag(id_ int,DAT_ date);
  -- Ланбина О.
  -- Печатный отчет по наданим ипотечным кредитам АЖИО.
-----------
  PROCEDURE corp(id_ int,DAT1_ date, DAT2_ date);
  -- Марценюк Л. Кучугурный А.
  -- Печатный отчет "Кредиты выданные и погашенные по отделам и ТОВО
  -- за период".
-------------------
 PROCEDURE rep_kred (datB_ date,nTip_Kl_ int);
 -- Новиков Александр
 -- Ведомость по начисленным процентам для Кредитного отдела банка УПБ
-----------------
/**
 * header_version - возвращает версию заголовка пакета CRD
 */
function header_version return varchar2;

/**
 * body_version - возвращает версию тела пакета CRD
 */
function body_version return varchar2;
-------------------

END CRD;
/
CREATE OR REPLACE PACKAGE BODY BARS.CRD wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
8bf0 2d7f
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
VqEbVytEqkwcgiab5la9qFiPWmwP+Zi1W2SbBTg=
/
 show err;
 
PROMPT *** Create  grants  CRD ***
grant EXECUTE                                                                on CRD             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CRD             to RCC_DEAL;
grant EXECUTE                                                                on CRD             to RPBN001;
grant EXECUTE                                                                on CRD             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/crd.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 