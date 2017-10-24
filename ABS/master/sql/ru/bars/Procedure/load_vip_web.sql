

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/LOAD_VIP_WEB.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure LOAD_VIP_WEB ***

  CREATE OR REPLACE PROCEDURE BARS.LOAD_VIP_WEB (P_MFO      IN varchar2,
                                     P_RNK      IN varchar2,
                                     P_VIP      IN varchar2 default null,
                                     P_KVIP     IN varchar2 default null,
                                     P_DATBEG   IN date default null,
                                     P_DATEND   IN date default null,
                                     P_RETURN   OUT varchar2,
                                     p_COMMENTS IN varchar2 default null,
                                     p_FIOMANAGER IN varchar2 default null,
                                     p_PHONEMANAGER IN varchar2 default null,
                                     p_MAILMANAGER IN varchar2 default null,
                                     p_ACCOUNTMANAGER IN number default null) is
    l_kvip varchar2(50);
 --   l_rel_rnk  varchar2(20);
BEGIN

  logger.trace('Start: load_vip_web');
  --
  p_return := null;
  --
  begin
  select id into l_kvip from vip_calc_tp where upper(name)=upper(P_KVIP);
    exception when no_data_found
        then l_kvip:=P_KVIP;
  end;


  if p_mfo = sys_context('bars_context', 'user_mfo') then
  update customer
         set isp = p_ACCOUNTMANAGER
       where rnk = to_number(trim(p_rnk));
    begin
      update vip_flags v
         set v.vip      = (select rtrim(id,',') from (select ltrim(sys_connect_by_path(id, ','),',') as "ID"
                            from (
                            select id,  lag(id) over (order by id) as id_1 from
                                (
                                    select t.id from vip_tp t, (
                                    select distinct substr(s, level, 1) as ID from
                                    (select replace(vip,',','') as s from vip_flags where rnk = p_rnk
                                    union all select replace(p_vip,',','') from dual)
                                    connect by level <= length(s) order by ID) a  where t.id=a.id
                                )

                                )
                            start with id_1 is null
                            connect by id_1 = prior id
                            order by 1 desc)
                            where rownum=1),

             v.kvip     = l_kvip,
             v.datbeg   = nvl(P_DATBEG, sysdate),
             v.datend   = nvl(p_datend, sysdate),
             v.comments = p_comments,
             v.fio_manager = case when p_FIOMANAGER is not null then p_FIOMANAGER else v.fio_manager end,
             v.phone_manager = case when p_PHONEMANAGER is not null then p_PHONEMANAGER else v.phone_manager end,
             v.mail_manager = case when p_MAILMANAGER is not null then p_MAILMANAGER else v.mail_manager end,
             v.account_manager = case when p_ACCOUNTMANAGER is not null then p_ACCOUNTMANAGER else v.account_manager end
       where v.mfo = p_mfo
         and v.rnk = p_rnk
         or v.rnk in (select rel_rnk from customer_rel where rel_id = 60 and rnk = p_rnk);
          --
      if sql%rowcount = 0 then
        begin
          insert into vip_flags
            (mfo, rnk, vip, kvip, datbeg, datend, comments, fio_manager, phone_manager, mail_manager, account_manager)
          values
            (p_mfo, p_rnk, p_vip, l_kvip, nvl(P_DATBEG, trunc(sysdate)), nvl(p_datend, trunc(sysdate)), p_comments, p_FIOMANAGER, p_PHONEMANAGER, p_MAILMANAGER, p_ACCOUNTMANAGER);

          for c in(select rel_rnk from customer_rel where rel_id = 60 and rnk = p_rnk)
          loop
            begin
               insert into vip_flags
                (mfo, rnk, vip, kvip, datbeg, datend, comments, fio_manager, phone_manager, mail_manager, account_manager)
               values
                (p_mfo, c.rel_rnk, p_vip, l_kvip, nvl(P_DATBEG, sysdate), nvl(p_datend, sysdate), p_comments, p_FIOMANAGER, p_PHONEMANAGER, p_MAILMANAGER, p_ACCOUNTMANAGER);
            exception
              when dup_val_on_index then
                p_return := 'Такий клієнт вже існує';
                return;
            end;
          end loop;
        exception
          when dup_val_on_index then
            p_return := 'Такий клієнт вже існує';
            return;
          when others then
            if (SQLCODE = -02291) then
              p_return := '';
            else
              p_return := SQLERRM;
            end if;
             return;
        end;
      end if;
      --
    end;

    begin
      update customerw
         set value = case when nvl(P_DATBEG, sysdate)<=trunc(sysdate) and nvl(P_DATEND, sysdate)>=trunc(sysdate) then '1' else '0' end
       where rnk = to_number(trim(p_rnk))
         and tag = 'VIP_K';
      if sql%rowcount = 0 then
        begin
          insert into customerw
            (rnk, tag, value, isp)
          values
            (to_number(trim(p_rnk)), 'VIP_K', case when nvl(P_DATBEG, sysdate)<=trunc(sysdate) and nvl(P_DATEND, sysdate)>=trunc(sysdate) then '1' else '0' end, 0);
        exception
          when dup_val_on_index then
            p_return := 'Такий клієнт вже існує';
               return;
          when others then
            if (SQLCODE = -02291) then
              p_return := '';
            else
              p_return := SQLERRM;
            end if;
                return;
        end;
      end if;
    end;
  end if;

  logger.trace('Finish: load_vip_web');
END load_vip_web;
/
show err;

PROMPT *** Create  grants  LOAD_VIP_WEB ***
grant EXECUTE                                                                on LOAD_VIP_WEB    to ABS_ADMIN;
grant EXECUTE                                                                on LOAD_VIP_WEB    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LOAD_VIP_WEB    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/LOAD_VIP_WEB.sql =========*** End 
PROMPT ===================================================================================== 
