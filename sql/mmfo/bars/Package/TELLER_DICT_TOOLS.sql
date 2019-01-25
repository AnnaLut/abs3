
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/teller_dict_tools.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.TELLER_DICT_TOOLS is

  -- Author  : VOLODYMYR.POHODA
  -- Created : 21.09.2017 15:17:10
  -- Updated : 11.10.2018
  -- Purpose : Процедури для роботи з довідниками Теллера
  g_package_name constant varchar2(20) := 'TELLER_DICT_TOOLS';


  function get_oper_type (p_op_code in varchar2)
    return varchar2;

  function get_equip_name (p_equip_code in number)
    return varchar2;

  procedure add_workstation_def (p_stationname in varchar2
                                ,p_equip_code  in number
                                ,p_equip_ip    in varchar2
                                ,p_protocol    in varchar2);

  procedure upd_workstation_def (p_stationname in varchar2
                                ,p_equip_code  in number
                                ,p_equip_ip    in varchar2
                                ,p_protocol    in varchar2);

  procedure add_oper_define (p_op_code  in varchar2,
                             p_op_lim   in number,
                             p_eq_ref   in number,
                             p_need_req in varchar2,
                             p_sw_flag  in integer);

  procedure modify_oper_define (p_op_code  in varchar2,
                                p_op_lim   in number,
                                p_eq_ref   in number,
                                p_need_req in varchar2,
                                p_sw_flag  in integer);


  procedure del_oper_define (p_op_code in varchar2,
--                             p_op_cur  in number,
                             p_eq_ref  in number);

--

  procedure add_teller(p_userid     in number,
                       p_branch     in varchar2,
                       p_valid_from in date,
                       p_valid_to   in date
                      ,p_tox         in integer);
--
  procedure upd_teller(p_userid     in number,
                       p_branch     in varchar2,
                       p_valid_from in date,
                       p_valid_to   in date,
                       p_id         in number
                      ,p_tox         in integer);


--
  procedure del_teller(p_id     in number);
--
  procedure add_equip(p_code  in number
                     ,p_name  in varchar2
                     ,p_limit in number
                     ,p_block in integer
                     ,p_type  in varchar2);
--
  procedure upd_equip(p_code  in number
                     ,p_name  in varchar2
                     ,p_limit in number
                     ,p_block in integer
                     ,p_type  in varchar2);


  procedure upd_boss(p_userrole in varchar2,
                     p_priority in number);

  procedure del_boss(p_userrole in varchar2);


end teller_dict_tools;
/
CREATE OR REPLACE PACKAGE BODY BARS.TELLER_DICT_TOOLS is


  function get_tt_id (p_op_code in varchar2)
    return number;

  function get_tt_id (p_op_code in varchar2)
    return number
    is
    v_progname constant varchar2(100) := g_package_name||'.GET_TT_ID';
    v_ret tts.id%type;
    v_err varchar2(2000);
  begin
    select id
      into v_ret
      from tts
      where tt = p_op_code;
    return v_ret;
  exception
    when others then
      v_err := v_progname||'. '||sqlerrm;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
  end get_tt_id;

  function get_oper_type (p_op_code in varchar2)
    return varchar2
    is
    v_ret varchar2(4);
    v_in_flag  integer := 0;
    v_out_flag integer := 0;
    v_int      integer := 0;
  begin
    for r in (select nvl(nlsm,nlsa) nlsa, nvl(nlsk,nlsb) nlsb, tt
                from tts
                where tt = p_op_code
              union
              select nvl(tts.nlsm,tts.nlsa) nlsa, nvl(tts.nlsk,tts.nlsb) nlsb, tts.tt
                from ttsap, tts
                where ttsap.tt = p_op_code
                  and ttsap.ttap = tts.tt)
    loop
      if nvl(r.nlsa,'-') like '%CASH%' then
        v_in_flag := 1;
      end if;
      if nvl(r.nlsb,'-') like '%CASH%' then
        v_out_flag := 1;
      end if;
      if v_in_flag = 1 and v_out_flag = 1 then
        exit;
      end if;
      for q in (select ps_tts.dk, ps_tts.nbs from ps_tts where tt = r.tt)
      loop
        if q.dk = 0 and q.nbs like '100%' then
          v_in_flag := 1;
        elsif q.dk = 1 and q.nbs like '100%' then
          v_out_flag := 1;
        end if;
      end loop;
    end loop;
   if v_in_flag = 1 and v_out_flag = 1 then
     v_ret := 'ALL';
   elsif v_in_flag = 1 and v_out_flag = 0 then
     v_ret := 'IN';
   elsif v_in_flag = 0 and v_out_flag = 1 then
     v_ret := 'OUT';
   else
     v_ret := 'NONE';
   end if;
