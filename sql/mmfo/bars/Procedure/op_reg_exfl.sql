create or replace procedure OP_REG_EXFL
(     mod_        INTEGER  -- Opening mode : 0, 1, 2, 3, 4, 9, 99, 77
,      p1_        INTEGER  -- 1st Par      : 0-inst_num   1-nd   2-nd   3-main acc   4-mfo
,      p2_        INTEGER  -- 2nd Par      : -    -    pawn   4-acc
,      p3_        INTEGER  -- 3rd Par (Grp): -    -    mpawn
,      p4_ IN OUT INTEGER  -- 4th Par      : -    -    ndz(O)
,     rnk_        INTEGER  -- Customer number
,     nls_        VARCHAR2 -- Account  number
,      kv_        SMALLINT -- Currency code
,     nms_        VARCHAR2 -- Account name
,     tip_        CHAR     -- Account type
,     isp_        SMALLINT -- 
,    accR_    OUT INTEGER  -- Account ID
, nbsnull_        VARCHAR2 default '1'
,     pap_        NUMBER   default null
,     vid_        NUMBER   default null
,     pos_        NUMBER   default null
,     sec_        NUMBER   default null
,    seci_        NUMBER   default null
,    seco_        NUMBER   default null
,    blkd_        NUMBER   default null
,    blkk_        NUMBER   default null
,     lim_        NUMBER   default null
,    ostx_        VARCHAR2 default null -- 'NULL' for update
,  nlsalt_        VARCHAR2 default null -- 'NULL' for update
,    tobo_        VARCHAR2 default null
,    accc_        NUMBER   default null
,      fl_        number   default null -- nowarn
) IS
--***************************************************************--
--          Регистрация / открытие счетов
--             ver 5.4.0.0 	24.07.2017
-- Регистрация перенесена в процедуру accreg.SetAccountAttr()
--***************************************************************--
BEGIN
  accreg.SetAccountAttr
  ( mod_, p1_, p2_, p3_, p4_
  , rnk_, nls_, kv_, nms_, tip_, isp_, accR_, nbsnull_, null, pap_, vid_, pos_
  , sec_, seci_, seco_, blkd_, blkk_, lim_, ostx_, nlsalt_, tobo_, accc_ );
END OP_REG_EXFL;
/

show errors
