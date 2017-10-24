create or replace view v_mbdk_partner as
select c.rnk, c.NMK, b.mfo, b.bic
from CUSTOMER c
join CUSTBANK b on c.rnk = b.rnk
where c.DATE_OFF is null 
    and c.custtype=1 
    and ( ( c.codcagent = 1 and b.mfo <> '300465' )
           or
          ( c.codcagent = 2 and b.bic is not null )
        )
    and c.codcagent in (1,2);

grant select on v_mbdk_partner to bars_access_defrole;
