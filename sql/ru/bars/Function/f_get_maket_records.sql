
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_maket_records.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_MAKET_RECORDS return t_maket_table
  /*
   27/10/2011  ���� �.
   ����������� ��������� ������ � ����� ������ � ����������� ��� XML2(xml2_br3).
   ���� ���-�� �� ������� � ����������� ������ exception � �� 000000 �� ������!!!
  */


  pipelined is
  g_numb_mask varchar2(100) := '9999999999999999999999999D99999999';
  g_nls_mask  varchar2(100) := 'NLS_NUMERIC_CHARACTERS = ''.,''';

  l_clob   clob;
  l_parser dbms_xmlparser.Parser := dbms_xmlparser.newParser;
  l_doc    dbms_xmldom.DOMDocument;

  l_children dbms_xmldom.DOMNodeList;
  l_child    dbms_xmldom.DOMNode;
  l_length   number;

  l_maket_rec t_maket_rec := t_maket_rec(null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null,
                                         null);

  -- ��������� ������ ��������� ���� �� ����� ����
  function getSubNodeText(node       in dbms_xmldom.DOMNode, -- ������� ���
                          subNodeTag in varchar2 -- ��� ������������ ����
                          ) return varchar2 is
  begin
    return dbms_xmldom.getNodeValue(dbms_xmldom.getFirstChild(dbms_xslprocessor.selectSingleNode(node,
                                                                                                 subNodeTag)));
  end;
begin
  -- ���������� clob ��������
  bars_lob.import_clob(l_clob);

  -- ������
  dbms_xmlparser.parseClob(l_parser, l_clob);
  l_doc := dbms_xmlparser.getDocument(l_parser);

  -- ���������� ���������� ��� ���� vau_rpt_ru
  l_children := dbms_xmldom.getElementsByTagName(l_doc, 'vau_rpt_ru');
  l_length   := dbms_xmldom.getLength(l_children);

  for i in 0 .. l_length - 1 loop
    l_child := dbms_xmldom.item(l_children, i);

    -- ��������� ��� ���������, ��������� ���������������
    l_maket_rec.cps := getSubNodeText(l_child, 'cps');
    -- ��������������� ���� cps
    case l_maket_rec.cps
      when 'M' then
        l_maket_rec.cps_decoded := 'MASTER';
      when 'V' then
        l_maket_rec.cps_decoded := 'VISA';
      else
        l_maket_rec.cps_decoded := l_maket_rec.cps;
    end case;

    l_maket_rec.term_id := getSubNodeText(l_child, 'term_id');
    l_maket_rec.br3     := getSubNodeText(l_child, 'br3');


  /*
    -- ��������������� ��� ���������
    -- ������ �������� �������� ���������� : OBU, Vinnitske, OV02/041-1ATM
    l_maket_rec.br3_decoded := trim(substr(l_maket_rec.br3,
                                           instr(l_maket_rec.br3,
                                                 ',',
                                                 instr(l_maket_rec.br3, ',') + 1) + 1));
    -- ������ �������� �������� ���������� : OV02/041-1ATM
    l_maket_rec.br3_decoded := replace(l_maket_rec.br3_decoded, '/', '-');
    -- ������ �������� �������� ���������� : OV02-041-1ATM
    l_maket_rec.br3_decoded := substr(l_maket_rec.br3_decoded,
                                      instr(l_maket_rec.br3_decoded, '-') + 1,
                                      instr(l_maket_rec.br3_decoded,
                                            '-',
                                            instr(l_maket_rec.br3_decoded,
                                                  '-') + 1) -
                                      instr(l_maket_rec.br3_decoded, '-') - 1);
    -- ������ �������� �������� ���������� : 041*/
   	  begin
		 select 	substr(b.branch,1,15)
			into l_maket_rec.br3_decoded
		 from branch b, xml2_br3 x
	  where b.branch=x.branch
		 and x.namex=l_maket_rec.br3
         and rownum = 1;
	 exception when no_data_found
	   then
	   raise_application_error(-20100,'³������� -'||l_maket_rec.br3
	                                                ||' �� ������� � �������� "������ �������� ��� ��� ������� XML2"(xml2_br3)');

	   --l_maket_rec.br3_decoded :='/'||f_ourmfo||'/000000/';
	   end;
	 -- ������ �������� �������� ���������� : /303398/000036/000041/

    l_maket_rec.tran_amt  := to_number(getSubNodeText(l_child, 'tran_amt'),
                                       g_numb_mask,
                                       g_nls_mask);
    l_maket_rec.tran_cnt  := to_number(getSubNodeText(l_child, 'tran_cnt'),
                                       g_numb_mask,
                                       g_nls_mask);
    l_maket_rec.tot_amt   := to_number(getSubNodeText(l_child, 'tot_amt'),
                                       g_numb_mask,
                                       g_nls_mask);
    l_maket_rec.fee_amt_i := to_number(getSubNodeText(l_child, 'fee_amt_i'),
                                       g_numb_mask,
                                       g_nls_mask);
    l_maket_rec.fee_amt_a := to_number(getSubNodeText(l_child, 'fee_amt_a'),
                                       g_numb_mask,
                                       g_nls_mask);
    l_maket_rec.fee_amt   := to_number(getSubNodeText(l_child, 'fee_amt'),
                                       g_numb_mask,
                                       g_nls_mask);
    pipe row(l_maket_rec);
  end loop;
  return;
end f_get_maket_records;
/
 show err;
 
PROMPT *** Create  grants  F_GET_MAKET_RECORDS ***
grant EXECUTE                                                                on F_GET_MAKET_RECORDS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_MAKET_RECORDS to PYOD001;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_maket_records.sql =========**
 PROMPT ===================================================================================== 
 