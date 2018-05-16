

declare
  l_kf             varchar2(6) := '';
  l_id             number :=0;
  l_cnt            number :=0;
begin --создание job-а
    for lc_kf in (select kf from bars.mv_kf where kf = l_kf or l_kf = '' or l_kf is null)
    loop
        l_kf := lc_kf.kf;
        bars.bc.go(l_kf);
        --dbms_application_info.set_action(lc_kf.kf || ' CC:' || to_char(sysdate, 'hh24:mi:ss'));
        --dbms_output.put_line (to_char(sysdate) || ':  CHECK_CC_DEAL_UPDATE (' || l_kf || ') - start' );
        --BARS.UPDATE_TBL_UTL.CHECK_CC_DEAL_UPDATE;
        --dbms_output.put_line (to_char(sysdate) || ':  CHECK_CC_DEAL_UPDATE (' || l_kf || ') id= ' || l_id || '; count = ' || l_cnt || ' - finish' );

        dbms_application_info.set_action(lc_kf.kf || ' CC: ' || to_char(sysdate, 'hh24:mi:ss'));
        dbms_output.put_line (to_char(sysdate) || ':  SYNC_CC_DEAL_UPDATE (' || l_kf || ') - start' );
        BARS.UPDATE_TBL_UTL.SYNC_CC_DEAL_UPDATE(l_id, l_cnt);
        dbms_output.put_line (to_char(sysdate) || ':  SYNC_CC_DEAL_UPDATE (' || l_kf || ') id= ' || l_id || '; count = ' || l_cnt || ' - finish' );

        commit;
    end loop;
end;
/