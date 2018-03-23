
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_ret_nbsr_rez.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_RET_NBSR_REZ (nlsa_ varchar2,
                                               r013a_ varchar2,
                                               s080a_ varchar2,
                                               id_ in varchar2,
                                               kva_ in number := null,
                                               ob22a_ in varchar2 := null,
                                               custtype_ in number := null,
                                               accr_ in number := null
                                               ) return varchar2
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    -- version  17.03.2017    (02.03.2016, 15.04.2014)

  17.03.2017  изменение набора R013 для счетов резервов
                 -без разбивки по S080 для основного и просроченного долга
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

    nbsr_   varchar2(4);
    r013r_  varchar2(1);

    -- балансовые счета дисконта
    nbsdiscont_     VARCHAR2 (2000)
      := '2016,2026,2036,2066,2076,2086,2106,2116,2126,2136,2206,2216,2226,2236,';

    -- балансовые счета премии
    nbspremiy_      VARCHAR2 (2000)
        := '2065,2075,2085,2105,2115,2125,2135,2205,2215,2235,';

    ret_    varchar2(100);
begin
  -- тимчасово зберігається стара версія
  if kva_ is null
  then
      if substr(nlsa_,1,1) like '1%' then
         if substr(nlsa_,1,4) like '150%' and substr(nlsa_,1,4) <> '1502' then
             nbsr_ := '1592';

             if substr(nlsa_,1,4) = '1500' then

                    r013r_ := '6';
             else
                 if substr(nlsa_,1,4) = '1508' and r013a_ = '3' then
                    r013r_ := '4';
                 else
                    r013r_ := '5';
                 end if;
             end if;
         elsif substr(nlsa_,1,4) like '181%' then
             nbsr_ := '1890';
             r013r_ := '0';
         else
             nbsr_ := '1590';

             if substr(nlsa_,4,1) not in ('8','9') then

                    r013r_ := '7';
             else
                if f_ourmfo = 353575 then
                    if substr(nlsa_,1,4)||r013a_ in ('15080','15083','15185','15180','15186','15280','15285','15286') then
                        r013r_ := '6';
                    else
                        r013r_ := '5';
                    end if;
                else
                    if substr(nlsa_,1,4) = '8' then
                        r013r_ := '6';
                    else
                        r013r_ := '5';
                    end if;
                end if;
             end if;
         end if;
      elsif substr(nlsa_,1,3) in ('357') then
         nbsr_ := '3599';

         if r013a_ = '3' then
            r013r_ := '4';
         else
            r013r_ := '5';
         end if;
      elsif substr(nlsa_,1,3) in ('371') then
         nbsr_ := '3599';
         r013r_ := '0';
      elsif substr(nlsa_,1,3) in ('351','354','355') then
         nbsr_ := '3590';
         r013r_ := '0';
      elsif substr(nlsa_,1,3) = '280' then
         nbsr_ := '2890';
         r013r_ := '0';
      elsif substr(nlsa_,1,1) not in ('1', '3')
         and substr(nlsa_,1,4) not in ('9000', '9001', '9020', '9023','9100', '9122','9129')
      then
         if id_ like 'RU%' then
            nbsr_ := '2401';
         else
            nbsr_ := '2400';
         end if;

         if substr(nlsa_,4,1) not in ('8','9') and
            substr(nlsa_,1,4) not in ('2607', '2627', '2657')
         then

                r013r_ := '8';
         else
             if f_ourmfo = 353575 then
                 if r013a_ = '3' and substr(nlsa_,4,1) <> '9' then
                    r013r_ := '4';
                 else
                    r013r_ := '5';
                 end if;
             else
                 if substr(nlsa_,4,1) = '8' then
                    r013r_ := '4';
                 else
                    r013r_ := '5';
                 end if;
             end if;
         end if;
      elsif substr(nlsa_,1,4) in ('9000')  then
         nbsr_ := '3690';

         r013r_ := '0';

      elsif substr(nlsa_,1,4) in ('9001', '9020', '9023','9100', '9122','9129')  then
         nbsr_ := '3692';

         r013r_ := '0';

      elsif substr(nlsa_,1,3) in ('310', '311')  then
         nbsr_ := '3190';

         r013r_ := '9';

         if substr(nlsa_,1,4) in ('3103','3105','3106','3107') then
            if r013a_ = '2' then
                r013r_ := '4';
            elsif  r013a_ = '1' then
                r013r_ := '5';
            end if;
         end if;

         if substr(nlsa_,1,4) in ('3108','3118') then
            if r013a_ in ('3', '5', '7', 'D') then
                r013r_ := 'A';
            elsif  r013a_ in ('4', '6', '8', 'E') then
                r013r_ := 'B';
            else
                r013r_ := '7';
            end if;
         end if;

         if  substr(nlsa_,1,4) = '3114' then
            r013r_ := '7';
         end if;

         if  substr(nlsa_,1,4) = '3119' then
            r013r_ := 'B';
         end if;
      else
         nbsr_ := '0000';
         r013r_ := '0';
      end if;
  else
     if accr_ is null then
         if instr(nbsdiscont_, substr(nlsa_, 1, 4)) > 0 or
            instr(nbspremiy_, substr(nlsa_, 1, 4)) > 0
         then
            ret_ := f_ret_nbsr_rez(nlsa_, r013a_, s080a_, id_);
            return ret_;
         end if;

         begin
            select nbs_rez,
                nvl(trim((case when r013 = 7 and s080a_ = '1' then 6 else r013 end)), '0') r013
            into nbsr_, r013r_
            from (select *
                  from srezerv_ob22
                  where nbs = substr(nlsa_, 1, 4) and
                        (ob22 = ob22a_ or ob22 = '0') and
                        (s080 = s080a_ or s080 = '0') and
                        (kv = kva_ or kv = '0')
                  order by ob22 desc, kv desc      )
            where rownum = 1;

            if nbsr_ = '3190' and r013r_ = '0' then
               r013r_ := '9';

               if substr(nlsa_,1,4) in ('3103','3105','3106','3107') then
                  if r013a_ = '2' then
                     r013r_ := '4';
                  elsif  r013a_ = '1' then
                     r013r_ := '5';
                  end if;
               end if;

               if substr(nlsa_,1,4) in ('3108','3118') then
                  if r013a_ in ('3', '5', '7', 'D') then
                     r013r_ := 'A';
                  elsif  r013a_ in ('4', '6', '8', 'E') then
                     r013r_ := 'B';
                  else
                     r013r_ := '7';
                  end if;
               end if;
            end if;
         exception
            when no_data_found then
                ret_ := f_ret_nbsr_rez(nlsa_, r013a_, s080a_, id_);
                return ret_;
         end;

         if nbsr_ = '3190' and r013r_ in ('1', '2') then
            if nlsa_ like '___9%' then
               r013r_ := 'B';
            elsif nlsa_ like '___8%' then
               r013r_ := 'A';
            else
               r013r_ := '7';
            end if;
         end if;
     else