/*    select  case
             when p_op_code = 'CUV' then 'OUT'
             when p_op_code = 'SBN' then 'IN'
             when p_op_code = 'TOX' then 'NONE'
             when kas_in = 'IN' and kas_out = 'OUT' then 'ALL'
             when kas_in = 'IN' and kas_out is null then 'IN'
             when kas_in is null and kas_out = 'OUT' then 'OUT'
             when kas_in is null and kas_out is null then 'NONE'
           end kas
      into v_ret
      from (select case (select max(1) from ps_tts p where p.tt in (select p_op_code and p.nbs like '100%' and p.dk = 0)
                     when 1 then 'IN'
                     else null
                   end kas_in,
                   case (select max(1) from ps_tts p where p.tt = p_op_code and p.nbs like '100%' and p.dk = 1)
                     when 1 then 'OUT'
                     else null
                   end  kas_out
             from dual t) tt;
    if nvl(v_ret,'NONE') = 'NONE' then
      for r in (select nlsa, nlsb from tts where tt = p_op_code)
      loop
        if nvl(r.nlsa,'-') like '%CASH%' and not nvl(r.nlsb,'-') like '%CASH%' then
          v_ret := 'IN';
        elsif nvl(r.nlsa,'-') like '%CASH%' and nvl(r.nlsb,'-') like '%CASH%' then
          v_ret := 'ALL';
        elsif not nvl(r.nlsa,'-') like '%CASH%' and nvl(r.nlsb,'-') like '%CASH%' then
          v_ret := 'OUT';
        end if;
      end loop;
    end if;*/
    return v_ret;
  exception
    when others then
      bars_audit.info('teller_dict_tools.get_oper_type error :'||sqlerrm);
      return 'NONE';
  end get_oper_type;

  function get_equip_name (p_equip_code in number)
    return varchar2
    is
  begin
    for r in (select ted.equip_name
                from teller_equipment_dict ted
                where ted.equip_code = p_equip_code)
    loop
      return r.equip_name;
    end loop;
    return null;
  end get_equip_name;

  function get_equip_type (p_equip_code in number)
    return varchar2
    is
  begin
    for r in (select ted.equip_type
                from teller_equipment_dict ted
                where ted.equip_code = p_equip_code)
    loop
      return r.equip_type;
    end loop;
    return '?';
  end get_equip_type;

  procedure add_workstation_def (p_stationname in varchar2
                                ,p_equip_code  in number
                                ,p_equip_ip    in varchar2
                                ,p_protocol    in varchar2)
    is
    v_progname constant varchar2(100) := g_package_name ||'.ADD_WORKSTATION_DEF';
    v_num number := 0;
    v_pos varchar2(1) := 'R';
    v_ip   varchar2(20) := p_equip_ip;
  begin
    if get_equip_type (p_equip_code) = 'A' then
      if p_equip_ip is null then
        bars_error.raise_nerror(p_errmod => 'TEL',
                                p_errname => 'TELL_DICT1');
