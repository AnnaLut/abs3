
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s260_bpk.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S260_BPK (p_nd number, p_acc number, p_tp number, p_s260 in varchar2, dat_ date)
return varchar2
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- versions 14/10/2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
is
    s260_r varchar2(10);
    nd_    number := p_nd;
begin
    if p_nd is null then
       begin
          if p_tp = 1 then
             select nd
             into nd_
             from v_bpk_nd_acc
             where acc = p_acc
               and (dat_close is null or (dat_close is not null and dat_close > dat_));
          else
             select nd
             into nd_
             from v_w4_nd_acc
             where acc= p_acc
               and (dat_close is null or (dat_close is not null and dat_close > dat_));
          end if;
       exception
          when no_data_found then null;
       end;
    end if;

    if nd_ is not null then
       begin
           if p_tp = 1 then
              select max(s260)
              into s260_r
              from v_bpk_nd_acc v, specparam s
              where v.nd = nd_ and
                    v.acc = s.acc and
                   (v.dat_close is null or (v.dat_close is not null and v.dat_close > dat_));
           else
              select max(s260)
              into s260_r
              from v_w4_nd_acc v, specparam s
              where v.nd = nd_ and
                    v.acc = s.acc and
                    (v.dat_close is null or (v.dat_close is not null and v.dat_close > dat_));
           end if;
       exception
          when no_data_found then null;
       end;
    end if;

    return lpad(nvl(trim(s260_r), p_s260),2,'0');
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s260_bpk.sql =========*** End
 PROMPT ===================================================================================== 
 