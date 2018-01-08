
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bpk_s_vart.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BPK_S_VART (p_ number, nd_ varchar2, mode_ number)
return number
is
ret_  number;
lim_  number:=0;
prc_ number:=0;
mmax_ number:=12;

fpd_ number:=0;
ppd_ number:=0;
dy_ number:=0;

PRAGMA AUTONOMOUS_TRANSACTION;

/*
функция для печати в договорах по БПК таблицы стоимости кредита
*/

begin



lim_:=0;
mmax_:=0;
prc_:=0;
fpd_:= 0;
dy_:= 365;

select

DECODE(P_,0,
  ( case
  when to_number(to_char(sysdate,'dd'))<25
  then (25-to_number(to_char(sysdate,'dd'))+to_number(to_char(last_day(sysdate),'dd')))
  when to_number(to_char(sysdate,'dd'))>25
  then (25+to_number(to_char(last_day(sysdate),'dd'))-to_number(to_char(sysdate,'dd'))+to_number(to_char(last_day(add_months(sysdate,1)),'dd')))
  else
  to_number(to_char(last_day(sysdate),'dd'))
  end),to_number(to_char(last_day(add_months(sysdate,P_)),'dd')))  --cколько дней в периоде
,
  case
  when mod(to_number(to_char(add_months(sysdate,p_),'YYYY')),4)=0
  then 366
  else 365 end --сколько дней в году платежного периода
,
  nvl(a.lim/100,0) --лимит овера
,
nvl(
case
    when to_number(to_char(sysdate,'DD'))>25 then
    to_number(nvl(f_acc_tag(a.acc,'PK_TERM'),cm.MM_MAX))
    --months_between(add_months(trunc(dat_begin,'MON'),nvl(cm.MM_MAX,12)),trunc(sysdate,'MON'))
   else
    to_number(nvl(f_acc_tag(a.acc,'PK_TERM'),cm.MM_MAX))+1

  end
  , 12)
,

nvl(f_acc_tag(a.acc,'W4_KPROC'),cm.percent_cred) -- процент по кредиту - берем из cm_product

into fpd_, dy_, lim_, mmax_, prc_


from accounts a, cm_product cm , W4_acc b, w4_card c

where
    C.CODE=B.CARD_CODE
    and C.PRODUCT_CODE=CM.PRODUCT_CODE(+)
    and b.ACC_PK=ND_
    and A.ACC=b.ACC_PK
;

if mode_=8 --cколько дней в периоде
then
    begin
    ret_:=fpd_;
    end;

ELSIF mode_=0 --%% ПО ПЛАТЕЖУ
then
BEGIN

    if p_<MMAX_-1
     then
    --dbms_output.put_line(LIM_||'|'||MMAX_||'|'||PRC_||'|'||fpd_||'|'||DY_);
      --ret_:=trunc((LIM_-P_*LIM_/(MMAX_-1))*(PRC_/100)*fpd_/DY_,2);
       ret_:=round((LIM_-P_*LIM_/(MMAX_-1))*(PRC_/100)*fpd_/dy_,2);
    else
       ret_:=0;
    end if;
END;

ELSIF MODE_=1 --СУМА ПОГАШЕНИЯ на период

THEN
BEGIN

    if p_=0
    then
    ret_:=round((LIM_/(MMAX_-1))+(lim_-(MMAX_-1)*round(LIM_/(MMAX_-1),2)),2);
    elsif (p_<MMAX_-1 and p_>0)
    then
    ret_:=round(LIM_/(MMAX_-1),2);
    else
    ret_:=0;
    end if;

END;

ELSIF MODE_=2 --общ СУМА %

THEN
BEGIN
--dbms_output.put_line(mmax_);
ret_:=0;
    for k in 1..mmax_
    loop
    --dbms_output.put_line(ret_||' '||nd_);
    ret_:=ret_+bpk_s_vart(k-1,nd_,0);
    end loop;
