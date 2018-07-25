create or replace view v_sw_gpi_statuses
as
select q.ref, 
       j.mt as mt103,
       j.io_ind as io_ind_103,
       q.swref as swref_103,
       j.date_in as date_input_103,
       j.vdate as vdate_103,
       j.sender as sender_103,
       j.receiver as receiver_103,
       j.payer as payer_103,
       j.payee as payee_103,
       j.amount/100 as amount,
       j.currency,
       j.sti,
       j.uetr,
       q.swref_199,
       j2.mt as mt_199,
       j2.io_ind as io_ind_199,
       j2.date_in as date_input_199,
       j2.sender as sender_199,
       j2.receiver as receiver_199,
       s.value as status_code,
       s.description as status_description 
        from sw_oper_queue q
            inner join sw_journal j on j.swref=q.swref
            inner join sw_statuses s on q.status=s.id 
            left join oper o on o.ref=q.ref
            left join sw_journal j2 on j2.swref=q.swref_199
         order by q.swref desc, q.swref_199 desc;
/
grant select on v_sw_gpi_statuses to bars_access_defrole
/            
