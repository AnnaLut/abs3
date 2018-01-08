
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_createfilename.sql =========*** R
 PROMPT ===================================================================================== 
 
CREATE OR REPLACE FUNCTION BARS.F_CREATEFILENAME (
                                sNumFile varchar2,  -- KODF из KL_F00
                                sGCode varchar2,    -- A017 из KL_F00
                                dtRepDate date,     -- отчетная дата
                                nFileId number
                        ) return varchar2 is
----------------------------------------------------------------
--    Функция для формирования имени файла отчетности      --
----------------------------------------------------------------
--    VERSION:  19/06/2015 (02/02/2011)                       --
----------------------------------------------------------------
    sPeriod         varchar2(1);   -- Period из V_F00
    sCQNum          varchar2(1);    -- Nom из V_F00
    sFPrefix        varchar2(1);  -- F_PREF из V_F00
    sNumExt         varchar2(2);   -- KODF_EXT из V_F00
    sEBox           varchar2(3);     -- UUU из V_F00
    ----------------------------------------
    FileName_       varchar2(100);
    prefix_         varchar2(1):=substr(trim(sFPrefix),1,1);
    dtExtDate_      date := dtRepDate;
    nDayN_          number := to_number(to_char(sysdate, 'dd'));  
    nMonthN_        number := to_number(to_char(sysdate, 'mm'));
    nI_             number;
    nPeriod_        number;
    dDatf           date;
    l_version_id    number; 
    
    function f_ret_lit_code(p_code in number) return varchar2
    is
    begin
        return chr(iif_n(p_code, 9, ascii(p_code), ascii(p_code), p_code + 55));
    end;       
begin
    begin
        select null f_pref, null kodf_ext, upper(e_address) uuu, upper(F.PERIOD_TYPE) 
        into sFPrefix, sNumExt, sEBox, sPeriod
        from NBUR_REF_FILES f, NBUR_REF_FILES_LOCAL l
        where f.id = nFileId and
            f.id = l.file_id;       
    exception
        when no_data_found then return null;
    end;

    begin
        select f.version_id, f.finish_time, f.file_name
        into l_version_id, dDatf, FileName_
        FROM NBUR_LST_FILES f, NBUR_REF_FILES s
        WHERE     f.file_id = nFileId
              and f.report_date = dtRepDate 
              AND s.id = f.file_id
              AND f.FILE_STATUS IN ('FINISHED', 'BLOCKED');
    exception
        when no_data_found then return null;
    end;
    
    if l_version_id <= 35 then
       sCQNum := nvl(f_ret_lit_code(l_version_id), '1');
    else
       sCQNum := nvl(f_ret_lit_code(mod(l_version_id, 35)), '1');
    end if;
    
    nPeriod_ := ascii(sPeriod);
    prefix_ := nvl(trim(sFPrefix), '#');

    if nPeriod_ = 84 
    then
        if dtRepDate between to_date('21'||to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy')
                         and to_date(to_char(last_day(dtRepDate),'DD')||to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy')
        then 
           --dtExtDate_ := trunc( dtRepDate + 16 , 'mm');
           dtExtDate_ := to_date('21' || to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy');
        ElsIf dtRepDate between to_date('11'||to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy')
                            and to_date('20'||to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy')
           then 
              --dtExtDate_ := to_date('21' || to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy');
              dtExtDate_ := to_date('11' || to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy');
        ElsIf dtRepDate between to_date('01'||to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy')
                            and to_date('10'||to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy')
           then 
              --dtExtDate_ := to_date('11' || to_char(dtRepDate,'MM') || to_char(dtRepDate,'YYYY'),'ddmmyyyy');
              dtExtDate_ := trunc( dtRepDate , 'mm');
        else
           null;
        end if;                         
    end if;
    
--    FileName_ :=  prefix_ ||
--                  nvl(sNumExt, sNumFile) ||
--                  Upper(trim(sEBox)) ||
--                  chr(iif_n(nMonthN_, 9, ascii(nMonthN_), ascii(nMonthN_), nMonthN_ + 55)) ||
--                  chr(iif_n(nDayN_, 9, ascii(nDayN_), ascii(nDayN_), nDayN_ + 55))||
--                  '.'||
--                  Upper(substr(sGCode, 1, 1));
--
    case nPeriod_
        when 53 then -- Once in 5 day
            nI_ := floor(nDayN_ / 5);

            If Mod(nDayN_, 5)>0 then
                nI_ := nI_ + 1;
            end if;

            If nI_ = 6 then
                dtExtDate_ := trunc(dtExtDate_ + 6, 'mm');
            Else
                dtExtDate_ := trunc(dtExtDate_, 'mm') + (nI_ * 5) + 1;
            end if;
        when 68  then  -- Daily
            dtExtDate_ := F_WorkDay(dtExtDate_ + 1, 1);
        when 77 then -- Month
            null;
        when 80  then  -- HalfMonth
            If nDayN_ < 16 then
               dtExtDate_ := trunc( dtExtDate_, 'mm' ) + 15;
            Else
               dtExtDate_ := trunc( dtExtDate_ + 16 , 'mm');
            end if;
         when 84 then -- Decade
            null;
        when 87 then -- Weekly
            dtExtDate_ := trunc( dtExtDate_ + 7, 'ww');
        else
            nI_ := 32 - nDayN_;
            dtExtDate_ := trunc( dtExtDate_ + nI_, 'mm');
    end case;

    nDayN_   := to_number(to_char(dtExtDate_, 'dd'));
    nMonthN_ := to_number(to_char(dtExtDate_, 'mm'));
--
--    If substr(upper(trim(sPeriod)), 1, 1) in ('M', 'Q', 'H', 'Y') then
--        FileName_ := FileName_ || chr(iif_n(nMonthN_, 9, ascii(nMonthN_), ascii(nMonthN_), nMonthN_ + 55));
--    else
--        FileName_ := FileName_ || chr(iif_n(nDayN_, 9, ascii(nDayN_), ascii(nDayN_), nDayN_ + 55));
--    end if;
--
--    if trunc(dDatf) <> trunc(sysdate) then
--       sCQNum := '1';
--
--    end if;

    FileName_ := FileName_ ||'_' || to_char(dtExtDate_,'ddmmyyyy');

    return FileName_;
end;
/
 show err;
 
PROMPT *** Create  grants  F_CREATEFILENAME ***
grant EXECUTE                                                                on F_CREATEFILENAME to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_createfilename.sql =========*** E
 PROMPT ===================================================================================== 
 