create or replace view v_sw_compare as
select s.id,
       s.kod_nbu,
       s.ddate,
       s.userid,
       u.fio,
       s.ref,
       o.sos,
       os.name sos_name,
       u2.fio fio_ref,
       s.prn_file_own,
       s.prn_file_import,
       s.comments
from sw_compare s,
     staff$base u,
     staff$base u2,
     oper o,
     OP_SOS os
where u.id = s.userid
  and u2.id (+)= s.userid_ref
  and s.ref = o.ref(+)
  and o.sos = os.sos(+);

grant SELECT                                                on v_sw_compare    to BARS_ACCESS_DEFROLE;
