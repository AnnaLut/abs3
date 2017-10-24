declare
  l_pks   varchar2(4096);
  l_qty   number(2);
  l_mfo   varchar2(6);
begin
  
  select count(1), min(SubStr(BRANCH,2,6))
    into l_qty, l_mfo
    from BRANCH 
   where BRANCH like '/______/'
     and DATE_CLOSED Is Null;
  
  select MFOU
    into l_mfo
    from BARS.BANKS$BASE
   where MFO = l_mfo;
  
  l_pks := q'[CREATE OR REPLACE PACKAGE BARS.ACC_PARAMS
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
  SBER         constant boolean     := ]' || case when l_mfo = '300465' then 'TRUE' else 'FALSE' end || q'[; -- Ощадбанк
  MMFO         constant boolean     := ]' || case when l_qty > 1        then 'TRUE' else 'FALSE' end || q'[; -- БД мульти МФО
  PROF         constant boolean     := TRUE;  -- с открытием счетов по профилю
  CCK          constant boolean     := TRUE;  -- открытие счетов для Кредитного портфеля
  KOD_D6       constant boolean     := FALSE; -- с проверкой на допустимое сочетание БС и эк.норм. клиента по справочнику KOD_D6  
  CC_DEAL      constant boolean     := FALSE; -- без проверки на модульный счет (cc_deal)
  DPT          constant boolean     := FALSE; -- без проверки на модульный счет (dpt_dposit)
  E_DEAL       constant boolean     := FALSE; -- без проверки на модульный счет (e_deal)
  MFOP         constant boolean     := FALSE; -- с проверкой заполнения поля "МФО для проц. счета"
  KAZ          constant boolean     := ]' || case when l_mfo = '820172' then 'TRUE' else 'FALSE' end || q'[; -- Казначейство
  
end ACC_PARAMS;]';
  
  execute immediate l_pks;
  
end;
/
