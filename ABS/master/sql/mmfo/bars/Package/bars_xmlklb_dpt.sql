
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_xmlklb_dpt.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_XMLKLB_DPT is

   -------------------------------------------------------------
   --
   --  ����� ��������� ��������� ������-����� �� �������� ���������
   --
   -------------------------------------------------------------


  -----------------------------------------------------------------
  --
  --    ���������
  --
  -----------------------------------------------------------------

  G_HEADER_VERSION  constant varchar2(64) := 'version 1.4 29.04.2009';


   -----------------------------------------------------------------
   --    XML_DPT()
   --
   --   ��������� - ���� � ��������� ������ ��������� �� ��������
   --
   --    p_message - ��������� ��� ���������
   --    p_pack    - �������� ������ ���������
   --    p_gateid  - ����� ��������� ���������
   --    p_seckey  - ���� ��������  kltoss
   --    p_reply   - ��������� ���������
   --
   procedure xml_dpt(
                  p_message     varchar2,
                  p_pack        bars_xmlklb.t_pack,
                  p_gateid      number,
                  p_seckey      varchar2,
                  p_reply   out clob);


   -----------------------------------------------------------------
   --    CHECK_PAY_PERMISSION
   --
   --    ��������� �������, ������� ��������� ����������� ���������� ��������
   --    ��� ��������
   --
   --    p_ref - ��� ���������,  ������� ��������, �� ��� �� �������
   --    p_tt  - ��� ��������
   --    p_sum - ����� ��������
   --
   --
   procedure  check_pay_permission(
                  p_ref  number,
                  p_tt   varchar2,
                  p_sum  number);


   -----------------------------------------------------------------
   --    MAIN_NLS()
   --
   --    �� ������������ ������� ��������, ��������
   --    ����� �������� � ���� � ����� ���. ���� ��������� �����.
   --    ����� ��� ���������� ��������� ����� �������� ���������.
   --
   --
   function main_nls return varchar2;



   -----------------------------------------------------------------
   --    ACRINT_NLS()
   --
   --    �� ������������ ������� ��������, ��������
   --    ���. ���� ����� ������. %%
   --    ����� ��� ���������� � �������� ��������.
   --
   --
   function acrint_nls return varchar2;


   -----------------------------------------------------------------
   --    AFTER_PAY_DPT_OP
   --
   --    ������� ���������� �������� ����� ������ ������ ��������� �� ��������
   --
   --    p_doc - ��������
   --
   --
   procedure after_pay_dpt_op(p_doc  oper%rowtype);


   -----------------------------------------------------------------
   --    ADD_OFFLINE_TTS
   --
   --    ��� ������� �������� ���������� �������� ��������,
   --    ������� ����� � ��� ��������� (dpt_tts_vidd). ������ �������� ������ ���� ���������
   --    ��������(� �� ������ ��� ��� ������� � ��� �������� ������).
   --    �� ��������� �������� ��� �������� � ��� ������� ������, �������� �������
   --    �������� � ��������� ����������� ��� ������ ���� ������� �� ��������� ���
   --    ����������� �������� ��� �������. ������ ������ �������� ��������� ��������
   --    TTOF1, TTOF2 ...  ���� �������� ������� ����� �������� ������� ������������
   --    ������ �������� ������. (�������� DP0 -> KB9 ""- )
   --        DP0 +���������� ������ � ���.�����_ ���_����
   --        KB9 off  DPT - ���������� ������ ���. ���
   --
   --
   procedure add_offline_tts;


END;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_XMLKLB_DPT is


   -------------------------------------------------------------
   --
   --  ����� ��������� ��������� ������-����� �� �������� ���������
   --
   -------------------------------------------------------------
