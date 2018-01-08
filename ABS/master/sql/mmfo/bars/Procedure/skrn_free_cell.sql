PROMPT ===================================================================================== 
PROMPT ***     *** ========== Scripts /Sql/Bars/Procedure/skrn_free_cell.sql =========***     ***
PROMPT ===================================================================================== 

CREATE OR REPLACE procedure BARS.skrn_free_cell (dat_ date)
as
begin

  delete from tmp_sal;


for x in (
            SELECT * FROM BRANCH WHERE BRANCH LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') and length(branch) = 22
          )
	LOOP

			   -- представимось бранчом
			   bc.subst_branch(x.branch);

				insert into  tmp_sal (branch, nms, ostqk, kosq, ostiqk, kv)
				select t.branch, e.name, t.cell_count, nvl(a.col,0) less_cell, t.cell_count-nvl(a.col,0) Free_cell  , t.ETALON_ID
				from (
					   select t.o_sk, t.name , t.branch, count(1) col
						from BARS.SKRYNKA_ND nd, skrynka s,  BARS.SKRYNKA_tip t
					   where nd.sos in (0, 15)
						 and (nd.dat_close > dat_ or nd.dat_close is null)
						 and nd.dat_begin  <= dat_
						 and T.O_SK = s.o_sk
						 and ND.N_SK = S.N_SK  
						 and nd.branch = x.branch
					   Group by t.o_sk, t.name , t.branch) a full outer join BARS.SKRYNKA_TIP t on (t.O_SK = a.o_sk),
					   BARS.SKRYNKA_TIP_ETALON e
			   where  e.ID = t.ETALON_ID
			   order by t.branch, t.ETALON_ID;


	suda;

	END LOOP;


end;
/