

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/TRANSFER_TELLER.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  procedure TRANSFER_TELLER ***

  CREATE OR REPLACE PROCEDURE BARS.TRANSFER_TELLER 
is
l_ref_list number_list;
l_xml_body clob;
l_ret clob;
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

  begin
    begin
      return p_xml.extract(p_xpath).getStringVal();
    exception
      when others then
        if p_mandatory is null or false then
          return null;
        else
          if sqlcode = -30625 then
            bars_error.raise_nerror('BCK',
                                    'XMLTAG_NOT_FOUND',
                                    p_xpath,
                                    -1,
                                    -1);
          else
            raise;
          end if;
        end if;
    end;
  end;
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
   begin
      --подготовить реквест
    l_request := soap_rpc.new_request(p_url         => get_param_webconfig('TELLER.Url'),
                                      p_namespace   => 'http://tempuri.org/',
                                      p_method      => 'TellerSet',
                                      p_wallet_dir  => get_param_webconfig('Ner.Wallet_dir'),
                                      p_wallet_pass => get_param_webconfig('Ner.Wallet_pass'));


    -- добавить параметры
    soap_rpc.add_parameter(l_request,
                           'TellerData',
                            xml_body
                           );

    -- позвать метод веб-сервиса
    l_response := soap_rpc.invoke(l_request);

     --‘икс непри€тности в работе xpath при указанных xmlns
    l_clob := replace(l_response.doc.getClobVal(), 'xmlns', 'mlns');
    l_tmp  := xmltype(l_clob);

    ret_:=extract(l_tmp, '/TellerSetResponse/TellerSetResult/text()', null);
    exception
      when others
        then
            bars_error.raise_error('DOC',47,SQLERRM);


   end transfer_xml;
begin
 tuda;
 begin


     select cast(collect(q.ref) as number_list) ref_list,
            '<?xml version="1.0" encoding="windows-1251" ?>' ||
               xmlelement("tellers",
                xmlagg(xmlelement("teller",
                 xmlelement("FIO", utl_encode.text_encode(b.fio, encoding => utl_encode.base64)),
                 xmlelement("REF", q.ref),
                 xmlelement("BRANCH", p.branch),
                 xmlelement("TT",p.tt),
                 xmlelement("TT_NAME", utl_encode.text_encode(t.name, encoding => utl_encode.base64)),
                 xmlelement("S", p.s),
                 xmlelement("SQ",
                 (select gl.p_icurval (p.kv,p.s , p.bdat ) from dual)),
                 xmlelement("PDAT", to_char(p.pdat,'dd.mm.yyyy HH24:MI:SS')),
                 xmlelement("FDAT", to_char(p.bdat,'dd.mm.yyyy')),
                 xmlelement("ID", b.id||substr(p.branch,-3,2)),
                 xmlelement("KV", p.kv),
                 xmlelement("STATUS_TELL", q.STATUS_TELL),
                 xmlelement("KF", p.kf)
                 ))).getclobval() into l_ref_list, l_xml_body
                FROM TELLER_QUEUE q,
                              tts t,
                             oper p,
                     --teller_staff s,
                       staff$base b
                WHERE     q.REF = p.REF
                         and p.tt=t.tt
                         --AND s.id = B.ID
                         and P.USERID = b.ID
                         and q.msg_status='NEW'
                         and rownum <= 1000;


     transfer_xml(l_xml_body, l_ret);
        if l_ret='Ok' then
            delete from  TELLER_QUEUE  where ref in(select column_value from table(l_ref_list));
         else
            update TELLER_QUEUE set msg_status='ERROR' where ref in(select column_value from table(l_ref_list));
         end if;

   exception when others then
        if sqlcode=-20000 then null;
           else
              raise_application_error(-20000, substr(dbms_utility.format_error_backtrace||
                                                    dbms_utility.format_call_stack(),1,4000) );

         end if;
   end;

end transfer_teller;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/TRANSFER_TELLER.sql =========*** E
PROMPT ===================================================================================== 
