PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /sql/bars/script/upd_tts_01E_COBUMMFO_9998.sql =========*** Run *** 
PROMPT ===================================================================================== 

declare
  l_fn varchar2(55) := '#(zp.get_nls_ref(''3570'',''29'',#(NLSA),980,#(REF)))';
begin
  update tts set nlsm = l_fn, nlsa = l_fn where tt = '!1E';
  update tts set nlsk = l_fn where tt = '01E';
exception 
  when others then
    rollback;
    raise;
end;
/

commit;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /sql/bars/script/upd_tts_01E_COBUMMFO_9998.sql =========*** End *** 
PROMPT ===================================================================================== 
