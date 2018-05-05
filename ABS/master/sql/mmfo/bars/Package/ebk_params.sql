CREATE OR REPLACE PACKAGE BARS.EBK_PARAMS
is
  /*
  A typical usage of these boolean constants is

    $if EBK_PARAMS.CUT_RNK $then
    -- ...
    $else
    -- ...
    $end
  */
  
  --
  -- constants
  --
  g_header_version  constant varchar2(64)  := 'version 1.03  2016.08.19';
  
  VERSION           constant pls_integer := 1;
  CUT_RNK           constant boolean     := TRUE;  -- обрізка рнк (видалення коду РУ)
  
  --
  -- IS_CUT_RNK (for SQL e.g. Views)
  --
  function IS_CUT_RNK
    return signtype
  deterministic
  result_cache;
  
end EBK_PARAMS;
/

show err

CREATE OR REPLACE PACKAGE BODY BARS.EBK_PARAMS
is
  
  --
  -- constants
  --
  g_body_version  constant varchar2(64)  := 'version 1.01  2016.08.20';
  
  --
  -- IS_CUT_RNK
  --
  function IS_CUT_RNK
    return signtype
  deterministic
  result_cache
  is
    l_ret  signtype;
  begin
    if CUT_RNK
    then
      l_ret := 1;
    else
      l_ret := 0;
    end if;
    return l_ret;
  end IS_CUT_RNK;



begin
  null;
end EBK_PARAMS;
/

show err

grant execute on EBK_PARAMS to BARS_ACCESS_DEFROLE;
