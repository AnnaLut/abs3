
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_s260.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_S260 (f_nd number, f_acc number, f_s260 varchar2,
    rnk_ number default null, nbs_ VARCHAR2 default null, default_ number default 1) return varchar2
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- versions     22.01.2019     (07/11/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 22.01.2019   для счетов 262  установливается s260=08
-- 08/06/2012 изменил только текст комментария (Версия от 03/03/2012 установлена не у Всех)
--            и передана скорее всего не всем (в Днепропетровске новая в Николаеве нет)
-- 03/03/2012 для ЮЛ сначала устанавливаем S260r_ ='08' и затем определяем по N дог. из ND_TXT
--            и при отсутствии в ND_TXT из SPECPARAM
-- 29/02/2012 вместо кода 06 (iнше) будем формировать новый код 08 (iнше ...)
--            изменения в кл-ре KL_S260
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
is
    s260_k      varchar2(10);
    k051_       VARCHAR2(2);
    custtype_   number;
    s260r_      varchar2(10);
begin
    if f_nd is not null then
        begin
          SELECT max((substr(trim(t.txt),1,2)))
          into s260_k
          FROM nd_txt t
          WHERE t.nd = f_nd
            and t.tag='S260';

           s260r_ := nvl(trim(s260_k), nvl(f_s260,'00'));
        end;
     else
         BEGIN
              SELECT max(NVL(substr(trim(t.txt),1,2), nvl(f_s260,'00')))
              INTO  s260_k
              FROM nd_acc n, nd_txt t
              WHERE n.acc=f_acc
                and n.nd=t.nd
                and t.tag='S260';

              s260r_ := nvl(trim(s260_k), nvl(f_s260,'00'));
         END;
    end if;

---------            установка s260=08 для счетов 262 
              if nbs_ like '262%'  then
                 s260r_ := '08';
              end if;
---------
    if default_ = 0 then
       if nvl(trim(s260r_), '00') = '00' and f_s260 <> '00' then
		  s260r_ := f_s260;
	   end if;

       return nvl(trim(s260r_), '00');
    else
       if s260r_ = '00' then
          s260r_ := '08';
       end if;

       return nvl(trim(s260r_), '00');
    end if;
end f_get_s260;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_s260.sql =========*** End ***
 PROMPT ===================================================================================== 
 