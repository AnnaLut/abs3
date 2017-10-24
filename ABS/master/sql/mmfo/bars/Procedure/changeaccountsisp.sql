

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CHANGEACCOUNTSISP.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CHANGEACCOUNTSISP ***

  CREATE OR REPLACE PROCEDURE BARS.CHANGEACCOUNTSISP ( isp1_ number, isp2_ number) AS
    i   NUMBER;
-- процедура переводит счета от исполнителя 1 (isp1_)
-- к исполнителю 2 (isp2_)
-- Макаренко И.В. 07/2009
BEGIN
  FOR i IN (SELECT acc
              FROM accounts
             WHERE dazs is null
               AND isp = isp1_
           )
  LOOP
    UPDATE accounts SET isp=isp2_ WHERE acc=i.acc;
  END LOOP;
  COMMIT;
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CHANGEACCOUNTSISP.sql =========***
PROMPT ===================================================================================== 
