
 
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpt_views.sql =========*** Run *** =
PROMPT ===================================================================================== 
 
 
CREATE OR REPLACE PACKAGE DPT_VIEWS
IS
   g_header_version   CONSTANT VARCHAR2 (64) := 'version 1.2 07.03.2017';

   FUNCTION header_version
      RETURN VARCHAR2;

   FUNCTION body_version
      RETURN VARCHAR2;

TYPE r_portfolio IS record (DPT_ID NUMBER (38),
                            DPT_NUM VARCHAR2 (35 Byte),
                            DPT_DAT DATE,
                            DAT_BEGIN DATE,
                            DAT_END DATE,
                            VIDD_CODE NUMBER (38),
                            VIDD_NAME VARCHAR2 (50 Byte),
                            RATE NUMBER,
                            DPT_AMOUNT NUMBER,
							DPT_COMMENTS VARCHAR2 (128 Byte),
							ARCHDOC_ID NUMBER (38),
                            DPT_NOCASH VARCHAR2 (4000 Byte),
                            DPT_STATUS NUMBER,
                            DPTRCP_MFO VARCHAR2 (12 Byte),
                            DPTRCP_ACC VARCHAR2 (15 Byte),
                            DPTRCP_NAME VARCHAR2 (380 Byte),
                            DPTRCP_IDCODE VARCHAR2 (14 Byte),
                            INTRCP_MFO VARCHAR2 (12 Byte),
                            INTRCP_ACC VARCHAR2 (15 Byte),
                            INTRCP_NAME VARCHAR2 (380 Byte),
                            INTRCP_IDCODE VARCHAR2 (15 Byte),
                            CUST_ID NUMBER (38),
                            CUST_NAME VARCHAR2 (70 Byte),
                            CUST_IDCODE VARCHAR2 (14 Byte),
                            CUST_BIRTHDATE DATE,
                            DOC_SERIAL VARCHAR2 (10 Byte),
                            DOC_NUM VARCHAR2 (200 Byte),
                            DOC_ISSUED VARCHAR2 (700 Byte),
                            DOC_DATE DATE,
                            DPT_ACCID NUMBER (38),
                            DPT_ACCNUM VARCHAR2 (15 Byte),
                            DPT_ACCNAME VARCHAR2 (70 Byte),
                            DPT_CURID NUMBER (3),
                            DPT_CURCODE CHAR (3 Byte),
                            DPT_CURNAME VARCHAR2 (35 Byte),
                            DPT_SALDO NUMBER (24),
                            DPT_SALDO_PL NUMBER (24),
                            DPT_LOCK  varchar2(30),
                            INT_ACCID NUMBER (38),
                            INT_ACCNUM VARCHAR2 (15 Byte),
                            INT_ACCNAME VARCHAR2 (70 Byte),
                            INT_CURID NUMBER (3),
                            INT_CURCODE CHAR (3 Byte),
                            INT_CURNAME VARCHAR2 (35 Byte),
                            INT_SALDO NUMBER,
                            INT_SALDO_PL NUMBER,
                            INT_KOS NUMBER,
                            INT_DOS NUMBER,
                            BRANCH_ID VARCHAR2 (30 Byte),
                            BRANCH_NAME VARCHAR2 (70 Byte),
                            FL_INT_PAYOFF NUMBER,
                            FL_AVANS_PAYOFF NUMBER,
                            DPT_CUR_DENOM NUMBER,
                            wb varchar2(1));
 type t_portfolio is table of r_portfolio;
 function get_portfolio(p_rnk in customer.rnk%type, p_mode In int) return t_portfolio pipelined;

 type t_tmp_dptrpt is table of tmp_dptrpt%rowtype;
 function get_rpt(p_code     in  tmp_dptrpt.code%type,
                  p_dat1     in  tmp_dptrpt.fdat%type,
                  p_dat2     in  tmp_dptrpt.fdat%type,
                  p_dptid    in  tmp_dptrpt.dptid%type) return t_tmp_dptrpt pipelined;
