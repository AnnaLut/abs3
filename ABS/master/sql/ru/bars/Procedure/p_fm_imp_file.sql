

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FM_IMP_FILE.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FM_IMP_FILE ***

  CREATE OR REPLACE PROCEDURE BARS.P_FM_IMP_FILE (p_id in out number)
as
  l_clob clob;
  l_id   number;
begin
  select file_data into l_clob from fm_imp_file where id = 1;
  finmon_export.importXYToABS(l_clob, l_id);
  p_id := l_id;
exception when no_data_found then null;
end p_fm_imp_file;
/
show err;

PROMPT *** Create  grants  P_FM_IMP_FILE ***
grant EXECUTE                                                                on P_FM_IMP_FILE   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FM_IMP_FILE   to FINMON01;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FM_IMP_FILE.sql =========*** End
PROMPT ===================================================================================== 
