prompt package FM_PUBLIC_UTL
create or replace package fm_public_utl
is
/*
created by lypskykh 25-OCT-2018
������, ������ �� ������� ��������� ��������
*/

g_version constant varchar2(150) := 'version 1.3  08.02.2019';

--
-- ��������� ������ ������
--
function get_version return varchar2;

--
-- �������� ������� �� ������������ ������ ��� �� ��� / ��������
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
--
function get_public_code (p_name   in varchar2,
                          p_mode   in int default 0) return number;

--
-- �������� ������� �� ������������ ������ ��� �� ���
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
--
function get_public_code (p_rnk    in number,
                          p_mode   in int default 0) return number;

--
-- ����� ���� � ����������� ��� (pep.org.ua), 0 - ���������� ����������
--
function get_pep_code (p_name in varchar2)
return number;
                          
--
-- ����� ����� � ������������ ��� (��� / pep.org.ua) 
-- ������ ������: nvl([��� ���], '-') / nvl([��� PEP], '-'), ���� p_null_flag = 1 - �� ������ ������ � ������ ���������� ����������
--
function get_composite_public_code (p_name in varchar2, p_null_flag in integer default 1)
return varchar2;

--
-- �������� �������� ����� �� ������������ ������ ��������� ��������
-- ��������� ���������� ��������-��� - finmon_public_customers
--
procedure check_public;

--
-- �������� ����� � ���������� ��������� (����� ������, pep.org.ua)
--
procedure import_pep_file (p_clob      in clob,
                           p_imported out number);

--
-- �������� ����� � ���������� ��������� (������ ������, ��������� - ��� "���")
--
procedure import_public_file (p_clob      in clob,
                              p_imported out number);

end fm_public_utl;
/
create or replace package body fm_public_utl
is

g_trace constant varchar2(150) := 'FM_PUBLIC_UTL';

--
-- ��������� ������ ������
--
function get_version return varchar2
    is
begin
    return g_version;
end get_version;

--
-- �������� ���������� ���� ��� ������ ����. ��� (�������� ������ �������� + ������� �������)
--
function makePEPSearchName(v varchar2)
return varchar2
is
begin
    return upper(regexp_replace(v, '[^([:alpha:]|[:digit:])]', '')); 
end makePEPSearchName;

--
-- �������� ������� �� ������������ ������ ��� �� ��� / ��������
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
--
function get_public_code (p_name   in varchar2,
                          p_mode   in int default 0)