END;
/
CREATE OR REPLACE PACKAGE BODY DPT_VIEWS
IS
   g_body_version   CONSTANT VARCHAR2 (64) := 'version 1.11 23.11.2017';

   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body dpt_views ' || g_body_version;
   END body_version;


   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN 'Package body dpt_views ' || g_body_version;
   END header_version;

   function get_portfolio(p_rnk in customer.rnk%type, p_mode In int) return t_portfolio pipelined
   is
   /*
   p_mode = 0 Вкладные
   p_mode = 1 ЕБП
   p_mode = -1 закрытые ЕБП
   p_mode = -2 закрытые Вкладные
   */
    TYPE Cur IS REF CURSOR;
    l_cursor   Cur;
    l_stmt_str VARCHAR2(32000);
    l_portfolio r_portfolio;
   begin
    l_stmt_str := 'select * from (WITH cust AS (SELECT c1.rnk,c1.nmk,c1.okpo,p.bday,p.ser,p.numdoc,p.organ,p.pdate FROM customer c1, person p WHERE c1.rnk = p.rnk AND canilookclient (c1.rnk) = 1 AND c1.rnk = '||to_char(p_rnk)||'),
               accmainlst as (select a.acc, da.dptid dpt_id,a.nls,a.nms,a.kv,a.ostc,a.ostb,SIGN (a.blkd) blk, a.daos from accounts a, cust, dpt_accounts da where a.rnk = cust.rnk and 
               ((a.nbs in (''2620'',''2630'') and newnbs.get_state = 1) or (a.nbs in (''2620'',''2630'',''2635'') and newnbs.get_state = 0)) and da.accid = a.acc),
               accintlst  as (select a.acc, da.dptid dpt_id,a.nls,a.nms,a.kv,a.ostc,a.ostb,SIGN (a.blkd) blk, a.daos from accounts a, cust, dpt_accounts da where a.rnk = cust.rnk and a.nbs in (''2628'',''2638'') and da.accid = a.acc),
               lst AS (SELECT dc.rnk,
                       dc.acc,
                       dc.kv,
                       v.amr_metr,
                       DC.DEPOSIT_ID DPT_ID,
                       DC.ND DPT_NUM,
                       dc.datz DPT_DAT,
                       /*DC.VIDD VIDD_CODE,
                       (SELECT type_name
                          FROM dpt_vidd
                         WHERE vidd = DC.VIDD)
                          VIDD_NAME,*/
                       0 AS rate,
                       NVL (dpt.f_dptw (dc.deposit_id, ''NCASH''), ''0'') DPT_NOCASH, 0 AS DPT_STATUS, max(DC.archdoc_id) archdoc_id --, max(dc.wb) wb
                       FROM cust c, accmainlst ac, dpt_deposit_clos dc, dpt_vidd v
                       WHERE c.rnk = dc.rnk AND v.vidd = dc.vidd and dc.acc = ac.acc
          GROUP BY dc.rnk,dc.acc,dc.branch,dc.kv,v.amr_metr,DC.DEPOSIT_ID,DC.ND,dc.datz/*,DC.VIDD*/, NVL (dpt.f_dptw (dc.deposit_id,''NCASH''), ''0'') '
                       ||
                         case when p_mode in (0,-2) then l_stmt_str   || ' HAVING max(DC.archdoc_id) = -1 '
                              when p_mode in (1, -1) then l_stmt_str  || ' HAVING max(DC.archdoc_id) >= 0 '
                         end
                       ||')
                    SELECT DISTINCT
                           lst.DPT_ID,
                           lst.DPT_NUM,
                           lst.DPT_DAT,
						   coalesce(d.dat_begin, (select max(dat_begin) from dpt_deposit_clos where deposit_id = d.deposit_id))DAT_BEGIN,
                           coalesce(d.dat_end, (select max(dat_end) from dpt_deposit_clos where deposit_id = d.deposit_id))DAT_END,
                           (select b.vidd from dpt_deposit_clos b where b.deposit_id =  D.DEPOSIT_ID and b.idupd in (select max( a.idupd ) 
                                                                                                                     from dpt_deposit_clos a
                                                                                                                     where a.deposit_id = b.deposit_id)) VIDD_CODE,
                                                                                                               
                           (SELECT type_name FROM dpt_vidd WHERE vidd = (select b.vidd from dpt_deposit_clos b where b.deposit_id =  D.DEPOSIT_ID and b.idupd in (select max( a.idupd ) 
                                                                                                                                                                   from dpt_deposit_clos a
                                                                                                                                                                   where a.deposit_id = b.deposit_id)) ) VIDD_NAME,
                           
                           /*lst.VIDD_CODE,
                           lst.VIDD_NAME,*/
                           dpt_web.get_dptrate (accmainlst.acc,
                                                accmainlst.kv,
                                                d.LIMIT,
                                                TRUNC (SYSDATE))
                              rate,
                           coalesce(d.limit, (select limit from dpt_deposit_clos where deposit_id = d.deposit_id and action_id = 0)) dpt_amount,
                           D.COMMENTS,
                           NVL (d.archdoc_id, lst.archdoc_id) AS archdoc_id,
                           lst.DPT_NOCASH,
						   CASE WHEN d.deposit_id IS NOT NULL THEN nvl(d.status,0) ELSE -1 END
                              DPT_STATUS,
						   d.mfo_d  DPTRCP_MFO,
                           d.nls_d  DPTRCP_ACC,
                           d.nms_d  DPTRCP_NAME,
                           d.okpo_d DPTRCP_IDCODE,
                           d.mfo_p  INTRCP_MFO,
                           d.nls_p  INTRCP_ACC,
                           d.name_p INTRCP_NAME,
                           d.okpo_p INTRCP_IDCODE,
                           cust.rnk CUST_ID,
                           cust.nmk CUST_NAME,
                           cust.okpo CUST_IDCODE,
                           cust.bday CUST_BIRTHDATE,
                           cust.ser DOC_SERIAL,
                           cust.numdoc DOC_NUM,
                           cust.organ DOC_ISSUED,
                           cust.pdate DOC_DATE,
                           accmainlst.acc DPT_ACCID,
                           accmainlst.nls DPT_ACCNUM,
                           accmainlst.nms DPT_ACCNAME,
                           NVL (accmainlst.kv, lst.kv) DPT_CURID,
                           (SELECT lcv
                              FROM tabval$global
                             WHERE kv = NVL (accmainlst.kv, lst.kv))
                              AS DPT_CURCODE,
                           (SELECT name
                              FROM tabval$global
                             WHERE kv = NVL (accmainlst.kv, lst.kv))
                              AS DPT_CURNAME,
                           accmainlst.ostc DPT_SALDO,
                           accmainlst.ostb DPT_SALDO_PL,
                           NVL (accmainlst.blk, 0) DPT_LOCK,
                           accintlst.acc INT_ACCID,
                           accintlst.nls INT_ACCNUM,
                           accintlst.nms INT_ACCNAME,
                           NVL (accintlst.kv, lst.kv) INT_CURID,
                           (SELECT lcv
                              FROM tabval$global
                             WHERE kv = NVL (accintlst.kv, lst.kv))
                              AS INT_CURCODE,
                           (SELECT name
                              FROM tabval$global
                             WHERE kv = NVL (accintlst.kv, lst.kv))
                              AS INT_CURNAME,
                           NVL (accintlst.ostc, 0) INT_SALDO,
                           NVL (accintlst.ostb, 0) INT_SALDO_PL,
                           (SELECT SUM (kos)
                              FROM saldoa
                             WHERE     acc = accintlst.acc
                                   AND fdat BETWEEN accintlst.daos AND SYSDATE)
                              INT_KOS,
                           (SELECT SUM (dos)
                              FROM saldoa
                             WHERE     acc = accintlst.acc
                                   AND fdat BETWEEN accintlst.daos AND SYSDATE)
                              INT_DOS,
						   coalesce(d.branch,(select branch from dpt_deposit_clos where deposit_id = d.deposit_id and action_id = 0)),
                           (select name from branch where branch = coalesce(d.branch,(select branch from dpt_deposit_clos where deposit_id = d.deposit_id and action_id = 0))) BRANCH_NAME,
                           dpt.payoff_enable (accintlst.acc,
                                              d.freq,
                                              DECODE (lst.amr_metr, 0, 0, 1),
                                              d.dat_begin,
                                              d.dat_end,
                                              gl.bd,
                                              DECODE (NVL (d.cnt_dubl, 0), 0, 0, 1))
                              FL_INT_PAYOFF,
                           DECODE (lst.amr_metr, 0, 0, 1) FL_AVANS_PAYOFF,
                           (SELECT denom
                              FROM tabval$global
                             WHERE kv = NVL (accmainlst.kv, lst.kv))
                              AS DPT_CUR_DENOM, 
			    d.wb --lst.wb
                      FROM cust
                           JOIN lst ON lst.rnk = cust.rnk
                           LEFT JOIN dpt_deposit d ON d.deposit_id = lst.DPT_ID
                           LEFT JOIN accmainlst ON lst.DPT_ID = accmainlst.DPT_ID
                           LEFT JOIN accintlst ON lst.DPT_ID = accintlst.DPT_ID
                     ) a';
     l_stmt_str :=
     case when p_mode = 0 then l_stmt_str   || ' where nvl(DPT_STATUS,0) > -1 and ARCHDOC_ID = -1 '
          when p_mode = 1 then l_stmt_str   || ' where nvl(DPT_STATUS,0) > -1 and ARCHDOC_ID >= 0 '
          when p_mode = -1 then l_stmt_str  || ' where DPT_STATUS = -1 and ARCHDOC_ID >= 0 '
          when p_mode = -2 then l_stmt_str  || ' where DPT_STATUS = -1 and ARCHDOC_ID < 0 '
     end;

