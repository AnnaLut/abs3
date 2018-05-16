
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_cash.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_CASH 
is
    -----------------------------------------------------------------
    --                                                             --
    --         ������ ����� (��� ���������)                        --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- ���������                                                   --
    -----------------------------------------------------------------

    VERSION_BODY      constant varchar2(64)  := 'version 6.4 15.05.2018';

    -----------------------------------------------------------------
    -- ����������
    -----------------------------------------------------------------

    G_CURRSHIFT    number;   -- ������� �������� �����
    G_ISUSECASH    number;   -- �������� �� ��� ����� � ������ (1-��, 0-���)

    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2;

    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2;

    ------------------------------------------------------------------
    -- NEXT_SHIFT
    --
    --  ��� ��������� ���� ������� ������ ��������� ����� �����
    --
    function next_shift return smallint;

    ------------------------------------------------------------------
    -- NEXT_SHIFT_DATE
    --
    --  ������ ���� ��������� ����� � ������� ��������� ����, ���� ���� ����� ���� - ������ �������� ���
    --
    --  p_currshift  - �������� ����� ��� ������ ���� ����. �����
    --  p_opdate     - ��������� ����
    --
    function next_shift_date(
                  p_currshift number,
                  p_opdate    date    ) return date;

    ------------------------------------------------------------------
    -- OPEN_CASH
    --
    --  �������� ������������� ��� (�����) ��� ����� � ���������.
    --  ���� �������� �� ������ �����
    --
    --
    procedure open_cash;

    ------------------------------------------------------------------
    -- OPEN_CASH
    --
    --  �������� ������������� ��� (�����) ��� ����� � ���������.
    --  ��� ��������� ����� ��� ������� ��������� ����
    --  ���� �������� �� ������ �����
    --
    --  p_shift number  -  ����� �����
    --  p_force number  -  ��������� ��� ������, ���� ���� ����� ����� ��� �������
    --
    procedure open_cash(p_shift number, p_force number default 1);

    ------------------------------------------------------------------
    -- CURRENT_OPDATE
    --
    --
    --
    function current_opdate return date;

    ------------------------------------------------------------------
    -- CURRENT_SHITFT
    --
    --  ������ ����� ������� �����. ���� ����� �� ������� - ������ ����
    --
    --
    function current_shift return smallint;

    ------------------------------------------------------------------
    -- OPEN_CASH_MANUALY
    --
    --  �������� ������������� ���(������ �����) ��� ���� �������, ���. �������� � ������
    --  �� ��������� ������� �������� ����. ����
    --  ���������� � ������, ���� �� ������� ������� �� ������� �����.
    --  ����������� ������������ ���� - ��������� ����. ����, ��������� 8:00
    --
    --
    --
    procedure open_cash_manualy(p_bankdate date);

    ------------------------------------------------------------------
    -- CLEAR_CASH_JOURNALS
    --
    -- ������� ���� ������������� ������ ��� ���������� ���������� �� ����� �����
    -- ����������� ������������� ������������ ������.
    -- ������ �� ��������� ���� (��������� ���� �� ����������)
    --
    procedure clear_cash_journals(p_dat date);

    ------------------------------------------------------------------
    -- MODIFY_CASH_SNAPSHOT
    --
    -- ������� �������� �������� �� ����� ��� ������������� ��������
    --
    -- p_ref - �������� ������������� ���������
    --
    procedure modify_cash_snapshot(p_ref number);

    ------------------------------------------------------------------
    -- MAKE_REPORT_DATA
    --
    -- ����������� ������ ��� ������� ��� �� ��������� �������
    --
    --  p_date        - ������������ ���� ��� ������
    --  p_shift       - ����� �����
    --  p_visauserid  - ��� ������������, ������� ������ ���� �������  (0-���)
    --  p_postuserid  - ��� ������������ ��� ������ ���-�(0-���)
    --  p_type        - ��� ������  'CJ' - �������� ������,
    --                              'SD' - ���� ���,
    --                              'RD' - ������ ����������
    --                              'RO' - ����� �������� (��� ��������� ������ ������ - 'SD' + 'RD')  - �������� �����, ��� ������ ���� �������
    --  p_branch      -  �����, �� ������ ������ �����
    --
    --
    procedure make_report_data
            ( p_date date,
              p_shift       number,
              p_visauserid  number,
              p_postuserid  number,
              p_type        varchar2,
              p_branch      varchar2  default sys_context('bars_context','user_branch')
            ) ;


    ------------------------------------------------------------------
    -- MAKE_CASH_JOURNAL_REPDATA
    --
    -- ����������� ������ �� �������. ������� ��� ������� �� �������� ��������
    --
    --  p_date    - ��������� ���� ����� ���������
    --	p_userid  - ��� ������������, ��� ������ ���-�
    --  p_kv      - ��� ���� ����� (% - 980 - !980),
    --  p_nlsmask - ����� ������� ����
    --  p_branch  - ��������
    --
    procedure make_cash_journal_repdata(
               p_date    date,
	       p_userid  number   default  0,
	       p_kv      varchar2 default '%',
	       p_nlsmask varchar2 default '1001%',
	       p_branch  varchar2 default sys_context('bars_context','user_branch')) ;


    ------------------------------------------------------------------
    -- GET_BRANCH
    --
    --  �� ����������, ������� ���������� ������������� � ������ (��� ���������)
    --  ������ ����� ������
    --
    function  get_branch(p_branch  varchar2) return varchar2;

    ------------------------------------------------------------------
    -- IS_CASHVISA
    --
    -- ������� ������ �����, �������� �� �������� ������ ����������� - ����� �����
    --  ���������� 1, ���� ���� �������, ����� ���������� 0
    --
    --  p_visagroup
    --
    function is_cashvisa(p_visagroup number) return number;

    ------------------------------------------------------------------
    --  IS_CASHVISA
    --
    --  ������� ������ �����, �������� �� �������� ������ ����������� - ����� �����.
    --  ���������� 1, ���� ���� �������, ����� ���������� 0
    --
    --  p_visagroup - ������ �����������,
    --  p_status    - ������ �� oper_visa
    --
    function is_cashvisa(p_visagroup number, p_status number) return number;

    ------------------------------------------------------------------
    -- GET_SK
    --
    -- �������� ������ ��� ����� ��� ����� � ���������.
    --  (���� �������� �� ������ ����� ������, �� ������ ������ ���� ����� - �����������)
    --
    --  p_nls  - ���� ��� ���. ����� ��������� ���
    --  p_nlsa - ���� �
    --  p_nlsb - ���� �
    --  p_kv   - ��� �
    --  p_kv2  - ��� �
    --  p_sk   - ��� � oper.sk
    --  p_tt   - �������� �� opldok
    --
    function get_sk( p_nls  varchar2,
                      p_nlsa varchar2,
                      p_nlsb varchar2,
                      p_kv   number,
                      p_kv2  number,
                      p_sk   number,
                      p_tt   varchar2 default null  ) return number;

    ------------------------------------------------------------------
    -- GET_NAZN
    --
    -- �������� ���������� ��� �������� p_opldoktt
    --
    --
    function get_nazn( p_nazn      varchar2,
                       p_opertt    varchar2,
                       p_opldoktt  varchar2) return varchar2;

    ------------------------------------------------------------------
    -- ENQUE_REF
    --
    --  �������� ���.+id ������ � ������� ��� �������� - ��� ���� �������� ��� ���
    --
    --  p_ref
    --  p_userid
    --
    procedure enque_ref(
               p_ref     number,
               p_userid  number );

    ------------------------------------------------------------------
    --  VALIDATE_FOR_CASHVISA
    --
    --  ������� �� ������� �������� � ������ � ���������������� ��� - �������� �� ��� ����.
    --  ��� ������������� ������, ��������� ���������� � cash_lastvisa
    --
    --  p_refcount -���-�� ����������, �������������� �� ���� ����
    --
    procedure validate_for_cashvisa( p_refcount     number default 10000);

    ------------------------------------------------------------------
    --  CHECK_FOR_CASHVISA
    --
    --  �� ���� � ��� ���������� ���������� - �������� ���-� ��� ���
    --
    --  return - 1 cash, 0 - nocash
    --
    function check_for_cashvisa( p_ref number, p_status number, p_groupid number) return number;

end bars_cash;
/

show error

