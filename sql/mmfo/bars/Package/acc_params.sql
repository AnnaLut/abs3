
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/acc_params.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ACC_PARAMS 
is
  /*
  A typical usage of these boolean constants is

    $if ACC_PARAMS.MMFO $then
      --
    $else
      --
    $end

  */

  VERSION      constant pls_integer := 3;
  SBER         constant boolean     := TRUE; -- Ощадбанк
  MMFO         constant boolean     := TRUE; -- БД мульти МФО
  PROF         constant boolean     := TRUE;  -- с открытием счетов по профилю
  CCK          constant boolean     := TRUE;  -- открытие счетов для Кредитного портфеля
  KOD_D6       constant boolean     := FALSE; -- с проверкой на допустимое сочетание БС и эк.норм. клиента по справочнику KOD_D6
  CC_DEAL      constant boolean     := FALSE; -- без проверки на модульный счет (cc_deal)
  DPT          constant boolean     := FALSE; -- без проверки на модульный счет (dpt_dposit)
  E_DEAL       constant boolean     := FALSE; -- без проверки на модульный счет (e_deal)
  MFOP         constant boolean     := FALSE; -- с проверкой заполнения поля "МФО для проц. счета"
  KAZ          constant boolean     := FALSE; -- Казначейство

end ACC_PARAMS;
/

 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/acc_params.sql =========*** End *** 
 PROMPT ===================================================================================== 
 