/*      bars_audit.info(substr(l_stmt_str,1,4000));
      bars_audit.info(substr(l_stmt_str,4001,8000));
      bars_audit.info(substr(l_stmt_str,8001,16000));*/
      OPEN l_cursor FOR l_stmt_str;

      LOOP
         FETCH l_cursor INTO l_portfolio;
         EXIT WHEN l_cursor%NOTFOUND;
         PIPE ROW (l_portfolio);
      END LOOP;

      CLOSE l_cursor;
   end;

 function get_rpt(p_code     in  tmp_dptrpt.code%type,
                  p_dat1     in  tmp_dptrpt.fdat%type,
                  p_dat2     in  tmp_dptrpt.fdat%type,
                  p_dptid    in  tmp_dptrpt.dptid%type) return t_tmp_dptrpt pipelined

 is
  pragma autonomous_transaction;
  l_tmp_dptrpt_rec tmp_dptrpt%rowtype;
  l_context varchar2(30) := sys_context('bars_context','user_branch');
 begin
   bc.go('/');
   bars_audit.info('dpt_views.get_rpt started');
   gen_dptrpt(p_code, p_dat1, p_dat2,p_dptid, 1);
   commit;
   bars_audit.info('dpt_views.get_rpt gen_dptrpt ok');
   for k in (select * from  bars.tmp_dptrpt )
   loop
    bars_audit.info('dpt_views.get_rpt loop' ||k.DPTID ||'   ' || to_char(k.FDAT));
    l_tmp_dptrpt_rec.recid          := k.recid;
    l_tmp_dptrpt_rec.CODE           := k.CODE;
    l_tmp_dptrpt_rec.DPTID          := k.DPTID;
    l_tmp_dptrpt_rec.DPTNUM         := k.DPTNUM;
    l_tmp_dptrpt_rec.DPTDAT         := k.DPTDAT;
    l_tmp_dptrpt_rec.DATBEG         := k.DATBEG;
    l_tmp_dptrpt_rec.DATEND         := k.DATEND;
    l_tmp_dptrpt_rec.DEPACCNUM      := k.DEPACCNUM;
    l_tmp_dptrpt_rec.DEPACCNAME     := k.DEPACCNAME;
    l_tmp_dptrpt_rec.INTACCNUM      := k.INTACCNUM;
    l_tmp_dptrpt_rec.INTACCNAME     := k.INTACCNAME;
    l_tmp_dptrpt_rec.CURID          := k.CURID;
    l_tmp_dptrpt_rec.CURCODE        := k.CURCODE;
    l_tmp_dptrpt_rec.CURNAME        := k.CURNAME;
    l_tmp_dptrpt_rec.TYPEID         := k.TYPEID;
    l_tmp_dptrpt_rec.TYPENAME       := k.TYPENAME;
    l_tmp_dptrpt_rec.CUSTID         := k.CUSTID;
    l_tmp_dptrpt_rec.CUSTNAME       := k.CUSTNAME;
    l_tmp_dptrpt_rec.DOCTYPE        := k.DOCTYPE;
    l_tmp_dptrpt_rec.ISAL_GEN       := k.ISAL_GEN;
    l_tmp_dptrpt_rec.OSAL_GEN       := k.OSAL_GEN;
    l_tmp_dptrpt_rec.FDAT           := k.FDAT;
    l_tmp_dptrpt_rec.PDAT           := k.PDAT;
    l_tmp_dptrpt_rec.ISAL_DAT       := k.ISAL_DAT;
    l_tmp_dptrpt_rec.OSAL_DAT       := k.OSAL_DAT;
    l_tmp_dptrpt_rec.DOCREF         := k.DOCREF;
    l_tmp_dptrpt_rec.DOCNUM         := k.DOCNUM;
    l_tmp_dptrpt_rec.DOCTT          := k.DOCTT;
    l_tmp_dptrpt_rec.DOCDK          := k.DOCDK;
    l_tmp_dptrpt_rec.DOCSUM         := k.DOCSUM;
    l_tmp_dptrpt_rec.DOCSK          := k.DOCSK;
    l_tmp_dptrpt_rec.DOCUSER        := k.DOCUSER;
    l_tmp_dptrpt_rec.DOCDTL         := k.DOCDTL;
    l_tmp_dptrpt_rec.CORRMFO        := k.CORRMFO;
    l_tmp_dptrpt_rec.CORRACC        := k.CORRACC;
    l_tmp_dptrpt_rec.CORRNAME       := k.CORRNAME;
    l_tmp_dptrpt_rec.CORRCODE       := k.CORRCODE;
    l_tmp_dptrpt_rec.USERID         := k.USERID;
    l_tmp_dptrpt_rec.USERNAME       := k.USERNAME;
    l_tmp_dptrpt_rec.BRN4ID         := k.BRN4ID;
    l_tmp_dptrpt_rec.BRN4NAME       := k.BRN4NAME;

    pipe row(l_tmp_dptrpt_rec);

   end loop;
   bars_audit.info('dpt_views.get_rpt gen_endloop');
   bars_audit.info('dpt_views.get_rpt exit');
 end;
end;
/
show err;

PROMPT *** Create  grants  DPT_VIEWS ***
grant DEBUG,EXECUTE                                                          on DPT_VIEWS       to BARS_ACCESS_DEFROLE;



PROMPT =====================================================================================
PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpt_views.sql =========*** End *** =
PROMPT =====================================================================================
 
/
