

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAYTT_EX.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAYTT_EX ***

  CREATE OR REPLACE PROCEDURE BARS.PAYTT_EX (
  flg_  SMALLINT,  -- флаг оплаты
  ref_  INTEGER,   -- референция
  datv_ DATE,      -- дата валютировния
  tt_   CHAR,      -- тип транзакции
  dk0_  NUMBER,    -- признак дебет-кредит
  kva_  SMALLINT,  -- код валюты А
  nls1_ VARCHAR2,  -- номер счета А
  sa_   DECIMAL,   -- сумма в валюте А
  kvb_  SMALLINT,  -- код валюты Б
  nls2_ VARCHAR2,  -- номер счета Б
  sb_   DECIMAL,   -- сумма в валюте Б
  p_err out varchar2
) is
begin
  bars_audit.trace('PAYTT_EX-'||ref_||'. start');
  p_err := '';
  paytt(flg_, ref_, datv_, tt_, dk0_, kva_, nls1_, sa_, kvb_, nls2_, sb_);
  bars_audit.trace('PAYTT_EX-'||ref_||'. finish');
exception when others then
  bars_audit.trace('PAYTT_EX-'||ref_||'. error: '||SQLERRM);
  p_err := SQLERRM;
  rollback;
end;
/
show err;

PROMPT *** Create  grants  PAYTT_EX ***
grant EXECUTE                                                                on PAYTT_EX        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAYTT_EX.sql =========*** End *** 
PROMPT ===================================================================================== 
