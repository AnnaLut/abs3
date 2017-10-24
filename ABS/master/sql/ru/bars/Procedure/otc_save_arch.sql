

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTC_SAVE_ARCH.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTC_SAVE_ARCH ***

  CREATE OR REPLACE PROCEDURE BARS.OTC_SAVE_ARCH (p_kodf in varchar2, p_datf in date, p_type in number) is
begin
    insert into OTCN_FLAG_BLK(TP, DATF, KODF, ISP, DAT_BLK)
    values (p_type, p_datf, p_kodf, user_id, sysdate);

    if p_type = 0 then -- зв≥тн≥сть ЌЅ”
        insert /*PARALLEL(RNBU_TRACE_ARCH) */
        into RNBU_TRACE_ARCH(KODF, DATF, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
        select /*+ PARALLEL(r) */
            p_kodf, p_datf, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
        from rnbu_trace;
    elsif p_type = 1 then -- зв≥тн≥сть ќщадного банку
        insert /* PARALLEL(RNBU_TRACE_INT_ARCH) */
        into RNBU_TRACE_INT_ARCH(KODF, DATF, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
        select /*+ PARALLEL(r) */
            p_kodf, p_datf, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
        from rnbu_trace;
    else
        null;
    end if;
    commit;
end;
/
show err;

PROMPT *** Create  grants  OTC_SAVE_ARCH ***
grant EXECUTE                                                                on OTC_SAVE_ARCH   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTC_SAVE_ARCH   to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTC_SAVE_ARCH.sql =========*** End
PROMPT ===================================================================================== 
