

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TAX.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TAX ***

  CREATE OR REPLACE PROCEDURE BARS.TAX (acc_ IN number, rnk_ IN number, ot_ IN number)
IS
        mfo_            varchar2 (12);
        okpo_           varchar2 (14);
        tgr_            number (1);
        bank_date       date;
        nls_            varchar2 (15);
        pos_            number (1);
        kv_             number;
        rez_in          number;
        rez_out         number;
        nmk_            varchar2 (38);
        creg_           number (38);
        cdst_           number (38);
        cursor customer_cr is
        select
                okpo,
                tgr,
                substr (nmk, 1, 38),
                c_reg,
                c_dst,
                codcagent
        from
                customer
        where
                rnk = rnk_;
        cursor codcagent_cr is
        select
                rezid
        from
                codcagent
        where
                codcagent = rez_in;
begin
        bank_date := gl.bdate;
        mfo_ := gl.amfo;
        select
                nls,
                pos,
                kv
        into
                nls_,
                pos_,
                kv_
        from
                accounts
        where
                vid <> 0 and
                vid is not null and
                dazs is null and
                acc = acc_;
        open customer_cr;
        fetch customer_cr into okpo_, tgr_, nmk_, creg_, cdst_, rez_in;
        if customer_cr%notfound then
           close customer_cr;
           return;
        end if;
        close customer_cr;
        open codcagent_cr;
        fetch codcagent_cr into rez_out;
        if codcagent_cr%notfound then
           close codcagent_cr;
           return;
        end if;
        close codcagent_cr;
insert into ree_tmp
        (
        mfo,
        id_a,
        rt,
        ot,
        nls,
        odat,
        kv,
        c_ag,
        nmk,
        nmkw,
        c_reg,
        c_dst,
        prz
        )
values
        (
        mfo_,
        okpo_,
        tgr_,
        ot_,
        nls_,
        bank_date,
        kv_,
        rez_out,
        nmk_,
        nmk_,
        creg_,
        cdst_,
        pos_
        );
EXCEPTION
WHEN NO_DATA_FOUND THEN return;
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TAX.sql =========*** End *** =====
PROMPT ===================================================================================== 
