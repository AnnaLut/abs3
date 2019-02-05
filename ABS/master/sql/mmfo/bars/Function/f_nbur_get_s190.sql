
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/function/f_nbur_get_s190.sql =*** Run ***
PROMPT ===================================================================================== 

create or replace function f_nbur_get_s190(p_date in date, p_value in number) return varchar2
is
  l_rez  kl_s190.s190%TYPE;
begin 
    select max(s190_rez) into l_rez
      from (select v.*
                  ,case 
                     when UPPER(ove) is null and p_value = v and d is null then s190
                     when UPPER(ove) is null and p_value = 0 and v is null and d is null then s190
                     when UPPER(ove) is null and is_number(v)=1 and is_number(d)=1 and p_value >=v and p_value <=d then s190
                     when UPPER(ove)='ÏÎÍÀÄ' and p_value > NVL(D,V) then s190
                     else null
                  end s190_rez
             from (select S190
                          ,regexp_substr(k.txt,'^[ïÏ][îÎ][íÍ][àÀ][äÄ]{1,}',1,1) ove
                          ,regexp_substr(k.txt,'[0-9]{1,}',1,1) v
                          ,regexp_substr(k.txt,'[0-9]{1,}',1,2) d
                     from kl_s190 k
                    where p_date >= DATA_O
                      and ( p_date <= DATA_C or DATA_C is null)
                   ) v
            )
      where s190_rez is not null;

      if (l_rez is null) then 
        l_rez := case 
--                      when p_value = 0   then '0'
                      when p_value between 1   and 7   then 'A'
                      when p_value between 8   and 30  then 'B'
                      when p_value between 31  and 60  then 'C'
                      when p_value between 61  and 90  then 'D'
                      when p_value between 91  and 180 then 'E'
                      when p_value between 181 and 360 then 'F'
                      when p_value > 360               then 'G'
--                      else null
                     else '0'
	
                 end;
      end if;
      return l_rez;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/function/f_nbur_get_s190.sql =*** End ***
PROMPT ===================================================================================== 
