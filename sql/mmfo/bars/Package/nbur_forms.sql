create or replace package NBUR_FORMS 
is
  g_header_version  constant varchar2(64)  := 'version 1.2  2017.04.09';
  g_header_defs     constant varchar2(512) := '';

  -- header_version - версія заголовку пакета
  function HEADER_VERSION return varchar2;

  -- body_version - версія тіла пакета
  function BODY_VERSION return varchar2;

  function F_RET_EMPT_NBUC
  ( p_type              number,
    p_report_date       date,
    p_report_code       varchar2,
    p_kf                varchar2
  ) return otcn_set_nbuc
  pipelined;

  -- отримання імені файлу
  function F_CREATEFILENAME
  ( p_file_id        in number,
    p_report_date    in date,
    p_kf             in varchar2,
    p_version_id     in number
  ) return varchar2;

  -- отримання заголовного рядку файлу
  function F_CREATEHEADLINE
  ( p_file_id        in number,
    p_report_date    in date,
    p_kf             in varchar2,
    p_version_id     in number
  ) return varchar2;

  -- отримання підзаголовного рядку файлу
  function F_CREATEHEADLINEEX
  ( p_file_id        in number,
    p_report_date    in date,
    p_kf             in varchar2,
    p_version_id     in number,
    p_nbuc           in varchar2
  ) return varchar2;

  -- отримання текстового файлу
  function F_CREATEFILEBODY
  ( p_file_id        in number,
    p_report_date    in date,
    p_kf             in varchar2,
    p_version_id     in number
  ) return clob;

end NBUR_FORMS;
/

show errors;

create or replace package body NBUR_FORMS 
is

g_body_version  constant varchar2(64)  := 'version 4.3 2019.05.24';
g_body_defs     constant varchar2(512) := '';

MODULE_PREFIX   constant varchar2(10)   := 'NBUR';

g_ret           OTCN_NBUC:=OTCN_NBUC(NULL);

-- header_version - версія заголовку пакета
function header_version return varchar2 is
begin
  return 'Package header NBUR_FORMS ' || g_header_version || '.' || chr(10) ||
         'Package header definition(s): ' || chr(10) ||  g_header_defs;
end header_version;

-- body_version - версія тіла пакета
function body_version return varchar2 is
begin
  return 'Package body NBUR_FORMS ' || g_body_version || '.' || chr(10) ||
         'Package body definition(s): ' || chr(10) || g_body_defs;
end body_version;

function f_ret_lit_code(p_code in number) return varchar2
is
begin
    return chr(iif_n(p_code, 9, ascii(p_code), ascii(p_code), p_code + 55));
end;

function f_get_params(par_ in varchar2, default_ in varchar2:=null) return varchar2
is
       val_ params.val%TYPE;
       ret_ VARCHAR2(100);
BEGIN
   SELECT val
   INTO val_
   FROM params
   WHERE LOWER(par)=LOWER(par_);

   ret_ := trim(val_);

   return ret_;
end;

FUNCTION f_ret_empt_nbuc (p_type        NUMBER, 
                          p_report_date DATE, 
                          p_report_code VARCHAR2,
                          p_kf          VARCHAR2
                          )
  RETURN otcn_set_nbuc PIPELINED
IS
  b040_          VARCHAR2 (20);
  type_branch_   NUMBER;
  bpos_          NUMBER;
  nbuc_          VARCHAR2 (20);
  exists_        NUMBER;
  sql_           VARCHAR2 (1000);

  TYPE cursortype IS REF CURSOR;

  curs_          cursortype;
  r_type_        NUMBER;
