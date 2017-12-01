CREATE OR REPLACE PROCEDURE rnk2rnk -- передача данных одного клиента другому
  (p_rnkfrom varchar2, -- от кого
   p_rnkto   varchar2  -- кому
-- p_dateoff date default trunc(sysdate)
   --ver 2.01 07.06.2017
   )
is
  type            cur is ref cursor;
  cur_            cur;
  sql_            varchar2(32000);
  acc_            number;
  dateoff_        date;
  dazs_           varchar2(32);
  dapp_           varchar2(32);
  nls_            varchar2(15);
  kv_             number;
  cnt_            int;
  rowid_          varchar2(128);
  fil_            varchar2(32000);
  column_name_    varchar2(128);
  custtfrom_      number(1);
  custtto_        number(1);
  sedfrom_        char(4);
  sedto_          char(4);
  okpofrom_       customer.okpo%type;
  okpoto_         customer.okpo%type;
  serfrom_        person.ser%type;
  serto_          person.ser%type;
  numdocfrom_     person.numdoc%type;
  numdocto_       person.numdoc%type;
  sexfrom_        person.sex%type;
  sexto_          person.sex%type;
  codcagentfrom_  customer.codcagent%type;
  codcagentto_    customer.codcagent%type;
  nmkfrom_        customer.nmk%type;
  nmkto_          customer.nmk%type;
  passpfrom_      person.passp%type;
  passpto_        person.passp%type;
  tip_            accounts.tip%type;
  nbs_            accounts.nbs%type;
  type t_arr is table of deal.id%type;
  v_data t_arr;
  l_dkbo_deal     deal.id%type;
  l_dkbo_acc_list  number_list;
  l_acc_list_union number_list;
  lc_acc_list      CONSTANT attribute_kind.attribute_code%TYPE := 'DKBO_ACC_LIST';
begin

  begin
    if to_char(to_number(p_rnkfrom))<>p_rnkfrom then
      raise_application_error(-(20720), 'RNK2RNK: реєстраційний номер '||p_rnkfrom||' неприпустимий.',TRUE);
    end if;
  exception when OTHERS then
    raise_application_error(-(20710), 'RNK2RNK: реєстраційний номер '||p_rnkfrom||' неприпустимий.',TRUE);
  end;

  begin
    if to_char(to_number(p_rnkto))<>p_rnkto then
      raise_application_error(-(20721), 'RNK2RNK: реєстраційний номер '||p_rnkto||' неприпустимий.',TRUE);
    end if;
  exception when OTHERS then
    raise_application_error(-(20711), 'RNK2RNK: реєстраційний номер '||p_rnkto||' неприпустимий.',TRUE);
  end;

  if p_rnkfrom=p_rnkto then
    raise_application_error(-(20712), 'RNK2RNK: неприпустимо '||p_rnkfrom||'='||p_rnkto,TRUE);
  end if;

  if length(sys_context('bars_context','user_branch'))=22 then
    begin
      select acc
      into   acc_
      from   (select acc
              from   accounts
              where  rnk=p_rnkfrom and
                     dazs is null
              minus
              select acc
              from   v_gl
              where  rnk=p_rnkfrom and
                     dazs is null)
      where rownum<2;
      raise_application_error(-(20713), 'RNK2RNK: у клієнта '||p_rnkfrom||' є незакриті рахунки в іншому бранчі. Зверніться вище.',TRUE);
    exception when no_data_found then
      null;
    end;
  end if;

  begin
    select c.date_off ,
           c.custtype ,
           c.sed      ,
           c.okpo     ,
           c.nmk      ,
           c.codcagent,
           p.ser      ,
           p.passp    ,
           p.numdoc   ,
           p.sex
    into   dateoff_      ,
           custtfrom_    ,
           sedfrom_      ,
           okpofrom_     ,
           nmkfrom_      ,
           codcagentfrom_,
           serfrom_      ,
           passpfrom_    ,
           numdocfrom_   ,
           sexfrom_
    from   customer c,
           person   p
    where  c.rnk=to_number(p_rnkfrom) and
           p.rnk(+)=c.rnk;
    if dateoff_ is not null then
      raise_application_error(-(20714), 'RNK2RNK: Клієнт '||p_rnkfrom||' закритий.',TRUE);
    end if;
  exception when no_data_found then
    raise_application_error(-(20715), 'RNK2RNK: Клієнт '||p_rnkfrom||' відсутній.',TRUE);
  end;

  begin
    select c.date_off ,
           c.custtype ,
           c.sed      ,
           c.okpo     ,
           c.nmk      ,
           c.codcagent,
           p.ser      ,
           p.passp    ,
           p.numdoc   ,
           p.sex
    into   dateoff_    ,
           custtto_    ,
           sedto_      ,
           okpoto_     ,
           nmkto_      ,
           codcagentto_,
           serto_      ,
           passpto_    ,
           numdocto_   ,
           sexto_
    from   customer c,
           person   p
    where  c.rnk=to_number(p_rnkto) and
           p.rnk(+)=c.rnk;
    if dateoff_ is not null then
      raise_application_error(-(20716), 'RNK2RNK: Клієнт '||p_rnkto||' закритий.',TRUE);
    end if;
  exception when no_data_found then
    raise_application_error(-(20717), 'RNK2RNK: Клієнт '||p_rnkto||' відсутній.',TRUE);
  end;

  if custtfrom_!=custtto_ then
    raise_application_error(-(20718), 'RNK2RNK: Різні типи клієнтів. Злиття неможливе.',TRUE);
  end if;

  if custtfrom_=3 and sedfrom_!=sedto_ and (sedto_='91  ' or sedfrom_='91  ') then
    raise_application_error(-(20719), 'RNK2RNK: Різні види клієнтів. Злиття неможливе.',TRUE);
  end if;