create or replace package body BARS_CASH 
is
    -----------------------------------------------------------------
    --                                                             --
    --         ������ ����� (��� ���������)                        --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- ���������                                                   --
    -----------------------------------------------------------------

    VERSION_BODY      constant varchar2(64)  := 'version 6.4 15.05.2018';
    G_MODULE          constant varchar2(4)   := 'CSH';
    G_CASH_JOURNAL    constant varchar2(4)   := 'CJ';
    G_SVOD_DAY        constant varchar2(4)   := 'SD';

    G_KV_ALL    constant varchar2(4)         := '';
    G_KV_GRN    constant varchar2(4)         := 'CJ';
    G_KV_VAL    constant varchar2(4)         := 'SD';

    G_TRACE     constant varchar2(100)       := 'bars_cash.';

    type t_cash_chklist is table of number index by binary_integer;
    g_cash_chklist t_cash_chklist;

    type t_tts is record (iscash number,  --   9-� ���� ��������
                          sk     number,  --   ������ ���������
                          nazn   varchar2(160));
    type t_tts_list is table of t_tts index by varchar2(5);
    tts_list  t_tts_list;

    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2 is
    begin
       return 'Package header bars_cash: '||VERSION_HEAD;
    end header_version;

    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2 is
    begin
       return 'Package body bars_cash: '||VERSION_BODY;
    end body_version;

    ------------------------------------------------------------------
    -- CURRENT_SHITFT
    --
    --  ������ ����� ������� �����. ���� ����� �� ������� - ������ ����
    --
    --
    function current_shift return smallint
    is
       l_shift   smallint;
       l_opdate  date;
    begin

       l_opdate := sysdate;

       select nvl(max(shift), 0)  into l_shift
       from cash_open
       where opdate between  trunc(l_opdate) and trunc(l_opdate) + 0.999
             and branch = sys_context('bars_context','user_branch');
       return l_shift;

    end;

    ------------------------------------------------------------------
    -- NEXT_SHIFT
    --
    --  �� ���� ������ ��������� ����� ����� ��� ����� ������������� ���
    --
    function next_shift return smallint
    is
    begin
       return current_shift + 1;
    end;




    ------------------------------------------------------------------
    -- NEXT_SHIFT_DATE
    --
    --  ������ ���� ��������� ����� � ������� ��������� ����, ���� ���� ����� ���� - ������ �������� ���
    --
    --  p_currshift  - �������� ����� ��� ������ ���� ����. �����
    --  p_opdate     - ��������� ����
    --
    function next_shift_date(
                  p_currshift number,
                  p_opdate    date    ) return date
    is
       l_date   date;
    begin
       select opdate into l_date
       from cash_open
       where  opdate > trunc(p_opdate) and opdate < trunc(p_opdate) + 0.999
              and shift = p_currshift + 1
              and branch = sys_context('bars_context','user_branch');
       return l_date;
    exception when no_data_found then
      return trunc(p_opdate) + 0.999;
    end;



    ------------------------------------------------------------------
    -- OPEN_CASH
    --
    --  �������� ������������� ��� (�����) ��� ����� � ���������.
    --  ��� ��������� ����� ��� ������� ��������� ����
    --  ���� �������� �� ������ �����
    --
    --  p_shift number  -  ����� �����
    --  p_force number  -  ��������� ��� ������, ���� ���� ����� ����� ��� �������
    --
    procedure open_cash(p_shift number, p_force number default 1)
    is
       l_maxref  number :=0;
       l_curdat  date;
       l_trace   varchar2(100):=G_TRACE||'open_cash: ';
    begin
        l_maxref := 0;
        bars_audit.info(l_trace||'�������� ����� ��� '||sys_context('bars_context','user_branch')||' �����: '||p_shift);
        l_curdat := sysdate;

        insert into cash_open(opdate, shift, userid, lastref)
        values(l_curdat, p_shift, user_id, l_maxref);

        for c in (select acc, nls, kv, ostc from v_cashaccounts a)  loop
            --bars_audit.info(l_trace||'����: '||c.acc||' - '||c.nls||'('||c.kv||') - '||c.ostc);
            begin
               insert into cash_snapshot(opdate,acc,ostf)
               values (l_curdat, c.acc, c.ostc);
            exception when dup_val_on_index then
               bars_audit.info(l_trace||'���� ��� ��� ���������������: '||c.acc||' - '||c.nls||'('||c.kv||') - '||c.ostc);
            end;
        end loop;

       G_CURRSHIFT := p_shift;

       -- ���� ���-�� ���������� ��������� ����� �� ������� �������
    exception when dup_val_on_index then
       if p_force  =  0 then
          bars_error.raise_error(G_MODULE, 101);
       else null;
       end if;
    end;



    ------------------------------------------------------------------
    -- OPEN_CASH
    --
    --  �������� ������������� ��� (�����) ��� ����� � ���������.
    --  ��������� ����������� ��������� �����
    --  ���� �������� �� ������ �����
    --
    --
    procedure open_cash
    is
       l_maxdat  date;
       l_maxref  number;
       l_curdat  date;
       l_shift   smallint;
    begin


       l_curdat := sysdate;

       -- ������������ ���� �� ���. ������
       select max(opdate) into l_maxdat
       from cash_snapshot
       where branch = sys_context('bars_context','user_branch');


       if l_maxdat > l_curdat then
          bars_error.raise_error(G_MODULE, 100, to_char(l_maxdat, 'dd-mm-yyyy hh24:mi:ss'),to_char(l_curdat, 'dd-mm-yyyy hh24:mi:ss'));
       end if;

       -- � ���� ��������� ���� ��� ��� ������ ������. ���� - �������� ����. �����
       if trunc(l_maxdat)  = trunc(l_curdat) then

          select max(shift) + 1 into l_shift
          from cash_open
          where opdate between trunc(l_curdat) and l_curdat
                and branch = sys_context('bars_context','user_branch');

       else
          --������ ����� � ������. ���
          l_shift := 1;
       end if;

       open_cash(p_shift => l_shift,
                 p_force => 0);


       G_CURRSHIFT := current_shift;


       bars_audit.info('������������ ������ ������ �����. ����� �'||l_shift);

    end;




    ------------------------------------------------------------------
    -- CURRENT_OPDATE
    --
    --
    --
    function current_opdate return date
    is
    begin
       return trunc(sysdate);
    end;



    ------------------------------------------------------------------
    -- OPEN_CASH_MANUALY
    --
    --  �������� ������������� ���(������ �����) ��� ���� �������, ���. �������� � ������
    --  �� ��������� ������� �������� ����. ����
    --  ���������� � ������, ���� �� ������� ������� �� ������� �����.
    --  ����������� ������������ ���� - ��������� ����. ����, ��������� 7:00
    --
    --
    --
    procedure open_cash_manualy(p_bankdate date)
    is
       l_isusecash  smallint;
       l_iscasopen  smallint;
       l_curdat     date;
    begin

       for c in (select branch from branch ) loop
           bc.subst_branch(c.branch);

           begin

			  /*
			  select 1 into l_isusecash
              from v_cashaccounts
              where rownum = 1;
			  */

              -- ����� �������� � ������
              begin
                 select  1 into l_iscasopen
                 from    cash_open where opdate
                 between p_bankdate and p_bankdate+ 0.999 and shift = 1
                         and branch = sys_context('bars_context','user_branch');
              exception when no_data_found then
                 -- ����� �� �������
                 l_curdat := p_bankdate + 7/24;
                 insert into cash_open(opdate, shift, userid, lastref)
                 values( l_curdat, 1, 1, 1);

                 for k in ( select s.acc, s.ostf
                            from sal s, v_cashaccounts a
                            where s.acc = a.acc and fdat = p_bankdate)
                 loop
                    insert into cash_snapshot(opdate,acc,ostf)
                    values (l_curdat, k.acc, k.ostf);
                 end loop;

              end;

           exception when no_data_found then null;
           end;

           bc.set_context;
       end loop;

    end;




    ------------------------------------------------------------------\
    -- OPEN_CASH_MANUALY2
    --
    --  �������� ��������� ����� �� ��������� �������� �� ������
    --  �� �������� ���������� �������
    --
    procedure open_cash_manualy2(p_shift  number default 1,
                                 p_branch varchar2 default '%')
    is
       l_isusecash  smallint;
       l_maxshift   smallint;
       l_curdat     date;
       l_trace      varchar2(1000):= G_MODULE||'.open_cash_manualy2: ';
    begin

       bars_audit.info(l_trace||'����������������� �������� ����� � '||p_shift||' ��� ������ �� �����: '||p_branch||' �� ������� ��������� ����');
       for c in (select branch
                   from branch
                  where branch like p_branch) loop

           bc.subst_branch(c.branch);


           begin
              /*
			  select 1 into l_isusecash
              from v_cashaccounts
              where rownum = 1;
			  */

              -- ����� �������� � ������
              l_curdat := sysdate;
              select max(shift) into l_maxshift
                from cash_open
               where opdate between trunc(l_curdat) and trunc(l_curdat) + 0.999
                 and branch = sys_context('bars_context','user_branch');
              bars_audit.trace(l_trace||'��� ������ '||c.branch||' ��� ���� '||to_char(l_curdat,'dd/mm/yyyy')||' ����������� �������� �����: '|| nvl(to_char(l_maxshift),'�� ������� �� �����' ) );

              if (l_maxshift is null and p_shift = 1) or
                 (l_maxshift  < p_shift )  then

                 insert into cash_open(opdate, shift, userid, lastref, branch)
                 values( l_curdat, p_shift, 1, 1, c.branch);
                 for k in ( select a.acc, a.nls, a.kv, a.ostc from v_cashaccounts a )
                 loop
                    insert into cash_snapshot(opdate,acc,ostf, branch)
                    values (l_curdat, k.acc, k.ostc, c.branch);
                 end loop;
              else
                 if l_maxshift = p_shift then -- ����� �������
                    bars_audit.info(l_trace||'����� �'||p_shift||' ��� '||c.branch||' �� '||to_char(l_curdat,'dd/mm/yyyy')||' ��� �������');
                 else
                    --l_maxshift > p_shift
                    --bars_error.raise_nerror(G_MODULE, 'CANNOT_OPEN_CASH', to_char(p_shift), to_char(l_curdat,'dd/mm/yyyy'));
                    bars_audit.info(l_trace||'���� ������� ����� ������� ����� �'||l_maxshift||' ��� '||c.branch||' �� '||to_char(l_curdat,'dd/mm/yyyy'));
                 end if;
              end if;

           exception when no_data_found then null;
           end;

           bc.set_context;
       end loop;

    end;




    ------------------------------------------------------------------
    -- MODIFY_CASH_SNAPSHOT
    --
    -- ������� �������� �������� �� ����� ��� ������������� ��������
    --
    -- p_ref - �������� ������������� ���������
    --
    procedure modify_cash_snapshot(p_ref number)
    is
    begin

       --��� ������������� ��������� ����� �������� �������

       -- �������� ��� �������� ������� �� ��� ��������� ����
       for c in ( select o.acc, o.fdat, dk, s, s.branch, s.opdate
                  from   opldok o, cash_snapshot s
                  where ref = p_ref
                        and o.acc = s.acc
                        and s.opdate between trunc(sysdate) and sysdate)
       loop
           update cash_snapshot
           set ostf = ostf +  decode(c.dk, 1, -1, 0, 1) * c.s
           where branch = c.branch and opdate = c.opdate and acc = c.acc;

       end loop;

    end;



    ------------------------------------------------------------------
    -- CLEAR_CASH_JOURNALS
    --
    -- ������� ���� ������������� ������ ��� ���������� ���������� �� ����� �����
    -- ����������� ������������� ������������ ������.
    -- ������ �� ��������� ���� (��������� ���� �� ����������)
    --
    procedure clear_cash_journals(p_dat date)
    is
    begin

       delete from cash_snapshot where opdate < p_dat;
       delete from cash_open     where opdate < p_dat;
       delete from cash_lastvisa where dat    < p_dat;


    exception when others then
       bc.set_context;
       raise;
    end;


    ------------------------------------------------------------------
    --  IS_CASHVISA
    --
    --  ������� ������ �����, �������� �� �������� ������ ����������� - ����� �����.
    --  ���������� 1, ���� ���� �������, ����� ���������� 0
    --
    --  p_visagroup - ������ �����������,
    --  p_status    - ������ �� oper_visa
    --
    function is_cashvisa(p_visagroup number, p_status number) return number
    is
    begin
       if p_status is not null and p_status = 0  then
          return 0;
       end if;

       -- ������ ��� ����� ��� �� ���������������
       if g_cash_chklist.count  = 0 then
           for c in (select chk from cash_chkgroups) loop
               g_cash_chklist(c.chk) := 0;
           end loop;
       end if;


       if g_cash_chklist.exists(p_visagroup) then
          return 1;
       else
          return 0;
       end if;

    end;


    ------------------------------------------------------------------
    --  IS_CASHVISA
    --
    --  ������� ������ �����, �������� �� �������� ������ ����������� - ����� �����.
    --  ���������� 1, ���� ���� �������, ����� ���������� 0
    --
    --  p_visagroup
    --
    function is_cashvisa(p_visagroup number) return number
    is
    begin
       return is_cashvisa(p_visagroup, null);
    end;



    ------------------------------------------------------------------
    -- GET_NAZN
    --
    -- �������� ���������� ��� �������� p_opldoktt
    --
    --
    function get_nazn( p_nazn      varchar2,
                       p_opertt    varchar2,
                       p_opldoktt  varchar2) return varchar2
    is
       l_sk  number;
       l_trace   varchar2(1000) := G_TRACE||'get_nazn:';
    begin

       if p_opertt<>p_opldoktt        and
          tts_list.exists(p_opldoktt) and
          tts_list(p_opldoktt).nazn  is not null then
              return tts_list(p_opldoktt).nazn;
       else
              return p_nazn;
       end if;

    end;



    ------------------------------------------------------------------
    -- GET_SK
    --
    -- �������� ������ ��� ����� ��� ����� � ���������.
    --  (���� �������� �� ������ ����� ������, �� ������ ������ ���� ����� - �����������)
    --
    --  p_nls  - ���� ��� ���. ����� ��������� ���
    --  p_nlsa - ���� �
    --  p_nlsb - ���� �
    --  p_kv   - ��� �
    --  p_kv2  - ��� �
    --  p_sk   - ��� � oper.sk
    --  p_tt   - �������� �� opldok
    --
    function get_sk(  p_nls  varchar2,
                      p_nlsa varchar2,
                      p_nlsb varchar2,
                      p_kv   number,
                      p_kv2  number,
                      p_sk   number,
                      p_tt   varchar2 default null
	           ) return number
    is
       l_sk  number;
    begin

       -- �� ������� �� ��������� ��������
       if  tts_list.exists(p_tt) then
           if tts_list(p_tt).sk is not null then
              return tts_list(p_tt).sk;
           end if;
       end if;


       if p_kv = p_kv2 and  ( substr(p_nlsa,1,4) in ('1001','1002') and  substr(p_nlsb,1,4) in ('1001','1002'))   then
          if p_nls = p_nlsa  then
             l_sk := p_sk;
          else
             if p_nls = p_nlsb then
                case p_sk  when 39 then l_sk:=66;
                           when 66 then l_sk:=39;
                           else l_sk :=66;
                end case;
             else --�������� ���� �� ���������� � ��������
                l_sk := p_sk;
             end if;
         end if;
       else
          l_sk := p_sk;
       end if;

       return l_sk;

    end;


    ------------------------------------------------------------------
    -- MAKE_REPORT_DATA2
    --
    --  ����������� ������ ��� ������� ��� �� ��������� ������� �� ���������
    --  ������������� �������.
    --  ������ ������ ����� ������� ������ �� ���� (�� �� ������).
    --
    --  p_date        - ������������ ���� ��� ������
    --  p_type        - ��� ������  'CJ' - �������� ������,
    --                              'SD' - ���� ���,
    --                              'RD' - ������ ����������
    --                              'RO' - ����� �������� (��� ��������� ������ ������ - 'SD' + 'RD')  - �������� �����, ��� ������ ���� �������
    --  p_visauserid  - ��� ������������, ������� ������ ���� �������  (0-���)
    --  p_postuserid  - ��� ������������ ��� ������ ���-�(0-���)
    --
    procedure make_report_data2
            ( p_date        date,
              p_type        varchar2,
              p_visauserid  number,
              p_postuserid  number
            )
    is
       l_date      date;
       l_next_date date;
       l_trace     varchar2(1000):= G_TRACE||'make_report_data2: ';
    begin

       l_date      := p_date;
       l_next_date := p_date + 0.999;

       execute immediate 'truncate table tmp_cashpayed';

       bars_audit.trace(l_trace||'������ ������ �������, �������� ���������: p_date='||to_char(p_date,'dd/mm/yyyy')||' postuserid='||p_postuserid||' visauserid='||p_visauserid||' type='||p_type );

       case p_type
          ----------
          -- �������� ������
          ----------
          when 'CJ' then
               -- ����� ����������, ���. ������������ �� ����� ������ ����� � ��������� � ������������
               -- ��������� ������ ��������� � ������ ������ �������� �����
               insert   into tmp_cashpayed(
                      datatype,
                      ref, acc, nls, kv, nms, optype,
                      s, sq,
                      nd, dk,  sk,
                      tt, nazn, nlsk,
                      lastvisadat, lastvisa_userid,
                      postdat, post_userid,
                      stime, etime, is_ourvisa)
               select '0',
                      o.ref, v.acc, v.nls, v.kv, v.nms,
                      decode(l.dk, 0, decode(v.pap, 1, 1,   0), decode(v.pap, 1, 0, 1) ),
                      l.s,
                      decode(o.kv, o.kv2, decode( v.kv, 980, l.s, gl.p_icurval( v.kv, l.s, pdat)), o.s2 ) sq,
                      nd, l.dk,
                      get_sk( v.nls, o.nlsa, o.nlsb, o.kv, o.kv2, o.sk, l.tt),
                      l.tt,
                      get_nazn(o.nazn, o.tt, l.tt) nazn,
                      a2.nls,
                      nvl(ov.dat, o.pdat), nvl(ov.userid,o.userid),
                      o.pdat, o.userid,
                      l_date, l_next_date,1
                 from oper           o,
                      opldok         l,
                      opldok         l2,
                      accounts       a2,
                      (select ref, dat, userid from oper_visa
                        where groupid not in (77, 80, 81, 30) and status = 2)  ov,
                      v_cashaccounts v
                where o.sos   = 5
                  and o.ref   = ov.ref(+)
                  and l.fdat  = trunc(l_date)
                  and o.ref   = l.ref
                  and v.acc   = l.acc
                  and l.ref   = l2.ref
                  and l.stmt  = l2.stmt
                  and l.dk    = 1 - l2.dk
                  and l2.acc  = a2.acc;


          ----------
          -- ���� ���������� ���
          ----------
          when 'SD' then
               -- ����� ����������, ���. ������������ �� ����� ������ ����� � ��������� � ������������
               -- ��������� ������ ���������
               -- � ������ ������ �������� �����
               insert   into tmp_cashpayed(
                      datatype,
                      branch,
                      acc, nls, kv, tt,
                      optype,
                      s, post_userid)
                select /*+ LEADING(o) INDEX(l PK_OPLDOK) */
                       0,
                       sys_context('bars_context', 'user_branch'),
                       v.acc,
                       v.nls,
                       v.kv,
                       l.tt,
                       decode(l.dk, 0, decode(pap, 1, 1, 0), decode(pap, 1, 0, 1)),
                       l.s,
                       o.userid
                  from oper o, opldok l, v_cashaccounts v
                 where o.pdat between l_date - 2 and l_next_date + 2
                   and o.sos = 5
                   and exists
                 (select /*+ INDEX(ov I1_OPERVISA) */ 1
                          from oper_visa ov, staff$base sb
                         where o.ref = ov.ref
                           and ov.groupid not in (77, 80, 81, 30)
                           and ov.status = 2
                           and ov.dat between l_date and l_next_date
                           and ov.userid = sb.id
                           and sb.branch = sys_context('bars_context', 'user_branch'))
                   and o.ref = l.ref
                   and l.acc = v.acc;

               /* tvSukhov 03.07.2014 !!! ��������� ������� ��������� �� ������� �������� �������
               select 0,
                      sys_context('bars_context','user_branch'),
                      v.acc, v.nls, v.kv, l.tt,
                      decode(l.dk, 0, decode(pap, 1, 1,   0), decode(pap, 1, 0, 1) ),
                      l.s, o.userid
                 from oper_visa      ov,
                      oper           o,
                      opldok         l,
                      v_cashaccounts v,
                      staff$base     sb
                where o.pdat between l_date - 2 and l_next_date + 2
                  and o.sos     = 5
                  and o.ref     = ov.ref
                  and ov.groupid not in (77, 80, 81, 30)
                  and ov.status = 2
                  and ov.dat between l_date and l_next_date
                  and ov.userid = sb.id
                  and sb.branch = sys_context('bars_context','user_branch')
                  and o.ref     = l.ref
                  and l.acc     = v.acc;*/


               -- ����� ����������, ���. ��������� ������������� ������ ��������� �� �� �������� ������ ������ ������
               -- � ������ ������ �������� �����
               insert   into tmp_cashpayed(
                            datatype,
                            branch,
                            kv, tt, optype,  s, post_userid)
               select 1,
                      sys_context('bars_context','user_branch'),
                      v.kv, l.tt, l.dk,  l.s, o.userid
                 from oper       o,
                      opldok     l,
                      accounts   v,
                      staff$base sb
                where pdat between l_date and  l_next_date
                  and substr(o.nlsa,1,1) <> '1'
                  and substr(o.nlsb,1,1) <> '1'
                  and o.ref = l.ref
                  and o.sos = 5
                  and l.acc = v.acc
                  and o.userid = sb.id
                  and o.branch  = sys_context('bars_context','user_branch')
                  and sb.branch = sys_context('bars_context','user_branch')
                  and substr(v.nls,1,4) in ('2620','2628','2630','2638','9760');



          ----------
          -- ������ ��������_�
          ----------
          when 'RD' then
                 -- ��������� ���. ���� ������� ������������� ������ ��������� �� ��������� ����.
               insert    into tmp_cashpayed(
                             datatype,
                             branch,
                             ref, post_userid, kv, tt, s, sq,
                             stime, etime)
               select '3',
                      sys_context('bars_context','user_branch'),
                      ref, userid, acckv, tt, s,
                      decode( acckv, 980, s, gl.p_icurval( acckv, s, pdat)) sq,
                      l_date, l_next_date
                 from (
                       select unique l.ref, a.kv acckv, l.tt, l.s,  pdat, userid
                         from oper o, opldok l, accounts a, staff$base sb
                        where pdat between l_date and l_next_date
                          and o.sos = 5
                          and o.ref = l.ref
                          and l.acc = a.acc
                          and o.userid = sb.id
                          and o.branch = sys_context('bars_context','user_branch')
                          and sb.branch = sys_context('bars_context','user_branch')
                  );


          ----------
          -- ����� �������� - �����
          ----------
          when 'RO' then
               -- ����� ����������, ���. ������������ �� ����� ������ ����� � ��������� � ������������
               -- ��������� ������ ���������
               -- � ������ ������ �������� �����
               insert    into tmp_cashpayed(
                      datatype, branch,
                      acc, nls, kv, tt,
                      optype,
                      s, sq,
                      post_userid)
                 select '0',
                       sys_context('bars_context', 'user_branch'),
                       v.acc,
                       v.nls,
                       v.kv,
                       l.tt,
                       decode(l.dk, 0, decode(pap, 1, 1, 0), decode(pap, 1, 0, 1)),
                       l.s,
                       decode(o.kv,
                              o.kv2,
                              decode(v.kv, 980, l.s, gl.p_icurval(v.kv, l.s, pdat)),
                              o.s2) sq,
                       o.userid
                  from oper o, opldok l, v_cashaccounts v,(select ref, dat, userid from oper_visa
                        where groupid not in (77, 80, 81, 30) and status = 2)  ov
                 where l.fdat  = trunc(l_date)
                   and o.sos = 5
                   and o.ref = ov.ref(+)
                   and o.ref = l.ref
                   and l.acc = v.acc;

               /* tvSukhov 03.07.2014 !!! ��������� ������� ��������� �� ������� �������� �������
                  select 0,
                      sys_context('bars_context','user_branch'),
                      v.acc, v.nls, v.kv, l.tt,
                      decode(l.dk, 0, decode(pap, 1, 1,   0), decode(pap, 1, 0, 1) ),
                      l.s,
                      decode(o.kv, o.kv2, decode( v.kv, 980, l.s, gl.p_icurval( v.kv, l.s, pdat)), o.s2 ) sq,
                      o.userid
                 from oper_visa      ov,
                      oper           o,
                      opldok         l,
                      v_cashaccounts v,
                      staff$base     sb
                where o.pdat between l_date - 2 and l_next_date + 2
                  and o.sos     = 5
                  and o.ref     = ov.ref
                  and ov.groupid not in (77, 80, 81, 30)
                  and ov.status = 2
                  and ov.dat between l_date and l_next_date
                  and ov.userid = sb.id
                  and sb.branch = sys_context('bars_context','user_branch')
                  and o.ref     = l.ref
                  and l.acc     = v.acc;
	                */


              -- ����� ����������, ���. ��������� ������������� ������ ��������� �� �� �������� ������ ������ ������
              -- � ������ ������ �������� �����
              insert    into  tmp_cashpayed(
                     datatype, branch,
                     kv, tt, optype,  s, sq,
                     post_userid)
              select 1, sys_context('bars_context','user_branch'),
                     v.kv, l.tt, l.dk,  l.s,
                     decode(o.kv, o.kv2, decode( v.kv, 980, l.s, gl.p_icurval( v.kv, l.s, pdat)), o.s2 ) sq,
                     o.userid
               from  oper       o,
                     opldok     l,
                     accounts   v,
                     staff$base sb
               where pdat between l_date and  l_next_date
                 and substr(o.nlsa,1,1) <> '1'
                 and substr(o.nlsb,1,1) <> '1'
                 and o.ref = l.ref
                 and o.sos = 5
                 and l.acc = v.acc
                 and o.userid = sb.id
                 and o.branch  = sys_context('bars_context','user_branch')
                 and sb.branch = sys_context('bars_context','user_branch')
                 and substr(v.nls,1,4) in ('2620','2628','2630','2638','9760','2909','2902'); --COBUMMFO-6936 (�������� ��� ��� '2909','2902')


           else
              bars_error.raise_nerror(G_MODULE, 'NOT_CASH_REPORT', p_type);

       end case;

      bars_audit.trace(l_trace||'������� ����� '||sql%rowcount);



      if p_type = 'SD' or  p_type = 'CJ' or p_type = 'RO'  then

         bars_audit.trace(l_trace||'����� �������� � ��������');
         -- ����� �������� � �������� �� ������ ����� � ���������
         -- � ������ ������ �������� �����
         insert into    tmp_cashpayed(
                 datatype,
                 branch,
                 acc, nls, kv, nms,
                 ostf,
                 obdb, obkr,
                 ost, stime, etime)
         select '2', sys_context('bars_context','user_branch'),
                 a.acc, a.nls, a.kv, a.nms,
                 decode(a.pap,1,-1,1) * ks.ostf,
                 sdb, skr,
                 decode(a.pap,1,-1,1) * ks.ostf   - nvl(sdb,0)  +  nvl(skr,0),
                 l_date, l_next_date
          from (
                 select acc, sum( decode(optype, 0, s, 0)) sdb,   sum( decode(optype, 1, s, 0)) skr
                   from tmp_cashpayed v
                  where datatype = '0'
               group by v.acc
                )        v,
                v_cashaccounts a,
                sal            ks
          where ks.acc    = a.acc
	    and ks.acc    = v.acc (+)
            and ks.fdat   = l_date
            and ( ((ks.ostf <>0 or v.sdb<>0 or v.skr<>0 or a.ostc<>0 ) and substr(a.nls,1,1) = '9') or
                  ( a.ostc<>0 and substr(a.nls,1,4) = '9812' )  or
                  ( a.ostc<>0 and substr(a.nls,1,4) = '3400' ) or
                    substr(a.nls,1,1) = '1'
                );

      end if;



      bars_audit.trace(l_trace||'������� ����� '||sql%rowcount);

       -- ������� �� �������
      if p_visauserid <> 0 then
         for c in ( select acc,
                           sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 0, s,  0), 0 ))   sdb,        -- ���������  �������� �� �������� ���������
                           sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 1, s,  0), 0 ))   skr,        -- ���������� �������� �� �������� ���������
                           sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 0, s,  0), 0 ))   sdb_dpt,    -- ���������  �������� �� ���������� ���������
                           sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 1, s,  0), 0 ))   skr_dpt,    -- ���������� �������� �� ���������� ���������
                           sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 0, sq, 0), 0 ))   sdbq,       -- ���������  ��� �������� �� �������� ���������
                           sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 1, sq, 0), 0 ))   skrq,       -- ���������� ��� �������� �� �������� ���������
                           sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 0, sq, 0), 0 ))   sdbq_dpt,   -- ���������  ��� �������� �� ���������� ���������
                           sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 1, sq, 0), 0 ))   skrq_dpt    -- ���������� ��� �������� �� ���������� ���������
                      from tmp_cashpayed v
                     where datatype = '0' and   lastvisa_userid = p_visauserid
                     group by v.acc) loop
              update tmp_cashpayed set obdbk      = c.sdb,
                                       obkrk      = c.skr,
                                       obdb_dptk  = c.sdb_dpt,
                                       obkr_dptk  = c.skr_dpt,
                                       obdbqk     = c.sdbq,
                                       obkrqk     = c.skrq,
                                       obdbq_dptk = c.sdbq_dpt,
                                       obkrq_dptk = c.skrq_dpt
	     where datatype = '2' and acc = c.acc;
         end loop;

      end if;





   end;



    ------------------------------------------------------------------
    -- MAKE_REPORT_DATA2
    --
    --  ����������� ������ ��� ������� ��� �� ��������� ������� �� ���������
    --  ������������� �������.
    --  ������ ������ ����� ������� ������ �� ���� (�� �� ������).
    --
    --  p_date        - ������������ ���� ��� ������
    --  p_type        - ��� ������  'CJ' - �������� ������,
    --                              'SD' - ���� ���,
    --                              'RD' - ������ ����������
    --                              'RO' - ����� ������_� (��� ��������� ������ ������ - 'SD' + 'RD')  - �������� �����, ��� ������ ���� �������
    --
    procedure make_report_data2
            ( p_date date,
              p_type        varchar2)
    is
    begin
       make_report_data2 ( p_date       => p_date,
                           p_type       => p_type,
                           p_visauserid => 0,
                           p_postuserid => 0);

    end;


    ------------------------------------------------------------------
    -- MAKE_REPORT_DATA
    --
    -- ����������� ������ ��� ������� ��� �� ��������� �������
    --
    --  p_date        - ������������ ���� ��� ������
    --  p_shift       - ����� �����  (0 - ��� �����)
    --  p_visauserid  - ��� ������������, ������� ������ ���� �������  (0-���)
    --  p_postuserid  - ��� ������������ ��� ������ ���-�(0-���)
    --  p_type        - ��� ������  'CJ' - �������� ������,
    --                              'SD' - ���� ���,
    --                              'RD' - ������ ����������
    --                              'RO' - ����� �������� (��� ��������� ������ ������ - 'SD' + 'RD')  - �������� �����, ��� ������ ���� �������
    --  p_branch      -  �����, �� ������ ������ �����
    --
    --
    procedure make_report_data
            ( p_date date,
              p_shift       number,
              p_visauserid  number,
              p_postuserid  number,
              p_type        varchar2,
              p_branch      varchar2  default sys_context('bars_context','user_branch')
            )
    is
       l_shift_date      date;          -- ���� ������ ��������� �����
       l_start_date      date;          -- ���� ������ ��������� �����, ��� ������ ����� - ��� 00:00. �������, �.�. ��� ���������. �������� 1-� ����� - ������� � pdat � open_cash ����� ���� � �������
       l_next_shift_date date;          -- ���� ��������� �����
       l_visauserid      varchar2(10);
       l_postuserid      varchar2(10);
       l_ispretend       number := 0;
       l_cnt             number := 0;
       l_trace           varchar2(1000):= G_TRACE||'make_report_data: ';
    begin

       --bars.bars_cash.validate_for_cashvisa(5000);

       bars_audit.trace(l_trace||'������ ������ �������, �������� ���������: p_date='||to_char(p_date,'dd/mm/yyyy')||' shift='||p_shift||' branch='||p_branch||' type='||p_type );

       if p_branch <> sys_context('bars_context','user_branch') then
          bc.subst_branch(p_branch);
          l_ispretend := 1;
       end if;

       begin
          select opdate, bars_cash.next_shift_date(p_shift, opdate),
                 decode(p_shift, 1, trunc(opdate), opdate)
            into l_shift_date, l_next_shift_date, l_start_date
            from cash_open
           where branch  =  sys_context('bars_context','user_branch')
             and ( shift = p_shift or 0 = p_shift)
             and opdate between p_date and p_date + 0.999;
           bars_audit.trace(l_trace||
                 '����� ���� ������: '||
                 ' shift_date='||to_date(l_shift_date,'dd/mm/yyyy hh24:mi:ss')||
                 ' next_shift_date='||to_date(l_next_shift_date,'dd/mm/yyyy hh24:mi:ss')||
                 ' start_date='||to_date(l_start_date,'dd/mm/yyyy hh24:mi:ss'));

       exception when no_data_found then
           bars_audit.trace(l_trace||'������ �� cash_open �� �������');
           make_report_data2( p_date, p_type, p_visauserid, p_postuserid);
           if l_ispretend = 1 then
              bc.set_context;
           end if;
           return;
       end;

       execute immediate 'truncate table tmp_cashpayed';


       case p_type
           ----------
           -- �������� ������
           ----------
           when 'CJ' then
                -- ����� ����������, ���. ������������ �� ����� ������ ����� � ��������� � ������������
                -- ��������� ������ ��������� � ������ ������ �������� �����
                bars_audit.trace(l_trace||'������� ������');
                insert into   tmp_cashpayed(
                               datatype,
                               ref, acc, nls, kv, nms, optype,
                               s, sq,
                               nd, dk,  sk,
                               tt, nazn, nlsk, kv2,
                               lastvisadat, lastvisa_userid,
                               postdat, post_userid,
                               stime, etime,
                               is_ourvisa, is_dptdoc)
                select '0',
                       o.ref, v.acc, v.nls, v.kv, v.nms, decode(l.dk, 0, decode(v.pap, 1, 1,   0), decode(v.pap, 1, 0, 1) ),
                       l.s, decode(v.kv, 980, l.s, gl.p_icurval( v.kv, l.s, pdat)) sq,
                       nd, l.dk,
                       get_sk( v.nls, o.nlsa, o.nlsb, o.kv, o.kv2, o.sk, o.tt),
                       l.tt,
                       get_nazn(o.nazn, o.tt, l.tt) nazn,
                       a2.nls, a2.kv ,
                       null,
                       (select nvl(max(userid),0)                         -- ���� ������ �������� ��������� �� ���� ������������ - �� ������ 0
                          from cash_lastvisa
                         where ref = ov.ref and userid = decode(p_visauserid, 0,  userid, p_visauserid )  ),
                       o.pdat, o.userid,       -- ����� �� ������ ����� �� �� ����� ������� ��� ������ ������ ������������ ��� ��������� (�������� ������ �������-����)
                       l_shift_date, l_next_shift_date,
                       (
                        select decode(nvl(max(userid),0), 0, 0, 1)
                          from cash_lastvisa  -- ���� ���� ���� ������ ���������
                         where ref = ov.ref and branch  = sys_context('bars_context','user_branch')
                       ),
                       case when (nbs in ('2630','2620','2628','2638')) or
                                 (a2.nbs like '380%' and o.nlsa = v.nls and substr(o.nlsb,1,4) in ('2630','2620','2628','2638') )  or
                                 (a2.nbs like '380%' and o.nlsb = v.nls and substr(o.nlsa,1,4) in ('2630','2620','2628','2638') )
                            then 1
                            else 0
                       end isdptdoc
                  from oper o,
                       opldok l,
                       opldok l2,
                       accounts a2,
                       v_cashaccounts_hist v,
                       (select unique ref                      -- ������ ��� ������� �������������� � ��� �����
                          from cash_lastvisa ov                -- ����� �-��� max, ����� �-��� MAX, ��������� �� ����� ���-�� ����� ���� ��������� ��� ���� (�������� ������� � ������)
                         where ov.dat >= l_start_date  and ov.dat < l_next_shift_date
                           and branch in (--���� ���
                                          '/'||sys_context ('bars_context', 'user_mfo')||'/',
                                          -- ��� �����
                                          sys_context ('bars_context', 'user_branch'),
                                          -- �������� ������ ������
                                          substr(sys_context('bars_context', 'user_branch'), 1, length(SYS_CONTEXT ('bars_context', 'user_branch')) - 7)
                                         )
                       ) ov
                 where ov.ref    = o.ref
                   and o.sos     = 5
                   and o.ref     = l.ref
                   and v.acc     = l.acc
		   --and o.pdat    between l_shift_date - 10 and  l_shift_date + 10
		   --and l.fdat    between l_shift_date - 10 and  l_shift_date + 10
		   --and l2.fdat   between l_shift_date - 10 and  l_shift_date + 10
                   and l.ref     = l2.ref
                   and l.stmt    = l2.stmt
                   and l.dk      = 1 - l2.dk
                   and l2.acc    = a2.acc
                   and v.opdate  = l_shift_date;



                select count(*) into l_cnt from tmp_cashpayed;

                bars_audit.trace(l_trace||'����� ������� '||l_cnt||' ����. ����������');

                if p_visauserid <> 0 then
                   update tmp_cashpayed set lastvisa_userid = post_userid, sk = 66
                    where nls = nlsk and kv = kv2 and dk = 1;   -- �������� ���� (����� � �����)

                   update tmp_cashpayed set sk = 39
                    where nls = nlsk and kv = kv2 and dk = 0;   -- �������� ���� (����� � �����)
                end if;

          ----------
          -- ���� ���������� ���
          ----------
          when 'SD' then
               -- ����� ����������, ���. ������������ �� ����� ������ ����� � ��������� � ������������
               -- � ������ ������ �������� �����
               insert into     tmp_cashpayed(
                      datatype, branch,
                      acc, nls, kv, tt,
                      optype,
                      s, post_userid,
                      stime, etime,
                      is_ourvisa)
               select 0, sys_context('bars_context','user_branch'),
                      v.acc, v.nls, v.kv, l.tt,
                      decode(l.dk, 0, decode(pap, 1, 1,   0), decode(pap, 1, 0, 1) ),
                      l.s, o.userid,
                      l_shift_date, l_next_shift_date,
                      ( select decode(nvl(max(userid),0), 0, 0, 1)
                         from cash_lastvisa  -- ���� ���� ���� ������ ���������
                        where ref = ov.ref and branch  = sys_context('bars_context','user_branch')
                      )
                 from
                      oper           o,
                      opldok         l,
                      v_cashaccounts_hist v,
                      (select unique ref                 -- ������ ��� ������� �������������� � ��� �����
                         from cash_lastvisa ov           -- ����� �-��� max, ����� �-��� MAX, ��������� �� ����� ���-�� ����� ���� ��������� ��� ���� (�������� ������� � ������)
                        where ov.dat >= l_start_date
                          and ov.dat < l_next_shift_date
                      ) ov
                where ov.ref = o.ref
                  and o.sos  = 5
                  and o.ref  = l.ref
 		  and o.pdat    between l_shift_date - 10 and  l_shift_date + 10
		  and l.fdat    between l_shift_date - 10 and  l_shift_date + 10
                  and l.acc= v.acc
                  and v.opdate  = l_shift_date;



               -- ����������
               insert into     tmp_cashpayed(
                      datatype, branch,
                      kv, tt, optype,  s, post_userid)
               select 1, sys_context('bars_context','user_branch'), v.kv, l.tt, l.dk,  l.s, o.userid
                 from oper       o,
                      opldok     l,
                      accounts   v,
                      staff$base sb
                where pdat between l_start_date and  l_next_shift_date
                  and substr(o.nlsa,1,1) <> '1'
                  and substr(o.nlsb,1,1) <> '1'
                  and o.ref = l.ref
                  and o.sos = 5
                  and l.acc = v.acc
                  and o.userid = sb.id
                  and o.branch  = sys_context('bars_context','user_branch')
                  and sb.branch = sys_context('bars_context','user_branch')
                  and substr(v.nls,1,4) in ('2620','2628','2630','2638','9760');


           ----------
           -- ������ ���������
           ----------
          when 'RD' then
              -- ��������� ���. ���� ������� ������������� ������ ��������� �� ��������� ����.
              if  p_postuserid  = 0 then
                  bars_audit.trace(l_trace||'p_postuserid='||p_postuserid||' - ����� ��� ���� ');
	          insert into     tmp_cashpayed( datatype,
                                             ref, post_userid, kv, tt, s, sq,
                                             stime, etime)
                     select '3',
                           ref, userid, acckv, tt, s,
                           decode(acckv, 980, s, gl.p_icurval( acckv, s, pdat)) sq,
                           l_shift_date, l_next_shift_date
                      from (
                            select unique l.ref, a.kv acckv, l.tt, l.s, pdat, userid
                              from oper o, opldok l, accounts a, staff$base sb
                             where pdat between l_start_date and l_next_shift_date
                               and o.sos = 5
                               and o.ref = l.ref
                               and l.acc = a.acc
                               and o.userid = sb.id
                          and o.branch = sys_context('bars_context','user_branch')
                          and sb.branch = sys_context('bars_context','user_branch')
                       );

              else
                 bars_audit.trace(l_trace||'p_postuserid='||p_postuserid||' - ����� ��� ������������� ');
                 insert into     tmp_cashpayed( datatype, branch,
                                            ref, post_userid, kv, tt, s, sq,
                                            stime, etime)
                 select '3',sys_context('bars_context','user_branch'),
                        ref, userid, acckv, tt, s,
                        decode(acckv, 980, s, gl.p_icurval( acckv, s, pdat)) sq,
                        l_shift_date, l_next_shift_date
                  from (
                         select unique l.ref, a.kv acckv, l.tt, l.s, pdat, userid
                           from oper o, opldok l, accounts a, staff$base sb
                          where pdat between l_start_date and l_next_shift_date
                            and o.sos = 5
                            and o.ref = l.ref
                            and l.acc = a.acc
                            and o.userid = sb.id
                            and o.userid = p_postuserid
                       );


              end if;





      ----------
      -- ����� ��������
      ----------
      when 'RO' then
         -- ����� ����������, ���. ������������ �� ����� ������ ����� � ��������� � ������������
         -- � ������ ������ �������� �����
         insert     into tmp_cashpayed(
                datatype, branch,
                acc, nls, kv, tt,
                optype,
                s,
                sq,
                post_userid,
                stime, etime,
                is_ourvisa
                 )
         select 0, sys_context('bars_context','user_branch'),
                v.acc, v.nls, v.kv, l.tt,
                decode(l.dk, 0, decode(pap, 1, 1,   0), decode(pap, 1, 0, 1) ),
                l.s,
                decode(v.kv, 980, l.s, gl.p_icurval( v.kv, l.s, pdat)) sq,
                o.userid,
                l_shift_date, l_next_shift_date,
                ( select decode(nvl(max(userid),0), 0, 0, 1)
                   from cash_lastvisa  -- ���� ���� ���� ������ ���������
                  where ref = ov.ref and branch  = sys_context('bars_context','user_branch')
                )
           from oper           o,
                opldok         l,
                v_cashaccounts v,
                (select unique ref                            -- � ������e cash_lastvisa ����� ���� ���������
                   from cash_lastvisa ov                                       -- ������� ��� ������ ���� (��������� ��� ���� ��� ������ ������)
                  where ov.dat >= l_start_date and ov.dat < l_next_shift_date
                ) ov
          where ov.ref = o.ref
            and o.sos  = 5
   	        and o.pdat    between l_shift_date - 10 and  l_shift_date + 10
			and l.fdat    between l_shift_date - 10 and  l_shift_date + 10
            and o.ref  = l.ref
            and l.acc= v.acc;



          -- ����� ����������, ���. ��������� ������������� ������ ��������� �� �� �������� ������ ������ ������
          -- � ������ ������ �������� �����
          insert into     tmp_cashpayed(
                        datatype, branch,
                        kv, tt, optype,  s, sq, post_userid)
          select  1, sys_context('bars_context','user_branch'), v.kv, l.tt, l.dk,  l.s,
                  decode(v.kv, 980, l.s, gl.p_icurval( v.kv, l.s, pdat)) sq,
                  o.userid
           from   oper       o,
                  opldok     l,
                  accounts   v,
                  staff$base sb
           where pdat between l_start_date and  l_next_shift_date
             and substr(o.nlsa,1,1) <> '1'
             and substr(o.nlsb,1,1) <> '1'
             and o.ref = l.ref
             and o.sos = 5
             and l.acc = v.acc
             and o.userid = sb.id
             and o.branch  = sys_context('bars_context','user_branch')
             and sb.branch = sys_context('bars_context','user_branch')
             and substr(v.nls,1,4) in ('2620','2628','2630','2635','2638','9760','2909','2902'); --COBUMMFO-6936 (�������� ��� ��� '2909','2902')

        else
            bars_error.raise_nerror(G_MODULE, 'NOT_CASH_REPORT', p_type);


      end case;



      if p_type = 'SD' or  p_type = 'CJ' or p_type = 'RO' then

         -- ����� �������� � �������� �� ������ ����� � ���������
         -- � ������ ������ �������� �����
         insert into    tmp_cashpayed(
                 datatype, branch,
                 acc, nls, kv, nms,
                 ostf,
                 obdb, obkr,
                 obdb_dpt, obkr_dpt,
                 obdbq, obkrq,
                 obdbq_dpt, obkrq_dpt,
                 ost, stime, etime)
         select '2', sys_context('bars_context','user_branch'), a.acc, a.nls, a.kv, a.nms,
                decode(a.pap,1,-1,1) * ks.ostf,
                sdb, skr,
                sdb_dpt, skr_dpt,
                sdbq, skrq,
                sdbq_dpt, skrq_dpt,
                decode(a.pap,1,-1,1) * ks.ostf   - nvl((sdb+sdb_dpt),0)  +  nvl((skr+skr_dpt),0),
                l_shift_date, l_next_shift_date
          from (
                 select acc,
                        sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 0, s,  0), 0 ))   sdb,       -- ���������  �������� �� �������� ���������
                        sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 1, s,  0), 0 ))   skr,       -- ���������� �������� �� �������� ���������
                        sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 0, s,  0), 0 ))   sdb_dpt,   -- ���������  �������� �� ���������� ���������
                        sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 1, s,  0), 0 ))   skr_dpt,    -- ���������� �������� �� ���������� ���������
                        sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 0, sq, 0), 0 ))   sdbq,       -- ���������  ��� �������� �� �������� ���������
                        sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 1, sq, 0), 0 ))   skrq,       -- ���������� ��� �������� �� �������� ���������
                        sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 0, sq, 0), 0 ))   sdbq_dpt,   -- ���������  ��� �������� �� ���������� ���������
                        sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 1, sq, 0), 0 ))   skrq_dpt   -- ���������� ��� �������� �� ���������� ���������
                   from tmp_cashpayed v
                  where datatype = '0'
               group by v.acc
               ) v,
                accounts a,
                cash_snapshot ks
          where ks.acc = a.acc and  ks.acc = v.acc (+)
            and ks.opdate  =  l_shift_date
            and ks.branch  =  sys_context('bars_context','user_branch')
            and ( ((ks.ostf <>0 or v.sdb<>0 or v.skr<>0 or a.ostc<>0 ) and substr(a.nls,1,1) = '9') or
            ( a.ostc<>0 and substr(a.nls,1,4) = '3400' )  or
                  ( a.ostc<>0 and substr(a.nls,1,4) = '9812' )  or
                    substr(a.nls,1,1) = '1'
                );
           -- ������� �� �������
	  if p_visauserid <> 0 then
	     for c in ( select acc,
                               sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 0, s,  0), 0 ))   sdb,        -- ���������  �������� �� �������� ���������
                               sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 1, s,  0), 0 ))   skr,        -- ���������� �������� �� �������� ���������
                               sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 0, s,  0), 0 ))   sdb_dpt,    -- ���������  �������� �� ���������� ���������
                               sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 1, s,  0), 0 ))   skr_dpt,    -- ���������� �������� �� ���������� ���������
                               sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 0, sq, 0), 0 ))   sdbq,       -- ���������  ��� �������� �� �������� ���������
                               sum( decode( nvl(is_dptdoc,0), 0, decode(optype, 1, sq, 0), 0 ))   skrq,       -- ���������� ��� �������� �� �������� ���������
                               sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 0, sq, 0), 0 ))   sdbq_dpt,   -- ���������  ��� �������� �� ���������� ���������
                               sum( decode( nvl(is_dptdoc,0), 1, decode(optype, 1, sq, 0), 0 ))   skrq_dpt    -- ���������� ��� �������� �� ���������� ���������
                          from tmp_cashpayed v
                         where datatype = '0' and   lastvisa_userid = p_visauserid
                         group by v.acc) loop
                  update tmp_cashpayed set obdbk      = c.sdb,
                                           obkrk      = c.skr,
                                           obdb_dptk  = c.sdb_dpt,
                                           obkr_dptk  = c.skr_dpt,
                                           obdbqk     = c.sdbq,
                                           obkrqk     = c.skrq,
                                           obdbq_dptk = c.sdbq_dpt,
                                           obkrq_dptk = c.skrq_dpt
		   where datatype = '2' and acc = c.acc;
	     end loop;

          end if;


      end if;



      if l_ispretend = 1 then
         bc.set_context;
      end if;

      select count(*) into l_cnt from tmp_cashpayed where datatype = 0;
      bars_audit.trace(l_trace||'����� ������� '||l_cnt||' ����. ����������');

      select count(*) into l_cnt from tmp_cashpayed where datatype = 2;
      bars_audit.trace(l_trace||'����� ������� '||l_cnt||' ������');

   exception when others then
      if l_ispretend = 1 then
         bc.set_context;
      end if;
      bars_audit.error(l_trace||'������ ������� ������ ��� ������: '||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace);
      raise;
   end;


    ------------------------------------------------------------------
    -- GET_BRANCH
    --
    --  �� ����������, ������� ���������� ������������� � ������ (��� ���������)
    --  ������ ����� ������
    --
    function  get_branch(p_branch  varchar2) return varchar2
    is
    begin
       case upper(p_branch)
          when '�������'  then return sys_context('bars_context','user_branch');
          when 'ϲ����˲' then return sys_context('bars_context','user_branch')||'%';
          else return p_branch;
       end case;
    end;

    ------------------------------------------------------------------
    -- MAKE_CASH_JOURNAL_REPDATA2
    --
    -- ����������� ������ �� �������. ������� ��� ������� �� �������� ��������
    -- ��� ������� ���������� �� �������� cash_snapshot
    --
    --  p_date    - ��������� ���� ����� ���������
    --  p_userid  - ��� ������������, ��� ������ ���-�
    --  p_kv      - ��� ���� ����� (% - 980 - !980),
    --  p_nlsmask - ����� ������� ����
    --  p_branch  - ��������
    --
    procedure make_cash_journal_repdata2(
               p_date    date,
               p_userid  number   default  0,
               p_kv      varchar2 default '%',
               p_nlsmask varchar2 default '1001%',
               p_branch  varchar2 default sys_context('bars_context','user_branch'))
    is
    begin

       execute immediate 'truncate table tmp_cashpayed';

       insert into tmp_cashpayed(
              acc, nls, kv, nms, optype,
              s, sq, dk,
              nd, sk,
              nlsk, nmsk,
              post_userid,
              ostf, ostfq, nazn, branch)
       select
              a.acc, a.nls, a.kv, a.nms, decode(l.dk, 0, decode(a.pap, 1, 1,   0), decode(a.pap, 1, 0, 1) ),
              l.s,  decode(a.kv, 980, l.s, gl.p_icurval( a.kv, l.s, l.fdat)), l.dk,
              o.nd,
              bars_cash.get_sk( a.nls, o.nlsa, o.nlsb, o.kv, o.kv2, o.sk),
              a2.nls, substr(a2.nms,1,38),
              userid,
              (-1)*(b.ost - b.kos + b.dos),  (-1)*(b.ostq - b.kosq + b.dosq) ,
              get_nazn(o.nazn,o.tt, l.tt) nazn,
              a.branch
         from accounts a,
              accm_calendar c, accm_snap_balances b,
              oper o,
              opldok l,  opldok l2, accounts a2
        where (a.nbs like '10%'  or a.nbs like '11%')
          and a.nls    like p_nlsmask
          and a.branch like p_branch
          and a.kv =  decode(p_kv, '980', 980, a.kv)
          and a.kv <> decode(p_kv, '<>980', 980, 0)
          and c.caldt_date = p_date
          and c.bankdt_id  = b.caldt_id
          and b.acc = a.acc
          and l.acc   =  a.acc
          and l.ref   = l2.ref
          and l.stmt  = l2.stmt
          and l.dk    = 1 - l2.dk
          and l2.acc  = a2.acc
          and l.ref   = o.ref
          and o.userid = decode(p_userid, 0, o.userid, p_userid)
          and l.fdat = p_date;



    end;


    ------------------------------------------------------------------
    -- MAKE_CASH_JOURNAL_REPDATA
    --
    -- ����������� ������ �� �������. ������� ��� ������� �� �������� ��������
    --
    --  p_date    - ��������� ���� ����� ���������
    --        p_userid  - ��� ������������, ��� ������ ���-�
    --  p_kv      - ��� ���� ����� (% - 980 - !980),
    --  p_nlsmask - ����� ������� ����
    --  p_branch  - ��������
    --
    procedure make_cash_journal_repdata(
               p_date    date,
               p_userid  number   default  0,
               p_kv      varchar2 default '%',
               p_nlsmask varchar2 default '1001%',
               p_branch  varchar2 default sys_context('bars_context','user_branch'))
    is
       l_kv     varchar2(5);
       l_opdate date;
       l_branch varchar2(50);
    begin
       l_branch := get_branch(p_branch);
       l_kv     := upper(p_kv);

       bars_audit.trace(G_MODULE||'make_cash_journal_repdata: ����� ��������� '||l_branch);

       begin
          select opdate
            into l_opdate
            from cash_open
           where branch  = l_branch
             and shift = 1
             and opdate between p_date and p_date + 0.999;
       exception when no_data_found then
           bars_audit.trace(G_MODULE||'������ ����� ����� - ����');
           make_cash_journal_repdata2(
               p_date   ,
               p_userid ,
               l_kv     ,
               p_nlsmask,
               l_branch);
           return;
       end;

       execute immediate 'truncate table tmp_cashpayed';

       insert into tmp_cashpayed(
              acc, nls, kv, nms, optype,
              s, sq, dk,
              nd, sk,
              nlsk, nmsk,
              post_userid,
              ostf, ostfq, nazn, branch)
       select
              a.acc, a.nls, a.kv, a.nms, decode(l.dk, 0, decode(a.pap, 1, 1,   0), decode(a.pap, 1, 0, 1) ),
              l.s,  decode(a.kv, 980, l.s, gl.p_icurval( a.kv, l.s, l.fdat)), l.dk,
              o.nd,  bars_cash.get_sk( a.nls, o.nlsa, o.nlsb, o.kv, o.kv2, o.sk),
              a2.nls,
              substr(a2.nms,1,38),
              userid,
              sign(s.ostf)*s.ostf,  sign(s.ostf) * decode(a.kv, 980, s.ostf, gl.p_icurval( a.kv, s.ostf, l.fdat)),
              get_nazn(o.nazn,o.tt, l.tt) nazn,
              a.branch
         from accounts a, cash_snapshot s, oper o,
              opldok l,  opldok l2, accounts a2
        where (a.nbs like '10%'  or a.nbs like '11%')
          and a.nls    like p_nlsmask
          and a.kv =  decode(l_kv, '980', 980, a.kv)
          and a.kv <> decode(l_kv, '<>980', 980, 0)
          and s.branch = l_branch
          and s.opdate = l_opdate
          and a.acc    =  s.acc
          and l.acc    =  a.acc
          and l.ref    = l2.ref
          and l.stmt   = l2.stmt
          and l.dk     = 1 - l2.dk
          and l2.acc   = a2.acc
          and l.ref    = o.ref
          and o.userid = decode(p_userid, 0, o.userid, p_userid)
          and o.pdat between  p_date and  p_date + 0.999;


    end;


    ------------------------------------------------------------------
    -- ENQUE_REF
    --
    --  �������� ���.+id ������ � ������� ��� �������� - ��� ���� �������� ��� ���
    --
    --  p_ref
    --  p_userid
    --
    procedure enque_ref(
               p_ref     number,
               p_userid  number )
    is
    begin
       insert into cash_refque(ref, userid)
       values(p_ref, p_userid);

    end;

    ------------------------------------------------------------------
    --  CHECK_FOR_CASHVISA
    --
    --  �� ���� � ��� ���������� ���������� - �������� ���-� ��� ���
    --
    --  return - 1 cash, 0 - nocash
    --
    function check_for_cashvisa( p_ref number, p_status number, p_groupid number) return number
    is
       l_iscash number;
       l_ref    number;
    begin

       -- ���� ��������� ��� ���� ������ ��-�����
       if p_status = 2 or p_status = 0 then
          -- ���� �� ����������� �������� ���
          if bars_cash.is_cashvisa(p_groupid)  = 1 then
             l_iscash := 1;
          else
             -- �������� ���� �� ��������, �� �� ������ ����� (��������, ���� ������ ��������)
             -- �� �������� ��������� ������, ��������� �������� ������ ��� �� �������� ��������
             begin
                select ref into l_ref
                  from opldok o, accounts a, cash_nbs cn
                 where o.acc = a.acc
                   and o.ref = p_ref
                   and a.nbs = cn.nbs
                   and rownum = 1;
                l_iscash := 1;
             exception when no_data_found then
                l_iscash := 0;
             end;
          end if;

       -- ���� �����������.
       else
          -- �� ��� ��������
          if bars_cash.is_cashvisa(p_groupid, p_status)  = 1 then
             l_iscash := 1;
          else

			 -- �������� ���� �� ��������, �� �� ������ ����� (��������, ���� ������ ��������) +  07 �������� �������� tai_oper_visa
             -- �� �������� ��������� ������, ��������� �������� ������ ��� �� �������� ��������
			begin
                select ref into l_ref
                  from opldok o, accounts a, cash_nbs cn
                 where o.acc = a.acc
                   and o.ref = p_ref
                   and a.nbs = cn.nbs
                   and rownum = 1;
                l_iscash := 1;
             exception when no_data_found then
                l_iscash := 0;
             end;

			 end if;
       end if;

       return l_iscash;
    end;


    ------------------------------------------------------------------
    --  VALIDATE_FOR_CASHVISA
    --
    --  ������� �� ������� �������� � ������ � ���������������� ��� - �������� �� ��� ����.
    --  ��� ������������� ������, ��������� ���������� � cash_lastvisa
    --
    --  p_refcount -���-�� ����������, �������������� �� ���� ����
    --
    procedure validate_for_cashvisa( p_refcount     number default 10000)
    is
       l_branch  branch.branch%type;
       l_iscash  smallint       := 0;
       l_ref     number;
       l_tt      varchar2(3);
       l_refl    number;
       l_trace   varchar2(1000) := G_TRACE||'validate_for_cashvisa:';
    begin

       bars_audit.info(l_trace||'������ ������� ��� �� �������� �������������� �����');


       for c in (select c.ref, c.userid, status, groupid, dat, o.KF
                   from cash_refque c, oper_visa o
                  where c.ref = o.ref and c.userid = o.userid
                    and rownum <= p_refcount
                    and status <> 0
                  union all  -- ��� ��, ������� ���� � ������� ��-�����
                 select c.ref, r.userid, status, groupid, dat, o.KF
                   from cash_refque c, oper_visa o, oper r
                  where c.ref = o.ref and c.ref = r.ref
                    and rownum <= p_refcount
                    and currvisagrp is null
                    and status = 0
                ) loop

           l_iscash := check_for_cashvisa(c.ref, c.status, c.groupid);

           if l_iscash = 1 then
             begin
               
               select branch into l_branch
                 from staff$base
                where id = c.userid;
             
               bars_audit.info(l_trace||'l_branch='||l_branch||' ref= '||c.ref);
               -- ���� ������������,��� ������� �� /, �� ��� ��������, ����� ��������� ����� � ��� ������� �� oper_visa,
               -- ��������� ���������� ������ �� ����� ������ �� ����������� ������������, ����� ������� �����������
               if l_branch = '/' then
                  l_branch := '/'||c.kf||'/';
               end if;
              
             end;

             begin
                 -- ������ ���� � ��� ���. �������� ���� ��������
                 insert into cash_lastvisa(kf, ref, dat,userid, branch)
                 values( c.KF, c.ref, c.dat, c.userid, l_branch) ;
             exception when dup_val_on_index then
                 bars_audit.error(l_trace||'�������� ���='||c.ref||' userid='||c.userid||' ��� ���� � ������ ���');
                 null;
             end;

             --���� ���� ��������� � ������� ������ (����)
              select refl into l_refl
                from oper
               where ref = c.ref;

              if l_refl is not null then
                 bars_audit.info(l_trace||'��������� � ���='||c.ref||' ����='||l_refl||' userid='||c.userid);
                 insert into cash_lastvisa( kf, ref, dat, userid, branch )
                 select KF, ref, c.dat, c.userid, l_branch
                   from oper
                  where ref <> c.ref
                  start with ref = c.ref connect by prior refl = ref;
              end if;
           end if;

           delete from cash_refque where ref = c.ref and userid = c.userid;
       end loop;

    exception when others then
       bars_audit.error(l_trace||'������ ���������� ������� ������� ���: '||sqlerrm);
       raise;
    end;




    ------------------------------------------------------------------
    -- INIT_PACK
    --
    --
    --
    procedure init_pack
    is
       l_isusecash smallint := 0;
    begin

       G_CURRSHIFT := current_shift;

       -- ������������, ���  ������ ������� ���������� �����
	   /*begin
          select 1 into l_isusecash
          from v_cashaccounts
          where rownum = 1;
       exception when no_data_found then null;
       end;
	   */

       G_ISUSECASH := 1;
       --bars_audit.trace('���������� �� ����� ='||G_CURRSHIFT );

       -- �������� �������� �� � ���������� �������� �� TTS (9-� ����)
       -- ����� ������������������ ��� ���������� ������
	   /*if tts_list.count  = 0 then
          for c in (select tt, sk, nazn
                      from tts where substr(flags, 10,1)  <> 0) loop
              tts_list(c.tt).sk     := c.sk;
              tts_list(c.tt).nazn   := c.nazn;
          end loop;
       end if;
	   */

    end;


begin
   init_pack;
end bars_cash;
/
 show err;
 
PROMPT *** Create  grants  BARS_CASH ***
grant EXECUTE                                                                on BARS_CASH       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_CASH       to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_cash.sql =========*** End *** =
 PROMPT ===================================================================================== 
 