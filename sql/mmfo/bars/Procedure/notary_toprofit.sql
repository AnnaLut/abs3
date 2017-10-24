

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NOTARY_TOPROFIT.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NOTARY_TOPROFIT ***

  CREATE OR REPLACE PROCEDURE BARS.NOTARY_TOPROFIT (p_NOTARY_ID int     ,
                                             p_ACCR_ID   int     ,
                                             p_BRANCH    varchar2,
                                             p_NBSOB22   varchar2,
                                             p_REF_OPER  int     ,
                                             p_DAT_OPER  date    ,
                                             p_PROFIT    int     ,
                                             p_err   out varchar2,
                                             p_ret   out int)
IS
begin
  begin
    insert
    into   notary_profit (id       ,
                          NOTARY_ID,
                          ACCR_ID  ,
                          BRANCH   ,
                          NBSOB22  ,
                          REF_OPER ,
                          DAT_OPER ,
                          PROFIT)
                  values (s_notary_profit.nextval,
                          p_NOTARY_ID            ,
                          p_ACCR_ID              ,
                          p_BRANCH               ,
                          p_NBSOB22              ,
                          p_REF_OPER             ,
                          p_DAT_OPER             ,
                          p_PROFIT);
    p_ret := 0;
    p_err := null;
  exception when dup_val_on_index then
    p_ret := -1;
    p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
            when others then
    p_ret := -2;
    p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
  end;
end NOTARY_toprofit;
/
show err;

PROMPT *** Create  grants  NOTARY_TOPROFIT ***
grant EXECUTE                                                                on NOTARY_TOPROFIT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NOTARY_TOPROFIT.sql =========*** E
PROMPT ===================================================================================== 