--        raise_application_error(-20001,'Для обладнання вказаного типу необхідно вказати IP-адресу');
      end if;
      for r in (select *
                  from teller_stations ts
                  where ts.equip_ref = p_equip_code
                    and ts.url       = p_equip_ip)
      loop
        v_num := v_num +1;
        if v_num = 2 then
          bars_error.raise_nerror(p_errmod => 'TEL',
                                  p_errname => 'TELL_DICT2',
                                  p_param1 =>  'Обладнання '||get_equip_name(p_equip_code)||'з адресою '||p_equip_ip||'  вже має дві підключені робочі станції');
          --raise_application_error(-20001, v_progname||': Обладнання '||get_equip_name(p_equip_code)||'з адресою '||p_equip_ip||'  вже має дві підключені робочі станції');
        end if;
        
        if r.equip_position = 'R' then 
          v_pos := 'L';
        elsif r.equip_position = 'L' then 
          v_pos := 'R';
        end if;
      end loop;
    else
      v_pos := '';
      v_ip  := null;
    end if;
    insert into teller_stations (station_name,
                                 equip_ref,
                                 url,
                                 equip_position,
                                 c_type)
      values (p_stationname, p_equip_code, v_ip, v_pos, p_protocol);
  end add_workstation_def;

  procedure upd_workstation_def (p_stationname in varchar2
                                ,p_equip_code  in number
                                ,p_equip_ip    in varchar2
                                ,p_protocol    in varchar2)
    is
    v_progname constant varchar2(100) := g_package_name ||'.UPD_WORKSTATION_DEF';
    v_num number := 0;
    v_pos varchar2(1) := 'R';
    v_ip  varchar2(20) := p_equip_ip;
    v_err varchar2(2000);
  begin
    if get_equip_type (p_equip_code) = 'A' then
      if p_equip_ip is null then
        v_err := v_progname||': Для обладнання вказаного типу необхідно вказати IP-адресу';
        bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
      end if;

      for r in (select *
                  from teller_stations ts
                  where ts.equip_ref = p_equip_code
                    and ts.url       = p_equip_ip)
      loop
        v_num := v_num +1;
        if v_num > 2 then
          v_err := v_progname||': Обладнання '||get_equip_name(p_equip_code)||' з адресою '||p_equip_ip||' вже має дві підключені робочі станції';
          bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
        end if;

        if r.equip_position = 'R' then 
          v_pos := 'L';
        elsif r.equip_position = 'L' then 
          v_pos := 'R';
        end if;
      end loop;
    else
      v_pos := '';
      v_ip  := null;
    end if;
    update teller_stations ts
      set ts.equip_ref      = p_equip_code,
          ts.url            = v_ip,
          ts.equip_position = v_pos,
          ts.c_type         = p_protocol
      where ts.station_name = p_stationname;
  end upd_workstation_def;

  procedure add_oper_define (p_op_code  in varchar2,
--                             p_op_cur  in number,
                             p_op_lim   in number,
                             p_eq_ref   in number,
                             p_need_req in varchar2,
                             p_sw_flag  in integer)
  is
    v_progname constant varchar2(100) := g_package_name || '.ADD_OPER_DEFINE';
    v_err      varchar2(2000);
    v_num      number;
    v_need_req varchar2(4) := coalesce(p_need_req,get_oper_type(p_op_code));
    v_sw_flag  integer := p_sw_flag;
  begin

    if p_op_code = 'TOX' then
      v_err := v_progname||': Довідник вже має запис щодо операції [tt = '||p_op_code||'] для обладнання з кодом = '||p_eq_ref;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end if;
    for r in (select 1 from teller_oper_define where oper_code = p_op_code and equip_ref = p_eq_ref)
    loop
      v_err := v_progname||': Довідник вже має запис щодо операції [tt = '||p_op_code||'] для обладнання з кодом = '||p_eq_ref;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end loop;

    if v_sw_flag is null then
      v_sw_flag := case 
                     when p_op_code in ('CN1','CN2','CUV','CNU','CN3','CN4') then 1
                     else 0
                   end;
    end if;
    select ed.equip_limit
      into v_num
      from teller_equipment_dict ed
      where ed.equip_code = p_eq_ref;

    if v_need_req in ('IN','ALL') and v_num < p_op_lim then
      v_err := v_progname||': .Спроба встановити ліміт для операції більше ліміту залику для обладнання';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end if;

    select count(1) into v_num
      from v_teller_need_req_dict vt
      where vt.code = v_need_req;
    if v_num = 0 then
      v_err := v_progname||'.'||'Помилкове значення поля "Ознака касової операції';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end if;


    insert into teller_oper_define (oper_code,
                                    max_amount,
                                    cur_code,
                                    equip_ref,
                                    need_req,
                                    sw_flag)
      values (p_op_code,
              p_op_lim,
              null,
              p_eq_ref,
              v_need_req,
              v_sw_flag
             );

    user_role_utl.grant_tts_to_role(p_role_code => 'RTELLER',
                                    p_tts_code  => p_op_code,
                                    p_approve   => true);

  exception
    when dup_val_on_index then
      v_err := v_progname||'. Операція [tt = '||p_op_code||'] вже присутня в довіднику';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    when others then
      v_err := v_progname||'. Помилка додавання операції [tt = '||p_op_code||'] в довідник операцій теллерів'||sqlerrm;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
  end add_oper_define;

  procedure modify_oper_define (p_op_code  in varchar2,
                                p_op_lim   in number,
                                p_eq_ref   in number,
                                p_need_req in varchar2,
                                p_sw_flag  in integer)
  is
    v_progname constant varchar2(100) := g_package_name || '.MODIFY_OPER_DEFINE';
    v_err      varchar2(2000);
    v_num      number;
    v_need_req varchar2(4) := coalesce(p_need_req,get_oper_type(p_op_code));
  begin

    select ed.equip_limit
      into v_num
      from teller_equipment_dict ed
      where ed.equip_code = p_eq_ref;

    if v_need_req in ('IN','ALL') and v_num < p_op_lim then
      v_err := v_progname||': Спроба встановити ліміт для операції більше ліміту залику для обладнання';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end if;

    select count(1) into v_num
      from v_teller_need_req_dict vt
      where vt.code = v_need_req;
    if v_num = 0 then
      v_err := v_progname||'. Помилкове значення поля "Ознака касової операції';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end if;
    update teller_oper_define
        set max_amount  = p_op_lim,
            need_req    = v_need_req,
            sw_flag     = nvl(p_sw_flag,0)
        where oper_code = p_op_code
          and equip_ref   = p_eq_ref;

  end modify_oper_define;


  procedure del_oper_define (p_op_code in varchar2,
--                             p_op_cur  in number,
                             p_eq_ref  in number)
  is
    v_progname constant varchar2(100) := g_package_name||'.DEL_OPER_DEFINE';
    v_int integer;
  begin
    if p_op_code = 'SBN' then
      bars_error.raise_nerror(p_errmod => 'TEL'
                             ,p_errname => 'TELL_DICT2');
    end if;
    -- удаляем запрашиваемое описание операции
    delete from teller_oper_define
      where oper_code = p_op_code
