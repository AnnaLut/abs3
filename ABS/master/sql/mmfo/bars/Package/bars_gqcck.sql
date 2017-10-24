
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_gqcck.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_GQCCK is

  ----------------------------------------------------------------------
  -- Module : CCK
  -- Author : ����
  -- Date   : 28.01.2007
  ----------------------------------------------------------------------
  -- ����� �������� ��������� �����. �������� ��������� ������
  ----------------------------------------------------------------------

  ----------------------------------------------------------------------
  -- Comments
  ----------------------------------------------------------------------
  -- �� ���������� �� ��������� ������ ��� �������!!!
  -- ��������� ���� $/BARS/SQL/ETALON/ERRORS/CKS_ERR.sql - �������� ������
  ----------------------------------------------------------------------

	----------------------------------------------------------------------
	-- History
	----------------------------------------------------------------------
  -- 07.02.2007 ����     : ������� �������� bdate � create_doginfo_query
  --                       get_doginfo_centura, get_doginfo_web
	-- 02.02.2007 tvSukhov : ����������� ���� ������, �� �������� ���
	--                       ������� ��������� get_doginfo
	-- 28.01.2007 ����     : ������
	----------------------------------------------------------------------

	-- ��� ������������ ������
	type rec_cckdog is record (
								cc_id        cc_deal.cc_id%type,
								sos          cc_sos.sos%type,     -- ��������� �������
								dat          date,
								ns           number,
								ns1          number,
								nmk          customer.nmk%type,   -- ������������ �������
								okpo         customer.okpo%type,  -- OKPO �������
								adres        customer.adr%type,   -- ����c        �������
								kv           cc_add.kv%type,      -- ��� ������   ��
								lcv          tabval.lcv%type,     -- ISO ������   ��
								namev        tabval.name%type,    -- �����a       ��
								unit         tabval.unit%type,    -- ���.������   ��
								gender       tabval.gender%type,  -- ��� ������   ��
								nss          number,              -- c���� �c�.�����
								dat4         date,                -- ���� ���������� ��
								nss1         number,
								dat_sn       date,                -- �� ����� ���� ��� %
								nsn          number,              -- c���� ��� %
								nsn1         number,
								dat_sk       date,                -- �� ����� ���� ��� ���
								nsk          number,              -- c���� ��� ����c������ ����cc��
								nsk1         number,
								kv_kom       int,                 -- ��� ����cc��
								dat_sp       date,                -- �� ����� ���� ��� ����
								nsp          number,              -- c���� ��� ����c������ ����
								sn8_nls      accounts.nls%type,   --
								sd8_nls      accounts.nls%type,   -- c���� ����c����� ����
								mfok         accounts.kf%type,    --
								nlsk         accounts.nls%type,   -- c��� �������
								nlsSS        accounts.nls%type    -- ������� c���
								);

  -------------------------------------------------------
  -- ������� ���������� ������ � ������� ��������� ������
  --
  function header_version return varchar2;

  --------------------------------------------------
  -- ������� ���������� ������ � ������� ���� ������
  --
  function body_version return varchar2;

  --------------------------------------------
  -- ������� ������� �����c � ������� �����c��
  --
  -- ���������:
  --   p_cc_id: ������������� ��
  --   p_date: ���� ����� ��
  --   p_bdate: ���������� ���� �� ������� ����� ������
  --   p_query_id: ������������� c��������� �����c�
  --
  procedure create_doginfo_query(
    p_cc_id in cc_deal.cc_id%type,
    p_date in date,
    p_bdate in date,
    p_queryid out gq_query.query_id%type);

  -------------------------------------------------------
  -- ��������� ��������� �����c� �� ���������� ��������
  --
  -- ���������:
  --
  --  p_request          �����c
  --  p_status           ��������� ��������� �����c�
  --                              1 - �c����� ���������
  --                              2 - ��������� c �������
  --  p_response         ����� �� �����c
  --
  procedure process_doginfo_query(
      p_request         in   gq_query.request%type,
      p_status          out  gq_query.query_status%type,
      p_response        out  gq_query.response%type);


  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� �� ���������� ��������
  -- ������������� ��������� ��� CENTURA
  --
  -- ���������:
  -- CC_ID_ - �������������   ��
  -- DAT1_ - ���� �����      ��
  -- nRet_ - ��� ��������: =1 �� ������, =0 ������
  -- sRet_ - ����� ������ (?)  --
  -- ��������� ��� ������
  --
  procedure get_doginfo_centura(
								CC_ID_  IN  varchar2, -- �������������   ��
								DAT1_   IN  date    , -- ���� �����      ��
								nRet_   OUT int     , -- ��� ��������: =1 �� ������, =0 ������
								sRet_   OUT varchar2, -- ����� ������ (?)
								nS_     OUT number  ,
								nS1_    OUT number  ,
								NMK_    OUT varchar2, -- ������������ �������
								OKPO_   OUT varchar2, -- OKPO         �������
								ADRES_  OUT varchar2, -- �����        �������
								KV_     OUT int     , -- ��� ������   ��
								LCV_    OUT varchar2, -- ISO ������   ��
								NAMEV_  OUT varchar2, -- �����a       ��
								UNIT_   OUT varchar2, -- ���.������   ��
								GENDER_ OUT varchar2, -- ��� ������   ��
								nSS_    OUT number  , -- ����� ���.�����
								DAT4_   OUT date    , -- ���� ���������� ��
								nSS1_   OUT number  ,
								DAT_SN_ OUT date    , --\ �� ����� ���� ��� %
								nSN_    OUT number  , --/ ����� ��� %
								nSN1_   OUT number  ,
								DAT_SK_ OUT date    , --\ �� ����� ���� ��� ���
								nSK_    OUT number  , --/ ����� ��� ����������� ��������
								nSK1_   OUT number  ,
								KV_KOM_ OUT int     , --| ��� ��������
								DAT_SP_ OUT date    , -- �� ����� ���� ��� ����
								nSP_    OUT number  , -- ����� ��� ����������� ����
								SN8_NLS OUT varchar2, --\
								SD8_NLS OUT varchar2, --/ ����� ���������� ����
								MFOK_   OUT varchar2, --\
								NLSK_   out varchar2); --/ ���� �������

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� �� ���������� ��������
  -- ������������� ��������� ��� WEB
  --
  -- ���������:
  -- CC_ID_ - �������������   ��
  -- DAT1_ - ���� �����      ��
  -- oDATA - ��������� ������ ���������, ���
  --
  procedure get_doginfo_web(
								CC_ID_  IN  varchar2, 	-- �������������   ��
								DAT1_   IN  date, 		-- ���� �����      ��
								l_response out clob -- ��������� ������ ���������, XML
							);

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� �� ���������� ��������
  -- ������������� ��������� ��� CENTURA
  --
  -- ���������:
  -- QueryId - ����� � ������� ��������
  -- QueryStatus - ������ ������� (0-������, 1-��������� �������, 2-��������� � �������)
  -- ErrMsg - ����� ������
  -- CC_ID_ - �������������   ��
  -- DAT1_ - ���� �����      ��
  -- nRet_ - ��� ��������: =1 �� ������, =0 ������
  -- sRet_ - ����� ������ (?)  --
  -- ��������� ��� ������
  --
  procedure get_doginfo_query_centura(
							      p_queryid      in   gq_query.query_id%type,
								    p_querystatus  out  gq_query.query_status%type,
								    p_errmsg       out  varchar2,
								    p_cc_id        out cc_deal.cc_id%type,
								    p_date         out date,
								    p_nS           out number,
								    p_nS1          out number,
								    p_NMK          out customer.nmk%type,   -- ������������ �������
								    p_OKPO         out customer.okpo%type,  -- OKPO �������
								    p_ADRES        out customer.adr%type,   -- ����c        �������
								    p_KV           out cc_add.kv%type,      -- ��� ������   ��
								    p_LCV          out tabval.lcv%type,     -- ISO ������   ��
								    p_NAMEV        out tabval.name%type,    -- �����a       ��
								    p_UNIT         out tabval.unit%type,    -- ���.������   ��
								    p_GENDER       out tabval.gender%type,  -- ��� ������   ��
								    p_nSS          out number,              -- c���� �c�.�����
								    p_DAT4         out date,                -- ���� ���������� ��
								    p_nSS1         out number,
								    p_DAT_SN       out date,                -- �� ����� ���� ��� %
								    p_nSN          out number,              -- c���� ��� %
								    p_nSN1         out number,
								    p_DAT_SK       out date,                -- �� ����� ���� ��� ���
								    p_nSK          out number,              -- c���� ��� ����c������ ����cc��
								    p_nSK1         out number,
								    p_KV_KOM       out int,                 -- ��� ����cc��
								    p_DAT_SP       out date,                -- �� ����� ���� ��� ����
								    p_nSP          out number,              -- c���� ��� ����c������ ����
								    p_SN8_NLS      out accounts.nls%type,   --
								    p_SD8_NlS      out accounts.nls%type,   -- c���� ����c����� ����
								    p_MFOK         out accounts.kf%type,    --
								    p_NLSK         out accounts.nls%type); --/ ���� �������

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� �� ���������� ��������
  -- ������������� ��������� ��� WEB
  --
  -- ���������:
  -- QueryId - ����� � ������� ��������
  -- QueryStatus - ������ ������� (0-������, 1-��������� �������, 2-��������� � �������)
  -- ErrMsg - ����� ������
  -- oDATA - ��������� ������ ���������, ���
  --
  procedure get_doginfo_query_web(
								    p_queryid      in   gq_query.query_id%type,
								    p_querystatus  out  gq_query.query_status%type,
								    p_errmsg       out  varchar2,
    								p_response     out  clob
								 );

