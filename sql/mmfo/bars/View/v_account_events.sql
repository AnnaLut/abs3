create or replace view V_ACCOUNT_EVENTS
( AC_ID
, USR_ID
, USR_NM
, EV_ID
, EV_DT
, EV_DSC
, EV_QTY
) as
select e.ACC, e.ISP, s.FIO
     , e.ID, e.FDAT, e.TXT
     , count(1) over ( partition by e.ACC ) 
  from ACC_SOB    e
  join STAFF$BASE s
    on ( s.ID = e.ISP )
 order by e.FDAT;

show err

grant select on V_ACCOUNT_EVENTS to BARS_ACCESS_DEFROLE;
