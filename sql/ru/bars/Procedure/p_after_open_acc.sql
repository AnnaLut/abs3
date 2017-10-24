

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_AFTER_OPEN_ACC.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_AFTER_OPEN_ACC ***

  CREATE OR REPLACE PROCEDURE BARS.P_AFTER_OPEN_ACC (p_acc number)
is
  l_nbs       accounts.nbs%type;
  l_nls       accounts.nls%type;
--
  rnk_        customer.rnk%type;
  nmk_        customer.nmk%type;
  insform_    varchar2(30);
  prinsider_  customer.prinsider%type;
  txt_        varchar2(1024);
  uid_        number;
  cid_        varchar2(1024);
  key_        number;
begin
  begin
    select nls,
           nbs
    into   l_nls,
           l_nbs
    from   accounts
    where  acc=p_acc;
    for k in (select id
              from   groups_nbs
              where  nvl(l_nbs,substr(l_nls,1,4)) like trim(nbs)||'%')
    loop
      sec.addAgrp(p_acc,k.id);
    end loop;
  exception when no_data_found then
    null;
  end;
--выдача сообщения (реестр инсайдеров)
  if getglobaloption('BMS')='1' and getglobaloption('RI')='1' then
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
    exception when no_data_found then
      insform_ := null;
    end;
--
    if insform_='0' and prinsider_<>99 then
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
      exception when no_data_found then
        cid_ := null;
      end;
      key_ := S_RI_MESSAGES.NEXTVAL;
      if cid_ is not null then
        begin
          bars_audit.info('bms.enqueue_msg (cen): nmk='||nmk_||', rnk='||to_char(rnk_));
          bms.enqueue_msg('('||to_char(key_)||')'||txt_,
                          dbms_aq.no_delay             ,
                          dbms_aq.never                ,
                          uid_);
          begin
            insert
            into   ri_messages (key    ,
                                id     ,
                                msg    ,
                                datemsg,
                                branch ,
                                rnk    ,
                                desktop)
                        values (key_                                     ,
                                uid_                                     ,
                                '('||to_char(key_)||')'||txt_            ,
                                sysdate                                  ,
                                sys_context('bars_context','user_branch'),
                                rnk_                                     ,
                                'CENTURA');
          end;
        exception when others then
          null;
        end;
      else
        begin
          bars_audit.info('bms.enqueue_msg (WEB): nmk='||nmk_||', rnk='||to_char(rnk_));
          bms.push_msg_web(user_name,
                           '('||to_char(key_)||')'||txt_);
          begin
            insert
            into   ri_messages (key    ,
                                id     ,
                                msg    ,
                                datemsg,
                                branch ,
                                rnk    ,
                                desktop)
                        values (key_                                     ,
                                uid_                                     ,
                                '('||to_char(key_)||')'||txt_            ,
                                sysdate                                  ,
                                sys_context('bars_context','user_branch'),
                                rnk_                                     ,
                                'WEB');
          end;
        exception when others then
          null;
        end;
      end if;
    end if;
  end if;
end;
/
show err;

PROMPT *** Create  grants  P_AFTER_OPEN_ACC ***
grant EXECUTE                                                                on P_AFTER_OPEN_ACC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_AFTER_OPEN_ACC.sql =========*** 
PROMPT ===================================================================================== 
