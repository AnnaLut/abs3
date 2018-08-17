

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/SKRN_FREE_CELL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure SKRN_FREE_CELL ***

  CREATE OR REPLACE PROCEDURE BARS.SKRN_FREE_CELL (dat_ date)
as
begin

  delete from tmp_sal;
  

for x in (
            SELECT * FROM BRANCH WHERE BRANCH LIKE SYS_CONTEXT ('bars_context', 'user_branch_mask') and length(branch) = 22
          )
    LOOP

               -- ������������� �������
               bc.go(x.branch);
               
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
               

         
    --suda; --COBUMMFO-8771

    END LOOP;
    
    bc.home;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/SKRN_FREE_CELL.sql =========*** En
PROMPT ===================================================================================== 
