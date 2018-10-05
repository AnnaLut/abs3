declare
    cnt_    number;
begin
    for m in (select kf from mv_kf)
    loop
        bc.subst_mfo(m.kf);
        
        insert /*+APPEND Parallel(4) */ into BARS.OTCN_F13_ZBSK
        select  *
        from OTCN_F13_ZBSK_OLD
        where fdat >= to_date('01032018','ddmmyyyy');
        
        cnt_ := sql%rowcount;
        
        commit;
        
        dbms_output.put_line( 'KF = '|| m.kf ||' OK! '||to_char(cnt_)||' rows.');
    end loop;
    
    bc.home;
end;
/