--выбраны ИНН, серию и номер паспорта, пол клиентов from и to
--выбраны резидентность, ФИО и вид документа клиента to

--сдача анализов клиента (физ.лица)
  if custtto_=3 then
    if serfrom_<>serto_ then
      raise_application_error(-(20722), 'RNK2RNK: Різні серії паспорта. Злиття неможливе.',TRUE);
    end if;
    if numdocfrom_<>numdocto_ then
      raise_application_error(-(20723), 'RNK2RNK: Різні номери паспорта. Злиття неможливе.',TRUE);
    end if;
    if length(okpofrom_)>=8 and instr(okpofrom_,'12345678')=0 and
       f_amorep(okpofrom_)<5 and okpofrom_<>okpoto_ then
      raise_application_error(-(20724), 'RNK2RNK: Різні ІПН. Злиття неможливе.',TRUE);
    end if;
    if length(okpofrom_)>=8 and instr(okpofrom_,'12345678')=0 and
       f_amorep(okpofrom_)<5 and nvl(sexfrom_,'0')!='0' and sexfrom_<>sexto_ then
      raise_application_error(-(20725), 'RNK2RNK: Різна стать. Злиття неможливе.',TRUE);
    end if;
    if codcagentto_ in (1,3,5) then
      if length(okpoto_)=10 and okpoto_<>'0000000000' then
        if substr(okpoto_,1,1)=substr(okpoto_,2,1) and
           substr(okpoto_,1,1)=substr(okpoto_,3,1) and
           substr(okpoto_,1,1)=substr(okpoto_,4,1) and
           substr(okpoto_,1,1)=substr(okpoto_,5,1) and
           substr(okpoto_,1,1)=substr(okpoto_,6,1) and
           substr(okpoto_,1,1)=substr(okpoto_,7,1) and
           substr(okpoto_,1,1)=substr(okpoto_,8,1) and
           substr(okpoto_,1,1)=substr(okpoto_,9,1) and
           substr(okpoto_,1,1)=substr(okpoto_,10,1) then
          raise_application_error(-(20726), 'RNK2RNK: Помилковий ІПН клієнта ''||p_rnkto||''. Злиття неможливе.',TRUE);
        end if;
      end if;
    end if;
    if codcagentto_ in (2,4,6) then
      if length(okpoto_)=9 and okpoto_<>'000000000' then
        if substr(okpoto_,1,1)=substr(okpoto_,2,1) and
           substr(okpoto_,1,1)=substr(okpoto_,3,1) and
           substr(okpoto_,1,1)=substr(okpoto_,4,1) and
           substr(okpoto_,1,1)=substr(okpoto_,5,1) and
           substr(okpoto_,1,1)=substr(okpoto_,6,1) and
           substr(okpoto_,1,1)=substr(okpoto_,7,1) and
           substr(okpoto_,1,1)=substr(okpoto_,8,1) and
           substr(okpoto_,1,1)=substr(okpoto_,9,1) then
          raise_application_error(-(20727), 'RNK2RNK: Помилковий ІПН клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
        end if;
      end if;
    end if;
    if nvl(length(trim(okpoto_)),0)=0 then
      raise_application_error(-(20728), 'RNK2RNK: Порожній ІПН клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
    end if;
    if not valid_fio(nmkto_) then
      raise_application_error(-(20729), 'RNK2RNK: Помилкове ПІБ клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
    end if;
    if passpto_=1 then
      if serto_ is null then
        raise_application_error(-(20730), 'RNK2RNK: Відсутня серія паспорта клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
      end if;
      if numdocto_ is null then
        raise_application_error(-(20731), 'RNK2RNK: Відсутній номер паспорта клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
      end if;
      if length(trim(serto_))<>2 or not
         ((substr(trim(serto_),1,1)>='А' and substr(trim(serto_),1,1)<='Я') or
          (substr(trim(serto_),2,1)>='А' and substr(trim(serto_),2,1)<='Я') or
          substr(trim(serto_),1,1)='І' or substr(trim(serto_),1,1)='Є' or
          substr(trim(serto_),1,1)='Ї' or substr(trim(serto_),1,1)='Ґ' or
          substr(trim(serto_),2,1)='І' or substr(trim(serto_),2,1)='Є' or
          substr(trim(serto_),2,1)='Ї' or substr(trim(serto_),2,1)='Ґ') then
        raise_application_error(-(20732), 'RNK2RNK: Помилкова серія паспорта клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
      end if;
      if length(trim(numdocto_))<>6 or not isnumber(trim(numdocto_)) then
        raise_application_error(-(20733), 'RNK2RNK: Помилковий номер паспорта клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
      end if;
    end if;
    if nmkto_<>upper(nmkto_) then
      raise_application_error(-(20734), 'RNK2RNK: Помилкове (мале) ПІБ клієнта '||p_rnkto||'. Злиття неможливе.',TRUE);
    end if;
  end if;

--Fin_ND   COBUSUPABS-2661
-- із-за ручної зміни РНК
  begin
    delete
    from   fin_nd t
    where  rnk in (to_number(p_rnkfrom),to_number(p_rnkto))                 and
           nd>0                                                             and
           exists (select 1
                   from   v_fin_cc_deal
                   where  nd=t.nd and
                          rnk in (to_number(p_rnkfrom),to_number(p_rnkto))) and
           not exists (select 1
                       from   v_fin_cc_deal
                       where  nd=t.nd and
                              rnk=t.rnk);
    update fin_nd t
    set    rnk=to_number(p_rnkto)
    where  rnk=to_number(p_rnkfrom) and
           nd>0                     and
           exists (select 1
                   from   v_fin_cc_deal
                   where  nd=t.nd and
                          rnk=to_number(p_rnkfrom));
  exception when OTHERS then
    raise_application_error(-(20737), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
  end;

  begin
    delete fin_nd_update t
    where  rnk in (to_number(p_rnkfrom),to_number(p_rnkto))          and
           nd>0                                                      and
           exists (select 1
                   from   v_fin_cc_deal
                   where  nd=t.nd and
                   rnk in (to_number(p_rnkfrom),to_number(p_rnkto))) and
           not exists (select 1
                       from   v_fin_cc_deal
                       where  nd=t.nd and
                              rnk=t.rnk);
    update fin_nd_update t
    set    rnk=to_number(p_rnkto)
    where  rnk=to_number(p_rnkfrom) and
           nd>0                     and
           exists (select 1
                   from   v_fin_cc_deal
                   where  nd=t.nd and
                          rnk=to_number(p_rnkfrom));
  exception when OTHERS then
    raise_application_error(-(20737), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
  end;

--tokf;

  delete
  from   CUSTOMERW
  where  rnk=to_number(p_rnkto) and
         value is null;

  for k in (select c.table_name,
                   c.column_name
            from   user_cons_columns c ,
                   user_constraints  s1,
                   user_constraints  s2
            where  s1.constraint_type='P'                  and
                   s1.table_name='CUSTOMER'                and
                   s2.r_constraint_name=s1.constraint_name and
                   c.constraint_name=s2.constraint_name)
  loop
    begin
      if k.table_name='ACCOUNTS' then
        cnt_ := 0;
        sql_ := 'select nls                         ,
                        kv                          ,
                        acc                         ,
                        to_char(dazs,''DD/MM/YYYY''),
                        to_char(dapp,''DD/MM/YYYY''),
                        tip                         ,
                        nbs
                 from   accounts
                 where  rnk='||p_rnkfrom;
        open cur_ for sql_;
        loop
          fetch cur_ into nls_ ,
                          kv_  ,
                          acc_ ,
                          dazs_,
                          dapp_,
                          tip_,
                          nbs_;
          exit when cur_%notfound;
          if dazs_ is null then
            begin
                  execute immediate 'update accounts
                                     set    rnk='||p_rnkto||'
                                     where  acc='||to_char(acc_);  
              if nbs_ = '2625' then
                  for cur2 in -- и неважно, открыт или закрыт deal. Все равно забираем счет и присоединяем к другому, ведь счет открыт
                         (select d.id from attribute_values avs
                         JOIN (select  max(t.nested_table_id) keep (dense_rank last order by t.value_date) nested_table_id ,
                                       t.object_id,
                                       t.attribute_id
                                from ATTRIBUTE_VALUE_BY_DATE t where t.attribute_id =
                                                                              (SELECT ak.id
                                                                                 FROM attribute_kind ak
                                                                                WHERE ak.attribute_code = 'DKBO_ACC_LIST')
                                group by t.object_id, t.attribute_id)  av   on av.nested_table_id=avs.nested_table_id
                        JOIN deal d                ON d.id = av.object_id AND d.deal_type_id IN (SELECT tt.id FROM object_type tt WHERE tt.type_code = 'DKBO')
                        where d.customer_id      = p_rnkfrom
                          and avs.number_values  = acc_)
                  loop

                  --Визначаємо всі рахунки клієнта ,включені в ДКБО
                  l_dkbo_acc_list  := bars.attribute_utl.get_number_values(p_object_id      => cur2.id
                                                                          ,p_attribute_code => lc_acc_list);

                  l_acc_list_union := l_dkbo_acc_list MULTISET EXCEPT DISTINCT number_list(acc_);

                  bars.attribute_utl.set_value(p_object_id      => cur2.id
                                              ,p_attribute_code => lc_acc_list
                                              ,p_values         => l_acc_list_union);

                    --присоединяем счет к ДКБО
                    pkg_dkbo_utl.p_acc_map_to_dkbo(in_customer_id => p_rnkto,
                                                   in_acc_list    => number_list(acc_),
                                                   out_deal_id    => l_dkbo_deal);
                    --пишем в историю переноса
                                insert
                                into   rnk2deal_acc (rnkfrom,
                                                rnkto  ,
                                                sdate  ,
                                                deal_from     ,
                                                deal_to      ,
                                                acc ,
                                                id)
                                        values (to_number(p_rnkfrom),
                                                to_number(p_rnkto)  ,
                                                sysdate             ,
                                                cur2.id           ,
                                                l_dkbo_deal         ,
                                                acc_                ,
                                                user_id);
                  end loop;
              end if;
            exception when OTHERS then
              raise_application_error(-(20735), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
          else
            begin
              execute immediate 'update accounts
                                 set    dapp=null
                                 where  acc='||to_char(acc_);
            exception when OTHERS then
              raise_application_error(-(20736), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
            begin
              execute immediate 'update accounts
                                 set    tip=''ODB''
                                 where  acc='||to_char(acc_);
            exception when OTHERS then
              raise_application_error(-(20737), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
--
/*            begin
              execute immediate 'alter trigger TBU_ACCOUNTS_DAZS disable';
            exception when OTHERS then
              raise_application_error(-(20743), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;*/
--
            dbms_application_info.set_action('rnk2rnk');
            begin
              execute immediate 'update accounts
                                 set    dazs=null
                                 where  acc='||to_char(acc_);
            exception when OTHERS then
/*              begin
                dbms_utility.exec_ddl_statement('alter trigger TBU_ACCOUNTS_DAZS enable');
              exception when OTHERS then
                raise_application_error(-(20744), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
              end;*/
              dbms_application_info.set_action(null);
              raise_application_error(-(20738), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
            dbms_application_info.set_action(null);
--
/*            begin
              dbms_utility.exec_ddl_statement('alter trigger TBU_ACCOUNTS_DAZS enable');
            exception when OTHERS then
              raise_application_error(-(20744), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;*/
--
            begin
              execute immediate 'update accounts
                                 set    tip='''||tip_||'''
                                 where  acc='||to_char(acc_);
            exception when OTHERS then
              raise_application_error(-(20739), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
            begin
              execute immediate 'update accounts
                                 set    rnk='||p_rnkto||'
                                 where  acc='||to_char(acc_);
            exception when OTHERS then
              raise_application_error(-(20740), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
--            bars_audit.info('RNK2RNK: dazs_='||dazs_||', acc='||acc_);
--            execute immediate "update accounts
--                               set    dazs="||to_date(dazs_,'DD/MM/YYYY')||"
--                               where  acc="||to_char(acc_);
            begin
              update accounts
              set    dazs=to_date(dazs_,'DD/MM/YYYY')
              where  acc=acc_;
            exception when OTHERS then
              raise_application_error(-(20741), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
            begin
              update accounts
              set    dapp=to_date(dapp_,'DD/MM/YYYY')
              where  acc=acc_;
            exception when OTHERS then
              raise_application_error(-(20742), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
            end;
          end if;
          cnt_ := cnt_ + 1;
          insert
          into   rnk2nls (rnkfrom,
                          rnkto  ,
                          sdate  ,
                          nls    ,
                          kv     ,
                          id)
                  values (to_number(p_rnkfrom),
                          to_number(p_rnkto)  ,
                          sysdate             ,
                          nls_                ,
                          kv_                 ,
                          user_id);
        end loop;
        close cur_;
        if cnt_>0 then
          insert
          into   rnk2tbl (rnkfrom,
                          rnkto  ,
                          tbl    ,
                          cnt    ,
                          sdate  ,
                          id)
                  values (to_number(p_rnkfrom),
                          to_number(p_rnkto)  ,
                          'ACCOUNTS'          ,
                          cnt_                ,
                          sysdate             ,
                          user_id);
        end if;
      elsif k.table_name<>'CUSTOMER_RISK' then
--      bars_audit.info('update '||k.table_name||' set '||k.column_name||'='||p_rnkto||' where '||k.column_name||'='||p_rnkfrom);

        cnt_ := 0;

        fil_ := '';
        sql_ := 'select column_name
                 from   user_tab_columns
                 where  table_name='''||k.table_name||'''
                 order  by column_id';
        open cur_ for sql_;
        loop
          fetch cur_ into column_name_;
          exit when cur_%notfound;

          if column_name_=k.column_name then
            fil_ := fil_||p_rnkto||',';
          else
            fil_ := fil_||column_name_||',';
          end if;
        end loop;
        close cur_;
        fil_ := substr(fil_,1,length(fil_)-1);

        begin

          sql_ := 'select rowid
                   from   '||k.table_name||'
                   where  '||k.column_name||'='||p_rnkfrom;
          open cur_ for sql_;
          loop
            fetch cur_ into rowid_;
            exit when cur_%notfound;

            begin
--            bars_audit.info('insert into (-) '||k.table_name||' select '||fil_||' from '||k.table_name||' where rowid='''||rowid_||'''');
              execute immediate 'insert into '||k.table_name||'
                                      select '||fil_||'
                                      from   '||k.table_name||'
                                      where  rowid='''||rowid_||'''';
              cnt_ := cnt_ + 1;
--            bars_audit.info('insert into (+) '||k.table_name||' select '||fil_||' from '||k.table_name||' where rowid='''||rowid_||'''');
            exception when others then
              if substr(k.table_name,1,4) in ('DPT_','DPU_') then
                begin
                  execute immediate 'update '||k.table_name||'
                                     set    '||k.column_name||'='||p_rnkto||'
                                     where  rowid='''||rowid_||'''';
                  cnt_ := cnt_ + 1;
--                bars_audit.info('update '||k.table_name||' set '||k.column_name||'='||p_rnkto||' where rowid='''||rowid_||'''');
                exception when others then
--                bars_audit.info(k.table_name||' ERROR rowid='''||rowid_||'''');
                  null;
                end;
              end if;
            end;
          end loop;
          close cur_;
        end;

--      execute immediate 'delete
--                         from   '||k.table_name||'
--                         where  '||k.column_name||'='||p_rnkto;
--      execute immediate 'update '||k.table_name||'
--                         set    '||k.column_name||'='||p_rnkto||'
--                         where  '||k.column_name||'='||p_rnkfrom;
--      cnt_ := sql%rowcount;
        if cnt_>0 then
          insert
          into   rnk2tbl (rnkfrom,
                          rnkto  ,
                          tbl    ,
                          cnt    ,
                          sdate  ,
                          id)
                  values (to_number(p_rnkfrom),
                          to_number(p_rnkto)  ,
                          k.table_name        ,
                          cnt_                ,
                          sysdate             ,
                          user_id);
        end if;
      end if;
    end;
  end loop;


  begin
    update customer
    set    date_off=trunc(sysdate) -- p_dateoff
    where  rnk=to_number(p_rnkfrom);
  exception when OTHERS then
    raise_application_error(-(20737), 'RNK2RNK: помилка - '||sqlerrm,TRUE);
  end;

--toroot;

  commit;

  bars_audit.info('RNK2RNK: дані клієнта '||p_rnkfrom||' передані клієнту '||p_rnkto);

end rnk2rnk;
/
