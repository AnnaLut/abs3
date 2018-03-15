PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/PACKAGE/nbu_601_formed_xml.sql =========*** Run *** 
PROMPT ===================================================================================== 

create or replace package nbu_601_formed_xml  as

 current_date   date;
 function get_xml_person_fo  return clob;
 function get_xml_document_fo return clob;
 function get_xml_address_fo return clob;
 function get_xml_person_uo return clob;
 function get_xml_finperformance_uo return clob;
 function get_xml_finperformancegr_uo return clob;
 function get_xml_ownerjur_uo return clob;
 function get_xml_ownerpp_uo return clob;
 function get_xml_partners_uo return clob;
 function get_xml_credit return clob;
 function get_xml_credit_pledge return clob;
 function get_xml_pledge_dep  return clob;
 function get_user_name  return varchar2;
 procedure run_formated_xml;

 end nbu_601_formed_xml;


/
create or replace package body nbu_601_formed_xml as

 current_user_kf varchar2(50):=sys_context('bars_context','user_mfo');

function  get_user_name  return varchar2
  is
  l_name varchar2(20);
  begin
   select user_name () into l_name from dual;
   return l_name;
  end;

function get_xml_person_fo return clob
  is
  l_xmltype_peson_fo xmltype;
  begin
   select xmlelement("ROOT",
          xmlelement("CURRENT_USER",get_user_name()) ,
          xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
          xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
          xmlelement("USER_KF", current_user_KF),
          XmlElement("PERSON_FO_FOS",
        xmlagg(XmlElement("PERSON_FO",
                           Xmlelement("RNK", p.rnk),
                           Xmlelement("LASTNAME",p.lastname),
                           Xmlelement("FIRSTNAME", p.firstname),
                           xmlelement("MIDDLENAME", p.middlename),
                           xmlelement("ISREZ", p.isrez),
                           xmlelement("INN", p.inn),
                           xmlelement("BIRTHDAY", to_char(p.birthday,'dd.mm.yyyy')),
                           xmlelement("CONTERYCODNEREZ", p.countrycodnerez),
                           xmlelement("K060", p.k060),
                           xmlelement("STATUS", p.status),
                           xmlelement("KF",p.kf)
                            ))
              ))
  into l_xmltype_peson_fo
  from nbu_person_fo p where kf=sys_context('bars_context','user_mfo');
  return l_xmltype_peson_fo.getClobVal();
    if l_xmltype_peson_fo is null then
       select XmlElement("PERSON_FO",'NO DATA') into l_xmltype_peson_fo from dual;
    end if;
 end get_xml_person_fo;

function get_xml_document_fo return clob
  is
  l_xml_document_fo xmltype;
  begin
    select xmlelement("ROOT",
          xmlelement("CURRENT_USER",get_user_name()) ,
          xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
          xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
          xmlelement("USER_KF", current_user_KF),
           XmlElement("DOCUMENT_FOS",
                    xmlagg(xmlelement("DOCUMENT_FO",
                              xmlelement("RNK", d.rnk),
                              xmlelement("TYPED",d.typed),
                              xmlelement("SERIYA",d.seriya),
                              xmlelement("NOMERD",d.nomerd),
                              xmlelement("DTD",to_char(d.dtd,'dd.mm.yyyy')),
                              xmlelement("STATUS",d.status),
                              xmlelement("KF",d.kf)
                            )))
                 )
   into l_xml_document_fo
   from nbu_document_fo d where kf=sys_context('bars_context','user_mfo');
    if l_xml_document_fo is null then
       select XmlElement("DOCUMENT_FO",'NO DATA') into l_xml_document_fo from dual;
    end if;
   return l_xml_document_fo.getClobVal();
end get_xml_document_fo;

function get_xml_address_fo return clob
  is
  l_xml_address_fo xmltype;
  begin
    select xmlelement("ROOT",
          xmlelement("CURRENT_USER",get_user_name()) ,
          xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
          xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
          xmlelement("USER_KF", current_user_KF),
           XmlElement("ADDRESS_FOS",
                   xmlagg(xmlelement("ADDRESS_FO",
                               xmlelement("RNK",a.rnk),
                               xmlelement("CODEREGION",a.codregion),
                               xmlelement("AREA",a.area),
                               xmlelement("ZIP",a.zip),
                               xmlelement("CITY",a.city),
                               xmlelement("STREETADDRESS",a.streetaddress),
                               xmlelement("HAUSENO",a.houseno),
                               xmlelement("ADRKORP",a.adrkorp),
                               xmlelement("FLATNO",a.flatno),
                               xmlelement("STATUS",a.status),
                               xmlelement("KF",a.kf)
                               )))
                  )
   into l_xml_address_fo
   from nbu_address_fo a where kf=sys_context('bars_context','user_mfo');
     if l_xml_address_fo is null then
       select XmlElement("ADDRESS_FO",'NO DATA') into l_xml_address_fo from dual;
     end if;
   return l_xml_address_fo.getClobVal();
