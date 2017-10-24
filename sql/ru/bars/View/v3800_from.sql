create or replace view V3800_From as 
  SELECT a.Branch, a.ob22, a.nls, a.nms, a.ostb/100 PLAN, a.ostc/100 FAKT, a.acc, p.rate_k, p.rate_p,
         To_number ( decode (a.acc, PUL.get('ACCF'), PUL.get('N'), '0') ) N, 
         To_number ( decode (a.acc, PUL.get('ACCF'), PUL.get('K'), '0') ) K, 
         To_number ( decode (a.acc, PUL.get('ACCF'), PUL.get('Q'), '0') ) Q, 
         decode (a.acc, PUL.get('ACCF'), 1 , 0)  FF,  
         decode (a.acc, PUL.get('ACCT'), 1 , 0)  FT ,
         To_number ( PUL.get('REFF') ) REFF, 
         To_number ( PUL.get('REFT') ) REFT  
   FROM accounts a,  (select acc, rate_k, rate_p from spot p1 where p1.vdate=(select max(vdate) from spot where acc=p1.acc)   ) p 
   WHERE a.kv = PUL.get('KV') and a.acc=p.acc (+)  and exists (select 1 from vp_list where acc3800=a.acc)  and a.dazs is null ;

grant select on V3800_FROM   to BARS_ACCESS_DEFROLE ;