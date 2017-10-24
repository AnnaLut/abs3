

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_OVERSOB.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_OVERSOB ***

  CREATE OR REPLACE PROCEDURE BARS.P_OVERSOB 
 ( acc_    number,
   nd_     number,
   ref_    number,
   sob_    number,
   s_      number,
   mdate_  date ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Вставка событий по овердрафтам в cc_sob.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

 nd2_    acc_over.nd%type;
 ndoc_   acc_over.ndoc%type;
 userid_ number;
 txt_    varchar2 (4000);

begin

 if nd_ is null then
   select nd,ndoc into nd2_,ndoc_ from acc_over where acc = acc_ and nvl(sos,0) <> 1;
 else
   nd2_:=nd_;
 end if;

 begin
  select txt
  into txt_
  from acc_over_sobtype
  where id = sob_;
 exception when no_data_found then
  return;
 end;

 if sob_ = 1 or sob_ = 2 then
   null;
 elsif sob_ = 3 then
  txt_:=txt_||' '||to_char(mdate_,'dd.mm.yyyy');
 elsif sob_ = 4 then
  txt_:=txt_||' s ='||to_char(s_/100);
 elsif sob_ = 5 then
  txt_:=txt_||' s ='||to_char(s_/100);
 elsif sob_ = 6 then
  txt_:=txt_||' ref ='||to_char(ref_)||' s='||to_char(s_/100);
 elsif sob_ = 7 then
  null;
 elsif sob_ = 8 then
  txt_:=txt_||' ref ='||to_char(ref_)||' s='||to_char(s_/100);
 elsif sob_ = 9 then
  null;
 elsif sob_ = 10 then
  txt_:=txt_||' lim ='||to_char(s_/100);
 end if;

 select id into userid_ from staff where upper(logname)=upper(user);

 insert into cc_sob(ND,FDAT,ISP,TXT,OTM,FREQ,PSYS)
  values(nd2_,bankdate,userid_,txt_,null,null,null);

exception when others then

  if nd2_ is not null then

    insert into cc_sob(ND,FDAT,ISP,TXT,OTM,FREQ,PSYS)
     values(nd2_,bankdate,userid_,'ошибка генерации события '||to_char(sob_),null,null,null);

  end if;

end p_oversob;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_OVERSOB.sql =========*** End ***
PROMPT ===================================================================================== 
