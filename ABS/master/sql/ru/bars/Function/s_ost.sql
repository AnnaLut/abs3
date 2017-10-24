
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/s_ost.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.S_OST (acc_ integer, dat1_ date, dat2_ date) RETURN DECIMAL IS
-- возвращает общую сумму остатков за период по календарным дням (учитывая первую и последнюю даты)
-- (используется в дальнейшем к примеру для расчета средневзвешенного остатка период)
 dat_  date;
 mdat_ date;
 xdat_ date;
 ost_  DECIMAL;
 ss_   DECIMAL;
begin
-- меняем первую дату периода (если первая дата в sal больше, чем первая дата периода)
  select min(fdat) into mdat_ from sal where acc=acc_;
   if mdat_<=dat1_ then
    dat_ := dat1_;
   else
    dat_ := mdat_;
   end if;
logger.info ('s_ost1,dat_= '||dat_);
-- устанавливаем предельную дату для суммирования = второй дате периода
-- не имеет значения есть ли такая дата в Sal, если еще не наступила,
-- то будет прогнозный расчет cо значением остатка=текущему
xdat_:=dat2_;
logger.info ('s_ost2,xdat_= '||xdat_);
-- обнуляем сумму
 ss_ := 0;
-- суммируем в выбранном периоде остатки
 while dat_<=xdat_
  loop
   begin
     select ost
     into ost_
     from sal
     where acc=acc_ and fdat=(select max(fdat)
                              from sal
                              where acc=acc_ and fdat<=dat_);
logger.info ('s_ost3,ost_= '||ost_);
   ss_ := ss_ + ost_;
   dat_ := dat_ + 1;
logger.info ('s_ost41,ss_= '||ss_);
logger.info ('s_ost42,dat_= '||dat_);
   end;
  end loop;
return ss_;
end s_ost;
/
 show err;
 
PROMPT *** Create  grants  S_OST ***
grant EXECUTE                                                                on S_OST           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on S_OST           to START1;
grant EXECUTE                                                                on S_OST           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/s_ost.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 