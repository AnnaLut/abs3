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
 function get_xml_groupur_uo return clob;
 function get_xml_finperformancepr_uo return clob;
 function get_xml_credit_tranche return clob; 
 procedure run_formated_xml_job (p_kf in varchar2, p_user_id in varchar2);
 procedure run_formated_xml;

end nbu_601_formed_xml;
/
create or replace package body nbu_601_formed_xml as

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
          xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
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
          xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
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
          xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
           XmlElement("ADDRESS_FOS",
                   xmlagg(xmlelement("ADDRESS_FO",
                               xmlelement("RNK",a.rnk),
                               xmlelement("CODEREGION",a.codregion),
                               xmlelement("AREA",a.area),
                               xmlelement("ZIP",a.zip),
                               xmlelement("CITY",a.city),
                               xmlelement("STREETADDRESS",a.streetaddress),
                               xmlelement("HOUSENO",a.houseno),
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
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
            XmlElement("PERSON_UO_FOS",
                  xmlagg(xmlelement("PERSON_UO",
                               xmlelement("RNK", p.rnk),
                               xmlelement("NAMEUR", p.nameur),
                               xmlelement("ISREZ", p.isrez),
                               xmlelement("CODEDRPOU", p.codedrpou),
                               xmlelement("REGISTRDAY", to_char(p.registryday,'dd.mm.yyyy')),
                               xmlelement("NUMBERREGISTRY", p.numberregistry),
                               xmlelement("K110", p.k110),
                               xmlelement("EC_YEAR",to_char(p.ec_year,'dd.mm.yyyy')),
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
          xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
          XmlElement("FINPERFORMANCE_UO_FOS",
                          xmlagg(xmlelement("FINPERFORMANCE_UO",
                               xmlelement("RNK", f.rnk),
                               xmlelement("SALES", f.sales),
                               xmlelement("EBIT", f.ebit),
                               xmlelement("EBITDA", f.ebitda),
                               xmlelement("TOTALDEBT", f.totaldebt),
                               xmlelement("STATUS", f.status),
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

function get_xml_groupur_uo  return clob
  is
  l_xml_groupur_uo xmltype;
  begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
            XmlElement("GROUPUR_UO_FOS",
                  xmlagg(xmlelement("GROUPUR_UO",
                               xmlelement("RNK", p.rnk),
                               xmlelement("WHOIS", p.whois),
                               xmlelement("ISREZGR", p.isrezgr),
                               xmlelement("CODEDRPOUGR", p.codedrpougr),
                               xmlelement("NAMEURGR", p.nameurgr),
                               xmlelement("COUNTRYCODGR", p.countrycodgr),
                               xmlelement("STATUS",p.status),
                               xmlelement("STATUS_MESSAGE", p.status_message),
                               xmlelement("KF",p.kf)
                            )))
                 )
    into l_xml_groupur_uo
    from nbu_groupur_uo p where kf=sys_context('bars_context','user_mfo');
     if l_xml_groupur_uo is null then
       select XmlElement("GROUPUR_UO",'NO DATA') into l_xml_groupur_uo from dual;
     end if;
    return l_xml_groupur_uo.getClobVal();
end get_xml_groupur_uo;

function get_xml_finperformancegr_uo return clob
  is
  l_xml_finperformancegr_uo xmltype;
  begin
   select xmlelement("ROOT",
          xmlelement("CURRENT_USER",get_user_name()) ,
          xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
          xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
          xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
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


function get_xml_finperformancepr_uo return clob
  is
  l_xml_finperformancepr_uo xmltype;
  begin
   select xmlelement("ROOT",
          xmlelement("CURRENT_USER",get_user_name()) ,
          xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
          xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
          xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
          XmlElement("FINPERFORMANCEPR_UO_FOS",
          xmlagg(xmlelement("FINPERFORMANCEPR_UO",
                               xmlelement("RNK", f.rnk),
                               xmlelement("SALES", f.sales),
                               xmlelement("EBIT", f.ebit),
                               xmlelement("EBITDA",f.ebitda),
                               xmlelement("TOTALDEBT", f.totaldebt),
                               xmlelement("STATUS", f.status),
                               xmlelement("KF", f.kf)
                            )))
                 )
    into l_xml_finperformancepr_uo
    from nbu_finperformancepr_uo f where kf=sys_context('bars_context','user_mfo');
     if l_xml_finperformancepr_uo is null then
       select XmlElement("FINPERFORMANCEPR_UO",'NO DATA') into l_xml_finperformancepr_uo from dual;
     end if;
   return l_xml_finperformancepr_uo.getClobVal();
end;


function get_xml_ownerjur_uo return clob
  is
  l_xml_ownerjur_uo xmltype;
   Begin
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
           XmlElement("OWNERJUR_UO_FOS",
                    xmlagg(xmlelement("OWNERJUR_UO",
                               xmlelement("RNK",o.rnk),
                               xmlelement("RNKB",o.rnkb),
                               xmlelement("NAMEOJ",o.nameoj),
                               xmlelement("ISREZOJ",o.isrezoj),
                               xmlelement("CODEDRPOUOJ",o.codedrpouoj),
                               xmlelement("REGISTRYDAYOJ",to_char (o.registrydayoj,'dd.mm.yyyy')),
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
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
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
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
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
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
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
                               xmlelement("FACTENDDAY",to_char(c.factendday,'dd.mm.yyyy')),
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
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
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
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
           XmlElement("PLEDGE_DEP_FOS",
          xmlagg( xmlelement("PLEDGE_DEP",
                                xmlelement("RNK",c.rnk),
                                xmlelement("ACC",c.acc),
                                xmlelement("ORDERNUM",c.ordernum),
                                xmlelement("NUMBERPLEDGE",REGEXP_REPLACE(c.numberpledge,'[^[:print:]]', '')),
                                xmlelement("PLEDGEDAY",to_char(c.pledgeday,'dd.mm.yyyy')),
                                xmlelement("S031",c.s031),
                                xmlelement("R030",c.r030),
                                xmlelement("SUMPLEDGE",c.sumpledge),
                                xmlelement("PRICEPLEDGE",c.pricepledge),
                                xmlelement("LASTPLEDGEDAY",to_char(c.lastpledgeday,'dd.mm.yyyy')),
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

function get_xml_credit_tranche return clob
 is
 l_xml_credit_tranche xmltype;
 begin 
    select xmlelement("ROOT",
           xmlelement("CURRENT_USER",get_user_name()) ,
           xmlelement("REPORTING_TIME",to_char(sysdate,'dd.mm.yyyy hh24:mi:ss')),
           xmlelement("REPORTING_DATE",to_char(trunc(sysdate,'mm'),'dd.mm.yyyy')),
           xmlelement("USER_KF", sys_context('bars_context','user_mfo')),
           XmlElement("CREDIT_TRANCHE_FOS",
          xmlagg( xmlelement("CREDIT_TRANCHE",
                                xmlelement("RNK",t.rnk),
                                xmlelement("ND",t.nd),
                                xmlelement("NUMDOGTR",t.numdogtr),
                                xmlelement("DOGDAYTR",to_char(t.dogdaytr,'dd.mm.yyyy')),
                                xmlelement("ENDDAYTR",to_char(t.enddaytr,'dd.mm.yyyy')),
                                xmlelement("SUMZAGALTR",t.sumzagaltr),
                                xmlelement("R030TR",t.r030tr),
                                xmlelement("PROCCREDITTR",t.proccredittr),
                                xmlelement("PERIODBASETR",t.periodbasetr),
                                xmlelement("PERIODPROCTR",t.periodproctr),
                                xmlelement("SUMARREARSTR",t.sumarrearstr),
                                xmlelement("ARREARBASETR",t.arrearbasetr ),
                                xmlelement("ARREARPROCTR",t.arrearproctr ),
                                xmlelement("DAYBASETR", t.daybasetr),
                                xmlelement("DAYPROCTR",t.dayproctr),
                                xmlelement("FACTENDDAYTR",to_char(t.factenddaytr,'dd.mm.yyyy')),
                                xmlelement("KLASSTR",t.klasstr),
                                xmlelement("RISKTR",t.risktr),
                                xmlelement("STATUS",t.status),
                                xmlelement("KF",t.kf)
                              )))
                 )
    into l_xml_credit_tranche
    from nbu_credit_tranche t where kf=sys_context('bars_context','user_mfo');
     if l_xml_credit_tranche is null then
       select XmlElement("CREDIT_TRANCHE",'NO DATA') into l_xml_credit_tranche from dual;
    end if;
    return l_xml_credit_tranche.getClobVal();
 end; 

procedure run_formated_xml_job (p_kf in varchar2, p_user_id in varchar2)
  is
  id number;
  params BARSTRANS.TRANSP_UTL.t_add_params;
  KF varchar2(6);
  l_request_id_person_fo number;
  l_request_id_document_fo number;
  l_request_id_address_fo number;
  l_request_id_person_uo number;
  l_request_id_finperformance_uo number;
  l_request_id_fingr_uo number;
  l_request_id_partners_uo number;
  l_request_id_ownerpp number;
  l_request_id_ownerjur number;
  l_request_id_credit number;
  l_request_id_credit_pledge number;
  l_request_id_pledge_dep number;
  l_request_id_groupur_uo number;
  l_request_id_finpr_uo number;
  l_request_id_cred_tranch number;
  begin
     bars_login.login_user(p_sessionid =>sys_guid(),
                         p_userid    =>p_user_id ,
                         p_hostname  =>null ,
                         p_appname   =>null );

   bc.go(p_kf);
   bars_audit.info('KF_601= ' || ' ' ||p_kf);
   params(1).param_type:='GET';
   params(1).tag:='KF';
   params(1).value:=p_kf;
   KF:=300465;

   begin
     select t.id into l_request_id_person_fo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=1 and kf=p_kf) and
           data_type_id=1 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_person_fo(), params, 'NBU_PERSON_FO', KF, id);
      bars.nbu_601_migrate.set_data_request_state(l_request_id_person_fo,9,'Дані успішно передані до ЦА');
      commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_person_fo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
        select id into l_request_id_document_fo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=2 and kf=p_kf) and
           data_type_id=2 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_document_fo(), params, 'NBU_DOCUMENT_FO', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_document_fo,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_document_fo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    Begin
     select id into l_request_id_address_fo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=3 and kf=p_kf) and
          data_type_id=3 and kf=p_kf;
     bars.nbu_601_migrate.set_data_request_state(l_request_id_address_fo,9,'Дані успішно передані до ЦА');
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_address_fo(), params, 'NBU_ADDRESS_FO', KF, id);
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_address_fo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
     select id into l_request_id_person_uo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=7 and kf=p_kf) and
       data_type_id=7 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_person_uo(), params, 'NBU_PERSON_UO', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_person_uo,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_person_uo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
      select id into l_request_id_finperformance_uo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=8 and kf=p_kf) and
           data_type_id=8 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_finperformance_uo(), params, 'NBU_FINPERFORMANCE_UO', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_finperformance_uo,9,'Дані успішно передані до ЦА');
      commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_finperformance_uo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
      select id into l_request_id_fingr_uo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=10 and kf=p_kf) and
           data_type_id=10 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_finperformancegr_uo(), params, 'NBU_FINPERFORMANCEGR_UO', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_fingr_uo,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_fingr_uo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
      select id into l_request_id_partners_uo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=11 and kf=p_kf) and
           data_type_id=11 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_partners_uo(), params, 'NBU_PARTNERS_UO', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_partners_uo,9,'Дані успішно передані до ЦА');
      commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_partners_uo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
      select id into l_request_id_ownerpp from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=13 and kf=p_kf) and
           data_type_id=13 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_ownerpp_uo(), params, 'NBU_OWNERPP_UO', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_ownerpp,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_ownerpp,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
      select id into l_request_id_ownerjur from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=14 and kf=p_kf) and
           data_type_id=14 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_ownerjur_uo(), params, 'NBU_OWNERJUR_UO', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_ownerjur,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_ownerjur,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

     begin
      select id into l_request_id_pledge_dep  from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=15 and kf=p_kf) and
           data_type_id=15 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_pledge_dep(), params, 'NBU_PLEDGE_DEP', KF, id);

       bars.nbu_601_migrate.set_data_request_state(l_request_id_pledge_dep,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_pledge_dep,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
      select id into l_request_id_credit  from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=16 and kf=p_kf) and
           data_type_id=16 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_credit(), params, 'NBU_CREDIT', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_credit,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_credit,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
     select id into l_request_id_credit_pledge  from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=17 and kf=p_kf) and
          data_type_id=17 and kf=p_kf;
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_credit_pledge(), params, 'NBU_CREDIT_PLEDGE', KF, id);
       bars.nbu_601_migrate.set_data_request_state(l_request_id_credit_pledge,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_credit_pledge,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end;

    begin
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_groupur_uo(), params, 'NBU_GROUPUR_UO', KF, id);
     select id into l_request_id_groupur_uo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=9 and kf=p_kf) and
           data_type_id=9 and kf=p_kf;
       bars.nbu_601_migrate.set_data_request_state(l_request_id_groupur_uo,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_groupur_uo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end; 
    
    begin
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_finperformancepr_uo(), params, 'NBU_FINPERFORMANCEPR_UO', KF, id);
     select id into l_request_id_finpr_uo from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=12 and kf=p_kf) and
           data_type_id=12 and kf=p_kf;
       bars.nbu_601_migrate.set_data_request_state(l_request_id_finpr_uo,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_finpr_uo,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end; 
    
    begin
    BARSTRANS.TRANSP_UTL.send(NBU_601_FORMED_XML.get_xml_credit_tranche(), params, 'NBU_CREDIT_TRANCHE', KF, id);
     select id into l_request_id_cred_tranch from nbu_data_request_601 t where  t.report_instance_id=(select max(report_instance_id) from nbu_data_request_601 where data_type_id=18 and kf=p_kf) and
           data_type_id=18 and kf=p_kf;
       bars.nbu_601_migrate.set_data_request_state(l_request_id_cred_tranch,9,'Дані успішно передані до ЦА');
       commit;
     exception
       when others then
         bars.nbu_601_migrate.set_data_request_state(l_request_id_cred_tranch,10,sqlerrm || dbms_utility.format_error_backtrace());
     commit;
    end; 

 end;

procedure run_formated_xml
  is
 current_kf varchar2(50):=sys_context('bars_context','user_mfo');
 current_id number:=user_id ();
 job_is_runing exception;
 pragma exception_init (job_is_runing,-27478);   
    
 begin
      dbms_scheduler.set_job_argument_value(job_name  =>'RUN_FORMATED_XML',
                                         argument_position =>1,
                                         argument_value => current_kf );

      dbms_scheduler.set_job_argument_value(job_name  =>'RUN_FORMATED_XML',
                                         argument_position =>2,
                                         argument_value => current_id );
   begin
   dbms_scheduler.run_job(job_name =>'RUN_FORMATED_XML', use_current_session => false);
   exception when job_is_runing 
             then null;
   end;          
end;

end;
/
grant execute on nbu_601_request_data_ru to barstrans;
grant execute on nbu_601_request_data_ru to bars_access_defrole;