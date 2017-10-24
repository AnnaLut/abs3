
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_web_sms_ins.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_WEB_SMS_INS is

    procedure prepare_web_sms_over_plan_pay;

    procedure prepare_web_sms_pre_plan_pay;

    procedure prepare_web_sms_pre_end_agr;

    procedure prepare_web_sms_chief;

    procedure prepare_web_sms;

end bars_web_sms_ins;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_WEB_SMS_INS is

    --------------------------------------------------------------------------------------------------------------------------------
    g_msg_over_plan_pay       varchar2 (160) := 'Існує затримка чергового страхового платежу для наступних договорів: ';
    g_msg_over_plan_pay_chief varchar2 (160) := '<b>Існує затримка чергових страхових платежів у договорах наступних менеджерів:</b><br/>';
    --------------------------------------------------------------------------------------------------------------------------------
    g_msg_pre_plan_pay        varchar2 (160) := 'Наближається чергова дата страхового платежу для наступних договорів: ';
    g_msg_pre_plan_pay_chief  varchar2 (160) := '<b>Наближається чергова дата страхових платежів у договорах наступних менеджерів:</b><br/>';
    --------------------------------------------------------------------------------------------------------------------------------
    g_msg_pre_end_agr         varchar2 (160) := 'Закінчується термін дії для наступних договорів: ';
    g_msg_pre_end_agr_chief   varchar2 (160) := '<b>Закінчується термін дії у договорах наступних менеджерів:</b><br/>';
    --------------------------------------------------------------------------------------------------------------------------------

    procedure prepare_web_sms_chief is
        -------------------------------------------------------------------------------------
        cursor cur_chief is
        select unique id
        from applist_staff af
        where codeapp in ('WIHF','WIHU');
        -------------------------------------------------------------------------------------
        type tab_cur_cur_chief is table of cur_chief%rowtype;
        l_tab_cur_cur_chief tab_cur_cur_chief;
        -------------------------------------------------------------------------------------
        l_msg_over_plan_pay_chief varchar2(4000);
        l_msg_pre_plan_pay_chief  varchar2(4000);
        l_msg_pre_end_agr_chief   varchar2(4000);
        -------------------------------------------------------------------------------------
        cursor cur_over_plan_pay_chief is
        select dl.staff_id, sb.fio, count(distinct dl.num) cnt_num
        from ins_deals dl
        join staff$base sb
          on sb.id = dl.staff_id
         and exists(select codeapp from applist_staff where id = dl.staff_id and codeapp in ('WIAU','WIAF','WICF','WICU','WIHF','WIHU','WIMF','WIMU','WIAN'))
        join ins_payments_schedule psh on dl.id = psh.deal_id and
                                          dl.status_id = 'ON' and
                                          psh.payed = 0 and
                                          trunc(psh.plan_date) = trunc(sysdate) - 14
        group by dl.staff_id, sb.fio;
        -------------------------------------------------------------------------------------
        cursor cur_pre_plan_pay_chief is
        select dl.staff_id, sb.fio, count(distinct dl.num) cnt_num
        from ins_deals dl
        join staff$base sb
          on sb.id = dl.staff_id
         and exists(select codeapp from applist_staff where id = dl.staff_id and codeapp in ('WIAU','WIAF','WICF','WICU','WIHF','WIHU','WIMF','WIMU','WIAN'))
        join ins_payments_schedule psh on dl.id = psh.deal_id and
                                          dl.status_id = 'ON' and
                                          psh.payed = 0 and
                                          trunc(psh.plan_date) = trunc(sysdate) + 7
        group by dl.staff_id, sb.fio;
        -------------------------------------------------------------------------------------
        cursor cur_pre_end_agr_chief is
        select dl.staff_id, sb.fio, count(distinct dl.num) cnt_num
        from ins_deals dl
        join staff$base sb
          on sb.id = dl.staff_id
         and exists(select codeapp from applist_staff where id = dl.staff_id and codeapp in ('WIAU','WIAF','WICF','WICU','WIHF','WIHU','WIMF','WIMU','WIAN'))
        where dl.status_id = 'ON' and
              trunc(dl.edate) = trunc(sysdate) + 14
        group by dl.staff_id, sb.fio;
        -------------------------------------------------------------------------------------
        type t_list_staff is record (staff_id ins_deals.staff_id%type, fio staff$base.fio%type,  cnt_num int);
        type tab_list_staff is table of t_list_staff;
        l_tab_list_staff tab_list_staff;
        -------------------------------------------------------------------------------------
    begin
        -------------------------------------------------------------------------------------
        open cur_over_plan_pay_chief;
        fetch cur_over_plan_pay_chief bulk collect into l_tab_list_staff;
        close cur_over_plan_pay_chief;
        if nvl(l_tab_list_staff.count,0) <> 0 then
            for i in l_tab_list_staff.first.. l_tab_list_staff.last loop
                l_msg_over_plan_pay_chief := l_msg_over_plan_pay_chief||l_tab_list_staff(i).fio||' кл. дог. '||l_tab_list_staff(i).cnt_num||'<br/>';
            end loop;
            l_msg_over_plan_pay_chief := g_msg_over_plan_pay_chief||l_msg_over_plan_pay_chief;
        end if;
        -------------------------------------------------------------------------------------
        open cur_pre_plan_pay_chief;
        fetch cur_pre_plan_pay_chief bulk collect into l_tab_list_staff;
        close cur_pre_plan_pay_chief;
        if nvl(l_tab_list_staff.count,0) <> 0 then
            for i in l_tab_list_staff.first.. l_tab_list_staff.last loop
                l_msg_pre_plan_pay_chief := l_msg_pre_plan_pay_chief||l_tab_list_staff(i).fio||' кл. дог. '||l_tab_list_staff(i).cnt_num||'<br/>';
            end loop;
            l_msg_pre_plan_pay_chief := g_msg_pre_plan_pay_chief||l_msg_pre_plan_pay_chief;
        end if;
        -------------------------------------------------------------------------------------
        open cur_pre_end_agr_chief;
        fetch cur_pre_end_agr_chief bulk collect into l_tab_list_staff;
        close cur_pre_end_agr_chief;
        if nvl(l_tab_list_staff.count,0) <> 0 then
            for i in l_tab_list_staff.first.. l_tab_list_staff.last loop
                l_msg_pre_end_agr_chief := l_msg_pre_end_agr_chief||l_tab_list_staff(i).fio||' кл. дог. '||l_tab_list_staff(i).cnt_num||'<br/>';
            end loop;
            l_msg_pre_end_agr_chief := g_msg_pre_end_agr_chief||l_msg_pre_end_agr_chief;
        end if;
        -------------------------------------------------------------------------------------
        if l_msg_pre_end_agr_chief is not null or
           l_msg_pre_plan_pay_chief is not null or
           l_msg_over_plan_pay_chief is not null then
            open cur_chief;
            loop
                fetch cur_chief bulk collect into l_tab_cur_cur_chief limit 500;
                exit when nvl(l_tab_cur_cur_chief.count,0) = 0;
                for i in l_tab_cur_cur_chief.first .. l_tab_cur_cur_chief.last loop
                    bms.send_message(p_receiver_id     => l_tab_cur_cur_chief(i).id,
                                     p_message_type_id => bms.msg_type_ordinary_message,
                                     p_message_text    => l_msg_over_plan_pay_chief||l_msg_pre_plan_pay_chief||l_msg_pre_end_agr_chief,
                                     p_delay           => 1,
                                     p_expiration      => 1209600);
                end loop;
            end loop;
            close cur_chief;
        end if;
        -------------------------------------------------------------------------------------
    end;

    procedure prepare_web_sms_over_plan_pay is
        -------------------------------------------------------------------------------------
        cursor cur_send_web_sms is
        select dl.staff_id, listagg(dl.num, ', ') within group (order by dl.num) list_agr
        from v_ins_deals dl
        join ins_payments_schedule psh on dl.deal_id = psh.deal_id and
                                          dl.status_id = 'ON' and
                                          psh.payed = 0 and
                                          trunc(psh.plan_date) = trunc(sysdate) - 14
        where dl.ext_system is null
        group by dl.staff_id;
        -------------------------------------------------------------------------------------
        type tab_cur_send_web_sms is table of cur_send_web_sms%rowtype;
        l_tab_cur_send_web_sms tab_cur_send_web_sms;
        -------------------------------------------------------------------------------------
    begin
        open cur_send_web_sms;
        loop
            fetch cur_send_web_sms bulk collect into l_tab_cur_send_web_sms limit 200;
            exit when nvl(l_tab_cur_send_web_sms.count,0) = 0;
            for i in l_tab_cur_send_web_sms.first .. l_tab_cur_send_web_sms.last loop
                bms.send_message(p_receiver_id     => l_tab_cur_send_web_sms(i).staff_id,
                                 p_message_type_id => bms.msg_type_ordinary_message,
                                 p_message_text    => g_msg_over_plan_pay||l_tab_cur_send_web_sms(i).list_agr,
                                 p_delay           => 1,
                                 p_expiration      => 1209600);
            end loop;
        end loop;
        close cur_send_web_sms;
    end;

    procedure prepare_web_sms_pre_plan_pay is
        -------------------------------------------------------------------------------------
        cursor cur_send_web_sms is
        select dl.staff_id, listagg(dl.num, ', ') within group (order by dl.num) list_agr
        from v_ins_deals dl
        join ins_payments_schedule psh on dl.deal_id = psh.deal_id and
                                          dl.status_id = 'ON' and
                                          psh.payed = 0 and
                                          trunc(psh.plan_date) = trunc(sysdate) + 7
        where dl.ext_system is null
        group by dl.staff_id;
        -------------------------------------------------------------------------------------
        type tab_cur_send_web_sms is table of cur_send_web_sms%rowtype;
        l_tab_cur_send_web_sms tab_cur_send_web_sms;
        -------------------------------------------------------------------------------------
    begin
        open cur_send_web_sms;
        loop
            fetch cur_send_web_sms bulk collect into l_tab_cur_send_web_sms limit 200;
            exit when nvl(l_tab_cur_send_web_sms.count,0) = 0;
            for i in l_tab_cur_send_web_sms.first .. l_tab_cur_send_web_sms.last loop
                bms.send_message(p_receiver_id     => l_tab_cur_send_web_sms(i).staff_id,
                                 p_message_type_id => bms.msg_type_ordinary_message,
                                 p_message_text    => g_msg_pre_plan_pay||l_tab_cur_send_web_sms(i).list_agr,
                                 p_delay           => 1,
                                 p_expiration      => 604800);
            end loop;
        end loop;
        close cur_send_web_sms;
    end;

    procedure prepare_web_sms_pre_end_agr is
        -------------------------------------------------------------------------------------
        cursor cur_send_web_sms is
        select dl.staff_id, listagg(dl.num, ', ') within group (order by dl.num) list_agr
        from v_ins_deals dl
        where dl.status_id = 'ON' and
              trunc(dl.edate) = trunc(sysdate) + 14 and
              dl.ext_system is null
        group by dl.staff_id;
        -------------------------------------------------------------------------------------
        type tab_cur_send_web_sms is table of cur_send_web_sms%rowtype;
        l_tab_cur_send_web_sms tab_cur_send_web_sms;
        -------------------------------------------------------------------------------------
    begin
        open cur_send_web_sms;
        loop
            fetch cur_send_web_sms bulk collect into l_tab_cur_send_web_sms limit 200;
            exit when nvl(l_tab_cur_send_web_sms.count,0) = 0;
            for i in l_tab_cur_send_web_sms.first .. l_tab_cur_send_web_sms.last loop
                bms.send_message(p_receiver_id     => l_tab_cur_send_web_sms(i).staff_id,
                                 p_message_type_id => bms.msg_type_ordinary_message,
                                 p_message_text    => g_msg_pre_end_agr||l_tab_cur_send_web_sms(i).list_agr,
                                 p_delay           => 1,
                                 p_expiration      => 1209600);
            end loop;
        end loop;
        close cur_send_web_sms;
    end;

    procedure prepare_web_sms is
    begin
        prepare_web_sms_over_plan_pay;
        prepare_web_sms_pre_plan_pay;
        prepare_web_sms_pre_end_agr;
        prepare_web_sms_chief;
    end;
end bars_web_sms_ins;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_web_sms_ins.sql =========*** En
 PROMPT ===================================================================================== 
 