end get_xml_address_fo;

function get_xml_person_uo  return clob
  is
  l_xml_person_uo xmltype;
  begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", current_user_KF),
            XmlElement("PERSON_UO_FOS",
                  xmlagg(xmlelement("PERSON_UO",
                               xmlelement("RNK", p.rnk),
                               xmlelement("NAMEUR", p.nameur),
                               xmlelement("ISREZ", p.isrez),
                               xmlelement("CODEDRPOU", p.codedrpou),
                               xmlelement("REGISTRDAY", to_char(p.registryday,'dd.mm.yyyy')),
                               xmlelement("NUMBERREGISTRY", p.numberregistry),
                               xmlelement("K110", p.k110),
                               xmlelement("EC_YEAR", p.ec_year),
                               xmlelement("COUNTERYCODNEREZ", p.countrycodnerez),
                               xmlelement("ISMEMBER", p.ismember),
                               xmlelement("ISCONTROLLER",p.iscontroller),
                               xmlelement("ISPARTNER",p.ispartner),
                               xmlelement("ISAUDIT",p.isaudit),
                               xmlelement("k060",p.k060),
                               xmlelement("STATUS",p.status),
                               xmlelement("KF",p.kf)
                            )))
                 )
    into l_xml_person_uo
    from nbu_person_uo p where kf=sys_context('bars_context','user_mfo');
     if l_xml_person_uo is null then
       select XmlElement("PERSON_UO",'NO DATA') into l_xml_person_uo from dual;
     end if;
    return l_xml_person_uo.getClobVal();
end get_xml_person_uo;

function get_xml_finperformance_uo return clob
  is
  l_xml_finperformance_uo xmltype;
  begin
   select xmlelement("ROOT",
          xmlelement("CURRENT_USER",get_user_name()) ,
          xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
          xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
          xmlelement("USER_KF", current_user_KF),
          XmlElement("FINPERFORMANCE_UO_FOS",
                          xmlagg(xmlelement("FINPERFORMANCE_UO",
                               xmlelement("RNK", f.rnk),
                               xmlelement("SALES", f.sales),
                               xmlelement("ebit", f.ebit),
                               xmlelement("CODEDRPOU", f.ebitda),
                               xmlelement("REGISTRDAY", to_char(f.totaldebt,'dd.mm.yyyy')),
                               xmlelement("NUMBERREGISTRY", f.status),
                               xmlelement("KF",f.kf)
                         )))
                 )
     into l_xml_finperformance_uo
     from nbu_finperformance_uo f where kf=sys_context('bars_context','user_mfo');
      if l_xml_finperformance_uo is null then
       select XmlElement("FINPERFORMANCE_UO",'NO DATA') into l_xml_finperformance_uo from dual;
     end if;
    return l_xml_finperformance_uo.getClobVal();
end get_xml_finperformance_uo;

function get_xml_finperformancegr_uo return clob
  is
  l_xml_finperformancegr_uo xmltype;
  begin
   select xmlelement("ROOT",
          xmlelement("CURRENT_USER",get_user_name()) ,
          xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
          xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
          xmlelement("USER_KF", current_user_KF),
          XmlElement("FINPERFORMANCEGR_UO_FOS",
          xmlagg(xmlelement("FINPERFORMANCEGR_UO",
                               xmlelement("RNK", f.rnk),
                               xmlelement("SALESGR", f.salesgr),
                               xmlelement("EBITGR", f.ebitgr),
                               xmlelement("TOTALDEBTGR", f.totaldebtgr),
                               xmlelement("CLASSGR", f.classgr),
                               xmlelement("STATUS", f.status),
                               xmlelement("KF", f.kf)
                            )))
                 )
    into l_xml_finperformancegr_uo
    from nbu_finperformancegr_uo f where kf=sys_context('bars_context','user_mfo');
     if l_xml_finperformancegr_uo is null then
       select XmlElement("FINPERFORMANCEGR_UO",'NO DATA') into l_xml_finperformancegr_uo from dual;
     end if;
   return l_xml_finperformancegr_uo.getClobVal();
end;

