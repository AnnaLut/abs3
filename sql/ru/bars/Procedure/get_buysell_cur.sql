

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/GET_BUYSELL_CUR.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure GET_BUYSELL_CUR ***

  CREATE OR REPLACE PROCEDURE BARS.GET_BUYSELL_CUR (p_type varchar2)
is
l_xml_body clob;
l_ret varchar2(4000);

  function get_param_webconfig(par varchar2) return web_barsconfig.val%type is
    l_res web_barsconfig.val%type;
  begin
    select val into l_res from web_barsconfig where key = par;
    return trim(l_res);
  exception
    when no_data_found then
      raise_application_error(-20000,
                              'Ќе найден KEY=' || par ||
                              ' в таблице web_barsconfig!');
  end;

function encode_base64(par varchar2) return varchar2 is
  begin
    return utl_encode.text_encode(par, encoding => utl_encode.base64);
  end;


procedure transfer_xml(xml_body clob, ret_ out clob)
   is
    l_request  soap_rpc.t_request;
    l_response soap_rpc.t_response;
    l_tmp      xmltype;
    l_message  varchar2(4000);
    l_clob     clob;
function extract(p_xml       in xmltype,
                   p_xpath     in varchar2,
                   p_mandatory in number) return varchar2 is
  g_is_error     boolean := false;
  g_cur_rep_id   number := -1;
  g_cur_block_id number := -1;
  begin
    begin
      return p_xml.extract(p_xpath).getStringVal();
    exception
      when others then
        if p_mandatory is null or g_is_error then
          return null;
        else
          if sqlcode = -30625 then
            bars_error.raise_nerror('BCK',
                                    'XMLTAG_NOT_FOUND',
                                    p_xpath,
                                    g_cur_block_id,
                                    g_cur_rep_id);
          else
            raise;
          end if;
        end if;
    end;
  end;
  begin
    --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => get_param_webconfig('VAL.Url'),
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'CorectData',
                                      p_wallet_dir  => get_param_webconfig('VAL.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('VAL.Wallet_pass'));
    -- добавить параметры
    soap_rpc.add_parameter(l_request,
                           'BatchData',
                            xml_body
                            );
    soap_rpc.add_parameter(l_request,
                           'p_type',
                            p_type
                            );
    -- позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);
     --‘икс непри€тности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);
    ret_:=extract(l_tmp, '/CorectDataResponse/CorectDataResult/text()', null);

  end transfer_xml;
