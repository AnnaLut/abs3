CREATE OR REPLACE FUNCTION f_nbur_get_sum_ovdp (p_acc in number,
                                                     p_dat in date) return number
 -------------------------------------------------------------------
 -- функція визначення справедливої вартості необтяжених ЦП
 -------------------------------------------------------------------
 -- ВЕРСИЯ: 20/11/2018
 -------------------------------------------------------------------
 -- параметри:
 --    p_acc - ідентифікатор рахунку
 --    p_dat - на дату
 -- повертає суму 
 ----------------------------------------------------------------
is
    l_sum  number;
    l_isin varchar2(20);
begin
    select gl.p_icurval(s.kv, round((s.kol_all - nvl(kol_zal, 0)) * fv_cp * koef * 100, 0), p_dat)  sum_nobt,
           o.isin
    into l_sum, l_isin
    from cp_v_zal_web s
    join cp_kod c
    on (s.id = c.id)
    left outer join nbur_ovdp_6ex o
    on (c.cp_id = o.isin and
        o.date_fv = p_dat)
    where s.acc = p_acc;
    
    -- немає запису для даного виду ЦП вnbur_ovdp_6ex 
    if l_sum is null and l_isin is null then
        select gl.p_icurval(s.kv, s.nom_all - nvl(nom_zal, 0), p_dat)  sum_nobt
        into l_sum
        from cp_v_zal_web s
        where s.acc = p_acc;
    end if;
    
    return l_sum;
exception
    when no_data_found then 
        return null;
end;
/
show err;