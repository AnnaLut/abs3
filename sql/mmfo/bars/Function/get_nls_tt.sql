
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_nls_tt.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_NLS_TT (
   p_tt_in       tts.tt%type,
   p_nls_type    varchar2,
   p_s           varchar2     default null,
   p_s2          varchar2     default null,
   p_nlsa        varchar2     default null,
   p_nlsb        varchar2     default null,
   p_mfoa        varchar2     default null,
   p_mfob        varchar2     default null,
   p_ref         varchar2     default null,
   p_kva          varchar2    default null,
   p_kvb         varchar2     default null,
   p_tt          varchar2     default null)
return varchar2
is
    l_nls_stmt varchar2(2000);
    l_kf  varchar2(6);
begin

 l_kf:=sys_context('bars_context','user_mfo');


  begin
    select trim(nls_stmt) into l_nls_stmt from tmp_tts_region
    where kf=l_kf
      and tt=p_tt_in
      and nls_type=p_nls_type;
  exception
        when no_data_found then

         begin
          select trim(nls_stmt) into l_nls_stmt from tmp_tts_region
          where kf=0
            and tt=p_tt_in
            and nls_type=p_nls_type
            and substr(nls_stmt,1,2)='#(';
         exception
           when no_data_found then
           l_nls_stmt:=null;
         end;
  end;

  if l_nls_stmt is not null then

           l_nls_stmt := replace(l_nls_stmt,'#(S)',   to_char(p_s));
           l_nls_stmt := replace(l_nls_stmt,'#(S2)',  to_char(p_s2));
           l_nls_stmt := replace(l_nls_stmt,'#(NLSA)',''''||p_nlsa||'''');
           l_nls_stmt := replace(l_nls_stmt,'#(NLSB)',''''||p_nlsb||'''');
           l_nls_stmt := replace(l_nls_stmt,'#(MFOA)',''''||p_mfoa||'''');
           l_nls_stmt := replace(l_nls_stmt,'#(MFOB)',''''||p_mfob||'''');
           l_nls_stmt := replace(l_nls_stmt,'#(REF)',to_char(p_ref));
           l_nls_stmt := replace(l_nls_stmt,'#(KVA)',to_char(p_kva));
           l_nls_stmt := replace(l_nls_stmt,'#(KVB)',to_char(p_kvb));
           l_nls_stmt := replace(l_nls_stmt,'#(TT)',''''||p_tt||'''');

           if substr(l_nls_stmt,1,2)='#(' then
            l_nls_stmt:= substr(l_nls_stmt,3,length(l_nls_stmt)-3);
           end if;

  execute immediate
  'select '|| l_nls_stmt||' from dual' into l_nls_stmt;

  end if;

  return l_nls_stmt;

end ;
/
 show err;
 
PROMPT *** Create  grants  GET_NLS_TT ***
grant EXECUTE                                                                on GET_NLS_TT      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_nls_tt.sql =========*** End ***
 PROMPT ===================================================================================== 
 