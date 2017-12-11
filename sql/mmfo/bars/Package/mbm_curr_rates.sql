
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mbm_curr_rates.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MBM_CURR_RATES is
    type r_currency_rates
        is record
        ( CURRENCYID                               NUMBER(3),
         CURRENCYCODE                              CHAR(3),
         CURRENCYNAME                              VARCHAR2(35),
         BASECURRENCYID                            NUMBER,
         BASECURRENCYCODE                          CHAR(3),
         DATES                                      DATE,
         SIZES                                      NUMBER(9,4),
         BUY                                       NUMBER(9,4),
         SALE                                      NUMBER(9,4),
         OFFICIAL                                  NUMBER(9,4),
         BUYPREV                                   NUMBER(9,4),
         SALEPREV                                  NUMBER(9,4),
         OFFICIALPREV                              NUMBER(9,4),
         BUYNEXT                                   NUMBER(9,4),
         SALENEXT                                  NUMBER(9,4),
         OFFICIALNEXT                              NUMBER(9,4));

    type r_currency_rates_table is table of r_currency_rates;

    FUNCTION f_currency_rates_bulk(p_date date, p_currencty_code varchar2)
    RETURN r_currency_rates_table
    result_cache;

    function get_currency_rates(p_date date, p_currencty_code varchar2)
    return t_currency_rates_table
    pipelined;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.MBM_CURR_RATES as

    FUNCTION f_currency_rates_bulk(p_date date, p_currencty_code varchar2)
    RETURN r_currency_rates_table
    result_cache relies_on (cur_rates$base)
    IS
        l_currency_rates r_currency_rates_table;
    BEGIN
        dbms_output.put_line('f_currency_rates_bulk called');
        select cr.kv,
                                t.lcv,
                                t.name,
                                980,
                                'UAH',
                                cr.vdate,
                                cr.bsum,
                                cr.rate_b,
                                cr.rate_s,
                                cr.rate_o,
                                cp.rate_b_prev,
                                cp.rate_s_prev,
                                cp.rate_o_prev,
                                cn.rate_b_next,
                                cn.rate_s_next,
                                cn.rate_o_next
       bulk collect into l_currency_rates
       from cur_rates cr,
            (select
                cp.rate_o rate_o_prev,
                cp.rate_b rate_b_prev,
                cp.rate_s rate_s_prev
            from
                cur_rates$base cp
            where
                (cp.kv, cp.vdate)= (  select
                                            crb.kv,
                                            max(crb.vdate) vdate
                                        from
                                            cur_rates crb
                                            ,tabval$global tv
                                        where
                                            crb.vdate <= p_date-1
                                            and tv.lcv = p_currencty_code
                                            and length (crb.branch)=8
                                            and CRB.KV = TV.KV
                                        group by crb.kv)
                and length(cp.branch)=8) cp,
            (select
                cn.rate_o rate_o_next,
                cn.rate_b rate_b_next,
                cn.rate_s rate_s_next
            from
                cur_rates$base cn
            where
                (cn.kv, cn.vdate)= ( select
                                        crb.kv,
                                        max(crb.vdate) vdate
                                    from
                                        cur_rates crb
                                        ,tabval$global tv
                                    where
                                        crb.vdate <= p_date+1
                                        and tv.lcv = p_currencty_code
                                        and length (crb.branch)=8
                                        and CRB.KV = TV.KV
                                    group by crb.kv)
                    and length(cn.branch)=8) cn,
            tabval t
        where
            (cr.kv, cr.vdate)= (select
                                    crb.kv,
                                    max(crb.vdate) vdate
                                from
                                    cur_rates crb
                                    ,tabval$global tv
                                where
                                    crb.vdate <= p_date
                                    and tv.lcv = p_currencty_code
                                    and length (crb.branch)=8
                                    and CRB.KV = TV.KV
                                group by crb.kv)
            and length(cr.branch)=8
            and CR.KV=t.kv;

        RETURN l_currency_rates;
    END;

    function get_currency_rates(p_date date, p_currencty_code varchar2)
    return t_currency_rates_table
    pipelined
    is
        l_currency_rates_data r_currency_rates_table;
        l integer;
    begin
        l_currency_rates_data := f_currency_rates_bulk(p_date, p_currencty_code);
        l := l_currency_rates_data.first;
        while (l is not null) loop
            pipe row (t_currency_rates(l_currency_rates_data(l).CURRENCYID,
                                 l_currency_rates_data(l).CURRENCYCODE,
                                 l_currency_rates_data(l).CURRENCYNAME,
                                 l_currency_rates_data(l).BASECURRENCYID,
                                 l_currency_rates_data(l).BASECURRENCYCODE,
                                 l_currency_rates_data(l).DATES,
                                 l_currency_rates_data(l).SIZES,
                                 l_currency_rates_data(l).BUY,
                                 l_currency_rates_data(l).SALE,
                                 l_currency_rates_data(l).OFFICIAL,
                                 l_currency_rates_data(l).BUYPREV,
                                 l_currency_rates_data(l).SALEPREV,
                                 l_currency_rates_data(l).OFFICIALPREV,
                                 l_currency_rates_data(l).BUYNEXT,
                                 l_currency_rates_data(l).SALENEXT,
                                 l_currency_rates_data(l).OFFICIALNEXT));
            l := l_currency_rates_data.next(l);
        end loop;
        return;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  MBM_CURR_RATES ***
grant EXECUTE                                                                on MBM_CURR_RATES  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mbm_curr_rates.sql =========*** End 
 PROMPT ===================================================================================== 
 