BEGIN
  IF p_type IN (6, 7)
  THEN
     IF p_type = 6
     THEN
        r_type_ := 1;
     ELSE
        r_type_ := 3;
     END IF;
  ELSE
     r_type_ := p_type;
  END IF;

  IF r_type_ in (1, 2, 4) -- коды областей
  THEN                                                            -- тип 1
     sql_ :=
           'select lpad(ku, 2, ''0'') nbuc '||
           'from spr_b040 '||
           'where (d_open is null or d_open <= :dat_) and  '||
            '     (d_close is null or d_close > :dat_)   '||
           'group by lpad(ku, 2, ''0'') '||
           'order by 1';
  ELSIF r_type_ IN (3, 5)
  THEN                                                            -- тип 2
     sql_ :=
           'select lpad(ku, 2, ''0'')||b041 nbuc '||
           'from spr_b040 '||
           'where (d_open is null or d_open <= :dat_) and  '||
            '     (d_close is null or d_close > :dat_)   '||
           'group by lpad(ku, 2, ''0'')||b041 '||
           'order by 1';
  ELSE
     sql_ := NULL;
  END IF;

  IF sql_ IS NOT NULL
  THEN
     OPEN curs_ FOR sql_ USING p_report_date, p_report_date;

     LOOP
        FETCH curs_
         INTO nbuc_;

        EXIT WHEN curs_%NOTFOUND;
        nbuc_ := TRIM (nbuc_);

        IF nbuc_ IS NOT NULL
        THEN
           -- существуют ли в сформированном файле записи с таким кодом
           BEGIN
              SELECT 1
                INTO exists_
                FROM DUAL
               WHERE EXISTS (
                        SELECT 1
                          FROM NBUR_AGG_PROTOCOLS
                        where report_date = p_report_date and
                              kf = p_kf and
                              report_code = p_report_code AND 
                              nbuc = nbuc_);
           EXCEPTION
              WHEN NO_DATA_FOUND
              THEN
                 exists_ := 0;
           END;

           -- если - нет
           IF exists_ = 0
           THEN
              g_ret.nbuc := nbuc_;
              PIPE ROW (g_ret);
           END IF;
        END IF;
     END LOOP;

     CLOSE curs_;

     IF p_type IN (6, 7)
     THEN
        IF p_type = 6
        THEN
           r_type_ := 4;
        ELSE
           r_type_ := 5;
        END IF;

        FOR k IN (SELECT nbuc
                    FROM TABLE (f_ret_empt_nbuc (r_type_, p_report_date, p_report_code, p_kf)))
        LOOP
           g_ret.nbuc := k.nbuc;
           PIPE ROW (g_ret);
        END LOOP;
     END IF;
  END IF;

  RETURN;
END;
   
-- отримання імені файлу
function f_createfilename (p_file_id        in number,
                           p_report_date    in date,
                           p_kf             in varchar2,
                           p_version_id     in number
                           ) return varchar2
is
    l_NumFile       varchar2(3);
    l_sGCode        varchar2(1);
    l_sPeriod       varchar2(1);
    l_sCQNum        varchar2(1);
    l_sFPrefix      varchar2(1);
    l_sNumExt       varchar2(2);
    l_sEBox         varchar2(3);

    l_nPeriod       numeric;
    l_dtExtDate     date := p_report_date;
    l_FileName      varchar2(100);
    l_nDayN         numeric;
    l_nMonthN       numeric;
    l_nI            numeric;
    l_dDatf         date;
   
    l_report_date    date := p_report_date;    
