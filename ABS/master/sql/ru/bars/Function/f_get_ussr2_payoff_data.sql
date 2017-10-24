
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_ussr2_payoff_data.sql =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_USSR2_PAYOFF_DATA (p_date in date)
  return blob is
  l_payoff_data xmltype;
  l_xml         clob;
  l_file        blob;

  -- typecasts clob to blob (binary conversion)
  function c2b(c in clob) return blob is
    pos     pls_integer := 1;
    buffer  raw(32767);
    res     blob;
    lob_len pls_integer := dbms_lob.getlength(c);
  begin
    dbms_lob.createtemporary(res, true);
    dbms_lob.open(res, dbms_lob.lob_readwrite);

    loop
      buffer := utl_raw.cast_to_raw(dbms_lob.substr(c, 16000, pos));

      if utl_raw.length(buffer) > 0 then
        dbms_lob.writeappend(res, utl_raw.length(buffer), buffer);
      end if;

      pos := pos + 16000;
      exit when pos > lob_len;
    end loop;

    return res; -- res is open here
  end c2b;
begin
  for cur in (select a.acc, a.branch, a.nls, to_number(cw.value) as crv_rnk
                from accounts a, customerw cw
               where a.nbs = '2625'
                 and a.ob22 = '22'
                 and cw.rnk = a.rnk
                 and cw.tag = 'RVRNK'
                 and exists (select 1
                        from opldok od
                       where od.fdat = p_date
                         and od.acc = a.acc)) loop
    for cur_0 in (select xmlelement("card",
                                    xmlattributes(cur.crv_rnk as "crv_rnk",
                                                  cur.branch as "branch",
                                                  cur.nls as "nls"),
                                    xmlelement("payoffs",
                                               xmlagg(xmlelement("payoff",
                                                                 xmlattributes(od.dk as
                                                                               "direction",
                                                                               min(ow.value) as
                                                                               "type",
                                                                               count(*) as
                                                                               "count",
                                                                               sum(od.s) as
                                                                               "sum"))))) as payoffs
                    from opldok od, operw ow
                   where od.fdat = p_date
                     and od.acc = cur.acc
                     and od.ref = ow.ref
                     and ow.tag = 'OW_SC'
                   group by od.dk, od.tt) loop
      select xmlconcat(l_payoff_data, cur_0.payoffs)
        into l_payoff_data
        from dual;
    end loop;
  end loop;

  select '<?xml version="1.0" encoding="windows-1251" ?>' || xmlelement("payoff_data", xmlattributes(to_char(p_date,'ddmmyyyy') AS "date", to_char(f_ourmfo_g) AS "mfo"), l_payoff_data)
         .getclobval()
    into l_xml
    from dual;

  l_file := utl_compress.lz_compress(c2b(l_xml));
  dbms_lob.freetemporary(l_xml);

  return l_file;
end f_get_ussr2_payoff_data;
/
 show err;
 
PROMPT *** Create  grants  F_GET_USSR2_PAYOFF_DATA ***
grant EXECUTE                                                                on F_GET_USSR2_PAYOFF_DATA to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_USSR2_PAYOFF_DATA to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_ussr2_payoff_data.sql =======
 PROMPT ===================================================================================== 
 