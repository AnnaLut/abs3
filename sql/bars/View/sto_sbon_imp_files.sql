create or replace view bars.sto_sbon_imp_files as
select x.fn
     , x.dat
     , x.branch
     , x.userid
     , x.kf
     , count(*) as docs_qty
     , sum(p.s)as docs_sum
     , sum(1) as opl_num
     , sum(o.s) as opl_sum 
     , sum(case when substr(p.nlsa,1,4) in ('2902') or substr(p.nlsb,1,4) in ('2902') then o.s else 0 end) as opl_pay
     , sum(case when substr(p.nlsa,1,4) in ('6510') or substr(p.nlsb,1,4) in ('6510') then o.s else 0 end) as opl_fee
from bars.opldok o, bars.xml_impfiles x, bars.accounts a, bars.xml_impdocs p
where o.ref=p.ref
  and x.dat>=dat_next_u(gl.bd, - 5)
  and x.kf=o.kf
  and X.FN=p.fn
  and o.fdat=x.dat
  and o.acc=a.acc    
  and a.nbs in ('1002','2924') 
  and o.dk=0
  and o.sos=5
  and substr(p.nlsa,1,4) in ('2924','6510','2902','1002') 
  and substr(p.nlsb,1,4) in ('2924','6510','2902','1002')  
group by x.fn, x.dat, x.kf, /*x.docs_qty, x.docs_sum,*/ x.branch, x.userid;

grant select on bars.sto_sbon_imp_files to sbon;
grant select on bars.sto_sbon_imp_files to bars_access_defrole;

comment on table sto_sbon_imp_files is 'Импортированные $A-файлы - для сверки SBONом';
comment on column sto_sbon_imp_files.fn is 'Имя файла';
comment on column sto_sbon_imp_files.dat is 'Дата файла';
comment on column sto_sbon_imp_files.docs_sum is 'Сумма документов';
comment on column sto_sbon_imp_files.docs_qty is 'Количество документов';
comment on column sto_sbon_imp_files.kf is 'Код филиала';