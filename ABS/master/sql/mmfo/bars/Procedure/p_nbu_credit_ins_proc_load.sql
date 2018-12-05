create or replace procedure p_nbu_credit_ins_proc_load (p_User           in int,
                                                       p_branch          in varchar2,
                                                       p_file_id         in NBU_CREDIT_INSURANCE_FILES.ID%type)
is
  title            varchar2(100) := 'p_nbu_credit_ins_proc_load';
  l_state          NBU_CREDIT_INSURANCE.STATE%TYPE;
  l_MESSAGE        NBU_CREDIT_INSURANCE.MESSAGE%TYPE;
  type l_req is record
   (
      kf1     varchar2 (6),
      nd1     NUMBER   (22),
      nls1    VARCHAR2 (15),
      kf2     varchar2 (6),
      nd2     NUMBER   (22),
      nls2    VARCHAR2 (15),
      acc2    NUMBER   (38),
      dazs    date,
      numb    NUMBER   (38)
   );

  type l_req_set is table of l_req;
  l_tab     l_req_set := l_req_set ();

begin
   bars.bars_login.login_user(sys_guid,p_User,null,null);
   bars.bc.go(p_branch);
   savepoint before_job_start;

  begin
    update NBU_CREDIT_INSURANCE_FILES F
    set f.state = 1
    where f.id = p_file_id
      and f.state <> 1;
    if sql%rowcount = 0 then
      raise_application_error(-20001,'Даний файл вже оброблено!');
    end if;
  end;

for cur in ( /*select distinct n.kf from  NBU_CREDIT_INSURANCE n where n.pid = p_file_id */
              select r.* from regions r where (r.kf=substr(p_branch,2,6) or p_branch = '/'))
loop
  bc.go(cur.kf);

            with tt as
             (  SELECT /*+ LEADING (B, W, A) INDEX(W PK_W4ACC)*/
               W.ND, A.NLS, A.KV, W.KF
                FROM BPK_PARAMETERS B, W4_ACC W, ACCOUNTS A
               WHERE B.TAG = 'FLAGINSURANCE'
                 AND B.KF = cur.kf
                 AND W.KF = B.KF
                 AND W.ND = B.ND
                 AND A.KF = W.KF
                 AND A.ACC = W.ACC_PK),
            i as
             (select i.kf, i.nd, i.nls, i.kv, a.acc, a.dazs, i.numb
                from NBU_CREDIT_INSURANCE i
                left join accounts a
                  on a.kf = i.kf
                 and a.nls = i.nls
                 and a.kv = i.kv
               where i.pid = p_file_id
                 and i.kf = cur.kf)

            select tt.kf,
                   tt.nd,
                   tt.nls,
                   i.kf,
                   i.nd,
                   i.nls,
                   i.acc,
                   i.dazs,
                   i.numb
              bulk collect
              into l_tab
              from tt
              full join i
                on i.kf = tt.kf
               and i.nd = tt.nd
               and i.kv = tt.kv
             where tt.nd is null
                or i.nd is null;

     if  l_tab is not empty then
     for j in l_tab.first .. l_tab.last
     loop
       begin
         if l_tab(j).nd1 is not null then   --лишнее, чистим
              bars_ow.set_bpk_parameter(p_nd    => l_tab(j).nd1,
                                        p_tag   => 'FLAGINSURANCE',
                                        p_value => null);
         elsif  l_tab(j).acc2 is null then
           l_state   := 2;
           l_MESSAGE :='Рахунок відсутній в системі';
         elsif l_tab(j).dazs is not null then
           l_state   := 2;
           l_MESSAGE :='Рахунок закрито';
         else
          bars_ow.set_bpk_parameter(p_nd    => l_tab(j).nd2,
                                        p_tag   => 'FLAGINSURANCE',
                                        p_value => 1);
           l_state   := 1;
           l_MESSAGE :=null;
         end if;
/*       exception when others then
         l_state   := 2;
         l_MESSAGE:= substr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(),1,1000);*/
       end;
       if l_tab(j).nd2 is not null then
         update  NBU_CREDIT_INSURANCE i
         set i.state   = l_state,
             i.message = l_MESSAGE
         where i.pid  = p_file_id
           and i.kf = cur.kf
           and i.nd = l_tab(j).nd2 ;
       end if;    
     end loop;
     end if;

  begin --всем остальным строкам, которые не поменялись ставим "Обработано"
       update NBU_CREDIT_INSURANCE i
       set i.state   = 1
       where i.pid  = p_file_id
         and i.kf = cur.kf
         and i.state = 0;
  end;
end loop;
   bms.enqueue_msg( 'Обробку реєстру користувача'|| p_User|| ' ЗАВЕРШЕНО ! Перегляньте результат ' , dbms_aq.no_delay, dbms_aq.never, p_User );
   bars.bars_login.logout_user;
exception when others then
   rollback to savepoint before_job_start;
   bms.enqueue_msg( 'Обробку реєстру користувача '|| p_User|| ' ЗАВЕРШЕНО З ПОМИЛКОЮ! -'|| dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() , dbms_aq.no_delay, dbms_aq.never, p_User );
   bars.bars_login.logout_user;
end;
/
