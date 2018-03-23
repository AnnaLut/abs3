begin

for cust in (select c.rnk from customer c where c.codcagent in (select t.codcagent from codcagent t where t.rezid = 2) and c.custtype = 3 and c.ise = '00000'
                                          and not (country IN (11,900) AND k050 = '910')) loop
UPDATE customer c SET c.ISE = '20000' where C.RNK = cust.rnk;
end loop;
commit;

end;
/

begin

for cust in (select c.rnk from customer c where c.codcagent in (select t.codcagent from codcagent t where t.rezid = 1) and c.custtype = 3 and c.ise = '00000'
                                          and not (country IN (11,900) AND k050 = '910')) loop
UPDATE customer c SET c.ISE = '14300' where C.RNK = cust.rnk;
end loop;
commit;

end;
/

