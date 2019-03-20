begin 
    execute immediate 'create table tmp_sago( id number(38),
                                              ref varchar2(100))';
                           
    execute immediate 'insert into tmp_sago 
    select sd.id, sd.ref_our from sago_documents sd where sd.ref_our is not null';

    update sago_documents sd 
       set sd.ref_our = null
     where sd.ref_our is not null;
     
    execute immediate 'alter table SAGO_DOCUMENTS modify ref_our varchar2(100)';

    execute immediate 'update sago_documents sd 
       set sd.ref_our = (select ref from tmp_sago where id = sd.id)';
       
    execute immediate 'drop table tmp_sago';
    commit;
end;
/