function get_xml_ownerjur_uo return clob
  is
  l_xml_ownerjur_uo xmltype;
   Begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", current_user_KF),
           XmlElement("OWNERJUR_UO_FOS",
                    xmlagg(xmlelement("OWNERJUR_UO",
                               xmlelement("RNK",o.rnk),
                               xmlelement("RNKB",o.rnkb),
                               xmlelement("NAMEOJ",o.nameoj),
                               xmlelement("ISREZOJ",o.isrezoj),
                               xmlelement("CODEDRPOUOJ",o.codedrpouoj),
                               xmlelement("REGISTRYDAYOJ",o.registrydayoj),
                               xmlelement("NUMBERREGISTRYOJ",o.numberregistryoj),
                               xmlelement("CONTRYCODOJ",o.countrycodoj),
                               xmlelement("PARCENOJ",o.percentoj),
                               xmlelement("STATUS",o.status),
                               xmlelement("KF",o.kf)
                             )))
                 )
     into l_xml_ownerjur_uo
     from nbu_ownerjur_uo o where kf=sys_context('bars_context','user_mfo');
      if l_xml_ownerjur_uo is null then
       select XmlElement("OWNERJUR_UO",'NO DATA') into l_xml_ownerjur_uo from dual;
      end if;
     return  l_xml_ownerjur_uo.getClobVal();
end;

 function get_xml_ownerpp_uo return clob
   is
  l_xml_ownerpp_uo xmltype;
   Begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", current_user_KF),
           XmlElement("OWNERPP_UO_FOS",
                   xmlagg(xmlelement("OWNERPP_UO",
                               xmlelement("RNK",o.rnk),
                               xmlelement("RNKB",o.rnkb),
                               xmlelement("LASTNAME",o.lastname),
                               xmlelement("FIRSTNAME",o.firstname),
                               xmlelement("MIDDLENAME",o.middlename),
                               xmlelement("ISREZ",o.isrez),
                               xmlelement("INN",o.inn),
                               xmlelement("COUNTRYCOD",o.countrycod),
                               xmlelement("PERCENT",to_char(o.percent,'99990,99')),
                               xmlelement("STATUS",o.status),
                               xmlelement("KF",o.kf)
                             )))
                 )
    into l_xml_ownerpp_uo
    from nbu_ownerpp_uo o where kf=sys_context('bars_context','user_mfo');
     if l_xml_ownerpp_uo is null then
       select XmlElement("OWNERPP_UO",'NO DATA') into l_xml_ownerpp_uo from dual;
     end if;
    return l_xml_ownerpp_uo.getClobVal();
end;

function get_xml_partners_uo return clob
  is
  l_xml_partners_uo xmltype;
   Begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", current_user_KF),
           XmlElement("PARTNERS_UO_FOS",
                     xmlagg(xmlelement("PARTNERS_UO",
                               xmlelement("RNK",p.rnk),
                               xmlelement("ISREZPR",p.isrezpr),
                               xmlelement("CODEDRPOUPR",p.codedrpoupr),
                               xmlelement("NAMEURPR",p.nameurpr),
                               xmlelement("COUNTRYCODPR",p.countrycodpr),
                               xmlelement("STATUS",p.status),
                               xmlelement("KF",p.kf)
                             )))
                 )
   into l_xml_partners_uo
   from nbu_partners_uo p where kf=sys_context('bars_context','user_mfo');
    if l_xml_partners_uo is null then
       select XmlElement("PARTNERS_UO",'NO DATA') into l_xml_partners_uo from dual;
    end if;
   return l_xml_partners_uo.getClobVal();
end;

function get_xml_credit return clob
  is
  l_xml_credit xmltype;
   Begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", current_user_KF),
           XmlElement("NBU_CREDIT_FOS",
               xmlagg(xmlelement("NBU_CREDIT",
                               xmlelement("RNK",c.rnk),
                               xmlelement("ND",c.nd),
                               xmlelement("ORDERNUM",c.ordernum),
                               xmlelement("FLAGOSOBA",c.flagosoba),
                               xmlelement("TYPECREDIT",c.typecredit),
                               xmlelement("NUMDOG",c.numdog),
                               xmlelement("DOGDAY",to_char(c.dogday,'dd.mm.yyyy')),
                               xmlelement("ENDDAY",to_char(c.endday,'dd.mm.yyyy')),
                               xmlelement("SUMZAGAL",c.sumzagal),
                               xmlelement("R030",c.r030),
                               xmlelement("PROCCREDIT",to_char(c.proccredit,'99990.99')),
                               xmlelement("SUMPAY",c.sumpay),
                               xmlelement("PERIODBASE",c.periodbase),
                               xmlelement("PERIODPROC",c.periodproc),
                               xmlelement("SUMARREARS",c.sumarrears),
                               xmlelement("ARREARBASE",c.arrearbase),
                               xmlelement("ARREARPROC",c.arrearproc),
                               xmlelement("DAYBASE",c.daybase),
                               xmlelement("DAYPROC",c.dayproc),
                               xmlelement("FACTENDDAY",to_date(c.factendday,'dd.mm.yyyy')),
                               xmlelement("FLAGZ",c.flagz),
                               xmlelement("KLASS",c.klass),
                               xmlelement("RISK",c.risk),
                               xmlelement("FLAGINSUREANCE",c.flaginsurance),
                               xmlelement("STATUS",c.status),
                               xmlelement("KF",c.kf)
                             )))
                 )
   into l_xml_credit
   from nbu_credit c where kf=sys_context('bars_context','user_mfo');
    if l_xml_credit is null then
       select XmlElement("NBU_CREDIT",'NO DATA') into l_xml_credit from dual;
    end if;
    return l_xml_credit.getClobVal();
