
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_dwhcck.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_DWHCCK 
is
    -------------------------------------------------------------------
    --                                                               --
    --         ������������ �������� ���������� �������� � ��������� --
    --                                                               --
    -------------------------------------------------------------------



    -----------------------------------------------------------------
    -- ���������                                                   --
    -----------------------------------------------------------------

    VERSION_HEAD      constant varchar2(64)  := 'version 1.0  29.12.2011';

    -----------------------------------------------------------------
    -- ����������
    -----------------------------------------------------------------


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
    -- START_LOAD_ROUTINE
    --
    -- ���������� �������� �� ������ ��������
    --
    --
    procedure start_load_routine(p_date date);



    ------------------------------------------------------------------
    -- FINISH_LOAD_ROUTINE
    --
    -- ���������� �������� �� ��������� ��������
    --
    -- p_errcode - 0 - �������� �������,  1 - c �������
    -- p_errmsg  - ��������� �� ������
    --
    procedure finish_load_routine(p_date date, p_errcode number, p_errmsg varchar2);



    ------------------------------------------------------------------
    -- GET_DATE_TO_LOAD
    --
    -- �������� �������� ���� ��� ��������
    --
    --
    function get_date_to_load return date;


    ------------------------------------------------------------------
    -- CHECK_IMPORT_STATUS
    --
    -- p_date        - ���� ������������ ��� ���������
    -- p_daymon_flag - ��� ���. ��������� (0-�������, 1-��������)
    -- p_retcode     - 0 - ����� ���������, 1 - ������ ���������
    -- p_errmsg      - ����� ���������
    --
    --
    procedure check_import_status(
                                  p_date            date,
                                  p_daymon_flag     number,
                                  p_errmsg      out varchar2,
                                  p_retcode     out number);





    ------------------------------------------------------------------
    -- SET_IMPORT_STATUS
    --
    -- ��������� ������ ��������
    --
    -- p_date        - ���� ������������ ��� ���������
    -- p_daymon_flag - ��� ���. ��������� (0-�������, 1-��������)
    --
    --
    procedure set_import_status(p_date date, p_daymon_flag number);





    ------------------------------------------------------------------
    -- NEST_DBLCREDITS
    --
    -- ��������� ��������� ������� dwh_tmp_dblcredits
    -- ���������, � ������� ���� ������� ����������� �� ��� 2202  ��� �� 2203 ��� 2233
    --
    -- p_date        - ���� ������������
    -- p_daymon_flag - ��� ���. ��������� (0-�������, 1-��������)
    --
    --
    procedure nest_dblcredits(p_date date);

