create or replace view v_msp_env_for_parse as
select "ID","ID_MSP_ENV","CODE","SENDER","RECIPIENT","PARTNUMBER","PARTTOTAL","ECP","DATA","DATA_DECODE","STATE","COMM","CREATE_DATE"
    from msp_envelopes
   where state = -1;
/
   
grant select on v_msp_env_for_parse to bars_access_defrole;
