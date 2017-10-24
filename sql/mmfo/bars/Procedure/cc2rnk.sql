

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CC2RNK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CC2RNK ***

  CREATE OR REPLACE PROCEDURE BARS.CC2RNK -- передача rnk кредитного договора
  (p_dblink  varchar2, -- DB LINK
   p_rnkold  int     , -- RNK old (из базы DB LINK)
   p_rnknew  out int   -- RNK new
   )
is

  l_rnkto             varchar2(32);
  l_rnkfrom           varchar2(32);
  l_okpo              varchar2(32);
  type                cur is ref cursor;
  cur_                cur;
  sql_                varchar2(32000);
  fil_                varchar2(32000);
  ins_                varchar2(32000);
--acc_                number;
--dateoff_            date;
--dazs_               varchar2(32);
--dapp_               varchar2(32);
--nls_                varchar2(15);
--kv_                 number;
  cnt_                int;
  rowid_              varchar2(128);
  column_name_        varchar2(128);
--custtfrom_          number(1);
--custtto_            number(1);
--sedfrom_            char(4);
--sedto_              char(4);
--okpofrom_           customer.okpo%type;
--okpoto_             customer.okpo%type;
--serfrom_            person.ser%type;
--serto_              person.ser%type;
--numdocfrom_         person.numdoc%type;
--numdocto_           person.numdoc%type;
--sexfrom_            person.sex%type;
--sexto_              person.sex%type;
--codcagentfrom_      customer.codcagent%type;
--codcagentto_        customer.codcagent%type;
--nmkfrom_            customer.nmk%type;
--nmkto_              customer.nmk%type;
--passpfrom_          person.passp%type;
--passpto_            person.passp%type;
--tip_                accounts.tip%type;

  l_id                int;
  l_RNK               customer_rel.RNK%type;
  l_REL_ID            customer_rel.REL_ID%type;
  l_REL_RNK           customer_rel.REL_RNK%type;
  l_REL_INTEXT        customer_rel.REL_INTEXT%type;
  l_VAGA1             customer_rel.VAGA1%type;
  l_VAGA2             customer_rel.VAGA2%type;
  l_TYPE_ID           customer_rel.TYPE_ID%type;
  l_POSITION          customer_rel.POSITION%type;
  l_FIRST_NAME        customer_rel.FIRST_NAME%type;
  l_MIDDLE_NAME       customer_rel.MIDDLE_NAME%type;
  l_LAST_NAME         customer_rel.LAST_NAME%type;
  l_DOCUMENT_TYPE_ID  customer_rel.DOCUMENT_TYPE_ID%type;
  l_DOCUMENT          customer_rel.DOCUMENT%type;
  l_TRUST_REGNUM      customer_rel.TRUST_REGNUM%type;
  l_TRUST_REGDAT      customer_rel.TRUST_REGDAT%type;
  l_BDATE             customer_rel.BDATE%type;
  l_EDATE             customer_rel.EDATE%type;
  l_NOTARY_NAME       customer_rel.NOTARY_NAME%type;
  l_NOTARY_REGION     customer_rel.NOTARY_REGION%type;
  l_SIGN_PRIVS        customer_rel.SIGN_PRIVS%type;
  l_SIGN_ID           customer_rel.SIGN_ID%type;
  l_NAME_R            customer_rel.NAME_R%type;
  l_sql               varchar2(32000);
  l_mfo               varchar2(16);

begin

  begin
    execute immediate 'begin
                         bars_login.login_user@'||p_dblink||'(null,null,null,null);
                       end;';
  exception when others then
    p_rnknew := null;
    bars_audit.error('CC2rnk: bars_login.login_user@'||p_dblink||
                     '(null,null,null,null)'||chr(13)||chr(10)||
                     sqlerrm||chr(13)||chr(10)||
                     replace(dbms_utility.format_error_backtrace,chr(10),chr(13)||chr(10)));
    return;
  end;

--begin
--  execute immediate 'select to_char(rnk)
--                     from   cc_deal@'||p_dblink||'
--                     where  nd='||to_char(p_ccnd)
--                     into   l_rnkfrom;
--exception when others then
--  p_rnknew := null;
--  return;
--end;

  l_rnkfrom := to_char(p_rnkold);

