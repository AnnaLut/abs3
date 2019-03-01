create or replace view v_nbu_session_history as
select s.id,
       s.report_id,
       o.id object_id,
       o.object_type_id,
       case when o.object_type_id = 1 then 'Фізична особа'
            when o.object_type_id = 2 then 'Юридична особа'
            when o.object_type_id = 3 then 'Застава'
            when o.object_type_id = 4 then 'Кредит'
            else null
       end object_type_name,
       case when o.object_type_id = 1 then c.core_customer_kf
            when o.object_type_id = 2 then c.core_customer_kf
            when o.object_type_id = 3 then pl.core_pledge_kf
            when o.object_type_id = 4 then cr.core_loan_kf
            else null
       end object_kf,
       case when o.object_type_id in (1, 2) then c.customer_code
            when o.object_type_id = 3 then pl.pledge_number
            when o.object_type_id = 4 then cr.loan_number
            else null
       end object_code,
       case when o.object_type_id in (1, 2) then c.customer_name
            when o.object_type_id = 3 then 'Договір застави № ' || pl.pledge_number || ' від ' || to_char(pl.pledge_date, 'dd.mm.yyyy')
            when o.object_type_id = 4 then 'Договір № ' || cr.loan_number || ' від ' || to_char(cr.loan_date, 'dd.mm.yyyy')
            else null
       end object_name,
       (select min(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_creation_time,
       (select max(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_activity_time,
       s.session_type_id,
       case when s.session_type_id = 1 then 'Новий об''єкт'
            when s.session_type_id = 2 then 'Модифікація'
            when s.session_type_id = 3 then 'Отримання даних від НБУ'
            when s.session_type_id = 4 then 'Видалення об''єкта'
            else null
       end session_type_name,
       s.state_id,
       bars.list_utl.get_item_name('NBU_601_SESSION_STATE', s.state_id) session_state,
       (select min(st.tracking_comment) keep (dense_rank last order by st.id) from nbu_session_tracking st where st.session_id = s.id) session_details,
      case when o.object_type_id in (1,2) then 'clientregister/registration.aspx?readonly=1'||chr(38)||'rnk='||c.core_customer_id
           when o.object_type_id=3 then (select 'CreditUi/provide/Index/?id='||a.nd from core_pledge_dep a where pl.core_pledge_id=a.acc and rownum=1)
		   when o.object_type_id=4 then (select case when cc.type_credit=1 and cc.check_person=1 then 'CreditUi/NewCredit/?custtype=3'||chr(38)||'nd='||cc.nd
													 when cc.type_credit=1 and cc.check_person=2 then 'CreditUi/NewCredit/?custtype=2'||chr(38)||'nd='||cc.nd
													 when cc.type_credit=2 and cc.check_person=1 then 'Way4Bpk/Way4Bpk?okpo='||cn.customer_code
													 when cc.type_credit=2 and cc.check_person=2 then 'way4bpk/way4bpk?custtype=2'||chr(38)||'okpo='||cn.customer_code

                                                   end way_link
                                                   from  v_nbu_check_credit cc,nbu_reported_customer cn
                                                   where cc.nd=cr.core_loan_id and cc.kf=cr.core_loan_kf
                                                         and cr.customer_object_id=cn.id and cc.rnk=cn.core_customer_id)

       end object_link,
       'Перейти' as obj,
       s.last_activity_at

from nbu_session s
join nbu_reported_object o on o.id = s.object_id
left join nbu_reported_customer c on c.id = s.object_id
left join nbu_reported_pledge pl on pl.id = s.object_id
left join nbu_reported_loan cr on cr.id = s.object_id
--order by s.last_activity_at desc, s.id desc
;
grant select on v_nbu_session_history to BARS_ACCESS_DEFROLE;