begin
  if p_type = 'VAL' then

    select '<?xml version="1.0" encoding="windows-1251" ?>' ||
           '<records>'||
             xmlagg(xmlelement("record",
             xmlelement("p_type", 'VAL'),
             xmlelement("branch",        q.branch),
             xmlelement("fdat",          to_char(q.fdat,'dd.mm.yyyy')),
             xmlelement("kv",            to_char(q.kv)),
             xmlelement("buy_v",         to_char(q.buy_v)),
             xmlelement("sell_v",        to_char(q.sell_v)),
             xmlelement("vsp_get",       to_char(q.vsp_get)),
             xmlelement("vsp_send",      to_char(q.vsp_send)),
             xmlelement("vsp_cur_get",   to_char(q.vsp_cur_get)),
             xmlelement("vsp_cur_send",  to_char(q.vsp_cur_send)),
             xmlelement("conv_buy",      to_char(q.conv_buy)),
             xmlelement("conv_sell",     to_char(q.conv_sell)),
             xmlelement("conv_cur_buy",  to_char(q.conv_cur_buy)),
             xmlelement("conv_cur_sell", to_char(q.conv_cur_sell))
             )).getclobval() ||'</records>' into l_xml_body
      from ( select substr(aa.branch,1,8) branch,
                    oa.fdat,
                    aa.kv,
                    sum(case when (oa.dk = 1 and aa.nls like '3800%' and ab.nls like '100%') then oa.s else 0 end) buy_v,
                    sum(case when (oa.dk = 0 and aa.nls like '3800%' and ab.nls like '100%') then oa.s else 0 end) sell_v,
                    sum(case when (oa.dk = 1 and aa.nls like '3903%' and ab.nls like '3800%') then oa.s else 0 end) vsp_get,
                    sum(case when (oa.dk = 0 and aa.nls like '3903%' and ab.nls like '3800%') then oa.s else 0 end) vsp_send,
                    avg(case when (oa.dk = 1 and aa.nls like '3903%' and ab.nls like '3800%') then to_number(replace(ow.value,',','.')) else 0 end) vsp_cur_get,
                    avg(case when (oa.dk = 0 and aa.nls like '3903%' and ab.nls like '3800%') then to_number(replace(ow.value,',','.')) else 0 end) vsp_cur_send,
                    sum(case when (oa.dk = 1 and aa.nls like '2900%' and aa.kv != 980 and ab.nls like '3800%') then oa.s else 0 end) conv_buy,
                    avg(case when (oa.dk = 0 and aa.nls like '2900%' and aa.kv != 980 and ab.nls like '3800%') then oa.s else 0 end) conv_sell,
                    sum(case when (oa.dk = 1 and aa.nls like '2900%' and aa.kv != 980 and ab.nls like '3800%') then to_number(replace(ow.value,',','.')) else 0 end) conv_cur_buy,
                    avg(case when (oa.dk = 0 and aa.nls like '2900%' and aa.kv != 980 and ab.nls like '3800%') then to_number(replace(ow.value,',','.')) else 0 end) conv_cur_sell
               from opldok oa,
                    accounts aa,
                    opldok ob,
                    accounts ab,
                    operw ow,
                    tabval va
              where oa.ref = ob.ref
                and oa.stmt = ob.stmt
	  		  and oa.tt not in ('045', '38Y')
                and oa.fdat = trunc(sysdate-1)
                and oa.sos = 5
                and aa.acc = oa.acc
                and ab.acc = ob.acc
                and aa.kv = va.kv
                and va.prv = 0
                and ((aa.nls like '3800%' and ab.nls like '100%') or
                     (aa.nls like '3903%' and ab.nls like '3800%') or
                     (aa.nls like '2900%' and aa.kv != 980 and ab.nls like '3800%') or
                      aa.nls like '3540%' and oa.tt = 'GO2' or
                      ab.nls like '3540%' and ob.tt = 'CV7')
                and ow.ref(+) = oa.ref
                and ow.tag(+) = 'KURS'
              group by substr(aa.branch,1,8), oa.fdat, aa.kv) q;
     transfer_xml(encode_base64(l_xml_body), l_ret);

   elsif p_type = 'METAL' then
     for c in (select m.ref from metal_queue m, oper o where m.ref = o.ref and o.sos = 5) loop
       select '<?xml version="1.0" encoding="windows-1251"?>' ||
              '<records>'||
              xmlagg(xmlelement("record",
              xmlelement("p_type",'METAL'),
              xmlelement("pdat",to_char(o.pdat,'dd/mm/yyyy')),
              xmlelement("bdat", to_char(o.bdat,'dd/mm/yyyy')),
              xmlelement("ref", o.ref),
              xmlelement("tt", o.tt),
              xmlelement("cnt", w2.value),
              xmlelement("buy_rate", l.cena_k/ves_un),
              xmlelement("sell_rate", l.cena/ves_un),
              xmlelement("kv", o.kv),
              xmlelement("sum_grn", case when o.kv = 980 then o.s
                                         when o.kv <> 980 and o.kv2 <> 980 then o.sq
                                         else o.s2 end),
              xmlelement("kod", w1.value),
              xmlelement("name", b.name),
              xmlelement("ves", b.ves),
              xmlelement("ves_un", b.ves_un),
              xmlelement("branch", o.branch),
              xmlelement("kf", o.kf)
              )).getclobval() ||'</records>' into l_xml_body
         from oper o,
              operw w1,
              operw w2,
              bank_metals b,
              bank_metals$local l
        where o.ref = c.ref
          and o.sos = 5
          and o.ref = w1.ref
          and w1.tag = 'BM__C'
          and o.ref = w2.ref
          and w2.tag = 'BM__K'
          and w1.value = b.kod
		  and l.fdat = (select max(fdat) from bank_metals$local where trunc(fdat) = o.bdat)
          and o.bdat = trunc(l.fdat)
          and b.kod = l.kod;

         begin
           transfer_xml(encode_base64(l_xml_body), l_ret);

           if l_ret is not null then
             raise_application_error (-20000, l_ret);
           else
             delete from metal_queue where ref = c.ref;
           end if;
         end;

     end loop;
   end if;

end get_buysell_cur;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/GET_BUYSELL_CUR.sql =========*** E
PROMPT ===================================================================================== 