--анализ на существование клиента с кодом ОКПО базы РУ

  begin
    execute immediate 'select nullif(nullif(okpo,''0000000000''),''000000000'')
                       from   customer@'||p_dblink||'
                       where  rnk='||l_rnkfrom
                       into   l_okpo;
  exception when no_data_found then
    l_okpo := null;
  end;

  if l_okpo is not null then
    begin
      select rnk
      into   l_rnkto
      from   customer
      where  okpo=l_okpo and
             date_off is null and
             rownum<2;
      bars_audit.info('CC2rnk: ОКПО already exists (from '||l_rnkfrom||' to '||l_rnkto||')');
      p_rnknew := to_number(l_rnkto);
      return;
    exception when no_data_found then
      null;
    end;
  end if;
  l_rnkto := to_char(bars_sqnc.get_nextval('S_CUSTOMER'));

--

  bars_audit.info('CC2rnk: begin (from '||l_rnkfrom||' to '||l_rnkto||')');

  for k in (select 'CUSTOMER' table_name,
                   'RNK'      column_name from dual
            union all
            select 'FIN_ND',
                   'RNK'                  from dual
            union all
            select 'FINMON_PUBLIC_CUSTOMERS',
                   'RNK'                  from dual
            union all
            select 'FM_KLIENT',
                   'RNK'                  from dual
            union all
            select 'FM_TURN_ARC',
                   'RNK'                  from dual
            union all
            select c.table_name,
                   c.column_name
            from   user_cons_columns c ,
                   user_constraints  s1,
                   user_constraints  s2
            where  s1.constraint_type='P'                  and
                   s1.table_name='CUSTOMER'                and
                   s2.r_constraint_name=s1.constraint_name and
                   c.constraint_name=s2.constraint_name
--                                                         and
--                 not exists (select 1
--                             from   user_cons_columns ca ,
--                                    user_constraints  s1a,
--                                    user_constraints  s2a
--                             where  s1a.constraint_type='P'                   and
--                                    s1a.table_name=c.table_name               and
--                                    s2a.r_constraint_name=s1a.constraint_name and
--                                    ca.constraint_name=s2a.constraint_name)
--          order by 1 desc
           )
  loop
    begin
--    таблицы, которые НЕ НАДО мигрировать
      if k.table_name not in ('ACC_BALANCE_CHANGES'  ,
                              'ACC_MSG'              ,
                              'ACCOUNTS'             ,
                              'BPK_IMP_PROECT_DATA'  ,
                              'CC_SWTRACE'           ,
                              'CIG_EVENTS'           ,
                              'CIM_ACTS'             ,
                              'CIM_BORG_MESSAGE'     ,
                              'CIM_BOUND_DATA'       ,
                              'CIM_CONTRACTS'        ,
                              'CIM_FANTOM_PAYMENTS'  ,
                              'CIM_VMD_BOUND_DATA'   ,
                              'CIN_CUST'             ,
                              'CM_CLIENT_QUE'        ,
                              'CONTRACT_P'           ,
                              'CONTRACTS_ALIEN'      ,
                              'CP_DT'                ,
                              'CP_EMIW'              ,
                              'CP_KOD'               ,
                              'CUST_NAL'             ,
                              'CUST_REQUESTS'        ,
                              'CUST_ZAY'             ,
                              'CUSTBANK'             ,
                              'CUSTCOUNT'            ,
                              'CUSTOMER_REL'         ,
                              'CUSTOMER_UPDATE'      ,
                              'CUSTOMERP'            ,
                              'CUSTOMERW_UPDATE'     ,
                              'E_DEAL$BASE'          ,
                              'EAD_DOCS'             ,
                              'FIN_ND'               ,
                              'FIN_ND_UPDATE'        ,
                              'FINMON_QUE'           ,
                              'FX_DEAL_ACC'          ,
                              'GRT_DEALS'            ,
                              'INS_DEALS'            ,
                              'INS_PARTNERS'         ,
                              'INSU_ACC'             ,
                              'INSU_RNK'             ,
                              'KL_CUSTOMER_PARAMS'   ,
                              'KL_CUSTOMERW'         ,
                              'NAEK_COUNTERS'        ,
                              'NBU_CONTR'            ,
                              'PERSON_VALID_DOCUMENT',
                              'RNK_REKV'             ,
                              'RNKP_KOD'             ,
                              'RNKP_KOD_ACC'         ,
                              'SOCIAL_CONTRACTS'     ,
                              'SOCIAL_TRUSTEE'       ,
                              'STO_LST'              ,
                              'SURVEY_SESSION'       ,
                              'SW_REG_DIRS'          ,
                              'SW_SB_TELEX'          ,
                              'TAMOZHDOC'            ,
                              'TOP_CONTRACTS'        ,
                              'ZAY_COMISS'           ,
                              'ZAYAVKA') and
         k.table_name not like 'DPT%'    and
         k.table_name not like 'DPU%'    and
         k.table_name not like 'KLP%' then
