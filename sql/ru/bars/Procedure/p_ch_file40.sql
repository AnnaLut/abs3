

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE40.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE40 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE40 (kodf_ varchar2,dat_ date,userid_ number) is
-- 14.10.2010 добавляем проверку для файла @40 и #02

 c_       number;
 kol_     number;
 sum_a_   number;
 sum_p_   number;
 sum_o_d_ number;
 sum_o_k_ number;
 nbs_     Varchar2(4);
 Dat1_    Date;
 flag_    number :=0;

begin

Dat1_:= TRUNC(Dat_,'MM');

delete from otcn_log
where userid = userid_ AND kodf = '40';

insert into otcn_log (kodf,userid,txt) VALUES
                     (kodf_,userid_,'Перевiрка файлу @40  з  файлом #02');

 insert into otcn_log (kodf,userid,txt)
        values(kodf_,userid_,'');

select count(*)
   into flag_
from tmp_nbu
where kodf='02'
  and datf = Dat_ ;

if flag_ = 0 then
   insert into otcn_log (kodf,userid,txt) VALUES
                        (kodf_,userid_,'За данную дату не сформирован файл #02');
   insert into otcn_log (kodf,userid,txt)
          values(kodf_,userid_,'');
end if;

if flag_ != 0 then
   for k in
   ( select substr(kodp,1,1)  kod,
   	 substr(kodp,2,4)  nbs,
	 SUM(to_number(znap)) zna
     from tmp_irep
     where kodf=kodf_ and datf=dat_
     group by substr(kodp,1,1), substr(kodp,2,4)
     order by 2,1)
   loop


   sum_a_ := 0;
   sum_p_ := 0;
   sum_o_d_ := 0;
   sum_o_k_ := 0;


   begin
      if k.kod='1' then
         select NVL(SUM(to_number(znap)),0) into sum_a_
         from tmp_nbu
         where kodf='02'
           and substr(kodp,1,6)='10'||k.nbs
           and datf = Dat_ ;
      end if;

      if k.kod='2' then
         select NVL(SUM(to_number(znap)),0) into sum_p_
         from tmp_nbu
         where kodf='02'
           and substr(kodp,1,6)='20'||k.nbs
           and datf = Dat_ ;
      end if;

      if k.kod='5' then
         select NVL(SUM(to_number(znap)),0) into sum_o_d_
         from tmp_nbu
         where kodf='02'
           and substr(kodp,1,6)='50'||k.nbs
           and datf = Dat_ ;
      end if;

      if k.kod='6' then
         select NVL(SUM(to_number(znap)),0) into sum_o_k_
         from tmp_nbu
         where kodf='02'
           and substr(kodp,1,6)='60'||k.nbs
           and datf = Dat_ ;
      end if;

      if k.kod='1' THEN
         if k.kod='1' and k.zna <> sum_a_ THEN
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Ошибка !!! Бал. счет = '||k.nbs|| ' Дт остаток @40 не равен Дт остатку #02');

            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Дт остаток @40 = '|| to_char(k.zna) ||
                ' Дт остаток файла #02 = ' || to_char(sum_a_) ||
                ' разница = ' || to_char(k.zna-sum_a_));
         else
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Дт остатки по счету '||k.nbs||' ОК !!!');

         end if;
      end if;

      if k.kod='2' THEN
         if k.kod='2' and k.zna <> sum_p_ THEN
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Ошибка !!! Бал. счет = '||k.nbs|| ' Кт остаток @40 не равен Кт остатку #02');

            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Кт остаток @40 = '|| to_char(k.zna) ||
                ' Кт остаток файла #02 = ' || to_char(sum_p_) ||
                ' разница = ' || to_char(k.zna-sum_p_));
         else
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Кт остатки по счету '||k.nbs||' ОК !!!');

         end if;
      end if;

      if k.kod='5' THEN
         if k.kod='5' and k.zna <> sum_o_d_ THEN
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Ошибка !!! Бал. счет = '||k.nbs|| ' Дт оборот @40 не равен Дт обороту #02');

            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Дт оборот @40 = '|| to_char(k.zna) ||
                ' Дт оборот файла #02 = ' || to_char(sum_o_d_) ||
                ' разница = ' || to_char(k.zna-sum_o_d_));
         else
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Дт оборот по счету '||k.nbs||' ОК !!!');

         end if;
      end if;

      if k.kod='6' THEN
         if k.kod='6' and k.zna <> sum_o_k_ THEN
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Ошибка !!! Бал. счет = '||k.nbs|| ' Кт оборот @40 не равен Кт обороту #02');

            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Кт оборот @40 = '|| to_char(k.zna) ||
                ' Кт оборот файла #02 = ' || to_char(sum_o_k_) ||
                ' разница = ' || to_char(k.zna-sum_o_k_));
         else
            insert into otcn_log (kodf,userid,txt) values
               ('40',userid_,' Кт оборот по счету '||k.nbs||' ОК !!!');

         end if;
      end if;

   end;

   end loop;
end if;

 insert into otcn_log (kodf,userid,txt)
        values(kodf_,userid_,'');

end p_ch_file40;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE40.sql =========*** End *
PROMPT ===================================================================================== 
