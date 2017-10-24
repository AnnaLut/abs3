
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/strcomp.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.STRCOMP (sp1_ varchar2, sp2_ varchar2)
return number
is
/*
* Date:   15.04.2009
* Author: Mary
* Desc:   функция нечеткого сравнения строк: возвращает расстояние Левенштейна между строками,
*         т.е. количество исправлений для преобразования первой во вторую
*/
   l1  number := nvl(length(sp1_),0);
   l2  number := nvl(length(sp2_),0);
   type vi is table of number index by binary_integer;
   -- собственно лев
   prev_col vi;
   tek_col  vi;
   del_cost number:=1;
   ins_cost number:=1;
   repl_cost number;
   s1_ varchar2(100);
   s2_ varchar2(100);

begin
   -- проверяем крайние случаи нулевых строк
   if l1=0 then return l2;
   end if;
   if l2=0 then return l1;
   end if;
   -- переводим в нижний регистр
   s1_ := lower(sp1_);
   s2_ := lower(sp2_);
   -- алгоритм Левенштейна со вставкой, удалением и заменой по цене 1
   for j in 0..l1 loop
      prev_col(j) := j;
   end loop;
   for i in 1..l2 loop
      tek_col(0) := i;
      for j in 1..l1 loop
         -- цена замены
         if (substr(s1_,j,1)=substr(s2_,i,1))
            then repl_cost:=0;
            else repl_cost:=1;
         end if;
         -- вычисление клетки
         tek_col(j) := least(tek_col(j-1)+ins_cost, prev_col(j)+del_cost, prev_col(j-1)+repl_cost);
      end loop;
      -- переход к следующей строке
      for j in 0..l1 loop
         prev_col(j):=tek_col(j);
      end loop;
   end loop;
   return tek_col(l1);
end strcomp;
 
/
 show err;
 
PROMPT *** Create  grants  STRCOMP ***
grant EXECUTE                                                                on STRCOMP         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/strcomp.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 