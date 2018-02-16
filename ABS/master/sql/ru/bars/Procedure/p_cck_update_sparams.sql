prompt procedure p_cck_update_sparams
create or replace procedure p_cck_update_sparams(p_start_date in date, p_end_date in date)
is
/* 
v.1.1 14.02.2018 
COBUMMFO-6175
При ручному редагуванні параметра R011 на основному рахунку SS - необхідно реалізувати процедуру, 
яка буде змінювати R011 на рахунках SP, SDI,SN,SNO, SNA, SPN цієї угоди , - при закритті банківського дня.
*/
l_title constant varchar2(32) := 'P_CCK_UPDATE_SPARAMS';
begin
    bars_audit.info(l_title||': start for '||p_start_date||', '||p_end_date);
    for rec in (
        with
        changed_sp_accs as /* счета SS, по которым менялись спецпараметры за дату */
        (
        select distinct su.acc, su.kf from bars.specparam_update su
        join bars.accounts a on su.acc = a.acc and su.kf = a.kf
        where su.effectdate between p_start_date and p_end_date
        and a.tip = 'SS'),
        nd_r011 as /* nd и r011 этих счетов  */
        (select nd, r011
        from bars.specparam s
        join changed_sp_accs ca on s.acc = ca.acc
        join bars.nd_acc na on ca.acc = na.acc and ca.kf = na.kf)
        select na.acc, ndr11.r011 /* все счета и нужные r011 для них */
        from bars.nd_acc na
        join nd_r011 ndr11 on na.nd = ndr11.nd
		join accounts a on na.acc = a.acc and na.kf = a.kf
		where a.tip in ('SP ', 'SDI','SN ','SNO', 'SNA', 'SPN')
        )
    loop
        savepoint sp1;
        begin
            bars_audit.trace(l_title||': обновляем спецпараметры счета: #'||rec.acc);
            accreg.setAccountSParam(rec.acc, 'R011', rec.r011);
        exception
            when others then
                rollback to sp1;
                bars_audit.error(l_title||': error for acc #'||rec.acc||': '||sqlerrm||' : '||dbms_utility.format_error_backtrace);
                continue;
        end;
    end loop;
    bars_audit.info(l_title||': finish');
end p_cck_update_sparams;
/
Show errors;
grant execute on bars.p_cck_update_sparams to start1;