--        and cur_code  = p_op_cur
        and equip_ref = p_eq_ref;
    select count(1) into v_int
      from teller_oper_define
      where oper_code = p_op_code;
    -- если у нас не осталось больше операций с указанным кодом в доступных операциях теллера, то исключаем эту операцию из роли.
    if v_int = 0 then
      resource_utl.revoke_resource_access(p_grantee_type_id  => resource_utl.get_resource_type_id(user_role_utl.RESOURCE_TYPE_ROLE),
                                          p_grantee_id       => user_role_utl.get_role_id('RTELLER'),
                                          p_resource_type_id => resource_utl.get_resource_type_id('TTS'),
                                          p_resource_id      => get_tt_id(p_op_code),
                                          p_approve          => true);
    end if;
/*  exception
    when others then
      bars_audit.error(v_progname||'. '||sqlerrm);
      raise_application_error(-20100,v_progname||'. '||sqlerrm);*/
  end del_oper_define;

  -- процедура добавления информации о теллере в таблицу. Для вызова из мета-таблиц
  procedure add_teller(p_userid     in number
                      ,p_branch     in varchar2
                      ,p_valid_from in date
                      ,p_valid_to   in date
                      ,p_tox         in integer)
  is
    v_progname varchar2(30) := g_package_name||'.ADD_TELLER';
    v_err varchar2(2000);
  begin
    for r in (select * from teller_users where (nvl(valid_to,sysdate) between p_valid_from and nvl(p_valid_to,sysdate)
                                               or valid_from between p_valid_from and nvl(p_valid_to,sysdate)
                                               or p_valid_from between valid_from and nvl(valid_to,sysdate))
                                           and user_id = p_userid)
    loop
      v_err := v_progname||': Користувач з id = '||p_userid||' вже має запис, період дії якого накладається на вказаний';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end loop;

    insert into teller_users (user_id,
                              user_name,
                              branch,
                              valid_from,
                              valid_to,
                              id,
                              tox_flag)
    select p_userid, s.fio, s.branch, p_valid_from, p_valid_to, s_teller_user_id.nextval, p_tox
      from staff$base s
      where s.id = p_userid
