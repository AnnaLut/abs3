

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RNBU_CONSOLIDATE_FILES.sql =======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RNBU_CONSOLIDATE_FILES ***

  CREATE OR REPLACE PROCEDURE BARS.RNBU_CONSOLIDATE_FILES (Form_Cod IN number, Fdate IN date)
is
mfo	varchar2 (6);
begin
	select val into mfo from params
	where par = 'MFO';
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RNBU_CONSOLIDATE_FILES.sql =======
PROMPT ===================================================================================== 
