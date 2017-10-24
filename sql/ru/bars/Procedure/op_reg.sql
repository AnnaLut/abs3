

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_REG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_REG ***

  CREATE OR REPLACE PROCEDURE BARS.OP_REG 
(mod_        INTEGER,  -- Opening mode : 0    1    2    3    4
  p1_        INTEGER,  -- 1st Par      : inst nd   nd        mfo
  p2_        INTEGER,  -- 2nd Par      : -    -    pawn
  p3_        INTEGER,  -- 3rd Par (Grp): -    -    mpawn
  p4_ IN OUT INTEGER,  -- 4th Par      : -    -    ndz(O)
 rnk_        INTEGER,  -- Customer number
 nls_        VARCHAR,  -- Account  number
  kv_        SMALLINT, -- Currency code
 nms_        VARCHAR,  -- Account name
 tip_        CHAR,     -- Account type
 isp_        SMALLINT,
accR_    OUT INTEGER)
IS

-- (C) BARS. Accounts Opening and Registration
-- Ver  op_reg.sql 3.1.1.2 99/10/18

BEGIN

op_reg_exfl(mod_,p1_,p2_,p3_,p4_,rnk_,nls_,kv_,nms_,tip_,isp_,accR_);

END op_reg;
/
show err;

PROMPT *** Create  grants  OP_REG ***
grant EXECUTE                                                                on OP_REG          to ABS_ADMIN;
grant EXECUTE                                                                on OP_REG          to BARS009;
grant EXECUTE                                                                on OP_REG          to BARS010;
grant EXECUTE                                                                on OP_REG          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_REG          to CUST001;
grant EXECUTE                                                                on OP_REG          to DEP_SKRN;
grant EXECUTE                                                                on OP_REG          to DPT;
grant EXECUTE                                                                on OP_REG          to FOREX;
grant EXECUTE                                                                on OP_REG          to NALOG;
grant EXECUTE                                                                on OP_REG          to PYOD001;
grant EXECUTE                                                                on OP_REG          to RCC_DEAL;
grant EXECUTE                                                                on OP_REG          to WR_ACRINT;
grant EXECUTE                                                                on OP_REG          to WR_ALL_RIGHTS;
grant EXECUTE                                                                on OP_REG          to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_REG.sql =========*** End *** ==
PROMPT ===================================================================================== 
