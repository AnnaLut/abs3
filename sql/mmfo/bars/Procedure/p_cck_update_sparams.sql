prompt procedure p_cck_update_sparams
create or replace procedure p_cck_update_sparams(p_start_date in date, p_end_date in date)
is
/* 
v.1.1 14.02.2018 
COBUMMFO-6175
��� ������� ����������� ��������� R011 �� ��������� ������� SS - ��������� ���������� ���������, 
��� ���� �������� R011 �� �������� SP, SDI,SN,SNO, SNA, SPN ���� ����� , - ��� ������� ����������� ���.
*/
title constant varchar2(32) := 'zbd.P_CCK_UPDATE_SPARAMS';
begin
      logger.tms_info( title||': Entry with ( p_start_date='||to_char(p_start_date,'dd.mm.yyyy')
                        ||', p_end_date='||to_char(p_end_date,'dd.mm.yyyy')||' ).' );
    for rec in (
        with
        changed_sp_accs as /* ����� SS, �� ������� �������� ������������� �� ���� */
        (
        select distinct su.acc, su.kf from bars.specparam_update su
        join bars.accounts a on su.acc = a.acc and su.kf = a.kf
        where su.effectdate between p_start_date and p_end_date
        and a.tip = 'SS'),
        nd_r011 as /* nd � r011 ���� ������  */
        (select nd, r011
        from bars.specparam s
        join changed_sp_accs ca on s.acc = ca.acc
        join bars.nd_acc na on ca.acc = na.acc and ca.kf = na.kf)
        select na.acc, ndr11.r011 /* ��� ����� � ������ r011 ��� ��� */
        from bars.nd_acc na
        join nd_r011 ndr11 on na.nd = ndr11.nd
		join accounts a on na.acc = a.acc and na.kf = a.kf
		where a.tip in ('SP ', 'SDI','SN ','SNO', 'SNA', 'SPN')
        )
    loop
        savepoint sp1;
        begin
            bars_audit.trace(title||': ��������� ������������� �����: #'||rec.acc);
            accreg.setAccountSParam(rec.acc, 'R011', rec.r011);
        exception
            when others then
                rollback to sp1;
                logger.tms_error( title||': error for acc #'||rec.acc||chr(10)||sqlerrm||chr(10)||dbms_utility.format_error_backtrace);
                continue;
        end;
    end loop;
    logger.tms_info( title||': Finish.' );
end p_cck_update_sparams;
/
Show errors;