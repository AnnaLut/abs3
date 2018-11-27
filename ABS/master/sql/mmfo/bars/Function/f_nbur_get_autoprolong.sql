CREATE OR REPLACE FUNCTION BARS.F_NBUR_GET_AUTOPROLONG (p_acc in number,
                                                        p_dat in date) return varchar2
 -------------------------------------------------------------------
 -- функція визначення чи була відмова від автопролонгації
 -------------------------------------------------------------------
 -- ВЕРСИЯ: 13/11/2018
 -------------------------------------------------------------------
 -- параметри:
 --    p_acc - ідентифікатор рахунку
 --    p_dat - на дату
 -- повертає = 1, якщо була відмова від автопролонгації
 --          = 0 - не було відмови
 ----------------------------------------------------------------
is
    l_flag  varchar2(1);
begin
    select (case when req_dat is not null then '1' else '0' end) 
    into l_flag
    from (select max(req_bnkdat) as req_dat
          from dpt_accounts a, dpt_extrefusals r
          where a.accid = p_acc  and
                a.dptid = r.dptid and
                r.req_state = 1 and
                r.req_bnkdat <= p_dat);

   return l_flag;
exception
    when no_data_found then 
        return '0';
end;
/
show err;