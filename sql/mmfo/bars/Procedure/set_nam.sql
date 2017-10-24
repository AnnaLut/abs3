

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SET_NAM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SET_NAM ***

  CREATE OR REPLACE PROCEDURE BARS.SET_NAM (
	AutoReceipting_ 	SMALLINT	-- признак автоквитовки
										-- 1- можно квитовать автоматом, 0 - запрещено
) IS

BEGIN

FOR c_mfo IN
	(SELECT b.mfo mfo, b.sab sab FROM banks b, mc_count mc
	 WHERE b.mfo=mc.mfo)
LOOP
	dbms_output.put_line('mfo='||c_mfo.mfo||', sab='||c_mfo.sab);
	mc_nam(c_mfo.mfo, c_mfo.sab, AutoReceipting_);
END LOOP;

END set_nam; -- end of procedure set_nam()
 
/
show err;

PROMPT *** Create  grants  SET_NAM ***
grant EXECUTE                                                                on SET_NAM         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SET_NAM         to TOSS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SET_NAM.sql =========*** End *** =
PROMPT ===================================================================================== 
