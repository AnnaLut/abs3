
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_sms_ins.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SMS_INS is

    procedure prepare_sms_pre_plan_pay;

    procedure prepare_sms_pre_end_agr;

end bars_sms_ins;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SMS_INS is

    g_msg_pre_plan_pay varchar2 (160) := 'SHANOVNYI KLIENTE, NAHADUEMO, SHCHO date VAM POTRIBNO OPLATYTY CHERHOVYI STRAKHOVYI PLATIZH PO VASHOMU DOHOVORU U VIDDILENNI OSHCHADBANKU. SHCHYRO VASH BANK.';
    g_msg_pre_end_agr  varchar2 (160) := 'SHANOVNYI KLIENTE, NAHADUEMO, SHCHO date ZAKINCHUETSIA STROK DII DOHOVORU STRAKHUVANNIA. PROPONUEMO PODOVZHYTY YOHO NA NOVYI STROK. SHCHYRO VASH OSHCHADBANK.';

    procedure prepare_sms_pre_plan_pay is
        -------------------------------------------------------------------------------------
        l_crtime date := sysdate;
        l_msgid  msg_submit_data.msg_id%type := null;
        -------------------------------------------------------------------------------------
        cursor cur_send_sms is
        select to_char(psh.plan_date,'dd.mm') plan_date, cw.value cellphone
        from ins_deals dl
        join ins_payments_schedule psh on dl.id = psh.deal_id and
                                          dl.status_id = 'ON' and
                                          psh.payed = 0 and
                                          trunc(psh.plan_date) = trunc(sysdate) + 14
        join customer c on c.rnk = dl.ins_rnk and c.custtype in (3,2)
        join customerw cw on cw.rnk = c.rnk and tag in ('MPNO','MOB01');
        -------------------------------------------------------------------------------------
        type tab_cur_send_sms is table of cur_send_sms%rowtype;
        l_tab_cur_send_sms tab_cur_send_sms;
        -------------------------------------------------------------------------------------
    begin
        open cur_send_sms;
        loop
            fetch cur_send_sms bulk collect into l_tab_cur_send_sms limit 100;
            exit when nvl(l_tab_cur_send_sms.count,0) = 0;
            for i in l_tab_cur_send_sms.first .. l_tab_cur_send_sms.last loop
                -- создаем само сообщение
                bars_sms.create_msg (l_msgid,
                                     l_crtime,
                                     l_crtime + 13,
                                     l_tab_cur_send_sms(i).cellphone,
                                     'lat',
                                     replace(g_msg_pre_plan_pay, 'date', l_tab_cur_send_sms(i).plan_date));
                l_msgid := null;
            end loop;
        end loop;
        close cur_send_sms;
    end;

    procedure prepare_sms_pre_end_agr is
        -------------------------------------------------------------------------------------
        l_crtime date := sysdate;
        l_msgid  msg_submit_data.msg_id%type := null;
        -------------------------------------------------------------------------------------
        cursor cur_send_sms is
        select to_char(dl.edate,'dd.mm') edate, cw.value cellphone
        from ins_deals dl
        join customer c on c.rnk = dl.ins_rnk and
                             c.custtype in (3,2) and
                             dl.status_id = 'ON' and
                             trunc(dl.edate) = trunc(sysdate) + 14
        join customerw cw on cw.rnk = c.rnk and tag in ('MPNO','MOB01');
        -------------------------------------------------------------------------------------
        type tab_cur_send_sms is table of cur_send_sms%rowtype;
        l_tab_cur_send_sms tab_cur_send_sms;
        -------------------------------------------------------------------------------------
    begin
        open cur_send_sms;
        loop
            fetch cur_send_sms bulk collect into l_tab_cur_send_sms limit 100;
            exit when nvl(l_tab_cur_send_sms.count,0) = 0;
            for i in l_tab_cur_send_sms.first .. l_tab_cur_send_sms.last loop
                -- создаем само сообщение
                bars_sms.create_msg (l_msgid,
                                     l_crtime,
                                     l_crtime + 13,
                                     l_tab_cur_send_sms(i).cellphone,
                                     'lat',
                                     replace(g_msg_pre_end_agr, 'date', l_tab_cur_send_sms(i).edate));
                l_msgid := null;
            end loop;
        end loop;
        close cur_send_sms;
    end;

end bars_sms_ins;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_sms_ins.sql =========*** End **
 PROMPT ===================================================================================== 
 