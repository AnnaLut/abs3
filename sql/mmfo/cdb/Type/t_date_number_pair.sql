
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/type/t_date_number_pair.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE CDB.T_DATE_NUMBER_PAIR as object
(
       date_value date,
       number_value number(22, 12),
       map member function map_value return number
)
/
CREATE OR REPLACE TYPE BODY CDB.T_DATE_NUMBER_PAIR as
       map member function map_value return number
       is
           l_year integer;
           l_month integer;
           l_day integer;
       begin
           l_year := extract(year from date_value);
           l_month := extract(month from date_value);
           l_day := extract(day from date_value);
           return power(10, 22) * (l_year * 366 + l_month * 31 + l_day) + number_value;
       end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/type/t_date_number_pair.sql =========*** End 
 PROMPT ===================================================================================== 
 