--      bars_audit.info('k.table_name = '||k.table_name);

        cnt_ := 0;

        fil_ := '';
        ins_ := '';
        sql_ := 'select column_name
                 from   user_tab_columns
                 where  table_name='''||k.table_name||'''
                 order  by column_id';
        open cur_ for sql_;
        loop
          fetch cur_ into column_name_;
          exit when cur_%notfound;

--        поля, которые НЕ НАДО мигрировать
          if column_name_ not in ('BRANCH','TOBO','KF','RNKP') then
            ins_ := ins_||column_name_||',';
            if column_name_=k.column_name then
              fil_ := fil_||l_rnkto||',';
            else
              if (k.table_name in ('CUSTOMERW','CUSTOMER') and column_name_='ISP') or
                 (k.table_name='CUSTOMER_RISK' and column_name_='USER_ID') then
                fil_ := fil_||'1,';
              else
                fil_ := fil_||column_name_||',';
              end if;
            end if;
          end if;
        end loop;
        close cur_;
        ins_ := ' ('||substr(ins_,1,length(ins_)-1)||') ';
        fil_ := substr(fil_,1,length(fil_)-1);

        begin
          sql_ := 'select rowid
                   from   '||k.table_name||'@'||p_dblink||'
                   where  '||k.column_name||'='||l_rnkfrom;
          begin
            open cur_ for sql_;
          exception when others then
            if sqlcode=-4063 then
              bars_audit.warning('CC2rnk: '||k.table_name||' skipping... '||sqlerrm);
              goto bs;
            end if;
          end;
          loop
            begin
              fetch cur_ into rowid_;
            exception when others then
              if sqlcode=-904 then
                bars_audit.warning('CC2rnk: '||k.table_name||' skipping... '||sqlerrm);
                goto bs;
              end if;
            end;

            exit when cur_%notfound;

            begin
