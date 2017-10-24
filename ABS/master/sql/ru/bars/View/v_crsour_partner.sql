create or replace view v_crsour_partner as
select c.rnk, b.mfo, c.nmk from customer c
join custbank b on b.rnk = c.rnk
where c.kf = sys_context('bars_context', 'user_mfo') and
      c.date_off is null and
      c.custtype = 1 and
      c.rnk in (select rnk from custbank b
                where c.codcagent = 9 and
                      b.mfo is not null /*and
                      b.mfo <> sys_context('bars_context', 'user_mfo')*/);

grant select on v_crsour_partner to bars_access_defrole;
