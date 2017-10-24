

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_SETACCESSBYACCMASK.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_SETACCESSBYACCMASK ***

  CREATE OR REPLACE PROCEDURE BARS.P_SETACCESSBYACCMASK (acc_ number, accmask_ number) is
--***************************************************************--
-- (C) BARS
-- Version 1.06 (04/04/2006)
-- Процедура установки доступа для счета acc_, как для счета accmask_
--***************************************************************--
secmask_ accounts.sec%type;
begin
  select sec into secmask_ from accounts where acc=accmask_;
  update accounts set sec=secmask_ where acc=acc_;
end p_setAccessByAccmask;
 
/
show err;

PROMPT *** Create  grants  P_SETACCESSBYACCMASK ***
grant EXECUTE                                                                on P_SETACCESSBYACCMASK to BARS009;
grant EXECUTE                                                                on P_SETACCESSBYACCMASK to BARS010;
grant EXECUTE                                                                on P_SETACCESSBYACCMASK to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_SETACCESSBYACCMASK to CUST001;
grant EXECUTE                                                                on P_SETACCESSBYACCMASK to RCC_DEAL;
grant EXECUTE                                                                on P_SETACCESSBYACCMASK to START1;
grant EXECUTE                                                                on P_SETACCESSBYACCMASK to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_SETACCESSBYACCMASK.sql =========
PROMPT ===================================================================================== 
