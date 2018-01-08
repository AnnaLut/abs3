create or replace view v_crkr_ca_transfer_for_proc
as
select * from crkr_ca_transfer
where state_id in (0/*STATE_TRANSFER_NEW*/);

GRANT SELECT ON v_crkr_ca_transfer_for_proc TO BARS_ACCESS_DEFROLE;