g_awk_body_defs constant varchar2(512) := ''
  	||'MKF - ���������������� ������'
  ;


   ----------------------------------------------
   --  ���������
   ----------------------------------------------

   G_BODY_VERSION    constant varchar2(64) := 'version 2.15 12.01.2011';
   G_TRACE           constant varchar2(50) := 'xmlklb_dpt.';
   G_MODULE          constant varchar2(50) := 'KLB';

   G_MESSAGE           constant varchar2(10) := 'DPT1';   -- ��� ��������� �� ��-�����

   G_TT_FIRST    constant smallint := 0;  -- �������. �����
   G_TT_ADDITION constant smallint := 1;  -- ����������
   G_TT_BACKDPT  constant smallint := 2;  -- ������� �������� ����� ��������� �����
   G_TT_GETINT   constant smallint := 3;  -- ������ ���������
   G_TT_SHTRAF   constant smallint := 5;  -- ������ ������ � ���������� ������
   G_TT_PBACKDPT constant smallint := 22; -- ��������� ������ ������
   ----------------------------------------------
   --  ����������
   ----------------------------------------------

   G_IS_DPT_EXISTS smallint;  -- ������� ���������� ��� ��������� - ����������
                              -- �� ��� ������� � �� �����, ����� ������ ���-� ��������� ������
                              -- (���������� ��� ����, ��� � ����������� �� ��������� �������)
   G_REF_DPT       smallint;  -- ���� ���. �������, ������ ���������� �������� ���.���-��
                              -- ���������� ������, ������������ ���������
                                          --
   G_CURR_DPT_OP   smallint;              --  ������� �������� �� ��������
   G_CURR_DPT_ND   dpt_deposit.nd%type;   --  ������� ����� ��������



   ----------------------------------------------
   --  ����
   ----------------------------------------------

   -- ��������� ��� �������� �������
   type t_customer  is record
     ( clientname       customer.nmk%type,
       client_name      varchar2(300),
       client_surname   varchar2(300),
       client_patr      varchar2(300),
       country          customer.country%type,
       pindex           customer_address.zip%type,
       obl              customer_address.domain%type,
       district         customer_address.region%type,
       settlement       customer_address.locality%type,
       adress           customer_address.address%type,
       fulladdress      customer.adr%type,
       clientcodetype   customer.tgr%type,
       clientcode       customer.okpo%type,
       doctype          person.passp%type,
       docserial        person.ser%type,
       docnumber        person.numdoc%type,
       docorg           person.organ%type,
       docdate          person.pdate%type,
       clientbdate      person.bday%type,
       clientbplace     person.bplace%type,
       clientsex        person.sex%type,
       clienthomeph     person.teld%type,
       clientworkph     person.telw%type,
       clientname_gc    customerw.value%type,
       resid_code       number,
       resid_index      varchar2(500),
       resid_obl        varchar2(500),
       resid_district   varchar2(500),
       resid_settlement varchar2(500),
       resid_adress     varchar2(500),
       clientid         number,
       registrydate     date);



   -- ��������� ��� �������� ��������
   type t_contract is record
     ( vidd           dpt_deposit.vidd%type,      -- ���.� ���������
       rnk            dpt_deposit.rnk%type,       -- ����� �������� (������������)
       nd             dpt_deposit.nd%type,        -- ����� ������ ��� ��������
       dpt_sum        dpt_deposit.limit%type,     -- ������ ����� (0-���,1- ������)
       datz           dpt_deposit.datz%type,      -- ���� ���������� ��������
       namep          dpt_deposit.name_p%type,    -- ���������� %%
       okpop          dpt_deposit.okpo_p%type,    -- �������.��� ���������� %%
       nlsp           dpt_deposit.nls_p%type,     -- ���� ��� ������� %%
       mfop           dpt_deposit.mfo_p%type,     -- ��� ��� ������� %%
       fl_perekr      dpt_vidd.fl_2620%type,      -- ���� �������� ����.�����
       name_perekr    dpt_deposit.nms_d%type,     -- ���������� ��������
       okpo_perekr    dpt_deposit.okpo_p%type,    -- �������.��� ���������� ��������
       nls_perekr     dpt_deposit.nls_d%type,     -- ���� ��� �������� ��������
       mfo_perekr     dpt_deposit.mfo_d%type,     -- ��� ��� �������� ��������
       comment        dpt_deposit.comments%type,  -- �����������
       dpt_id         dpt_deposit.deposit_id%type,-- ������������� ��������
       datbegin       date,                       -- ���� �������� ��������
       duration       dpt_vidd.duration%type,
       duration_days  dpt_vidd.duration_days%type);


   -- ��������� ��� �������� ���. ��������
   type t_soccontract is record
     ( custid         social_contracts.rnk%type,            -- ���.� ���������
       soctypeid      social_contracts.type_id%type,        -- ��� ��� ��������
       agencyid       social_contracts.agency_id%type,      -- ��� ��� ��������
       contractnum    social_contracts.contract_num%type,   -- ����� ��������
       contractdate   social_contracts.contract_date%type,  -- ���� ���������� ��������
       cardaccount    social_contracts.card_account%type,   -- ����� ��������
       pensionnum     social_contracts.pension_num%type,    -- ����� ����������� �������������
       details        social_contracts.details%type,        -- �����������
       contractacc    social_contracts.acc%type,            -- out. �������� ����� ������
       contractid     social_contracts.contract_id%type     -- out. ����� ���. ���������(��������)
     );



   type t_socdeposit is record
     ( customer    t_customer,      -- ��������� �������
       contract    t_soccontract,   -- ��������� ���������
       ref         number);         -- �������� ��. �����


   type t_deposit is record
     ( customer    t_customer,  -- ��������� �������
       contract    t_contract,  -- ��������� ���������
       ref         number);     -- �������� ��. �����



   -- ��� - ������ �� �������� �������� (���������/�������) ��� ���������� ������
   type t_getdeposit is record
     ( procdat   date,           -- ���� ��������/������
       dptid     number,         -- ����� �������� (dpt_deposit.deposit_id)
       amount    number,         -- ����� ��� ���������� ������ (��� = null, ���� ��������)
       isclose   number,         -- out - ������ �� �������
       dpt2pay   number,         -- out - ����� ������� ����� ����� � �������� �����
       int2pay   number,         -- out - ����� ������� ����� ����� � ����� %%
       penalty   number,         -- out - ����� �����
       comments  varchar2(3000),  -- out - �������� (��� ��������� ����������� - �������� ������ ������ ��� ���������)
       ref       number);        -- �������� ��. �����


  type t_agreement is record
    ( dptid           dpt_agreements.dpt_id%type,          -- ������������� ��������
      agrmnttype      dpt_agreements.agrmnt_type%type,     -- ��� ��
      initcustid      dpt_deposit.rnk%type,                -- ���.� ���������� ��
      trustcustid     customer.rnk%type,                   -- ���.� 3-�� ����
      trustid         dpt_trustee.id%type,                 -- ��� ������������� �� � 3-�� �����
      transferdpt     CLOB,                                -- ��������� �������� ��������
      transferint     CLOB,                                -- ��������� ������� ���������
      amountcash      dpt_agreements.amount_cash%type,     -- ����� ����������/������ ���.
      amountcashless  dpt_agreements.amount_cashless%type, -- ����� ����������/������ ������.
      datbegin        dpt_agreements.date_begin%type,      -- ����� ���� ������ ��������
      datend          dpt_agreements.date_end%type,        -- ����� ���� ��������� ��������
      ratereqid       dpt_agreements.rate_reqid%type,      -- ��� ������� �� ��������� ������
      ratevalue       dpt_agreements.rate_value%type,      -- ����� �������� %-��� ������
      ratedate        dpt_agreements.rate_date%type,       -- ���� ������ �������� ����� ������
      denomamount     dpt_agreements.denom_amount%type,    -- ����� ������ �����
      denomcount      dpt_agreements.denom_count%type,     -- ���-�� ������ �����
      denomref        dpt_agreements.denom_ref%type,       -- ���.�������� �� ����� ������ �����
      comissref       dpt_agreements.comiss_ref%type,      -- ���.�������� �� ���������� ��
      docref	      dpt_agreements.DOC_REF%type,         -- ���. ��������� ����������/���������� ������
      comissreqid     dpt_agreements.comiss_reqid%type,    -- ��. �������
      agrmntid        dpt_agreements.agrmnt_id%type        -- ������������� ��
   );


  type t_dptagreement is record
   (  customer    t_customer,  -- ��������� ������� (���� �� 3-�� �����)
      agreement   t_agreement, -- ��������� ���. ����������
      ref       number
   );


   -----------------------------------------------------------------
   --    INSERT_DOC
   --
   --    ������� ���-�� � ��  gl.indoc2
   --
   --    p_doc       - ���-�
   --    p_dreclist  - ��� ���������
   --
   procedure insert_doc(
                  p_doc        oper%rowtype,
                  p_dreclist   bars_xmlklb.array_drec)
   is
      l_drec          varchar2(60);
      l_trace         varchar2(1000) := G_TRACE||'insert_doc: ';
   begin

      gl.in_doc2(
          ref_   =>  p_doc.ref,
          tt_    =>  p_doc.tt,
          vob_   =>  p_doc.vob,
          nd_    =>  p_doc.nd,
          pdat_  =>  p_doc.pdat,
          vdat_  =>  p_doc.vdat,
          dk_    =>  p_doc.dk,
          kv_    =>  p_doc.kv,
          s_     =>  p_doc.s,
          kv2_   =>  p_doc.kv2,
          s2_    =>  p_doc.s2,
          sq_    =>  0,
          sk_    =>  p_doc.sk,
          data_  =>  p_doc.datd,
          datp_  =>  p_doc.pdat,
          nam_a_ =>  p_doc.nam_a,
          nlsa_  =>  p_doc.nlsa,
          mfoa_  =>  p_doc.mfoa,
          nam_b_ =>  p_doc.nam_b,
          nlsb_  =>  p_doc.nlsb,
          mfob_  =>  p_doc.mfob,
          nazn_  =>  p_doc.nazn,
          d_rec_ =>  null,
          id_a_  =>  p_doc.id_a,
          id_b_  =>  p_doc.id_b,
          id_o_  =>  p_doc.id_o,
          sign_  =>  null,
          sos_   =>  0,
          prty_  =>  0,
          uid_   =>  null);


      --  �������� ���. ����������
      for i in 0..p_dreclist.count - 1 loop

            if ( p_dreclist(i).tag is not null and
       		     p_dreclist(i).val is not null ) then
                begin
                   insert into operw(ref, tag, value)
                   values(p_doc.ref, p_dreclist(i).tag, p_dreclist(i).val);
                exception when others then
                    bars_error.raise_error('KLB', 31, p_dreclist(i).tag);
                end;
            end if;
      end loop;


   exception when others then
      bars_audit.error(l_trace||'������ ������� ���-��: '||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    PAY_DOC()
   --
   --    �������� ���-�
   --
   --
   procedure pay_doc(
                  p_doc     in out oper%rowtype)
   is
      l_paymode   number;
      l_trace     varchar2(1000)   := G_TRACE||'pay_doc: ';
   begin
      -- 37 - ������ �� ����.������� = 1 / �� ����.������� = 0 / �� ������� = 2
      begin
         select value
         into   l_paymode
         from   tts_flags
         where  tt = p_doc.tt and fcode = 37;
      exception when no_data_found then
         bars_audit.debug(l_trace||'�� ����� tt='||p_doc.tt);
         l_paymode := 0;
      end;
      bars_audit.debug(l_trace||'��� ������ =:'||l_paymode);
      bars_audit.debug(l_trace||'tt = '||p_doc.tt||' nlsa='||p_doc.nlsa||' nlsb='||p_doc.nlsb||' s='||p_doc.s||'��� ������ =:'||l_paymode);

      begin
         bars_audit.debug(l_trace||'����� gl.dyntt2');
         gl.dyntt2 (
                 sos_    => p_doc.sos,
                 mod1_   => l_paymode,
                 mod2_   => 1,
                 ref_    => p_doc.ref,
                 vdat1_  => p_doc.vdat,
                 vdat2_  => p_doc.vdat,
                 tt0_    => p_doc.tt,
                 dk_     => p_doc.dk,
                 kva_    => p_doc.kV,
                 mfoa_   => p_doc.mfoa,
                 nlsa_   => p_doc.nlsa,
                 sa_     => p_doc.s,
                 kvb_    => p_doc.kv,
                 mfob_   => p_doc.mfob,
                 nlsb_   => p_doc.nlsb,
                 sb_     => p_doc.s,
                 sq_     => p_doc.s,
                 nom_    => 0);

          bars_audit.trace(l_trace||'�������� �������');

       bars_xmlklb.G_DOC_REF := null;

       exception when others then
           -- ���� ������, account is locked
           bars_audit.error(l_trace||'������ ����������� gl.dyntt2 '||sqlerrm);
           if (  instr(sqlerrm,'\') > 0 and
   	         substr(sqlerrm, instr(sqlerrm,'\') + 1, 4) = 9349) then
               bars_audit.info(l_trace||'���� ����� ������ ���������: '||sqlerrm);
               bars_error.raise_error('KLB', 33);
           else raise;
           end if;

      end;

   end;





   -----------------------------------------------------------------
   --    INIT_DOC_FIELDS_ACCRUE()
   --
   --    ������������������� ���� ���-�� ��� ������� ������������ %%
   --
   --    p_doc      - ��������
   --    p_accdoh   - ��� ����� �������
   --    p_accint   - acc ��������� ��������
   --    p_intsum   - �����
   --    p_tt       - ��������
   --    p_kv       - ������
   --    p_nazn     - ����������
   --
   procedure init_doc_fields_accrue(
                  p_doc     in out oper%rowtype,
                  p_accdoh        number,
                  p_accint        number,
                  p_intsum        number,
                  p_tt            tts.tt%type,
                  p_kv            number,
                  p_nazn          varchar2 )
   is
      l_trace     varchar2(1000)   := G_TRACE||'init_doc_fields_accrue: ';
   begin


      -- �������� ����� ��� ���-��
      gl.ref(p_doc.ref);

      begin
         select a.nls,      nmkk,        okpo,       p_kv
         into   p_doc.nlsa, p_doc.nam_a, p_doc.id_a, p_doc.kv
         from   accounts a, customer c
         where  a.rnk = c.rnk and a.acc = p_accdoh;
      exception when no_data_found then
         bars_error.raise_error('KLB', 60, to_char(p_accdoh));
      end;


      begin
         select a.nls,      nmkk,        okpo,       p_kv
         into   p_doc.nlsb, p_doc.nam_b, p_doc.id_b, p_doc.kv
         from   accounts a, customer c
         where  a.rnk = c.rnk and a.acc = p_accint;
      exception when no_data_found then
         bars_error.raise_error('KLB', 61, to_char(p_accint));
      end;

      p_doc.tt    := p_tt;
      p_doc.dk    := 1;
      p_doc.s     := p_intsum;
      p_doc.s2    := p_doc.s;
      p_doc.kv2   := p_doc.kv;

      p_doc.mfoa  := gl.amfo;
      p_doc.mfob  := gl.amfo;

      p_doc.datd  := gl.bd;
      p_doc.pdat  := gl.bd;
      p_doc.vdat  := gl.bd;
      p_doc.nd    := p_doc.ref;
      p_doc.nazn  := p_nazn;
      p_doc.vob   := 6;


   exception when others then
      bars_audit.error(l_trace||'������ ������������� ����� ���-�� ��� ������������ %%: '||sqlerrm);
      raise;


   end;





   -----------------------------------------------------------------
   --    MAIN_ACC()
   --
   --    �� ������������ ������� ��������, ��������
   --    ����� �������� � ���� � ����� acc ��������� ����� � ����� ���������
   --
   --
   procedure main_acc(
            p_nls  out varchar2,
            p_acc  out number,
            p_kv   out number,
            p_cntr out dpt_deposit.nd%type )

   is
      l_acc    number;
      l_dptpr  varchar2(4);
      l_trace  varchar2(1000) := G_TRACE||'main_acc: ';
   begin

      if bars_xmlklb.G_DOC_REF is null then
         bars_xmlklb.G_DOC_REF := gl.aref;
      end if;

      -- ������� ���. �������� ������� ��������
      bars_audit.trace(l_trace||' ������� ���. �������� ������� �������� ��� ���='||bars_xmlklb.G_DOC_REF||' ��� -CNTR ');
      begin
         select value
         into p_cntr
         from operw
         where ref = bars_xmlklb.G_DOC_REF and tag = 'CNTR ';
         bars_audit.trace(l_trace||' �� ������ �������� �������� ��� ��������='||p_cntr);
      exception when no_data_found then
         bars_error.raise_error('KLB', 55);
      end;


      begin
         select value
         into l_dptpr
         from operw
         where ref = bars_xmlklb.G_DOC_REF and tag = 'DPTPR';
         bars_audit.trace(l_trace||'��� �������� ='||l_dptpr);
      exception when no_data_found then
         bars_error.raise_error('KLB', 55);
      end;

      -- �������� ���������� ����� ��������
      -- �������, ��� ����� ��������||branch - ��� ���������� �����
      bars_audit.trace(l_trace||'����� �������� �� ������: '||p_cntr);
      begin


         case  l_dptpr
               when 'DPT1' then  select a.acc, a.nls, a.kv
                                 into p_acc, p_nls, p_kv
                                 from dpt_deposit t, accounts a
                                 where nd = trim(p_cntr)
                                 and a.acc = t.acc;
               when 'DPT2' then  select a.acc, a.nls, a.kv
                                 into p_acc, p_nls, p_kv
                                 from social_contracts t, accounts a
                                 where contract_num = trim(p_cntr)
                                 and a.acc = t.acc;
               else
                   bars_error.raise_error(G_MODULE, 178, l_dptpr);
          end case;

          bars_audit.trace(l_trace||'�������� acc= '||p_acc);


      exception when others then
          case
          when sqlcode = -01403 or sqlcode = 100 then  -- no_data_found
             bars_error.raise_error('KLB', 56, to_char(p_cntr), sys_context('bars_context','user_branch'));
          when sqlcode = -01422 then  -- exact fetch returns more than requested number of rows
             bars_error.raise_error('KLB', 59, to_char(p_cntr));
          else
             raise;
          end case;
      end;

      bars_audit.trace(l_trace||'��� ���-�� ���='||bars_xmlklb.G_DOC_REF||' ��� ��������� �����='||p_acc||' �������='||p_nls);
   exception when others then
      bars_audit.error(l_trace||'������ ��������� ��. �����. ���='||bars_xmlklb.G_DOC_REF);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    MAIN_ACC()
   --
   --    �� ������������ ������� ��������, ��������
   --    ����� �������� � ���� � ����� acc ��������� �����
   --
   --
   procedure main_acc(
            p_nls  out varchar2,
            p_acc  out number,
            p_kv   out number)
   is
      l_cntr  dpt_deposit.nd%type;
   begin
         main_acc( p_nls  => p_nls,
                   p_acc  => p_acc,
                   p_kv   => p_kv,
                   p_cntr => l_cntr);
   end;



   -----------------------------------------------------------------
   --    MAIN_NLS()
   --
   --    �� ������������ ������� ��������, ��������
   --    ����� �������� � ���� � ����� ���. ���� ��������� �����.
   --    ����� ��� ���������� ��������� ����� �������� ���������.
   --
   --
   function main_nls return varchar2
   is
      l_nls    varchar2(14);
      l_kv     number;
      l_acc    number;
      l_trace  varchar2(1000) := G_TRACE||'main_nls: ';
   begin

      main_acc(l_nls, l_acc, l_kv);
      return l_nls;

   end;


   -----------------------------------------------------------------
   --  ACRINT_NLS()
   --
   --    �� ������������ ������� ��������, ��������
   --    ���. ���� ����� ������. %%
   --    ����� ��� ���������� � �������� ��������.
   --
   --
   function acrint_nls return varchar2
   is
      l_nls     varchar2(14);
      l_kv      number;
      l_acc     number;
      l_acrint  number;
      l_trace   varchar2(1000) := G_TRACE||'acrint_nls: ';
   begin

      main_acc(l_nls, l_acc, l_kv);
      select acra into l_acrint
      from int_accn
      where acc = l_acc and id = 1;

      select nls into l_nls
      from  accounts
      where  acc = l_acrint;

      return l_nls;

   end;




   -----------------------------------------------------------------
   --    GET_DPT_OPERATION
   --
   --    ��������� ��� �������� � ��������� �� tt, ref
   --    ���� ��� �������� �� ������ � ���������� � ���.��������e DPTOP,
   --    ������� ��� �������� �� �������������� ��������� DPTOP � ��������� ��������
   --
   --
   function get_dpt_operation(p_tt  varchar2,
                              p_ref number  ) return smallint
   is
      l_dptop   number;
      l_dptops  operw.value%type;
   begin

      begin

         --���� �������� � ���. ���������
         select value into l_dptops
         from operw
         where tag = 'DPTOP' and ref = p_ref;

         l_dptop := to_number(l_dptops);

      exception when others then
         case
            when sqlcode = -01403 or sqlcode = 100  then  --no_data_found then
                 -- ������������� ��������  ��� �������� ��������
                 select val into l_dptop
                 from op_rules
                 where tt = p_tt and tag = 'DPTOP';
            when sqlcode = -1722 then  --invalid number
                 bars_error.raise_nerror(G_MODULE, 'DPTOP_NOT_NUMBER',l_dptops);
            else raise;
         end case;

      end;



      if l_dptop is null then
         -- ������� ��������� ������
         --��� �������� %s(����������) �� ����������� �������� ���.��������� DPTOP ��-���������
         bars_error.raise_error(G_MODULE, 35, bars_error.get_error_text(G_MODULE, 71, p_tt));
      end if;


      return l_dptop;


   exception when no_data_found then
      -- ������� ��������� ������
      --��� �������� %s(����������) �� ���������� ���.�������� DPTOP(��� ��������)
      bars_error.raise_error(G_MODULE, 35, bars_error.get_error_text(G_MODULE, 70, p_tt));
   end;



   -----------------------------------------------------------------
   --    PAY_DPT_PLAN_OPERATION
   --
   --    �������� �� ����� ��������, ������� ��������� �������� �������� �� �����
   --
   --    p_ref - ��� ���������,  ������� ��������, �� ��� �� �������
   --    p_tt  - ��� ��������
   --    p_sum - ����� ��������
   --    (���������� ���������� ���������������� � ����� ����� ������� ���-�� check_pay_�������2(35)permission)
   --
   procedure  pay_dpt_plan_operation
   is
   begin
      if ( G_CURR_DPT_OP   = 0 and
           G_IS_DPT_EXISTS = 1 and
           G_REF_DPT is not null) then

            gl.pay(2, G_REF_DPT, gl.bdate);

            delete from xml_refque where dpt_nd = G_CURR_DPT_ND;
      end if;
   end;







   -----------------------------------------------------------------
   --    CHECK_PAY_PERMISSION
   --
   --    ��������� �������, ������� ��������� ����������� ���������� ��������
   --    ��� ��������
   --
   --    p_ref - ��� ���������,  ������� ��������, �� ��� �� �������
   --    p_tt  - ��� ��������
   --    p_sum - ����� ��������
   --
   --
   procedure  check_pay_permission(
                  p_ref  number,
                  p_tt   varchar2,
                  p_sum  number)
   is
      l_dptop      smallint;
      l_dptid      number;
      l_trace      varchar2(1000) := G_TRACE||'check_pay_permission: ';
      l_cntr       dpt_deposit.nd%type;
      l_cntrval    operw.value%type;
      l_needcheck  operw.value%type;
      l_ret        smallint;
      l_ref        number;
      l_dptacc     number;
      l_ostb       number;
      l_ostc       number;
  begin

      /* ������ ���������� �������������� ��� ����,
         ��� � ��������� � ���������� ����� ����� �� �� ���������� ���������
      */



      G_CURR_DPT_OP   := null;
      G_IS_DPT_EXISTS := 0;
      G_REF_DPT       := null;
      G_CURR_DPT_ND   := null;

      -- ���� ��� �������� �� ������ � ���������� � ���.��������e DPTOP,
      -- ������� ��� �������� �� ��������������
      l_dptop := get_dpt_operation(p_tt, p_ref);

      G_CURR_DPT_OP   := l_dptop;

      bars_audit.trace(l_trace||' ��� �������� � ���������-'||l_dptop);


      begin
         -- ����� ����� ��������
         select value  into l_cntrval
         from   operw w
         where  w.ref = p_ref and w.tag = 'CNTR';

         -- �����-�� ����������� ����� ��������
	 if length(l_cntrval) > 35 then
             bars_error.raise_error('KLB', 190,  substr(l_cntrval,1,35) );
	 end if;

         l_cntr := l_cntrval;

      exception when no_data_found then
         bars_error.raise_error('KLB', 35,  bars_error.get_error_text(G_MODULE, 74, to_char(p_ref)) );
      end;


      G_CURR_DPT_ND := l_cntr;




      -- ������ dpt_id  ��� ��������
      begin

         select deposit_id, acc into l_dptid, l_dptacc
         from   dpt_deposit d
         where  d.nd  = l_cntr;

         -- ���� ���� �������, ����� ������ ������� ���-��
         -- ����� �������� ��-����� ������ ���������� ������,
         -- ������� ��� ������ ��� �������� ��������
         if l_dptop = 0 then
            begin

               select ref into l_ref
                 from xml_refque
                where dpt_nd = l_cntr;

               G_IS_DPT_EXISTS := 1;
               G_REF_DPT       := l_ref;

            exception when no_data_found then
               -- ������� ��� � � ������� ��� ����
               -- ���������� ��������� ������
               --
               -- ���������, ���� ��������� ����� ��� ������ �������� ���, �����
               -- ��� ������ �������� �������� ��������
               -- ������� ��������� ������ - ��� ��������� ������� �� �������� ����� (�������� ��� �������)
               --
               select ostb, ostc into l_ostb, l_ostc
                 from accounts a
                where acc = l_dptacc;

               if l_ostb<>0 or  l_ostc<>0 then
                   bars_error.raise_nerror('KLB', 'SUCH_DRECDPT_WASPAYED', l_cntr);
               else
                   bars_error.raise_error('KLB', 35,  bars_error.get_error_text(G_MODULE, 75, l_cntr) );
               end if;

            end;
         end if;

      exception when no_data_found then

         -- ��������� ����� (�������� ������� ��� �� ������)
         if l_dptop = 0 then
            --bars_error.raise_error('KLB', 35,  bars_error.get_error_text(G_MODULE, 75, l_cntr));
            --���� ������� ��� �� ������ - ��������� ���-� � �������
            insert into xml_refque(ref, dpt_nd) values(p_ref, l_cntr);
            return;
         else
            bars_error.raise_error('KLB', 56,  to_char(l_cntr), sys_context('bars_context','user_branch'));
         end if;

      end;

      -- �������� ����� �� ��������� �������� �� ������������
      begin
         select value  into l_needcheck
         from   operw w
         where  w.ref = p_ref and w.tag = 'DPTCH';
      exception when no_data_found then
         l_needcheck := '1';
      end;

      if l_needcheck = '0' then
         return;
      end if;

      -- ������ �-��� ���������� ����������, ���� �������� �� ������
      l_ret := dpt.check_oper_permission(
                 p_dptid   => l_dptid,
                 p_dptop   => l_dptop,
                 p_amount  => p_sum);

   exception when others then
      bars_audit.error(l_trace||' �������� '||p_tt||' �� ����� ���� ��������');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    ACCRUE_INTEREST_UPTODATE
   --
   --    ����������� ��������.
   --    1) ���� ���������� � ���������� ����� ������ � �����������
   --    2) �	��� ���������� � ��������� ������  ������ � �����������
   --
   --    p_doc - ��������� ���-�� ���������� �����
   --
   procedure  accrue_interest_uptodate(
              p_doc oper%rowtype)
   is
      l_trace     varchar2(1000) := G_TRACE||'accrue_interest_uptodate: ';
      l_nls       varchar2(14);
      l_acc       number;  -- ��� ���������
      l_datfrom   date;
      l_datto     date;
      l_frstdat   date;
      l_dat_stop  date;
      l_intsum    number;
      l_tt        tts.tt%type;
      l_acra      number;
      l_acrb      number;
      l_sround    number;
      l_apldat    date;
      l_kv        number;
      l_doc       oper%rowtype;
      l_cntr      dpt_deposit.nd%type;
      l_drecs     bars_xmlklb.array_drec;
   begin

      --p_doc.datd < gl.bd and p_doc.tt = G_TT_ADDITION then

      bars_audit.trace(l_trace||'� ������� p_doc.datd=');

      if p_doc.datd >= gl.bd then
         return;
      end if;


      bars_audit.trace(l_trace||'���� ���-�� '||to_char(p_doc.datd,'dd/mm/yyyy')||' < ����.����='||to_char(gl.bd,'dd/mm/yyyy')||'  - �������� ������������ %%' );

      main_acc(l_nls, l_acc, l_kv, l_cntr);


      l_datfrom := p_doc.datd + 1;

      -- ���� ������� ����������
      select min(fdat) into l_frstdat
      from saldoa
      where acc = l_acc;

      if l_datfrom <= l_frstdat then
         bars_audit.trace(l_trace||'���� ��������� ������ ��� ����� ���������� ������- �� �������� ������������ %%' );
         return;
      end if;


      -- ���� �� - ��� ���� ���������� ����������
      begin
         select acr_dat, nvl(s,0), acra,   acrb,   tt,   apl_dat,  kvb, stp_dat
         into   l_datto, l_sround, l_acra, l_acrb, l_tt, l_apldat, l_kv, l_dat_stop
         from   int_accn
         where  acc = l_acc and metr < 90 and id = 1;
      exception when no_data_found  then
         bars_error.raise_error('KLB', 57, to_char( l_acc));
      end;



      if l_datto is null then
         bars_audit.info(l_trace||'���� ���������� ���������� %% - �������');
         if l_dat_stop >  ((gl.bd - 1) + 1) then
            l_datto   :=  ((gl.bd - 1) + 1); -- ��� ����, ��� ���� ����� ������ ��������� ���� �� ����������
         else
            -- ���� ������� ��� ����������
            l_datto   :=  l_dat_stop;
         end if;
      end if;


      if l_datto > l_apldat  then
         bars_audit.info(l_trace||'���� ���������� ���������� ������ ���� ��������� �������, ������������ �� ���������');
         return;
      end if;


      if l_datfrom  > l_datto  then
         bars_audit.info(l_trace||'���� ��������� ������ ���� ���������� ���������, ������������ �� ���������');
         return;
      end if;


      bars_audit.info(l_trace||'������������ %% � '||to_char(l_datfrom,'dd/mm/yyyy')||' �� '||to_char(l_datto,'dd/mm/yyyy')||' �� ����� '||p_doc.s||' ��� ����� ���='||l_acc);

      -- ������������ ��������� �� ����� ����������
      acrn.p_int(
                  acc_  => l_acc,     -- ��� ��������� �����
                  id_   => 1,         -- ���������� �� �������. �������
                  dt1_  => l_datfrom, -- ����� �
                  dt2_  => l_datto,   -- ����� ��
                  int_  => l_intsum,  -- ����������� ����� ������������� ���������
                  ost_  => p_doc.s,   -- ����� ����������
                  mode_ => 0);        -- ������� �����

      bars_audit.info(l_trace||'������������� ���� = '||l_intsum);

      -- �������� �� ������. ����� ������� ���������� ����������� ����������




      -- �������� ������� ���������� ��� ������������ ����������
      l_sround := l_intsum - round(l_intsum,0);
      bars_audit.info(l_trace||'����������= '||l_intsum||' - '||round(l_intsum,0)||'='||l_sround);
      l_intsum := round(l_intsum);

      init_doc_fields_accrue(
                  p_doc      => l_doc,
                  p_accdoh   => l_acrb,
                  p_accint   => l_acra,
                  p_intsum   => l_intsum ,
                  p_tt       => l_tt,
                  p_kv       => l_kv,
                  p_nazn     => '������������� %% �� ������ '||l_cntr||' � '||to_char(l_datfrom,'dd/mm/yyyy')||' �� '||to_char(l_datto,'dd/mm/yyyy')
                  );


      bars_xmlklb.G_DOC_REF := l_doc.ref;

      -- �������� ���-�
      insert_doc(
                 p_doc      => l_doc,
                 p_dreclist => l_drecs);

      -- ��������� ��������
      pay_doc(l_doc);

      -- �������� ����� ����������

      update int_accn set s = l_sround
      where  acc = l_acc and id = 1;


      bars_audit.info(l_trace||'����� ���������� ��� ��� = '||l_acc||' ='||l_sround);

   exception when others then
      bars_audit.error(l_trace||'������ ������������ %%: '||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    GET_SOCCONTRACT()
   --
   --    ������� ���. �������
   --
   --    p_cntr   - ��������� ��������
   --
   procedure get_soccontract(
                  p_cntr  in out t_soccontract)
   is
      l_nd       varchar2(30);
      l_ndprv    varchar2(30);
      l_rnk      number;
      l_trace    varchar2(1000) := G_TRACE||'get_soccontract: ';
   begin
      dpt_social.create_contract(
             p_custid       => p_cntr.custid       ,
             p_soctypeid    => p_cntr.soctypeid    ,
             p_agencyid     => p_cntr.agencyid     ,
             p_contractnum  => p_cntr.contractnum  ,
             p_contractdate => p_cntr.contractdate ,
             p_cardaccount  => p_cntr.cardaccount  ,
             p_pensionnum   => p_cntr.pensionnum   ,
             p_details      => p_cntr.details      ,
             p_contractacc  => p_cntr.contractacc  ,
             p_contractid   => p_cntr.contractid   );


         -- �������� ����� ��������, ���� �� ������ �����������
         l_nd := substr(p_cntr.contractnum,  instr(p_cntr.contractnum,'/') + 1 );

         begin
            select val into l_ndprv
            from branch_parameters
            where tag = 'DPTNUM' and branch = sys_context('bars_context','user_branch');

            if l_ndprv < l_nd then
               update branch_parameters set val = l_nd
               where tag = 'DPTNUM' and branch = sys_context('bars_context','user_branch');
            end if;

         exception when no_data_found  then
            insert into branch_parameters(branch, tag, val)
            values(sys_context('bars_context','user_branch'), 'DPTNUM', l_nd);
         end;


   exception when others then
      bars_audit.error(l_trace||'������ �������� ��������: '||sqlerrm);
      raise;
   end;


   -----------------------------------------------------------------
   --    GET_AGREEMENT()
   --
   --    ������� ���. �����
   --
   --    p_dptagr   - ��������� ���� ����������
   --
   procedure get_agreement(p_dptagr    in out t_dptagreement)
   is
      l_nd       varchar2(30);
      l_ndprv    varchar2(30);
      l_rnk      number;
      l_trace    varchar2(1000) := G_TRACE||'get_agreement: ';
   begin


      dpt_web.create_agreement(
        p_dptid             => p_dptagr.agreement.dptid         ,      -- ������������� ��������
        p_agrmnttype        => p_dptagr.agreement.agrmnttype    ,      -- ��� ��
        p_initcustid        => p_dptagr.agreement.initcustid    ,      -- ���.� ���������� ��
        p_trustcustid       => p_dptagr.agreement.trustcustid   ,      -- ���.� 3-�� ����
        p_trustid           => p_dptagr.agreement.trustid       ,      -- ��� ������������� �� � 3-�� �����
        p_transferdpt       => p_dptagr.agreement.transferdpt   ,      -- ��������� �������� ��������
        p_transferint       => p_dptagr.agreement.transferint   ,      -- ��������� ������� ���������
        p_amountcash        => p_dptagr.agreement.amountcash    ,      -- ����� ����������/������ ���.
        p_amountcashless    => p_dptagr.agreement.amountcashless,      -- ����� ����������/������ ������.
        p_datbegin          => p_dptagr.agreement.datbegin      ,      -- ����� ���� ������ ��������
        p_datend            => p_dptagr.agreement.datend        ,      -- ����� ���� ��������� ��������
        p_ratereqid         => p_dptagr.agreement.ratereqid     ,      -- ��� ������� �� ��������� ������
        p_ratevalue         => p_dptagr.agreement.ratevalue     ,      -- ����� �������� %-��� ������
        p_ratedate          => p_dptagr.agreement.ratedate      ,      -- ���� ������ �������� ����� ������
        p_denomamount       => p_dptagr.agreement.denomamount   ,      -- ����� ������ �����
        p_denomcount        => p_dptagr.agreement.denomcount    ,      -- ���-�� ������ �����
        p_denomref          => p_dptagr.agreement.denomref      ,      -- ���.�������� �� ����� ������ �����
        p_comissref         => p_dptagr.agreement.comissref     ,      -- ���.�������� �� ���������� ��
        p_docref	    => p_dptagr.agreement.docref	,      -- ���. ��������� ����������/���������� ������
        p_comissreqid       => p_dptagr.agreement.comissreqid   ,      -- ��. ������� (-13 ����� �� �������)
        p_agrmntid          => p_dptagr.agreement.agrmntid      );     -- ������������� ��

   end;


   -----------------------------------------------------------------
   --    GET_CONTRACT()
   --
   --    ������� �������
   --
   --    p_indoc  - ������� ���-�
   --    p_cust   - ��������� �������
   --    p_dpt    - ��������� ��������
   --
   procedure get_contract(
                  p_cntr  in out t_contract)
   is
      l_nd       varchar2(30);
      l_nd1      number;
      l_ndprv   varchar2(300);
      l_ndprv1   number;
      l_rnk      number;
      l_trace    varchar2(1000) := G_TRACE||'get_contract: ';
   begin
      dpt_web.create_deposit(
         p_vidd          => p_cntr.vidd        ,
         p_rnk           => p_cntr.rnk         ,
         p_nd            => p_cntr.nd          ,
         p_sum           => p_cntr.dpt_sum     ,
         p_nocash        => 0,
         p_datz          => p_cntr.datz        ,
         p_namep         => p_cntr.namep       ,
         p_okpop         => p_cntr.okpop       ,
         p_nlsp          => p_cntr.nlsp        ,
         p_mfop          => p_cntr.mfop        ,
         p_fl_perekr     => p_cntr.fl_perekr   ,
         p_name_perekr   => p_cntr.name_perekr ,
         p_okpo_perekr   => p_cntr.okpo_perekr ,
         p_nls_perekr    => p_cntr.nls_perekr  ,
         p_mfo_perekr    => p_cntr.mfo_perekr  ,
         p_comment       => p_cntr.comment     ,
         p_dpt_id        => p_cntr.dpt_id      ,
         p_datbegin      => p_cntr.datbegin    ,
	 p_duration      => p_cntr.duration    ,
	 p_duration_days => p_cntr.duration_days );



         -- �������� ����� ��������, ���� �� ������ �����������
         bars_audit.trace(l_trace||'����� ��������: '||p_cntr.nd);
         l_nd := substr(p_cntr.nd,  instr(p_cntr.nd,'/') + 1 );
         begin
            l_nd1 := to_number(l_nd);
         exception when others then
            bars_error.raise_error(G_MODULE, 188, l_nd);
         end;


         begin
            select val into l_ndprv
            from   branch_parameters
            where  tag = 'DPTNUM' and branch = sys_context('bars_context','user_branch');

	    begin
                l_ndprv1 := to_number(l_ndprv);
	    exception when others then
               if sqlcode = -1722 then   -- invalid number
                  -- ������� ��������� ������
                   bars_error.raise_error(G_MODULE, 35, bars_error.get_error_text(G_MODULE, 189, l_ndprv));
               end if;
            end;

            if l_ndprv1 < l_nd1 then
               update branch_parameters set val = l_nd
               where tag = 'DPTNUM' and branch = sys_context('bars_context','user_branch');
            end if;

         exception when no_data_found  then
            insert into branch_parameters(branch, tag, val)
            values(sys_context('bars_context','user_branch'), 'DPTNUM', l_nd);
         end;



   exception when others then
      bars_audit.error(l_trace||'������ �������� ��������: '||sqlerrm);
      raise;
   end;


   -----------------------------------------------------------------
   --    GET_CUSTOMER()
   --
   --    ��������� �� ������� ������� ������� � ������ � ���������
   --    type_customer.clientid ��� rnk, ���� ���� ������ - �������
   --
   --    p_indoc  - ������� ���-�
   --    p_cust   - ��������� �������
   --    p_dpt    - ��������� ��������
   --
   procedure get_cutomer(
                  p_cust    in out t_customer)
   is
      l_trace     varchar2(1000) := G_TRACE||'get_customer: ';
   begin

      bars_audit.trace(l_trace||' p_cust.resid_code='||p_cust.resid_code);
      bars_audit.trace(l_trace||'1: '||p_cust.clientname||' 2:'||p_cust.client_name||' 3:'||p_cust.client_surname||' 4:'||p_cust.client_patr);

      dpt_web.p_open_vklad_rnk(
        p_clientname       => p_cust.clientname      ,
        p_client_name      => p_cust.client_name     ,
        p_client_surname   => p_cust.client_surname  ,
        p_client_patr      => p_cust.client_patr     ,
        p_country          => p_cust.country         ,
        p_index            => p_cust.pindex          ,
        p_obl              => p_cust.obl             ,
        p_district         => p_cust.district        ,
        p_settlement       => p_cust.settlement      ,
        p_adress           => p_cust.adress          ,
        p_fulladdress      => p_cust.fulladdress     ,
        p_clientcodetype   => p_cust.clientcodetype  ,
        p_clientcode       => p_cust.clientcode      ,
        p_doctype          => p_cust.doctype         ,
        p_docserial        => p_cust.docserial       ,
        p_docnumber        => p_cust.docnumber       ,
        p_docorg           => p_cust.docorg          ,
        p_docdate          => p_cust.docdate         ,
        p_clientbdate      => p_cust.clientbdate     ,
        p_clientbplace     => p_cust.clientbplace    ,
        p_clientsex        => p_cust.clientsex       ,
        p_clienthomeph     => p_cust.clienthomeph    ,
        p_clientworkph     => p_cust.clientworkph    ,
        p_clientname_gc    => p_cust.clientname_gc   ,
        p_resid_code       => p_cust.resid_code      ,
        p_resid_index      => p_cust.resid_index     ,
        p_resid_obl        => p_cust.resid_obl       ,
        p_resid_district   => p_cust.resid_district  ,
        p_resid_settlement => p_cust.resid_settlement,
        p_resid_adress     => p_cust.resid_adress    ,
        p_clientid         => p_cust.clientid        ,
        p_registrydate     => p_cust.registrydate    );

   end;


   -----------------------------------------------------------------
   --    PARSE_DPTCUST()
   --
   --    ��������� ���-� �������� ��� ����� �������
   --
   --    p_nd     - ���� ������ ������ /Body/DPT1/Client
   --    p_cust   - ��������� �������
   --
   procedure parse_dptcust(
                  p_nd             dbms_xmldom.DOMNode,
                  p_cust    in out t_customer)
   is
      l_tmp       varchar2(1000);
      l_ntmp      smallint;
      l_trace     varchar2(1000) := G_TRACE||'parse_dptcust: ';
   begin
      p_cust.client_name     := dbms_xslprocessor.valueOf(p_nd, 'ClientName/F_NAME/text()');
      p_cust.client_surname  := dbms_xslprocessor.valueOf(p_nd, 'ClientName/L_NAME/text()');
      p_cust.client_patr     := dbms_xslprocessor.valueOf(p_nd, 'ClientName/M_NAME/text()');
      p_cust.clientname      := substr(p_cust.client_surname ||' '||p_cust.client_name,1,38)||' '||dbms_xslprocessor.valueOf(p_nd, 'ClientName/M_NAME/text()');

      p_cust.country         := dbms_xslprocessor.valueOf(p_nd,        'Country/text()');
      p_cust.pindex          := substr(dbms_xslprocessor.valueOf(p_nd, 'Adress/FGIDX/text()'), 1,   5);
      p_cust.obl             := substr(dbms_xslprocessor.valueOf(p_nd, 'Adress/FGOBL/text()'), 1,  30);
      p_cust.district        := substr(dbms_xslprocessor.valueOf(p_nd, 'Adress/FGDST/text()'), 1,  30);
      p_cust.settlement      := substr(dbms_xslprocessor.valueOf(p_nd, 'Adress/FGTWN/text()'), 1,  30);
      p_cust.adress          := substr(dbms_xslprocessor.valueOf(p_nd, 'Adress/FGADR/text()'), 1, 100);

      p_cust.clientcodetype  := dbms_xslprocessor.valueOf(p_nd,   'TGR/text()');
      p_cust.clientcode      := dbms_xslprocessor.valueOf(p_nd,   'OKPO/text()');
      p_cust.doctype         := dbms_xslprocessor.valueOf(p_nd,   'PASSP/text()');
      p_cust.docserial       := dbms_xslprocessor.valueOf(p_nd,   'SER/text()');
      p_cust.docnumber       := dbms_xslprocessor.valueOf(p_nd,   'NUMDOC/text()');
      p_cust.docorg          := dbms_xslprocessor.valueOf(p_nd,   'ORGAN/text()');

      l_tmp                  := dbms_xslprocessor.valueOf(p_nd,   'PDATE/text()');
      p_cust.docdate         := bars_xmlklb.convert_to_date(l_tmp,'PDATE');
      l_tmp                  := dbms_xslprocessor.valueOf(p_nd,   'BDAY/text()');
      p_cust.clientbdate     := bars_xmlklb.convert_to_date(l_tmp,'BDAY');


      if p_cust.docdate <= p_cust.clientbdate then
         bars_error.raise_error(G_MODULE, 183, to_char(p_cust.docdate, 'dd/mm/yyyy'),  to_char(p_cust.clientbdate, 'dd/mm/yyyy'));
      end if;

      p_cust.clientbplace    := dbms_xslprocessor.valueOf(p_nd,   'BPLace/text()');
      p_cust.clientsex       := dbms_xslprocessor.valueOf(p_nd,   'Sex/text()');
      p_cust.clienthomeph    := dbms_xslprocessor.valueOf(p_nd,   'TELD/text()');
      p_cust.clientworkph    := dbms_xslprocessor.valueOf(p_nd,   'TELW/text()');
      p_cust.clientname_gc   := dbms_xslprocessor.valueOf(p_nd,   'PASSP/text()');

      l_tmp                  := dbms_xslprocessor.valueOf(p_nd,     'CodeAgent/text()');
      l_ntmp                 := bars_xmlklb.convert_to_number(l_tmp,'CodeAgent');
      p_cust.resid_code      := case l_ntmp when 5 then 1 else 0 end;


      p_cust.registrydate    :=  gl.bd;

   exception when others then
      bars_audit.error(l_trace||'������ ������� ���������� ��� �������');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;


   -----------------------------------------------------------------
   --    PARSE_DPT()
   --
   --    ��������� ���-� ��������
   --
   --    p_nd     - ���� ������ �������� /Body/DPT1
   --    p_dpt    - ��������� ��������
   --
   procedure parse_dpt(
                  p_nd            dbms_xmldom.DOMNode,
                  p_dpt    in out t_deposit)
   is
      l_tmp    varchar2(1000);
      l_nd     dbms_xmldom.DOMNode;
      l_trace  varchar2(1000) := G_TRACE||'parse_dpt: ';
      l_cust   t_customer;
      l_cntr   t_contract;
   begin

      bars_audit.trace(l_trace||'������ ������ ����� ���������');
      -- �������� ���������
      p_dpt.ref := dbms_xslprocessor.valueOf(p_nd, '@Ref');

      bars_audit.trace(l_trace||'�������� �������� ������-����� -'||p_dpt.ref);

      -- ������� �������
      l_nd    := dbms_xslprocessor.selectSingleNode(p_nd, 'Body_DPT1/DPT/Client');
      parse_dptcust(l_nd, l_cust);


      l_nd    := dbms_xslprocessor.selectSingleNode(p_nd, 'Body_DPT1/DPT/Contract');

      l_cntr.vidd           := dbms_xslprocessor.valueOf(l_nd,   'VIDD/text()');
      l_cntr.dpt_sum        := dbms_xslprocessor.valueOf(l_nd,   'SUM_DPT/text()');
      l_cntr.comment        := dbms_xslprocessor.valueOf(l_nd,   'Comm/text()');
      l_cntr.nd             := dbms_xslprocessor.valueOf(l_nd,   'DPN_NUM/text()');
      l_tmp                 := dbms_xslprocessor.valueOf(l_nd,   'DAT_S/text()');
      l_cntr.datbegin       := bars_xmlklb.convert_to_date(l_tmp,'DAT_S');
      l_cntr.datz           := l_cntr.datbegin;
      l_cntr.duration       := dbms_xslprocessor.valueOf(l_nd,   'DPT_MONTH/text()');
      l_cntr.duration_days  := dbms_xslprocessor.valueOf(l_nd,   'DPT_DAY/text()');


      p_dpt.customer := l_cust;
      p_dpt.contract := l_cntr;

      bars_audit.trace(l_trace||' ��� �������� -'||l_cntr.vidd||' �����-'||l_cntr.nd);

   exception when others then
      bars_audit.error(l_trace||'������ ������� ���������� ���  �������� ���='||p_dpt.ref);
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    PARSE_DPTAGREEMENT()
   --
   --    ��������� ���-� ������� �� ���. ����������
   --
   --    p_nd       - ���� ������ ������� �� ��� ����������  /Body/DPTD
   --    p_dptagr   - ��������� ���.����������
   --

   procedure parse_dptagreement(
                  p_nd         dbms_xmldom.DOMNode,
                  p_dptagr     in out t_dptagreement)
   is
      l_tmp     varchar2(1000);
      l_nd      dbms_xmldom.DOMNode;
      l_nd2     dbms_xmldom.DOMNode;
      l_trace   varchar2(1000) := G_TRACE||'parse_dptagreement: ';
      l_cust    t_customer;
      l_agr     t_agreement;
      l_atype number;
   begin

      bars_audit.trace(l_trace||'������ ������ ����� ���������');

      -- �������� ���������
      p_dptagr.ref := dbms_xslprocessor.valueOf(p_nd, '@Ref');
      bars_audit.trace(l_trace||'�������� �������� ������-����� -'||p_dptagr.ref);


      -- ������� �������
      l_nd    := dbms_xslprocessor.selectSingleNode(p_nd, 'Body_DPTD/DPT/Client');


      parse_dptcust(l_nd, l_cust);
      bars_audit.trace(l_trace||'��������� � ��������� �������� ����������� ����');

      l_nd    := dbms_xslprocessor.selectSingleNode(p_nd, 'Body_DPTD/DPT/DPT_AGREEMENT');
      l_nd2   := dbms_xslprocessor.selectSingleNode(p_nd, 'Body_DPTD/DPT/DPT_TRUSTEE');

      l_agr.dptid        := dbms_xslprocessor.valueOf(l_nd,   'CONTRACT_NUM/text()');   -- ������������� ��������
      l_agr.agrmnttype   := dbms_xslprocessor.valueOf(l_nd,   'AGRMNT_TYPE/text()');    -- ��� ��
      l_agr.initcustid   := dbms_xslprocessor.valueOf(l_nd,   'CUST_ID/text()');        -- ���.� ���������� ��


      bars_audit.trace(l_trace||' ��� ���. ����������:'||l_agr.agrmnttype||'  ������� �:'||l_agr.dptid ||' ��� ����������:'||l_agr.initcustid);


    /* dptid          dpt_agreements.dpt_id%type,          -- ������������� ��������
      agrmnttype      dpt_agreements.agrmnt_type%type,     -- ��� ��
      initcustid      dpt_deposit.rnk%type,                -- ���.� ���������� ��
      trustcustid     customer.rnk%type,                   -- ���.� 3-�� ����

      trustid         dpt_trustee.id%type,                 -- ��� ������������� �� � 3-�� �����
      transferdpt     CLOB,                                -- ��������� �������� ��������
      transferint     CLOB,                                -- ��������� ������� ���������
      amountcash      dpt_agreements.amount_cash%type,     -- ����� ����������/������ ���.
      amountcashless  dpt_agreements.amount_cashless%type, -- ����� ����������/������ ������.
      datbegin        dpt_agreements.date_begin%type,      -- ����� ���� ������ ��������
      datend          dpt_agreements.date_end%type,        -- ����� ���� ��������� ��������
      ratereqid       dpt_agreements.rate_reqid%type,      -- ��� ������� �� ��������� ������
      ratevalue       dpt_agreements.rate_value%type,      -- ����� �������� %-��� ������
      ratedate        dpt_agreements.rate_date%type,       -- ���� ������ �������� ����� ������
      denomamount     dpt_agreements.denom_amount%type,    -- ����� ������ �����
      denomcount      dpt_agreements.denom_count%type,     -- ���-�� ������ �����
      denomref        dpt_agreements.denom_ref%type,       -- ���.�������� �� ����� ������ �����
      comissref       dpt_agreements.comiss_ref%type,      -- ���.�������� �� ���������� ��
      docref	      dpt_agreements.DOC_REF%type,         -- ���. ��������� ����������/���������� ������
      comissreqid     dpt_agreements.comiss_reqid%type,    -- ��. �������
      agrmntid        dpt_agreements.agrmnt_id%type        -- ������������� ��


      dptid           dpt_agreements.dpt_id%type,          -- ������������� ��������
      agrmnttype      dpt_agreements.agrmnt_type%type,     -- ��� ��
      initcustid      dpt_deposit.rnk%type,                -- ���.� ���������� ��
      trustcustid     customer.rnk%type,                   -- ���.� 3-�� ����
      trustid         dpt_trustee.id%type,                 -- ��� ������������� �� � 3-�� �����
      transferdpt     CLOB,                                -- ��������� �������� ��������
      transferint     CLOB,                                -- ��������� ������� ���������
      amountcash      dpt_agreements.amount_cash%type,     -- ����� ����������/������ ���.
      amountcashless  dpt_agreements.amount_cashless%type, -- ����� ����������/������ ������.
      datbegin        dpt_agreements.date_begin%type,      -- ����� ���� ������ ��������
      datend          dpt_agreements.date_end%type,        -- ����� ���� ��������� ��������
      ratereqid       dpt_agreements.rate_reqid%type,      -- ��� ������� �� ��������� ������
      ratevalue       dpt_agreements.rate_value%type,      -- ����� �������� %-��� ������
      ratedate        dpt_agreements.rate_date%type,       -- ���� ������ �������� ����� ������
      denomamount     dpt_agreements.denom_amount%type,    -- ����� ������ �����
      denomcount      dpt_agreements.denom_count%type,     -- ���-�� ������ �����
      denomref        dpt_agreements.denom_ref%type,       -- ���.�������� �� ����� ������ �����
      comissref       dpt_agreements.comiss_ref%type,      -- ���.�������� �� ���������� ��
      docref	      dpt_agreements.DOC_REF%type,         -- ���. ��������� ����������/���������� ������
      comissreqid     dpt_agreements.comiss_reqid%type,    -- ��. �������
      agrmntid        dpt_agreements.agrmnt_id%type        -- ������������� ��

      */

      case

          when l_agr.agrmnttype = 2  then null;    -- ��������� ����� ��� ��i�� ����

          when l_agr.agrmnttype = 3  then null;    -- ��������� ����� ��� ��i�� �_�������� ������
               /*l_agr.trustcustid  := dbms_xslprocessor.valueOf(l_nd,   'DATE_BEGIN/text()');       -- ���.� 3-�� ����
	         l_agr.ratereqid    := dbms_xslprocessor.valueOf(l_nd,   'DATE_BEGIN/text()');       -- ��� ������� �� ��������� ������
                 l_agr.ratevalue    := dbms_xslprocessor.valueOf(l_nd,   'DATE_BEGIN/text()');       -- ����� �������� %-��� ������
	         l_agr.ratedate     := dbms_xslprocessor.valueOf(l_nd,   'DATE_BEGIN/text()');       -- ���� ������ �������� ����� ������
	         l_agr.agrmntid     := dbms_xslprocessor.valueOf(l_nd,   'AGRMNT_ID/text()');       -- ������������� ��
	        */

	  when l_agr.agrmnttype = 5            -- �������� ����� ��� 3� ��� - ���������
	    or l_agr.agrmnttype = 8  then null;

	  when l_agr.agrmnttype = 12 then         -- �������� ����� ��� ��������� - ���������

               l_tmp                  := dbms_xslprocessor.valueOf(l_nd,   'DATE_BEGIN/text()');  -- ����� ���� ������ ��������
               l_agr.datbegin         := bars_xmlklb.convert_to_date(l_tmp,'DATE_BEGIN');
               l_tmp                  := dbms_xslprocessor.valueOf(l_nd,   'DATE_END/text()');    -- ����� ���� ��������� ��������
               l_agr.datend           := bars_xmlklb.convert_to_date(l_tmp,'DATE_END');
               l_agr.agrmntid         := dbms_xslprocessor.valueOf(  l_nd, 'AGRMNT_ID/text()');   -- ������������� ��
               l_agr.comissreqid      := -13;                                                     -- ��. ������� �� �������� (����� ��� �� �����)


          when l_agr.agrmnttype = 6                -- �������� ����� ��� 3� ��� - ���������� + ����� � �����
	    or l_agr.agrmnttype = 9
	    or l_agr.agrmnttype = 13
	    or l_agr.agrmnttype = 7  then

               l_agr.trustid     := dbms_xslprocessor.valueOf(l_nd2, 'UNDO_ID');   -- � ������������� ��
               l_agr.trustcustid := dbms_xslprocessor.valueOf(l_nd2, 'RNK_TR');    -- ��� � 3-�� ����



                /*
               "begin dpt_web.create_agreement " +
                " (:dpt_id,:agr_id,:init_cust_id,:p_trustcustid,:p_trustid, " +
                " null,null,null,null,null,null,null,null,null,null,null,null,:ref,null,:req_num, " +
                " :p_agrmntid " +
                " ); " +
                "end;";


*/

          when l_agr.agrmnttype = 10               -- ������������� �� ������ / ������� �������
	    or l_agr.agrmnttype = 11 then null;

          when l_agr.agrmnttype = 14 then null;    -- ��������� ����� ��� ������ �� ����� �������� �����
          when l_agr.agrmnttype = 21 then null;    -- ����������
	  else
	      bars_error.raise_nerror(G_MODULE, 'NOT_AGREEMENT_TYPE', to_char(l_agr.agrmnttype));
      end case;

      p_dptagr.customer  := l_cust;
      p_dptagr.agreement := l_agr;

   exception when others then
      bars_audit.error(l_trace||'������ ������� ���������� ���  �������� ');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    PARSE_SOCDPT()
   --
   --    ��������� ���-� ���. ��������
   --
   --    p_nd     - ���� ������ �������� /Body/DPT2
   --    p_dpt    - ��������� ��������
   --
   procedure parse_socdpt(
                  p_nd            dbms_xmldom.DOMNode,
                  p_dpt    in out t_socdeposit)
   is
      l_tmp       varchar2(1000);
      l_nd     dbms_xmldom.DOMNode;
      l_trace     varchar2(1000) := G_TRACE||'parse_socdpt: ';
      l_cust      t_customer;
      l_cntr      t_soccontract;
   begin

      bars_audit.trace(l_trace||'������ ������ ����� ���������');
      -- �������� ���������
      p_dpt.ref := dbms_xslprocessor.valueOf(p_nd, '@Ref');
      bars_audit.trace(l_trace||'�������� �������� ������-����� -'||p_dpt.ref);

      -- ������� �������
      l_nd    := dbms_xslprocessor.selectSingleNode(p_nd, 'Body_DPT2/DPT/Client');
      parse_dptcust(l_nd, l_cust);


      l_nd    := dbms_xslprocessor.selectSingleNode(p_nd, 'Body_DPT2/DPT/Contract');


      l_cntr.soctypeid    := dbms_xslprocessor.valueOf(l_nd,   'TYPE_ID/text()');
      l_cntr.agencyid     := dbms_xslprocessor.valueOf(l_nd,   'AGENCY_ID/text()');
      l_cntr.contractnum  := dbms_xslprocessor.valueOf(l_nd,   'CONTRACT_NUM/text()');

      l_tmp               := dbms_xslprocessor.valueOf(l_nd,   'CONTRACT_DATE/text()');
      l_cntr.contractdate := bars_xmlklb.convert_to_date(l_tmp,'CONTRACT_DATE');
      l_cntr.cardaccount  := dbms_xslprocessor.valueOf(l_nd,   'CARD_ACCOUNT/text()');
      l_cntr.pensionnum   := dbms_xslprocessor.valueOf(l_nd,   'PENSION_NUM/text()');
      l_cntr.details      := dbms_xslprocessor.valueOf(l_nd,   'DETAILS/text()');

      p_dpt.customer := l_cust;
      p_dpt.contract := l_cntr;

      bars_audit.trace(l_trace||' ��� �������� -'||l_cntr.soctypeid||' �����-'||l_cntr.contractnum);

   exception when others then
      bars_audit.error(l_trace||'������ ������� ���������� ��� ���. �������� ');
      bars_audit.error(l_trace||sqlerrm);
      raise;

   end;






   -----------------------------------------------------------------
   --    INIT_DOC_FIELDS_1ST_PAY()
   --
   --    ������������������� ���� ���-�� ��� ��������������� ������
   --    �� ���������� ������
   --
   --    p_doc     - ��������
   --    p_drec    - ���. ���������
   --    p_dpt     - ��������� ��������
   --    p_seckey  - ���� ��������� ��������
   --
   procedure init_doc_fields_1st_pay(
                  p_doc     in out oper%rowtype,
                  p_dpt            t_deposit,
                  p_seckey         varchar2)
   is
      l_trace     varchar2(1000)   := G_TRACE||'init_doc_fields_1stpay: ';
      l_maintt    char(3) := 'KB8';
   begin

      begin
         select a.nls,        a.kv,   d.dat_begin, c.okpo
           into p_doc.nlsb, p_doc.kv, p_doc.vdat,  p_doc.id_b
           from dpt_deposit d, accounts a, customer c
          where a.acc = d.acc
	    and d.deposit_id = p_dpt.contract.dpt_id
            and d.rnk = c.rnk;
      exception when no_data_found then
         bars_error.raise_error('KLB', 52, to_char(p_dpt.contract.dpt_id));
      end;

      bars_audit.trace(l_trace||'�������� nlsb='||p_doc.nlsb||' vdat='||to_date(p_doc.vdat,'dd/mm/yyyy'));
      p_doc.tt    := l_maintt;
      p_doc.dk    := 1;
      p_doc.s     := p_dpt.contract.dpt_sum;
      p_doc.s2    := p_doc.s;
      p_doc.kv2   := p_doc.kv;

      p_doc.mfoa  := gl.amfo;
      p_doc.mfob  := gl.amfo;

      bars_audit.trace(l_trace||'before getTOBOParam TRDPT: branch'||sys_context('bars_context','user_branch'));
      bars_audit.trace(l_trace||'before getTOBOParam TRDPT: context_mfo'||bars_context.extract_mfo);
      bars_audit.trace(l_trace||'before getTOBOParam TRDPT: aMFO'||gl.aMFO);

      p_doc.nlsa  := tobopack.GetTOBOParam('TRDPT');

      bars_audit.trace(l_trace||'����� nlsa ='||p_doc.nlsa);

      if p_doc.nlsb is null or p_doc.nlsb ='' then
         bars_error.raise_error('KLB', 53);
      end if;

      p_doc.datd  := p_doc.vdat;
      p_doc.pdat  := p_doc.vdat;
      p_doc.nd    := substr(p_dpt.contract.nd,-10);

      bars_audit.info(l_trace||'��������� ������ �� ���.����i �'||p_dpt.contract.nd||' �i� ����. � ���������: '||p_doc.nd);
      if p_doc.nd is null then
         p_doc.nd   := to_char(sysdate, 'hh24:mi');
      end if;

      p_doc.id_a  := gl.aokpo;
      p_doc.nazn  := '��������� ������ �� ���.����i �'||p_dpt.contract.nd||' �i� ����';
      p_doc.id_o  := p_seckey;
      p_doc.vob   := 1;

      bars_audit.trace(l_trace||'������� ������������ ������� nam_a:');

      begin
         select nmkk into p_doc.nam_a
         from customer c, accounts a
         where c.rnk = a.rnk and a.nls = p_doc.nlsa and a.kv = p_doc.kv;
      exception when no_data_found then
         -- ������ ������� ���������� - KLB - 35
         bars_error.raise_error('KLB', 35,
              bars_error.get_error_text('KLB', 58,  p_doc.nlsa||'('||to_char(p_doc.kv)||')', sys_context('bars_context','user_branch'))
                                );
      end;


      bars_audit.trace(l_trace||'����� ������������ �������:'||p_doc.nam_a);

      begin
         select nmkk into p_doc.nam_b
         from customer c, accounts a
         where c.rnk = a.rnk and a.nls = p_doc.nlsb and a.kv = p_doc.kv;
      exception when no_data_found then
         bars_error.raise_error('KLB', 54, p_doc.nlsb||'('||to_char(p_doc.kv)||')');
      end;


   exception when others then
      bars_audit.error(l_trace||'������ ������������� ����� ���-�� ��� ������ ���������� ������ '||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    INIT_DRECS()
   --
   --    ���������������� ���. ���������
   --
   --    p_drecs    -  ������ ���. ����������
   --    p_dpt      -  ��������� ��������
   --    p_packname -  ��� ��������� ������
   --
   procedure init_drecs(
                  p_dreclist  in out bars_xmlklb.array_drec,
                  p_dpt              t_deposit,
                  p_packname         varchar2)
   is
   begin

      p_dreclist.delete;

      -- ���. ������. �����
      p_dreclist(0).tag := 'CLBRF';
      p_dreclist(0).val := p_dpt.ref;

      -- ��� ������
      p_dreclist(1).tag := 'KLBXF';
      p_dreclist(1).val := p_packname;

      -- ����� �������� � ����
      p_dreclist(2).tag := 'CNTR';
      p_dreclist(2).val := p_dpt.contract.nd;

      -- ��� �������� - �������
      p_dreclist(3).tag := 'DPTPR';
      p_dreclist(3).val := 'DPT1';

   end;








   -----------------------------------------------------------------
   --    PROCRESS_DOC()
   --
   --    �������� �������������� ����� �� ���. ������.
   --    �������� � �������� �� �������� ���� ������ ��-�����
   --
   --    p_pack    -  �������� ������ ���������
   --    p_gateid  - ����� ��������� ���������
   --    p_reply   - ��������� ���������
   --    p_seckey  - �������� kltoss
   --
   --    return number - �������� ���������
   --
   function process_doc(
                  p_dpt       t_deposit,
                  p_seckey    varchar2,
                  p_packname  varchar2) return number
   is
      l_doc       oper%rowtype;
      l_dreclist  bars_xmlklb.array_drec;
      l_trace     varchar2(1000)   := G_TRACE||'process_doc: ';
   begin

      -- ���������������� ���� ���-��
      init_doc_fields_1st_pay(
                  p_doc     => l_doc,
                  p_dpt     => p_dpt,
                  p_seckey  => p_seckey);

      -- ���������������� ���. ��������� ��� ���-��
      init_drecs(
                  p_dreclist => l_dreclist,
                  p_dpt      => p_dpt,
                  p_packname => p_packname);


      -- �������� ����� ��� ���-��
      gl.ref(l_doc.ref);

      bars_xmlklb.G_DOC_REF := l_doc.ref;

      -- �������� ���-�
      insert_doc(
                 p_doc      => l_doc,
                 p_dreclist => l_dreclist);

      pay_doc(l_doc);

      return l_doc.ref;

   end;



   -----------------------------------------------------------------
   --    ADD_CURSORDATA_TO_NODE
   --
   --    �������� ������ ��������� ��� �������
   --    � ������������ ���� ��������� ��� �����. ����� ����������� �������� � ���� ��� ������� �� ���������
   --
   --    p_doc       - ��������
   --    p_nddpt     - ���� �������� �������� ��� �������
   --    p_cur       - ������
   --    p_tag       - ������������ ����
   --    p_attrname  - �������
   --    p_attrval   - ������� ��������
   --
   procedure add_cursordata_to_node(
                 p_doc       in out dbms_xmldom.DOMDocument,
                 p_nddpt     in out dbms_xmldom.DOMNode,
                 p_cur       sys_refcursor,
                 p_tag       varchar2,
		 p_attrname  varchar2 default null,
		 p_attrval   varchar2 default null)
   is
      l_ctx        dbms_xmlquery.ctxhandle;
      l_srcdoc     dbms_xmldom.DOMDocument;
      l_srcnd      dbms_xmldom.DOMNode;
      l_nd         dbms_xmldom.DOMNode;
      l_curdata    clob;
      l_attr       dbms_xmldom.DOMattr;
      l_trace     varchar2(1000)   := G_TRACE||'add_cursordata_to_node: ';
   begin

      l_ctx := dbms_xmlgen.newcontext(p_cur);
      dbms_xmlgen.setrowsettag(l_ctx, p_tag);
      dbms_xmlgen.setrowtag(l_ctx, 'rowtag');

      dbms_lob.createtemporary(l_curdata, false);
      dbms_xmlgen.getxml(l_ctx, l_curdata);

      l_srcdoc    :=  bars_xmlklb.parse_clob(l_curdata);
      l_srcnd     :=  dbms_xmldom.makeNode(dbms_xmldom.getDocumentElement(l_srcdoc));

      l_nd        :=  dbms_xmldom.importNode(p_doc, l_srcnd, true);
      l_nd        :=  dbms_xmldom.appendChild(p_nddpt, l_nd);


      if p_attrname is not null then
         l_attr      := dbms_xmldom.createAttribute(p_doc,p_attrname);
                        dbms_xmldom.setValue(l_attr, p_attrval);
         l_attr      := dbms_xmldom.setAttributeNode( dbms_xmldom.makeElement(l_nd), l_attr);
      end if;


      -- �������
      if dbms_lob.istemporary(l_curdata)  = 1 then
         dbms_lob.freetemporary(l_curdata);
      end if;
      dbms_xmldom.freedocument(l_srcdoc);

   exception when others then
      if dbms_lob.istemporary(l_curdata)  = 1 then
         dbms_lob.freetemporary(l_curdata);
      end if;

      if not dbms_xmldom.isnull(l_srcdoc) then
         dbms_xmldom.freedocument(l_srcdoc);
      end if;

      bars_audit.error(l_trace||'������ ���������� ������ ������� � ����');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;



   -----------------------------------------------------------------
   --    INSERT_GENERALDPT_INFO
   --
   --    ������� ���������� �� �������� � �����
   --
   --    p_doc    - ��������
   --    p_nddpt  - ���� � ���������
   --    p_nd     - ����� ��������
   --    p_dptid  - ��������, ���������� ����� �������� � ����-�
   --    p_rnk    - ��� �������, �� ���. ������ �������
   --    p_acc    - ��� ��������� ������ (����������� ������ ��� ���. ���������)
   --
   procedure insert_generaldpt_info(
                  p_doc      in out dbms_xmldom.DOMDocument,
                  p_nddpt    in out dbms_xmldom.DOMNode,
                  p_nd       varchar2,
                  p_dpttag   varchar2,
                  p_dptid    number,
                  p_rnk      number,
                  p_acc      number)
   is
      l_trace    varchar2(1000) := G_TRACE||'insert_generaldpt_info: ';
      l_elem     dbms_xmldom.DOMElement;
      l_ndmsg    dbms_xmldom.DOMNode;
      l_nd       dbms_xmldom.DOMNode;
      l_cur      sys_refcursor;
      l_sql      varchar2(2000);
      l_acc      number;
      l_accr     number;
      l_rnk      number;
      l_kv       number;
      l_nls      varchar2(14);
      l_proc     number;
   begin

      bars_audit.trace(l_trace||'������ ���������� ���������� � �������� :'||p_nd);

      l_elem    := dbms_xmldom.createElement(p_doc,  p_dpttag );
      l_ndmsg   := dbms_xmldom.makeNode(l_elem);
      l_nd      := dbms_xmldom.appendChild(p_nddpt, l_ndmsg);


     if p_acc is null then
        -- ������� �������
        select d.acc, i.acra, d.rnk
          into l_acc, l_accr, l_rnk
          from dpt_deposit d, int_accn i
         where deposit_id = p_dptid
           and d.acc = i.acc and i.id = 1;
     else
        l_acc  := p_acc;
        l_rnk  := p_rnk;

        select acra  into l_accr
        from   int_accn
        where  acc = l_acc and id = 1;

     end if;


      bars_xmlklb.set_tag_value(p_doc, l_nd, 'dpt_num', p_nd);
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'dpt_id' , p_dptid);

      -- ������� ����
     select a.kv,  a.nls
       into l_kv, l_nls
       from accounts a
      where a.acc = l_acc;

      bars_xmlklb.set_tag_value(p_doc, l_nd, 'main_acc', to_char(l_acc));
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'main_nls', l_nls);
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'main_kv' , to_char(l_kv));

      -- ����� %%
     select a.kv,  a.nls
       into l_kv, l_nls
       from accounts a
      where a.acc = l_accr;

      bars_xmlklb.set_tag_value(p_doc, l_nd, 'acr_acc', to_char(l_accr));
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'acr_nls', l_nls);
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'acr_kv' , to_char(l_kv));

