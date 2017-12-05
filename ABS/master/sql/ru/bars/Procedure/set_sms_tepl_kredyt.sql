CREATE OR REPLACE PROCEDURE BARS.set_sms_tepl_kredyt(in_ number) IS

err    EXCEPTION;
BEGIN
for k in (
select r.*, VERIFY_CELLPHONE(tel) vt from
(
select
    a.acc,A1.ACC acc_2620, a.nls nls_2203, a1.nls nls_2620,c.rnk ,
    substr(case when instr(c.value,'+380')>0 then c.value when substr(c.value,1,1)='0'
            then '+38'||c.value when substr(c.value,1,2)='38' then '+'||c.value else c.value end,1,20) tel

from accounts a, customerw c, nd_acc n, nd_acc n1, accounts a1
    where
        ((a.nbs=decode(NEWNBS.GET_STATE,0,'2202','2203') and a.ob22 in (decode(NEWNBS.GET_STATE,0,'57','80'),decode(NEWNBS.GET_STATE,0,'58','81')))
        or
        (a.nbs='2203' and a.ob22 in ('47','48') ))
        and c.rnk=a.rnk
        and c.tag='MPNO'
        and n.acc=A.ACC
        and n.nd=n1.nd
        and n1.acc=a1.acc
        and a1.nbs='2620'
        and A1.send_sms is null
        and A1.DAZS is null
) r order by vt)
loop
    begin
        if  k.vt=1 then
        begin
        update accounts set SEND_SMS='Y' where acc=k.acc_2620;
        delete from ACC_SMS_PHONES where acc=k.acc_2620;
        Insert into ACC_SMS_PHONES
        (ACC, PHONE, PHONE1, PHONE2, ENCODE,
            ENCODE1, ENCODE2, DAILYREPORT, PAYFORSMS, SMSCLEARANCE)
        Values
        (k.acc_2620, k.tel, NULL, NULL, 'lat',
        NULL, NULL, NULL, NULL, NULL);
        --dbms_output.put_line('за рахунком '||k.nls_2620||',рнк:'||k.rnk||', що прив''язано до рахунку '||k.nls_2203||' встановлено СМС інформування на номер '||k.tel);

        end;
       -- else
        --dbms_output.put_line('за рахунком '||k.nls_2620||',рнк:'||k.rnk||', що прив''язано до рахунку '||k.nls_2203||' НЕ встановлено СМС інформування на номер '||k.tel||' НОМЕР НЕ ДІЙСНИЙ!!!!');
     end if;
   end;
 end loop;
END set_sms_tepl_kredyt;
/
