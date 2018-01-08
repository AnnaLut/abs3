

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW950_HEADER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW950_HEADER ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW950_HEADER ("SENDER_BIC", "LORO_ACCNUM", "NOSTRO_ACCCODE", "NOSTRO_ACCNUM", "NOSTRO_ACCNAME", "NOSTRO_REST_IN", "NOSTRO_REST_OUT", "NOSTRO_TRN_COUNT", "STMT_REF", "STMT_MT", "STMT_TRN", "STMT_CURRCODE", "STMT_CURRENCY", "STMT_BEG_DATE", "STMT_END_DATE", "STMT_REST_IN", "STMT_REST_OUT", "STMT_DATE_IN", "STMT_DATE_OUT", "STMT_VALUE_DATE", "STMT_NUM", "STMT_PAGE", "STMT_PROCESSED", "STMT_DETAIL_COUNT", "STMT_DOS", "STMT_KOS", "STMT_NPROC_COUNT") AS 
  select j.sender                                           sender_bic,       /* bic      */
       b.their_acc                                        loro_accnum,      /* lor      */
       a.acc                                              nostro_acccode,   /* acc      */
       a.nls                                              nostro_accnum,    /* nls      */
       a.nms                                              nostro_accname,   /* nms      */
       fost(a.acc, w.stmt_bdate)+
          fdos(a.acc, w.stmt_bdate, w.stmt_bdate)-
          fkos(a.acc, w.stmt_bdate, w.stmt_bdate)         nostro_rest_in,
       fost(a.acc, w.stmt_date)                           nostro_rest_out,
       (select count(*)
          from opldok
         where fdat between w.stmt_bdate and w.stmt_date
           and acc = a.acc                             )  nostro_trn_count,
       j.swref                                            stmt_ref,         /* swref    */
       j.mt                                               stmt_mt,          /* mt       */
       j.trn                                              stmt_trn,         /* trn      */
       t.kv                                               stmt_currcode,    /* kv       */
       t.lcv                                              stmt_currency,    /* lcv      */
       w.stmt_bdate                                       stmt_beg_date,    /* bdat     */
       w.stmt_date                                        stmt_end_date,    /* dat      */
       w.obal/100                                         stmt_rest_in,     /* vxl      */
       w.cbal/100                                         stmt_rest_out,    /* ixl      */
       trunc(j.date_in)                                   stmt_date_in,     /* date_in  */
       trunc(j.date_out)                                  stmt_date_out,    /* date_out */
       j.vdate                                            stmt_value_date,  /* vdate    */
       w.num                                              stmt_num,         /* num      */
       j.page                                             stmt_page,        /* page     */
       nvl(w.done, 0)                                     stmt_processed,   /* done     */
       (select count(*)
          from v_sw950_detail
         where sw950ref = w.swref)                        stmt_detail_count,
		 (select nvl(sum(s),0)/100
          from sw_950d
         where swref = w.swref and stmt_dk in('D', 'RC')) STMT_DOS,
        (select nvl(sum(s),0)/100
          from sw_950d
         where swref = w.swref and stmt_dk in('C', 'RD')) STMT_KOS,
       (select count(*)
          from v_sw950_detail
         where sw950ref = w.swref
           and processed = 'N')               stmt_nproc_count
  from sw_950 w, accounts a, bic_acc b, tabval t, sw_journal j
 where a.acc(+) = w.nostro_acc
   and b.acc(+) = w.nostro_acc
   and j.swref  = w.swref
   and t.lcv    = j.currency
   and nvl(w.done, 0) = 0;

PROMPT *** Create  grants  V_SW950_HEADER ***
grant SELECT                                                                 on V_SW950_HEADER  to BARS013;
grant SELECT                                                                 on V_SW950_HEADER  to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW950_HEADER  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW950_HEADER  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW950_HEADER  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW950_HEADER.sql =========*** End ***
PROMPT ===================================================================================== 
