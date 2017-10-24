
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_ussr2_rippayoff_data.sql ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_USSR2_RIPPAYOFF_DATA (p_date in date)
  return blob is
  l_date date := trunc(p_date, 'mm');
  l_xml  clob;
  l_file blob;

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
  select '<?xml version="1.0" encoding="windows-1251" ?>' || xmlelement("rippayoff_data", xmlattributes(to_char(add_months(l_date, -1),'mmyyyy') as "date", to_char(f_ourmfo_g) as "mfo"), xmlagg(xmlelement("record", xmlattributes(a.branch as "branch", a.nbs as "nbs", count(1) as "count", sum(o_in.s) as "sum"))))
         .getclobval()
    into l_xml
    from opldok o_out, opldok o_in, accounts a
   where o_out.acc in (select a.acc
                         from accounts a
                        where a.nbs = '2906'
                          and a.ob22 = '09')
     and o_out.dk = 0
     and o_out.fdat >= add_months(l_date, -1)
     and o_out.fdat < l_date
     and o_in.ref = o_out.ref
     and o_in.dk = 1
     and o_in.fdat = o_out.fdat
     and a.acc = o_in.acc
   group by a.branch, a.nbs;

  l_file := utl_compress.lz_compress(c2b(l_xml));
  dbms_lob.freetemporary(l_xml);

  return l_file;
end f_get_ussr2_rippayoff_data;
/
 show err;
 
PROMPT *** Create  grants  F_GET_USSR2_RIPPAYOFF_DATA ***
grant EXECUTE                                                                on F_GET_USSR2_RIPPAYOFF_DATA to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_USSR2_RIPPAYOFF_DATA to RPBN001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_ussr2_rippayoff_data.sql ====
 PROMPT ===================================================================================== 
 