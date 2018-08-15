

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_AFTER_OPEN_ACC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_AFTER_OPEN_ACC ***

  CREATE OR REPLACE PROCEDURE BARS.P_AFTER_OPEN_ACC 
( p_acc           accounts.acc%type
) is
  l_nbs           accounts.nbs%type;
  l_nls           accounts.nls%type;
  l_branch        accounts.branch%type;
  l_isp           accounts.isp%type;
  rnk_            customer.rnk%type;
  nmk_            customer.nmk%type;
  insform_        varchar2(30);
  prinsider_      customer.prinsider%type;
  txt_            varchar2(1024);
  uid_            number;
  cid_            varchar2(1024);
  key_            number;
  type t_grp_type is table of vip_nbs_grp_lst.grp_id%type;
  t_grp_lst       t_grp_type;
  -- 12.03.2017
begin

  begin

    select a.NLS, coalesce(a.NBS,substr(a.NLS,1,4))
         , a.BRANCH, a.ISP
      into l_nls, l_nbs, l_branch, l_isp
      from ACCOUNTS a
     where a.ACC = p_acc;

    -- для Ощада відкриття рахунка у VIP ТВБВ або менеджером в ТВБВ з VIP зоною
    select g.GRP_ID
      bulk collect
      into t_grp_lst
      from VIP_NBS_GRP_LST g
     where g.R020 = l_nbs
       and 0 < ( select count(1)
                   from VIP_MGR_USR_LST u
                  where u.BRANCH = l_branch
                    and lnnvl( u.USR_ID <> l_isp )
               );

    if ( t_grp_lst.count > 0 )
    then

      -- чистимо
      update ACCOUNTS
         set SEC = null
       where ACC = p_acc;

      -- додаємо лише в групи з обмеженим доступом
      for g in t_grp_lst.first .. t_grp_lst.last
      loop
        sec.addAgrp( p_acc, t_grp_lst(g) );
      end loop;

    else

      for k in ( select ID
                   from GROUPS_NBS
                  where l_nbs like trim(NBS)||'%' )
      loop
        sec.addAgrp(p_acc,k.id);
      end loop;

    end if;

  exception
    when no_data_found then
      null;
  end;
  
  begin
  --добавление доп. параметров по заявке COBUPRVNIX-124 VL 22.03.2018
   if (l_nbs in (1811, 1819, 2800, 2801, 2805, 2809, 3540, 3541, 3542, 3548, 3570, 3578, 3710)) 
    then 
	bars.accreg.setAccountwParam (p_acc,'BUS_MOD',15);
	bars.accreg.setAccountwParam (p_acc,'SPPI','Так');
	bars.accreg.setAccountwParam (p_acc,'IFRS','AC');
   end if;
   exception when others then 
    raise_application_error(-20000,p_acc || ' ERROR: ' || sqlerrm ||' '||dbms_utility.format_error_backtrace());
  end;

  -- выдача сообщения (реестр инсайдеров)
  if getglobaloption('BMS')='1' and getglobaloption('RI')='1'
  then

    begin
      select a.rnk  ,
             c.nmk  ,
             w.value,
             nvl(nullif(c.prinsider,0),99)
      into   rnk_    ,
             nmk_    ,
             insform_,
             prinsider_
      from   accounts  a,
             customer  c,
             customerw w
      where  a.acc=p_acc    and
             c.rnk=a.rnk    and
             w.rnk(+)=a.rnk and
             w.tag='INSFO';
    exception
      when no_data_found then
        insform_ := null;
    end;

    if ( insform_ = '0' and prinsider_ <> 99 )
    then

      uid_ := user_id;

--    if check_subscriber('BARS_'||uid_)=0 then
--      begin
--        bms.add_subscriber(uid_);
--      exception when others then
--        if sqlcode=-24089 then -- or sqlcode=-1405 then
--          null;
--        else
--          bars_audit.error('bms.add_subscriber: user_id='||to_char(uid_)||' - '||sqlerrm);
--        end if;
--      end;
--    end if;

      txt_ := 'Для клієнта-інсайдера ('||nmk_||', rnk='||to_char(rnk_)||') необхідне заповнення анкети';

      begin
        select client_id
        into   cid_
        from   USER_LOGIN_SESSIONS
        where  proxy_user is null and
               user_id=uid_       and
               rownum<2;
      exception
        when no_data_found then
          cid_ := null;
      end;

      -- key_ := S_RI_MESSAGES.NEXTVAL;
      key_ :=  bars_sqnc.get_nextval('S_RI_MESSAGES');

      if cid_ is not null
      then

        begin

          bars_audit.info('bms.enqueue_msg (cen): nmk='||nmk_||', rnk='||to_char(rnk_));

          bms.enqueue_msg( '('||to_char(key_)||')'||txt_,
                          dbms_aq.no_delay             ,
                          dbms_aq.never                ,
                          uid_);

          insert
            into RI_MESSAGES
               ( KEY, ID, MSG, DATEMSG, BRANCH, RNK, DESKTOP )
          values
             ( key_, uid_, '('||to_char(key_)||')'||txt_, sysdate
             , sys_context('bars_context','user_branch'), rnk_, 'CENTURA' );

        exception when others then
          null;
        end;

      else

        begin

          bars_audit.info('bms.enqueue_msg (WEB): nmk='||nmk_||', rnk='||to_char(rnk_));

          bms.push_msg_web( user_name, '('||to_char(key_)||')'||txt_ );

          insert
            into RI_MESSAGES
               ( KEY, ID, MSG, DATEMSG, BRANCH, RNK, DESKTOP )
          values
               ( key_, uid_, '('||to_char(key_)||')'||txt_, sysdate
               , sys_context('bars_context','user_branch'), rnk_, 'WEB' );

        exception
          when others then
            null;
        end;

      end if;

    end if;

  end if; -- выдача сообщения (реестр инсайдеров)

end P_AFTER_OPEN_ACC;
/
show err;

PROMPT *** Create  grants  P_AFTER_OPEN_ACC ***
grant EXECUTE                                                                on P_AFTER_OPEN_ACC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_AFTER_OPEN_ACC.sql =========*** 
PROMPT ===================================================================================== 
