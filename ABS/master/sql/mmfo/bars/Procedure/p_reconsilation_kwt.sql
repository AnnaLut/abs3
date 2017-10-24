

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_RECONSILATION_KWT.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_RECONSILATION_KWT ***

  CREATE OR REPLACE PROCEDURE BARS.P_RECONSILATION_KWT (p_swtref sw_journal.swref%type, p_ref oper.ref%type, p_colN number, p_tt tts.tt%type)
is
l_userid number:=user_id();
begin
if (p_tt='NOS') then
    gl.PAY(2, p_ref, bankdate());
    UPDATE oper SET nextvisagrp='!!', currvisagrp='47' WHERE ref=p_ref;
    bars_swift.genmsg_notify_listadd(p_ref);
    bars_swift.genmsg_notify_process;
    INSERT INTO oper_visa(ref, dat, userid, groupid, status)
           VALUES(p_ref, sysdate, l_userid, 71, 3);
end if;

--if (GetGlobalOption('SW_NR20') !='1' and p_tt is not null) then
     bars_swift.stmt_document_link(p_swtref, p_colN, bars_swift.t_listref(p_ref),0);
--end if;

end p_reconsilation_kwt;
/
show err;

PROMPT *** Create  grants  P_RECONSILATION_KWT ***
grant EXECUTE                                                                on P_RECONSILATION_KWT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_RECONSILATION_KWT.sql =========*
PROMPT ===================================================================================== 
