

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_POVID.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_POVID ***

  CREATE OR REPLACE PROCEDURE BARS.P_POVID 
  (p_filial   varchar2,
   p_nlslist  varchar2)
is
  type         cur is ref cursor;
  cur_         cur;
  sql_         varchar2(4000);
  name_fil_    varchar2(70);
  highdep_     number;
  NAME_G_      varchar2(70);
  ADR_G_       varchar2(70);
  OKPO_G_      varchar2(14);
  BOSS_        varchar2(70);
  clauselike_  varchar2(4096);
  nlslist_     varchar2(4096);
  el_          varchar2(1024);
  i_           int;
  RNK_         number;
  NMK_         varchar2(70);
  ADR_         varchar2(70);
  OKPO_        varchar2(16);
  DATX_        date;
  NLS_FIL_     varchar2(14);
  NLS_BARS_    varchar2(14);
  KV_          number;

begin

  execute immediate 'truncate table tmp_povid';

  select val into NAME_G_ from params$base where PAR='NAME';
  select val into OKPO_G_ from params$base where PAR='OKPO';
  select val into BOSS_   from params$base where PAR='BOSS';
  select val into ADR_G_  from params$base where PAR='ADDRESS';

--разбор p_nlslist

  clauselike_ := ' (';
  nlslist_    := p_nlslist;

  bars_audit.info('P_POVID: nlslist_='||nlslist_);

  while length(nlslist_)>0
  loop
    i_ := instr(nlslist_,',');
    if i_>0 then
      el_      := substr(nlslist_,1,i_-1);
      nlslist_ := substr(nlslist_,i_+1);
    else
      el_      := nlslist_;
      nlslist_ := '';
    end if;
    clauselike_ := clauselike_||'m.nls_bars like '''||el_||'%'' or ';
  end loop;

  if length(clauselike_)=1 then
    clauselike_ := '1=1';
  else
    clauselike_ := substr(clauselike_,1,length(clauselike_)-4)||')';
  end if;

  begin
    execute immediate 'select min(hig_depart)
                       from   S6_S6_'||p_filial||'_DEPARTAMENT'
                       into   highdep_;
    execute immediate 'select nam_depart
                       from   S6_S6_'||p_filial||'_DEPARTAMENT
                       where  hig_depart='||to_char(highdep_)
                       into   name_fil_;
  exception when others then
    begin
      execute immediate 'select name
                         from   S6_S5_'||p_filial||'_ANKETA
                         where  sign=''Наим.учреждения'''
                         into   name_fil_;
    exception when others then
      begin
        execute immediate 'select npayername
                           from   S6_HI_'||p_filial||'_VAR
                           where  npayername is not null and
                                  rownum<2'
                           into   name_fil_;
      exception when others then
        name_fil_ := 'Филиал '||p_filial;
      end;
    end;
  end;

  i_ := 0;

  sql_:='select c.rnk     ,
                c.nmk     ,
                c.adr     ,
                c.okpo    ,
                a.daos    ,
                m.nls_fil ,
                m.nls_bars,
                m.kv
         from   s6_migrnls m,
                accounts   a,
                customer   c
         where  m.filial='''||p_filial||''' and
                a.nls=m.nls_bars            and
                a.kv=m.kv                   and
                c.rnk=a.rnk                 and'||
                clauselike_;

  bars_audit.info('P_POVID: sql_='||sql_);

--for k in (select c.rnk     ,  --RNK
--                 c.nmk     ,  --NMK
--                 c.adr     ,  --ADR
--                              --name_fil  name_fil_
--                              --filial    p_filial
--                 a.daos    ,  --DATX
--                 m.nls_fil ,  --NLS_FIL
--                 m.nls_bars,  --NLS_BARS
--                 m.kv         --KV
--                              --MFO_G     f_ourmfo_g
--                              --NAME_G    params$base - PAR='NAME'
--                              --ADR_G     params$base - PAR='ADDRESS'
--                              --OKPO_G    params$base - PAR='OKPO'
--                              --BOSS)     params$base - PAR='BOSS'
--          from   s6_migrnls m,
--                 accounts   a,
--                 customer   c
--          where  m.filial=p_filial and
--                 a.nls=m.nls_bars  and
--                 a.kv=m.kv         and
--                 c.rnk=a.rnk       and
--                 clauselike_)

  open cur_ for sql_;
  loop
    fetch cur_ into RNK_     ,
                    NMK_     ,
                    ADR_     ,
                    OKPO_    ,
                    DATX_    ,
                    NLS_FIL_ ,
                    NLS_BARS_,
                    KV_;
    exit when cur_%notfound;

    i_ := 1;
    insert
    into   tmp_povid (RNK     ,
                      NMK     ,
                      ADR     ,
                      OKPO    ,
                      name_fil,
                      filial  ,
                      DATX    ,
                      NLS_FIL ,
                      NLS_BARS,
                      kv      ,
                      MFO_G   ,
                      NAME_G  ,
                      ADR_G   ,
                      OKPO_G  ,
                      BOSS)
              VALUES (RNK_      ,
                      NMK_      ,
                      ADR_      ,
                      OKPO_     ,
                      name_fil_ ,
                      p_filial  ,
                      DATX_     ,
                      NLS_FIL_  ,
                      NLS_BARS_ ,
                      KV_       ,
                      f_ourmfo_g,
                      NAME_G_   ,
                      ADR_G_    ,
                      OKPO_G_   ,
                      BOSS_);
  end loop;
  close cur_;

  if i_=0 then
    raise_application_error(-20371,'Данные по филиалу '||p_filial||' сч. '||
                            p_nlslist||' отсутствуют...',TRUE);
  else
    commit;
  end if;
end p_povid;
/
show err;

PROMPT *** Create  grants  P_POVID ***
grant EXECUTE                                                                on P_POVID         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_POVID         to RPBN001;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_POVID.sql =========*** End *** =
PROMPT ===================================================================================== 
