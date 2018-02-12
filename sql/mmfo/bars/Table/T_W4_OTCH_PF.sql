begin
    bpa.alter_policy_info(p_table_name    => 'T_W4_OTCH_PF',
                          p_policy_group  => 'FILIAL',
                          p_select_policy => 'M',
                          p_insert_policy => 'M',
                          p_update_policy => 'M',
                          p_delete_policy => 'M');
    bpa.alter_policy_info(p_table_name    => 'T_W4_OTCH_PF',
                          p_policy_group  => 'WHOLE',
                          p_select_policy => null,
                          p_insert_policy => null,
                          p_update_policy => null,
                          p_delete_policy => null);
end;
/
prompt create table T_W4_OTCH_PF
begin
    execute immediate '
    create table T_W4_OTCH_PF
    (
    branch varchar2(30), 
    nls varchar2(15), 
    rnk number(38), 
    okpo varchar2(14), 
    nmk varchar2(70), 
    bday date, 
    pass_ser varchar2(10), 
    pass_num varchar2(20), 
    indx1 varchar2(20), 
    np1 varchar2(30), 
    adr1 varchar2(100), 
    indx2 varchar2(20), 
    np2 varchar2(30), 
    adr2 varchar2(100), 
    card_code varchar2(32), 
    code varchar2(32), 
    pr varchar2(3), 
    zar_365 number, 
    zar_n_365 number, 
    dmin_zar date, 
    dmax_zar date, 
    spi_365 number, 
    spi_365_dw number, 
    dmax_spi date, 
    ost_2625 number,
    kf varchar2(6)
    )
    PARTITION BY LIST (KF)
    ( PARTITION T_W4_300465 VALUES (''300465'')
    , PARTITION T_W4_302076 VALUES (''302076'')
    , PARTITION T_W4_303398 VALUES (''303398'')
    , PARTITION T_W4_304665 VALUES (''304665'')
    , PARTITION T_W4_305482 VALUES (''305482'')
    , PARTITION T_W4_311647 VALUES (''311647'')
    , PARTITION T_W4_312356 VALUES (''312356'')
    , PARTITION T_W4_313957 VALUES (''313957'')
    , PARTITION T_W4_315784 VALUES (''315784'')
    , PARTITION T_W4_322669 VALUES (''322669'')
    , PARTITION T_W4_323475 VALUES (''323475'')
    , PARTITION T_W4_324805 VALUES (''324805'')
    , PARTITION T_W4_325796 VALUES (''325796'')
    , PARTITION T_W4_326461 VALUES (''326461'')
    , PARTITION T_W4_328845 VALUES (''328845'')
    , PARTITION T_W4_331467 VALUES (''331467'')
    , PARTITION T_W4_333368 VALUES (''333368'')
    , PARTITION T_W4_335106 VALUES (''335106'')
    , PARTITION T_W4_336503 VALUES (''336503'')
    , PARTITION T_W4_337568 VALUES (''337568'')
    , PARTITION T_W4_338545 VALUES (''338545'')
    , PARTITION T_W4_351823 VALUES (''351823'')
    , PARTITION T_W4_352457 VALUES (''352457'')
    , PARTITION T_W4_353553 VALUES (''353553'')
    , PARTITION T_W4_354507 VALUES (''354507'')
    , PARTITION T_W4_356334 VALUES (''356334'') )
    tablespace brsdynd
    ';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
grant select on T_W4_OTCH_PF to bars_access_defrole;