end bars_gqcck; 
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_GQCCK is

  ------------
  -- constants
  --
  g_bodyVersion   constant varchar2(64)  := 'version 1.06 07.02.2007';
  g_headerVersion constant varchar2(64)  := 'version 1.06 07.02.2007';
  g_bodyDefs      constant varchar2(512) := '';
  g_headerDefs    constant varchar2(512) := '';
  XML_HEADER      constant varchar2(100) := '<?xml version="1.0" encoding="windows-1251"?>';
  CRLF            constant varchar2(2)   := chr(13) || chr(10);

  -------------------------------------------------------
  -- ������� ���������� c����� c ���c��� ��������� ������
  --
  function header_version return varchar2
  is
  begin
      return 'package header BARS_GQCCK ' || g_headerVersion || chr(10) ||
             'package header definition(s):' || chr(10) || g_headerDefs;
  end header_version;

  --------------------------------------------------
  -- ������� ���������� c����� c ���c��� ���� ������
  --
  function body_version return varchar2
  is
  begin
      return 'package body BARS_GQCCK ' || g_bodyVersion || chr(10) ||
             'package body definition(s):' || chr(10) || g_bodyDefs;
  end body_version;

  -----------------------------------------------
  -- ������� ������c�� �������� �������� �� XPath
  --
  function extract(p_xml in xmltype, p_xpath in varchar2, p_default in varchar2) return varchar2 is
  begin
    return p_xml.extract(p_xpath).getStringVal();
  exception when others then
    if sqlcode = -30625 then
      return p_default;
    else
      raise;
    end if;
  end extract;


  -----------------------------------------------
  -- ������� ������c�� �������� clob �� XML
  --
  function getStringVal(p_xml in xmltype, p_default in clob) return clob is
  begin
    return p_xml.getStringVal();
  exception when others then
    if sqlcode = -30625 then
      return to_clob(translate(p_default using CHAR_CS));
    else
      raise;
    end if;
  end getStringVal;

  --------------------------------------------
  -- ������� c������ �����c � ������� �����c��
  --
  -- ���������:
  --   p_cc_id: ������������� ��
  --   p_date: ���� ����� ��
  --   p_query_id: ������������� c��������� �����c�
  --
  procedure create_doginfo_query(
    p_cc_id in cc_deal.cc_id%type,
    p_date in date,
    p_bdate in date,
    p_queryid out gq_query.query_id%type)
  is
    l_request clob;
  begin
    bars_audit.trace('bars_gqcck: create_doginfo_query entry point');
    bars_audit.trace('bars_gqcck: create_doginfo_query par[0]=>%s', p_cc_id);
    bars_audit.trace('bars_gqcck: create_doginfo_query par[2]=>%s', p_date);

    -- ��������� �����c
    l_request := XML_HEADER || CRLF ||
    '<Query>'               || CRLF ||
    '   <CreditDogInfo>'    || CRLF ||
    '       <CcId>'         || p_cc_id || '</CcId>'  || CRLF ||
    '       <Date>'         || to_char(p_date,'dd.mm.yyyy') ||'</Date>' || CRLF ||
    '       <BDate>'        || to_char(p_bdate,'dd.mm.yyyy') ||'</BDate>' || CRLF ||
    '   </CreditDogInfo>'   || CRLF ||
    '</Query>';

    bars_gq.create_query(2, l_request, p_queryid);
    bars_audit.info('GQCCK: c���������� �������������� �����c c ��������������� ' || to_char(p_queryid));
    bars_audit.trace('bars_gqcck: create_doginfo_query end');
  end create_doginfo_query;

  -------------------------------------------------------
  -- ��������� ��������� ������ �� ���������� �������� (STA)
  --
  -- ���������:
  --
  -- CC_ID_ - �������������   ��
  -- DAT1_ - ���� �����      ��
  -- oData  - ������ - ��������� ������
  --
  procedure get_doginfo(  CC_ID_ IN varchar2 , -- �������������   ��
   						  DAT1_  IN date     , -- ���� �����      ��
                gl_bdate_1 in date,
   						  oData  OUT rec_cckdog -- ������ - ��������� ������
   						)
  IS
	-- ����������
	ND_   int;
	RNK_  int;
	ACC8_ int;
	nInt_ number;
	nLim_ number;
