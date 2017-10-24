delete from vip_template;

insert into vip_template (template) 
values('--Депозити ЮО--
select v.nmk||(select TXT from VIP_PARAMS_TEMPLATE where ID_PAR = ''DPU'')||to_char(d.dat_end-trunc(sysdate))||'' днів!'' as message, s.logname  from dpu_deal d, v_vip_deal v, staff s, (select * from TABLE(VIP_ADM.VIP_PARAMS(''DPU''))) d1
where d.rnk = v.rnk
and v.account_manager = s.id
and to_char(d.dat_end-trunc(sysdate)) in d1.l_day
union all
--Депозити ФО
select v.nmk||(select TXT from VIP_PARAMS_TEMPLATE where ID_PAR = ''DPT'')||to_char(d.dat_end-trunc(sysdate))||'' днів!'' as message, s.logname from dpt_deposit d, v_vip_deal v, staff s, (select * from TABLE(VIP_ADM.VIP_PARAMS(''DPT''))) d1
where d.rnk = v.rnk
and v.account_manager = s.id
and to_char(d.dat_end-trunc(sysdate)) in d1.l_day
union all
--Депозити ФО закрытие
select v.nmk||(select TXT from VIP_PARAMS_TEMPLATE where ID_PAR = ''DPT_C'')||'' № ''||d.deposit_id as message, s.logname from dpt_deposit d, v_vip_deal v, staff s, (select * from TABLE(VIP_ADM.VIP_PARAMS(''DPT_C''))) d1
where d.rnk = v.rnk
and v.account_manager = s.id
and to_char(d.dat_end-trunc(sysdate)) in d1.l_day
union all
--Дата народження
select v.nmk||(select TXT from VIP_PARAMS_TEMPLATE where ID_PAR = ''BDAT'')||to_char(to_char(F_GET_CONTDAY_EXT(d.bday,trunc(sysdate))))||'' днів!'' as message, s.logname from person d, v_vip_deal v, staff s, (select * from TABLE(VIP_ADM.VIP_PARAMS(''BDAT''))) d1
where d.rnk = v.rnk
and v.account_manager = s.id
and to_char(F_GET_CONTDAY_EXT(d.bday,trunc(sysdate))) in d1.l_day
--Закінчення ознаки VIP
union all
select v.nmk||(select TXT from VIP_PARAMS_TEMPLATE where ID_PAR = ''VIP'')||to_char(d.datend-trunc(sysdate))||'' днів!'' as message, s.logname from vip_flags d, v_vip_deal v, staff s, (select * from TABLE(VIP_ADM.VIP_PARAMS(''VIP''))) d1
where d.rnk = v.rnk
and v.account_manager = s.id
and to_char(d.datend-trunc(sysdate)) in d1.l_day
--Платіж за кредитом
union all
select v.nmk||(select TXT from VIP_PARAMS_TEMPLATE where ID_PAR = ''CCK'')||to_char(F_GET_DATE_CCK (d.CC_ID, d.sdate) -trunc(sysdate))||'' днів!'' as message, s.logname 
from cc_deal d, v_vip_deal v, staff s, (select * from TABLE(VIP_ADM.VIP_PARAMS(''CCK''))) d1
where d.rnk = v.rnk
and v.account_manager = s.id
and D.SOS > 9 and d.sos < 15 and d.vidd in (11,12,13)
and to_char((select  F_GET_DATE_CCK (CC_ID, sdate) from cc_deal where nd = d.nd) -trunc(sysdate)) in d1.l_day');


commit;