--dbms_output.put_line(accr_);
         begin
            select a.nbs, nvl(trim(s.r013), '0') r013
            into nbsr_, r013r_
            from accounts a, specparam s
            where a.acc = accr_ and
                a.acc = s.acc(+);
--
--
--            if (substr(nbsr_,1,4) like '159%' or
--                nbsr_ in ('3599') or 
--                substr(nbsr_,1,4) like '3690%') and
--                r013r_ = '0'
--            then
--                ret_ := f_ret_nbsr_rez(nlsa_, r013a_, s080a_, id_);
--                return ret_;
--            end if;
         end;
     end if;
  end if;

--  переопределение r013, если взято из specparam
     case
        when nbsr_ ='1592' and r013r_ in ('1','2')   then  r013r_ :='6';
        when nbsr_ ='1590' and r013r_ in ('1','4')   then  r013r_ :='7';
        when nbsr_ ='2400' and r013r_ in ('6','7')   then  r013r_ :='8';
        when nbsr_ ='2401' and r013r_ in ('6','7')   then  r013r_ :='8';
        when nbsr_ ='3690' and r013r_ in ('1','2')   then  r013r_ :='0';
          else   null;
     end case;


  return nbsr_ || r013r_;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_ret_nbsr_rez.sql =========*** End
 PROMPT ===================================================================================== 