return number
is
l_public   int;
l_name     varchar2(250);
begin
    l_name := replace(replace(replace(replace(replace(replace(replace(replace(p_name,'/',''),'\',''),'*',''),'~',''),'!',''),'&',''),'?',''),' ','');
    if  l_name is null then
        return 0;
    end if;

    begin
        select /*+ index(I_FMN_PUBLIC_RELS) */
               case when p_mode = 0 then 1
                    when p_mode = 1 then id
               end
        into l_public
        from finmon_public_rels
        where fullname = upper(l_name)
          and (ADD_MONTHS(termin,36) >= bankdate or termin is null);
    exception
        when no_data_found then l_public := 0;
        when too_many_rows then l_public := 1;
    end;
    return l_public;
end get_public_code;

--
-- �������� ������� �� ������������ ������ ��� �� ���
-- ���������� � ������ ���������� ����� � ������, ���� p_mode = 1; 1 - ���� p_mode = 0; 0 - ���� �� �������
--
function get_public_code (p_rnk    in number,
                          p_mode   in int default 0)
return number
is
l_name customer.nmk%type;
begin
    if p_rnk is not null then
        begin
            select nmk
            into l_name
            from customer
            where rnk = p_rnk;
        exception
            when no_data_found then return 0;
        end;
        return get_public_code(l_name, p_mode);
    else
        return 0;
    end if;
end get_public_code;

--
-- ����� ���� � ����������� ��� (pep.org.ua), 0 - ���������� ����������
--
function get_pep_code (p_name in varchar2)
return number
is
l_res_num number;
l_searchName varchar2(256) := makePEPSearchName(p_name);
begin
    select pep_id 
    into l_res_num
    from
        (select id as pep_id, search_name from finmon_pep_dict -- ����� ������
         union all
         select pep_id, search_name from finmon_pep_names_dict -- ��������� �����
         union all
         select pep_id, search_name from finmon_pep_rels_dict) -- ��������� ����
    where search_name = l_searchName
    and rownum = 1; -- ��������������� �� ������ ����������
    return l_res_num;
exception
    when no_data_found then return 0;
end get_pep_code;

--
-- ����� ����� � ������������ ��� (��� / pep.org.ua)
-- ������ ������: nvl([��� ���], '-') / nvl([��� PEP], '-'), ���� p_null_flag = 1 - �� ������ ������ � ������ ���������� ����������
--
function get_composite_public_code (p_name in varchar2, p_null_flag in integer default 1)
return varchar2
is
l_kis_pep pls_integer;
l_pep_org pls_integer;
begin
    l_kis_pep := get_public_code(p_name, 1);
    l_pep_org := get_pep_code(p_name);
    if l_kis_pep = 0 and l_pep_org = 0 and p_null_flag = 1 then 
        return '';
    else
        return case when l_kis_pep = 0 then '-' else to_char(l_kis_pep) end || '/' || case when l_pep_org = 0 then '-' else to_char(l_pep_org) end;
    end if;
end get_composite_public_code;

--
-- �������� �������� ����� �� ������������ ������ ��������� ��������
-- ��������� ���������� ��������-��� - finmon_public_customers
--
procedure check_public
is
l_trace constant varchar2(24) := 'CHECK_PUBLIC';
 /*
 RNK,
 ϲ�/����� �볺���,
 � ����� � ������� �������� ���,
 ����� ������,
 ������ ������, � ������� ������� ������ ���������� ���������� ���� ������������ ������� ������ � ������ (Id) 2, 3, 62-65.
 (+) RNK ���'����� �����,
 (+) ϲ�/����� ���'����� �����,
 (+) � ���'��. ����� � ������� �������� ���,
 (+) ��������
 ���� �����;

 � ��� ����������� ���� ���� �볺���
   1) ��� �볺��� � �������� �������� ��� - ���� "RNK ���'����� �����", "ϲ�/����� ���'����� �����", "� ���'��. ����� � ������� �������� ���" ����, ��������="�볺��"
   2) ��� ���'����� ����� (�볺��� �����) �� ���� �����, ������������ � ������ �볺��� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������, ���� "� ����� � ������� �������� ���" �����, ���� ���'����� ����� - ������� ��� �� ���� ������� ���, ��������="���'����� ����� (�볺�� �����)"
   3) ��� ���'����� ����� (�� �볺�� �����) �� ���� ����� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������, ���� "� ����� � ������� �������� ���" �����, ���� ���'����� ����� - ������� ��� �� ���� ������� ���, ��������="���'����� ����� (�� �볺�� �����)"
 */

begin
    bars_audit.info(g_trace||'.'||l_trace||': �����. ������� ���������� ������');
    delete from FINMON_PUBLIC_CUSTOMERS;
    commit; -- ������� ������ � ����� ������

    bars_audit.info(g_trace||'.'||l_trace||': �������� ���������� ������� ����������.');

    INSERT INTO FINMON_PUBLIC_CUSTOMERS (ID, RNK, NMK, CRISK, CUST_RISK, CHECK_DATE, RNK_REEL, NMK_REEL, NUM_REEL, COMMENTS, PEP_CODE)
    /* 1) ��� �볺��� � �������� �������� ���
            ����    "RNK ���'����� �����",
                    "ϲ�/����� ���'����� �����",
                    "� ���'��. ����� � ������� �������� ���" ����,
                    ��������="�볺��"
    */
    SELECT get_public_code(nmk, 1),
           c.RNK,
           c.NMK,
           NVL (CW.VALUE, '�������'),
           CONCATSTR (CR.RISK_ID),
           TRUNC (SYSDATE),
           null,
           '',
           null,
           '�볺��',
           get_pep_code(nmk)
    FROM CUSTOMER C,
         (SELECT RNK, RISK_ID
            FROM CUSTOMER_RISK
           WHERE TRUNC (SYSDATE) BETWEEN DAT_BEGIN AND NVL(DAT_END, trunc(sysdate))
             AND RISK_ID IN (2,3,62,63,64,65) order by RISK_ID) CR,
         (SELECT RNK, VALUE
            FROM CUSTOMERW
           WHERE TAG = 'RIZIK') CW
    WHERE (get_pep_code(nmk) != 0 or get_public_code(nmk) != 0)
      AND DATE_OFF IS NULL
      AND CR.RNK(+) = C.RNK
      AND CW.RNK(+) = C.RNK
    GROUP BY C.RNK, C.NMK, CW.VALUE
      /* 2) ��� ���'����� ����� (�볺��� �����) �� ���� �����,
            ������������ � ������ �볺��� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������,
            ����    "� ����� � ������� �������� ���" �����,
                    ���� ���'����� ����� - ������� ��� �� ���� ������� ���,
                    ��������="���'����� ����� (�볺�� �����)"
         3) ��� ���'����� ����� (�� �볺�� �����) �� ���� ����� - ���� ����� �� �볺��� - ��� �볺��� ���'������� � �������� ������,
            ����    "� ����� � ������� �������� ���" �����,
                    ���� ���'����� ����� - ������� ��� �� ���� ������� ���,
                    ��������="���'����� ����� (�� �볺�� �����)"
      */
    UNION ALL
    SELECT  NULL,
         c.RNK,
         c.nmk,
         NVL (CW.VALUE, '�������'),
         concatstr (cr.risk_id),
         trunc (sysdate),
         crel.rel_rnk,
         coalesce(c2.nmk, ce.name),
         get_public_code(coalesce(c2.nmk, ce.name), 1),
         case   when rel_intext = 1 then '���''����� ����� (�볺�� �����)'
                when rel_intext = 0 then '���''����� ����� (�� �볺�� �����)'
         end,
         get_pep_code(coalesce(c2.nmk, ce.name))
    FROM CUSTOMER c,
         CUSTOMER_REL crel,
         CUSTOMER_EXTERN ce,
         (SELECT RNK, risk_id
            FROM CUSTOMER_RISK
           WHERE trunc (sysdate) between dat_begin and nvl(dat_end, trunc(sysdate))
             AND risk_id IN (2,3,62,63,64,65) order by risk_id) cr,
         (SELECT RNK, VALUE
            FROM CUSTOMERW
           WHERE TAG = 'RIZIK') cw,
         CUSTOMER C2
    WHERE    (get_pep_code(coalesce(c2.nmk, ce.name)) != 0 or get_public_code(coalesce(c2.nmk, ce.name)) != 0)
         AND CREL.REL_RNK = CE.ID(+)
         AND C.RNK = CREL.RNK
         AND C.DATE_OFF IS NULL
         AND CR.RNK(+) = CREL.RNK
         AND CW.RNK(+) = CREL.RNK
         AND C2.RNK(+) = CREL.REL_RNK
    GROUP BY C.RNK, C.NMK, CW.VALUE, CREL.REL_RNK,CREL.REL_INTEXT,CE.NAME,C2.NMK;
bars_audit.info('finmon_check_public - finished');
exception
    when others then
        bars_audit.error(g_trace||'.'||l_trace||': ����������� � �������: '||sqlerrm||' '||dbms_utility.format_error_backtrace);
        rollback; -- ������������ � ������� ������
        raise;
end check_public;

--
-- �������� ����� � ���������� ��������� (����� ������, pep.org.ua)
--
procedure import_pep_file (p_clob      in clob,
                           p_imported out number)
    is
l_trace          constant varchar2(150) := g_trace || '.import_pep_file: ';
l_parser         dbms_xmlparser.parser;
l_doc            dbms_xmldom.domdocument;
l_itemlist       dbms_xmldom.DOMNodeList;
l_item           dbms_xmldom.DOMNode;
l_relslist       dbms_xmldom.DOMNodeList;
l_relsNode       dbms_xmldom.DOMNode;
l_rel            dbms_xmldom.DOMNode;
l_names          varchar2(32000);
l_names_tab      string_list;
type t_finmon_pep       is table of FINMON_PEP_DICT%rowtype;
type t_finmon_pep_names is table of FINMON_PEP_NAMES_DICT%rowtype;
type t_finmon_pep_rels  is table of FINMON_PEP_RELS_DICT%rowtype;
finmon_pep       t_finmon_pep       := t_finmon_pep();
finmon_pep_names t_finmon_pep_names := t_finmon_pep_names();
finmon_pep_rels  t_finmon_pep_rels  := t_finmon_pep_rels();
l_tmp            varchar2(4000);
begin
    bars_audit.info(l_trace||'�����');
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);
    l_itemlist := dbms_xmldom.getelementsbytagname(l_doc, 'item');
    
    if dbms_xmldom.getlength(l_itemlist) = 0 then
        /* ���� ������ / �� ��� ��������� / �� �������� ���������  */
        raise_application_error(-20000, '� ����� �� ������� ������������ item!');
    end if;
    
    for i in 0 .. dbms_xmldom.getlength(l_itemlist)-1
    loop
        l_item := dbms_xmldom.item(l_itemlist, i);
        finmon_pep.extend;
        
        -- ������ ���������� ����
        finmon_pep(i+1).id := i+1; -- ������������ ��, �������� �������� ����� �� ��������
        dbms_xslprocessor.valueof(l_item, 'first_name/text()', l_tmp);
        finmon_pep(i+1).first_name := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'last_name/text()', l_tmp);
        finmon_pep(i+1).last_name := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'full_name/text()', l_tmp);
        finmon_pep(i+1).full_name := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'first_name_en/text()', l_tmp);
        finmon_pep(i+1).first_name_en := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'last_name_en/text()', l_tmp);
        finmon_pep(i+1).last_name_en := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'full_name_en/text()', l_tmp);
        finmon_pep(i+1).full_name_en := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'is_pep/text()', l_tmp);
        finmon_pep(i+1).is_pep := to_number(l_tmp);
        dbms_xslprocessor.valueof(l_item, 'type_of_official/text()', l_tmp);
        finmon_pep(i+1).type_of_official := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'type_of_official_en/text()', l_tmp);
        finmon_pep(i+1).type_of_official_en := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'patronymic/text()', l_tmp);
        finmon_pep(i+1).patronymic := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'patronymic_en/text()', l_tmp);
        finmon_pep(i+1).patronymic_en := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'date_of_birth/text()', l_tmp);
        finmon_pep(i+1).date_of_birth := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'died/text()', l_tmp);
        finmon_pep(i+1).died := to_number(l_tmp);
        dbms_xslprocessor.valueof(l_item, 'last_job_title/text()', l_tmp);
        finmon_pep(i+1).last_job_title := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'last_workplace/text()', l_tmp);
        finmon_pep(i+1).last_workplace := l_tmp;
        dbms_xslprocessor.valueof(l_item, 'url/text()', l_tmp);
        finmon_pep(i+1).url := l_tmp;
        finmon_pep(i+1).load_date := trunc(sysdate);
        finmon_pep(i+1).search_name := makePEPSearchName(finmon_pep(i+1).last_name || ' ' || finmon_pep(i+1).first_name || ' ' || finmon_pep(i+1).patronymic); -- ��������� ���� ��� ������
        /* ��������� ����� */
        dbms_xslprocessor.valueof(l_item, 'names/text()', l_names);
        l_names_tab := tools.string_to_words(p_string           => l_names,
                                             p_trim_words       => 'Y',
                                             p_splitting_symbol => chr(10));
        for n in l_names_tab.first..l_names_tab.last
        loop
            finmon_pep_names.extend;
            finmon_pep_names(finmon_pep_names.last).pep_id := finmon_pep(i+1).id;
            finmon_pep_names(finmon_pep_names.last).search_name := makePEPSearchName(l_names_tab(n)); -- ��������� ���� ��� ������
        end loop;
        /* ������ ��������� ��� */
        l_relsNode := dbms_xslprocessor.selectSingleNode(l_item, 'related_persons');
        l_relslist := dbms_xmldom.getChildNodes(l_relsNode);
        for j in 0..dbms_xmldom.getlength(l_relslist) - 1
        loop
            l_rel := dbms_xmldom.item(l_relslist, j);
            finmon_pep_rels.extend;
            finmon_pep_rels(finmon_pep_rels.last).pep_id := finmon_pep(i+1).id;
            dbms_xslprocessor.valueof(l_rel, 'relationship_type/text()', l_tmp);
            finmon_pep_rels(finmon_pep_rels.last).relationship_type := l_tmp;
            dbms_xslprocessor.valueof(l_rel, 'relationship_type_en/text()', l_tmp);
            finmon_pep_rels(finmon_pep_rels.last).relationship_type_en := l_tmp;
            dbms_xslprocessor.valueof(l_rel, 'person_uk/text()', l_tmp);
            finmon_pep_rels(finmon_pep_rels.last).person_uk := l_tmp;
            finmon_pep_rels(finmon_pep_rels.last).search_name := makePEPSearchName(l_tmp); -- ��������� ���� ��� ������
            dbms_xslprocessor.valueof(l_rel, 'person_en/text()', l_tmp);
            finmon_pep_rels(finmon_pep_rels.last).person_en := l_tmp;
        end loop;
    end loop;
    bars_audit.info(l_trace||'XML ��������, �������: '||finmon_pep.last);
    /* ������� ������ ������ */
    delete from finmon_pep_names_dict;
    delete from finmon_pep_rels_dict;
    delete from finmon_pep_dict;
    /* ���������� ����� */
    forall i in finmon_pep.first..finmon_pep.last
        insert into finmon_pep_dict values finmon_pep(i);
    for i in finmon_pep_names.first..finmon_pep_names.last
    loop
        begin
            insert into finmon_pep_names_dict values finmon_pep_names(i);
        exception
            when dup_val_on_index then null;
            when others then
                if sqlcode = -1400 then null; else raise; end if;
        end;
    end loop;
    for i in finmon_pep_rels.first..finmon_pep_rels.last
    loop
        begin
            insert into finmon_pep_rels_dict values finmon_pep_rels(i);
        exception
            when dup_val_on_index then null;
            when others then
                if sqlcode = -1400 then null; else raise; end if;
        end;
    end loop;
    p_imported := finmon_pep.last;
    bars_audit.info(l_trace||'���������� ������� ��������');
