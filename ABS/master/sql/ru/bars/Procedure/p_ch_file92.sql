

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE92.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_CH_FILE92 ***

  CREATE OR REPLACE PROCEDURE BARS.P_CH_FILE92 (kodf_ varchar2,dat_ date,userid_ number) is

s1007_b  Number;
s1007_e  Number;
s_39     Number;
s_66     Number;

begin

   delete from otcn_log where userid = userid_ and kodf = kodf_;

   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'Перев_рка файла #92 (символiв 39 и 66)');

   select nvl(sum(ABS(ost+dos-kos)),0) into s1007_b from sal
   where nbs='1007' and kv=980 and fdat=Dat_;
   select nvl(sum(ABS(ost)),0) into s1007_e from sal
   where nbs='1007' and kv=980 and fdat=Dat_;

   select nvl(sum(to_number(znap)),0) into s_39 from tmp_nbu where KODF=kodf_
         and DATF=dat_ and kodp='39';

   select nvl(sum(to_number(znap)),0) into s_66 from tmp_nbu where KODF=kodf_
       and DATF=dat_ and kodp='66';


   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'');
   insert into otcn_log (kodf,userid,txt)
    values(kodf_,userid_,'Остаток 1007 вихiдний '||to_char(Abs(s1007_e))||
    ' + сим. 39 '||to_char(s_39)||' - 1007 вхiдний '||
    to_char(Abs(s1007_b))||' =  сим. 66 '||to_char(s_66));

   if s_39+s1007_e-s1007_b<>s_66 THEN
      insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'Вiдхилення = '||to_char(s_39+s1007_e-s1007_b-s_66));
   else
      insert into otcn_log (kodf,userid,txt)
       values(kodf_,userid_,'ОК ');
   end if;

end p_ch_file92;
/
show err;

PROMPT *** Create  grants  P_CH_FILE92 ***
grant EXECUTE                                                                on P_CH_FILE92     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_CH_FILE92.sql =========*** End *
PROMPT ===================================================================================== 
