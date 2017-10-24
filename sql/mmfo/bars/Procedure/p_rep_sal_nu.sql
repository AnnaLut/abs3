

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_REP_SAL_NU.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_REP_SAL_NU ***

  CREATE OR REPLACE PROCEDURE BARS.P_REP_SAL_NU 
											 (
											   mode_            int,
											   p_dat1           date,
                                               p_dat2           date,
											   p_mask           varchar2 default '%',     -- маска рахунка
											   p_kv             varchar2 default '%',     -- маска валюти
                                               p_branch         varchar2 default  sys_context('bars_context','user_branch'),
                                               p_branch_lik  	varchar2 default  null,
											   p_pw             varchar2 default '1'      --  1 - рахунки системні  0 - позасистемні
											  )
as
p_sql   varchar2(32000);
p_sql1  varchar2(22000);
p_sql2  varchar2(2000);
p_sql3  varchar2(2000);
p_sql4  varchar2(2000);
p_sql5  varchar2(2000);
p_sql6  varchar2(2000);
l_branch_lik varchar2(100);

begin

  bars_report.validate_nlsmask(p_mask,1);
  bars_report.validate_period(p_dat1, p_dat2, 62);


p_sql1 := 'insert into TMP_SAL_ACC (acc, nbs, nls, kv, branch, nms, daos, dazs)
                            select distinct a.acc, a.nbs, a.nls, a.kv, a.branch, substr(a.nms,1,35), a.daos, a.dazs
                              from accounts a, accounts f
							 where (a.dazs IS NULL or a.dazs>= to_date('''|| to_char(p_dat1,'dd-mm-yyyy')  ||''',''dd-mm-yyyy''))';

if p_pw ='1'   then 	 p_sql2 := ' and a.acc  = f.acc  and a.nbs is not null and f.nbs not like  ''8%''';
               else 	 p_sql2 := ' and a.acc = f.acc  and f.nbs is null';
			   --else 	 p_sql2 := ' and a.accc = f.acc  and f.nbs is not null';
end if;

if (p_mask is null or p_mask = '%')      then  p_sql3 := ' ';
elsif  length(p_mask) < 5 and p_pw ='1'  then  p_sql3 := ' and f.nbs like '''||p_mask||'%'' ';
else                                           p_sql3 := ' and f.nls like '''||p_mask||'%'' ';
end if;

if (p_kv is null or p_kv = '%' or p_kv = '0'  )         then  p_sql4 := ' ';
else                                           p_sql4 := ' and f.kv = '||p_kv;
end if;

case when p_branch_lik = '1' or p_branch_lik = '%'  then  l_branch_lik := '%';
                                                    else  l_branch_lik := null;
end case;

p_sql5 := ' and f.branch like '''||p_branch||l_branch_lik||'''';

--p_sql6 := 'and f.nbs not like  ''8%''';

p_sql :=  p_sql1 || p_sql2 || p_sql3 || p_sql4|| p_sql5|| p_sql6;

P_SAL_SNP_KOR ( mode_ , p_dat1, p_dat2,   p_sql);
commit;
end p_rep_sal_nu;
/
show err;

PROMPT *** Create  grants  P_REP_SAL_NU ***
grant EXECUTE                                                                on P_REP_SAL_NU    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_REP_SAL_NU    to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_REP_SAL_NU.sql =========*** End 
PROMPT ===================================================================================== 