end;

function get_xml_credit_pledge return clob
  is
  l_xml_credit_pladge xmltype;
  begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", current_user_KF),
           XmlElement("CREDIT_PLADGE_FOS",
          xmlagg( xmlelement("CREDIT_PLADGE",
                                xmlelement("RNK",c.rnk),
                                xmlelement("ND",c.nd),
                                xmlelement("ACC",c.acc_ple),
                                xmlelement("SUMPALDGE",c.sumpledge),
                                xmlelement("PRICEPLADGE",c.pricepledge),
                                xmlelement("STATUS",c.status),
                                xmlelement("KF",c.kf)
                              )))
                 )
    into l_xml_credit_pladge
    from nbu_credit_pledge c where kf=sys_context('bars_context','user_mfo');
     if l_xml_credit_pladge is null then
       select XmlElement("CREDIT_PLADGE",'NO DATA') into l_xml_credit_pladge from dual;
    end if;
    return l_xml_credit_pladge.getClobVal();

end;

function get_xml_pledge_dep return clob
  is
  l_xml_pledge_dep xmltype;
  begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", current_user_KF),
           XmlElement("PLEDGE_DEP_FOS",
          xmlagg( xmlelement("PLEDGE_DEP",
                                xmlelement("RNK",c.rnk),
                                xmlelement("ACC",c.acc),
                                xmlelement("ORDERNUM",c.ordernum),
                                xmlelement("NUMBERPLEDGE",c.numberpledge),
                                xmlelement("PLEDGEDAY",c.pledgeday),
                                xmlelement("S031",c.s031),
                                xmlelement("R030",c.r030),
                                xmlelement("SUMPLEDGE",c.sumpledge),
                                xmlelement("PRICEPLEDGE",c.pricepledge),
                                xmlelement("LASTPLEDGEDAY",c.lastpledgeday),
                                xmlelement("CODREALTY",c.codrealty),
                                xmlelement("ZIPREALTY",c.ziprealty),
                                xmlelement("SQUAREREALTY",c.squarerealty),
                                xmlelement("REAL6INCOME",c.real6income),
                                xmlelement("NOREAL6INCOME",c.noreal6income),
                                xmlelement("FLAGINSURANCEPLEDGE",c.flaginsurancepledge),
                                xmlelement("NUMDOGDP",c.numdogdp),
                                xmlelement("DOGDAYDP",to_char(c.dogdaydp,'dd.mm.yyyy')),
                                xmlelement("R030DP",c.r030dp),
                                xmlelement("SUMDP",c.sumdp),
                                xmlelement("STATUS",c.status),
                                xmlelement("KF",c.kf)
                              )))
                 )
    into l_xml_pledge_dep
    from nbu_pledge_dep c where kf=sys_context('bars_context','user_mfo');
     if l_xml_pledge_dep is null then
       select XmlElement("PLEDGE_DEP",'NO DATA') into l_xml_pledge_dep from dual;
    end if;
    return l_xml_pledge_dep.getClobVal();
end;

procedure run_formated_xml
  is
  id number;
  params BARSTRANS.TRANSP_UTL.t_add_params;
  KF varchar2(6);
  begin
   params(1).param_type:='GET';
   params(1).tag:='KF';
   params(1).value:=f_ourmfo;
   KF:=current_user_kf;
    begin
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_person_fo(), params, 'NBU_PERSON_FO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_document_fo(), params, 'NBU_DOCUMENT_FO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_address_fo(), params, 'NBU_ADDRESS_FO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_person_uo(), params, 'NBU_PERSON_UO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_finperformance_uo(), params, 'NBU_FINPERFORMANCE_UO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_finperformancegr_uo(), params, 'NBU_FINPERFORMANCEGR_UO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_partners_uo(), params, 'NBU_PARTNERS_UO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_ownerpp_uo(), params, 'NBU_OWNERPP_UO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_ownerjur_uo(), params, 'NBU_OWNERJUR_UO', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_credit(), params, 'NBU_CREDIT', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_credit_pledge(), params, 'NBU_CREDIT_PLADGE', KF, id);
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_pledge_dep(), params, 'NBU_PLADGE_DEP', KF, id);
    end;
   end;

end;
/

grant execute on nbu_601_formed_xml to barstrans;
grant execute on nbu_601_formed_xml to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End*** ========== Scripts /Sql/BARS/PACKAGE/nbu_601_formed_xml.sql =========*** End*** 
PROMPT ===================================================================================== 


