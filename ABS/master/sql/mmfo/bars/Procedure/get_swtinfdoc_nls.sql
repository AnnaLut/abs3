

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_SWTINFDOC_NLS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_SWTINFDOC_NLS ***

  CREATE OR REPLACE PROCEDURE BARS.GET_SWTINFDOC_NLS (
                      p_srcmfo    in    varchar2,
                      p_dstmfo    out   varchar2,
                      p_dstnls    out   varchar2,
                      p_dstidcode out   varchar2 )
is
l_kodn  number;
begin
--bars_audit.info ('get_swtinfdoc_nls1='||' p_srcmfo= '||p_srcmfo||' p_dstmfo= '||p_dstmfo||' p_dstnls= '||p_dstnls||' p_dstidcode= '||p_dstidcode);
    select kodn, mfop into l_kodn, p_dstmfo
      from banks
     where mfo = p_srcmfo;

    if (l_kodn is not null and l_kodn = 6) then p_dstmfo := p_srcmfo;
    end if;

    select nvl(zkpo, '9999999999'), accountmvps into p_dstidcode, p_dstnls
      from alegro
     where mfo = p_dstmfo
       and mfo is not null
       and num not like '%/%';
--bars_audit.info ('get_swtinfdoc_nls2='||' p_srcmfo= '||p_srcmfo||' p_dstmfo= '||p_dstmfo||' p_dstnls= '||p_dstnls||' p_dstidcode= '||p_dstidcode);
end get_swtinfdoc_nls;
/
show err;

PROMPT *** Create  grants  GET_SWTINFDOC_NLS ***
grant EXECUTE                                                                on GET_SWTINFDOC_NLS to BARS013;
grant EXECUTE                                                                on GET_SWTINFDOC_NLS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_SWTINFDOC_NLS.sql =========***
PROMPT ===================================================================================== 
