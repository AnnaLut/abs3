

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/OTC_DEL_ARCH.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure OTC_DEL_ARCH ***

  CREATE OR REPLACE PROCEDURE BARS.OTC_DEL_ARCH (p_kodf in varchar2, p_datf in date, p_type in number) is
    isp_    number;
begin
    if f_ourmfo = '300465' then
       begin
            select isp
            into isp_
            from OTCN_FLAG_BLK
            where TP = p_type and
                  DATF = p_datf and
                  KODF = p_kodf;

            if isp_ <> user_id then return; end if;
       exception
            when no_data_found then null;
       end;
   end if;

    if p_type = 0 then -- зв≥тн≥сть ЌЅ”
       delete from RNBU_TRACE_ARCH r where DATF = p_datf and KODF = p_kodf;
    elsif p_type = 1 then -- зв≥тн≥сть ќщадного банку
       delete from RNBU_TRACE_INT_ARCH r where DATF = p_datf and KODF = p_kodf;
    end if;

    delete from OTCN_FLAG_BLK where TP = p_type and DATF = p_datf and KODF = p_kodf;
end;
/
show err;

PROMPT *** Create  grants  OTC_DEL_ARCH ***
grant EXECUTE                                                                on OTC_DEL_ARCH    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on OTC_DEL_ARCH    to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/OTC_DEL_ARCH.sql =========*** End 
PROMPT ===================================================================================== 