--      l_proc := dpt.fproc(l_acc, p_contract.datbegin);
      l_proc := dpt.fproc(l_acc, gl.bd);

      bars_audit.trace(l_trace||'to_char = '||to_char(l_proc)||' - '||to_char(l_proc));

      bars_xmlklb.set_tag_value(p_doc, l_nd, 'proc', to_char(l_proc ));
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'rnk' , l_rnk);



     l_sql := ' select rnk, tgr, custtype, country, nmk, nmkv, nmkk, codcagent,                           '||
              ' prinsider, okpo, adr, sab, c_reg, c_dst, rgtax, to_char(datet,''yyyy-mm-dd'') datet ,     '||
              ' adm, to_char(datea,''yyyy-mm-dd'') datea, stmt,  to_char(date_on,''yyyy-mm-dd'') date_on, '||
              ' to_char(date_off,''yyyy-mm-dd'') date_off, notes,notesec, crisk, pincode, nd,             '||
              ' rnkp, ise, fs, oe, ved, sed, lim, mb, rgadm, bc, branch, tobo, isp, taxf, nompdv          '||
              ' from customer where rnk = :1 ' ;

      open  l_cur for l_sql using l_rnk;

      add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'customer');

      close l_cur;


     l_sql := ' select rnk, tag, value from  bars.customerw where rnk = :1 ' ;

      open  l_cur for l_sql using l_rnk;

      add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'customerw');

      close l_cur;


      -- ��������� ���. ������� (����������� ����)
      l_sql := ' select p.rnk, p.sex, p.passp, p.ser, p.numdoc,   '||
               '        to_char(p.pdate,''yyyy-mm-dd'') pdate,    '||
               '        to_char(p.bday,''yyyy-mm-dd'')  bday,     '||
               '        p.organ,  p.bplace, p.teld, p.telw, p.dov,'||
               '        to_char(p.bdov,''yyyy-mm-dd'')  bdov,     '||
               '        to_char(p.edov ,''yyyy-mm-dd'') edov      '||
               ' from  bars.person p                              '||
               ' where rnk = :1';
       open  l_cur for l_sql using l_rnk;

       add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'person');
      close l_cur;



      l_sql := ' select acc, nls, kv, nbs, to_char(daos, ''yyyy-mm-dd'') daos,   '||
               '        to_char(dapp,''yyyy-mm-dd'') dapp, nms, lim, ostb, ostc, '||
               '        ostf, ostq, dos, kos, dosq, kosq, pap,                   '||
               '        to_char(dazs,''yyyy-mm-dd'') dazs,  blkd, blkk, tip, rnk '||
               ' from saldo where acc in (:1, :2) ';

      open  l_cur for l_sql using l_acc, l_accr;

      add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'accounts');
      close l_cur;


   exception when others then

      if l_cur%isopen then
         close l_cur;
      end if;

      bars_audit.error(l_trace||'������ ���������� ���������� � ����� �� ��������:');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;




   -----------------------------------------------------------------
   --    INSERT_DPTAGREEMENT_INFO
   --
   --    ������� ���������� �� ���.���������� � � �����
   --
   --    p_doc    - ��������
   --    p_nddpt  - ���� � ���������
   --    p_nd     - ����� ��������
   --    p_dpttag - (DPTD - ��� ������� ���������, DPTS - ��� ���.)
   --    p_agr    - ��������� ���. ����������
   --


   procedure insert_dptagreement_info(
                  p_doc      in out dbms_xmldom.DOMDocument,
                  p_nddpt    in out dbms_xmldom.DOMNode,
                  p_dpttag   varchar2,
                  p_agr      t_agreement)
   is
      l_trace    varchar2(1000) := G_TRACE||'insert_dptagreement_info: ';
      l_elem     dbms_xmldom.DOMElement;
      l_ndmsg    dbms_xmldom.DOMNode;
      l_nd       dbms_xmldom.DOMNode;
      l_cur      sys_refcursor;
      l_sql      varchar2(2000);
      l_dptnd    dpt_deposit.nd%type;
   begin

      bars_audit.trace(l_trace||'������ ���������� ���������� � ���. ����������');

      l_elem    := dbms_xmldom.createElement(p_doc,  p_dpttag );
      l_ndmsg   := dbms_xmldom.makeNode(l_elem);
      l_nd      := dbms_xmldom.appendChild(p_nddpt, l_ndmsg);


      begin
          select nd into l_dptnd
          from dpt_deposit where deposit_id = p_agr.dptid;
      exception when no_data_found then
         bars_error.raise_error(G_MODULE,182, to_char(p_agr.dptid));
      end;

      bars_xmlklb.set_tag_value(p_doc, l_nd, 'dpt_num', l_dptnd);
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'dpt_id' , p_agr.dptid);

      bars_audit.trace(l_trace||'�������� �������� ��������� ���: '||p_agr.trustcustid);

      -- ��������� ������� (����������� ����)
      l_sql := ' select c.rnk, tgr, custtype, country, nmk, nmkv, nmkk, codcagent, '||
               '        prinsider, okpo, adr, sab, c_reg, c_dst, rgtax,            '||
               '        to_char(datet,''yyyy-mm-dd'') datet, adm,                  '||
               '        to_char(datea,''yyyy-mm-dd'') datea, stmt,                 '||
               '        to_char(date_on,''yyyy-mm-dd'') date_on,                   '||
               '        to_char(date_off,''yyyy-mm-dd'') date_off, notes,          '||
               '        notesec, crisk, pincode, nd, rnkp, ise, fs, oe, ved, sed,  '||
               '        lim, mb, rgadm, bc, branch, tobo, isp, taxf, nompdv        '||
               '  from  bars.customer c                                            '||
               '  where c.rnk = :1';

       open l_cur for l_sql using p_agr.trustcustid;
       bars_audit.trace(l_trace||'������ ������');



       add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'customer');

       close l_cur;
       bars_audit.trace(l_trace||'�������� ������ �� ������� (CUSTPOMER)');

      -- ��������� ���. ������� (����������� ����)
      l_sql := ' select p.rnk, p.sex, p.passp, p.ser, p.numdoc,   '||
               '        to_char(p.pdate,''yyyy-mm-dd'') pdate,    '||
               '        to_char(p.bday,''yyyy-mm-dd'')  bday,     '||
               '        p.organ,  p.bplace, p.teld, p.telw, p.dov,'||
               '        to_char(p.bdov,''yyyy-mm-dd'')  bdov,     '||
               '        to_char(p.edov ,''yyyy-mm-dd'') edov      '||
               ' from  bars.person p                              '||
               ' where rnk = :1';
       open  l_cur for l_sql using p_agr.trustcustid;
       bars_audit.trace(l_trace||'������ ������');


       add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'person');
       close l_cur;
       bars_audit.trace(l_trace||'�������� ������ �� �������-���. ���� (PERSON)');

      -- ��������� ���������c��
      l_sql := ' select id, dpt_id, typ_tr, rnk_tr, rnk, add_num,    '||
               '        to_char(add_dat,''yyyy-mm-dd'') add_dat,     '||
               '        fl_act, undo_id, branch                      '||
               ' from   dpt_trustee                                  '||
               ' where  dpt_id = :1 and id = (select trustee_id      '||
               '                                from dpt_agreements  '||
               '                               where agrmnt_id = :2) ';

      open  l_cur for l_sql using p_agr.dptid, p_agr.agrmntid;

      bars_audit.trace(l_trace||'������ ������.'||' ����� � ���. ����������: '||p_agr.agrmntid);

      add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'trustee');
       close l_cur;
       bars_audit.trace(l_trace||'�������� ������ �� �������������(DPT_TRUSTEE)');


       l_sql := ' select rnk, tag, value from  bars.customerw where rnk = :1 ' ;

       open  l_cur for l_sql using p_agr.trustcustid;

       add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'customerw');

       close l_cur;



   exception when others then

      if l_cur%isopen then
         close l_cur;
      end if;

      bars_audit.error(l_trace||'������ ���������� ���������� � ����� �� ��������:');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;




   -----------------------------------------------------------------
   --    INSERT_DPT_INFO
   --
   --    ������� ���������� �� �������� �������� � �����
   --
   --
   procedure insert_dpt_info(
                  p_doc      in out dbms_xmldom.DOMDocument,
                  p_nddpt    in out dbms_xmldom.DOMNode,
                  p_contract t_contract)
   is
   begin
      insert_generaldpt_info(
           p_doc     => p_doc,
           p_nddpt   => p_nddpt,
           p_nd      => p_contract.nd,
           p_dpttag  => 'DPT1',
           p_dptid   => p_contract.dpt_id,
           p_rnk     => p_contract.rnk,
           p_acc     => null);
   end;


   -----------------------------------------------------------------
   --    INSERT_SOCDPT_INFO
   --
   --    ������� ���������� �� ���. �������� � �����
   --
   --
   procedure insert_socdpt_info(
                  p_doc      in out dbms_xmldom.DOMDocument,
                  p_nddpt    in out dbms_xmldom.DOMNode,
                  p_contract t_soccontract)
   is
   begin
      insert_generaldpt_info(
           p_doc     => p_doc,
           p_nddpt   => p_nddpt,
           p_nd      => p_contract.contractnum,
           p_dpttag  => 'DPT2',
           p_dptid   => p_contract.contractid ,
           p_rnk     => p_contract.custid,
           p_acc     => p_contract.contractacc);
   end;



   ------------------------------------------------------
   --   CREATE_DPT_REPLY()
   --
   --   �������� ���������
   --   � ��������� ErrorCode � ErrorDetail, ���� errcode = '0000',
   --
   --   p_errcode     - ��� ������  (��������� ����� �� err_klb.err)
   --   p_errdetail   - �������� ������
   --   p_clbref      - ��� ��-�����
   --   p_doc         - ��������� ���-� ������
   --
   procedure create_dpt_reply(
                   p_errcode          varchar2,
                   p_errdetail        varchar2,
                   p_contract         t_contract,
                   p_clbref           number,
                   p_doc       in out dbms_xmldom.DOMDocument)
   is
      l_trace    varchar2(1000) := G_TRACE||'create_dpt_reply: ';
      l_nddpt    dbms_xmldom.DOMNode;
   begin


      bars_xmlklb.create_reply(
                   p_errcode    => p_errcode  ,
                   p_errdetail  => p_errdetail,
                   p_clbref     => p_clbref   ,
                   p_refnode    => l_nddpt    ,
                   p_doc        => p_doc      );

   -- �������� ���������� �� ��������
   if (p_errcode = '0000') then
          insert_dpt_info(
                  p_doc      => p_doc,
                  p_nddpt    => l_nddpt,
                  p_contract => p_contract);

   end if;

   exception when others then
      bars_audit.error(l_trace||'������ ������������ ������:'||sqlerrm);
      raise;
   end;





   ------------------------------------------------------
   --   CREATE_DPTAGREEMENT_REPLY()
   --
   --   �������� ��������� ��� ������� �� �������� ���. ����������
   --   � ��������� ErrorCode � ErrorDetail, ���� errcode = '0000',
   --
   --   p_errcode     - ��� ������  (��������� ����� �� err_klb.err)
   --   p_errdetail   - �������� ������
   --   p_message     - (DPTD - ��� ������� ���������, DPTS - ��� ���.)
   --   p_dptagr      - ��������� ���. ����������
   --   p_doc         - ��������� ���-� ������
   --
   procedure create_dptagreement_reply(
                   p_message      varchar2,
                   p_errcode      varchar2,
                   p_errdetail    varchar2,
                   p_dptagr       t_dptagreement,
                   p_doc       in out dbms_xmldom.DOMDocument)
   is
      l_trace    varchar2(1000) := G_TRACE||'create_dptagreement_reply: ';
      l_nddpt    dbms_xmldom.DOMNode;
   begin


      bars_xmlklb.create_reply(
                   p_errcode    => p_errcode  ,
                   p_errdetail  => p_errdetail,
                   p_clbref     => p_dptagr.ref ,
                   p_refnode    => l_nddpt    ,
                   p_doc        => p_doc      );

   -- �������� ���������� �� ��������
   if (p_errcode = '0000') then
          insert_dptagreement_info(
                  p_doc      => p_doc,
                  p_nddpt    => l_nddpt,
                  p_dpttag   => p_message,
                  p_agr      => p_dptagr.agreement);

   end if;

   exception when others then
      bars_audit.error(l_trace||'������ ������������ ������:'||sqlerrm);
      raise;
   end;






   -----------------------------------------------------------------
   --    INSERT_GETDPT_INFO
   --
   --    �������� ���������� �� ������� �� ����?��� �������� ��� ��������� ������
   --
   --
   procedure insert_getdpt_info(
                  p_message     varchar2,
                  p_doc      in out dbms_xmldom.DOMDocument,
                  p_nddpt    in out dbms_xmldom.DOMNode,
                  p_getdpt      t_getdeposit)
   is
      l_trace    varchar2(1000) := G_TRACE||'insert_getdpt_info: ';
      l_elem     dbms_xmldom.DOMElement;
      l_ndmsg    dbms_xmldom.DOMNode;
      l_nd       dbms_xmldom.DOMNode;
      l_cur      sys_refcursor;
      l_sql      varchar2(2000);
      l_nls      varchar2(14);
      l_nlsr     varchar2(14);
      l_scn      number;
   begin

      bars_audit.trace(l_trace||'������ ���������� ���������� � �������');

      l_elem    := dbms_xmldom.createElement(p_doc, upper(p_message));
      l_ndmsg   := dbms_xmldom.makeNode(l_elem);
      l_nd      := dbms_xmldom.appendChild(p_nddpt, l_ndmsg);

      bars_xmlklb.set_tag_value(p_doc, l_nd, 'isclose'  ,p_getdpt.isclose);
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'dpt2pay'  ,p_getdpt.dpt2pay);
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'int2pay'  ,p_getdpt.int2pay);
      bars_xmlklb.set_tag_value(p_doc, l_nd, 'comments' ,p_getdpt.comments);

     /*
      -- �������� ������� �� ����� %% � ��������� �����
      bars_audit.trace(l_trace||'������ ������� �� ������ ��������: '||p_getdpt.dptid);
      select a.nls,  ai.nls
        into l_nls, l_nlsr
        from dpt_deposit d, accounts a, int_accn i, accounts ai
       where d.deposit_id = p_getdpt.dptid
         and d.acc = a.acc and a.acc = i.acc and i.acra = ai.acc and i.id = 1;


      bars_audit.trace(l_trace||'�����: '||l_nls||' '||l_nlsr);
      bars_xmlklb_ref.make_postvp( gl.bd, '*', '%',  l_nls);
      bars_xmlklb_ref.make_postvp_nodel( gl.bd, '*', '%',  l_nlsr);

      l_sql := ' select sab, nls, nlsk, nms as nams, namk as nmk, mfo,        '||
               '         nd, vob, dk, s, to_char(fdat, ''yyyy-mm-dd'') daopl, '||
               '         ost as ism, to_char(dapp, ''yyyy-mm-dd'') dapp,      '||
               '         nazn as naz, pond, okpo as kokk,ref, sos, blk_msg,   '||
               '         kv, kv2,tt, stmt                                     '||
               '    from bars.tmp_vpklb order by ref                          ' ;
      open  l_cur for l_sql;

      l_scn := dbms_flashback.get_system_change_number;

      add_cursordata_to_node
                 ( p_doc   => p_doc,
                   p_nddpt => l_nd,
                   p_cur   => l_cur,
                   p_tag   => 'vpacc',
		   p_attrname => 'cscn',
		   p_attrval => l_scn);
      close l_cur;
      */

      dbms_xmldom.setVersion(p_doc, '1.0');

   end;





   ------------------------------------------------------
   --   CREATE_GETDPT_REPLY()
   --
   --   �������� ��������� ��� ������ �� �������� �������� ��� ����. ������
   --   � ��������� ErrorCode � ErrorDetail, ���� errcode = '0000',
   --
   --   p_errcode     - ��� ������  (��������� ����� �� err_klb.err)
   --   p_errdetail   - �������� ������
   --   p_clbref      - ��� ��-�����
   --   p_doc         - ��������� ���-� ������
   --
   --
   procedure create_getdpt_reply(
                   p_message          varchar2,
                   p_errcode          varchar2,
                   p_errdetail        varchar2,
                   p_getdpt           t_getdeposit,
                   p_clbref           number,
                   p_doc       in out dbms_xmldom.DOMDocument)
   is
      l_trace    varchar2(1000) := G_TRACE||'create_getdpt_reply: ';
      l_nddpt    dbms_xmldom.DOMNode;
   begin


      bars_xmlklb.create_reply(
                   p_errcode    => p_errcode  ,
                   p_errdetail  => p_errdetail,
                   p_clbref     => p_clbref   ,
                   p_refnode    => l_nddpt    ,
                   p_doc        => p_doc      );

      -- �������� ���������� �� ��������
      if (p_errcode = '0000') then

         insert_getdpt_info(
                  p_message  => p_message,
                  p_doc      => p_doc,
                  p_nddpt    => l_nddpt,
                  p_getdpt   => p_getdpt);

   end if;

   exception when others then
      bars_audit.error(l_trace||'������ ������������ ������:'||sqlerrm);
      raise;
   end;





   -----------------------------------------------------------------
   --    PARSE_GETDPT()
   --
   --    ��������� ���-� ������� �� �������� ��� ��������� ������
   --
   --    p_nd       - ���� ������ �������� /Body/DPT1
   --    p_dpt      - ��������� ��������
   --    p_message  - DPTC - ��������, DPTR - ��������� ������
   --
   procedure parse_getdpt(
                  p_nd               dbms_xmldom.DOMNode,
                  p_getdpt    in out t_getdeposit,
                  p_message   in     varchar2)
   is
      l_pathl     varchar2(100) ;
      l_tmp       varchar2(1000);
      l_trace     varchar2(1000) := G_TRACE||'parse_getdpt: ';
   begin


      -- �������� ���������
      p_getdpt.ref := dbms_xslprocessor.valueOf(p_nd, '@Ref');

      bars_audit.trace(l_trace||'�������� �������� ������-����� -'||p_getdpt.ref);

      bars_audit.trace(l_trace||'������ ������ ����� ���������');

      l_pathl := 'Body_'||p_message||'/DPTClose/';

      p_getdpt.dptid   := dbms_xslprocessor.valueOf(p_nd, l_pathl||'DPT_ID/text()');
      l_tmp            := dbms_xslprocessor.valueOf(p_nd, l_pathl||'DATE_OFF/text()');
      p_getdpt.procdat := bars_xmlklb.convert_to_date(l_tmp,'DATE_OFF');

      -- ��������
      if p_message = 'DPTC' then
         p_getdpt.amount := null;
      else
         p_getdpt.amount  := dbms_xslprocessor.valueOf(p_nd, l_pathl||'DPT_OSTC/text()');
      end if;

   exception when others then
      bars_audit.error(l_trace||'������ ������� �������� ��� ������� �� �������� ��� ����. ������');
      bars_audit.error(l_trace||sqlerrm);
      raise;
   end;


   -----------------------------------------------------------------
   --    POST_DPTVP()
   --
   --    ������������ ������� �� ������ ���������� ��������
   --
   --    p_dptid - ����� ��������
   --
   procedure post_dptvp( p_dptid number)
   is
      l_acc     number;
      l_nls     varchar2(14);
      l_intnls  varchar2(14);
      l_sab     customer.sab%type;
      l_branch  branch.branch%type;
   begin
      select a.acc, a.nls, d.branch
        into l_acc, l_nls, l_branch
        from dpt_deposit d, accounts a
       where deposit_id = p_dptid
         and a.kv = d.kv and a.acc = d.acc;

      select a.nls into l_intnls
        from int_accn i, accounts a
       where i.acra = a.acc and i.acc = l_acc
         and id = 1;

      begin
         select sab into l_sab
           from v_klbx_branch
          where isactive = 1 and branch = l_branch;

         bars_xmlklb_ref.postvp_for_sab(l_sab, gl.bd, l_intnls);
         bars_xmlklb_ref.postvp_for_sab(l_sab, gl.bd, l_nls);
      exception when no_data_found then
         null;
      end;
   end;


   -----------------------------------------------------------------
   --    PROCESS_GETDPT()
   --
   --    ���������� ������ �� �������� �������� ��� ���� ��������� ������
   --
   --    p_message -  (DPTC - ��������, DPTR - ������� ������ )
   --    p_pack    -  �������� ������ ���������
   --    p_gateid  - ����� ��������� ���������
   --    p_seckey  - ���� ��������  kltoss
   --    p_reply   - ��������� ���������
   --
   procedure process_getdpt(
                  p_message     varchar2,
                  p_pack        bars_xmlklb.t_pack,
                  p_gateid      number,
                  p_seckey      varchar2,
                  p_reply   out clob)
   is
      l_getdpt    t_getdeposit;
      l_trace     varchar2(1000)   := G_TRACE||'process_getdpt: ';
      l_errumsg   err_texts.err_msg%type;
      l_errcode   varchar2(10)           ;
      l_errmsg    err_texts.err_msg%type ;
      l_bodydoc   dbms_xmldom.DOMDocument;
      l_doc       dbms_xmldom.DOMDocument;
      l_nddoc     dbms_xmldom.DOMNode;
      l_nd        dbms_xmldom.DOMNode;
      l_ndlist    dbms_xmldom.DOMNodeList;
      l_reply     clob;
      l_sumc      number;
      l_sumc2     number;
      l_isdemand  smallint;
      l_fullpay   smallint;
      l_int2pay_ing number;
      l_int2pay_tax number;
   begin

       l_doc    := bars_xmlklb.parse_clob(p_pack.cbody);
       l_nddoc  := dbms_xmldom.makeNode(l_doc);

       l_ndlist := dbms_xslprocessor.selectNodes(l_nddoc, '/Body/'||p_message);

       bars_audit.trace(l_trace||'����� �������� - '||dbms_xmldom.getLength(l_ndlist));
       for i in 0 .. dbms_xmldom.getLength(l_ndlist) - 1
       loop
           begin
              l_nd      := dbms_xmldom.item(l_ndlist, i);
              l_errcode := '0000';
              l_errumsg := 'Success';
              -- ��������� � ���������
              parse_getdpt (
                  p_nd       => l_nd,
                  p_getdpt   => l_getdpt,
                  p_message  => p_message);

              l_fullpay := case nvl(l_getdpt.amount, 0) when 0 then 1 else 0 end;

              -- ����� ������ ���������

              bars_audit.trace(l_trace||'����� ������ dpt_web.global_penalty_ex');

              dpt_web.global_penalty_ex(
                 p_dptid     => l_getdpt.dptid ,    -- ������������� ��������
                 p_modcode   => 'DPT',
                 p_date      => l_getdpt.procdat,   -- ���� ������ (�������)
                 p_fullpay   => l_fullpay,          -- 1-�����������, 0-����.������
                 p_amount    => l_getdpt.amount,    -- ����� ������
                 p_mode      => 'RW',               -- ����� RO - ������, RW - ���������
                 p_penalty   => l_getdpt.penalty,   -- ����� ������
                 p_commiss   => l_sumc,             -- ����� �������� �� ���
                 p_commiss2  => l_sumc2,            -- ����� �������� �� ����� ������ �����
                 p_dptrest   => l_getdpt.dpt2pay,   -- ����� �������� � �������
                 p_intrest   => l_getdpt.int2pay,   -- ����� ��������� � �������
                 p_details   => l_getdpt.comments,  -- ��������� �������� ������� ������
		 p_int2pay_ing => l_int2pay_ing ,
                 p_int2pay_tax => l_int2pay_tax);

                 l_getdpt.isclose  := l_fullpay;

              -- ���� ����������� ��������
              if l_getdpt.isclose = 1 then
                  -- ���� ����� ������� ��� �����������
                  l_isdemand := dpt_web.is_demandpt(l_getdpt.dptid);
                  if l_isdemand = 1 then
                     bars_audit.trace(l_trace||'������� �� ��������������, ���������� ���� ���� ������� �����');
                     -- ����� �������, ��� ������� ���� ����� �������� ������
	             dpt.fill_dptparams(
                         p_dptid => l_getdpt.dptid,
                         p_tag   => '2CLOS',
                         p_val   => 'Y');
                  end if;
              end if;


              bars_audit.trace(l_trace||'����� ����� dpt_web.global_penalty_ex');

              if p_message = 'DPTR' then
                 -- �� ������� ���� - ��� ���������� ������ - ���� ��������� �������
                 l_getdpt.int2pay := 0;
              end if;

              -- ���� ���� ���������, ��������� � ������������ ��������
              -- ����� �� �������� �� �����
              for c in (select d.ref, o.tt, o.sos
                          from dpt_payments d, oper o
                         where d.ref = o.ref and o.vdat >= gl.bd
                           and dpt_id  = l_getdpt.dptid
                           and sos < 5) loop
                    -- ��� �������� � ��������� ��������� �� �����
                    bars_audit.trace(l_trace||'������ ��-����� ���������: tt='||c.tt||' ���='||c.ref);
                    gl.pay2(2, c.ref, gl.bd);
              end loop;


          exception  when others then
              bars_xmlklb.get_process_error(sqlerrm,l_errcode,l_errumsg);
          end;

          -- ��������� �������� � ����� ���������
          create_getdpt_reply(
                   p_message       => p_message,
                   p_errcode       => l_errcode,
                   p_errdetail     => l_errumsg,
                   p_getdpt        => l_getdpt,
                   p_clbref        => l_getdpt.ref,
                   p_doc           => l_bodydoc);
       end loop;


       -- ��������� ����� ��� ����� ������

       bars_xmlklb.create_document_reply(
             p_bodydoc => l_bodydoc,
             p_hdr     => p_pack.hdr,
             p_reply   => l_reply);


       --�������� � ���� �����
       bars_audit.trace(l_trace||'������ ���������� ������ � ��');
       bars_xmlklb.save_reply(
                  p_gateid  => p_gateid,
                  p_partid  => 1,
                  p_reply   => l_reply);


       p_reply := l_reply;


       dbms_xmldom.freedocument(l_bodydoc);
       dbms_xmldom.freedocument(l_doc);

       -- �� ������� �����, ���  ��������� ������ ���������� ����� �� ����
       -- ����������(�������) �� ��������� �����  � ����� %%

       post_dptvp(l_getdpt.dptid);


   exception when others then
       bars_context.set_context;

       if not dbms_xmldom.isnull(l_bodydoc) then
          dbms_xmldom.freedocument(l_bodydoc);
       end if;
       if not dbms_xmldom.isnull(l_doc) then
          dbms_xmldom.freedocument(l_doc);
       end if;

       bars_audit.error(l_trace||'������ ��������� ��������');
       bars_audit.error(l_trace||sqlerrm);
       raise;
   end;




   -----------------------------------------------------------------
   --    PROCESS_DPTAGREEMENT()
   --
   --    ���������� ������ �� �������� ���. ����������
   --
   --    p_message - (DPTD - ��� ������� ���������, DPTS - ��� ���.)
   --    p_pack    - �������� ������ ���������
   --    p_gateid  - ����� ��������� ���������
   --    p_seckey  - ���� ��������  kltoss
   --    p_reply   - ��������� ���������
   --
   procedure process_dptagreement(
                  p_message     varchar2,
                  p_pack        bars_xmlklb.t_pack,
                  p_gateid      number,
                  p_seckey      varchar2,
                  p_reply   out clob)
   is
      l_getdpt    t_getdeposit;
      l_trace     varchar2(1000)   := G_TRACE||'process_dptagreement: ';
      l_errumsg   err_texts.err_msg%type;
      l_errcode   varchar2(10)           ;
      l_errmsg    err_texts.err_msg%type ;
      l_bodydoc   dbms_xmldom.DOMDocument;
      l_doc       dbms_xmldom.DOMDocument;
      l_nddoc     dbms_xmldom.DOMNode;
      l_nd        dbms_xmldom.DOMNode;
      l_ndlist    dbms_xmldom.DOMNodeList;
      l_reply     clob;
      l_dptagr    t_dptagreement;
   begin

       l_doc    := bars_xmlklb.parse_clob(p_pack.cbody);
       l_nddoc  := dbms_xmldom.makeNode(l_doc);
       l_ndlist := dbms_xslprocessor.selectNodes(l_nddoc, '/Body/'||p_message);

       bars_audit.trace(l_trace||'����� �������� - '||dbms_xmldom.getLength(l_ndlist));
       for i in 0 .. dbms_xmldom.getLength(l_ndlist) - 1
       loop
           begin
              l_nd      := dbms_xmldom.item(l_ndlist, i);
              l_errcode := '0000';
              l_errumsg := 'Success';

              -- ��������� � ���������
              parse_dptagreement (
                  p_nd       => l_nd,
                  p_dptagr   => l_dptagr);

              begin
                 bars_audit.trace(l_trace||'����� savepoint');
                 savepoint dpt_before;

                 -- ���� �� � 3-� �����. ��������� ����������� �������
                 if l_dptagr.agreement.agrmnttype  = 12  then
                    bars_audit.trace(l_trace||'����� ������������ �������');
                    -- �������� ����� �������
                    get_cutomer(l_dptagr.customer);
                    -- �������� ����� ��������
                    bars_audit.info(l_trace||'����������� 3-�� ���� ��� �'||l_dptagr.customer.clientid);
                    l_dptagr.agreement.trustcustid := l_dptagr.customer.clientid;
                 else
                    bars_audit.info(l_trace||'����������� ������� �� ���������');
                 end if;


                 get_agreement(l_dptagr);


              exception  when others then
                 rollback to dpt_before;
                 raise;
              end;




          exception  when others then
              bars_xmlklb.get_process_error(sqlerrm,l_errcode,l_errumsg);
          end;

          -- ��������� �������� � ����� ���������
          create_dptagreement_reply(
                   p_message       => p_message,
                   p_errcode       => l_errcode,
                   p_errdetail     => l_errumsg,
                   p_dptagr        => l_dptagr,
                   p_doc           => l_bodydoc);


       end loop;


       -- ��������� ����� ��� ����� ������

       bars_xmlklb.create_document_reply(
             p_bodydoc => l_bodydoc,
             p_hdr     => p_pack.hdr,
             p_reply   => l_reply);


       --�������� � ���� �����
       bars_audit.trace(l_trace||'������ ���������� ������ � ��');
       bars_xmlklb.save_reply(
                  p_gateid  => p_gateid,
                  p_partid  => 1,
                  p_reply   => l_reply);


       p_reply := l_reply;


       dbms_xmldom.freedocument(l_bodydoc);
       dbms_xmldom.freedocument(l_doc);


   exception when others then
       bars_context.set_context;

       if not dbms_xmldom.isnull(l_bodydoc) then
          dbms_xmldom.freedocument(l_bodydoc);
       end if;
       if not dbms_xmldom.isnull(l_doc) then
          dbms_xmldom.freedocument(l_doc);
       end if;

       bars_audit.error(l_trace||'������ ��������� ��������');
       bars_audit.error(l_trace||sqlerrm);
       raise;
   end;





   -----------------------------------------------------------------
   --    PROCESS_DPT()
   --
   --    ���������� ������ �� �������� ��������
   --
   --    p_pack    -  �������� ������ ���������
   --    p_gateid  - ����� ��������� ���������
   --    p_seckey  - ���� ��������  kltoss
   --    p_reply   - ��������� ���������
   --
   procedure process_dpt(
                  p_pack        bars_xmlklb.t_pack,
                  p_gateid      number,
                  p_seckey      varchar2,
                  p_reply   out clob)
   is

      l_dpt       t_deposit;
      l_trace     varchar2(1000)   := G_TRACE||'process_dpt: ';
      l_errumsg   err_texts.err_msg%type;
      l_errcode   varchar2(10)           ;
      l_errmsg    err_texts.err_msg%type ;
      l_bodydoc   dbms_xmldom.DOMDocument;
      l_doc       dbms_xmldom.DOMDocument;
      l_nddoc     dbms_xmldom.DOMNode;
      l_nd        dbms_xmldom.DOMNode;
      l_ndlist    dbms_xmldom.DOMNodeList;
      l_reply     clob;
      l_refdpt    number;
      l_ref       number;
      l_dptnd     varchar2(100);
  begin


       l_doc    := bars_xmlklb.parse_clob(p_pack.cbody);
       l_nddoc  := dbms_xmldom.makeNode(l_doc);
       l_ndlist := dbms_xslprocessor.selectNodes(l_nddoc, '/Body/DPT1');

       bars_audit.trace(l_trace||'����� ��������� � ������ - '||dbms_xmldom.getLength(l_ndlist));
       for i in 0 .. dbms_xmldom.getLength(l_ndlist) - 1  loop
           begin

              l_nd      := dbms_xmldom.item(l_ndlist, i);
              l_errcode := '0000';
              l_errumsg := 'Success';
              -- ��������� � ���������


              parse_dpt(p_nd   => l_nd,
                        p_dpt  => l_dpt);


              begin
                 bars_audit.trace(l_trace||'����� savepoint');
                 savepoint dpt_before;
                 bars_audit.trace(l_trace||'����� ������������ �������');
                 -- �������� ����� �������
                 get_cutomer(l_dpt.customer);
                 -- �������� ����� ��������
                 bars_audit.info(l_trace||'����������� ������� ��� �'||l_dpt.customer.clientid);

                 l_dpt.contract.rnk := l_dpt.customer.clientid;
                 get_contract(l_dpt.contract);


                 begin
                    select nd into  l_dptnd
                    from dpt_deposit where deposit_id = l_dpt.contract.dpt_id;
                    bars_audit.info(l_trace||'������� ����� ������� ��� ����� � '||l_dpt.contract.dpt_id||' ����� �������� ���� = '||l_dptnd);
                 end;

                 bars_audit.trace(l_trace||'�������� �������� �� �������������� �����');

                 -- �������� �������� �� �������������� �����
                 l_refdpt := process_doc(
                     p_dpt      => l_dpt,
                     p_seckey   => p_seckey,
                     p_packname => p_pack.hdr.pack_name);


                 -- ���������, �������� ��� ������� ��������, ������ ������ � ���������
                 -- ������� � ���� � �������
                 begin
                    select ref into l_ref from xml_refque
                    where dpt_nd = l_dptnd;
                    bars_audit.trace(l_trace||'����� ����������� ����������� CHK');

                    -- ������ ��� - ���������� ������ ��� ����������� ��������
                    gl.pay(2,l_refdpt, gl.bdate);
                    --������� �� �������
                    bars_audit.trace(l_trace||'����� ��������� �� �������');
                    delete from xml_refque where dpt_nd = l_dptnd;
                    bars_audit.trace(l_trace||'����� ��������� �� �������');
                 exception when no_data_found then
                    -- ������� ��� �� ���� - �������� � ������� ��� ������
                    insert into xml_refque(ref, dpt_nd) values(l_refdpt, l_dptnd);
                 end;

              exception  when others then
                 rollback to dpt_before;
                 raise;
              end;

            exception  when others then
               bars_xmlklb.get_process_error(sqlerrm,l_errcode,l_errumsg);
            end;


           -- ��������� �������� � ����� ���������
            create_dpt_reply (
                   p_errcode       => l_errcode,
                   p_errdetail     => l_errumsg,
                   p_contract      => l_dpt.contract,
                   p_clbref        => l_dpt.ref,
                   p_doc           => l_bodydoc);

           --bars_xmlklb.create_reply(l_errcode, l_errumsg, l_dpt.ref, l_bodydoc);

       end loop;

       -- ��������� ����� ��� ����� ������

       bars_xmlklb.create_document_reply(
             p_bodydoc => l_bodydoc,
             p_hdr     => p_pack.hdr,
             p_reply   => l_reply);


       --�������� � ���� �����
       bars_audit.trace(l_trace||'������ ���������� ������ � ��');
       bars_xmlklb.save_reply(
                  p_gateid  => p_gateid,
                  p_partid  => 1,
                  p_reply   => l_reply);


       p_reply := l_reply;


       dbms_xmldom.freedocument(l_bodydoc);
       dbms_xmldom.freedocument(l_doc);



   exception when others then
       bars_context.set_context;

       if not dbms_xmldom.isnull(l_bodydoc) then
          dbms_xmldom.freedocument(l_bodydoc);
       end if;

       if not dbms_xmldom.isnull(l_doc) then
          dbms_xmldom.freedocument(l_doc);
       end if;

       bars_audit.error(l_trace||'������ ��������� ��������');
       bars_audit.error(l_trace||sqlerrm);
       raise;
   end;








   -----------------------------------------------------------------
   --    PROCESS_DPT()
   --
   --    ���������� ������ �� �������� ���. ��������
   --
   --    p_pack    -  �������� ������ ���������
   --    p_gateid  - ����� ��������� ���������
   --    p_seckey  - ���� ��������  kltoss
   --    p_reply   - ��������� ���������
   --
   procedure process_socdpt(
                  p_pack        bars_xmlklb.t_pack,
                  p_gateid      number,
                  p_seckey      varchar2,
                  p_reply   out clob)
   is

      l_dpt       t_socdeposit;
      l_trace     varchar2(1000)   := G_TRACE||'process_socdpt: ';
      l_errumsg   err_texts.err_msg%type;
      l_errcode   varchar2(10)           ;
      l_errmsg    err_texts.err_msg%type ;
      l_bodydoc   dbms_xmldom.DOMDocument;
      l_doc       dbms_xmldom.DOMDocument;
      l_nddoc     dbms_xmldom.DOMNode;
      l_nd        dbms_xmldom.DOMNode;
      l_ndlist    dbms_xmldom.DOMNodeList;
      l_reply     clob;
      l_refdpt    number;
      l_ref       number;
      l_dptnd     varchar2(100);
      l_nddpt    dbms_xmldom.DOMNode;
  begin


       l_doc    := bars_xmlklb.parse_clob(p_pack.cbody);

       --p_testlog(p_pack.hdr.pack_name, p_pack.cbody);

       l_nddoc  := dbms_xmldom.makeNode(l_doc);
       l_ndlist := dbms_xslprocessor.selectNodes(l_nddoc, '/Body/DPT2');

       bars_audit.trace(l_trace||'����� ��������� � ������ - '||dbms_xmldom.getLength(l_ndlist));
       for i in 0 .. dbms_xmldom.getLength(l_ndlist) - 1  loop
           begin

              l_nd      := dbms_xmldom.item(l_ndlist, i);
              l_errcode := '0000';
              l_errumsg := 'Success';
              -- ��������� � ���������


              parse_socdpt(p_nd   => l_nd,
                           p_dpt  => l_dpt);


              begin
                 bars_audit.trace(l_trace||'����� savepoint');
                 savepoint dpt_before;
                 bars_audit.trace(l_trace||'����� ������������ �������');

                 -- �������� ����� �������
                 get_cutomer(l_dpt.customer);
                 bars_audit.info(l_trace||'����������� ������� ��� �'||l_dpt.customer.clientid);

                 -- �������� ����� ��������
                 l_dpt.contract.custid := l_dpt.customer.clientid;
                 get_soccontract(l_dpt.contract);

                 bars_audit.info(l_trace||'������� ����� ���. �������, � '||l_dpt.contract.contractid||' �������� ���� = '||l_dpt.contract.contractacc);

              exception  when others then
                 rollback to dpt_before;
                 raise;
              end;

            exception  when others then
               bars_xmlklb.get_process_error(sqlerrm,l_errcode,l_errumsg);
            end;


           -- ��������� �������� � ����� ���������
            bars_xmlklb.create_reply(
                   p_errcode    => l_errcode  ,
                   p_errdetail  => l_errumsg  ,
                   p_clbref     => l_dpt.ref  ,
                   p_refnode    => l_nddpt    ,
                   p_doc        => l_bodydoc);

            -- �������� ��������� ���������� �� ��������
            if (l_errcode = '0000') then
               insert_socdpt_info(
                   p_doc      => l_bodydoc,
                   p_nddpt    => l_nddpt,
                   p_contract => l_dpt.contract);
            end if;


       end loop;

       -- ��������� ����� ��� ����� ������

       bars_xmlklb.create_document_reply(
             p_bodydoc => l_bodydoc,
             p_hdr     => p_pack.hdr,
             p_reply   => l_reply);


       --�������� � ���� �����
       bars_audit.trace(l_trace||'������ ���������� ������ � ��');
       bars_xmlklb.save_reply(
                  p_gateid  => p_gateid,
                  p_partid  => 1,
                  p_reply   => l_reply);


       p_reply := l_reply;


       dbms_xmldom.freedocument(l_bodydoc);
       dbms_xmldom.freedocument(l_doc);



   exception when others then
       bars_context.set_context;

       if not dbms_xmldom.isnull(l_bodydoc) then
          dbms_xmldom.freedocument(l_bodydoc);
       end if;

       if not dbms_xmldom.isnull(l_doc) then
          dbms_xmldom.freedocument(l_doc);
       end if;

       bars_audit.error(l_trace||'������ ��������� ��������');
       bars_audit.error(l_trace||sqlerrm);
       raise;
   end;








   -----------------------------------------------------------------
   --    XML_DPT()
   --
   --   ��������� - ���� � ��������� ������ ��������� �� ��������
   --
   --    p_message - ��������� ��� ���������
   --    p_pack    - �������� ������ ���������
   --    p_gateid  - ����� ��������� ���������
   --    p_seckey  - ���� ��������  kltoss
   --    p_reply   - ��������� ���������
   --
   procedure xml_dpt(
                  p_message     varchar2,
                  p_pack        bars_xmlklb.t_pack,
                  p_gateid      number,
                  p_seckey      varchar2,
                  p_reply   out clob)
   is
   begin

      case
      -- �������� ��������
         when p_message = 'DPT1' then
            process_dpt(
               p_pack     => p_pack,
               p_gateid   => p_gateid,
               p_seckey   => p_seckey,
               p_reply    => p_reply);
      -- �������� ���. ��������
         when p_message = 'DPT2' then
            process_socdpt(
               p_pack     => p_pack,
               p_gateid   => p_gateid,
               p_seckey   => p_seckey,
               p_reply    => p_reply);
         -- ������ �� �������� ��� ������� ������
         when p_message = 'DPTC' or  p_message = 'DPTR' then
            process_getdpt(
               p_message  => p_message,
               p_pack     => p_pack,
               p_gateid   => p_gateid,
               p_seckey   => p_seckey,
               p_reply    => p_reply);
         -- ������ �� �������� ���. �����
         when p_message = 'DPTD'  then
            process_dptagreement(
               p_message  => p_message,
               p_pack     => p_pack,
               p_gateid   => p_gateid,
               p_seckey   => p_seckey,
               p_reply    => p_reply);
      end case;

   end;



   -----------------------------------------------------------------
   --    AFTER_PAY_DPT_OP
   --
   --    ������� ���������� �������� ����� ������ ������ ��������� �� ��������
   --
   --    p_ref - ��� ���������
   --
   --
   procedure after_pay_dpt_op(p_doc  oper%rowtype)
   is
   begin
      case G_CURR_DPT_OP
           when  G_TT_ADDITION then
                 --  ���� ��������� �������� ����������, ���������,
                 --  ���� ���� ������� < ���������� ���� - ����������� %%
                 accrue_interest_uptodate(p_doc);
           when G_TT_FIRST then
                 pay_dpt_plan_operation;--���� ��������� �����
           else null;
      end case;
   end;


   -----------------------------------------------------------------
   --    ADD_OFFLINE_TTS
   --
   --    ��� ������� �������� ���������� �������� ��������,
   --    ������� ����� � ��� ��������� (dpt_tts_vidd). ������ �������� ������ ���� ���������
   --    ��������(� �� ������ ��� ��� ������� � ��� �������� ������).
   --    �� ��������� �������� ��� �������� � ��� ������� ������, �������� �������
   --    �������� � ��������� ����������� ��� ������ ���� ������� �� ��������� ���
   --    ����������� �������� ��� �������. ������ ������ �������� ��������� ��������
   --    TTOF1, TTOF2 ...  ���� �������� ������� ����� �������� ������� ������������
   --    ������ �������� ������. (�������� DP0 -> KB9 ""- )
   --        DP0 +���������� ������ � ���.�����_ ���_����
   --        KB9 off  DPT - ���������� ������ ���. ���
   --
   --
   procedure add_offline_tts
   is
   begin
      for c in ( select vidd, d.tt, val from dpt_tts_vidd d, op_rules o, tts t
                 where     d.tt not in (select tt from op_rules where tag = 'ISOFF')
                       and d.tt  = o.tt and o.tag like 'TTOF%' and val = t.tt
               ) loop
          begin
             insert into dpt_tts_vidd(vidd, tt)
             values(c.vidd, c.val);
          exception when dup_val_on_index then null;
          end;

      end loop;

   end;


end;
/
 show err;
 
PROMPT *** Create  grants  BARS_XMLKLB_DPT ***
grant EXECUTE                                                                on BARS_XMLKLB_DPT to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_xmlklb_dpt.sql =========*** End
 PROMPT ===================================================================================== 
 