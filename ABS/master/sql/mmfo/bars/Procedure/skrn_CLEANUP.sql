

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SKRN_CLEANUP.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SKRN_CLEANUP ***

  CREATE OR REPLACE PROCEDURE BARS.SKRN_CLEANUP (DUMMY NUMBER)
IS
BEGIN
   FOR k IN (SELECT *
               FROM branch b
              WHERE     LENGTH (b.branch) = 22
                    AND b.date_closed IS NULL
                    AND EXISTS
                           (SELECT 1
                              FROM branch_parameters
                             WHERE branch = b.branch AND tag = 'DEP_KAS'))
   LOOP
      bc.subst_branch (k.branch);

			begin
			   skrn.p_cleanup (0);
			 exception when others then null;
			end;

	  begin
			for k in (
						select a.acc
						from skrynka_nd_acc r, accounts a
						where r.acc = a.acc
						  and daos < gl.bd
						  and dazs is null
						  and dapp is null
						  and nd not in (select nd from skrynka_nd )
			)
			loop
				update accounts
				  set dazs = gl.bd
				 where acc = k.acc
				   and dazs is null
				   and dapp is null
				   and daos < gl.bd;
			end loop;
	commit;
	end;
   END LOOP;

   bc.set_context;

 exception when others then null;
   bc.set_context;

END;
/
show err;

PROMPT *** Create  grants  SKRN_CLEANUP ***
grant EXECUTE                                                                on SKRN_CLEANUP    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SKRN_CLEANUP    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SKRN_CLEANUP.sql =========*** End 
PROMPT ===================================================================================== 