exception
    when others then
        bars_audit.fatal(l_trace||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end import_pep_file;

--
-- �������� ����� � ���������� ��������� (������ ������, ��������� - ��� "���")
--
procedure import_public_file (p_clob      in clob,
                              p_imported out number)
is
l_trace        constant varchar2(150) := g_trace || '.import_public_file: ';
l_parser       dbms_xmlparser.parser;
l_doc          dbms_xmldom.domdocument;
l_analyticlist dbms_xmldom.DOMNodeList;
l_analytic     dbms_xmldom.DOMNode;
type t_finmon_public_rels is table of finmon_public_rels%rowtype;
finmon_row     t_finmon_public_rels := t_finmon_public_rels();
l_tmp          varchar2(265);
l_bigtmp       clob;
begin
    bars_audit.info(l_trace||'�����');
    l_parser := dbms_xmlparser.newparser;
    dbms_xmlparser.parseclob(l_parser, p_clob);
    l_doc := dbms_xmlparser.getdocument(l_parser);
    l_analyticlist := dbms_xmldom.getelementsbytagname(l_doc, 'person');
    if dbms_xmldom.getlength(l_analyticlist) = 0 then
        /* ���� ������ / �� ��� ��������� / �� �������� ���������  */
        raise_application_error(-20000, '� ����� �� ������� ������������ person!');
    end if;
    for i in 0 .. dbms_xmldom.getlength(l_analyticlist)-1
    loop
        l_analytic := dbms_xmldom.item(l_analyticlist, i);
        finmon_row.extend;
        /*
        <id>
        <name>
        <termin>
        <birth>
        <bio>
        */
        dbms_xslprocessor.valueof(l_analytic, 'id/text()', l_tmp);
        finmon_row(i+1).id := to_number(trim(l_tmp));

        dbms_xslprocessor.valueof(l_analytic, 'name/text()', l_tmp);
        finmon_row(i+1).name := trim(l_tmp);

        dbms_xslprocessor.valueof(l_analytic, 'termin/text()', l_tmp);
        finmon_row(i+1).termin := to_date(trim(l_tmp),'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_analytic, 'birth/text()', l_tmp);
        finmon_row(i+1).birth := to_date(trim(l_tmp),'dd.mm.yyyy');

        dbms_xslprocessor.valueof(l_analytic, 'bio/text()', l_bigtmp);
        finmon_row(i+1).bio := trim(l_bigtmp);

        finmon_row(i+1).PRIZV := substr(finmon_row(i+1).name, 1, instr(finmon_row(i+1).name,' ')-1);
        finmon_row(i+1).FNAME := trim(substr(finmon_row(i+1).name, length(finmon_row(i+1).PRIZV)+1, length(finmon_row(i+1).name)));
        finmon_row(i+1).TERMINMOD := trunc(sysdate);
        finmon_row(i+1).FULLNAME :=  upper(replace(replace(replace(replace(replace(replace(replace(replace(finmon_row(i+1).name,'/',''),'\',''),'*',''),'~',''),'!',''),'&',''),'?',''),' ',''));
    end loop;
    bars_audit.info(l_trace||'XML ������� ��������');
    execute immediate 'truncate table finmon_public_rels';
    bars_audit.info(l_trace||'���������� ������ �������');
    forall j in finmon_row.first .. finmon_row.last
        insert into finmon_public_rels values finmon_row(j);
    bars_audit.info(l_trace||'���������� ������� ��������');
    dbms_xmlparser.freeparser(l_parser);
    DBMS_XMLDOM.freeDocument(l_doc);
    p_imported := finmon_row.last;
exception
    when others then
        bars_audit.fatal(l_trace||dbms_utility.format_error_stack||chr(10)||dbms_utility.format_error_backtrace);
        raise;
end import_public_file;

end fm_public_utl;
/
Show errors;
grant execute on bars.fm_public_utl to bars_access_defrole;