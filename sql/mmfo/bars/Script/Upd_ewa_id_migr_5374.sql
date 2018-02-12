declare
l_cou number;
begin  
mgr_utl.p_ref_constraints_disable('INS_DEALS');
------------------ins_deals_300465_id
select count(*) into l_cou from ins_deals t 
where t.kf = '300465' and t.id <= 81323
   and substr(t.id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update ins_deals t
set t.id = t.id* 100 + 1
where t.kf = '300465' and t.id <= 81323;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table ins_deals for kf 300465');
end if;

------------------ins_deals_322669_id
select count(*) into l_cou from ins_deals t 
where t.kf = '322669' and t.id <= 104349
   and substr(t.id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update ins_deals t
set t.id = t.id* 100 + 11
where t.kf = '322669' and t.id <= 104349;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table ins_deals for kf 322669');
end if;

------------------INS_PAYMENTS_SCHEDULE_300465_deal_id
select count(*) into l_cou from INS_PAYMENTS_SCHEDULE t 
where t.kf = '300465' and t.deal_id <= 81323
   and substr(t.deal_id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_PAYMENTS_SCHEDULE t
set t.deal_id = t.deal_id* 100 + 1
where t.kf = '300465' and t.deal_id <= 81323;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_PAYMENTS_SCHEDULE for kf 300465');
end if;

------------------INS_PAYMENTS_SCHEDULE_322669_deal_id
select count(*) into l_cou from INS_PAYMENTS_SCHEDULE t 
where t.kf = '322669' and t.deal_id <= 104349
   and substr(t.deal_id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_PAYMENTS_SCHEDULE t
set t.deal_id = t.deal_id* 100 + 11
where t.kf = '322669' and t.deal_id <= 104349;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_PAYMENTS_SCHEDULE for kf 322669');
end if;

------------INS_DEAL_STS_HISTORY_300465_deal_id
select count(*) into l_cou from INS_DEAL_STS_HISTORY t 
where t.kf = '300465' and t.deal_id <= 81323
   and substr(t.deal_id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then   
update INS_DEAL_STS_HISTORY t
set t.deal_id = t.deal_id* 100 + 1
where t.kf = '300465' and t.deal_id <= 81323;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_DEAL_STS_HISTORY for kf 300465');
end if;

------------INS_DEAL_STS_HISTORY_322669_deal_id
select count(*) into l_cou from INS_DEAL_STS_HISTORY t 
where t.kf = '322669' and t.deal_id <= 104349
   and substr(t.deal_id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then   
update INS_DEAL_STS_HISTORY t
set t.deal_id = t.deal_id* 100 + 11
where t.kf = '322669' and t.deal_id <= 104349;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_DEAL_STS_HISTORY for kf 322669');
end if;
----------------INS_PAYMENTS_SCHEDULE_300465_id
select count(*) into l_cou from INS_PAYMENTS_SCHEDULE t 
where t.kf = '300465' and t.id <= 57947
   and substr(t.id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_PAYMENTS_SCHEDULE t
set t.id = t.id* 100 + 1
where t.kf = '300465' and t.id <= 57947;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_PAYMENTS_SCHEDULE for kf 300465');
end if;

----------------INS_PAYMENTS_SCHEDULE_322669_id
select count(*) into l_cou from INS_PAYMENTS_SCHEDULE t 
where t.kf = '322669' and t.id <= 80909
   and substr(t.id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_PAYMENTS_SCHEDULE t
set t.id = t.id* 100 + 11
where t.kf = '322669' and t.id <= 80909;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_PAYMENTS_SCHEDULE for kf 322669');
end if;
-------------INS_DEAL_STS_HISTORY_300465_id
select count(*) into l_cou from INS_DEAL_STS_HISTORY t 
where t.kf = '300465' and t.id <= 123273
   and substr(t.id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_DEAL_STS_HISTORY t
set t.id = t.id* 100 + 1
where t.kf = '300465' and t.id <= 123273; 
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_DEAL_STS_HISTORY for kf 300465');
end if;

-------------INS_DEAL_STS_HISTORY_322669_id
select count(*) into l_cou from INS_DEAL_STS_HISTORY t 
where t.kf = '322669' and t.id <= 169517
   and substr(t.id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_DEAL_STS_HISTORY t
set t.id = t.id* 100 + 11
where t.kf = '322669' and t.id <= 169517;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_DEAL_STS_HISTORY for kf 322669'); 
end if;
-------------INS_DEAL_ATTRS_300465_id
select count(*) into l_cou from INS_DEAL_ATTRS t 
where t.kf = '300465' and t.deal_id <= 81323
   and substr(t.deal_id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_DEAL_ATTRS t
set t.deal_id = t.deal_id* 100 + 1
where t.kf = '300465' and t.deal_id <= 81323; 
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_DEAL_ATTRS for kf 300465');
end if;

-------------INS_DEAL_ATTRS_322669_id
select count(*) into l_cou from INS_DEAL_ATTRS t 
where t.kf = '322669' and t.deal_id <= 104349
   and substr(t.deal_id,-2) not in (select tt.ru from kf_ru tt where tt.kf = t.kf);

if l_cou>0 then
update INS_DEAL_ATTRS t
set t.deal_id = t.deal_id* 100 + 11
where t.kf = '322669' and t.deal_id <= 104349;
dbms_output.put_line('Updated '||sql%rowcount||' rows in table INS_DEAL_ATTRS for kf 322669'); 
end if;
------------- 

mgr_utl.p_ref_constraints_enable('INS_DEALS');
commit;
end;
/