--	DAT_SN1_ date := gl.bdate - 1;
--	DAT_SK1_ date := gl.bdate - 1;

  begin

	oData.cc_id := CC_ID_;
	oData.dat := DAT1_;

	begin /* ����� �� */
    	select 	d.nd ,d.wdate,c.NMK  ,c.okpo   ,c.rnk  , c.ADR ,ad.KV ,
           		t.LCV,t.NAME ,t.UNIT ,t.GENDER ,a.acc  , a.kf, d.sos
    	into	ND_, oData.dat4, oData.nmk, oData.okpo, RNK_, oData.adres, oData.kv,
            	oData.lcv, oData.namev, oData.unit, oData.gender, ACC8_, oData.mfok, oData.sos
    	from 	cc_deal d, customer c, cc_add ad, tabval t, accounts a
    	where 	d.ND = ad.ND and ad.KV = t.KV and d.rnk = c.rnk
      		and a.nls like '8999_'||d.nd and a.kv = ad.kv
      		and d.cc_id = CC_ID_ and d.SDATE = DAT1_;
  	exception when NO_DATA_FOUND then
  		-- ������� �� ������.
  		bars_error.raise_error('CKS-10');
  	end;

    -- ������� ����
	begin
        select NLS
        into oData.nlsSS 
        from ACCOUNTS a, ND_ACC na
        where a.ACC = na.ACC 
                and a.TIP = 'SS ' 
                and na.ND = ND_
                and a.kv = oData.kv;
  	exception when NO_DATA_FOUND then null;
  		-- !!! ���� ����� � ���������� ������� (tvSukhov)
  	end;

	-- ���� �������
  	begin
    	select a.nls
    	into oData.nlsk
    	from nd_acc n, accounts a
    	where n.nd = ND_ and a.tip = 'SG ' and a.kv = oData.kv and n.acc = a.acc;
  	exception when NO_DATA_FOUND then null;
  	end;

	-- �� ����� ���� ��� % ?
  	begin
    	select max(i.acr_dat)
    	into oData.dat_sn
    	from accounts a, nd_acc n, int_accn i
    	where n.nd = ND_ and n.acc = a.acc and a.tip in ('SS ','SP ','SL ')
      		and i.id = 0 and a.acc = i.acc and i.acr_dat is not null;
  	exception when NO_DATA_FOUND then null;
  	end;

	-- �� ����� ���� ��� ��� ?
  	oData.nsk := 0;
  	begin
    	select acr_dat
    	into oData.dat_sk
    	from int_accn
    	where acc = ACC8_ and id = 2;

    	-- ��� � ����� ��� ����������� ��������
    	select min(a.kv), Nvl(-SUM(a.ostb+a.ostf),0)
    	into oData.kv_kom, oData.nsk
    	from accounts a, nd_acc n
    	where n.nd = ND_ and n.acc = a.acc and a.tip in ('SK0','SK9');
  	exception when NO_DATA_FOUND then null;
  	end;

	-- �� ����� ���� ��� ���� ?
	oData.nsp := 0;
  	begin
    	select Nvl(i.acr_dat,a.daos-1), a8.NLS, a6.NLS, -(a8.ostb+a.ostf)
    	into oData.dat_sp, oData.sn8_nls, oData.sd8_nls, oData.nsp
    	from accounts a, nd_acc n, int_accn i, accounts a8, accounts a6
    	where n.nd = ND_ and n.acc = a.acc and a.tip = 'SPN'
      		and i.id = 2 and a.acc = i.acc and i.acrA = a8.acc and i.acrB = a6.acc;
  	exception when NO_DATA_FOUND then null;
  	end;

	-- ����� ��������������
  	begin
    	select 	-SUM(decode(a.tip,'LIM',ostb+ostf, 0)),
           		-SUM(decode(a.tip,'LIM',0 , ostb+ostf)),
           		-SUM(decode(a.tip,'LIM', ostx, 0))
    	into oData.nss1, oData.nsn, nLIM_
    	from accounts a, nd_acc n
    	where n.nd = ND_ and n.acc = a.acc and a.tip in ('SN ','SPN','SLN','LIM');

    	If (oData.nss1 > 0 or oData.nsn1 > 0) then
       		oData.nss := GREATEST( oData.nss1 - nLIM_, 0);
       		oData.ns  := oData.nss + oData.nsn + Iif_N(oData.kv, oData.kv_kom, 0, oData.nsk, 0); /* �i������ ����i� */
       		oData.nsn1 := 0;
       		oData.nsk1 := 0;

       		-- ����������� %% � ������� ������
       		If (oData.dat_sn is Null or oData.dat_sn < gl_bdate_1) then

          		savepoint DO_ACRN;

          		delete from ACR_INTN;
          		FOR k in (	select a.acc, a.tip, i.metr, NVL(i.acr_dat, a.daos-1) + 1 DAT1
                    		from nd_acc n, accounts a, int_accn i
                    		where n.nd=ND_ and n.acc=a.acc and a.dazs is null
                      			and a.acc=i.acc
                      			and (i.id=0 and a.tip in ('SS ','SP ','SL ')  OR
                           				i.id = 2 and a.tip = 'LIM' and i.metr > 90 )
                   		)
          		LOOP
             		If (k.Tip = 'LIM' and k.Metr > 90) then /* ���.������� ������ METR>90 */
                		CC_KOMISSIA (k.Metr,k.Acc, 2, k.Dat1, gl_bdate_1, oData.nsk1, Null, 1);
                		oData.nsk1 := -oData.nsk1;
             		Else
                		acrn.p_int(k.Acc, 0, k.DAT1, gl_bdate_1, nInt_, NULL, 1);
             		end if;
          		END LOOP;

          		begin
             		select - sum(round(ACRD+ REMI,0))
             		into oData.nsn1
             		from ACR_INTN;
          		exception when NO_DATA_FOUND then null;
          		end;

          		rollback to DO_ACRN;

       		End if;

			oData.nsn1 := oData.nsn + oData.nsn1;
       		oData.nsk1:= oData.nsk + oData.nsk1;
       		oData.ns1 := oData.nss1 + oData.nsn1 + Iif_N( oData.kv, oData.kv_kom, 0, oData.nsk1, 0); /* �������� ����i� */

    	End if;

  	end;

  end get_doginfo;

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� �� ���������� ��������
  -- ������������� ��������� ��� CENTURA
  --
  -- ���������:
  -- CC_ID_ - �������������   ��
  -- DAT1_ - ���� �����      ��
  -- nRet_ - ��� ��������: =1 �� ������, =0 ������
  -- sRet_ - ����� ������ (?)  --
  -- ��������� ��� ������
  --
  procedure get_doginfo_centura(
								CC_ID_  IN  varchar2, -- �������������   ��
								DAT1_   IN  date    , -- ���� �����      ��
								nRet_   OUT int     , -- ��� ��������: =1 �� ������, =0 ������
								sRet_   OUT varchar2, -- ����� ������ (?)
								nS_     OUT number  ,
								nS1_    OUT number  ,
								NMK_    OUT varchar2, -- ������������ �������
								OKPO_   OUT varchar2, -- OKPO         �������
								ADRES_  OUT varchar2, -- �����        �������
								KV_     OUT int     , -- ��� ������   ��
								LCV_    OUT varchar2, -- ISO ������   ��
								NAMEV_  OUT varchar2, -- �����a       ��
								UNIT_   OUT varchar2, -- ���.������   ��
								GENDER_ OUT varchar2, -- ��� ������   ��
								nSS_    OUT number  , -- ����� ���.�����
								DAT4_   OUT date    , -- ���� ���������� ��
								nSS1_   OUT number  ,
								DAT_SN_ OUT date    , --\ �� ����� ���� ��� %
								nSN_    OUT number  , --/ ����� ��� %
								nSN1_   OUT number  ,
								DAT_SK_ OUT date    , --\ �� ����� ���� ��� ���
								nSK_    OUT number  , --/ ����� ��� ����������� ��������
								nSK1_   OUT number  ,
								KV_KOM_ OUT int     , --| ��� ��������
								DAT_SP_ OUT date    , -- �� ����� ���� ��� ����
								nSP_    OUT number  , -- ����� ��� ����������� ����
								SN8_NLS OUT varchar2, --\
								SD8_NLS OUT varchar2, --/ ����� ���������� ����
								MFOK_   OUT varchar2, --\
								NLSK_   out varchar2) --/ ���� �������
	IS
	  -- ����������
	  tmpRes rec_cckdog;

	begin
		get_doginfo(CC_ID_, DAT1_, BankDate, tmpRes);

		-- ����������� �������
		if (tmpRes.sos < 9 or tmpRes.sos > 16) then
	  		-- ������� �� ������.
	  		bars_error.raise_error('CKS-10');
	  	else
			-- ��������� out ����������
			nRet_ := 0; -- ��� ��������: =1 �� ������, =0 ������
			sRet_ := ''; -- ����� ������ (?)

			nS_ := tmpRes.ns;
			nS1_ := tmpRes.ns1;
			NMK_ := tmpRes.nmk; -- ������������ �������
			OKPO_ := tmpRes.okpo; -- OKPO         �������
			ADRES_ := tmpRes.adres; -- �����        �������
			KV_ := tmpRes.kv; -- ��� ������   ��
			LCV_ := tmpRes.lcv; -- ISO ������   ��
			NAMEV_ := tmpRes.namev; -- �����a       ��
			UNIT_ := tmpRes.unit; -- ���.������   ��
			GENDER_ := tmpRes.gender; -- ��� ������   ��
			nSS_ := tmpRes.nss; -- ����� ���.�����
			DAT4_ := tmpRes.dat4; -- ���� ���������� ��
			nSS1_ := tmpRes.nss1;
			DAT_SN_ := tmpRes.dat_sn; --\ �� ����� ���� ��� %
			nSN_ := tmpRes.nsn; --/ ����� ��� %
			nSN1_ := tmpRes.nsn1;
			DAT_SK_ := tmpRes.dat_sk; --\ �� ����� ���� ��� ���
			nSK_ := tmpRes.nsk; --/ ����� ��� ����������� ��������
			nSK1_ := tmpRes.nsk1;
			KV_KOM_ := tmpRes.kv_kom; --| ��� ��������
			DAT_SP_ := tmpRes.dat_sp; -- �� ����� ���� ��� ����
			nSP_ := tmpRes.nsp; -- ����� ��� ����������� ����
			SN8_NLS := tmpRes.sn8_nls; --\
			SD8_NLS := tmpRes.sd8_nls; --/ ����� ���������� ����
			MFOK_ := tmpRes.mfok; --\
			NLSK_ := tmpRes.nlsk; --/ ���� �������
	  	end if;

	exception when OTHERS then
		-- ���� ������������ ���� ������
		if (bars_error.get_error_code(SQLERRM) = 'CKS-00010') then
			nRet_ := 1;
			sRet_ := SQLERRM;

			return;
		end if;

		raise;
	end get_doginfo_centura;

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� �� ���������� ��������
  -- ������������� ��������� ��� WEB
  --
  -- ���������:
  -- CC_ID_ - �������������   ��
  -- DAT1_ - ���� �����      ��
  -- oDATA - ��������� ������ ���������, ���
  --
  procedure get_doginfo_web(
								CC_ID_  IN  varchar2, 	-- �������������   ��
								DAT1_   IN  date, 		-- ���� �����      ��
								l_response out clob -- ��������� ������ ���������, XML
							)
	is
		l_oData rec_cckdog;
	begin
		get_doginfo(CC_ID_, DAT1_,BankDate, l_oData);

	    l_response := XML_HEADER || CRLF ||
	      '<QueryResult>'        || CRLF ||
	      '   <CreditDogInfo>'   || CRLF ||
	      '       <ErrorMessage>'|| ''                             		 || '</ErrorMessage>'|| CRLF ||
	      '       <CcId>'        || CC_ID_                        		 || '</CcId>'     || CRLF ||
	      '       <Date>'        || to_char(DAT1_,'dd.mm.yyyy')   		 || '</Date>'   || CRLF ||
	      '       <Ns>'          || l_oData.nS                     		 || '</Ns>'     || CRLF ||
	      '       <Ns1>'         || l_oData.nS1                          || '</Ns1>'    || CRLF ||
	      '       <Nmk>'         || l_oData.NMK                          || '</Nmk>'    || CRLF ||
	      '       <Okpo>'        || l_oData.OKPO                         || '</Okpo>'   || CRLF ||
	      '       <Adres>'       || l_oData.ADRES                        || '</Adres>'  || CRLF ||
	      '       <Kv>'          || l_oData.KV                           || '</Kv>'     || CRLF ||
	      '       <Lcv>'         || l_oData.LCV                          || '</Lcv>'    || CRLF ||
	      '       <Namev>'       || l_oData.NAMEV                        || '</Namev>'  || CRLF ||
	      '       <Unit>'        || l_oData.UNIT                         || '</Unit>'   || CRLF ||
	      '       <Gender>'      || l_oData.GENDER                       || '</Gender>' || CRLF ||
	      '       <Nss>'         || l_oData.nSS                          || '</Nss>'    || CRLF ||
	      '       <Dat4>'        || to_char(l_oData.DAT4,'dd.mm.yyyy')   || '</Dat4>'   || CRLF ||
	      '       <Nss1>'        || l_oData.nSS1                         || '</Nss1>'   || CRLF ||
	      '       <DatSn>'       || to_char(l_oData.DAT_SN,'dd.mm.yyyy') || '</DatSn>'  || CRLF ||
	      '       <Nsn>'         || l_oData.nSN                          || '</Nsn>'    || CRLF ||
	      '       <Nsn1>'        || l_oData.nSN1                         || '</Nsn1>'   || CRLF ||
	      '       <DatSk>'       || to_char(l_oData.DAT_SK,'dd.mm.yyyy') || '</DatSk>'  || CRLF ||
	      '       <Nsk>'         || l_oData.nSK                          || '</Nsk>'    || CRLF ||
	      '       <Nsk1>'        || l_oData.nSK1                         || '</Nsk1>'   || CRLF ||
	      '       <KvKom>'       || l_oData.KV_KOM                       || '</KvKom>'  || CRLF ||
	      '       <DatSp>'       || to_char(l_oData.DAT_SP,'dd.mm.yyyy') || '</DatSp>'  || CRLF ||
	      '       <Nsp>'         || l_oData.nSP                          || '</Nsp>'    || CRLF ||
	      '       <Sn8Nls>'      || l_oData.SN8_NLS                      || '</Sn8Nls>' || CRLF ||
	      '       <Sd8Nls>'      || l_oData.SD8_NLS                      || '</Sd8Nls>' || CRLF ||
	      '       <Mfok>'        || l_oData.mfok                         || '</Mfok>'   || CRLF ||
	      '       <Nlsk>'        || l_oData.nlsk                         || '</Nlsk>'   || CRLF ||
	      '       <NlsSS>'       || l_oData.nlsSS                        || '</NlsSS>'  || CRLF ||
	      '   </CreditDogInfo>'  || CRLF                            	 ||
	      '</QueryResult>';

	end get_doginfo_web;

  -------------------------------------------------------
  -- ��������� ��������� �����c� �� ���������� ��������
  --
  -- ���������:
  --
  --  p_request          �����c
  --  p_status           ��������� ��������� �����c�
  --                              1 - �c����� ���������
  --                              2 - ��������� c �������
  --  p_response         ����� �� �����c
  --
  procedure process_doginfo_query(
      p_request         in   gq_query.request%type,
      p_status          out  gq_query.query_status%type,
      p_response        out  gq_query.response%type)
  is
  	l_oData rec_cckdog; -- ��������� ������ ����������

    l_cc_id varchar2(500);
    l_date date;
    l_bdate date;

    l_response clob; -- XML ������ ����������
    l_reqstatus number := 0;
    l_errmsg varchar2(500) := '';
  begin
    bars_audit.trace('bars_gqcck: process_doginfo_query entry point');

    -- ��������� ������� BRANCH
    if (sys_context('bars_context', 'user_branch') != '/') then
      -- ����c� ��������� ������ ���������c� ������ ������������� ���������.
 	  bars_error.raise_error('CKS-11');
    end if;

    l_cc_id   := extract(p_request,'/Query/CreditDogInfo/CcId/text()','');
    l_date := to_date(extract(p_request,'/Query/CreditDogInfo/Date/text()','01.01.1900'), 'dd.mm.yyyy');
    l_bdate := to_date(extract(p_request,'/Query/CreditDogInfo/BDate/text()','01.01.1900'), 'dd.mm.yyyy');
    bars_audit.trace('bars_gqcck: process_doginfo_query CcId='||l_cc_id||' date='||l_date);

    begin
      get_doginfo(l_cc_id, l_date, l_bdate, l_oData);
      l_reqstatus := 1;
    exception when others then
      l_reqstatus := 2;
      l_errmsg := SQLERRM;
    end;

    --
    -- c������ ����� �� �����c
    --
    l_response := XML_HEADER || CRLF ||
      '<QueryResult>'        || CRLF ||
      '   <CreditDogInfo>'   || CRLF ||
      '       <ErrorMessage>'|| l_errmsg                       		 || '</ErrorMessage>'|| CRLF ||
      '       <CcId>'        || l_cc_id                        		 || '</CcId>'     || CRLF ||
      '       <Date>'        || to_char(l_date,'dd.mm.yyyy')   		 || '</Date>'   || CRLF ||
      '       <Ns>'          || l_oData.nS                     		 || '</Ns>'     || CRLF ||
      '       <Ns1>'         || l_oData.nS1                          || '</Ns1>'    || CRLF ||
      '       <Nmk>'         || l_oData.NMK                          || '</Nmk>'    || CRLF ||
      '       <Okpo>'        || l_oData.OKPO                         || '</Okpo>'   || CRLF ||
      '       <Adres>'       || l_oData.ADRES                        || '</Adres>'  || CRLF ||
      '       <Kv>'          || l_oData.KV                           || '</Kv>'     || CRLF ||
      '       <Lcv>'         || l_oData.LCV                          || '</Lcv>'    || CRLF ||
      '       <Namev>'       || l_oData.NAMEV                        || '</Namev>'  || CRLF ||
      '       <Unit>'        || l_oData.UNIT                         || '</Unit>'   || CRLF ||
      '       <Gender>'      || l_oData.GENDER                       || '</Gender>' || CRLF ||
      '       <Nss>'         || l_oData.nSS                          || '</Nss>'    || CRLF ||
      '       <Dat4>'        || to_char(l_oData.DAT4,'dd.mm.yyyy')   || '</Dat4>'   || CRLF ||
      '       <Nss1>'        || l_oData.nSS1                         || '</Nss1>'   || CRLF ||
      '       <DatSn>'       || to_char(l_oData.DAT_SN,'dd.mm.yyyy') || '</DatSn>'  || CRLF ||
      '       <Nsn>'         || l_oData.nSN                          || '</Nsn>'    || CRLF ||
      '       <Nsn1>'        || l_oData.nSN1                         || '</Nsn1>'   || CRLF ||
      '       <DatSk>'       || to_char(l_oData.DAT_SK,'dd.mm.yyyy') || '</DatSk>'  || CRLF ||
      '       <Nsk>'         || l_oData.nSK                          || '</Nsk>'    || CRLF ||
      '       <Nsk1>'        || l_oData.nSK1                         || '</Nsk1>'   || CRLF ||
      '       <KvKom>'       || l_oData.KV_KOM                       || '</KvKom>'  || CRLF ||
      '       <DatSp>'       || to_char(l_oData.DAT_SP,'dd.mm.yyyy') || '</DatSp>'  || CRLF ||
      '       <Nsp>'         || l_oData.nSP                          || '</Nsp>'    || CRLF ||
      '       <Sn8Nls>'      || l_oData.SN8_NLS                      || '</Sn8Nls>' || CRLF ||
      '       <Sd8Nls>'      || l_oData.SD8_NLS                      || '</Sd8Nls>' || CRLF ||
      '       <Mfok>'        || l_oData.mfok                         || '</Mfok>'   || CRLF ||
      '       <Nlsk>'        || l_oData.nlsk                         || '</Nlsk>'   || CRLF ||
      '   </CreditDogInfo>'  || CRLF                            		 ||
      '</QueryResult>';

    p_status   := l_reqstatus;
    p_response := xmltype.createXML(l_response);

    bars_audit.info('GQCCK: c���������� ����� ��� �����c�.');
    bars_audit.trace('bars_gqcck: process_doginfo_query end');

  end process_doginfo_query;

  -----------------------------------------------------------------
  --
  -- ��������� ��������� c����c� �����c��, �����c� � ������
  --
  procedure get_response(
    p_queryid in gq_query.query_id%type,          -- id �������
    p_querystatus out gq_query.query_status%type, -- ������ �������
    p_request out  gq_query.request%type,         -- �����c
    p_response out  gq_query.response%type        -- �����
  ) is
  begin
    select query_status, request, response
      into p_querystatus, p_request, p_response
      from gq_query
     where query_id = p_queryid;
    bars_audit.trace('bars_gqcck: get_response query status is %s', p_querystatus);
  exception when NO_DATA_FOUND then
    bars_audit.trace('bars_gqcck: get_response query id=%s not found.');
    bars_audit.error('GQCCK: �����c c ��������������� ' || p_queryid || ' �� ������');

    -- �����c �� ������.
    bars_error.raise_error('CKS-12');
  end get_response;

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� ������. �����c� �� ���������� ��������
  --
  -- ���������:
  -- p_queryid  - ����� � ������� ��������
  -- p_querystatus - ������ �������
  -- p_errmsg - ����� ������ �������
  -- p_response - ���������/������ ������� XML
  --
  procedure get_doginfo_query(
    p_queryid      in gq_query.query_id%type,
    p_querystatus  out  gq_query.query_status%type,
    p_errmsg       out  varchar2,
    p_response     out  clob
  )
  is
    l_request    gq_query.request%type;     -- �����c
    l_response   gq_query.response%type;    -- ����� �� �����c
  begin
    p_response := to_clob(null);

    -- ���������� ��������� ��������� ������ �� ������
    get_response(p_queryid, p_querystatus, l_request, l_response);

    p_errmsg   := extract(l_response, '/QueryResult/CreditDogInfo/ErrorMessage/text()','');
    p_response := getStringVal(l_response, null);

  end get_doginfo_query;

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� ������. �����c� �� ���������� ��������
  -- ������������� ��������� ��� CENTURA
  --
  -- ���������:
  -- p_queryid  - ����� � ������� ��������
  -- p_querystatus - ������ �������
  -- p_errmsg - ����� ������ �������
  -- ��������� ��� ������
  --
  procedure get_doginfo_query_centura(
    p_queryid      in   gq_query.query_id%type,
    p_querystatus  out  gq_query.query_status%type,
    p_errmsg       out  varchar2,
    p_cc_id        out cc_deal.cc_id%type,
    p_date         out date,
    p_nS           out number,
    p_nS1          out number,
    p_NMK          out customer.nmk%type,   -- ������������ �������
    p_OKPO         out customer.okpo%type,  -- OKPO �������
    p_ADRES        out customer.adr%type,   -- ����c        �������
    p_KV           out cc_add.kv%type,      -- ��� ������   ��
    p_LCV          out tabval.lcv%type,     -- ISO ������   ��
    p_NAMEV        out tabval.name%type,    -- �����a       ��
    p_UNIT         out tabval.unit%type,    -- ���.������   ��
    p_GENDER       out tabval.gender%type,  -- ��� ������   ��
    p_nSS          out number,              -- c���� �c�.�����
    p_DAT4         out date,                -- ���� ���������� ��
    p_nSS1         out number,
    p_DAT_SN       out date,                -- �� ����� ���� ��� %
    p_nSN          out number,              -- c���� ��� %
    p_nSN1         out number,
    p_DAT_SK       out date,                -- �� ����� ���� ��� ���
    p_nSK          out number,              -- c���� ��� ����c������ ����cc��
    p_nSK1         out number,
    p_KV_KOM       out int,                 -- ��� ����cc��
    p_DAT_SP       out date,                -- �� ����� ���� ��� ����
    p_nSP          out number,              -- c���� ��� ����c������ ����
    p_SN8_NLS      out accounts.nls%type,   --
    p_SD8_NlS      out accounts.nls%type,   -- c���� ����c����� ����
    p_MFOK         out accounts.kf%type,    --
    p_NLSK         out accounts.nls%type)   -- c��� �������
  is
    l_response_clob  clob;    -- ����� �� �����c
    l_response       xmltype;    -- ����� �� �����c
  begin
    bars_audit.trace('bars_gqcck: get_doginfo_query_centura entry point');

    -- ���������� ��������� ��������� ������ �� ������
	  get_doginfo_query( p_queryid, p_querystatus, p_errmsg, l_response_clob);

   -- ���� ������������ ���� ������
  	if p_querystatus = 2 and bars_error.get_error_code(p_errmsg) = 'CKS-00010' then
       p_querystatus:=1;
		end if;

    bars_audit.trace('bars_gqcck: get_doginfo_query_centura entry point');

    -- ��������� �c�����
    if (p_querystatus = 1) then

    	l_response := XMLTYPE(l_response_clob);
  		p_errmsg   := extract(l_response, '/QueryResult/CreditDogInfo/ErrorMessage/text()',null);
  		p_cc_id    := extract(l_response, '/QueryResult/CreditDogInfo/CcId/text()',null);
  		p_date     := to_date(extract(l_response, '/QueryResult/CreditDogInfo/Date/text()',null), 'dd.mm.yyyy');
  		p_nS       := extract(l_response, '/QueryResult/CreditDogInfo/Ns/text()',null);
  		p_nS1      := extract(l_response, '/QueryResult/CreditDogInfo/Ns1/text()',null);
  		p_NMK      := extract(l_response, '/QueryResult/CreditDogInfo/Nmk/text()',null);
  		p_OKPO     := extract(l_response, '/QueryResult/CreditDogInfo/Okpo/text()',null);
  		p_ADRES    := extract(l_response, '/QueryResult/CreditDogInfo/Adres/text()',null);
  		p_KV       := extract(l_response, '/QueryResult/CreditDogInfo/Kv/text()',null);
  		p_LCV      := extract(l_response, '/QueryResult/CreditDogInfo/Lcv/text()',null);
  		p_NAMEV    := extract(l_response, '/QueryResult/CreditDogInfo/Namev/text()',null);
  		p_UNIT     := extract(l_response, '/QueryResult/CreditDogInfo/Unit/text()',null);
  		p_GENDER   := extract(l_response, '/QueryResult/CreditDogInfo/Gender/text()',null);
  		p_nSS      := extract(l_response, '/QueryResult/CreditDogInfo/Nss/text()',null);
  		p_DAT4     := to_date(extract(l_response, '/QueryResult/CreditDogInfo/Dat4/text()',null), 'dd.mm.yyyy');
  		p_nSS1     := extract(l_response, '/QueryResult/CreditDogInfo/Nss1/text()',null);
  		p_DAT_SN   := to_date(extract(l_response, '/QueryResult/CreditDogInfo/DatSn/text()',null), 'dd.mm.yyyy');
  		p_nSN      := extract(l_response, '/QueryResult/CreditDogInfo/Nsn/text()',null);
  		p_nSN1     := extract(l_response, '/QueryResult/CreditDogInfo/Nsn1/text()',null);
  		p_DAT_SK   := to_date(extract(l_response, '/QueryResult/CreditDogInfo/DatSk/text()',null), 'dd.mm.yyyy');
  		p_nSK      := extract(l_response, '/QueryResult/CreditDogInfo/Nsk/text()',null);
  		p_nSK1     := extract(l_response, '/QueryResult/CreditDogInfo/Nsk1/text()',null);
  		p_KV_KOM   := extract(l_response, '/QueryResult/CreditDogInfo/KvKom/text()',null);
  		p_DAT_SP   := to_date(extract(l_response, '/QueryResult/CreditDogInfo/DatSp/text()',null), 'dd.mm.yyyy');
  		p_nSP      := extract(l_response, '/QueryResult/CreditDogInfo/Nsp/text()',null);
  		p_SN8_NLS  := extract(l_response, '/QueryResult/CreditDogInfo/Sn8Nls/text()',null);
  		p_SD8_NlS  := extract(l_response, '/QueryResult/CreditDogInfo/Sd8Nls/text()',null);
  		p_MFOK     := extract(l_response, '/QueryResult/CreditDogInfo/Mfok/text()',null);
  		p_NLSK     := extract(l_response, '/QueryResult/CreditDogInfo/Nlsk/text()',null);
	  end if;

    bars_audit.trace('bars_gqcck: get_doginfo_query_centura response parsed, done...');

  end get_doginfo_query_centura;

  -----------------------------------------------------------------
  --
  -- ��������� ��������� ���������� ������. �����c� �� ���������� ��������
  -- ������������� ��������� ��� WEB
  --
  -- ���������:
  -- p_queryid  - ����� � ������� ��������
  -- p_querystatus - ������ �������
  -- p_errmsg - ����� ������ �������
  -- p_response - ������ � ���� XML
  --
  procedure get_doginfo_query_web(
									    p_queryid      in   gq_query.query_id%type,
									    p_querystatus  out  gq_query.query_status%type,
									    p_errmsg       out  varchar2,
										  p_response     out  clob
										)
  is
    l_response   clob;    -- ����� �� �����c
  begin
    bars_audit.trace('bars_gqcck: get_doginfo_query_web entry point');

    -- ���������� ��������� ��������� ������ �� ������
	  get_doginfo_query( p_queryid, p_querystatus, p_errmsg, l_response);

    -- ��������� �c�����
    if (p_querystatus = 1) then
		  p_response := l_response;
	  end if;

    bars_audit.trace('bars_gqcck: get_doginfo_query_web response parsed, done...');

  end get_doginfo_query_web;

end bars_gqcck; 
/
 show err;
 
PROMPT *** Create  grants  BARS_GQCCK ***
grant EXECUTE                                                                on BARS_GQCCK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_GQCCK      to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BARS_GQCCK      to WR_CREDIT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_gqcck.sql =========*** End *** 
 PROMPT ===================================================================================== 
 