
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_createheadline.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CREATEHEADLINE (
                        sNumFile varchar2,  -- KODF из V_F00
                        sGCode varchar2,    -- A017 из V_F00
                        dtRepDate date,     -- отчетная дата
                        sFileName varchar2, -- название файла
                        nCnt number         -- количество строк в файле (только строки с показателями)
) return varchar2 is
------------------------------------------------------------------------------
-- Функция для формирования части служебной строки файла отчетности         --
-- AA=DDMMYYY1=DDMMYYY2=DDMMYYY3=DDMMYYY4=HHMM=MFO=NN=YYYYYYYYY=NAMEFILE=   --
------------------------------------------------------------------------------
-- VERSION: 04.06.2010
------------------------------------------------------------------------------
   sRDate_ varchar2(8);
   sPeriod_ varchar2(1);
   sMFO_ varchar2(6):= F_OURMFO;
   sMsmt_ varchar2(30);
   bTurnSign_ boolean;
   sGNum_ varchar2(2);

   strLine_ varchar2(200);
   dtRDate_ date;
   nPeriodCode_ number;   -- Код символа периода
   nDayN_ number;
   nMonthN_ number;
   nI_ number;

   sSuperDate_ varchar2(8);    -- Дата (период отчетности)
   sStartDate_ varchar2(8);    -- Дата начала отчетного периода
   sStopDate_ varchar2(8);     -- Дата окончания отчетного перода

   sRepCode_ varchar2(2);
   nParamCount_ number;
begin
    begin
        select period, nn, aa
        into sPeriod_, sMsmt_, sGNum_
        from KL_f00
        where kodf=sNumFile and
              a017=sGCode and
              trim(branch) <> '/';
    exception
        when no_data_found then return null;
    end;

    nPeriodCode_ := ascii(sPeriod_);
    dtRDate_ := trunc(dtRepDate) - 1;

    nDayN_   := to_number(to_char(dtRDate_, 'dd'));
    nMonthN_ := to_number(to_char(dtRDate_, 'mm'));

    sStopDate_ := to_char(dtRDate_, 'ddmmyyyy');

    case nPeriodCode_
        when 53 then -- Once in 5 day
            nI_ := floor(nDayN_ / 5);

            If Mod(nDayN_, 5)>0 then
                nI_ := nI_ + 1;
            end if;

            sStartDate_ := to_char(trunc(dtRDate_, 'mm') + ((nI_ - 1) * 5), 'ddmmyyyy');

            If nI_ = 6 then
                dtRDate_ := trunc(dtRDate_ + 6, 'mm');
            Else
                dtRDate_ := trunc(dtRDate_, 'mm') + (nI_ * 5) + 1;
            end if;
        when 68  then  -- Daily
            sStartDate_ := sStopDate_;
            dtRDate_ := F_WorkDay(dtRDate_ + 1, 1);
        when 80  then  -- HalfMonth
            If nDayN_ < 16 then
               sStartDate_ := to_char( trunc( dtRDate_, 'mm' ), 'ddmmyyyy' );
               dtRDate_ := trunc( dtRDate_, 'mm' ) + 15;
            Else
               sStartDate_ := to_char( trunc( dtRDate_, 'mm' ) + 15, 'ddmmyyyy' );
               dtRDate_ := trunc( dtRDate_ + 16 , 'mm');
            end if;
        when 87 then -- Weekly
            sStartDate_ := to_char( trunc( dtRDate_, 'ww' ), 'ddmmyyyy' );
            dtRDate_ := calcdat1(trunc( dtRDate_ + 7, 'ww'));
        when 77 then -- Monthly
            dtRDate_ := dtRDate_ + 1;

            sStartDate_ := to_char(add_months(dtRDate_, -1), 'ddmmyyyy');
            sStopDate_  := to_char(last_day(add_months(dtRDate_, -1)), 'ddmmyyyy');

            -- Если месячный файл содержит данные только по остаткам
            If instr(nvl(F_get_params('SFOTCN'), ''), sNumFile) <= 0 then
                sStartDate_ := sStopDate_;
            end if;
        when 81 then -- 1/4 year
            dtRDate_ := dtRDate_ + 1;

            sStartDate_ := to_char(add_months(dtRDate_, -3), 'ddmmyyyy');
            sStopDate_  := to_char(dtRDate_ - 1, 'ddmmyyyy');

            -- Если квартальный файл содержит данные только по остаткам
            If instr(nvl(F_get_params('SFOTCN'), ''), sNumFile) <= 0 then
                sStartDate_ := sStopDate_;
            end if;
        when 84 then -- 10 days
            If nDayN_ >= 1   AND nDayN_ < 11 then
                sStartDate_ := to_char(trunc(dtRDate_, 'mm'), 'ddmmyyyy');
                dtRDate_ := trunc(dtRDate_, 'mm')+10;
            ElsIf nDayN_ >= 11 AND nDayN_ < 21 then
                sStartDate_ := to_char(trunc(dtRDate_, 'mm')+10, 'ddmmyyyy');
                dtRDate_ := trunc(dtRDate_, 'mm')+20;
            elsIf nDayN_ >= 21 AND nDayN_ <= 31 then
                sStartDate_ := to_char(trunc(dtRDate_, 'mm')+20, 'ddmmyyyy');
                dtRDate_ := trunc(dtRDate_+15, 'mm');
            end if;
        else
            nI_ := 32 - nDayN_;
            sStartDate_ := sStopDate_;
            dtRDate_ := to_date('01' || to_char( dtRDate_ + nI_, 'mmyyyy'), 'ddmmyyyy');
    end case;

    sSuperDate_ := to_char( dtRDate_, 'ddmmyyyy');

    strLine_ := lpad(sGNum_, 2, '0') || '=' || sSuperDate_ || '=' || sStartDate_ || '=' || sStopDate_ || '=' ||
               to_char(sysdate, 'ddmmyyyy') || '=' || lpad(to_char(sysdate, 'hh24mi'), 4, '0') || '=' ||
               sMFO_ || '=' || sMsmt_ || '=' || lpad(to_char(nCnt), 9, '0') || '=' || sFileName || '=';

    return strLine_;

end F_CREATEHEADLINE;
/
 show err;
 
PROMPT *** Create  grants  F_CREATEHEADLINE ***
grant EXECUTE                                                                on F_CREATEHEADLINE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_createheadline.sql =========*** E
 PROMPT ===================================================================================== 
 