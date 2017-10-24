

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_D8_041.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_D8_041 ***

  CREATE OR REPLACE PROCEDURE BARS.P_D8_041 (rnk in varchar2 default null)
is
  l_rnk customer.rnk%type ;
begin
  for k in (select okpo, link_group,groupname  from d8_cust_link_groups)
     loop
       l_rnk :=null;
       update d8_cust_link_groups set link_code = tools.number_to_base(k.link_group,62) where okpo = k.okpo and link_group=k.link_group;

       begin
          begin
                SELECT rnk
                  INTO l_rnk
                  FROM customer
                 WHERE okpo = k.okpo AND date_off IS NULL;
          exception
             when too_many_rows then null;
             when no_data_found then
             begin
                    SELECT rnk
                      INTO l_rnk
                      FROM customer
                     WHERE rnk = k.okpo AND date_off IS NULL;
             exception
                when no_data_found then null;
             end;
          end;
          bars_audit.info('D8_041 rnk = '||l_rnk||' OKPO = '||k.okpo);
          if l_rnk is not null then
          update customerw set value = k.link_group||'/'||tools.number_to_base(k.link_group,62) where rnk = l_rnk and tag = 'LINKG';
          if sql%rowcount = 0 then
                insert into customerw (rnk, tag, value,isp) values (l_rnk, 'LINKG', k.link_group||'/'||tools.number_to_base(k.link_group,62),0);
               --
          end if;

          update customerw set value = k.groupname where rnk = l_rnk and tag = 'LINKK';
          if sql%rowcount = 0 then
             insert into customerw (rnk, tag, value,isp) values (l_rnk, 'LINKK', k.groupname,0);
          end if;
          end if;
       end;
     end loop;
end;
/
show err;

PROMPT *** Create  grants  P_D8_041 ***
grant EXECUTE                                                                on P_D8_041        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_D8_041.sql =========*** End *** 
PROMPT ===================================================================================== 