begin
    if p_version_id <= 35 then
       l_sCQNum := nvl(f_ret_lit_code(p_version_id), '1');
    else
       l_sCQNum := nvl(f_ret_lit_code(mod(p_version_id, 35)), '1');
    end if;

    begin
        select substr(nvl(a.file_code_alt, a.file_code),1,1), 
               substr(nvl(a.file_code_alt, a.file_code),2,2), a.scheme_code,
               b.e_address, a.period_type
        into l_sFPrefix, l_NumFile, l_sGCode, l_sEBox, l_sPeriod
        from NBUR_REF_FILES a, NBUR_REF_FILES_LOCAL b
        where a.id = p_file_id and
              a.id = b.file_id and
              b.kf = p_kf;
    exception
        when no_data_found then return null;
    end;

    l_nPeriod := ascii(l_sPeriod);
    l_sFPrefix := nvl(trim(l_sFPrefix), '#');

    l_nDayN   := to_number(to_char(sysdate, 'dd'));
    l_nMonthN := to_number(to_char(sysdate, 'mm'));
    
    if l_NumFile = '2C' then
       l_report_date := DAT_PREV_U(l_report_date, 1);
       l_dtExtDate := l_report_date;
    end if;

    if l_nPeriod = 84 -- декада
    then
        if l_report_date between to_date('21'||to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy')
                         and to_date(to_char(last_day(l_report_date),'DD')||to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy')
        then
           l_dtExtDate := to_date('21' || to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy');
        ElsIf l_report_date between to_date('11'||to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy')
                            and to_date('20'||to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy')
           then
              l_dtExtDate := to_date('11' || to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy');
        ElsIf l_report_date between to_date('01'||to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy')
                            and to_date('10'||to_char(l_report_date,'MM') || to_char(l_report_date,'YYYY'),'ddmmyyyy')
           then
              l_dtExtDate := trunc(l_report_date , 'mm');
        else
           null;
        end if;
    end if;

    l_FileName :=  l_sFPrefix || nvl(l_sNumExt, l_NumFile) || Upper(trim(l_sEBox)) ||
                  f_ret_lit_code(l_nMonthN) ||
                  f_ret_lit_code(l_nDayN)||
                  '.'||
                  Upper(substr(l_sGCode, 1, 1));

    l_nDayN   := to_number(to_char(l_report_date, 'dd'));
    l_nMonthN := to_number(to_char(l_report_date, 'mm'));

    case l_nPeriod
        when 53 then -- Once in 5 day
            l_nI := floor(l_nDayN / 5);

            If Mod(l_nDayN, 5)>0 then
                l_nI := l_nI + 1;
            end if;

            If l_nI = 6 then
                l_dtExtDate := trunc(l_dtExtDate + 6, 'mm');
            Else
                l_dtExtDate := trunc(l_dtExtDate, 'mm') + (l_nI * 5) + 1;
            end if;
        when 68  then  -- Daily
            l_dtExtDate := F_WorkDay(l_dtExtDate + 1, 1);
        when 77 then -- Month
            l_dtExtDate := add_months(trunc(l_dtExtDate, 'mm'), 1);
         when 84 then -- Decade
            If l_nDayN >= 1   AND l_nDayN < 11 then
               l_dtExtDate := trunc(l_dtExtDate, 'mm') + 10;
            ElsIf l_nDayN >= 11 AND l_nDayN < 21 then
               l_dtExtDate := trunc(l_dtExtDate, 'mm') + 20;
            elsIf l_nDayN >= 21 AND l_nDayN <= 31 then
               l_dtExtDate := trunc(l_dtExtDate+15, 'mm');
            end if;
        when 87 then -- Weekly
            l_dtExtDate := trunc( l_dtExtDate + 7, 'ww');
        else
            l_nI := 32 - l_nDayN;
            l_dtExtDate := trunc( l_dtExtDate + l_nI, 'mm');
    end case;

    l_nDayN   := to_number(to_char(l_dtExtDate, 'dd'));
    l_nMonthN := to_number(to_char(l_dtExtDate, 'mm'));

    If substr(upper(trim(l_sPeriod)), 1, 1) in ('M', 'Q', 'H', 'Y') then
        l_FileName := l_FileName || f_ret_lit_code(l_nMonthN);
    else
        l_FileName := l_FileName || f_ret_lit_code(l_nDayN);
    end if;

    if trunc(l_dDatf) <> trunc(sysdate) or l_sCQNum = 'Z' then
       l_sCQNum := '1';
    else
       if l_sCQNum = '9' then
          l_sCQNum := 'A';
       else
          l_sCQNum := chr(ascii(l_sCQNum));
       end if;
    end if;

    l_FileName := l_FileName || nvl(trim(l_sCQNum), '1');

    return l_filename;
end f_createfilename;

-- отримання заголовного рядку файлу
function f_createheadline (p_file_id        in number,
                           p_report_date    in date,
                           p_kf             in varchar2,
                           p_version_id     in number
                           ) return varchar2
is
   l_headline       varchar2(200);
   l_NumFile        varchar2(2);
   l_FileCode       varchar2(3);
   l_FileName       varchar2(200);
   l_Cnt            number;
   l_Period         varchar2(1);
   l_MFO            varchar2(6):= p_kf;
   l_Msmt           varchar2(30);
   l_GNum           varchar2(2);
   l_FlagTurns      number;

   l_dtRDate        date;
   l_PeriodCode     number;
   l_DayN           number;
   l_MonthN         number;
   l_nI             number;

   l_SuperDate      varchar2(8);    -- Дата (период отчетности)
   l_StartDate      varchar2(8);    -- Дата начала отчетного периода
   l_StopDate       varchar2(8);    -- Дата окончания отчетного перода

   l_file_code      varchar2(3);
   l_ParamCount     number;
   
   l_report_date    date := p_report_date;
begin
    begin
        select nvl(a.file_code_alt, a.file_code), a.UNIT_CODE, a.PERIOD_TYPE, 
               a.SCHEME_NUMBER, a.FLAG_TURNS
        into l_FileCode, l_Msmt, l_Period, l_GNum, l_FlagTurns
        from NBUR_REF_FILES a
        where a.id = p_file_id;
    exception
        when no_data_found then return null;
    end;

    l_NumFile := substr(l_FileCode, 2, 2);

    -- визначення того, чи файл містить обороти, може міститись також в PARAMS
    if l_FlagTurns is null then
       l_FlagTurns := (case when nvl(instr(nvl(F_get_params('SFOTCN'), ''), l_NumFile), 0) <= 0 then 0 else 1 end);
    end if;

    select count(*)
    into l_Cnt
    from NBUR_AGG_PROTOCOLS
    where report_date = p_report_date and
          kf = p_kf and
          report_code = l_FileCode;
    
    l_FileName := f_createfilename(p_file_id, l_report_date, p_kf, p_version_id);

    if l_NumFile = '2C' then
       l_report_date := DAT_PREV_U(l_report_date, 1);
    end if;
    
    l_PeriodCode := ascii(l_Period);
    l_dtRDate := trunc(l_report_date);

    l_DayN   := to_number(to_char(l_report_date, 'dd'));
    l_MonthN := to_number(to_char(l_report_date, 'mm'));

    l_StopDate := to_char(l_dtRDate, 'ddmmyyyy');

    case l_PeriodCode
        when 53 then -- Once in 5 day
            l_nI := floor(l_DayN / 5);

            If Mod(l_DayN, 5)>0 then
                l_nI := l_nI + 1;
            end if;

            l_StartDate := to_char(trunc(l_dtRDate, 'mm') + ((l_nI - 1) * 5), 'ddmmyyyy');

            If l_nI = 6 then
                l_dtRDate := trunc(l_dtRDate + 6, 'mm');
            Else
                l_dtRDate := trunc(l_dtRDate, 'mm') + (l_nI * 5) + 1;
            end if;
        when 68  then  -- Daily
            l_StartDate := l_StopDate;
            l_dtRDate := F_WorkDay(l_dtRDate + 1, 1);
        when 87 then -- Weekly
            l_StartDate := to_char( trunc( l_dtRDate, 'ww' ), 'ddmmyyyy' );
            l_dtRDate := calcdat1(trunc( l_dtRDate + 7, 'ww'));
        when 77 then -- Monthly
            l_dtRDate := last_day(l_dtRDate) + 1;

            l_StartDate := to_char(add_months(l_dtRDate, -1), 'ddmmyyyy');
            l_StopDate  := to_char(last_day(add_months(l_dtRDate, -1)), 'ddmmyyyy');

            -- Если месячный файл содержит данные только по остаткам
            If l_FlagTurns = 0 then
               l_StartDate := l_StopDate;
            end if;
        when 81 then -- 1/4 year
            l_dtRDate := last_day(l_dtRDate) + 1;

            l_StartDate := to_char(add_months(l_dtRDate, -3), 'ddmmyyyy');
            l_StopDate  := to_char(last_day(add_months(l_dtRDate, -1)), 'ddmmyyyy');

            -- Если квартальный файл содержит данные только по остаткам
            If l_FlagTurns = 0 then
                l_StartDate := l_StopDate;
            end if;
        when 84 then -- 10 days
            If l_DayN >= 1   AND l_DayN < 11 then
                l_StartDate := to_char(trunc(l_dtRDate, 'mm'), 'ddmmyyyy');
                l_dtRDate := trunc(l_dtRDate, 'mm')+10;
            ElsIf l_DayN >= 11 AND l_DayN < 21 then
                l_StartDate := to_char(trunc(l_dtRDate, 'mm')+10, 'ddmmyyyy');
                l_dtRDate := trunc(l_dtRDate, 'mm')+20;
            elsIf l_DayN >= 21 AND l_DayN <= 31 then
                l_StartDate := to_char(trunc(l_dtRDate, 'mm')+20, 'ddmmyyyy');
                l_dtRDate := trunc(l_dtRDate+15, 'mm');
            end if;
        else
            l_nI := 32 - l_DayN;
            l_StartDate := l_StopDate;
            l_dtRDate := to_date('01' || to_char( l_dtRDate + l_nI, 'mmyyyy'), 'ddmmyyyy');
    end case;

    l_SuperDate := to_char(l_dtRDate, 'ddmmyyyy');

    l_headline := lpad(l_GNum, 2, '0') || '=' || l_SuperDate || '=' || l_StartDate || '=' || l_StopDate || '=' ||
               to_char(sysdate, 'ddmmyyyy') || '=' || lpad(to_char(sysdate, 'hh24mi'), 4, '0') || '=' ||
               l_MFO || '=' || l_Msmt || '=' || lpad(to_char(l_Cnt), 9, '0') || '=' || l_FileName;

    -- ідентифікатор ключа ІDKEY (6 знаків)
    l_headline := l_headline || '=' || lpad(' ', 6, ' ');

    --електронно-цифровий підпис EDS  (64 знаки)
    l_headline := l_headline || '=' || lpad(' ', 64, ' ');

    return l_headline;
end f_createheadline;

-- отримання підзаголовного рядку файлу
function f_createheadlineex (p_file_id        in number,
                             p_report_date    in date,
                             p_kf             in varchar2,
                             p_version_id     in number,
                             p_nbuc           in varchar2
                            ) return varchar2
is
    l_headlineex    varchar2(200);
    l_loc_code      NBUR_REF_FILES.LOCATION_CODE%type;
    l_MFO           varchar2(20);
    l_report_code   varchar2(3);
    l_GCode         varchar2(1);
    l_nbuc          NBUR_REF_FILES_LOCAL.nbuc%type;
begin
    begin
        select a.location_code, nvl(a.file_code_alt, a.file_code), a.scheme_code, b.nbuc
        into l_loc_code, l_report_code, l_GCode, l_nbuc
        from NBUR_REF_FILES a, NBUR_REF_FILES_LOCAL b
        where a.id = p_file_id and
            a.id = b.file_id and
            b.kf = p_kf;
    exception
        when no_data_found then return null;
    end;

    l_headlineex := '#' || l_loc_code || '=';

    l_MFO := (case when nvl(trim(p_NBUC), '0') = '0' then l_nbuc else trim(p_NBUC) end);

    if length(l_MFO) = 14 then
        l_headlineex := l_headlineex || substr(l_MFO, 1, 2) ||  '=' || substr(l_MFO, 3);
    else
        l_headlineex := l_headlineex || l_MFO;
    end if;

    return l_headlineex;
end f_createheadlineex;

-- отримання текстового файлу
function F_CREATEFILEBODY
( p_file_id        in number,
  p_report_date    in date,
  p_kf             in varchar2,
  p_version_id     in number
) return clob
is
  l_filebody      clob;
  l_row           varchar2(2000);
  l_rpt_code      nbur_ref_files.file_code%type;
  l_rpt_rcode     nbur_ref_files.file_code%type;
  l_nbucp         nbur_agg_protocols.nbuc%type := null;
  l_cnt           number := 0;
  l_nbuc_set      varchar2(20);
  l_list_order    varchar2(20000);
  l_cursor_sel    clob;

  l_nbuc          nbur_agg_protocols.nbuc%type;
  l_field_code    nbur_agg_protocols.field_code%type;
  l_field_value   nbur_agg_protocols.field_value%type;
  
  l_file_fmt      varchar2(20);
  l_len_pok       number;
  l_type_cons     number;
  
  TYPE cursor_type IS REF CURSOR;
  l_cursor         cursor_type;
begin
    -- формуємо службовий рядок
    l_filebody := lpad(' ', 100, ' ')||chr(13)||chr(10);

    -- формуємо заголовний рядок
    l_row := f_createheadline (p_file_id, p_report_date, p_kf, p_version_id);

    l_filebody := l_filebody||l_row||chr(13)||chr(10);

    begin
        select nvl(f.file_code_alt, f.file_code), f.file_code, l.NBUC, 
            f.FILE_FMT, f.CONSOLIDATION_TYPE
          into l_rpt_code, l_rpt_rcode, l_nbuc_set, l_file_fmt, l_type_cons
          from NBUR_REF_FILES f
          join NBUR_REF_FILES_LOCAL l
            on ( l.FILE_ID = f.ID and l.KF = p_kf )
         where f.ID = p_file_id;
    exception
      when no_data_found then
        return null;
    end;

    if l_file_fmt = 'XML'
    then

      NBUR_XML.CRT_FILE( p_file_id   => p_file_id
                       , p_rpt_dt    => p_report_date
                       , p_kf        => p_kf
                       , p_vrsn_id   => p_version_id
                       , p_file_body => l_filebody );
    else

      begin
        select listagg(replace(segment_rule,'kodp','field_code'), ',')
               within group (order by file_id, sort_attribute)
          into l_list_order
          from NBUR_REF_FORM_STRU
         where file_Id = p_file_id and
               sort_attribute is not null and
               nvl(key_attribute, 0)<>0;
      exception
        when no_data_found then l_list_order := null;
      end;

      -- довжина показника
      if l_rpt_code like '#%' then
          begin
              select max(length(trim(kod_ekpok)))
              into l_len_pok
              from ek_pok_1
              where a010 = substr(l_rpt_code,2,2) and
                  data_c is null;
          exception
              when no_data_found then l_len_pok := 0;
          end;
      else
          l_len_pok := 0;
      end if;

      l_cursor_sel := 'select nbuc, '||
                          (case when l_len_pok > 0 then 'substr(' else '' end) ||
                          'field_code'||
                          (case when l_len_pok > 0 then ',1,'||to_char(l_len_pok)||')' else '' end)||
                          ', field_value
                        from NBUR_AGG_PROTOCOLS
                       where report_date = :p_report_date and
                             kf = :p_kf and
                             report_code = :l_rpt_code
                       order by nbuc, '||nvl(l_list_order, 'field_code');

      open l_cursor for l_cursor_sel using p_report_date, p_kf, l_rpt_rcode;

      loop
          FETCH l_cursor INTO l_nbuc, l_field_code, l_field_value;
          EXIT WHEN l_cursor%NOTFOUND;

          -- формуємо підзаголовний рядок
          if l_nbucp is null or l_nbucp <> l_nbuc then
             l_row := f_createheadlineex (p_file_id, p_report_date, p_kf, p_version_id, l_nbuc);
             l_filebody := l_filebody||l_row||chr(13)||chr(10);
          end if;

          -- формуємо рядки з показниками
          l_row := l_field_code || '=' || l_field_value;
          l_filebody := l_filebody||l_row||chr(13)||chr(10);

          l_nbucp := l_nbuc;
          l_cnt := l_cnt + 1;
      end loop;

      close l_cursor;
      
      -- формуємо пусті рядки для тих підрозділів, по яких немає даних
      if p_kf in ('324805', '322669') then
         if (l_type_cons <> '0' or l_cnt = 0) and 
             not (p_kf = '322669' and l_rpt_code = '#E9') then
             FOR k IN (SELECT nbuc
                      FROM TABLE (f_ret_empt_nbuc (l_type_cons, p_report_date, l_rpt_code, p_kf)))
             LOOP
               l_row := f_createheadlineex (p_file_id, p_report_date, p_kf, p_version_id, k.nbuc);
               l_filebody := l_filebody||l_row||chr(13)||chr(10);
             END LOOP;
             
             if l_type_cons = '0' and l_cnt = 0 then
                l_row := f_createheadlineex (p_file_id, p_report_date, p_kf, p_version_id, l_nbuc_set);
                l_filebody := l_filebody||l_row||chr(13)||chr(10);
             end if;
         elsif p_kf = '322669' and l_rpt_code = '#E9' then
             if l_cnt = 0 then
                l_row := f_createheadlineex (p_file_id, p_report_date, p_kf, p_version_id, l_nbuc_set);
                l_filebody := l_filebody||l_row||chr(13)||chr(10);
             end if;

             l_row := f_createheadlineex (p_file_id, p_report_date, p_kf, p_version_id, '320069');
             l_filebody := l_filebody||l_row||chr(13)||chr(10);
         end if;
      -- якщо файл пустий, то підзаголовний рядок все одно потрібен
      elsif p_kf not in ('324805', '322669') and l_cnt = 0 then
         l_row := f_createheadlineex (p_file_id, p_report_date, p_kf, p_version_id, l_nbuc_set);
         l_filebody := l_filebody||l_row||chr(13)||chr(10);
      end if;

      l_filebody := l_filebody||chr(13)||chr(10);

    end if;

    return l_filebody;

  end F_CREATEFILEBODY;

begin
  null;
end NBUR_FORMS;
/

show err;

grant EXECUTE on NBUR_FORMS to BARS_ACCESS_DEFROLE;
grant EXECUTE on NBUR_FORMS to RPBN002;