--            bars_audit.info('insert into (-) '||k.table_name||' select '||fil_||' from '||k.table_name||' where rowid='''||rowid_||'''');
              execute immediate 'insert into '||k.table_name||ins_||'
                                      select '||fil_||'
                                      from   '||k.table_name||'@'||p_dblink||'
                                      where  rowid='''||rowid_||'''';
              cnt_ := cnt_ + 1;
--            bars_audit.info('insert into (+) '||k.table_name||' select '||fil_||' from '||k.table_name||' where rowid='''||rowid_||'''');
            exception when others then
              if sqlcode=-904 then
                bars_audit.warning('CC2rnk: '||k.table_name||' skipping...'||sqlerrm);
              elsif sqlcode=-942 then
                bars_audit.warning('CC2rnk: '||k.table_name||' skipping...'||sqlerrm);
              elsif sqlcode=-2291 then
                bars_audit.warning('CC2rnk: '||k.table_name||' skipping...'||sqlerrm);
              else
                if k.table_name<>'CUSTOMERW' then
                  bars_audit.error('CC2rnk: insert into '||k.table_name||ins_||chr(13)||chr(10)||
                                           'select '||fil_||chr(13)||chr(10)||
                                           'from   '||k.table_name||'@'||p_dblink||chr(13)||chr(10)||
                                           'where  rowid='''||rowid_||''''||chr(13)||chr(10)||
                                           sqlerrm||chr(13)||chr(10)||
                                           replace(dbms_utility.format_error_backtrace,chr(10),chr(13)||chr(10)));
                else
                  null;
                end if;
              end if;
            end;
          end loop;
<<bs>>    null;
          close cur_;
        end;
--      bars_audit.info('CC2rnk: '||k.table_name||' count = '||cnt_);

      end if;
    end;
  end loop;

--мучаем CUSTOMER_REL и CUSTOMER_EXTERN

  begin
    sql_ := 'select RNK             ,
                    REL_ID          ,
                    REL_RNK         ,
                    REL_INTEXT      ,
                    VAGA1           ,
                    VAGA2           ,
                    TYPE_ID         ,
                    POSITION        ,
                    FIRST_NAME      ,
                    MIDDLE_NAME     ,
                    LAST_NAME       ,
                    DOCUMENT_TYPE_ID,
                    DOCUMENT        ,
                    TRUST_REGNUM    ,
                    TRUST_REGDAT    ,
                    BDATE           ,
                    EDATE           ,
                    NOTARY_NAME     ,
                    NOTARY_REGION   ,
                    SIGN_PRIVS      ,
                    SIGN_ID         ,
                    NAME_R
             from   CUSTOMER_REL@'||p_dblink||'
             where  rnk='||to_char(p_rnkold);
    open cur_ for sql_;
--  for k in (select *
--            from   CUSTOMER_REL@p_dblink
--            where  rnk=p_rnkold)
    loop

      fetch cur_
      into  l_RNK             ,
            l_REL_ID          ,
            l_REL_RNK         ,
            l_REL_INTEXT      ,
            l_VAGA1           ,
            l_VAGA2           ,
            l_TYPE_ID         ,
            l_POSITION        ,
            l_FIRST_NAME      ,
            l_MIDDLE_NAME     ,
            l_LAST_NAME       ,
            l_DOCUMENT_TYPE_ID,
            l_DOCUMENT        ,
            l_TRUST_REGNUM    ,
            l_TRUST_REGDAT    ,
            l_BDATE           ,
            l_EDATE           ,
            l_NOTARY_NAME     ,
            l_NOTARY_REGION   ,
            l_SIGN_PRIVS      ,
            l_SIGN_ID         ,
            l_NAME_R;
      exit when cur_%notfound;

--    bars_audit.info('CC2rnk: CUSTOMER_REL');
--    l_id := s_customerextern.nextval;
      begin
        execute immediate 'select f_ourmfo_g@'||p_dblink||'
                           from   dual'
                           into   l_mfo;
      exception when others then
        l_mfo := substr(p_dblink,-6);
      end;
      l_id := f_id_rel(l_REL_INTEXT,l_REL_RNK,l_mfo);

      if l_REL_INTEXT=1 then -- клиент из CUSTOMER (вставить в CUSTOMER_EXTERN)
        begin
          l_sql := 'insert
                    into   customer_extern (id,
                                            NAME,
                                            DOC_TYPE,
                                            DOC_SERIAL,
                                            DOC_NUMBER,
                                            DOC_DATE,
                                            DOC_ISSUER,
                                            BIRTHDAY,
                                            BIRTHPLACE,
                                            SEX,
                                            ADR,
                                            TEL,
                                            EMAIL,
                                            CUSTTYPE,
                                            OKPO,
                                            COUNTRY,
                                            REGION,
                                            FS,
                                            VED,
                                            SED,
                                            ISE,
                                            NOTES)
                                     select '||to_char(l_id)||',
                                            c.nmk,
                                            p.passp,
                                            p.ser,
                                            p.numdoc,
                                            p.pdate,
                                            p.organ,
                                            p.bday,
                                            p.bplace,
                                            to_char(nvl(p.sex,0)),
                                            c.adr,
                                            nvl(p.telw,p.teld),
                                            w.value,
                                            c.custtype-1,
                                            c.okpo,
                                            c.COUNTRY,
                                            null,
                                            c.fs,
                                            c.VED,
                                            c.SED,
                                            c.ISE,
                                            c.notes
                                     from   customer@' ||p_dblink||' c,
                                            person@'   ||p_dblink||' p,
                                            customerw@'||p_dblink||' w
                                     where  c.rnk='||to_char(l_REL_RNK)||' and
                                            p.rnk(+)=c.rnk                 and
                                            w.rnk(+)=c.rnk                 and
                                            w.tag(+)=''EMAIL''';
          execute immediate l_sql;
        exception when dup_val_on_index then
          null;
                  when others then
          bars_audit.error('CC2rnk: insert into customer_extern(1) error - '||chr(13)||chr(10)||
                           l_sql||chr(13)||chr(10)||
                           sqlerrm||chr(13)||chr(10)||
                           replace(dbms_utility.format_error_backtrace,chr(10),chr(13)||chr(10)));
          exit;
        end;
      else
--      выбрать из CUSTOMER_EXTERN@p_dblink по k.REL_RNK и вставить в CUSTOMER_EXTERN
        begin
          l_sql := 'insert
                    into   customer_extern (id,
                                            NAME,
                                            DOC_TYPE,
                                            DOC_SERIAL,
                                            DOC_NUMBER,
                                            DOC_DATE,
                                            DOC_ISSUER,
                                            BIRTHDAY,
                                            BIRTHPLACE,
                                            SEX,
                                            ADR,
                                            TEL,
                                            EMAIL,
                                            CUSTTYPE,
                                            OKPO,
                                            COUNTRY,
                                            REGION,
                                            FS,
                                            VED,
                                            SED,
                                            ISE,
                                            NOTES)
                                     select '||to_char(l_id)||',
                                            NAME,
                                            DOC_TYPE,
                                            DOC_SERIAL,
                                            DOC_NUMBER,
                                            DOC_DATE,
                                            DOC_ISSUER,
                                            BIRTHDAY,
                                            BIRTHPLACE,
                                            nvl(SEX,''0''),
                                            ADR,
                                            TEL,
                                            EMAIL,
                                            CUSTTYPE,
                                            OKPO,
                                            COUNTRY,
                                            REGION,
                                            FS,
                                            VED,
                                            SED,
                                            ISE,
                                            NOTES
                                     from   customer_extern@'||p_dblink||'
                                     where  id='||to_char(l_REL_RNK);
          execute immediate l_sql;
        exception when dup_val_on_index then
          null;
                  when others then
          bars_audit.error('CC2rnk: insert into customer_extern(0) error - '||chr(13)||chr(10)||
                           l_sql||chr(13)||chr(10)||
                           sqlerrm||chr(13)||chr(10)||
                           replace(dbms_utility.format_error_backtrace,chr(10),chr(13)||chr(10)));
          exit;
        end;
      end if;
      begin
        insert
        into   customer_rel (RNK,
                             REL_ID,
                             REL_RNK,
                             REL_INTEXT,
                             VAGA1,
                             VAGA2,
                             TYPE_ID,
                             POSITION,
                             FIRST_NAME,
                             MIDDLE_NAME,
                             LAST_NAME,
                             DOCUMENT_TYPE_ID,
                             DOCUMENT,
                             TRUST_REGNUM,
                             TRUST_REGDAT,
                             BDATE,
                             EDATE,
                             NOTARY_NAME,
                             NOTARY_REGION,
                             SIGN_PRIVS,
                             SIGN_ID,
                             NAME_R)
                     values (to_number(l_rnkto),
                             l_REL_ID,
                             l_id,
                             0,
                             l_VAGA1,
                             l_VAGA2,
                             l_TYPE_ID,
                             l_POSITION,
                             l_FIRST_NAME,
                             l_MIDDLE_NAME,
                             l_LAST_NAME,
                             l_DOCUMENT_TYPE_ID,
                             l_DOCUMENT,
                             l_TRUST_REGNUM,
                             l_TRUST_REGDAT,
                             l_BDATE,
                             l_EDATE,
                             l_NOTARY_NAME,
                             l_NOTARY_REGION,
                             l_SIGN_PRIVS,
                             l_SIGN_ID,
                             l_NAME_R);
      exception when others then
        bars_audit.error('CC2rnk: insert into customer_rel error - '||chr(13)||chr(10)||
                         sqlerrm||chr(13)||chr(10)||
                         replace(dbms_utility.format_error_backtrace,chr(10),chr(13)||chr(10)));
        exit;
      end;
      begin
        l_sql := 'insert
                  into   cust_rnk_db_id (rel_intext_db,
                                         rel_rnk_db   ,
                                         id           ,
                                         mfo)
                                 values ('||to_char(l_REL_INTEXT)||',
                                         '||to_char(l_REL_RNK)||'   ,
                                         '||to_char(l_id)||'        ,
                                         f_ourmfo_g@'||p_dblink||')';
--      bars_audit.error('l_sql='||l_sql);
        execute immediate l_sql;
      exception when dup_val_on_index then
        null;
      end;
    end loop;
    close cur_;
  end;

  p_rnknew := to_number(l_rnkto);
  bars_audit.info('CC2rnk: end (from '||l_rnkfrom||' to '||l_rnkto||')');

--commit;

end CC2rnk;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CC2RNK.sql =========*** End *** ==
PROMPT ===================================================================================== 
