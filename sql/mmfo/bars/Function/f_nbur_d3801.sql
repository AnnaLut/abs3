
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_d3801.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_D3801 
              (p_ref            number,
               p_tt             varchar2,
               p_acc3801        number,
               p_dk             number,
               p_accd           number,
               p_acck           number,
               p_report_date    date,
               p_kf             varchar2
              ) return number is
 -------------------------------------------------------------------
 -- AA?NE?: 15/07/2016 (03.12.2004)
 -------------------------------------------------------------------
 -- ?an?ao noiiu yeaeaaeaioa, aey ai?a?ieo iia?aoee a aae?oiiaiaiiuo
 --   iia?aoee ii eanna
 -- ia?aiao?u:
 --    ref_ - eaaioeoeeaoi? aieoiaioa
 --    tt_ - eia iia?aoee
 --    acc3801_ - eia n?aoa aeaeaaeaioa
 --    dk_ - aaaao/e?aaeo
 --    accd_ - eia n?aoa ?acoeuoaoa oi?aiaee aae?oie ii aaaaoo
 --    acck_ - eia n?aoa ?acoeuoaoa oi?aiaee aae?oie ii e?aaeoo
 -------------------------------------------------------------------
	l_sum number;
	l_dk  number := 1 - p_dk;
begin
    if l_dk = 1 then
        select sum(t.bal)
        into l_sum
        from NBUR_DM_TRANSACTIONS t
        where t.report_date = p_report_date and
              t.kf = p_kf and
              t.ref = p_ref and
              t.acc_id_db = p_acc3801 and
              t.tt = p_tt and
              t.acc_id_cr not in (p_accd, p_acck) and
              substr(t.acc_num_cr,1,3) in ('100','110') and
              t.kv=980 ;
    else
        select sum(t.bal)
        into l_sum
        from NBUR_DM_TRANSACTIONS t
        where t.report_date = p_report_date and
              t.kf = p_kf and
              t.ref = p_ref and
              t.acc_id_cr = p_acc3801 and
              t.tt = p_tt and
              t.acc_id_db not in (p_accd, p_acck) and
              substr(t.acc_num_db,1,3) in ('100','110') and
              t.kv=980 ;
    end if;

	return l_sum;
exception
   when no_data_found then
  	    return 0;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_d3801.sql =========*** End *
 PROMPT ===================================================================================== 
 