

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Procedure/CLEAR_CLIENT_BY_ACCOUNT.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CLEAR_CLIENT_BY_ACCOUNT ***

  CREATE OR REPLACE PROCEDURE BARSAQ.CLEAR_CLIENT_BY_ACCOUNT (p_nls in varchar2, p_kv number)
as
l_acc number;
begin
    select acc into l_acc from bars.accounts where nls=p_nls and kv=p_kv;
    delete from ibank_acc where acc=l_acc;
    delete from accounts where acc_num=p_nls and cur_id=p_kv;
    commit;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Procedure/CLEAR_CLIENT_BY_ACCOUNT.sql ====
PROMPT ===================================================================================== 
