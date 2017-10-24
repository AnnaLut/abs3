

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAYTT_EX.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAYTT_EX ***

  CREATE OR REPLACE PROCEDURE BARS.PAYTT_EX (
  flg_  SMALLINT,  -- ���� ������
  ref_  INTEGER,   -- ����������
  datv_ DATE,      -- ���� ������������
  tt_   CHAR,      -- ��� ����������
  dk0_  NUMBER,    -- ������� �����-������
  kva_  SMALLINT,  -- ��� ������ �
  nls1_ VARCHAR2,  -- ����� ����� �
  sa_   DECIMAL,   -- ����� � ������ �
  kvb_  SMALLINT,  -- ��� ������ �
  nls2_ VARCHAR2,  -- ����� ����� �
  sb_   DECIMAL,   -- ����� � ������ �
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
