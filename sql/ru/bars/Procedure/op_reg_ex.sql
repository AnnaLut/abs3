

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OP_REG_EX.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OP_REG_EX ***

  CREATE OR REPLACE PROCEDURE BARS.OP_REG_EX (
          mod_       INTEGER,   -- Opening mode : 0, 1, 2, 3, 4, 9, 99, 77
          p1_        INTEGER,   -- 1st Par      : 0-inst_num   1-nd   2-nd   3-main acc   4-mfo
          p2_        INTEGER,   -- 2nd Par      : -    -    pawn   4-acc
          p3_        INTEGER,   -- 3rd Par (Grp): -    -    mpawn
          p4_ IN OUT INTEGER,   -- 4th Par      : -    -    ndz(O)
         rnk_        INTEGER,   -- Customer number
         nls_        VARCHAR2,  -- Account  number
          kv_        SMALLINT,  -- Currency code
         nms_        VARCHAR2,  -- Account name
         tip_        CHAR,      -- Account type
         isp_        SMALLINT,
        accR_    OUT INTEGER,
     nbsnull_        VARCHAR2 DEFAULT '1',
     pap_            NUMBER   DEFAULT NULL,
     vid_            NUMBER   DEFAULT NULL,
     pos_            NUMBER   DEFAULT NULL,
     sec_            NUMBER   DEFAULT NULL,
     seci_           NUMBER   DEFAULT NULL,
     seco_           NUMBER   DEFAULT NULL,
     blkd_           NUMBER   DEFAULT NULL,
     blkk_           NUMBER   DEFAULT NULL,
     lim_            NUMBER   DEFAULT NULL,
     ostx_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
   nlsalt_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
     tobo_           VARCHAR2 DEFAULT NULL,
     accc_           NUMBER   DEFAULT NULL)
IS

--***************************************************************--
--          Регистрация - открытие счетов
--             ver 5.3.0.0 	27.09.2005
-- Реализация перенесена в процедуру op_reg_lock()
--***************************************************************--
BEGIN
  op_reg_exfl(mod_,p1_,p2_,p3_,p4_,rnk_,nls_,kv_,nms_,tip_,isp_,accR_,nbsnull_,pap_,vid_,pos_,
              sec_,seci_,seco_,blkd_,blkk_,lim_,ostx_,nlsalt_,tobo_,accc_,null);
END op_reg_ex;
/
show err;

PROMPT *** Create  grants  OP_REG_EX ***
grant EXECUTE                                                                on OP_REG_EX       to ABS_ADMIN;
grant EXECUTE                                                                on OP_REG_EX       to BARS009;
grant EXECUTE                                                                on OP_REG_EX       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OP_REG_EX       to CUST001;
grant EXECUTE                                                                on OP_REG_EX       to DEP_SKRN;
grant EXECUTE                                                                on OP_REG_EX       to RCC_DEAL;
grant EXECUTE                                                                on OP_REG_EX       to TECH005;
grant EXECUTE                                                                on OP_REG_EX       to WR_ALL_RIGHTS;
grant EXECUTE                                                                on OP_REG_EX       to WR_VIEWACC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OP_REG_EX.sql =========*** End ***
PROMPT ===================================================================================== 