end bars_dwhcck;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_DWHCCK 
is
    -------------------------------------------------------------------
    --                                                               --
    --         ������������ �������� ���������� �������� � ��������� --
    --                                                               --
    -------------------------------------------------------------------


    -----------------------------------------------------------------
    -- ���������                                                   --
    -----------------------------------------------------------------

    VERSION_BODY      constant varchar2(64)  := 'version 1.0 29.12.2011';
    G_MODULE          constant varchar2(4)   := 'DWHC';
    G_TRACE     constant varchar2(100)       := 'bars_cckdwh.';


    ------------------------------------------------------------------
    -- HEADER_VERSION
    --
    --
    --
    function header_version return varchar2 is
    begin
       return 'Package header bars_cckdwh: '||VERSION_HEAD;
    end header_version;




    ------------------------------------------------------------------
    -- BODY_VERSION
    --
    --
    --
    function body_version return varchar2 is
    begin
       return 'Package body bars_cckdwh: '||VERSION_BODY;
    end body_version;




    ------------------------------------------------------------------
    -- START_LOAD_ROUTINE
    --
    -- ���������� �������� �� ������ ��������
    --
    --
    procedure start_load_routine(p_date date)
    is
       l_trace varchar2(1000) := G_MODULE||'start_load_routine: ';
    begin
       bars_audit.info(l_trace||' ����� �������� '||to_char(p_date,'dd/mm/yyyy'));
       update dwh_import_stat set status = 'LOADING' where bank_date = p_date;
    end;



    ------------------------------------------------------------------
    -- FINISH_LOAD_ROUTINE
    --
    -- ���������� �������� �� ��������� ��������
    --
    -- p_errcode - 0 - �������� �������,  1 - c �������
    -- p_errmsg  - ��������� �� ������
    --
    procedure finish_load_routine(p_date date, p_errcode number, p_errmsg varchar2)
    is
       l_trace varchar2(1000) := G_MODULE||'finish_load_routine: ';
    begin
       bars_audit.info(l_trace||' ��������� �������� '||to_char(p_date,'dd/mm/yyyy'));

       if p_errcode = 0 then
          update dwh_import_stat set status = 'LOADED' where bank_date = p_date;
       else
          update dwh_import_stat set status = 'ERROR', errmsg = substr(p_errmsg,1,1000)
           where bank_date = p_date;
           bars_audit.error(l_trace||'������: '||p_errmsg);
       end if;
    end;




    ------------------------------------------------------------------
    -- GET_DATE_TO_LOAD
    --
    -- �������� �������� ���� ��� ��������
    --
    --
    function get_date_to_load return date
    is
       l_date date;
    begin
       select min(bank_date) into l_date
         from dwh_import_stat d
        where status = 'NEW_ALL'
          and not exists
             (select 1 from  dwh_import_stat
               where status in ('NEW_DAY',  -- � ���������� ����� �� ������ ���� ������ �������
                                'NEW_MON',  -- ������ ��������
                                'ERROR',    -- ������
                                'LOADING')  -- ��� � ������ ��������
                 and bank_date < d.bank_date
             );

       return l_date;

    end;
    ------------------------------------------------------------------
    -- CHECK_IMPORT_STATUS
    --
    -- �������� ����������� ����������� ���������� ���. ���������
    --
    --
    -- p_date        - ���� ������������ ��� ���������
    -- p_daymon_flag - ��� ���. ��������� (0-�������, 1-��������)
    -- p_retcode     - 0 - ����� ���������, 1 - ������ ���������
    -- p_errmsg      - ����� ���������
    --
    --
    procedure check_import_status(
                                  p_date            date,
                                  p_daymon_flag     number,
                                  p_errmsg      out varchar2,
                                  p_retcode     out number)
    is
       l_stat         dwh_import_stat%rowtype;
       l_maxdate      date;
       l_type         varchar2(3);  -- ������� ����: ������ ������� = DAY, �������+�������� = ALL
       l_status       varchar2(10);
       l_trace        varchar2(1000) := G_MODULE||'.check_import_status: ';
    begin

       bars_audit.info(l_trace||'������ �������� ����������� ���������� ���. ��������� �� '||to_char(p_date,'dd-mm-yyyy')||' ���: '||case when p_daymon_flag=1 then '��������' else '�������' end);

       begin

          -- ��� �������� �������� - ��� ��������� ���� ������ ��� ���
          if p_daymon_flag = 1 then
             -- ������ ������ ���� ��������� ����: �������� ��� �������
             select max(dat) into l_maxdate
               from ( select trunc(p_date,'mm')-1 + level dat
                        from dual
                     connect by level <= to_char(last_day(p_date), 'dd')
                    )
              where dat not in (select holiday from holiday);

             if p_date <> l_maxdate then
                p_errmsg  := '���� '||to_char(p_date,'dd/mm/yyy')||' �� �������� ��������� ����� ������ - ���������� �������� ����������';
                p_retcode := 1;
                return;
             end if;
          end if;


          select * into l_stat from dwh_import_stat where bank_date = p_date;
          bars_audit.info(l_trace||'������ ���� ��� ���� � ������ ����������� �� �������� '||l_stat.type);

          --����� ���� ��� ����
          if l_stat.type = 'DAY' then    -- �� ���� ���� ������ ���� ������ �������
             case l_stat.status
                  when 'NEW_DAY' then    -- ��������� ��� ���� ���������� �� ���� ����, �� �� ��������� - ��������� ��������� ��� ���
                                      p_errmsg  := '��������� ��� ���� ���������, �� �� ��������� - ��������� ��������� ��� ��� ';
                                      p_retcode := 0;
                  when 'NEW_MON' then    -- �������� ������ ��� �������
                                      p_errmsg  := '��� ��������� ������� ���. ��������� �� '||to_char(p_date)||' � ������� ������� �������� ��������� ������������ ������ '||l_stat.status;
                                      p_retcode := 1;
                  when 'NEW_ALL' then    -- �������� ������ ��� �������
                                      p_errmsg  := '��� ��������� ������� ���. ��������� �� '||to_char(p_date)||' � ������� ������� �������� ��������� ������������ ������ '||l_stat.status;
                                      p_retcode := 1;
                  when 'ERROR'  then
                                      p_errmsg  := '��� �������� � ��������� ��������� ������. ���������� ������ ��������� �� ��� ����� ��������������';
                                      p_retcode := 1;
                  when 'LOADED' then
                                      p_errmsg  := '������ ���� ��� ��������� � ��������� - ��������� ���������� ����������';
                                      p_retcode := 1;
                  when 'LOADING' then
                                      p_errmsg  := '������ ���� ����������� � ��������� - ��������� ���������� ����������';
                                      p_retcode := 1;
                  else                p_errmsg  := '����������� ��� ������� �������� '||l_stat.status;
                                      p_retcode := 1;
             end case;
          else                        -- �� ���� ���� ������ ���� ������� � ��������
              case l_stat.status
                  when 'NEW_DAY' then
                                      p_errmsg  := '������� ��������� ��� ���� ���������, ����� ��������';
                                      p_retcode := 0;
                  when 'NEW_MON' then
                                      p_errmsg  := '�������� ��������� ��� ���� ���������, �� �� ���������. ����������� ���������� ';
                                      p_retcode := 0;
                  when 'NEW_ALL' then
                                      p_errmsg  := '�������� � ������� ��������� ��� ���� ���������, �� �� ���������. ����������� ���������� ��������';
                                      p_retcode := 0;
                  when 'ERROR'  then
                                      p_errmsg  := '��� �������� � ��������� ��������� ������. ���������� ������ ��������� �� ��� ����� ��������������';
                                      p_retcode := 1;
                  when 'LOADED' then
                                      p_errmsg  := '������ ���� ��� ��������� � ��������� - ��������� ���������� ����������';
                                      p_retcode := 1;
                  when 'LOADING' then
                                      p_errmsg  := '������ ���� ����������� � ��������� - ��������� ���������� ����������';
                                      p_retcode := 1;
                  else                p_errmsg  := '����������� ��� ������� �������� '||l_stat.status;
                                      p_retcode := 1;
              end case;
          end if;

          bars_audit.info(l_trace||p_errmsg);
          return;

       exception when no_data_found then
          bars_audit.info(l_trace||'����������� �� ������ ����� �� �����������');
          p_retcode := 0;
       end;
    end;


    ------------------------------------------------------------------
    -- SET_IMPORT_STATUS
    --
    -- ��������� ������ ��������
    --
    -- p_date        - ���� ������������ ��� ���������
    -- p_daymon_flag - ��� ���. ��������� (0-�������, 1-��������)
    --
    --
    procedure set_import_status(p_date date, p_daymon_flag number)
    is
       l_stat         dwh_import_stat%rowtype;
       l_maxdate      date;
       l_type         varchar2(3);  -- ������� ����: ������ ������� = DAY, �������+�������� = ALL
       l_status       varchar2(10);
       l_trace        varchar2(1000) := 'dwh_set_import_status: ';
    begin

       begin


          select * into l_stat from dwh_import_stat where bank_date = p_date;

          --����� ���� ��� ����
          if l_stat.type = 'DAY' then    -- �� ���� ���� ������ ���� ������ �������

             if p_daymon_flag = 1 then   -- ���������� ��� ������� ��� - �������, � ������� ���� �������� - �������
                return;
             end if;
             case l_stat.status
                  when 'NEW_DAY' then  l_status := 'NEW_ALL';   -- ���� �������, � �� �� ���������������
                  when 'NEW_ALL' then  l_status := 'NEW_ALL';   -- ���� �������, � �� �� ���������������
                  when 'NEW_MON' then  l_status := 'NEW_ALL';   -- ��������� ������ ����� ������, � �� �� ���������������
                  else return;
             end case;
          else                           -- �� ���� ���� ������ ���� �������  � ��������
             if p_daymon_flag = 0  then  -- ��������� ��������� �������
                case l_stat.status
                     when 'NEW_DAY' then  l_status := 'NEW_DAY';  -- ���� �������, � �� �� ���������������
                     when 'NEW_MON' then  l_status := 'NEW_ALL';  -- ���� ��������, � �� �� ��������� ������� � �������� ������
                     when 'NEW_ALL' then  l_status := 'NEW_ALL';  -- ���� ������, � �� ��������������� �������
                    else return;
                end case;
             else                      -- ��������� ��������� ��������
                case l_stat.status
                     when 'NEW_DAY' then  l_status := 'NEW_ALL';  -- ���� �������, � �� ��������� ��������
                     when 'NEW_MON' then  l_status := 'NEW_MON';  -- ���� ��������, � �� �� ���������������
                     when 'NEW_ALL' then  l_status := 'NEW_ALL';  -- ���� ������, � �� ��������������� �������
                    else return;
                end case;
             end if;
          end if;

          delete from dwh_import_stat where bank_date = p_date;
          l_type := l_stat.type;

       exception when no_data_found then

          -- ������ ������ ���� ��������� ����: �������� ��� �������
          select max(dat) into l_maxdate
            from ( select trunc(p_date,'mm')-1 + level dat
                     from dual
                  connect by level <= to_char(last_day(p_date), 'dd')
                 )
          where dat not in (select holiday from holiday);

          l_type := 'DAY';
          if p_date = l_maxdate then
             l_type := 'ALL';
          end if;


          -- ������ ��� ������
          if p_daymon_flag = 0 then     -- ��������� �������
             if  l_type = 'DAY' then    -- � ���� ������� ������ �������
                 l_status := 'NEW_ALL';
             else                       -- � ���� ������� ��� ������� ��� � ��������
                 l_status := 'NEW_DAY';
             end if;
          else                       -- ��������� ��������
             if  l_type = 'DAY' then    -- � ���� ������� ������ �������
                 bars_error.raise_error(l_trace||' ���������� �������� ��������� �� ����, ������� �� �������� ��������� ���� ������');
             else                       -- � ���� ������� ��� ������� ��� � ��������
                 l_status := 'NEW_MON';
             end if;
          end if;

       end;

       insert into dwh_import_stat(sys_date, bank_date, type, status, retry_cnt)
       values(sysdate, p_date, l_type, l_status, 0 );

    end;



    ------------------------------------------------------------------
    -- NEST_DBLCREDITS
    --
    -- ��������� ��������� ������� dwh_tmp_dblcredits
    -- ���������, � ������� ���� ������� ����������� �� ��� 2202  ��� �� 2203 ��� 2233
    --
    -- p_date        - ���� ������������
    -- p_daymon_flag - ��� ���. ��������� (0-�������, 1-��������)
    --
    --
    procedure nest_dblcredits(p_date date)
    is
    begin
       delete from  dwh_tmp_dblcredits;

       insert into dwh_tmp_dblcredits(g00, gt, gr, g59)
       select g00, gt, gr, g59
         from ( select g00, gt, gr, g59, count(*)  cnt
                  from inv_cck_fl
                 where g19 in ('2202','2203') and gr <> 'I'
                 group by g00, gt, gr, g59
              )
        where cnt > 1;
    end;


end bars_dwhcck;
/
 show err;
 
PROMPT *** Create  grants  BARS_DWHCCK ***
grant EXECUTE                                                                on BARS_DWHCCK     to BARSDWH_ACCESS_USER;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_dwhcck.sql =========*** End ***
 PROMPT ===================================================================================== 
 