--        and s.branch = p_branch
        ;
    if sql%rowcount  = 0 then
      v_err := v_progname||': Не знайдено користувача з id = '||p_userid||' для бранча '||p_branch;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end if;
  exception
    when others then
      v_err := v_progname||': '||sqlerrm;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
  end;

  -- процедура обвновления  информации о теллере
  procedure upd_teller(p_userid     in number,
                       p_branch     in varchar2,
                       p_valid_from in date,
                       p_valid_to   in date,
                       p_id         in number
                      ,p_tox         in integer)
  is
    v_progname varchar2(30) := g_package_name||'.UPD_TELLER';
    v_err      varchar2(2000);
  begin
    for r in (select *
                from teller_users
                where (nvl(valid_to,sysdate) between p_valid_from and nvl(p_valid_to,sysdate)
                      or valid_from between p_valid_from and nvl(p_valid_to,sysdate)
                      or p_valid_from between valid_from and nvl(valid_to,sysdate))
                  and user_id = p_userid
                  and id != p_id
             )
    loop
      v_err := v_progname||': Користувач з id = '||p_userid||' вже має запис, період дії якого накладається на вказаний';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end loop;

    if nvl(p_valid_to,p_valid_from) <p_valid_from then
      v_err := v_progname||': Дата початку ['||to_char(p_valid_from,'dd.mm.yyyy')||'] не може бути більшою за дату закінчення['||to_char(p_valid_to,'dd.mm.yyyy')||']';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end if;

    update teller_users
      set valid_from = p_valid_from,
          valid_to   = p_valid_to,
          branch     = p_branch,
          tox_flag   = p_tox
      where id = p_id;
  exception
    when others then
      v_err := v_progname||': '||sqlerrm;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
  end upd_teller;


  procedure del_teller(p_id     in number)
    is
    v_progname varchar2(30) := g_package_name||'.DEL_TELLER';
    v_err      varchar2(2000);
  begin
    delete from teller_users
      where id = p_id;
  exception
    when others then
      v_err := v_progname||': '||sqlerrm;
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
  end del_teller;

  procedure add_equip(p_code  in number
                     ,p_name  in varchar2
                     ,p_limit in number
                     ,p_block in integer
                     ,p_type  in varchar2)
    is
  begin
    insert into teller_equipment_dict (equip_code,
                                       equip_name,
                                       equip_limit,
                                       is_blocked,
                                       equip_type)
      values (p_code
             ,p_name
             ,p_limit
             ,p_block
             ,p_type);
  end;

  procedure upd_equip(p_code  in number
                     ,p_name  in varchar2
                     ,p_limit in number
                     ,p_block in integer
                     ,p_type  in varchar2)
    is
    v_curr_lim number;
    v_err      varchar2(2000);
  begin
    for r in (select od.oper_code
                from teller_oper_define od
                  where od.equip_ref = p_code
                    and od.max_amount > p_limit)
    loop
      v_err := 'Ліміт для операції [tt='||r.oper_code||'] більше вказанного ліміта для обладнання';
      bars_error.raise_nerror(p_errmod => 'TEL',p_errname => 'TELL_DICT2',p_param1 => v_err);
    end loop;

    select equip_limit into v_curr_lim
      from teller_equipment_dict
      where equip_code = p_code;

    update teller_equipment_dict
      set equip_name  = p_name
         ,equip_limit = p_limit
         ,is_blocked  = p_block
         ,equip_type  = p_type
      where equip_code = p_code;
  end;

  procedure upd_boss(p_userrole in varchar2,
                     p_priority in number)
    is
  begin
    merge into teller_boss_roles br
      using (select p_userrole userrole, p_priority priority from dual) parm
      on (br.userrole = parm.userrole)
      when matched then update 
        set priority  = parm.priority
      when not matched then insert (userrole, priority)
        values (parm.userrole, parm.priority);
  end upd_boss;
  
  procedure del_boss (p_userrole in varchar2)
    is
  begin
    delete from teller_boss_roles where userrole = p_userrole;
  end del_boss;
end teller_dict_tools;
/
 show err;
 
PROMPT *** Create  grants  TELLER_DICT_TOOLS ***
grant EXECUTE                                                                on TELLER_DICT_TOOLS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TELLER_DICT_TOOLS to BARS_ACCESS_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/teller_dict_tools.sql =========*** E
 PROMPT ===================================================================================== 
 