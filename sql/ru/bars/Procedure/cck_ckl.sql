CREATE OR REPLACE PROCEDURE BARS."CCK_CKL"
 ( p_NLS  accounts.nls%type,
   p_KV   accounts.kv%type
  )  is

 l_acc   accounts.ACC%type    ;
 l_value accountsw.value%type ; l_mes  int;
 l_fdat0 date                 ; -- дата выдачи транша
 l_dos0  saldoa.dos%type      ; -- непогаш.сумма выдачи
 l_fdat1 date                 ; -- дата планового    погашения транша
 l_kos   saldoa.kos%type      ;
 l_kos1  saldoa.kos%type :=0  ;
 l_sump  saldoa.kos%type ;
 m_fdat  date;  n_fdat  date;

BEGIN
 -- STA 09.03.2011
 -- Графiк погашення Циклiчних Кредитних Лiнiй

  EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_CCK_CKL ';

  begin
    select acc, daos    into l_acc, l_fdat0
    from accounts where nls=p_nls and kv=p_kv and tip='SS ';
  exception when no_data_found then return;
  end;

--logger.info('CKL - 1 l_acc='||l_acc ||',  l_fdat0=' || l_fdat0);

  begin
    select to_number(value) into l_mes  from accountsw
    where tag='CCK_MPOG' and acc=l_acc ;
  exception  when others then    l_mes := 12;
  end;

--logger.info('CKL - 2 l_mes='||l_mes);

  -- Цикл по выдачам
  for d in ( select fdat,DOS from saldoa where dos>0 and acc=l_acc order by 1)
  loop
    l_fdat0 := greatest ( l_fdat0, d.fdat );
    l_fdat1 := add_months(d.fdat, l_mes);

--logger.info('CKL - 3 d.fdat='||d.fdat ||',  d.dos=' || d.dos ||
--', l_kos1='|| l_kos1);

    select nvl( max(fdat),l_fdat0), nvl(sum(o.s),0) + l_kos1
    into   m_fdat,      l_KOS
    from opldok o
    where o.dk = 1 and o.acc= l_acc
      and o.fdat > l_fdat0 and o.fdat > d.fdat and o.fdat <= l_fdat1
      and exists (select 1 from opldok o1, accounts a1
                  where o1.acc = a1.acc and a1.tip <> 'SP '
                    and o1.ref = o.ref  and o1.stmt=o.stmt
                    and o1.dk  = 0 );

--logger.info('CKL - 4 m_fdat='||m_fdat ||',  l_kos=' || l_kos);

    l_kos1  := greatest (l_kos  - d.dos, 0 ); -- остаток от пред.погашения или 0
    l_fdat0 := m_fdat ;
    l_kos   := least(d.dos,l_kos); -- столько погашено

--logger.info('CKL - 5 l_kos1='||l_kos1 ||',  l_fdat0=' || l_fdat0 ||' ,l_kos='||l_kos );
if l_fdat1 < gl.bdate then  l_sump := (d.dos-l_kos);
else                        l_sump := 0;
end if;

    insert into TMP_CCK_CKL(nls,kv,FDAT0,DOS0,FDAT1,KOS1,sump) values
    (p_nls,p_kv,d.fdat, d.dos/100, l_fdat1, l_kos/100, l_sump/100);

  end loop;

end CCK_CKL;
/

