

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/BUSS_GET.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure BUSS_GET ***

  CREATE OR REPLACE PROCEDURE BARS.BUSS_GET 
  (p_IDCODE   IN  number  ,
   p_OKPO     IN  varchar2,
   p_MFO      IN  number  ,
   p_RNK      IN  number  ,
   s_bussline IN  varchar2,
   p_RET      OUT int     ,
   p_err      OUT varchar2
  )
IS
  l_count   number;
  l_DATERI  date;
  l_id      number;
  rnk_      number;
begin
  p_RET := 0;
  p_err := null;
  if p_IDCODE=0 then
    dbms_application_info.set_client_info('BUSS_GET(0): begin '||
                                          to_char(sysdate,'dd.mm.yyyy')||' at '||
                                          to_char(sysdate,'hh24:mi:ss'));
    begin
      delete
      from   customer_buss;
    exception when others then
      p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
      bars_audit.error('BUSS_GET(-2): '||p_err);
      p_RET := -2;
    end;
  else
    begin
      insert
      into   customer_buss (EDRPOU,
                            MFO   ,
                            RNK   ,
                            BUSSLINE)
                    values (p_OKPO,
                            p_MFO ,
                            p_RNK ,
                            s_bussline);
    exception when others then
      p_err := sqlerrm||' '||dbms_utility.format_error_backtrace;
      bars_audit.error('BUSS_GET(-1): '||p_err);
      p_RET := -1;
    end;
  end if;
  RETURN;
end BUSS_GET;
/
show err;

PROMPT *** Create  grants  BUSS_GET ***
grant EXECUTE                                                                on BUSS_GET        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BUSS_GET        to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/BUSS_GET.sql =========*** End *** 
PROMPT ===================================================================================== 