END;

ELSIF MODE_=3 --общ СУМА погашения
THEN
BEGIN
--dbms_output.put_line(mmax_);
ret_:=0;
    for k in 1..mmax_
    loop
    --dbms_output.put_line(ret_||' '||nd_);
    ret_:=ret_+bpk_s_vart(k-1,nd_,1);
    end loop;
END;


ELSIF MODE_=4 -- СУМА платежу за розр. пер
THEN
BEGIN
--dbms_output.put_line(mmax_);
--ret_:=0;

    --dbms_output.put_line(ret_||' '||nd_);
    ret_:=bpk_s_vart(p_,nd_,0)+bpk_s_vart(p_,nd_,1);


END;


ELSIF MODE_=5 --общ  СУМА платежу за весь. пер
THEN
BEGIN
--dbms_output.put_line(mmax_);
ret_:=0;
    for k in 1..mmax_
    loop
    --dbms_output.put_line(ret_||' '||nd_);
    ret_:=ret_+bpk_s_vart(k-1,nd_,4);
    end loop;
END;


ELSIF MODE_=6 --дата погашения
THEN
BEGIN
--dbms_output.put_line(mmax_);
ret_:=0;

select
case
when (to_number(to_char(add_months(sysdate,p_),'dd')))<=25 then to_number((to_char(add_months(add_months(sysdate,p_),1),'yyyymm')||'25'))
when (to_number(to_char(add_months(sysdate,p_),'dd')))>25 then to_number((to_char(add_months(add_months(sysdate,p_),2),'yyyymm')||'25'))

end
into ret_
from dual;


END;

ELSIF MODE_=7 --%% rhtl
THEN
BEGIN
--dbms_output.put_line(mmax_);
ret_:=0;
if bpk_s_vart(0,nd_,4)<>0
then
    insert into TMP_BPK_s_vart (dt, summ)
    select trunc(sysdate) dt, nvl(decode(p_,0,-lim_,-lim_*((100-p_)/100)),0) summ from dual;

    begin
    for k in 0..mmax_-1
     loop
     insert into TMP_BPK_s_vart (dt, summ)
      (select to_date(bpk_s_vart(k,nd_,6), 'yyyymmdd') dt, bpk_s_vart(k,nd_,4) summ from dual);
     end loop;
    end;

           select round((1/pd-1)*100,4) into ret_ from
            (select * from TMP_BPK_s_vart
             model
                dimension by (row_number() over (order by dt) rn)
                measures(dt-first_value(dt) over (order by dt) dt, summ s, 0 ss, 0 f_a, 0 f_b, 0 f_x, 0 a, 1 b, 0 pd, 0 iter)
                rules iterate(10000) until (abs(f_x[1])< power(10,-4))
                      (ss[any]=s[CV()]*power(a[1],dt[CV()]/dy_),
                       f_a[1]=sum(ss)[any],
                       ss[any]=s[CV()]*power(b[1],dt[CV()]/dy_),
                       f_b[1]=sum(ss)[any],
                       pd[1]=a[1]-f_a[1]*(b[1]-a[1])/(f_b[1]-f_a[1]),
                       ss[any]=s[CV()]*power(pd[1],dt[CV()]/dy_),
                       f_x[1]=sum(ss)[any],
                       a[1]=decode(sign(f_a[1]*f_x[1]),1,pd[1],a[1]),
                       b[1]=decode(sign(f_a[1]*f_x[1]),1,b[1],pd[1]),
                       iter[1]=iteration_number+1
                      )
               )
               where rn=1;
    commit;
else ret_:=0;
end if;






end;


end if;
return ret_;
end bpk_s_vart;
/
 show err;
 
PROMPT *** Create  grants  BPK_S_VART ***
grant EXECUTE                                                                on BPK_S_VART      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bpk_s_vart.sql =========*** End ***
 PROMPT ===================================================================================== 
 