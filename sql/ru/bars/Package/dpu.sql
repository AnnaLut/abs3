create or replace package DPU
is

  g_header_version  constant varchar2(64) := 'version 42.38  03.04.2017';

  --
  -- ����������� ������ ������
  --
  function header_version return varchar2;
  function body_version   return varchar2;

  --
  -- ������ �������� �������������� r011/r013 ��� ���./����.������ �� ��������
  --
  procedure get_r011_r013
  ( p_depnbs  in  ps.nbs%type,                     -- ���.���� ����������� �����
    p_intnbs  in  ps.nbs%type,                     -- ���.���� ����������� �����
    p_depr011 out specparam.r011%type,             -- �������� r011 ��� ����������� �����
    p_intr011 out specparam.r011%type,             -- �������� r011 ��� ����������� �����
    p_depr013 out specparam.r013%type,             -- �������� r013 ��� ����������� �����
    p_intr013 out specparam.r013%type);            -- �������� r013 ��� ����������� �����

  --
  -- ����� ��������� � ������ ������� �� ��������
  --
  procedure FILL_DPU_PAYMENTS
  ( p_dpuid   in  dpu_payments.dpu_id%type,        -- ������������� ��������
    p_ref     in  dpt_payments.ref%type            -- �������� ���������
  );

  --
  -- ��������� �������� ������������ ����������� ��������
  --
  procedure P_OPEN_STANDART
  ( nd_          VARCHAR2,    -- ����� ��������
    rnk_         NUMBER,      -- ���.� �������
    vidd_        NUMBER,      -- ��� ��������
    sum_         NUMBER,      -- ����� ��������
    datz_        DATE,        -- ���� ����������
    datn_        DATE,        -- ���� ������
    dato_        DATE,        -- ���� ���������
    datv_        DATE,        -- ���� ��������
    mfov_        VARCHAR2,    -- ��� ��� ������� %%
    nlsv_        VARCHAR2,    -- ���� ��� ������� %%
    nmsv_        VARCHAR2,    -- ���������� %%
    mfop_        VARCHAR2,    -- ��� ��� �������� ��������
    nlsp_        VARCHAR2,    -- ���� ��� �������� ��������
    nmsp_        VARCHAR2,    -- ���������� ��������
    freq_        NUMBER,      -- ������-�� ������� %%
    comproc_     NUMBER,      -- ������� ������������� %%
    id_stop_     NUMBER,      -- ��� ������
    min_sum_     NUMBER,      -- ����� ������������ �������
    ir_          NUMBER,      -- �������.%-��� ������
    br_          NUMBER,      -- ��� ������� ������
    op_          NUMBER,      -- ��� �������� ����� BR � IR
    comment_     VARCHAR2,    -- �����������
    grp_         NUMBER,      -- ������ �������
    isp_         NUMBER,      -- �����.�����������
    branch_      VARCHAR2,    -- ��� �������������, �� ������� ����������� �������
    trustid_     NUMBER,      -- ������������� ���.���� 
    dpu_id_      OUT NUMBER,  -- �������� ��������
    err_         OUT VARCHAR2 -- ��������� �� ������
  );
    
  --
  -- ��������� �������� ���.���������� ��� ����������� ��������
  --
  procedure P_OPEN_DEPOSIT_LINE
    (nd_          VARCHAR2,    -- ����� ���.����������
     dpu_gen_     NUMBER,      -- ����� ���.��������
     rnk_         NUMBER,      -- ���.� �������
     vidd_        NUMBER,      -- ��� ��������
     sum_         NUMBER,      -- ����� ��������
     datz_        DATE,        -- ���� ����������
     datn_        DATE,        -- ���� ������
     dato_        DATE,        -- ���� ���������
     datv_        DATE,        -- ���� ��������
     mfov_        VARCHAR2,    -- ��� ��� ������� %%
     nlsv_        VARCHAR2,    -- ���� ��� ������� %%
     nmsv_        VARCHAR2,    -- ���������� %%
     mfop_        VARCHAR2,    -- ��� ��� �������� ��������
     nlsp_        VARCHAR2,    -- ���� ��� �������� ��������
     nmsp_        VARCHAR2,    -- ���������� ��������
     freq_        NUMBER,      -- ������-�� ������� %%
     comproc_     NUMBER,      -- ������� ������������� %%
     id_stop_     NUMBER,      -- ��� ������
     min_sum_     NUMBER,      -- ����� ������������ �������
     ir_          NUMBER,      -- �������.%-��� ������
     br_          NUMBER,      -- ��� ������� ������
     op_          NUMBER,      -- ��� �������� ����� BR � IR
     comment_     VARCHAR2,    -- �����������
     grp_         NUMBER,      -- ������ �������
     isp_         NUMBER,      -- �����.�����������
     trustid_     NUMBER,      -- ������������� ���.���� 
     old_dpuid_   dpu_deal.dpu_id%type default null, -- �������� ����� ����� (��� �����������)
     dpu_id_      OUT NUMBER,  -- �������� ��������
     err_         OUT VARCHAR2 -- ��������� �� ������
    );
    
  --
  -- �������� ������������ ��������� ���� ������������ ����������� �������� �� 
  -- ��������������� � �������� ���������� �������� �� �������������
  --
  function subdeal_validation (p_dpuid in dpu_deal.dpu_id%type) return number;
    
  --
  -- �������� �������� ��� ��� �������/���������� ����������� ��������
  --
  function DATE_VALIDATE
  ( p_vidd      dpu_vidd.vidd%type,
    p_datbeg    date,
    p_datend    date
  ) return VARCHAR2;

  --
  -- �������� �� ��������� ���������� �������� (�� ACC ���.�������)
  --
  function deposit_replenishment( p_depacc in dpu_deal.acc%type ) return number;
    
  --
  -- ��������� ���� ������������ ����������� �������� �� ��������������� 
  --        � �������� ���������� �������� �� �������������
  --
  procedure create_subdeal 
  ( p_gendpuid  in     dpu_deal.dpu_id%type  -- �������� ��������� ��������
  , p_subdpuid     out dpu_deal.dpu_id%type  -- �������� ���������� ��������
  );
    
  --
  -- ������ ������ ���.���������� � ������������ ��������
  --
  function f_next_add_number
  ( p_gendpuid in dpu_deal.dpu_gen%type
  ) return number;
    
  --
  -- ������ %-��� ������ ��� �������� ����������� �������� �� 
  --  �� ����� � ����������� �� ����, ����� � ����� ��������
  --
  function f_calc_rate
   (p_vidd    dpu_vidd_rate.vidd%type,   -- ��� ��������
    p_datbeg  date,                      -- ���� ������ ��������
    p_datend  date,                      -- ���� ��������� ��������
    p_amount  dpu_vidd_rate.limit%type)  -- ����� �������� (����� �����)
  return number; 
    
  --
  -- ������ ������������ ����������� ��������
  --
  function F_DURATION 
  ( p_date_open  DATE, 
    p_term_mnth  INTEGER, 
    p_term_days  INTEGER
  ) return DATE;


  --
  -- ��������� ����� ����, ����������� �� ����������� ����, 
  -- �� ��������������� ������ ���.���������� (���������)
  --
  procedure P_GENACC_RECEIPT 
  ( p_docref   oper.ref%type,       -- ���.���������-����������� �� ���.����
    p_docdat   oper.vdat%type,      -- ���� ����������� �� ���.����
    p_docsum   oper.s%type,         -- ����� ����������� �� ���.����
    p_genacc   accounts.acc%type,   -- ��� ������.����� ���.��������
    p_addacc   accounts.acc%type);  -- ��� ������������� ����� ���.����������
    
  --
  -- ������������� ����������� �� ��������������� ��������
  --
  procedure breakdown_combinpayments 
  ( p_docref   in  oper.ref%type,         -- �������� �������-�����������
    p_mainid   in  dpu_deal.dpu_id%type,  -- �������� ���������  ������.��������
    p_dmndid   in  dpu_deal.dpu_id%type,  -- �������� ���������� ������.��������
    p_mainref  out oper.ref%type,         -- �������� ���������� �� �������� ����
    p_dmndref  out oper.ref%type);        -- �������� ���������� �� ��������� ����
    
  --
  -- ��������� ���������� ����������� �������� ��
  --
  procedure upd_dealparams 
  ( p_dealid   in  dpu_deal.dpu_id%type,      -- ������������� ��������
    p_dealnum  in  dpu_deal.nd%type,          -- ����� ��������
    p_dealsum  in  dpu_deal.sum%type,         -- ����� ��������
    p_minsum   in  dpu_deal.min_sum%type,     -- ����� ������.�������
    p_freqid   in  dpu_deal.freqv%type,       -- ������-�� ������� ���������
    p_stopid   in  dpu_deal.id_stop%type,     -- ����� �� ��������� �����������
    p_datreg   in  dpu_deal.datz%type,        -- ���� ���������� ��������
    p_datbeg   in  dpu_deal.dat_begin%type,   -- ���� ������ ��������
    p_datend   in  dpu_deal.dat_end%type,     -- ���� ��������� ��������
    p_datret   in  dpu_deal.datv%type,        -- ���� �������� ��������
    p_depmfo   in  dpu_deal.mfo_d%type,       -- ��� ��� �������� ��������
    p_depnls   in  dpu_deal.nls_d%type,       -- ���� ��� �������� ��������
    p_depnms   in  dpu_deal.nms_d%type,       -- ���������� ��� �������� ��������
    p_intmfo   in  dpu_deal.mfo_p%type,       -- ��� ��� ������� ���������
    p_intnls   in  dpu_deal.nls_p%type,       -- ���� ��� ������� ���������
    p_intnms   in  dpu_deal.nms_p%type,       -- ���������� ��� ������� ���������
    p_intokpo  in  dpu_deal.okpo_p%type,      -- ���� ��� ������� ���������
    p_indrate  in  int_ratn.ir%type,          -- �������������� ������
    p_operid   in  int_ratn.op%type,          -- ��� �������.��������
    p_basrate  in  int_ratn.br%type,          -- ������� ������
    p_ratedat  in  int_ratn.bdat%type,        -- ���� ��������� ������
    p_branch   in  dpu_deal.branch%type,      -- ��� ������������� �����
    p_trustid  in  dpu_deal.trustee_id%type,  -- ��� �����.���� �������
    p_comment  in  dpu_dealw.value%type       -- �����������
  );
    
  --
  -- ������������� ����������� ������ �������� / ������ �� ��������
  --
  procedure final_amrt (p_dpuid in dpu_deal.dpu_id%type);   -- ������������� ��������
    
  --
  -- �������� ���� ������ �������� / ������ �� ��������
  --
  procedure close_dpaccs (p_dpuid in dpu_deal.dpu_id%type); -- ������������� ��������
    
  --
  -- ������������� ��������� ����������� ������ �� ����� ���������� ������
  --      � ����������� �� ����, ����� � ����� ����������� ��������
  --
  procedure get_scalerate 
   (p_typeid   in   dpu_vidd_rate.type_id%type,                -- ��� ��������
    p_kv       in   dpu_vidd_rate.kv%type,                     -- ��� ������
    p_vidd     in   dpu_vidd_rate.vidd%type,                   -- ��� ��������
    p_amount   in   dpu_vidd_rate.limit%type,                  -- ����� �������� (����� �����)
    p_datbeg   in   date,                                      -- ���� ������ ��������
    p_datend   in   date,                                      -- ���� ��������� ��������
    p_mnth     in   dpu_vidd_rate.term%type      default null, -- ���-�� �������
    p_days     in   dpu_vidd_rate.term_days%type default null, -- ���-�� ����
    p_actrate  out  dpu_vidd_rate.rate%type,                   -- ���������� ������
    p_maxrate  out  dpu_vidd_rate.max_rate%type,               -- ����.���������� ������
    p_recid    out  dpu_vidd_rate.id%type);                     -- ������������� ������


  --
  -- ��������� ��������� swift-���������� ���������� ��� ����������� �������� � ��.������
  --
  procedure SET_DEALSWTAGS 
  ( p_dpuid       in  dpu_deal_swtags.dpu_id%type,      -- ������������� ��������
    p_tag56_name  in  dpu_deal_swtags.tag56_name%type,  -- ����-���������: �������� 
    p_tag56_adr   in  dpu_deal_swtags.tag56_adr%type,   -- ����-���������: �����
    p_tag56_code  in  dpu_deal_swtags.tag56_code%type,  -- ����-���������: swift-���
    p_tag57_name  in  dpu_deal_swtags.tag57_name%type,  -- ����-�����������: �������� 
    p_tag57_adr   in  dpu_deal_swtags.tag57_adr%type,   -- ����-�����������: �����
    p_tag57_code  in  dpu_deal_swtags.tag57_code%type,  -- ����-�����������: swift-���
    p_tag57_acc   in  dpu_deal_swtags.tag57_acc%type,   -- ����-�����������: ����
    p_tag59_name  in  dpu_deal_swtags.tag59_name%type,  -- ����������: ��������
    p_tag59_adr   in  dpu_deal_swtags.tag59_adr%type,   -- ����������: �����
    p_tag59_acc   in  dpu_deal_swtags.tag59_acc%type    -- ����������: ����
  );

  --
  -- ������� ���������� ��� �������� ��� ������������ ��������� ��������� ����
  --
  function get_tt (p_operid in number,          -- ��� �������� �� ���-�� dpt_op
                   p_curid  in oper.kv%type,    -- ��� ������
                   p_mfob   in oper.mfob%type,  -- ��� ����� ����������
                   p_nlsb   in oper.nlsb%type   -- ���� ����������
  ) return tts.tt%type;
    
  --
  -- ������� ���������� ����� � ���� �������� ��� ������ ���������� �������
  -- (���.��� ������������ ���������� �� ������� "������ � ���.���������� ��")
  -- 
  -- p_dpuid - ������������� ����������� �������� ��� ���.����������
  -- p_type  - ��������� ���������� � ���� <ON>, ��� 
  --           O {A, D} - ������� ���������� � �������� � ���.����������
  --           N {N, _} - �������� ���-��� ��� ��� (N - ��������)
  --
  function f_nazn
  ( p_type  in varchar2, 
    p_dpuid in dpu_deal.dpu_id%type
  ) return oper.nazn%type;
  
  --
  -- ������������ ���������� ������� ��� �������� ���������� ��������� (DU%) 
  --
  function get_intdetails (p_depacc in accounts.nls%type, -- � ��������� �����
                           p_depcur in accounts.kv%type)  -- ������ ��������� �����
    return oper.nazn%type;
     
  --
  -- get_intpay_state() - ������� �������� ������������ ������� ��������� 
  --                      ������ �� ������� �������� � ������-�� ������� ���������
  -- ������� ���������� 1 (������� ���������) ��� 0 (������� ���������)  
  -- 
  -- ���������:
  --    p_dpuid   - ������������� �������� 
  --    p_freq    - ������������� �������
  --    p_datbeg  - ���� ������ �������� ��������
  --    p_datend  - ���� ��������� �������� ��������
  --    p_intacc  - �����.����� ����������� �����
  --    p_bdate   - ���������� ����
  --
  function get_intpay_state (p_dpuid   in  dpu_deal.dpu_id%type,
                             p_freq    in  dpu_deal.freqv%type,
                             p_datbeg  in  dpu_deal.dat_begin%type,
                             p_datend  in  dpu_deal.dat_end%type,
                             p_intacc  in  int_accn.acra%type,
                             p_bdate   in  date
  ) return number;
    
  --
  -- get_intpay_state_ex() - ������� �������� ������������ ������� ��������� 
  --                         �� ��������� �������� �� ��������� ����
  -- ������� ���������� 1 (������� ���������) ��� 0 (������� ���������)  
  -- 
  -- ���������:
  --    p_dpuid   - ������������� �������� 
  --    p_bdate   - ���������� ����
  --
  function get_intpay_state_ex (p_dpuid   in  dpu_deal.dpu_id%type,
                                p_bdate   in  date
  ) return number;
    
  --
  -- get_vob() - ������� ���������� ��� ���������� ��������� ��� ������ ��������
  --
  -- ���������:
  --    p_tt   - ��� ��������
  --    p_kva  - ��� ������-�
  --    p_kvb  - ��� ������-�
  --
  function get_vob (p_tt  in oper.tt%type,
                    p_kva in oper.kv%type,
                    p_kvb in oper.kv2%type
  ) return oper.vob%type;
    
  --
  -- get_nazn() - ������� ���������� ���������� ������� ��� ������ ��������
  --
  -- ���������:
  --    p_operid - ��� ��������
  --    p_dpuid  - ������������� �������� / ���.����������
  --    p_tt     - ��� ��������
  --    p_mfoa   - ���-�
  --    p_nlsa   - ����-�
  --    p_kva    - ������-�
  --    p_mfob   - ���-�
  --    p_nlsb   - ����-�
  --    p_kvb    - ������-�
  --
  function get_nazn (p_operid in dpt_op.id%type,
                     p_dpuid  in dpu_deal.dpu_id%type, 
                     p_tt     in oper.tt%type   default null,
                     p_mfoa   in oper.mfoa%type default null,
                     p_nlsa   in oper.nlsa%type default null,
                     p_kva    in oper.kv%type   default null,
                     p_mfob   in oper.mfob%type default null,
                     p_nlsb   in oper.nlsb%type default null,
                     p_kvb    in oper.kv2%type  default null
  ) return oper.nazn%type;
    
  --
  -- get_penalty_ex () - ��������� ������� ���������� ������ � ����� ������ 
  --                     ��� ��������� ����������� ����������� ��������
  --
  -- ���������:
  --    p_dpuid          - �������� ����������� ��������
  --    p_bdate          - ���� ���������� ����������� 
  --    p_totalint_nom   - ����� ����������� %% (���) �� ������ ��������
  --    p_totalint_eqv   - ����� ����������� %% (���) �� ������ ��������
  --    p_penyaint_nom   - ����� ����������� %% (���) �� �������� ������
  --    p_penyaint_eqv   - ����� ����������� %% (���) �� �������� ������
  --    p_intpay_nom     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_intpay_eqv     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_dptpay_nom     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_dptpay_eqv     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_penya_rate     - �������� ������
  --    p_tax_inc_ret    - ���� ���������� � ����������� %% ������� �� �������� � �� (��� ����������)
  --    p_tax_mil_ret    - ���� ���������� � ����������� %% ���������� ����� � ��   (��� ����������)
  --    p_tax_inc_pay    - ���� ������� �� �������� � �� (��� ������ � ���� ����������� %% �� ������� ������)
  --    p_tax_mil_pay    - ���� ���������� ����� � ��   (��� ������ � ���� ����������� %% �� ������� ������)
  --    p_details        - ����������� ������� ������
  --
  procedure get_penalty_ex
  ( p_dpuid         in   number,
    p_bdate         in   date,  
    p_totalint_nom  out  number,
    p_totalint_eqv  out  number,
    p_penyaint_nom  out  number,
    p_penyaint_eqv  out  number,
    p_intpay_nom    out  number,
    p_intpay_eqv    out  number,
    p_dptpay_nom    out  number,
    p_dptpay_eqv    out  number,
    p_penya_rate    out  number,
    p_tax_inc_ret   out  number,
    p_tax_mil_ret   out  number,
    p_tax_inc_pay   out  number,
    p_tax_mil_pay   out  number,
    p_details       out  varchar2
  );
    
  --
  -- get_penalty () - ��������� ������� ���������� ������ � ����� ������ 
  --                  ��� ��������� ����������� ����������� ��������
  --
  -- ���������:
  --    p_dpuid          - �������� ����������� ��������
  --    p_bdate          - ���� ���������� ����������� 
  --    p_totalint_nom   - ����� ����������� %% (���) �� ������ ��������
  --    p_totalint_eqv   - ����� ����������� %% (���) �� ������ ��������
  --    p_penyaint_nom   - ����� ����������� %% (���) �� �������� ������
  --    p_penyaint_eqv   - ����� ����������� %% (���) �� �������� ������
  --    p_intpay_nom     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_intpay_eqv     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_dptpay_nom     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_dptpay_eqv     - ����� ������ (���) ��� �������� � ����������� �����
  --    p_penya_rate     - �������� ������ 
  --    p_details        - ����������� ������� ������
  --
  procedure GET_PENALTY
  ( p_dpuid         in   number,
    p_bdate         in   date,  
    p_totalint_nom  out  number,
    p_totalint_eqv  out  number,
    p_penyaint_nom  out  number,
    p_penyaint_eqv  out  number,
    p_intpay_nom    out  number,
    p_intpay_eqv    out  number,
    p_dptpay_nom    out  number,
    p_dptpay_eqv    out  number,
    p_penya_rate    out  number,
    p_details       out  varchar2
  );
    
  --
  -- p_penalty() - (��������) ��������� ������� ���������� ������ � ����� ������ 
  --               ��� ��������� ����������� ����������� ��������
  --
  -- ���������:
  --    p_dpu_id     - �������� ����������� ��������
  --    p_dat        - ���� ���������� ����������� 
  --    p_fact_sum   - ����� ����� ����������� %% 
  --    p_penyasum   - ����� ����������� %% �� �������� ������
  --    p_penya_rate - �������� ������ 
  --    p_comment    - ����������� ������� ������
  --
  procedure P_PENALTY
  ( p_dpu_id     in     number
  , p_dat        in     date
  , p_fact_sum      out number
  , p_penyasum      out number
  , p_penya_rate    out number
  , p_comment       out varchar2
  );

  --
  -- close_deal() - ��������� �������� �������� ��� ���.����������
  -- 
  -- ���������:
  --    p_dpuid   - �������� ����������� �������� ��� ���.����������
  --
  procedure CLOSE_DEAL
  ( p_dpuid          in     dpu_deal.dpu_id%type );

  --
  -- close_deal() - ��������� �������� �������� ��� ���.�����
  -- 
  -- ���������:
  --    p_dpuid   - �������� ����������� �������� ��� ���.�����
  --    p_errmsg  - ����������� ��� ������� (������� ������������� ��������)
  --
  procedure CLOSE_DEAL
  ( p_dpuid          in     dpu_deal.dpu_id%type
  , p_errmsg         out    sec_audit.rec_message%type
  );

  --
  -- deal_prolongation() - ��������� ����������� ���������� ��������
  -- 
  -- ���������:
  --    p_bdat     - ��������� ���� (��������)
  --    p_dpuid    - dpu_id ��������, ��� 0 ��� ������������������ ��������
  --    p_datend   - ���� ���� ���������� ������� (��� p_dpuid <> 0)
  --    p_rate     - ���� ������ �� �������� ���� �����������
  --    p_reopen   - ������������ ������� (�������): 0-���; 1-� �������������;
  --
  procedure deal_prolongation
  ( p_bdat     in date                  default null,
    p_dpuid    in dpu_deal.dpu_id%type  default 0,   
    p_datend   in dpu_deal.dat_end%type default null,
    p_rate     in int_ratn.ir%type      default null,
    p_reopen   in number                default 0
  );

  --
  -- �������� ������� �� ����������� ��������
  --   
  --   p_dpuid  - �����. ����������� ��������
  --   p_amount - ����� ���������� ������ (� ����� ��������)
  --   p_option - ������ ����������� �������
  --     0 - �������� ������ ��� �������� �������
  --     1 - 
  --     2 - �� ������� ������ ��������
  --   p_outmsg - ������� ����������� ��� ������� ��� Null
  --
  procedure PARTIAL_PAYMENT
  ( p_dpuid    in   dpu_deal.dpu_id%type,
    p_amount   in   accounts.ostc%type,
    p_option   in   number,
    p_outmsg   out  varchar2
  );

  --
  -- ��������� ����������� ����������� ������� 
  -- ��� ��� %% ������ �� �������� ����� ������
  --
  procedure INTEREST_RECALCULATION
  ( p_dpuid   in  dpu_deal.dpu_id%type,
    p_outmsg  out varchar2
  );
  
  --
  -- ���������� �������� �� ������� �������� �� ���������� ��������
  --
  procedure BLOCK_CONTRACT
  ( p_dpuid    in  dpu_deal.dpu_id%type,  -- ��. ����������� ��������
    p_nd       in  cc_deal.nd%type,       -- ��. ����������  �������� (���� NULL - ������������� ������)
    p_errmsg  out  varchar2               -- ����������� ��� ������� ��� NULL
  );

  ---
  -- ��������� ���������� ����� �� ������� �������� ���������� � �������
  ---
  procedure REPAYMENT_PLEDGE
  ( p_dpuid    in  dpu_deal.dpu_id%type,  -- ��. ����������� ��������
    p_errmsg  out  varchar2               -- ����������� ��� ������� ��� NULL
  );

  --
  -- ��������� ������ ��� ������������ �������� ��������
  --
  procedure PENALTY_PAYMENT
  ( p_dpuid        in   dpu_deal.dpu_id%type,          -- ��. ����������� ��������
    p_penalty      in   accounts.ostc%type,            -- ���� ������ (� �������)
    p_int_pay      in   accounts.ostc%type,            -- ���� ������� ����������� �� ������� ������
    p_tax_inc_ret  in   accounts.ostc%type default 0,  -- ���� ���������� ���������� ������� �� �������� � ��
    p_tax_mil_ret  in   accounts.ostc%type default 0,  -- ���� ���������� ���������� ���������� �����   � ��
    p_tax_inc_pay  in   accounts.ostc%type default 0,  -- ���� ��������� ������� �� �������� � ��
    p_tax_mil_pay  in   accounts.ostc%type default 0   -- ���� ��������� ���������� �����   � ��
  );
    
$if DPU_PARAMS.LINE8
$then
  ---
  -- get_nls4pay() - �-� ������� ������� ��� ������ ��������
  --                 (�������� � 8-�� ����� ��� ���.���)
  -- ���������:
  --  p_ref - �������� ���������
  --  p_nls - ����� �������
  --  p_kv  - ��� ������
  ---
  function get_nls4pay
  ( p_ref  in  oper.ref%type,
    p_nls  in  accounts.nls%type,
    p_kv   in  accounts.kv%type
  ) return accounts.nls%type;
    
  ---
  -- �������� �������� �� ������� ���.��
  ---
  function IS_LINE
  ( p_ref  in  oper.ref%type
  ) return number;
  
  --
  --
  --
  function GET_SWT_DTL
  ( p_dpuid         in     dpu_deal.dpu_id%type  -- ��. ����������� ��������
  , p_tt            in     oper.tt%type          -- ��� ��������
  ) return varchar2;
  
  --
  -- ����� �������������� ������� �� ���.���.���� ��� ������� �� ���.���.����
  --
  function GET_DISCREPANCY_BALANCES
  ( p_rpt_dt         in     date default null
  ) return varchar2;
    
  --
  -- ���������� ����� �������� � ��������� ���������� �� ���.���.���.���.��
  --
  procedure PAY_BACK
  ( p_ref    in  oper.ref%type
  );
$end
    
  --
  -- ��������� ������ ����в�Ͳ� �������� ����������� ������ ��
  -- (�� ����������� ��� ������� ������ �� 8-�� ����)
  --
  procedure PAY_DOC_INT
  ( p_dpuid  in      dpu_deal.dpu_id%type,  -- ��. ����������� ��������
    p_tt     in      oper.tt%type,          --
    p_dk     in      oper.dk%type,          --
    p_bdat   in      oper.datd%type,        --
    p_acc_A  in      accounts.acc%type,     --
    p_acc_B  in      accounts.acc%type,     --
    p_sum_A  in      accounts.ostc%type,    -- ���� ��� p_acc_A (������ ������)
    p_nazn   in      oper.nazn%type,        --
    p_ref    in out  oper.ref%type,         --
    p_tax    in      oper.s%type default 0  -- ���� ������� � ����������� %% ���������� � ���. ���. ��������
  );

  --
  -- ������� %% ( �� ��������� �������� / � ���� ����� )
  --
  procedure AUTO_PAYOUT_INTEREST
  ( p_bdate  in  fdat.fdat%type
  );

  --
  -- ���� �������� ���������� �������� ���� ���������� ������ 䳿
  --
  procedure AUTO_MOVE2ARCHIVE
  ( p_bdate    in  fdat.fdat%type
  );

  --
  -- ���� ����������� �� ������� %% �� ��������� ����� ���� ����������
  --
  procedure AUTO_MAKE_INT_FINALLY
  ( p_bdate  in  fdat.fdat%type
  );
  
  -- 
  -- ����������� �������: 
  -- ���� (p_dpuid = 0) - �� ������ �������� � ���� �����
  -- ���� (p_dpuid > 0) - �� �������� [p_dpuid] �� ���� [p_bdate]
  --
  procedure AUTO_MAKE_INTEREST
  ( p_dpuid  in  dpu_deal.dpu_id%type,                       -- ������������� ���. ��������
    p_bdate  in  fdat.fdat%type                              -- ���� ����������� %% (��� p_dpuid > 0)
  );

  --
  -- ��������������� ���������� �������� ��
  --
  procedure AUTO_EXTENSION
  ( p_bdate  in   fdat.fdat%type
  );

  --
  --
  --
  function get_parameters
  ( p_dpuid    dpu_dealw.dpu_id%type,  -- ��. ����������� ��������
    p_tag      dpu_dealw.tag%type      -- ��� ����������� ���������
  ) return     dpu_dealw.value%type;

  --
  -- ���������� ���������� ��������� ��������
  --
  procedure SET_PARAMETERS
  ( p_dpuid  in  dpu_dealw.dpu_id%type,  -- ��. ����������� ��������
    p_tag    in  dpu_dealw.tag%type,     -- ��� ����������� ���������
    p_value  in  dpu_dealw.value%type    -- �������� ����������� ���������
  );

  --
  -- �������� �������� ����� ����������� �������� � ��������� �����
  --
  function CHECK_PENALIZATION
  ( p_dpu_id     dpu_deal.dpu_id%type
  , p_begin_dt   dpu_deal.dat_begin%type
  ) return number;

$if DPU_PARAMS.SBER
$then
  --
  -- check bank code on belonging to internal payment system
  --
  function IS_OSCHADBANK
  ( p_mfo  dpu_ru.kf%type
  ) return number;

$end


END DPU;
/

show errors;

----------------------------------------------------------------------------------------------------

create or replace package body DPU
is
  --
  -- ���������� ���������� � ���������
  -- 
  g_body_version  constant varchar2(64)          := 'version 44.10  12.12.2017';
  
  modcode         constant varchar2(3)           := 'DPU';
  accispparam     constant varchar2(16)          := 'DPU_ISP';
  accgrpparam     constant varchar2(16)          := 'DPU_GRP';
  dpavid          constant accounts.vid%type     := 4;  -- ���������� ����
  dptop_tag       constant op_field.tag%type     := 'DPTOP';
  c_naticur_vob   constant vob.vob%type          := 6;  -- ��� ��������� "������������ �����" 
  c_frgncur_vob   constant vob.vob%type          := 46; -- ��� ��������� "�������� ������������ �����" 
  c_multcur_vob   constant vob.vob%type          := 16; -- ��� ��������� "������������� ������������ �����" 
  c_endline       constant char(2)               := chr(13)||chr(10);
  c_opendeal      constant number(1)             := 0;
  c_closdeal      constant number(1)             := 1;
  �_blkd_ins      constant accounts.blkd%type    := 12; -- ��� ���������� ����������� ���. ��������� �������� ����
  �_irvc_stpid    constant dpu_deal.id_stop%type := -1; -- ��� ������ ��� ������������ ���.��������
  
  ---
  -- Exceptions
  ---
  TASK_ALREADY_RUNNING     exception;
  pragma exception_init( TASK_ALREADY_RUNNING, -20222 );
  
  ---
  -- Types
  ---
  type r_accrec is record ( id   accounts.acc%type
                          , numb accounts.nls%type
                          , name accounts.nms%type
                          , type accounts.tip%type );
  
  type r_swift_dtls_type is record ( tag operw.tag%type
                                   , val operw.value%type );

  type t_swift_dtls_type is table of r_swift_dtls_type;

  --
  -- variables
  --

  -- 
  -- ����������� ������ ��������� ������
  --
  function HEADER_VERSION 
    return varchar2 
  is
    l_result   ALL_PLSQL_OBJECT_SETTINGS.PLSQL_CCFLAGS%type;
  begin
    return 'Package ' || $$PLSQL_UNIT || ' header '||g_header_version||'.'||chr(10)||
           'PLSQL_CCFLAGS => '||l_result;
  end HEADER_VERSION;

  --
  -- ����������� ������ ���� ������
  --
  function BODY_VERSION 
    return varchar2 
  is
    l_result   ALL_PLSQL_OBJECT_SETTINGS.PLSQL_CCFLAGS%type;
  begin
    
    begin
      select PLSQL_CCFLAGS
        into l_result
        from ALL_PLSQL_OBJECT_SETTINGS
       where OWNER = 'BARS'
         and NAME  = 'DPU'
         and TYPE  = 'PACKAGE BODY';
    exception
      when NO_DATA_FOUND then
        l_result := 'none.';
    end;
    
    RETURN 'Package ' || $$PLSQL_UNIT || ' body '||g_body_version||'.'||chr(10)||
           'PLSQL_CCFLAGS => '||l_result;
    
  end BODY_VERSION;

--
-- ����������� ���������� ����������� ������ (����������� � �����������)
--
procedure GET_ACCPARAMS
( p_dealid    in     dpu_deal.dpu_id%type,
  p_dealnum   in     dpu_deal.nd%type,
  p_dputype   in     dpu_deal.vidd%type,
  p_custid    in     dpu_deal.rnk%type,
  p_custname  in     customer.nmk%type,
  p_deptype   in     accounts.nbs%type,
  p_inttype   in     accounts.nbs%type,
  p_curcode   in     accounts.kv%type,
  p_branch    in     varchar2,
  p_mfo       in     varchar2,
  p_dpuline   in     number,
  p_termtype  in     dpu_vidd.irvk%type,
  p_depacc       out r_accrec,
  p_intacc       out r_accrec
) is
  title     constant varchar2(64) := $$PLSQL_UNIT||'.GET_ACCPARAMS';
  l_dealnum          number(38);
begin

  bars_audit.trace( '%s: entry, � %s/%s, dputype %s, customer � %s, acctype %s/%s (%s)',
                    title, to_char(p_dealid), p_dealnum, to_char(p_dputype),
                    to_char(p_custid), p_deptype, p_inttype, to_char(p_curcode) );
  bars_audit.trace( '%s: dpuline=%s, termtype=%s', title, to_char(p_dpuline), to_char(p_termtype));
  
  -- ����� ��������
  begin
    l_dealnum := to_number(p_dealnum); 
  exception 
    when value_error then
      l_dealnum := p_dealid;
  end; 
  
  -- ����� ��������� ����� � ����� ����������� ����� 
  begin
    p_depacc.numb := substr(f_newnls2( null, 'DPU', p_deptype, p_custid, l_dealnum, p_curcode ),1,14);
    p_intacc.numb := substr(f_newnls2( null, 'DPU', p_inttype, p_custid, l_dealnum, p_curcode ),1,14);
  exception 
    when others then
     bars_error.raise_nerror( modcode, 'ACCNUM_GENERATION_FAILED', p_custid, to_char(p_dputype), sqlerrm );
  end;
  
  -- �������� ������������ ������
  p_depacc.name := case 
                   when p_dpuline  = 1 
                   then bars_msg.get_msg(modcode, 'FNLS_NMS_MASK2_FLEXT1')
                   else bars_msg.get_msg(modcode, 'FNLS_NMS_MASK2_DEP')
                   end;
  p_intacc.name := bars_msg.get_msg(modcode, 'FNLS_NMS_MASK2_NBS8');

  -- ������������ ������ = ������� + ������������ ������� 
  p_depacc.name := substr(p_depacc.name||' '||p_custname, 1, 70);
  p_intacc.name := substr(p_intacc.name||' '||p_custname, 1, 70);

  -- ���������� �����.�������
  p_depacc.numb := vkrzn(substr(p_mfo, 1, 5), p_depacc.numb);
  p_intacc.numb := vkrzn(substr(p_mfo, 1, 5), p_intacc.numb);

  -- ���� ������
  p_depacc.type := case when p_dpuline = 2 then 'NL8' else 'DEP' end;
  p_intacc.type := 'DEN';

  bars_audit.trace('%s: exit with (%s,%s,%s) and (%s,%s,%s)', title, 
                   p_depacc.numb, p_depacc.type, p_depacc.name,
                   p_intacc.numb, p_intacc.type, p_intacc.name);

end GET_ACCPARAMS;

--
-- ����������� �����.����������� � ������ ������� ��� ���������� ������ 
--
procedure get_secaccparams 
( p_accmain  in      accounts.nls%type 
, p_curmain  in      accounts.kv%type
, p_accisp   in out  accounts.isp%type
, p_accgrp   in out  accounts.grp%type
) is
  title    constant  varchar2(30) := 'dpu.getsecaccparams:';
  l_grp              accounts.grp%type;
  l_isp              accounts.isp%type;
begin
  bars_audit.trace( '%s entry, {%s, %s, %s, %s}', title, p_accmain, 
                    to_char(p_curmain), to_char(p_accisp), to_char(p_accgrp) );
  
  -- �����.���. � ������ ������� - ����������������� �� ����� / �� �������������
  l_isp := BRANCH_USR.get_branch_param(accispparam); 
  l_grp := BRANCH_USR.get_branch_param(accgrpparam); 
  
  -- l_isp := nvl(l_isp, user_id);
  
  -- If ( l_grp Is Null )
  -- Then
  --   select min(ID)
  --     into l_grp
  --     from GROUPS_NBS
  --    where nbs = SubStr(p_accmain, 1, 4);
  -- Else
  --   l_grp := null;
  -- End If;
  
  p_accisp := nvl(l_isp, p_accisp);
  p_accgrp := nvl(l_grp, p_accgrp);

  bars_audit.trace('%s exit with (%s, %s)', title, to_char(p_accisp), to_char(p_accgrp)); 

end get_secaccparams;

--
-- ����� ����� ���������� �������� ��� ��������
--
function GET_EXPACC
( p_dptype   in  dpu_vidd.vidd%type     -- ��� ���� ��������
, p_balacc   in  dpu_vidd.bsd%type      -- ���.���� ��������
, p_curid    in  dpu_vidd.kv%type       -- ��� ������
, p_branch   in  varchar2               -- ��� �������������
, p_penalty  in  number default 0       -- ���� ��� (0 - ����������, 1 - �����������)
) return accounts.acc%type
is
  title     constant varchar2(30)      := 'dpu.getexpacc:';
  basecur   constant tabval.kv%type    := gl.baseval;
  sourid    constant proc_dr.sour%type := 4;
  l_accid   accounts.acc%type;
  l_accnum  accounts.nls%type;
begin

  bars_audit.trace( '%s entry, dptype=>%s, balacc=>%s, curid=>%s, branch=>%s'
                  , title, to_char(p_dptype), p_balacc, to_char(p_curid), p_branch );

  begin
    
    select decode( p_curid, basecur, decode(p_penalty, 0, g67, g67n), decode(p_penalty, 0, v67, v67n) ) 
      into l_accnum 
      from PROC_DR$BASE
     where sour   = sourid 
       and nbs    = p_balacc 
       and rezid  = p_dptype
       and branch = p_branch;
    
    bars_audit.trace('%s acc found for vidd � %s and branch %s => %s', title, 
                     to_char(p_dptype), p_branch, l_accnum);
  exception
    when NO_DATA_FOUND then
      
      select min(a.acc)
        into l_accid
        from ACCOUNTS      a
           , DPU_VIDD_OB22 o
       where o.VIDD   = p_dptype
         and a.NBS    = decode(p_penalty, 0, o.NBS_EXP , o.NBS_RED )
         and a.OB22   = decode(p_penalty, 0, o.OB22_EXP, o.OB22_RED)
         and a.BRANCH = substr(p_branch, 1, 15)
         and a.KV     = basecur
         and a.DAZS Is null;

      if l_accid is not null 
      then
        bars_audit.trace( '%s acc #%s found for vidd � %s and branch %s', title, to_char(l_accid), to_char(p_dptype), p_branch );
      else
        bars_audit.trace( '%s acc not found for branch %s', title, p_branch);
      end if;

  end;

  if (l_accid is null)
  then
     select acc
       into l_accid
       from accounts
      where nls    = l_accnum
        and kv     = basecur
        and branch = SubStr( p_branch, 1, 15 )
        and dazs   is null;
  end if;
  
  bars_audit.trace('%s exit with %s', title, to_char(l_accid));
  
  RETURN l_accid;

exception 
  when others then
    bars_error.raise_nerror( modcode, 'EXPENSACC_NOT_FOUND', to_char(p_dptype), p_branch, sqlerrm );
end get_expacc;

--
-- ����������� �������� ���� ��� ���������� ���������
--
function get_stpdat 
( p_datend   in  date,
  p_dpucode  in  char default null
) return date
is
  title  constant varchar2(30) := 'dpu.getstpdat:';
  l_date date;
begin
  
  bars_audit.trace('%s entry, {%s, %s)', title, to_char(p_datend), p_dpucode); 
  
  l_date := p_datend - 1;
  
  if (p_dpucode = 'DMND') then 
    l_date := null; 
  end if;
  
  bars_audit.trace('%s exit with %s', title, to_char(l_date)); 
  
  RETURN l_date;

end get_stpdat;

$if DPU_PARAMS.LINE8
$then
--
-- ������� ���� ���������� ���.�������� ���.��
--
Function GET_DATEND_LINE
( p_dpugen  in  dpu_deal.dpu_gen%type
) RETURN    DATE
$if dbms_db_version.version >= 11
$then
  RESULT_CACHE RELIES_ON( DPU_DEAL )
$end
Is
  l_datend  dpu_deal.dat_end%type;
Begin
  begin
    select dat_end
      into l_datend
      from dpu_deal
     where dpu_id = p_dpugen
       and closed = 0;
  exception
    when NO_DATA_FOUND then
      l_datend := null;
  end;
  
  Return l_datend;
  
End GET_DATEND_LINE;

$end

--
-- �������� �� ��������� ���������� �������� (�� ACC ���.�������)
--
function deposit_replenishment( p_depacc  in  dpu_deal.acc%type )
return number
is
  l_fladd  dpu_vidd.fl_add%type;
begin
  
  begin
    select fl_add 
      into l_fladd
      from dpu_vidd
     where vidd = ( select vidd from dpu_deal 
                     where acc = p_depacc );
  exception
    when OTHERS then
      l_fladd := null;
  end;
  
  RETURN l_fladd;
  
end deposit_replenishment;


--
-- �������� ���� ����������� � ��������� �� ���� ����
--
Function CHECK_USER_RIGHT
( p_userid  in  staff$base.id%type,
  p_level   in  number
) RETURN NUMBER
  RESULT_CACHE RELIES_ON( STAFF$BASE )
is
  l_branch  STAFF$BASE.branch%type;
begin
  
  if (p_userid is Not Null) 
  then
    
    select branch
      into l_branch
      from BARS.STAFF$BASE
     where ID = p_userid;
    
    if ( length(l_branch) <= (1 + 7 * nvl(p_level,0)) )
    then
      Return 1;  -- TRUE
    else
      Return 0;  -- FALSE
    end if;
    
  Else -- ���� �� �������� ��� �����������
    Return null; -- N/A
  End if;
  
end CHECK_USER_RIGHT;


--
-- ������ �������� �������������� R011/R013 ��� ���./����.������ �� ��������
--
procedure get_r011_r013
 (p_depnbs  in  ps.nbs%type,          -- ���.���� ����������� �����
  p_intnbs  in  ps.nbs%type,          -- ���.���� ����������� �����
  p_depr011 out specparam.r011%type,  -- �������� r011 ��� ����������� �����
  p_intr011 out specparam.r011%type,  -- �������� r011 ��� ����������� �����
  p_depr013 out specparam.r013%type,  -- �������� r013 ��� ����������� �����
  p_intr013 out specparam.r013%type)  -- �������� r013 ��� ����������� �����
is
  l_bdate date := GL.BD();
begin
  
  -- r011 for deposit account
  begin
    select r011 
      into p_depr011
      from kl_r011 
     where prem     = '��' 
       and l_bdate >= d_open
       and l_bdate <  nvl(d_close, l_bdate + 1)
       and r020     = p_depnbs
       and r020r011 is null;
  exception
    when others then 
      p_depr011 := case when p_depnbs in ('2600', '2650') then 9 else null end;
  end;
  
  -- R011 for interest account
  begin
    select r011 
      into p_intr011
      from KL_R011 
     where PREM     = '��' 
       and R020     = p_intnbs 
       and R020R011 = p_depnbs
       and D_OPEN  <= l_bdate
       and LNNVL( D_CLOSE <= l_bdate );
  exception
    when no_data_found then  
      begin 
        select R011 
          into p_intr011
          from kl_r011 
         where PREM    = '��' 
           and R020    = p_intnbs
           and R020R011 is null
           and D_OPEN <= l_bdate
           and LNNVL( D_CLOSE <= l_bdate );
      exception
        when others then 
          p_intr011 := null;
      end;
    when others then
      p_intr011 := null;
  end; 
  
  if p_intr011 is null 
  then
    p_intr011 := case 
                 when (p_depnbs = '2600' and p_intnbs = '2608') then 1
                 when (p_depnbs = '2650' and p_intnbs = '2658') then 1
                 end;
  end if;
  
  -- R013 for deposit accounts
  p_depr013 := case
               when (p_depnbs = '2600') then 7
               when (p_depnbs = '2650') then 8
               when (p_depnbs in ('2610', '2615', '2651', '2652')) then 9
               end;
  
  -- R013 for interest accounts
  p_intr013 := null;
  
end get_r011_r013;

--
-- ���������� �������������� ��� ���������� ���
--
procedure FILL_SPECPARAMS
  (p_depaccid   in  accounts.acc%type, 
   p_depacctype in  accounts.nbs%type, 
   p_intaccid   in  accounts.acc%type,
   p_intacctype in  accounts.nbs%type,
   p_d020       in  specparam.d020%type,
   p_begdate    in  dpu_deal.dat_begin%type default null
  )
is
  title     constant varchar2(30) := 'dpu.fillspecparams:';
  l_s180    specparam.s180%type;
  l_s181    specparam.s181%type;
  l_depr011 specparam.r011%type;
  l_depr012 specparam.r012%type := 2;
  l_depr013 specparam.r013%type;
  l_intr011 specparam.r011%type;
  l_intr013 specparam.r013%type;
  l_s181et  kl_r020.s181%type;
  l_depnbs  accounts.nbs%type;
  l_intnbs  accounts.nbs%type;
begin
  
  bars_audit.trace('%s entry, depacc => %s/%s, intacc => %s/%s', title, 
                    to_char(p_depaccid), p_depacctype, 
                    to_char(p_intaccid), p_intacctype); 

  if p_depacctype is not null then
     l_depnbs := p_depacctype;
  else
     select nbs into l_depnbs from accounts where acc = p_depaccid;
  end if;
  
  if p_intacctype is not null then
     l_intnbs := p_intacctype;
  else
     select nbs into l_intnbs from accounts where acc = p_intaccid;
  end if;
  
  update specparam set s180 = null, s181 = null where acc = p_depaccid;
  update specparam set s180 = null, s181 = null where acc = p_intaccid;
  
  l_s180 := fs180( acc_  => p_depaccid,
                   bdat_ => p_begdate);
  l_s181 := fs181( acc_  => p_depaccid,
                   bdat_ => p_begdate);
  
  bars_audit.trace('%s s180 = %s, s181 = %s, d020 = %s', title, l_s180, l_s181);
  
  get_r011_r013 (l_depnbs,  l_intnbs,  
                 l_depr011, l_intr011, 
                 l_depr013, l_intr013);
  
  bars_audit.trace( '%s r011(dep/int) = %s/%s, r013(dep/int) = %s/%s', title
                  , l_depr011, l_intr011, l_depr013, l_intr013); 

  update SPECPARAM
     set S180 = l_s180,
         S181 = l_s181,
         R011 = l_depr011,
         R012 = l_depr012,
         R013 = l_depr013,
         D020 = p_d020 
   where ACC  = p_depaccid;

  if (sql%rowcount=0)
  then
    insert into SPECPARAM ( ACC, S180, S181, R011, R012, R013, D020 ) 
    values ( p_depaccid, l_s180, l_s181, l_depr011, l_depr012, l_depr013, p_d020 );
  end if;

  update SPECPARAM
     set S180 = l_s180
       , S181 = l_s181
       , R011 = nvl(l_intr011,R011)
       , R013 = l_intr013
   where ACC  = p_intaccid;

  if (sql%rowcount=0)
  then
    insert into SPECPARAM ( ACC, S180, S181, R011, R013 )
    values ( p_intaccid, l_s180, l_s181, l_intr011, l_intr013 );
  end if;

  bars_audit.trace('%s exit', title); 

end FILL_SPECPARAMS;

--
-- ���������� ��������� ������ �� ���������� ��������� ��.���
--
procedure ins_dpuacc                
 (p_dpuid  in dpu_accounts.dpuid%type, -- ������������� ��������
  p_accid  in dpu_accounts.accid%type) -- ������������� �����
is
begin
  insert into dpu_accounts (dpuid, accid) values (p_dpuid, p_accid);
exception 
  when dup_val_on_index then null; 
end ins_dpuacc;

--
-- ����� ��������� � ������ ������� �� ��������
--
procedure FILL_DPU_PAYMENTS
( p_dpuid  in dpu_payments.dpu_id%type,                      -- ������������� ��������
  p_ref    in dpt_payments.ref%type                          -- �������� ���������
) IS
BEGIN
  
  bars_audit.trace( 'dpu.fill_dpu_payments: entry with (p_dpuid = %s, p_ref = %s).', to_char(p_dpuid), to_char(p_ref) );

  BEGIN
    INSERT INTO dpu_payments 
      ( dpu_id, ref ) 
    VALUES 
      ( p_dpuid, p_ref );
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      null;
    WHEN OTHERS THEN
      -- ���������� ������� �������� (��� %s) � ���������� ��������� � %s: %s
      bars_error.raise_nerror( modcode, 'LINK_DOCUMENT_FAILED', to_char(p_ref), to_char(p_dpuid), SubStr(SQLERRM,1,250) );
  END;

end FILL_DPU_PAYMENTS;


--
-- �������� �� ������������ �� ��������� �����
--
function is_insider
( p_rnk  in  dpu_deal.rnk%type
) return boolean
is
  /**
  <b>IS_INSIDER</b> - �-� �������� �� ������������ �� ��������� �����
  %param   p_rnk - ����������� ����� �볺��� � ���
  
  %version 1.0   04.02.2016
  %usage   �������� �� ������������ �� ��������� �����
  */  
  l_k060     customer.prinsider%type;
  l_retval   boolean;
begin  
  
  bars_audit.trace( 'dpu.is_insider: entry with (p_rnk = %s).', to_char(p_rnk) );
  
  begin
    
    select PRINSIDER 
      into l_k060
      from BARS.CUSTOMER
     where RNK = p_rnk;
    
    if ( l_k060 = 99 )
    then l_retval := false;
    else l_retval := true;
    end if;
    
  exception
    when NO_DATA_FOUND then
      l_retval := null;
  end;
  
  return l_retval;
  
end IS_INSIDER;

$if DPU_PARAMS.SBER
$then
--
-- check bank code on belonging to internal payment system
--
function IS_OSCHADBANK
( p_mfo  dpu_ru.kf%type  -- ��� ����� ����������
) return number
is
  l_exist number(1);
begin
  
  select case
           when EXISTS( select 1 
                          from BANKS$BASE
                         where MFOU = '300465'
                           and BLK = 0
                           and SSP Is Not Null
                           and MFO = p_mfo )
           then 1
           else 0
         end
    into l_exist
    from dual;
  
  return l_exist;
  
end IS_OSCHADBANK;

$end

--
-- �������� ����������� �������� (��������/���.����������/���������������)
--
procedure CREATE_DEAL
( p_dealnum    in  dpu_deal.nd%type,
  p_custid     in  dpu_deal.rnk%type,
  p_dputype    in  dpu_deal.vidd%type,
  p_dpusum     in  dpu_deal.sum%type,
  p_freqid     in  dpu_deal.freqv%type,
  p_comproc    in  dpu_deal.comproc%type,
  p_stopid     in  dpu_deal.id_stop%type,
  p_minsum     in  dpu_deal.min_sum%type,
  p_datz       in  dpu_deal.datz%type,
  p_datn       in  dpu_deal.dat_begin%type,
  p_dato       in  dpu_deal.dat_end%type,
  p_datv       in  dpu_deal.datv%type,
  p_deprcvbank in  dpu_deal.mfo_d%type,
  p_deprcvacnt in  dpu_deal.nls_d%type,
  p_deprcvcust in  dpu_deal.nms_d%type,
  p_intrcvbank in  dpu_deal.mfo_p%type,
  p_intrcvacnt in  dpu_deal.nls_p%type,
  p_intrcvcust in  dpu_deal.nms_p%type,
  p_branch     in  dpu_deal.branch%type,
  p_accisp     in  accounts.isp%type,
  p_accgrp     in  accounts.grp%type, 
  p_indrate    in  int_ratn.ir%type,
  p_basrate    in  int_ratn.br%type,
  p_operat     in  int_ratn.op%type,
  p_comments   in  dpu_dealw.value%type,    -- ��������
  p_trustid    in  dpu_deal.trustee_id%type,
  p_subdeal    in  number,                  -- 0-��������, 1-�����������
  p_gendpuid   in  dpu_deal.dpu_gen%type,   -- �������� �����.��������
  p_dpuid      out dpu_deal.dpu_id%type)
is
  title         constant varchar2(30)      := 'dpu.createdeal: '; 
  
  l_mfo         banks.mfo%type             := gl.amfo;
  l_userid      staff.id%type              := gl.auid;
  l_depacc      r_accrec;
  l_intacc      r_accrec;
  l_custname    customer.nmk%type;
  l_typerow     dpu_vidd%rowtype;
  l_branch      dpu_deal.branch%type;
  l_dpuid       dpu_deal.dpu_id%type;
  l_tmp         number(38);
  l_accisp      accounts.isp%type;
  l_accgrp      accounts.grp%type; 
  l_blkd        accounts.blkd%type;
  l_blkd_ins    accounts.blkd%type;
  l_blkk        accounts.blkk%type;  
  l_lim         accounts.lim%type; 
  l_mdate       accounts.mdate%type;
  l_expaccid    int_accn.acra%type;
  l_stpdat      int_accn.stp_dat%type;
  l_intrcvacnt  dpu_deal.nls_p%type;
  l_intrcvbank  dpu_deal.mfo_p%type;
  l_intrcvcust  dpu_deal.nms_p%type;
  l_combdputype dpu_deal.vidd%type;
  l_combdpuid   dpu_deal.dpu_id%type;
  l_combstopid  dpu_deal.id_stop%type;
  l_depob22     dpu_vidd_ob22.ob22_dep%type;
  l_intob22     dpu_vidd_ob22.ob22_int%type;
begin

  bars_audit.trace('%s entry, � %s, custid %s, dputype %s, grp %s', title,
                   p_dealnum, to_char(p_custid), to_char(p_dputype), to_char(p_accgrp) );
  
  -- ��������� �������
  begin
    select nmk into l_custname from customer where rnk = p_custid;
  exception 
    when no_data_found then 
      bars_error.raise_nerror(modcode, 'RNK_NOT_FOUND', to_char(p_custid));
  end;

  -- ��������� ���� ��������
  begin
    select * into l_typerow from dpu_vidd where vidd = p_dputype;
  exception 
    when no_data_found then
      bars_error.raise_nerror(modcode, 'VIDD_NOT_FOUND', to_char(p_dputype));
  end;

  -- ������� - ���������������?
  begin
    select dmnd_vidd into l_combdputype from dpu_vidd_comb where main_vidd = p_dputype;
    bars_audit.trace('%s l_combdputype - %s', title, to_char(l_combdputype));
  exception 
    when no_data_found then
      l_combdputype := null;
  end;
  
  l_branch := substr(nvl(p_branch,sys_context('bars_context','user_branch')), 1, 30);
  
  -- �������� ����������� ��������
$if dbms_db_version.version >= 11
$then
$if DPU_PARAMS.SBER
$then
    l_dpuid := bars_sqnc.get_nextval('S_CC_DEAL');
$else
    l_dpuid := S_CC_DEAL.NextVal;
$end
$else
  begin
    select s_cc_deal.nextval into l_dpuid from dual;
  exception 
    when no_data_found then
      bars_error.raise_nerror(modcode, 'CANT_GET_DPUID');
  end;
$end
  
  bars_audit.trace('%s dpu_id = %s', title, to_char(l_dpuid));
  
  -- ������ �������, �������� � ����� ����������� � ����������� ������
  get_accparams (p_dealid    =>  l_dpuid, 
                 p_dealnum   =>  p_dealnum, 
                 p_dputype   =>  p_dputype, 
                 p_custid    =>  p_custid, 
                 p_custname  =>  l_custname, 
                 p_deptype   =>  l_typerow.bsd, 
                 p_inttype   =>  l_typerow.bsn,
                 p_curcode   =>  l_typerow.kv, 
                 p_branch    =>  l_branch, 
                 p_mfo       =>  l_mfo, 
                 p_dpuline   =>  nvl(l_typerow.fl_extend, 0),
                 p_termtype  =>  l_typerow.IRVK,
                 p_depacc    =>  l_depacc, 
                 p_intacc    =>  l_intacc);
  
  -- ������ � ������ 
  l_accgrp := p_accgrp;
  l_accisp := p_accisp;
  get_secaccparams (p_accmain  =>  p_deprcvacnt, 
                    p_curmain  =>  l_typerow.kv,
                    p_accisp   =>  l_accisp,
                    p_accgrp   =>  l_accgrp);
  
  bars_audit.trace('%s accgrp = %s, accisp = %s', title, to_char(l_accgrp), to_char(l_accisp) );
  
  -- ���������� �� ������ - ��� ����������� ��������� �� ���.������
  l_blkd  := case when l_typerow.fl_extend = 2   then  8 else 0 end;
  
$if DPU_PARAMS.SBER
$then
  -- ��� ���������� ���. �� ����� ��� ������� �������� ���������
  l_blkd_ins := case when is_insider(p_custid) then �_blkd_ins else 0 end;
  
$end
  -- ���������� �� ������� - ��� ��������������� ������� ���������
  l_blkk  := case when l_combdputype is not null then 99 else 0 end;
  
  -- ����������� ������� - ��� ��������������� ������� ���������
  if l_combdputype is not null and nvl(p_minsum, 0) > 0 
  then
     l_lim := - (p_minsum * 100);
  else
     l_lim := 0;
  end if;
  
  bars_audit.trace('%s (blkd, blkk) = (%s, %s), lim = %s', title, 
                   to_char(l_blkd), to_char(l_blkk), to_char(l_lim));
  
  -- ���� ���������
  if (p_subdeal = 1 or l_typerow.dpu_code = 'DMND') 
  then
    l_mdate := null;
  else
    l_mdate := p_dato;
  end if; 
  
  -- ��������� OB22 ��� �������
  begin
    
    select ob22_dep, ob22_int 
      into l_depob22, l_intob22 
      from DPU_VIDD_OB22 
     where vidd = p_dputype
       and rownum  = 1;
    
    bars_audit.trace('%s OB22(���/����) = %s/%s', title, l_depob22, l_intob22);
    
  exception
    when NO_DATA_FOUND then 
      bars_audit.Info( title || ' �� �������� ��������� OB22 ��� ���� �������� ' || to_char(p_dputype) );
  end;
  
  -- �������� ����������� �����
  begin
    ACCREG.SetAccountAttr
    ( mod_    => 99
    , p1_     => 0
    , p2_     => 0
    , p3_     => l_accgrp
    , p4_     => l_tmp
    , rnk_    => p_custid
    , nls_    => l_depacc.numb
    , kv_     => l_typerow.kv
    , nms_    => l_depacc.name
    , tip_    => l_depacc.type
    , isp_    => l_accisp
    , accR_   => l_depacc.id
    , ob22_   => l_depob22
    , vid_    => dpavid
$if DPU_PARAMS.SBER
$then
    , blkd_   => case when l_blkd = 0 then l_blkd_ins else l_blkd end
$else
    , blkd_   => l_blkd
$end
    , blkk_   => l_blkk
    , lim_    => l_lim
    , branch_ => l_branch );
  exception
    when others then
      bars_error.raise_nerror(modcode, 'OPENACC_FAILED', l_depacc.numb, l_typerow.kv, sqlerrm);
  end;
  
  update ACCOUNTS 
     set MDATE = l_mdate
   where ACC   = l_depacc.id;
  
  bars_audit.trace('%s depaccid = %s', title, to_char(l_depacc.id));
  
  -- �������� ����������� �����
  begin
    ACCREG.SetAccountAttr
    ( mod_    => 99
    , p1_     => 0
    , p2_     => 0
    , p3_     => l_accgrp
    , p4_     => l_tmp
    , rnk_    => p_custid
    , nls_    => l_intacc.numb
    , kv_     => l_typerow.kv
    , nms_    => l_intacc.name
    , tip_    => l_intacc.type
    , isp_    => l_accisp
    , accR_   => l_intacc.id
    , ob22_   => l_intob22
    , blkd_   => l_blkd
    , branch_ => l_branch );
  exception
    when others then
      bars_error.raise_nerror(modcode, 'OPENACC_FAILED', l_intacc.numb, l_typerow.kv, sqlerrm);
  end;
  
  update ACCOUNTS 
     set MDATE = l_mdate
   where ACC   = l_intacc.id;
  
  bars_audit.trace('%s intaccid = %s', title, to_char(l_intacc.id));  
  
  -- ���� ���������� �������� ��� ��������
  l_expaccid := get_expacc( p_dptype => l_typerow.vidd,
                            p_balacc => l_typerow.bsd,
                            p_curid  => l_typerow.kv,
                            p_branch => l_branch );
  
  bars_audit.trace('%s expaccid = %s', title, to_char(l_expaccid));  

  -- ����-���� �� ���������� %%
$if DPU_PARAMS.SBER
$then
  l_stpdat := get_stpdat(p_datV, l_typerow.dpu_code); -- ��� ����� ���� ���� �����.%% = ���� ���������� -1
$else  
  l_stpdat := get_stpdat(p_datO, l_typerow.dpu_code);
$end

  if (p_comproc = 1) 
  then -- �����������
    l_intrcvacnt := substr(l_depacc.numb, 1, 14);
    l_intrcvbank := substr(l_mfo,         1,  6);
    l_intrcvcust := substr(l_depacc.name, 1, 38);
  else
    l_intrcvacnt := substr(trim(p_intrcvacnt),  1, 14);
    l_intrcvbank := substr(trim(p_intrcvbank),  1,  6);
    l_intrcvcust := substr(trim(p_intrcvcust),  1, 38);
  end if;
  
  bars_audit.trace('%s int_receiver (%s,%s,%s)', title, l_intrcvacnt, l_intrcvbank, l_intrcvcust);  
  
  -- ���������� �������� � ������
  begin
    
    insert 
      into INT_ACCN
       ( ID, ACC, ACRA, ACRB, STP_DAT,
         TT, METR, IO, BASEY, FREQ,
         KVB, NLSB, MFOB, NAMB )
    values
       ( 1, l_depacc.id, l_intacc.id, l_expaccid, l_stpdat, 
         nvl(l_typerow.tt, 'DU%'), l_typerow.metr, l_typerow.tip_ost, l_typerow.basey, l_typerow.freq_n,
         l_typerow.kv, l_intrcvacnt, l_intrcvbank,  l_intrcvcust);
    
    insert
      into INT_RATN
         ( ID, ACC, BDAT, IR, OP, BR )
    values 
         ( 1, l_depacc.id, p_datz, p_indrate, p_operat, p_basrate );
    
  exception
    when others then
      bars_error.raise_nerror(modcode, 'OPENINTCARD_FAILED', l_depacc.numb, l_typerow.kv, sqlerrm);
  end;
  
  bars_audit.trace('%s rate (%s,%s,%s)', title, to_char(p_indrate), to_char(p_operat), to_char(p_basrate));  

  -- ���������� ��������������
  fill_specparams (p_depaccid   => l_depacc.id, 
                   p_depacctype => l_typerow.bsd, 
                   p_intaccid   => l_intacc.id,
                   p_intacctype => l_typerow.bsn,
                   p_d020       => '01');
  
  -- �������� ����������� ��������
  begin
    insert into dpu_deal
      (dpu_id, nd, dpu_gen, dpu_add, user_id, 
       rnk, vidd, sum, acc,
       freqv, comproc, id_stop, min_sum, 
       datz, dat_begin, dat_end, datv,
       mfo_d, nls_d, nms_d,
       mfo_p, nls_p, nms_p,
       closed, trustee_id, branch)
    values
      (l_dpuid, p_dealnum,
      (case when l_combdputype is not null then l_dpuid else p_gendpuid end), 
      (case when l_typerow.fl_extend = 2 then 0 else null end), 
       l_userid, p_custid, p_dputype, p_dpusum * 100, l_depacc.id, p_freqid, p_comproc, 
       (case when p_subdeal = 1 then l_typerow.id_stop else p_stopid end), 
       (case when p_subdeal = 1 then null else p_minsum * 100 end), 
       p_datz, p_datn, p_dato, p_datv,
       p_deprcvbank, p_deprcvacnt, p_deprcvcust,
       l_intrcvbank, l_intrcvacnt, l_intrcvcust,
       0, p_trustid, l_branch);
  exception 
    when others then
      bars_error.raise_nerror (modcode, 'OPENDPUDEAL_FAILED', p_dealnum, sqlerrm);
  end;
  
  -- ������ ������ � ��������� ������ �� ��������� ��.���
  ins_dpuacc( l_dpuid, l_depacc.id );
  ins_dpuacc( l_dpuid, l_intacc.id );
  
  -- �������� �������� � ���������� ��������
  if ( p_comments Is Not Null )
  then
    dpu.set_parameters( l_dpuid, 'COMMENTS', SubStr(p_comments,1,250) );
  end if;
  
$if DPU_PARAMS.IRR
$then
  -- ������� � ������� �� ������������ ��������/������
  if (l_typerow.fl_extend = 0)
  then
    insert into dpu_irrqueue
      (dpu_id, branch) 
    values
      (l_dpuid, sys_context('bars_context','user_branch'));
  end if;
$end

  -- ��������������� �������
  if ( l_combdputype is not null )
  then
    
    bars_audit.trace('%s l_combdputype - %s', title, to_char(l_combdputype));
    
    begin
      create_deal( p_dealnum     => p_dealnum,
                   p_custid      => p_custid,
                   p_dputype     => l_combdputype,
                   p_dpusum      => p_dpusum,
                   p_freqid      => p_freqid,
                   p_comproc     => p_comproc, 
                   p_stopid      => p_stopid,
                   p_minsum      => p_minsum,
                   p_datz        => p_datz,
                   p_datn        => p_datn,
                   p_dato        => p_dato,
                   p_datv        => p_datv,
                   p_deprcvbank  => p_deprcvbank,
                   p_deprcvacnt  => p_deprcvacnt,
                   p_deprcvcust  => p_deprcvcust,
                   p_intrcvbank  => l_intrcvbank,
                   p_intrcvacnt  => l_intrcvacnt,
                   p_intrcvcust  => l_intrcvcust,
                   p_branch      => l_branch,
                   p_accisp      => l_accisp,
                   p_accgrp      => l_accgrp, 
$if DPU_PARAMS.SBER
$then
                   p_indrate     => round((p_indrate/2), 1), -- ��� ������� ��� (50% �� �����.������ � ����������� �� �������)
$else                               
                   p_indrate     => p_indrate,
$end                              
                   p_basrate     => p_basrate,
                   p_operat      => p_operat,
                   p_comments    => p_comments,
                   p_trustid     => p_trustid,
                   p_subdeal     => 1,
                   p_gendpuid    => l_dpuid,
                   p_dpuid       => l_combdpuid );
      bars_audit.trace('%s l_combdpuid - %s', title, to_char(l_combdpuid));
    exception
      when others then 
        bars_error.raise_nerror (modcode, 'OPENCOMBDEAL_FAILED', p_dealnum, sqlerrm);
    end;
  end if;
  
  bars_audit.trace('%s exit with %s', title, to_char(l_dpuid));
  
  p_dpuid := l_dpuid;

end create_deal;
--
--
--
procedure p_open_standart
( nd_          VARCHAR2,
  rnk_         NUMBER,
  vidd_        NUMBER,
  sum_         NUMBER,
  datz_        DATE,
  datn_        DATE,
  dato_        DATE,
  datv_        DATE,
  mfov_        VARCHAR2,
  nlsv_        VARCHAR2,
  nmsv_        VARCHAR2,
  mfop_        VARCHAR2,
  nlsp_        VARCHAR2,
  nmsp_        VARCHAR2,
  freq_        NUMBER,
  comproc_     NUMBER,
  id_stop_     NUMBER,
  min_sum_     NUMBER,
  ir_          NUMBER,
  br_          NUMBER,
  op_          NUMBER,
  comment_     VARCHAR2,
  grp_         NUMBER,
  isp_         NUMBER,
  branch_      VARCHAR2,
  trustid_     NUMBER, 
  dpu_id_      OUT NUMBER,
  err_         OUT VARCHAR2)
is
begin
  create_deal (p_dealnum     =>  nd_,
               p_custid      =>  rnk_,
               p_dputype     =>  vidd_,
               p_dpusum      =>  sum_,
               p_freqid      =>  freq_,
               p_comproc     =>  comproc_, 
               p_stopid      =>  id_stop_, 
               p_minsum      =>  min_sum_, 
               p_datz        =>  datz_,
               p_datn        =>  datn_,
               p_dato        =>  dato_,
               p_datv        =>  datv_,
               p_deprcvbank  =>  mfop_,
               p_deprcvacnt  =>  nlsp_,
               p_deprcvcust  =>  nmsp_,
               p_intrcvbank  =>  mfov_,
               p_intrcvacnt  =>  nlsv_,
               p_intrcvcust  =>  nmsv_,
               p_branch      =>  branch_,
               p_accisp      =>  isp_,
               p_accgrp      =>  grp_, 
               p_indrate     =>  ir_,
               p_basrate     =>  br_,
               p_operat      =>  op_,
               p_comments    =>  comment_,
               p_trustid     =>  trustid_,
               p_subdeal     =>  0, 
               p_gendpuid    =>  null,
               p_dpuid       =>  dpu_id_);
end p_open_standart;

--
-- �������� ������ 8-�� ������ ��� ������������ ���.����������
--
procedure IOPEN_AGRACCS
( p_agrid     in  dpu_deal.dpu_id%type,   -- �������� ���.����������
  p_agrnum    in  dpu_deal.dpu_add%type,  -- � ���.����������
  p_genid     in  dpu_deal.dpu_id%type,   -- �������� ���.��������
  p_gennum    in  dpu_deal.nd%type,       -- � ���.��������
  p_gendepacc in  dpu_deal.acc%type,      -- �����.� ���. ����� ���.��������
  p_genintacc in  dpu_deal.acc%type,      -- �����.� ����.����� ���.��������
  p_datend    in  dpu_deal.dat_end%type,  -- ���� ��������� ���.����������
  p_custid    in  dpu_deal.rnk%type,      -- ���.� �������
  p_branch    in  dpu_deal.branch%type,   -- ����� ��������
  p_custname  in  customer.nmk%type,      -- ������������ �������
  p_deptype   in  accounts.nbs%type,      -- ���.���� ��������
  p_inttype   in  accounts.nbs%type,      -- ���.���� ���������
  p_curcode   in  accounts.kv%type,       -- ��� ������
  p_mainacc   in  accounts.nls%type,      -- �������� ���� �������
  p_accisp    in  accounts.isp%type,      -- �����.���.
  p_accgrp    in  accounts.grp%type,      -- ������ �������
  p_mfo       in  banks.mfo%type,         -- ��� �����
  p_depacc    out r_accrec,               -- ��������� ���. ����� 8-�� ������
  p_intacc    out r_accrec)               -- ��������� ����.����� 8-�� ������
is
  title  constant varchar2(60) := 'dpu.iopenagraccs:';
  l_num  dpu_deal.nd%type;
  l_isp  accounts.isp%type;
  l_grp  accounts.grp%type; 
  l_tmp  number(38);
  l_blkd accounts.blkd%type := 0;
  ---
  procedure CHK_ACC_NUM
  is
  begin

    begin

      select Substr(p_depacc.numb,1,5)||Substr(to_char(trunc(p_agrid/100)),-9)
        into p_depacc.numb
        from ACCOUNTS
       where NLS = p_depacc.numb
         and KV  = p_curcode;

      p_intacc.numb := Substr(p_intacc.numb,1,5)||Substr(p_depacc.numb,6,9);

      p_depacc.numb := SubStr(vkrzn( SubStr(p_mfo,1,5), p_depacc.numb ),1,14);
      p_intacc.numb := SubStr(vkrzn( SubStr(p_mfo,1,5), p_intacc.numb ),1,14);

    exception
      when NO_DATA_FOUND then
        null;
    end;

  end CHK_ACC_NUM;
  ---
begin
  
  bars_audit.trace( '%s entry, agr � %s for � %s/%s, grp = %s', title
                  , to_char(p_agrnum), p_gennum, to_char(p_genid), to_char(p_accgrp) );
  
  l_num := substr( '000000'||p_genid, -8, 6 );
  
  -- ������ �������
  p_depacc.numb := '8'||substr(p_deptype, 2, 3)||'0'||l_num||substr('000'||p_agrnum, -3, 3);  
  p_intacc.numb := '8'||substr(p_inttype, 2, 3)||'0'||l_num||substr('000'||p_agrnum, -3, 3);

  p_depacc.numb := substr(vkrzn(substr(p_mfo,1,5), p_depacc.numb), 1, 14);
  p_intacc.numb := substr(vkrzn(substr(p_mfo,1,5), p_intacc.numb), 1, 14);

  -- �������� ������� ���. � ������ ��������
  CHK_ACC_NUM;

  -- ������������ ������ = ���.����� � ... + ������������ ������� 
  p_depacc.name := substr(bars_msg.get_msg(modcode, 'FNLS_NMS_AGREEMENT', to_char(p_agrnum))||' '||p_custname, 1, 70);
  p_intacc.name := substr(bars_msg.get_msg(modcode, 'FNLS_NMS_AGREEMENT', to_char(p_agrnum))||' '||p_custname, 1, 70);

  -- ���� ������
  p_depacc.type := 'DEP';
  p_intacc.type := 'DEN';

  -- ������ � ������ 
  l_grp := p_accgrp;
  l_isp := p_accisp;
  
  get_secaccparams( p_accmain  =>  p_mainacc, 
                    p_curmain  =>  p_curcode,
                    p_accisp   =>  l_isp,
                    p_accgrp   =>  l_grp);
  
$if DPU_PARAMS.SBER
$then
  -- ��� ���������� ���. �� ����� ��� ������� �������� ���������
  l_blkd := case when is_insider(p_custid) then �_blkd_ins else 0 end;
$end
  
  -- �������� ����������� �����
  begin
    ACCREG.SetAccountAttr
    ( mod_    => 99
    , p1_     => 0
    , p2_     => 0
    , p3_     => l_grp
    , p4_     => l_tmp
    , rnk_    => p_custid
    , nls_    => p_depacc.numb
    , kv_     => p_curcode
    , nms_    => p_depacc.name
    , tip_    => p_depacc.type
    , isp_    => l_isp
    , accR_   => p_depacc.id
    , ob22_   => null
    , pap_    => 2
    , vid_    => dpavid
    , blkd_   => l_blkd
--  , nlsalt_ => (select nls from accounts where acc = p_gendepacc)
    , branch_ => p_branch );
  exception
    when others then
      bars_error.raise_nerror( modcode, 'OPENACC_FAILED'
                             , p_depacc.numb, to_char(p_curcode), sqlerrm );
  end;

  bars_audit.trace( '%s depacc %s/%s opened, acc = %s', title
                  , p_depacc.numb, to_char(p_curcode), to_char(p_depacc.id) );

  -- �������� ����������� �����
  begin
    ACCREG.SetAccountAttr
    ( mod_    => 99
    , p1_     => 0
    , p2_     => 0
    , p3_     => l_grp
    , p4_     => l_tmp
    , rnk_    => p_custid
    , nls_    => p_intacc.numb
    , kv_     => p_curcode
    , nms_    => p_intacc.name
    , tip_    => p_intacc.type
    , isp_    => l_isp
    , accR_   => p_intacc.id
    , ob22_   => null
    , pap_    => 2
--  , nlsalt_ => (select nls from accounts where acc = p_genintacc)
    , branch_ => p_branch );
  exception
    when others then
      bars_error.raise_nerror( modcode, 'OPENACC_FAILED', 
                               p_intacc.numb, to_char(p_curcode), sqlerrm );
  end;

  bars_audit.trace( '%s intacc %s/%s opened, acc = %s', title, 
                    p_intacc.numb, to_char(p_curcode), to_char(p_intacc.id) );

  -- ���� ���������, ���������
  update ACCOUNTS 
     set MDATE  = p_datend
       , NBS    = '8'||substr(nbs, 2, 3)
       , NLSALT = (select nls from accounts where acc = p_gendepacc)
   where ACC    = p_depacc.id;
  
  update ACCOUNTS 
     set MDATE  = p_datend,
         NBS    = '8'||substr(nbs, 2, 3), 
         NLSALT = (select nls from accounts where acc = p_genintacc)
   where ACC    = p_intacc.id;
  
  -- ���������� ������������� ���.
  fill_specparams( p_depaccid   => p_depacc.id, 
                   p_depacctype => p_deptype, 
                   p_intaccid   => p_intacc.id,
                   p_intacctype => p_inttype,
                   p_d020       => '01' );
                   
  bars_audit.trace('%s exit with (%s,%s,%s) and (%s,%s,%s)', title, 
                   to_char(p_depacc.id), p_depacc.numb, p_depacc.name,
                   to_char(p_intacc.id), p_intacc.numb, p_intacc.name);
exception 
  when others then
    bars_error.raise_nerror(modcode, 'AGROPENACC_FAILED', 
                            to_char(p_agrnum), to_char(p_genid), sqlerrm);
end iopen_agraccs;

--
-- �������� ���.���������� �� 8-�� ������ � ������������ ����������� ��������
--
procedure create_agreement
 (p_dealnum    in  dpu_deal.nd%type,         -- � ���.����������
  p_custid     in  dpu_deal.rnk%type,        -- ���.� �������
  p_dputype    in  dpu_deal.vidd%type,       -- ��� ��������
  p_gendpuid   in  dpu_deal.dpu_gen%type,    -- �������� ���.��������
  p_dpusum     in  dpu_deal.sum%type,        -- ����� ���.����������
  p_freqid     in  dpu_deal.freqv%type,      -- ������-�� ������� %%
  p_comproc    in  dpu_deal.comproc%type,    -- ������� ������������� %%
  p_stopid     in  dpu_deal.id_stop%type,    -- ����� �� ��������� �����������
  p_minsum     in  dpu_deal.min_sum%type,    -- ������.�������
  p_datz       in  dpu_deal.datz%type,       -- ���� ����������
  p_datn       in  dpu_deal.dat_begin%type,  -- ���� ������
  p_dato       in  dpu_deal.dat_end%type,    -- ���� ���������
  p_datv       in  dpu_deal.datv%type,       -- ���� ��������
  p_deprcvbank in  dpu_deal.mfo_d%type,      -- ��� ��� �������� ��������
  p_deprcvacnt in  dpu_deal.nls_d%type,      -- ���� ��� �������� ��������
  p_deprcvcust in  dpu_deal.nms_d%type,      -- ������������ ��� �������� ��������
  p_intrcvbank in  dpu_deal.mfo_p%type,      -- ��� ��� ������� %%
  p_intrcvacnt in  dpu_deal.nls_p%type,      -- ���� ��� ������� %%
  p_intrcvcust in  dpu_deal.nms_p%type,      -- ������������ ��� ������� %%
  p_accisp     in  accounts.isp%type,        -- �����.�����������
  p_accgrp     in  accounts.grp%type,        -- ������ �������
  p_indrate    in  int_ratn.ir%type,         -- ���.������
  p_basrate    in  int_ratn.br%type,         -- ���.������
  p_operat     in  int_ratn.op%type,         -- �������� ����� ���.� ���.��������
  p_comments   in  dpu_dealw.value%type,     -- ��������
  p_trustid    in  dpu_deal.trustee_id%type, -- ��� ���.���� �������
  p_old_dpuid  in  dpu_deal.dpu_id%type default null, -- �������� ����� ����� (��� �����������)
  p_dpuid      out dpu_deal.dpu_id%type)     -- �������� ���.����������
is
  title            constant varchar2(30)      := 'dpu.createagrmnt:'; 
  l_mfo            constant banks.mfo%type    := gl.amfo;
  l_userid         staff.id%type              := gl.auid;
  l_custname       customer.nmk%type; 
  l_typerow        dpu_vidd%rowtype;
  l_branch         dpu_deal.branch%type;
  l_gendpunum      dpu_deal.nd%type;  
  l_gendepacc      accounts.acc%type;
  l_genintacc      accounts.acc%type;
  l_genexpacc      accounts.acc%type;
  l_addnum         dpu_deal.dpu_add%type; 
  l_dpuid          dpu_deal.dpu_id%type;
  l_depacc         r_accrec;
  l_intacc         r_accrec;
  l_stpdat         int_accn.stp_dat%type;
  l_intrcvacnt     dpu_deal.nls_p%type;
  l_intrcvbank     dpu_deal.mfo_p%type;
  l_intrcvcust     dpu_deal.nms_p%type;
  l_errmsg         varchar(1000);
begin

  bars_audit.trace( '%s Entry with ( dealnum=%s, custid=%s, dputype=%s, accgrp=%s, datv=%s ).'
                  , title, p_dealnum, to_char(p_custid), to_char(p_dputype)
                  , to_char(p_accgrp), to_char(p_datv,'dd/mm/yyyy') );
  
  -- ��������� �������
  begin
    select nmk into l_custname from customer where rnk = p_custid;
  exception 
    when no_data_found then 
      bars_error.raise_nerror(modcode, 'RNK_NOT_FOUND', to_char(p_custid));
  end;

  -- ��������� ���� ��������
  begin
    select * into l_typerow from dpu_vidd where vidd = p_dputype;
  exception 
    when no_data_found then
      bars_error.raise_nerror(modcode, 'VIDD_NOT_FOUND', to_char(p_dputype));
  end;
  
  -- ��������� ������������ ��������
  begin
    select d.branch, d.nd, i.acc, i.acra, i.acrb  
      into l_branch, l_gendpunum, l_gendepacc, l_genintacc, l_genexpacc  
      from dpu_deal d, int_accn i 
     where d.acc    = i.acc 
       and i.id     = 1 
       and d.dpu_id = p_gendpuid;
  exception
    when no_data_found then
      bars_error.raise_nerror (modcode, 'GENACC_NOT_FOUND', to_char(p_gendpuid));
  end;  
  
  -- ����� ���.����������
  l_addnum := f_next_add_number(p_gendpuid);
  
  bars_audit.trace('%s addnum = %s', title, to_char(l_addnum));
  
  -- �������� ���.����������
$if dbms_db_version.version >= 11
$then
$if DPU_PARAMS.SBER
$then
    l_dpuid := bars_sqnc.get_nextval('S_CC_DEAL');
$else
    l_dpuid := S_CC_DEAL.NextVal;
$end
$else
  begin
    select s_cc_deal.nextval into l_dpuid from dual; 
  exception 
    when no_data_found then
      bars_error.raise_nerror(modcode, 'CANT_GET_DPUID');
  end;
$end
  
  bars_audit.trace('%s dpuid = %s', title, to_char(l_dpuid));
  
  -- �������� ��� �������� �� ���������� ������ ��������
  l_errmsg := DATE_VALIDATE( p_vidd   => p_dputype, 
                             p_datbeg => p_datn,
                             p_datend => p_dato );
  
  if ( l_errmsg Is Not Null )
  then
    bars_error.raise_error( modcode, 666, l_errmsg );
  end if; 
  
$if DPU_PARAMS.LINE8
$then
  -- �������� �� "�����" �� ��� ��
  If ( l_typerow.fl_extend = 2 AND 
       p_dato > dpu.get_datend_line(p_gendpuid) ) 
  then
    bars_error.raise_nerror( modcode, 'INVALID_DATEND_TRANCHE', to_char(p_dato, 'dd/mm/yyyy'), 
                             to_char(dpu.get_datend_line(p_gendpuid), 'dd/mm/yyyy') );
  End If;
$end
  
  -- �������� ������ 8-�� ������ ��� ������������ ���.����������
  IOPEN_AGRACCS( p_agrid     => l_dpuid,
                 p_agrnum    => l_addnum,
                 p_genid     => p_gendpuid,
                 p_gennum    => l_gendpunum,
                 p_gendepacc => l_gendepacc,
                 p_genintacc => l_genintacc,
                 p_datend    => p_dato,
                 p_custid    => p_custid,
                 p_branch    => l_branch,
                 p_custname  => l_custname, 
                 p_deptype   => l_typerow.bsd,
                 p_inttype   => l_typerow.bsn,
                 p_curcode   => l_typerow.kv, 
                 p_mainacc   => p_deprcvacnt,
                 p_accisp    => p_accisp,
                 p_accgrp    => p_accgrp, 
                 p_mfo       => l_mfo,
                 p_depacc    => l_depacc,
                 p_intacc    => l_intacc);
  
  -- ���� ���������� �������� ����������� �� ���.�������� (���� ����)
  if l_genexpacc is not null 
  then
     l_typerow.acc7 := l_genexpacc;
  end if;

  -- ����-���� �� ���������� %%
$if DPU_PARAMS.SBER
$then
  l_stpdat := get_stpdat(p_datV, l_typerow.dpu_code); -- ��� ����� ���� ���� �����.%% = ���� ���������� -1
$else  
  l_stpdat := get_stpdat(p_datO, l_typerow.dpu_code);
$end

  if p_comproc = 1 
  then
     l_intrcvacnt := substr(l_depacc.numb, 1, 14);
     l_intrcvbank := substr(l_mfo,         1,  6);
     l_intrcvcust := substr(l_depacc.name, 1, 38);
  else
     l_intrcvacnt := substr(p_intrcvacnt,  1, 14);
     l_intrcvbank := substr(p_intrcvbank,  1,  6);
     l_intrcvcust := substr(p_intrcvcust,  1, 38);
  end if;
  
  bars_audit.trace('%s int_receiver (%s,%s,%s)', title, 
                   l_intrcvacnt, l_intrcvbank, l_intrcvcust);  
  
  -- ���������� �������� � ������
  begin
    insert 
      into INT_ACCN
      ( ID, ACC, ACRA, ACRB, ACR_DAT, STP_DAT, TT, 
        METR, IO, BASEY, FREQ, 
        KVB, NLSB, MFOB, NAMB )
    values
      ( 1, l_depacc.id, l_intacc.id, l_typerow.acc7, p_datz, l_stpdat, l_typerow.tt, 
        l_typerow.metr, l_typerow.tip_ost, l_typerow.basey, l_typerow.freq_n, 
        l_typerow.kv, l_intrcvacnt, l_intrcvbank,  l_intrcvcust);
        
    insert 
      into INT_RATN 
      ( ID, ACC, BDAT, IR, OP, BR )
    values
      ( 1, l_depacc.id, p_datz, p_indrate, p_operat, p_basrate );
    
  exception
    when others then
      bars_error.raise_nerror(modcode, 'OPENINTCARD_FAILED', 
                              l_depacc.numb, l_typerow.kv, sqlerrm);
  end;
  
  bars_audit.trace('%s rate (%s,%s,%s)', title, 
                   to_char(p_indrate), to_char(p_operat), to_char(p_basrate));  

  -- ���������� ��������������
  fill_specparams (p_depaccid   => l_depacc.id, 
                   p_depacctype => l_typerow.bsd, 
                   p_intaccid   => l_intacc.id,
                   p_intacctype => l_typerow.bsn,
                   p_d020       => '01');

  -- �������� ��������������� ����������
  begin
    insert into dpu_deal
      (dpu_id, nd, dpu_gen, dpu_add, user_id, rnk, vidd, 
       sum, acc, freqv, comproc, id_stop, min_sum, 
       datz, dat_begin, dat_end, datv,
       mfo_d, nls_d, nms_d, mfo_p, nls_p, nms_p,
       closed, trustee_id, branch, CNT_DUBL)
    values
      (l_dpuid, p_dealnum, p_gendpuid, l_addnum, l_userid, p_custid, p_dputype, 
       p_dpusum*100, l_depacc.id, p_freqid, p_comproc, p_stopid, p_minsum*100, 
       p_datz, p_datn, p_dato, p_datv,
       p_deprcvbank, p_deprcvacnt, p_deprcvcust,
       l_intrcvbank, l_intrcvacnt, l_intrcvcust,
       0, p_trustid, l_branch, p_old_dpuid);
  exception 
    when others then
      bars_error.raise_nerror (modcode, 'OPENDPUDEAL_FAILED', p_dealnum, sqlerrm);
  end;
  
  -- ������ ������ � ��������� ������ �� ��������� ��.���
  ins_dpuacc( l_dpuid, l_depacc.id );
  ins_dpuacc( l_dpuid, l_intacc.id );
  
  -- �������� �������� � ���������� ��������
  if ( p_comments Is Not Null )
  then
    dpu.set_parameters( l_dpuid, 'COMMENTS', SubStr(p_comments,1,250) );
  end if;
  
$if DPU_PARAMS.IRR
$then
  -- ������� � ������� �� ������������ ��������/������
  -- insert into dpu_irrqueue (dpu_id, branch) values (l_dpuid, sys_context('bars_context','user_branch'));
$end

  p_dpuid := l_dpuid;
  
  bars_audit.trace('%s exit with %s', title, to_char(p_dpuid));	

end create_agreement;
--
-- �������� ���.���������� � ����������� ��������
--
procedure p_open_deposit_line
  (nd_          varchar2,
   dpu_gen_     number,
   rnk_         number,
   vidd_        number,
   sum_         number,
   datz_        date,
   datn_        date,
   dato_        date,
   datv_        date,
   mfov_        varchar2,
   nlsv_        varchar2,
   nmsv_        varchar2,
   mfop_        varchar2,
   nlsp_        varchar2,
   nmsp_        varchar2,
   freq_        number,
   comproc_     number,
   id_stop_     number,
   min_sum_     number,
   ir_          number,
   br_          number,
   op_          number,
   comment_     varchar2,
   grp_         number,
   isp_         number,
   trustid_     number,
   old_dpuid_   dpu_deal.dpu_id%type default null,
   dpu_id_      out number,
   err_         out varchar2)
is
begin
  create_agreement( p_dealnum    => nd_,
                    p_custid     => rnk_,
                    p_dputype    => vidd_,
                    p_gendpuid   => dpu_gen_,
                    p_dpusum     => sum_,
                    p_freqid     => freq_,
                    p_comproc    => comproc_, 
                    p_stopid     => id_stop_, 
                    p_minsum     => min_sum_, 
                    p_datz       => datz_,
                    p_datn       => datn_,
                    p_dato       => dato_,
                    p_datv       => datv_,
                    p_deprcvbank => mfop_,
                    p_deprcvacnt => nlsp_,
                    p_deprcvcust => nmsp_,
                    p_intrcvbank => mfov_,
                    p_intrcvacnt => nlsv_,
                    p_intrcvcust => nmsv_,
                    p_accisp     => isp_,
                    p_accgrp     => grp_, 
                    p_indrate    => ir_,
                    p_basrate    => br_,
                    p_operat     => op_,
                    p_comments   => comment_,
                    p_trustid    => trustid_,
                    p_old_dpuid  => old_dpuid_,
                    p_dpuid      => dpu_id_);
end p_open_deposit_line;

--
-- �������� ������������ ��������� ���� ������������ ����������� �������� �� 
-- ��������������� � �������� ���������� �������� �� �������������
--
function subdeal_validation (p_dpuid in dpu_deal.dpu_id%type) return number
is
  title        constant varchar2(30) := 'dpu.subdealvalid:'; 
  l_maintypeid dpu_vidd.vidd%type;
  l_combtypeid dpu_vidd.vidd%type;
  l_result     number(1) := 0;
begin

  bars_audit.trace('%s entry, � %s', title, to_char(p_dpuid));
  
  begin
    select vidd
      into l_maintypeid
      from dpu_deal
     where dpu_id = p_dpuid 
       and closed = 0           -- ��������
       and dpu_add is null      -- �� ���������� �����
       and dpu_gen is null      -- �� ���.�������
       and dat_end is not null  -- �������
       and vidd not in          -- �� ��������� ����������������
          (select dmnd_vidd from dpu_vidd_comb);

    bars_audit.trace('%s maindputype = %s', title, to_char(l_maintypeid));

    -- ���������������?
    begin
      select dmnd_vidd 
        into l_combtypeid 
        from dpu_vidd_comb 
       where main_vidd = l_maintypeid;

      bars_audit.trace('%s combdputype = %s', title, to_char(l_combtypeid));
      
      -- ���� ���������?
      select count(*) 
        into l_result 
        from dpu_deal
       where vidd    = l_combtypeid
         and dpu_gen = p_dpuid
         and dpu_id != p_dpuid;

      bars_audit.trace('%s combdeals(cnt) = %s', title, to_char(l_result));

      l_result := case when l_result = 0 then 1 else 0 end; 
      
    exception
      when no_data_found then
        l_result := 1;
    end;

  exception 
    when no_data_found then 
      l_result := 0;
  end;

  return l_result;

end subdeal_validation;

--
-- �������� �������� ��� ��� �������/���������� ����������� ��������
--
function DATE_VALIDATE
( p_vidd      dpu_vidd.vidd%type,
  p_datbeg    date,
  p_datend    date
) return VARCHAR2
is
  title  constant  varchar2(64) := 'dpu.datevalidate';
  l_errmsg         varchar(1000);
  l_term_max       dpu_vidd.term_max%type;
  l_term_min       dpu_vidd.term_min%type;
  l_term_type      dpu_vidd.term_type%type;
  l_months         integer;
  l_days           integer;
  err_vidd         exception;
BEGIN

  bars_audit.trace( '%s: entry with (vidd = %s, dat_beg = %s, dat_end = %s ).',
                    title, to_char(p_vidd), to_char(p_datbeg, 'dd.mm.yyyy'), to_char(p_datend, 'dd.mm.yyyy') );

  begin
    select v.TERM_TYPE, v.TERM_MIN, v.TERM_MAX
      into l_term_type, l_term_min, l_term_max
      from DPU_VIDD v
     where v.VIDD = p_vidd;
  exception
    when NO_DATA_FOUND then
      raise err_vidd;
  end;

  bars_audit.trace( '%s: TERM_TYPE=%s, TERM_MIN=%s, TERM_MAX=%s.'
                  , title, to_char(l_term_type), to_char(l_term_min), to_char(l_term_max) );

  if ( l_term_type = 2 )
  then -- �������

    -- �������� �� ���������� ����� ���
    l_months := trunc(l_term_min);                 -- �-�� ������
    l_days   := ( l_term_min - l_months ) * 10000; -- �-�� ���
    
    bars_audit.trace( '%s: months_min = %s, days_min = %s', title, to_char(l_months), to_char(l_days) );
    
    if p_datend >= F_DURATION( p_datbeg, l_months, l_days )
    then
      
      -- �������� �� ���������� ������ ���
      l_months := trunc(l_term_max);                 -- �-�� ������
      l_days   := ( l_term_max - l_months ) * 10000; -- �-�� ���
    
      bars_audit.trace( '%s: months_max = %s, days_max = %s.', title, to_char(l_months), to_char(l_days) );
      
      if p_datend <= F_DURATION( p_datbeg, l_months, l_days )
      then
        l_errmsg := null;
      else
        l_errmsg := '����� ������ �� ����������� ����������� ('||to_char(l_months)||' ��. '||to_char(l_days)||' ���)!';
      end if;
      
    else
      l_errmsg := '����� ������ �� �������� ����������� ('||to_char(l_months)||' ��. '||to_char(l_days)||' ���)!';
    end if;
    
  else -- ���������

    l_months := trunc(l_term_min);                 -- �-�� ������
    l_days   := ( l_term_min - l_months ) * 10000; -- �-�� ���
    
    bars_audit.trace( '%s: months = %s, days = %s.', title, to_char(l_months), to_char(l_days) );
    
    if p_datend = F_DURATION( p_datbeg, l_months, l_days )
    then
      l_errmsg := null;
    else
      l_errmsg := '����� �� ������� ����������� ('||to_char(l_months)||' ��. '||to_char(l_days)||' ���)!';
    end if;

  end if;

  bars_audit.trace( '%s: exit with: %s.', title, to_char(l_errmsg) );

  Return l_errmsg;

EXCEPTION
  when OTHERS then
    bars_audit.trace( '%s: exit with ERROR: %s', title, 
$if dbms_db_version.version >= 10
$then
                      dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
$else
                      SQLERRM ); --  ��� ���. ����� 10
$end

    return 0;
End DATE_VALIDATE;

--
-- ��������� ���� ������������ ����������� �������� �� ��������������� 
--        � �������� ���������� �������� �� �������������
--
procedure create_subdeal 
 (p_gendpuid in  dpu_deal.dpu_id%type,    -- �������� ��������� ��������
  p_subdpuid out dpu_deal.dpu_id%type)    -- �������� ���������� ��������
is
  title      constant varchar2(30)       := 'dpu.createsubdeal:';
  blk        constant accounts.blkk%type := 99;
  l_bdate    date                        := GL.BD();
  l_dpurow   dpu_deal%rowtype;
  l_maintype dpu_vidd_comb.main_vidd%type;
  l_dmndtype dpu_vidd_comb.dmnd_vidd%type;
  l_accisp   accounts.isp%type;
  l_accgrp   accounts.grp%type;
  l_indrate  int_ratn.ir%type;
  l_basrate  int_ratn.br%type;
  l_operat   int_ratn.op%type;
  l_subdpuid dpu_deal.dpu_id%type;
begin

  bars_audit.trace('%s entry, � %s', title, to_char(p_gendpuid));

  -- ��������� ������������ ����������� ��������
  begin
    select * into l_dpurow from dpu_deal where dpu_id = p_gendpuid;
  exception 
    when no_data_found then
      bars_error.raise_nerror(modcode, 'DPUID_NOT_FOUND', to_char(p_gendpuid));
  end;
  bars_audit.trace( '%s dpu_num = %s, cust_id = %s, vidd = %s', title
                  , l_dpurow.nd, to_char(l_dpurow.rnk), to_char(l_dpurow.vidd) );

  -- �������� ������������ ��������� ���� ��������
  if subdeal_validation (p_gendpuid) = 0 then
     bars_error.raise_nerror(modcode, 'CRTSUBDEAL_NOTVALID', to_char(p_gendpuid));
  end if;

  -- ����� ���������� ���� ��������������� ����� ���������
  begin
    select c.main_vidd, c.dmnd_vidd 
      into l_maintype, l_dmndtype 
      from dpu_vidd v, dpu_vidd_comb c, dpu_vidd m
     where v.vidd  = l_dpurow.vidd 
       and v.kv    = m.kv
       and v.bsd   = m.bsd
       and v.bsn   = m.bsn
       and m.flag  = 1
       and m.vidd != v.vidd
       and m.vidd  = c.main_vidd
       and rownum  = 1;
  exception 
    when no_data_found then
     -- �� ������ ��������������� ��� �������� ��� ���� �������� �
     bars_error.raise_nerror(modcode, 'CRTSUBDEAL_NOCOMBTYPE', to_char(l_dpurow.vidd));
  end;
  bars_audit.trace('%s main/dmnd = %s/%s', title, to_char(l_maintype), to_char(l_dmndtype));
   
  begin
    select a.isp, a.grp, r.ir, r.op, r.br 
      into l_accisp, l_accgrp, l_indrate, l_operat, l_basrate 
      from accounts a, int_ratn r
     where a.acc  = l_dpurow.acc
       and a.acc  = r.acc
       and r.id   = 1
       and r.bdat = (select max(i.bdat)
                       from int_ratn i
                      where i.acc   = r.acc
                        and i.id    = r.id
                        and i.bdat <= l_bdate);
  exception 
    when no_data_found then
     -- �� ������� ���������� ������ �� �������� � 
     bars_error.raise_nerror(modcode, 'CRTSUBDEAL_NORATE', to_char(p_gendpuid));
  end;
  bars_audit.trace('%s accisp/accgrp = %s/%s',   title, to_char(l_accisp),  to_char(l_accgrp));
  bars_audit.trace('%s indrate/basrate = %s/%s', title, to_char(l_indrate), to_char(l_basrate));
  
  -- ��������� ������������ ������� � ���������� �� ������� �� ���.�����
  update accounts 
     set lim  = nvl(-l_dpurow.min_sum, 0),
         blkk = blk
   where acc  = l_dpurow.acc;
  bars_audit.trace('%s accounts.lim => %s', title, to_char(nvl(-l_dpurow.min_sum, 0)));
  
  -- ��������� ���� �������� ��� ��������� ��������
  update dpu_deal 
     set vidd    = l_maintype,
         dpu_gen = dpu_id 
   where dpu_id  = p_gendpuid;
  bars_audit.trace('%s dpu_deal.vidd => %s', title, to_char(l_maintype));
     
  begin
    create_deal( p_dealnum    => l_dpurow.nd,
                 p_custid     => l_dpurow.rnk,
                 p_dputype    => l_dmndtype,
                 p_dpusum     => l_dpurow.sum/100,
                 p_freqid     => l_dpurow.freqv,
                 p_comproc    => l_dpurow.comproc, 
                 p_stopid     => l_dpurow.id_stop,
                 p_minsum     => l_dpurow.min_sum/100,
                 p_datz       => l_dpurow.datz,
                 p_datn       => l_dpurow.dat_begin,
                 p_dato       => l_dpurow.dat_end,
                 p_datv       => l_dpurow.datv,
                 p_deprcvbank => l_dpurow.mfo_d,
                 p_deprcvacnt => l_dpurow.nls_d,
                 p_deprcvcust => l_dpurow.nms_d,
                 p_intrcvbank => l_dpurow.mfo_p,
                 p_intrcvacnt => l_dpurow.nls_p,
                 p_intrcvcust => l_dpurow.nms_p,
                 p_branch     => l_dpurow.branch,
                 p_accisp     => l_accisp,
                 p_accgrp     => l_accgrp, 
                 p_indrate    => l_indrate,
                 p_basrate    => l_basrate,
                 p_operat     => l_operat,
                 p_comments   => DPU.get_parameters( p_gendpuid, 'COMMENTS' ),
                 p_trustid    => l_dpurow.trustee_id,
                 p_subdeal    => 1,
                 p_gendpuid   => p_gendpuid,
                 p_dpuid      => l_subdpuid);
    bars_audit.trace('%s subdpuid = %s', title, to_char(l_subdpuid));
  exception
    when others then 
      -- ������ ��� �������� ���������� �������� ��� ����.�������� � 
      bars_error.raise_nerror (modcode, 'CRTSUBDEAL_FAILED', to_char(p_gendpuid), sqlerrm);
  end;
  
  p_subdpuid := l_subdpuid;

end create_subdeal;

--
-- ������ ������ ���.���������� � ������������ ��������
--
function f_next_add_number(p_gendpuid in dpu_deal.dpu_gen%type) return number
is
  l_addnum dpu_deal.dpu_add%type;
begin
$if DPU_PARAMS.SBER
$then
  select nvl(count(dpu_add), 0) + 1 
    into l_addnum
    from dpu_deal
   where dpu_gen = p_gendpuid;
$else
  select nvl(max(dpu_add), 0) + 1 
    into l_addnum
    from dpu_deal
   where dpu_gen = p_gendpuid;
$end
  return l_addnum;
exception 
  when others then
    return null;
end f_next_add_number;

--
-- ������ %-��� ������ ��� �������� ����������� �������� �� 
--  �� ����� � ����������� �� ����, ����� � ����� ��������
--
function f_calc_rate
( p_vidd    dpu_vidd_rate.vidd%type,   -- ��� ��������
  p_datbeg  date,                      -- ���� ������ ��������
  p_datend  date,                      -- ���� ��������� ��������
  p_amount  dpu_vidd_rate.limit%type   -- ����� �������� (����� �����)
) return number 
is
  title     varchar2(60) := 'dpu.fcalcrate:';
  l_actrate dpu_vidd_rate.rate%type;
  l_maxrate dpu_vidd_rate.max_rate%type;
  l_recid   dpu_vidd_rate.id%type;
begin

  bars_audit.trace( '%s entry with {%s,%s,%s,%s}', title, to_char(p_vidd),
                    to_char(p_datbeg), to_char(p_datend), to_char(p_amount) );
                          
  get_scalerate (p_typeid   => null,
                 p_kv       => null,
                 p_vidd     => p_vidd,
                 p_amount   => p_amount,
                 p_datbeg   => p_datbeg,
                 p_datend   => p_datend,
                 p_actrate  => l_actrate,
                 p_maxrate  => l_maxrate,
                 p_recid    => l_recid);

  bars_audit.trace('%s exit with rate = '||to_char(l_actrate));
  
  return l_actrate;

end f_calc_rate;

--
-- ������ ������������ ����������� ��������
--
FUNCTION f_duration 
( p_date_open  DATE, 
  p_term_mnth  INTEGER, 
  p_term_days  INTEGER
) RETURN DATE
--DETERMINISTIC
IS
--***************************************************************************--
--                ������ ������������ ����������� ��������                   --
--***************************************************************************--
  title       constant varchar2(30) := 'dpu.f_duration:'; 
  l_day_open           integer;
  l_datM               date;
  l_dayM_last          integer;
  l_dat                date;
  l_datH               date;
BEGIN
  
  bars_audit.trace( '%s f_duration = %s, p_term_mnth = %s, p_term_days = %s.'
                  , title, to_char(p_date_open,'dd.mm.yyyy'), to_char(p_term_mnth), to_char(p_term_days) );
  
  IF NVL(p_term_mnth, 0) = 0 AND NVL(p_term_days, 0) = 0 
  THEN
    RETURN p_date_open;
  END IF; 
  
  -- ���� ��������      
  l_day_open := to_number(to_char(p_date_open,'DD'));  

  -- ���� �������� + DELTA �������
  l_datM := add_months(trunc(p_date_open,'MM'), nvl(p_term_mnth,0) );
  
  -- ��������� ���� ��� ���� �������� + DELTA �������
  l_dayM_last := extract( day from last_day(l_datM) );
  
  -- ��������� ��������� ���� ������ 
  IF l_dayM_last < l_day_open 
  THEN
     l_dat := add_months(l_datM, 1);
  ELSE
     l_dat := l_datM + l_day_open - 1;
  END IF;
  
$if DPU_PARAMS.SBER
$then
  -- ���� ��������� ����������� � ����� ��������
  l_dat := l_dat + NVL(p_term_days, 0) - 1;
$else
  l_dat := l_dat + NVL(p_term_days, 0);
$end
  
$if DPU_PARAMS.HOLI
$then
  -- ��������� ������� ����, ��������� �� ����� ���������
  BEGIN
    SELECT dat_next_u(holiday,1)
      INTO l_datH 
      FROM holiday
     WHERE kv = gl.baseval 
       AND holiday = l_dat;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
      l_datH := l_dat;
  END;
  
  RETURN l_datH;
$else
  RETURN l_dat;
$end

END f_duration;

--
-- ������� ����������� ��������� ��������
--
procedure fill_operw
( p_ref  in  operw.ref%type,
  p_tag  in  operw.tag%type,
  p_val  in  operw.value%type
)
is
begin
  insert into OPERW
    (REF, TAG, VALUE)
  values
    (p_ref, p_tag, p_val);
exception
  when DUP_VAL_ON_INDEX then
    update OPERW
       set VALUE = p_val
     where REF   = p_ref
       and TAG   = p_tag;
  when OTHERS then
    bars_audit.error( 'DPU.fill_operw: ������� ������� ����������� �������� �������� =>'||
                      chr(10)||dbms_utility.format_error_stack()||
$if dbms_db_version.version >= 10
$then
                      dbms_utility.format_error_backtrace() );
$else
                      sqlErrm() );
$end
    raise;
end FILL_OPERW;

--
-- ���� ����, ����������� �� ���.����, �� ����������.������ ���.���������� (���������)
--
procedure p_genacc_receipt 
( p_docref   oper.ref%type,        -- ���.���������-����������� �� ���.����
  p_docdat   oper.vdat%type,       -- ���� ����������� �� ���.����
  p_docsum   oper.s%type,          -- ����� ����������� �� ���.����
  p_genacc   accounts.acc%type,    -- ��� ������.����� ���.��������
  p_addacc   accounts.acc%type)    -- ��� ������������� ����� ���.����������
is
  title      constant varchar2(60) := 'dpu.genaccrcpt:';
  l_ref      nlk_ref.ref2%type;
  l_amnt     oper.s%type;
  l_doc_dt   oper.vdat%type;
  l_nls8600  accounts.nls%type;
  l_nlsDEP   accounts.nls%type;
  l_kv       accounts.kv%type;
  l_dpuid    dpu_deal.dpu_id%type; -- ��. ������ �������� ��������� ��
  ora_lock   exception;
  pragma exception_init(ora_lock, -54);
begin

  bars_audit.trace('%s entry, ref=>%s,dat=>%s,sum=>%s,gen=>%s,add=>%s,', title, 
                   to_char(p_docref), to_char(p_docdat,'dd.mm.yyyy'),
                   to_char(p_docsum), to_char(p_genacc), to_char(p_addacc));
  
  begin
    select ref2 
      into l_ref 
      from NLK_REF
     where ref1 = p_docref 
       and acc  = p_genacc 
       and ref2 is null
       for update of ref2 nowait;
  exception
    when ora_lock then
      bars_error.raise_nerror(modcode, 'GENACC_RECEIPT_LOCKED', to_char(p_docref));
  end;
  
  begin
    
    select S, VDAT
      into l_amnt, l_doc_dt
      from OPER
     where REF = p_docref
       and SOS = 5;
    
    if ( l_amnt = p_docsum )
    then
      null;
    else
      bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '���� ��������� #'||to_char(p_docref)||' �� ������� �������� ��� '||to_char(p_docsum) );
    end if;
    
    if ( l_doc_dt = p_docdat )
    then
      null;
    else
      bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '���� ��������� #'||to_char(p_docref)||' �� ������� �������� ��� '||to_char(p_docdat,'dd/mm/yyyy') );
    end if;
    
  exception
    when NO_DATA_FOUND then
      bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�� �������� �������� #'||to_char(p_docref)||'!' );
  end;
  
  begin
    -- ��������� ���.����.���� = ���� ����������� �������
    -- gl.bdate := p_docdat;
    GL.PL_DAT( p_docdat );
    
    begin
      select a.nls, a.kv, d.dpu_id
        into l_nlsDEP, l_kv, l_dpuid
        from ACCOUNTS a
        join DPU_DEAL d
          on ( d.acc = a.acc )
       where a.acc = p_addacc
         and a.dazs is Null
         and d.closed = 0;
    exception
      when NO_DATA_FOUND then 
        bars_error.raise_error( modcode, 666, '������� (ACC=' || to_char(p_addacc) || ') �������� ��� �������� ��������� ������ ��������� ��!' );
    end;
    
    l_nls8600 := VKRZN( SubStr( GL.KF(), 1, 5 ), '86000000000000' );
    
    GL.PAYV( null, p_docref,  p_docdat, 'DU8', 1,
             l_kv, l_nls8600, p_docsum,
             l_kv, l_nlsDEP , p_docsum );
    
    FILL_OPERW( p_docref, 'ND', to_char(l_dpuid) );
    
    FILL_DPU_PAYMENTS( l_dpuid, p_docref );
    
    -- ������� � �������� �������
    GL.PL_DAT( GL.GBD() );
    
    -- �������� ��������� �� ���������
    update NLK_REF
       set REF2 = ref1
     where REF1 = p_docref
       and ACC  = p_genacc;

  exception
    when others then
      bars_error.raise_nerror( modcode, 'GENACC_RECEIPT_FAILED', to_char(p_docref), sqlerrm );
  end;

  bars_audit.trace('%s exit', title);

end p_genacc_receipt;

--
-- ����������� ����.���� ��� �������-���������� �� ���� �� ��������.�������� 
--
function get_combinpaymentdat (p_docdate in date) return date
is
  l_date fdat.fdat%type;
  l_stat fdat.stat%type;
begin
  
  begin
    select nvl(STAT,0) into l_stat from FDAT where FDAT = p_docdate;
  exception 
    when no_data_found then l_stat := 9;
  end;

  if l_stat = 9 
  then
     l_date := GL.BD();
  else
     l_date := p_docdate;
  end if;
  
  return l_date;
  
end get_combinpaymentdat;

--
-- ������������� ����������� �� ��������������� ��������
--
procedure breakdown_combinpayments 
 (p_docref   in  oper.ref%type,         -- �������� �������-�����������
  p_mainid   in  dpu_deal.dpu_id%type,  -- �������� ���������  ������.��������
  p_dmndid   in  dpu_deal.dpu_id%type,  -- �������� ���������� ������.��������
  p_mainref  out oper.ref%type,         -- �������� ���������� �� �������� ����
  p_dmndref  out oper.ref%type)         -- �������� ���������� �� ��������� ����
is 
  title varchar2(30) := 'dpu.breakdowncombinpayments:';
  type  t_dpurec is record (id      dpu_deal.dpu_id%type,
                            num     dpu_deal.nd%type,
                            dat     dpu_deal.datz%type,
                            custid  dpu_deal.rnk%type,
                            accid   dpu_deal.acc%type,
                            typeid  dpu_deal.vidd%type,
                            datbeg  dpu_deal.dat_begin%type,
                            datend  dpu_deal.dat_end%type,
                            minsum  dpu_deal.min_sum%type); 
  type r_accrec is  record (acc     accounts.acc%type,
                            nls     accounts.nls%type,
                            kv      accounts.kv%type,
                            rnk     accounts.rnk%type, 
                            nms     accounts.nms%type,
                            ostc    accounts.ostc%type,
                            ostb    accounts.ostb%type,
                            dazs    accounts.dazs%type); 
  l_basecur  tabval.kv%type  := gl.baseval;
  l_bdate    fdat.fdat%type  := GL.BD();
  l_mfo      banks.mfo%type  := GL.KF();
  l_doc      oper%rowtype;
  l_maindpu  t_dpurec;
  l_dmnddpu  t_dpurec;
  l_mainacc  r_accrec;
  l_dmndacc  r_accrec;
  l_custcode oper.id_b%type; 
  l_mainsum  oper.s%type;
  l_dmndsum  oper.s%type;
  l_tt       oper.tt%type;
  l_vob      oper.vob%type := 6;
  l_dk       oper.dk%type  := 1;
  l_ref      oper.ref%type;
  l_nazn     oper.nazn%type;
  l_vdat     oper.vdat%type;
begin
  
  bars_audit.trace('%s entry, ref => %s, main � => %s, dmnd � => %s', title, 
                   to_char(p_docref), to_char(p_mainid), to_char(p_dmndid));  
  
  -- ��������� �������-����������� �� ���������� ����
  begin
    select o.*
      into l_doc
      from nlk_ref n, oper o, accounts a
     where n.ref1 = o.ref
       and n.acc  = a.acc
       and o.sos  = 5 
       and n.ref1 = p_docref
       and n.ref2 is null 
     for update of n.ref2 nowait;
  exception
    when others then
      bars_error.raise_nerror (modcode, 'COMB_INPAYMENT_NOT_FOUND', to_char(p_docref)); 
  end;
  bars_audit.trace('%s transit acc - %s, amount - %s', title, l_doc.nlsb, to_char(l_doc.s));  
    
  -- ��������� ��������� ��������
  begin
    select dpu_id, nd, datz, rnk, acc, vidd, dat_begin, dat_end, nvl(min_sum, 0)
      into l_maindpu 
      from dpu_deal 
     where dpu_id = p_mainid;
  exception
    when no_data_found then
      bars_error.raise_nerror (modcode, 'COMB_DEAL_NOT_FOUND', to_char(p_mainid)); 
  end;
  bars_audit.trace('%s main � %s, limit %s', title, l_maindpu.num, to_char(l_maindpu.minsum));  
   
  -- ��������� ���������� ��������
  begin
    select dpu_id, nd, datz, rnk, acc, vidd, dat_begin, dat_end, nvl(min_sum, 0)
      into l_dmnddpu 
      from dpu_deal 
     where dpu_id = p_dmndid;
  exception
    when no_data_found then
      bars_error.raise_nerror (modcode, 'COMB_DEAL_NOT_FOUND', to_char(p_dmndid)); 
  end;
  bars_audit.trace('%s dmnd � %s, limit %s', title, l_dmnddpu.num, to_char(l_dmnddpu.minsum));  

  -- ��������� ��������� �����
  begin
    select acc, nls, kv, rnk, substr(nms, 1, 38), ostc, ostb, dazs 
      into l_mainacc 
      from accounts 
     where acc = l_maindpu.accid;
  exception
    when no_data_found then
      bars_error.raise_nerror (modcode, 'COMB_ACC_NOT_FOUND', l_maindpu.num); 
  end;
  bars_audit.trace('%s saldo(main � %s) = %s', title, l_mainacc.nls, to_char(l_mainacc.ostc));  

  -- ��������� ���������� �����
  begin
    select acc, nls, kv, rnk, substr(nms, 1, 38), ostc, ostb, dazs 
      into l_dmndacc 
      from accounts 
     where acc = l_dmnddpu.accid;
  exception
    when no_data_found then
      bars_error.raise_nerror (modcode, 'COMB_ACC_NOT_FOUND', l_dmnddpu.num); 
  end;
  bars_audit.trace('%s saldo(dmnd � %s) = %s', title, l_dmndacc.nls, to_char(l_dmndacc.ostc)); 
  
  -- ��������� ��������
  if l_mainacc.ostc != l_mainacc.ostb
  then
    bars_error.raise_nerror (modcode, 'COMB_SALDOCHECK_FAILED', l_mainacc.nls, to_char(l_mainacc.kv)); 
  elsif l_dmndacc.ostc != l_dmndacc.ostb 
  then
    bars_error.raise_nerror (modcode, 'COMB_SALDOCHECK_FAILED', l_dmndacc.nls, to_char(l_dmndacc.kv)); 
  elsif l_mainacc.dazs is not null 
  then
    bars_error.raise_nerror (modcode, 'COMB_ACCOPENCHECK_FAILED', l_mainacc.nls, to_char(l_mainacc.kv)); 
  elsif l_dmndacc.dazs is not null
  then
    bars_error.raise_nerror (modcode, 'COMB_ACCOPENCHECK_FAILED', l_dmndacc.nls, to_char(l_dmndacc.kv)); 
  elsif l_mainacc.kv != l_doc.kv
  then
    bars_error.raise_nerror (modcode, 'COMB_CURRENCYCHECK_FAILED', to_char(l_doc.kv), l_mainacc.nls, to_char(l_mainacc.kv)); 
  elsif l_dmndacc.kv != l_doc.kv
  then
    bars_error.raise_nerror (modcode, 'COMB_CURRENCYCHECK_FAILED', to_char(l_doc.kv), l_dmndacc.nls, to_char(l_dmndacc.kv)); 
  elsif l_maindpu.custid != l_dmnddpu.custid
  then
    bars_error.raise_nerror (modcode, 'COMB_CUSTCHECK_FAILED', l_maindpu.num, l_dmnddpu.num); 
  elsif l_maindpu.datbeg > l_bdate or l_maindpu.datend <= l_bdate
  then
    bars_error.raise_nerror (modcode, 'COMB_DEALDAT_FAILED', l_maindpu.num); 
  elsif l_dmnddpu.datbeg > l_bdate or l_dmnddpu.datend <= l_bdate
  then
    bars_error.raise_nerror (modcode, 'COMB_DEALDAT_FAILED', l_dmnddpu.num); 
  else
    -- �������� �������������� ��������� � ��������� ��������������� ��������� 
    begin
      select okpo
        into l_custcode
        from customer
       where rnk = l_maindpu.custid
         and exists (select 1 
                       from dpu_vidd_comb b 
                      where b.main_vidd = l_maindpu.typeid  
                        and b.dmnd_vidd = l_dmnddpu.typeid);
    exception
      when no_data_found then
        bars_error.raise_nerror (modcode, 'COMB_INVALID_DPUTYPE', l_maindpu.num, l_dmnddpu.num); 
    end;
  end if;
  
  bars_audit.trace('%s check succ. passed', title);  
  
  -- ����� � ����������   
  l_mainsum := least (l_doc.s, greatest(0, l_maindpu.minsum - l_mainacc.ostc));           
  bars_audit.trace('%s main sum = %s', title, to_char(l_mainsum));  

  l_dmndsum := greatest(0, l_doc.s - l_mainsum);
  bars_audit.trace('%s dmnd sum = %s', title, to_char(l_dmndsum));  
 
  -- ��� ��������
  begin
    select t.tt 
      into l_tt
      from tts t, op_rules o
     where t.tt like 'DU%' 
       and t.tt   = o.tt 
       and o.tag  = dptop_tag -- 'DPTOP' 
       and o.val  = '0'
       and rownum = 1;
  exception
    when no_data_found then
      bars_error.raise_nerror (modcode, 'COMB_TT_NOT_FOUND');
  end;
  
  -- ��� ���������
  begin
    select vob 
      into l_vob 
      from tts_vob 
     where tt = l_tt 
       and decode(l_doc.kv, l_basecur, 1, 2) = nvl(ord, 1);
  exception
    when no_data_found or too_many_rows then null;
  end;
  
  -- ���������� �������
  select trim(nazn) into l_nazn from tts where tt = l_tt;
  
  if l_nazn is null then
     l_nazn := substr(l_doc.nazn, 1, 160);
  else
     l_nazn := substr(replace (l_nazn, '#(DPUNUM)', l_maindpu.num),                       1, 160);
     l_nazn := substr(replace (l_nazn, '#(DPUDAT)', to_char(l_maindpu.dat,'dd.mm.yyyy')), 1, 160);
  end if;
  
  bars_audit.trace('%s nazn = %s', title, l_nazn);

  -- ���� ���������� �������
  l_vdat := get_combinpaymentdat (l_doc.vdat); 

  bars_audit.trace('%s vdat = %s', title, to_char(l_vdat, 'dd.mm.yyyy'));

  begin

    savepoint sp_comb; 

    -- ���������� �� �������� ���������� ����
    if l_mainsum > 0 
    then
      gl.ref( l_ref );
      gl.in_doc3( ref_   => l_ref, 
                  tt_    => l_tt,         dk_    => l_dk,
                  vob_   => l_vob,        nd_    => SubStr(to_char(l_ref),1,10),
                  pdat_  => sysdate,      data_  => l_bdate,   
                  vdat_  => l_vdat,       datp_  => l_bdate,     
                  kv_    => l_mainacc.kv, kv2_   => l_mainacc.kv,
                  s_     => l_mainsum,    s2_    => l_mainsum,
                  mfoa_  => l_mfo,        mfob_  => l_mfo,
                  nlsa_  => l_doc.nlsb,   nlsb_  => l_mainacc.nls,
                  nam_a_ => l_doc.nam_b,  nam_b_ => l_mainacc.nms, 
                  id_a_  => l_doc.id_b,   id_b_  => l_custcode,
                  nazn_  => l_nazn,       uid_   => null,
                  d_rec_ => null,         sk_    => null,
                  id_o_  => null,         sign_  => null,
                  sos_   => null,         prty_  => null );
      paytt( null, 
             l_ref, 
             l_vdat, 
             l_tt, 
             l_dk, 
             l_mainacc.kv, 
             l_doc.nlsb,  
             l_mainsum, 
             l_mainacc.kv, 
             l_mainacc.nls,
             l_mainsum);
       bars_audit.financial(title||' �������� � '||to_char(l_ref));
       p_mainref := l_ref;
    end if;
    
    -- ���������� �� ��������� ���������� ����
    if l_dmndsum > 0 then
       gl.ref (l_ref);
       gl.in_doc3 (ref_   => l_ref, 
                   tt_    => l_tt,         dk_    => l_dk,
                   vob_   => l_vob,        nd_    => SubStr(to_char(l_ref),1,10),   
                   pdat_  => sysdate,      data_  => l_bdate,   
                   vdat_  => l_vdat,       datp_  => l_bdate,     
                   kv_    => l_dmndacc.kv, kv2_   => l_dmndacc.kv,
                   s_     => l_dmndsum,    s2_    => l_dmndsum,
                   mfoa_  => l_mfo,        mfob_  => l_mfo,
                   nlsa_  => l_doc.nlsb,   nlsb_  => l_dmndacc.nls,
                   nam_a_ => l_doc.nam_b,  nam_b_ => l_dmndacc.nms, 
                   id_a_  => l_doc.id_b,   id_b_  => l_custcode,
                   nazn_  => l_nazn,       uid_   => null,  
                   d_rec_ => null,         sk_    => null,
                   id_o_  => null,         sign_  => null,
                   sos_   => null,         prty_  => null);
       paytt (null, 
             l_ref, 
             l_vdat, 
             l_tt, 
             l_dk, 
             l_dmndacc.kv, 
             l_doc.nlsb,  
             l_dmndsum, 
             l_dmndacc.kv, 
             l_dmndacc.nls,
             l_dmndsum);
       bars_audit.financial(title||' �������� � '||to_char(l_ref));
       p_dmndref := l_ref; 
    end if;
  
    update nlk_ref set ref2 = nvl(p_mainref, p_dmndref) where ref1 = p_docref; 
    if sql%rowcount = 0 then
       bars_error.raise_nerror (modcode, 'COMB_NLKREFUPD_FAILED', to_char(p_docref)); 
    end if; 
  exception
    when others then
      rollback to sp_comb;
      bars_error.raise_nerror (modcode, 'COMB_BREAKDOWN_FAILED', 
                               l_mainsum, l_mainacc.nls, l_mainacc.kv, 
                               l_dmndsum, l_dmndacc.nls, l_dmndacc.kv, sqlerrm); 
  end;  

  bars_audit.trace('%s exit with (%s, %s)', title, to_char(p_mainref), to_char(p_dmndref));

end breakdown_combinpayments;

--
-- ��������� ���������� ����������� �������� ��
--
procedure upd_dealparams 
 (p_dealid   in  dpu_deal.dpu_id%type,                 -- ������������� ��������
  p_dealnum  in  dpu_deal.nd%type,                     -- ����� ��������
  p_dealsum  in  dpu_deal.sum%type,                    -- ����� ��������
  p_minsum   in  dpu_deal.min_sum%type,                -- ����� ������.�������
  p_freqid   in  dpu_deal.freqv%type,                  -- ������-�� ������� ���������
  p_stopid   in  dpu_deal.id_stop%type,                -- ����� �� ��������� �����������
  p_datreg   in  dpu_deal.datz%type,                   -- ���� ���������� ��������
  p_datbeg   in  dpu_deal.dat_begin%type,              -- ���� ������ ��������
  p_datend   in  dpu_deal.dat_end%type,                -- ���� ��������� ��������
  p_datret   in  dpu_deal.datv%type,                   -- ���� �������� ��������
  p_depmfo   in  dpu_deal.mfo_d%type,                  -- ��� ��� �������� ��������
  p_depnls   in  dpu_deal.nls_d%type,                  -- ���� ��� �������� ��������
  p_depnms   in  dpu_deal.nms_d%type,                  -- ���������� ��� �������� ��������
  p_intmfo   in  dpu_deal.mfo_p%type,                  -- ��� ��� ������� ���������
  p_intnls   in  dpu_deal.nls_p%type,                  -- ���� ��� ������� ���������
  p_intnms   in  dpu_deal.nms_p%type,                  -- ���������� ��� ������� ���������
  p_intokpo  in  dpu_deal.okpo_p%type,                 -- ���� ��� ������� ���������
  p_indrate  in  int_ratn.ir%type,                     -- �������������� ������
  p_operid   in  int_ratn.op%type,                     -- ��� �������.�������� ����� �������� 
  p_basrate  in  int_ratn.br%type,                     -- ������� ������
  p_ratedat  in  int_ratn.bdat%type,                   -- ���� ��������� ������
  p_branch   in  dpu_deal.branch%type,                 -- ��� ������������� �����
  p_trustid  in  dpu_deal.trustee_id%type,             -- ��� �����.���� �������
  p_comment  in  dpu_dealw.value%type                  -- �����������
) is
  title      varchar2(30) := 'dpu.upddealparams:';
  l_dpu      dpu_deal%rowtype;
  r_vidd     dpu_vidd%rowtype;
  l_int      int_ratn%rowtype;
  l_intacc   int_accn.acrA%type;
  l_intid    int_accn.id%type := 1;
  l_acrdat   int_accn.acr_dat%type;
  l_expacc   int_accn.acrB%type;
  numbnull   constant number  := 0;
  datenull   constant date    := to_date('10.11.4977','dd.mm.yyyy');
  charnull   constant char(4) := '____';
  l_level    constant number  := 2;  -- ����� ����������� ����� ����� �������� ��������� ��������
  l_comb     dpu_vidd_comb.main_vidd%type;
  l_errmsg   varchar(1000);
begin
  
  bars_audit.trace('%s entry with %s', title, to_char(p_dealid));
  
  -- ���� ���������� �� 3-�� ����
  -- if (CHECK_USER_RIGHT(user_id,l_level) = 1 ) then
  --   null;
  -- else
  --   -- ������������ %s-�� ���� ���������� �������� ��������� ��������
  --   bars_error.raise_nerror( modcode, 'UPDEAL_MODIFY_DENIED', to_char(l_level+1) );
  -- end if;
  
  begin
    select * into l_dpu 
      from BARS.DPU_DEAL 
     where dpu_id = p_dealid 
       for update nowait;
  exception
    when NO_DATA_FOUND then
      bars_error.raise_nerror( modcode, 'DPUID_NOT_FOUND', to_char(p_dealid) );
  end;
  
  begin
    select acra, acr_dat
      into l_intacc, l_acrdat
      from int_accn 
     where acc = l_dpu.acc 
       and id = l_intid;
  exception
    when no_data_found then
      bars_error.raise_nerror( modcode, 'UPDEAL_INTACC_NOT_FOUND', to_char(p_dealid) );
  end;
  
  begin
    select * into r_vidd
      from BARS.DPU_VIDD 
     where VIDD = l_dpu.vidd;
  exception
    when NO_DATA_FOUND then
      r_vidd.fl_extend := 0;
  end;
  
  if    p_dealnum is null 
  then
        bars_error.raise_nerror (modcode, 'UPDEAL_NUM_NULL',    to_char(p_dealid));
  elsif p_datreg  is null 
  then 
        bars_error.raise_nerror (modcode, 'UPDEAL_DATREG_NULL', to_char(p_dealid));
  elsif p_datbeg  is null 
  then
        bars_error.raise_nerror (modcode, 'UPDEAL_DATBEG_NULL', to_char(p_dealid));
--elsif p_indrate is null and p_basrate is null 
--then
--      bars_error.raise_nerror (modcode, 'UPDEAL_RATE_NULL',   to_char(p_dealid));
  elsif p_freqid  is null 
  then 
        bars_error.raise_nerror (modcode, 'UPDEAL_FREQ_NULL',   to_char(p_dealid));
  elsif p_stopid  is null 
  then 
        bars_error.raise_nerror (modcode, 'UPDEAL_STOP_NULL',   to_char(p_dealid));
  elsif p_branch  is null 
  then
        bars_error.raise_nerror (modcode, 'UPDEAL_BRANCH_NULL', to_char(p_dealid));
  end if;
  
  if nvl(l_dpu.nd,         charnull) !=  nvl(p_dealnum, charnull) or
     nvl(l_dpu.sum,        numbnull) !=  nvl(p_dealsum, numbnull) or
     nvl(l_dpu.min_sum,    numbnull) !=  nvl(p_minsum,  numbnull) or
     nvl(l_dpu.freqv,      numbnull) !=  nvl(p_freqid,  numbnull) or
     nvl(l_dpu.id_stop,    numbnull) !=  nvl(p_stopid,  numbnull) or
     nvl(l_dpu.datz,       datenull) !=  nvl(p_datreg,  datenull) or
     nvl(l_dpu.dat_begin,  datenull) !=  nvl(p_datbeg,  datenull) or
     nvl(l_dpu.dat_end,    datenull) !=  nvl(p_datend,  datenull) or
     nvl(l_dpu.datv,       datenull) !=  nvl(p_datret,  datenull) or
     nvl(l_dpu.mfo_d,      charnull) !=  nvl(p_depmfo,  charnull) or
     nvl(l_dpu.nls_d,      charnull) !=  nvl(p_depnls,  charnull) or
     nvl(l_dpu.nms_d,      charnull) !=  nvl(p_depnms,  charnull) or
     nvl(l_dpu.mfo_p,      charnull) !=  nvl(p_intmfo,  charnull) or
     nvl(l_dpu.nls_p,      charnull) !=  nvl(p_intnls,  charnull) or
     nvl(l_dpu.nms_p,      charnull) !=  nvl(p_intnms,  charnull) or
     nvl(l_dpu.okpo_p,     charnull) !=  nvl(p_intokpo, charnull) or
     nvl(l_dpu.branch,     charnull) !=  nvl(p_branch,  charnull) or
     nvl(l_dpu.trustee_id, numbnull) !=  nvl(p_trustid, numbnull)   
  then
    
    bars_audit.trace('%s at least one param changed for deal # %s', title, to_char(p_dealid));
    
    begin
      update BARS.DPU_DEAL d
         set d.ND         = substr(p_dealnum, 1,  35),
             d.SUM        = p_dealsum, 
             d.MIN_SUM    = p_minsum,
             d.FREQV      = p_freqid,
             d.ID_STOP    = p_stopid,
             d.DATZ       = p_datreg,
             d.DAT_BEGIN  = p_datbeg,
             d.DAT_END    = p_datend, 
             d.DATV       = p_datret,
             d.MFO_D      = substr(trim(p_depmfo),  1,  6),
             d.NLS_D      = substr(trim(p_depnls),  1, 14),
             d.NMS_D      = substr(trim(p_depnms),  1, 38),
             d.MFO_P      = substr(trim(p_intmfo),  1,  6),
             d.NLS_P      = substr(trim(p_intnls),  1, 14),
             d.NMS_P      = substr(trim(p_intnms),  1, 38),
             d.OKPO_P     = substr(trim(p_intokpo), 1, 10),
             d.BRANCH     = substr(p_branch,        1, 30),
             d.TRUSTEE_ID = nvl(p_trustid, 0)
       where d.DPU_ID     = p_dealid;
      
      bars_audit.info( bars_msg.get_msg( modcode, 'UPDEAL_GENERAL_DONE',
                                         p_dealnum, 
                                         to_char(p_datreg, 'dd.mm.yyyy'), 
                                         to_char(p_dealid) ) );
    exception
      when others then
        bars_error.raise_nerror( modcode, 'UPDEAL_FAILED', to_char(p_dealid), sqlerrm );
    end;
    
    if ( nvl(l_dpu.comments, charnull) != nvl(p_comment, charnull) )
    then
      dpu.set_parameters( p_dealid, 'COMMENTS', SubStr(p_comment,1,250) );
    end if;
    
    -- �����ֲ� ��� Ĳ� ��������
    if nvl(l_dpu.dat_end, bankdate) != nvl(p_datend, bankdate) 
    then
      
      bars_audit.trace( '%s prolongation (%s - > %s)', title,
                        to_char(l_dpu.dat_end, 'dd.mm.yyyy'),
                        to_char(p_datend,      'dd.mm.yyyy') );
      
      -- �������� ��� �������� �� ���������� ������ ��������
      l_errmsg := DATE_VALIDATE( p_vidd   => l_dpu.vidd 
                               , p_datbeg => p_datbeg
                               , p_datend => p_datend );
      
      if ( l_errmsg Is Not Null )
      then
        bars_error.raise_error( modcode, 666, l_errmsg );
      end if; 
      
$if DPU_PARAMS.SBER
$then
      If ( p_datret < l_acrdat )
      Then -- ���� ���� ���������� �������� �� ���� ����� �� ���� �����.�����.%%
$else
      If ( p_datend < l_acrdat )
      Then -- ���� ���� ���������� �������� �� ���� ����� �� ���� �����.�����.%%
$end
        bars_error.raise_nerror( modcode, 'UPDEAL_DATEND_INVALID', to_char(p_datend, 'dd.mm.yyyy'), to_char(l_acrdat, 'dd.mm.yyyy') );
      Else
        null;
      End If;
      
$if DPU_PARAMS.LINE8
$then
        -- �������� �� "�����" �� ��� ��
        If ( (l_dpu.dpu_gen is NOT Null) AND (r_vidd.fl_extend = 2 ) AND 
             (p_datend > dpu.get_datend_line(l_dpu.dpu_gen)) ) 
        Then
          bars_error.raise_nerror( modcode, 'INVALID_DATEND_TRANCHE', to_char(p_datend, 'dd/mm/yyyy'), 
                                   to_char(dpu.get_datend_line(l_dpu.dpu_gen), 'dd/mm/yyyy') );
        End If;
      
$end
        -- 
        begin
          -- ���� ���������
          update ACCOUNTS 
$if DPU_PARAMS.SBER
$then
             set MDATE = p_datret
$else
             set MDATE = p_datend
$end
           where ACC = l_dpu.acc; 
          
          update ACCOUNTS 
$if DPU_PARAMS.SBER
$then
             set MDATE = p_datret
$else
             set MDATE = p_datend
$end
           where ACC = l_intacc; 
          
          /*
          ���� ���� �������/���������� ��������
          if ( p_datbeg = p_datreg )
          then
            -- ��� �� �� ������ ���� �� ���������� �� ��� ������� ���� ������������ ACR_DAT = DAT_BEGIN
            -- ��� ��� ���� ������� ����������
            select d.DATZ, d.DAT_BEGIN, i.ACR_DAT
              from BARS.DPU_DEAL d
              join BARS.INT_ACCN i
                on ( i.ACC = d.ACC and i.ID = 1 )
             where d.DPU_ID = :p_dpu_id
               and d.DAT_BEGIN = i.ACR_DAT
          end if;
          
          */
          
          -- ����-���� ����������� �������
          update INT_ACCN 
$if DPU_PARAMS.SBER
$then
             set stp_dat = p_datret - 1
$else
             set stp_dat = p_datend - 1
$end
           where ACC     = l_dpu.acc 
             and ID      = l_intid
             and STP_DAT is not null;
          
          -- ���������� ��������������
          fill_specparams (p_depaccid   => l_dpu.acc, 
                           p_depacctype => null, 
                           p_intaccid   => l_intacc,
                           p_intacctype => null,
                           p_d020       => case when l_dpu.dat_end < p_datend then '02' else '01' end,
                           p_begdate    => p_datbeg );
          bars_audit.info (bars_msg.get_msg (modcode, 'UPDEAL_PROLONG_DONE',
                                             p_dealnum, 
                                             to_char(p_datreg, 'dd.mm.yyyy'), 
                                             to_char(p_dealid)));
        exception
          when others then
            bars_error.raise_nerror (modcode, 'UPDEAL_PROLONG_FAILED', to_char(p_dealid), sqlerrm);
        end;     
     end if;
  
     -- ��������� ���������� ������� ��������� � ���������� ��������
     if nvl(l_dpu.mfo_p, charnull) !=  nvl(p_intmfo,  charnull) or
        nvl(l_dpu.nls_p, charnull) !=  nvl(p_intnls,  charnull) or
        nvl(l_dpu.nms_p, charnull) !=  nvl(p_intnms,  charnull)
     then
        update int_accn 
           set nlsb = SubStr(trim(p_intnls), 1, 14),     
               mfob = SubStr(trim(p_intmfo), 1,  6),
               namb = SubStr(trim(p_intnms), 1, 38),
               okpo = SubStr(trim(p_intokpo),1, 14)
         where acc  = l_dpu.acc
           and id   = l_intid;
     end if;

  end if;
  
  -- ��������������� �������
  begin
    select dmnd_vidd
      into l_comb 
      from dpu_vidd_comb 
     where main_vidd = l_dpu.vidd;
  exception
    when no_data_found then
     l_comb := null;
  end;
  
  if l_comb is not null 
  then
     
     bars_audit.trace('%s is comb deal', title);
     
     -- ����������� �������
     if nvl(p_minsum, 0) > 0 
     then
        update accounts 
           set lim = - p_minsum 
         where acc = l_dpu.acc 
           and nvl(lim, 0) != - p_minsum;
        if sql%rowcount > 0 then
           bars_audit.info (bars_msg.get_msg (modcode, 'UPDEAL_LIMIT_DONE',
                                              p_dealnum, 
                                              to_char(p_datreg, 'dd.mm.yyyy'), 
                                              to_char(p_dealid)));
        end if;
        bars_audit.trace('%s lim = %s', title, to_char(- (p_minsum * 100)));
     end if;
     
     -- ��������� ���������� ��������� ������������
     for childs in 
        (select dpu_id 
           from dpu_deal
          where vidd      = l_comb
            and dpu_gen   = l_dpu.dpu_gen
            and dpu_id   != l_dpu.dpu_id
            and nvl(closed, 0) = 0)
     loop
       bars_audit.trace('%s comb subdeal found � %s', title, to_char(childs.dpu_id));
       upd_dealparams (childs.dpu_id,  p_dealnum,   p_dealsum,
                       p_minsum,       p_freqid,    p_stopid,
                       p_datreg,       p_datbeg,    p_datend,   p_datret,
                       p_depmfo,       p_depnls,    p_depnms,
                       p_intmfo,       p_intnls,    p_intnms,   p_intokpo,
$if DPU_PARAMS.SBER
$then
                       round((p_indrate/2), 1),  null,  null,   p_ratedat,  -- ��� ������� ��� (50% �� �����.������ � ����������� �� �������)
$else
                       p_indrate,      p_operid,    p_basrate,  p_ratedat,
$end                         
                       p_branch,       p_trustid,   p_comment);
     end loop;
  end if;
  
  --
  -- ��������� ���������� ������
  --
  if ( ( p_ratedat Is Not Null ) and 
       ( p_indrate Is Not Null or p_basrate Is Not Null )
     )
  then
    
    begin
      select rn.*
        into l_int
        from INT_RATN rn
       where rn.acc  = l_dpu.acc
         and rn.id   = l_intid
         and rn.bdat = ( select max(ro.bdat)
                           from int_ratn ro
                          where ro.acc   = rn.acc 
                            and ro.id    = rn.id
                            and ro.bdat <= p_ratedat );
    exception
      when NO_DATA_FOUND then
        bars_error.raise_nerror( modcode, 'UPDEAL_RATE_NOT_FOUND', 
                                 to_char(p_dealid), to_char(p_ratedat,'dd.mm.yyyy') );
    end;
  
    bars_audit.trace( '%s %s = (%s, %s, %s)', title, to_char(p_ratedat,'dd.mm.yyyy'),
                      to_char(l_int.ir), to_char(l_int.op), to_char(l_int.br) );
     
    if nvl(l_int.ir, numbnull) != nvl(p_indrate, numbnull) or
       nvl(l_int.op, numbnull) != nvl(p_operid,  numbnull) or
       nvl(l_int.br, numbnull) != nvl(p_basrate, numbnull)
    then
      
      bars_audit.trace( '%s rate changing...', title );
      
      begin
        
        if ( l_int.bdat = p_ratedat )
        then
          update BARS.INT_RATN
             set IR   = p_indrate,
                 BR   = p_basrate,
                 OP   = p_operid
           where ACC  = l_int.acc 
             and ID   = l_int.id
             and BDAT = l_int.bdat;
        else
          insert
            into BARS.INT_RATN
               ( ACC, ID, BDAT, IR, OP, BR )
          values
               ( l_int.acc, l_int.id, p_ratedat, p_indrate, p_operid, p_basrate );
        end if;
        
        bars_audit.info( bars_msg.get_msg( modcode, 'UPDEAL_RATE_DONE',
                                           p_dealnum, 
                                           to_char(p_datreg,'dd.mm.yyyy'),
                                           to_char(p_dealid) ) );
      exception
         when OTHERS then
           bars_error.raise_nerror(modcode, 'UPDEAL_RATE_FAILED', to_char(p_dealid), sqlerrm); 
      end;
      
    end if;
  
  else -- ������ �� ���������
    null;
  end if;
  
  --
  -- "���������" ��������
  --
  If ( l_dpu.branch != p_branch )
  then 
    
    bars_audit.trace('%s rebranching (%s - > %s)', title, l_dpu.branch, p_branch );
    
    for a� in ( select accid 
                  from dpu_accounts
                 where dpuid = p_dealid 
                    --or dpuid in (select dpu_id from dpu_deal where dpu_gen = p_dealid)
              )
    loop
      update BARS.ACCOUNTS
         set TOBO   = p_branch,
             BRANCH = p_branch
       where ACC = a�.ACCID;
    end loop;
    
    if ( SubStr(l_dpu.branch,1,15) != SubStr(p_branch,1,15) )
    then -- ���� �������� ACRB � %% ������ �������
    
      l_expacc := get_expacc( p_dptype => l_dpu.vidd,
                              p_balacc => r_vidd.bsd,
                              p_curid  => r_vidd.kv,
                              p_branch => p_branch );
      
      update BARS.INT_ACCN 
         set ACRB = l_expacc
       where ACC  = l_dpu.acc
         and ID   = l_intid;
      
    end if;
    
    /* ���� ��������� ����� branch �� ��� ������� ������ �������� */
    
  End If;
  
  bars_audit.trace('%s exit', title);

end upd_dealparams;

--
-- ������������� ����������� ������ �������� / ������ �� ��������
--
procedure final_amrt (p_dpuid in dpu_deal.dpu_id%type) -- ������������� ��������
is
begin
$if DPU_PARAMS.IRR
$then
  dpt_irr.final_amrt (p_dptid => p_dpuid, p_custype => 2);
$else
  null;
$end  
end final_amrt;

--
-- �������� ���� ������ �������� / ������ �� ��������
--
procedure close_dpaccs (p_dpuid in dpu_deal.dpu_id%type) -- ������������� ��������
is
begin
$if DPU_PARAMS.IRR
$then
  dpt_irr.close_dpaccs (p_dptid => p_dpuid, p_custype => 2);
$else
  null;
$end  
end close_dpaccs;
  
--
-- ������������� ��������� ����������� ������ �� ����� ���������� ������
--      � ����������� �� ����, ����� � ����� ����������� ��������
--
procedure get_scalerate 
 (p_typeid   in   dpu_vidd_rate.type_id%type,                -- ��� ��������
  p_kv       in   dpu_vidd_rate.kv%type,                     -- ��� ������
  p_vidd     in   dpu_vidd_rate.vidd%type,                   -- ��� ��������
  p_amount   in   dpu_vidd_rate.limit%type,                  -- ����� �������� (����� �����)
  p_datbeg   in   date,                                      -- ���� ������ ��������
  p_datend   in   date,                                      -- ���� ��������� ��������
  p_mnth     in   dpu_vidd_rate.term%type      default null, -- ���-�� �������
  p_days     in   dpu_vidd_rate.term_days%type default null, -- ���-�� ����
  p_actrate  out  dpu_vidd_rate.rate%type,                   -- ���������� ������
  p_maxrate  out  dpu_vidd_rate.max_rate%type,               -- ����.���������� ������
  p_recid    out  dpu_vidd_rate.id%type)                     -- ������������� ������
is
  title     varchar2(60) := 'dpu.getscalerate:';
  l_datend  date;
  l_rate    dpu_vidd_rate.rate%type;
  l_maxrate dpu_vidd_rate.max_rate%type;
  l_recid   dpu_vidd_rate.id%type;
  l_typeid  dpu_vidd_rate.type_id%type;
  l_kv      dpu_vidd_rate.kv%type;
begin

  bars_audit.trace('%s entry, type=>{%s,%s,%s},s=>%s,dates=>{%s,%s},term=>{%s,%s}', 
                   title, to_char(p_typeid), to_char(p_kv),
                          to_char(p_vidd),   to_char(p_amount),
                          to_char(p_datbeg), to_char(p_datend),  
                          to_char(p_mnth),   to_char(p_days));

  -- ������ ���� ��������� (���� �� ������ ����)
  if p_datend is null 
  then
    l_datend := add_months(p_datbeg, nvl(p_mnth, 0)) + nvl(p_days, 0);
  else
     l_datend := p_datend;
  end if;     
  bars_audit.trace('%s datend* = %s', title, to_char(l_datend, 'dd.mm.yyyy'));

  for r in 
      (select dat_lim, amount_lim, id, rate, max_rate
         from 
             (select id, rate, max_rate, limit - (1 - summ_include) amount_lim,
                     add_months(p_datbeg, term) + term_days - (2 - term_include) dat_lim 
                from DPU_VIDD_RATE
               where -- ����� ��� ���� �������� 
                     (p_vidd is not null and vidd = p_vidd) 
                  or -- ����� ��� �������� + ������
                     (p_vidd is null and type_id = p_typeid and kv = p_kv)
              )
        where amount_lim >= p_amount
          and dat_lim    >= l_datend
        order by 1, 2)
  loop
      bars_audit.trace('%s � %s: (dat,rate) = (%s,%s)', title, 
                                                        to_char(r.id),
                                                        to_char(r.dat_lim,'dd.mm.yyyy'), 
                                                        to_char(r.rate));
      l_recid   := r.id;
      l_rate    := r.rate;
      l_maxrate := r.max_rate;
  exit 
      when r.dat_lim >= l_datend;
  end loop;
  bars_audit.trace('%s rate = %s', title, to_char(l_rate));
  
  -- ������ ��� ���� �������� �� ���������� => ����� ������ ��� ���� �������� � ������
  if (p_vidd is not null and l_rate is null) then

      bars_audit.trace('%s rate for vidd %s not found', title, to_char(p_vidd));

      if (p_typeid is null or p_kv is null) then
          begin
            select type_id, kv 
              into l_typeid, l_kv 
              from dpu_vidd
             where vidd = p_vidd;
          exception
            when no_data_found then 
              l_typeid := null; 
              l_kv     := null;
          end;
      end if;

      l_typeid := nvl(p_typeid, l_typeid);
      l_kv     := nvl(p_kv,     l_kv    ); 
      
      bars_audit.trace('%s searching rate for type %s/%s...', title, 
                                                              to_char(l_typeid), 
                                                              to_char(l_kv));
      get_scalerate (p_typeid  => l_typeid, 
                     p_kv      => l_kv,
                     p_vidd    => null, 
                     p_amount  => p_amount, 
                     p_datbeg  => p_datbeg, 
                     p_datend  => l_datend, 
                     p_actrate => l_rate, 
                     p_maxrate => l_maxrate,
                     p_recid   => l_recid);
  end if;
  
  p_actrate := l_rate;
  p_maxrate := l_maxrate;
  p_recid   := l_recid;
  
  bars_audit.trace('%s exit, rates=>%s(max %s), id=>%s', title, 
                                                         to_char(p_actrate), 
                                                         to_char(p_maxrate),
                                                         to_char(p_recid));

end get_scalerate;


--
-- ��������� ��������� swift-���������� ���������� ��� ����������� �������� � ��.������
--
procedure SET_DEALSWTAGS
( p_dpuid       in  dpu_deal_swtags.dpu_id%type,      -- ������������� ��������
  p_tag56_name  in  dpu_deal_swtags.tag56_name%type,  -- ����-���������: �������� 
  p_tag56_adr   in  dpu_deal_swtags.tag56_adr%type,   -- ����-���������: �����
  p_tag56_code  in  dpu_deal_swtags.tag56_code%type,  -- ����-���������: swift-���
  p_tag57_name  in  dpu_deal_swtags.tag57_name%type,  -- ����-�����������: �������� 
  p_tag57_adr   in  dpu_deal_swtags.tag57_adr%type,   -- ����-�����������: �����
  p_tag57_code  in  dpu_deal_swtags.tag57_code%type,  -- ����-�����������: swift-���
  p_tag57_acc   in  dpu_deal_swtags.tag57_acc%type,   -- ����-�����������: ����
  p_tag59_name  in  dpu_deal_swtags.tag59_name%type,  -- ����������: ��������
  p_tag59_adr   in  dpu_deal_swtags.tag59_adr%type,   -- ����������: �����
  p_tag59_acc   in  dpu_deal_swtags.tag59_acc%type    -- ����������: ����
) is
  c_title   constant varchar2(60) := 'dpu.setdealswtags:';
begin
  
  bars_audit.trace( '%s entry, dpuid=>%s, branch=>%s, tag56=>(%s,%s,%s), '||
                    'tag57=>(%s,%s,%s,%s), tag59=>(%s,%s,%s)',
                    bars_audit.args( c_title, to_char(p_dpuid),
                                     p_tag56_name, p_tag56_adr, p_tag56_code,
                                     p_tag57_name, p_tag57_adr, p_tag57_code, p_tag57_acc,  
                                     p_tag59_name, p_tag59_adr, p_tag59_acc) );

  update BARS.DPU_DEAL_SWTAGS
     set tag56_name = SubStr(p_tag56_name, 1, 100)
       , tag56_adr  = SubStr(p_tag56_adr , 1,  50)
       , tag56_code = SubStr(p_tag56_code, 1,  11)
       , tag57_name = SubStr(p_tag57_name, 1, 100)
       , tag57_adr  = SubStr(p_tag57_adr , 1,  50)
       , tag57_code = SubStr(p_tag57_code, 1,  11)
       , tag57_acc  = SubStr(p_tag57_acc , 1,  20)
       , tag59_name = SubStr(p_tag59_name, 1, 100)
       , tag59_adr  = SubStr(p_tag59_adr , 1,  50)
       , tag59_acc  = SubStr(p_tag59_acc , 1,  20)
   where dpu_id     = p_dpuid;
  
  if sql%rowcount > 0 
  then
    bars_audit.trace( '%s sw-tags for deposit %s updated.', c_title, to_char(p_dpuid) );
  else
    
    if coalesce( trim(p_tag56_name), trim(p_tag56_adr), trim(p_tag56_code),
                 trim(p_tag57_name), trim(p_tag57_adr), trim(p_tag57_code), trim(p_tag57_acc),
                 trim(p_tag59_name), trim(p_tag59_adr),                     trim(p_tag59_acc)
               ) is Null
    then 
      bars_audit.trace( '%s all tags are null', c_title );
      null;
    else
      bars_audit.trace('%s inserting sw-tags for deposit %s...', c_title, to_char(p_dpuid));
      insert 
        into dpu_deal_swtags 
           ( dpu_id,
             tag56_name, tag56_adr, tag56_code,
             tag57_name, tag57_adr, tag57_code, tag57_acc,
             tag59_name, tag59_adr,             tag59_acc ) 
      values
        ( p_dpuid, 
          substr(p_tag56_name, 1, 100), substr(p_tag56_adr, 1, 50), substr(p_tag56_code, 1, 11), 
          substr(p_tag57_name, 1, 100), substr(p_tag57_adr, 1, 50), substr(p_tag57_code, 1, 11), substr(p_tag57_acc, 1, 20), 
          substr(p_tag59_name, 1, 100), substr(p_tag59_adr, 1, 50),                              substr(p_tag59_acc, 1, 20) ); 
     bars_audit.trace('%s sw-tags for deposit %s inserted.', c_title, to_char(p_dpuid));
    end if;
    
  end if;
  
  bars_audit.trace('%s exit', c_title);
  
end set_dealswtags;

--
-- ������� ���������� ��� �������� ��� ������������ ��������� ��������� ����
--
function get_tt (p_operid in number,          -- ��� �������� �� ���-�� dpt_op
                 p_curid  in oper.kv%type,    -- ��� ������
                 p_mfob   in oper.mfob%type,  -- ��� ����� ����������
                 p_nlsb   in oper.nlsb%type)  -- ���� ����������
  return tts.tt%type
is
  c_title   constant varchar2(60)   := 'dpu.gett:';
  c_baseval constant oper.kv%type   := gl.baseval;
  c_ourmfo  constant oper.mfob%type := gl.amfo;
  l_fli     tts.fli%type;
  l_tt      tts.tt%type;
  l_op      dpt_op.id%type;
  cursor tt_cur is select t.tt
                     from tts t, op_rules o 
                    where t.tt  = o.tt 
                      and o.tag = dptop_tag -- DPTOP
                      and o.val = to_char(l_op)
                      and t.fli = l_fli
                      and t.tt  like 'DU%'
                      and (t.kv = p_curid or t.kv is null)
                    order by decode(t.kv, p_curid, 1, 2), t.tt;
begin
  
  bars_audit.trace('%s entry, operid=>%s,curid=>%s,mfob=>%s,nlsb=%s', c_title,
                   to_char(p_operid), to_char(p_curid), p_mfob, p_nlsb);
  
  -- ��� ����������
  l_fli := case 
             when p_mfob  = c_ourmfo
             then 0 -- ����������.
$if DPU_PARAMS.SBER
$then
             else 1 -- ������.��� (��������)
$else
             when p_curid = c_baseval 
             then 1 -- ������.���
             else 2 -- ������.SWIFT
$end
           end;
  
  if ( l_fli = 0 or p_curid = c_baseval or IS_OSCHADBANK(p_mfob) = 0 )
  then
    l_op := p_operid;
  else
    l_op := ( p_operid * 10 + 7 );
  end if;
  
  bars_audit.trace('%s transaction type = %s', c_title, to_char(l_fli));
  
  for tt_rec in tt_cur 
  loop
    l_tt := tt_rec.tt;
    exit when (tt_cur%rowcount = 1 or tt_cur%notfound or tt_cur%notfound is null);
  end loop;
  
  bars_audit.trace('%s tt = %s', c_title, l_tt);
  
  return l_tt;
  
end get_tt;

--
-- ������� ���������� ����� � ���� �������� ��� ������ ���������� �������
-- (���.��� ������������ ���������� �� ������� "������ � ���.���������� ��")
-- 
-- p_dpuid - ������������� ����������� �������� ��� ���.����������
-- p_type  - ����� ������������ ����������, ���������� �������� 
--           A - ������� ����������: 1) � �������� 2) � ���.���������� (�������)
--           D - ������� ����������  1) � ���.���������� 2) � �������� 
--           N - � ������ "��� ���"
--           F - ������ ��� - ��������  (�������)
--           B - ������ ��� - � ���� dd.mm.yyyy
--           U - 
--
function f_nazn (p_type  in varchar2, 
                 p_dpuid in dpu_deal.dpu_id%type) 
  return oper.nazn%type 
is
  l_lang      char(1) := substr(bars_msg.get_lang, 1, 1);  
  l_gennum    dpu_deal.nd%type;
  l_gendat    dpu_deal.datz%type;
  l_gendatS   varchar2(50);
  l_agrnum    dpu_deal.nd%type;
  l_agrdat    dpu_deal.datz%type;
  l_dpu_add   dpu_deal.dpu_add%type;
  l_agrdatS   varchar2(50);
  l_kv        dpu_vidd.kv%type; 
  l_txt       oper.nazn%type;
  l_datfmt    char(1);
begin
  
  -- � � ���� ���.�������� +/- � � ���� ���.����������
  begin               
    select trim(g.nd), g.datz, trim(d.nd), d.datz, nvl(d.dpu_add, 0), v.kv 
      into l_gennum, l_gendat, l_agrnum, l_agrdat, l_dpu_add, l_kv
      from dpu_deal d,
           dpu_deal g,
           dpu_vidd v
     where g.dpu_id = nvl(d.dpu_gen, d.dpu_id)
       and d.dpu_id = p_dpuid
       and d.vidd   = v.vidd;
  exception 
    when NO_DATA_FOUND then 
      return null;
  end;
  
  if instr(p_type, 'B') > 0
  then 
     l_gendatS := to_char(l_gendat, 'dd.mm.yyyy'); 
     l_agrdatS := to_char(l_agrdat, 'dd.mm.yyyy');  
  else 
     l_gendatS := substr(f_dat_lit(l_gendat, l_lang), 1, 50);
     l_agrdatS := substr(f_dat_lit(l_agrdat, l_lang), 1, 50); 
  end if;
  
  if ( l_dpu_add > 0 )
  then
    if instr(p_type, 'D') > 0
    then
      -- ��������� ����� � %s �� %s �� �������� � %s �� %s
      l_txt := substr(bars_msg.get_msg( modcode, 'NAZN_AGRGEN_DEAL', 
                                                 l_agrnum, 
                                                 l_agrdatS,
                                                 l_gennum, 
                                                 l_gendatS ), 1, 160 );
    else
      -- �������� � %s �� %s �� ��������� ����� � %s �� %s
      l_txt := substr(bars_msg.get_msg( modcode, 'NAZN_GENAGR_DEAL', 
                                                 l_gennum, 
                                                 l_gendatS, 
                                                 l_agrnum, 
                                                 l_agrdatS ), 1, 160 );
    end if;
    
  else
    -- �������� � %s �� %s 
    l_txt := substr(bars_msg.get_msg( modcode, 'NAZN_STND_DEAL', 
                                               l_gennum, 
                                               l_gendatS ), 1, 160 );
  end if;
  
  if instr(p_type, 'N') > 0 and l_kv = gl.baseval 
  then
    --  ��� ���
    l_txt := substr(l_txt ||bars_msg.get_msg(modcode, 'NAZN_TAX'), 1, 160);
  end if;
  
  return l_txt;
  
end f_nazn;

--
-- ������������ ���������� ������� ��� �������� ���������� ��������� (DU%) 
--
function get_intdetails (p_depacc in accounts.nls%type,  -- � ��������� �����
                         p_depcur in accounts.kv%type)   -- ������ ��������� �����
  return oper.nazn%type
is
  title     constant varchar2(60):= 'dpu.getintdtl:';
  l_dpuid   dpu_deal.dpu_id%type;
  l_tip     accounts.tip%type; 
  l_lang    char(1) := substr(bars_msg.get_lang, 1, 1);
  l_prefix  varchar2(30);
  l_details oper.nazn%type;
begin

  bars_audit.trace('%s entry, depacc=>%s/%s', title, p_depacc, to_char(p_depcur));
  
  begin
    select d.dpu_id, a.tip
      into l_dpuid, l_tip 
      from dpu_deal     d, 
           dpu_accounts da, 
           accounts     a
     where da.dpuid = d.dpu_id
       and da.accid = a.acc 
       and a.nls    = p_depacc
       and a.kv     = p_depcur;
  exception
    when no_data_found then
      return null;
  end;
  
  if l_tip in ('DDM', 'DDI') then
     l_prefix := 'AMRT_DISCONT_DTLS'; -- ����������� �������� �� ����������� ������ �����
  elsif l_tip in ('DPM', 'DPI') then
     l_prefix := 'AMRT_PREMIUM_DTLS'; -- ����������� ���쳿 �� ����������� ������ �����
  else
     l_prefix := 'INT_DTLS';          -- ����������� ������� �� ����������� ������ �����
  end if;
  
  l_details := substr(bars_msg.get_msg(modcode, l_prefix) ||' '|| f_nazn(l_lang||'B', l_dpuid), 1, 160);
  
  return l_details;
 
end get_intdetails;

--
-- get_intpay_state() - ������� �������� ������������ ������� ��������� 
--                      ������ �� ������� �������� � ������-�� ������� ���������
-- ������� ���������� 1 (������� ���������) ��� 0 (������� ���������)  
-- 
-- ���������:
--    p_dpuid   - ������������� �������� 
--    p_freq    - ������������� �������
--    p_datbeg  - ���� ������ �������� ��������
--    p_datend  - ���� ��������� �������� ��������
--    p_intacc  - �����.����� ����������� �����
--    p_bdate   - ���������� ����
--
function get_intpay_state (p_dpuid   in  dpu_deal.dpu_id%type,
                           p_freq    in  dpu_deal.freqv%type,
                           p_datbeg  in  dpu_deal.dat_begin%type,
                           p_datend  in  dpu_deal.dat_end%type,
                           p_intacc  in  int_accn.acra%type,
                           p_bdate   in  date)
return number
is
  c_title constant varchar2(60) := 'dpu.getintpaystate:';
  l_state number(1)             := 0;
  l_dat1   date;
  l_dat2   date;
  l_tmpdat date;
  l_index number(2);
begin

  bars_audit.trace('%s entry, dpuid=>%s, freq=>%s, %s-%s, intacc=>%s, bdate=>%s', 
                   c_title, to_char(p_dpuid),  to_char(p_freq),   to_char(p_datbeg), 
                            to_char(p_datend), to_char(p_intacc), to_char(p_bdate));
                            
  -- �������� ������������ �������� ����������
  if p_freq   is null
  or p_intacc is null 
  or p_datbeg is null 
  or p_bdate  is null 
  or p_datbeg > p_datend 
  or p_datbeg > p_bdate
  or p_freq not in (1, 2, 3, 5, 7, 180, 360, 400) 
  then
     return l_state;
  end if;   

  if (p_datend <= p_bdate) then 
      -- ���� �������� �����
      l_state := 1;
  elsif (p_freq in (1, 2)) then 
      -- ��������� / ���������� �������
      l_state := 1;
  elsif (p_freq = 3) then  
      -- ������������ ������� ��������� 
      if p_bdate >= p_datbeg + 7 then  
         -- ������ ������ �� ��� �������� ��������
         l_dat1  := p_bdate - 7;
         l_dat2  := p_bdate;
      end if;
  elsif (p_freq = 5) then 
      -- ������� ��������� ��� � �����
      l_dat1 := greatest(add_months(last_day(p_bdate), -1) + 1, p_datbeg);
      l_dat2 := p_bdate;
  elsif (p_freq in (7, 180)) then 
      -- ������� ��������� ��� � ������� / ������� 
      l_index := case when p_freq = 7   then 3  -- �������
                      when p_freq = 180 then 6  -- �������
                 end;
      if months_between(last_day(p_bdate), 
                        add_months(last_day(p_datbeg), -1)) > (l_index - 1) then
         l_tmpdat := add_months(last_day(p_datbeg), -1) + 1;
         while l_tmpdat <= p_bdate loop
               l_dat1   := l_tmpdat;
               l_tmpdat := add_months(l_tmpdat, l_index);
         end loop;
         l_dat2 := add_months(l_dat1, l_index) - 1;
         l_dat2 := least (l_dat2, p_bdate);
         l_dat1 := greatest (l_dat1, p_datbeg);
      end if;
  elsif (p_freq = 360) then
     -- ������� %% ��� � ��� ��������� ������ � ��������� ������� ���� ����
     l_tmpdat := dat_next_u(add_months(trunc(p_bdate, 'YEAR'), 12), -1);
     begin 
       select dat_next_u(l_tmpdat, -1) 
         into l_dat1
         from holiday 
        where holiday = l_tmpdat;
     exception
       when no_data_found then
         l_dat1 := l_tmpdat;
     end;    
     if l_dat1 != p_bdate then 
        l_dat1 := null; 
     end if;
     l_dat2 := l_dat1;
  else  
     l_state := 0;
  end if;
  bars_audit.trace('%s term = (%s, %s)', c_title, to_char(l_dat1, 'dd.mm.yyyy'),
                                                  to_char(l_dat2, 'dd.mm.yyyy'));

  if (l_state = 0 and l_dat1 is not null and l_dat2 is not null) then
      bars_audit.trace('%s fdos = %s', c_title, to_char(fdos(p_intacc, l_dat1, l_dat2)));
      l_state := case when fdos(p_intacc, l_dat1, l_dat2) = 0 then 1 else 0 end;
  end if;
   
  bars_audit.trace('%s exit with %s', c_title, to_char(l_state)); 
  
  return l_state;

end get_intpay_state;

--
-- get_intpay_state_ex() - ������� �������� ������������ ������� ��������� 
--                         �� ��������� �������� �� ��������� ����
-- ������� ���������� 1 (������� ���������) ��� 0 (������� ���������)  
-- 
-- ���������:
--    p_dpuid   - ������������� �������� 
--    p_bdate   - ���������� ����
--
function get_intpay_state_ex (p_dpuid in dpu_deal.dpu_id%type,
                              p_bdate in date)
return number
is
  c_title  constant varchar2(60) := 'dpu.getintpaystatex:';
  l_freq   dpu_deal.freqv%type;
  l_datbeg dpu_deal.dat_begin%type;
  l_datend dpu_deal.dat_end%type;
  l_intacc int_accn.acra%type;
  l_state  number(1);
begin 

  bars_audit.trace('%s entry, dpuid=>%s, bdate=>%s', c_title, to_char(p_dpuid), to_char(p_bdate));
  
  begin
    select d.freqv, d.dat_begin, d.dat_end, i.acra
      into l_freq, l_datbeg, l_datend, l_intacc
      from dpu_deal d, int_accn i
     where d.acc    = i.acc 
       and i.id     = 1 
       and d.dpu_id = p_dpuid; 
  exception
    when no_data_found then l_state := 0; 
  end;
  
  if l_state is null then
     l_state := get_intpay_state (p_dpuid  => p_dpuid,
                                  p_freq   => l_freq,
                                  p_datbeg => l_datbeg,
                                  p_datend => l_datend,
                                  p_intacc => l_intacc,
                                  p_bdate  => p_bdate);
  end if;
  
  bars_audit.trace('%s exit with %s', c_title, to_char(l_state)); 
  
  return l_state;
  
end get_intpay_state_ex;

--
-- get_vob() - ������� ���������� ��� ���������� ��������� ��� ������ ��������
--
-- ���������:
--    p_tt   - ��� ��������
--    p_kva  - ��� ������-�
--    p_kvb  - ��� ������-�
--
function get_vob (p_tt  in oper.tt%type,
                  p_kva in oper.kv%type,
                  p_kvb in oper.kv2%type)
return oper.vob%type
is
  c_title   constant varchar2(60)   := 'dpu.getvob:'; 
  c_baseval constant tabval.kv%type := gl.baseval;
  l_vob     oper.vob%type;
begin
  
  bars_audit.trace('%s entry, tt=>%s, kva=>%s, kvb=>%s', c_title, p_tt, to_char(p_kva), to_char(p_kvb));
  
  begin
    select vob into l_vob from tts_vob where tt = p_tt;
  exception
    when no_data_found or too_many_rows then
      l_vob := case
               when p_kva != p_kvb     then c_multcur_vob  -- 16 ��������.���.�����
               when p_kva  = c_baseval then c_naticur_vob  --  6 ������������ �����
               else                         c_frgncur_vob  -- 46 ��������.���.�����
               end;
  end;
  
  bars_audit.trace('%s exit with %s', c_title, to_char(l_vob));
  
  return l_vob;
  
end get_vob;

--
-- get_nazn() - ������� ���������� ���������� ������� ��� ������ ��������
--
-- ���������:
--    p_operid - ��� ��������
--    p_dpuid  - ������������� �������� / ���.����������
--    p_tt     - ��� ��������
--    p_mfoa   - ���-�
--    p_nlsa   - ����-�
--    p_kva    - ������-�
--    p_mfob   - ���-�
--    p_nlsb   - ����-�
--    p_kvb    - ������-�
--
function get_nazn (p_operid in dpt_op.id%type,
                   p_dpuid  in dpu_deal.dpu_id%type, 
                   p_tt     in oper.tt%type   default null,
                   p_mfoa   in oper.mfoa%type default null,
                   p_nlsa   in oper.nlsa%type default null,
                   p_kva    in oper.kv%type   default null,
                   p_mfob   in oper.mfob%type default null,
                   p_nlsb   in oper.nlsb%type default null,
                   p_kvb    in oper.kv2%type  default null)
return oper.nazn%type  
is
  c_title   constant varchar2(60) := 'dpu.getnazn:'; 
  l_nazn    oper.nazn%type;
  l_compint number(1);       /* ������� ������������� ��������� */
  l_demand  number(1);       /* ������� �������� �� ������������� */
begin

  bars_audit.trace('%s entry, operid=>%s, dpuid=>%s, tt=>%s, sideA=>%s, sideB=>%s',
                   c_title, to_char(p_operid), to_char(p_dpuid), p_tt,
                            trim(p_mfoa||' '||p_nlsa||' '||to_char(p_kva)),
                            trim(p_mfob||' '||p_nlsb||' '||to_char(p_kvb)) );

  if p_operid in (0, 1) then

     -- ������������� ����� �� ���������� ������� ����� %s 
     l_nazn := substr(bars_msg.get_msg(modcode, 'DOCDTL_TYPE0', dpu.f_nazn('A', p_dpuid)), 1, 160);

  elsif p_operid = 2 then
  
     begin
       select 1 
         into l_demand
         from dpu_deal 
        where dpu_id = p_dpuid 
          and dat_end is null;  
     exception
       when no_data_found then l_demand := 0;
     end;
     
     bars_audit.trace('%s demand_dpt flag = %s', c_title, to_char(l_demand));
     
     if l_demand = 1 then
        l_nazn := substr(bars_msg.get_msg(modcode, 'DOCDTL_TYPE2D')||l_nazn, 1, 160);
     else
        -- (��������) ���������� ����������� ������ ����� %s
        l_nazn := substr(bars_msg.get_msg(modcode, 'DOCDTL_TYPE2', dpu.f_nazn('A', p_dpuid)), 1, 160);
     end if; 

  elsif p_operid = 4 then
     
     -- ������� ������������� ��������� �� ���������� ����
     begin
       select 1 into l_compint 
         from dpu_deal d, accounts a
        where d.dpu_id = p_dpuid 
          and d.acc    = a.acc
          and d.mfo_p  = gl.amfo
          and d.nls_p  = a.nls;  
     exception
       when no_data_found then 
         l_compint := 0;
     end;
     
     bars_audit.trace('%s compound_int flag = %s', c_title, to_char(l_compint));
     
     if l_compint = 0 then
        -- ������������� �����.������� �� ���.������ ����� %s
        l_nazn := substr(bars_msg.get_msg(modcode, 'DOCDTL_TYPE4', dpu.f_nazn('A', p_dpuid)), 1, 160);
     else
        -- ���������� ���.�� ���� �����.������� �� ���.������ ����� %s
        l_nazn := substr(bars_msg.get_msg(modcode, 'DOCDTL_TYPE4C', dpu.f_nazn('A', p_dpuid)), 1, 160);
     end if;
  
  elsif p_operid = 5 then
     
     -- ���������� ������� ��� ������������ �������� �����
     l_nazn := substr(bars_msg.get_msg(modcode, 'DOCDTL_TYPE5P', dpu.f_nazn('A', p_dpuid)), 1, 160);
     
  else
     -- ����������� � ������ ��������
     If (p_tt Is Not Null) Then
        
        SELECT nazn
          INTO l_nazn
          FROM tts
         WHERE tt = p_tt;
        
        If (l_nazn Is Not Null) Then
           l_nazn := '';
        End If;
     Else
       
       l_nazn := null;
       
     End If;
     
     l_nazn := null;
  
  end if;     

  bars_audit.trace('%s exit with %s', c_title, l_nazn);
  
  return l_nazn;

end get_nazn;

$if DPU_PARAMS.LINE8
$then
--
-- get_nls4pay() - �-� ������� ������� ��� ������ ��������
--                 (�������� � 8-�� ����� ��� ���.���)
-- ���������:
--  p_ref - �������� ���������
--  p_nls - ����� �������
--  p_kv  - ��� ������
--
function get_nls4pay
( p_ref  in  oper.ref%type,
  p_nls  in  accounts.nls%type,
  p_kv   in  accounts.kv%type
) return accounts.nls%type 
is
  c_title   constant varchar2(20) := 'dpu.get_nls4pay: '; 
  l_depnls  accounts.nls%type;
  l_dpuid   dpu_deal.dpu_id%type;
  err       exception;
  err_msg   varchar2(250);
begin
  
  bars_audit.trace('%s start with p_ref=%s;', c_title, to_char(p_ref) );
  
  If SubStr(p_nls, 1, 4) in ('2525','2528','2546','2548','2600','2608','2610','2615','2618','2650','2651','2652','2658') then
    
    begin
      
      begin
        select to_number(value)
          into l_dpuid
          from operw 
         where ref = p_ref 
           and tag = 'ND';
      exception
        when NO_DATA_FOUND then
          -- ��� �������� �� ��� ��� ND �� = 0
          l_dpuid := 0;
        when OTHERS        then
          err_msg := '������� ������� ������������� ��������� �����!!!';
          raise err;
      end;
      
      if ( l_dpuid = 0 )
      then -- �������� ������� �� ��������� �� ��
      
        begin
          select gen_id
            into l_dpuid
            from V_DPU_RELATION_ACC 
           where gen_acc = (select acc from accounts where nls = p_nls and kv = p_kv)
             and ROWNUM = 1;
        exception
          when NO_DATA_FOUND then
            l_dpuid := null;
        end;
        
        -- ���� �������� ������� � �������� ���.��������
        if (l_dpuid is not null) then
          err_msg := '������� '||p_nls||'/'||to_char(p_kv)||' �������� ������������ �������� #'||to_char(l_dpuid)||'! ������ ������������� ������!';
          raise err;
        else
          l_depnls := null;
        end if;
        
      else
        
        begin    
          select nls
            into l_depnls
            from accounts 
           where acc = (select dep_acc
                          from V_DPU_RELATION_ACC 
                         where gen_acc = (select acc from accounts where nls = p_nls and kv = p_kv)
                           and dep_id  = l_dpuid
                        );
        exception
          when NO_DATA_FOUND then
            l_depnls := vkrzn( substr(gl.amfo, 1, 5), '86000000000000' );
            /* 
            select MFOB
              into l_depnls
              from oper
             where ref = p_ref;
            
            if l_depnls != gl.aMFO then
               l_depnls := vkrzn( substr(gl.amfo, 1, 5), '86000000000000' );
            else
              -- err_msg := '������� '||p_nls||'/'||to_char(p_kv)||' �� � �������� ������������ �������� ��� ��������� ����� #'||to_char(l_dpuid);
              -- raise err;
              l_depnls := null;
            end if;
            */
        end;
        
      end if;
      
    end;
  
  ElsIf SubStr(p_nls, 1, 1) =  '8' then
  
    if ( p_ref = -2 )
    then
      begin
        select NLS
          into l_depnls
          from ACCOUNTS
         where ACC = (select gen_acc
                        from V_DPU_RELATION_ACC 
                       where dep_acc = (select acc from accounts where nls = p_nls and kv = p_kv)
                     );
--       where ( NLS, KV ) in ( select NLSALT, KV from ACCOUNTS where NLS = p_nls and KV = p_kv );
      exception
        when NO_DATA_FOUND then
           err_msg := '������� '||p_nls||'/'||to_char(p_kv)||' �� � �������� ��������� �����!!';
           raise err;
      end;
    else
      l_depnls := p_nls;
    end if;
  
  -- �������� 6399 ���� ������� �������� �� ����� ���� �������
  ElsIf ( (SubStr(p_nls, 1, 2) = '70') Or (SubStr(p_nls, 1, 4) in ('6399','6350')) )
  then
    l_depnls := vkrzn( substr(gl.amfo, 1, 5), '80210000000000' );
  Else
    l_depnls := vkrzn( substr(gl.amfo, 1, 5), '86000000000000' );
  end if;
  
  bars_audit.trace('%s exit with depnls=%s;', c_title, l_depnls);
  
  RETURN l_depnls;
  
exception
  when ERR    then 
    raise_application_error( -20888, err_msg, TRUE );
  when OTHERS then
    raise_application_error( -20001, dbms_utility.format_error_stack() ||chr(10)|| dbms_utility.format_error_backtrace(), TRUE );
end get_nls4pay;

---
-- �������� �������� �� ������� ���.��
---
function IS_LINE
( p_ref  in  oper.ref%type
) return number
is
  l_nlsA  accounts.nls%type;
  l_kv_A  accounts.kv%type;
  l_nlsB  accounts.nls%type;
  l_kv_B  accounts.kv%type;
  l_out   number;
begin
  
  bars_audit.trace('DPU.IS_LINE: start with p_ref=%s.', to_char(p_ref) );
  
  begin
    
    select nlsA, kv, nlsB, kv2
      into l_nlsA, l_kv_A, l_nlsB, l_kv_B
      from OPER
     where ref = p_ref;
    
    bars_audit.trace('DPU.IS_LINE: nlsA=%s, nlsB=%s.', l_nlsA, l_nlsB );
  
    select min(gen_id)
      into l_out
      from V_DPU_RELATION_ACC 
     where gen_acc = (select acc from accounts where nls = l_nlsA and kv = l_kv_A)
        or gen_acc = (select acc from accounts where nls = l_nlsB and kv = l_kv_B);
    
  exception
    when OTHERS then
      l_out := null;
  end;
  
  bars_audit.trace('DPU.IS_LINE: exit with %s;', nvl(to_char(l_out),'<null>') );
  
  return l_out;
  
end IS_LINE;
$end

--
--
--
function GET_SWIFT_DETAILS
( p_dpuid         in     dpu_deal.dpu_id%type  -- ��. ����������� ��������
, p_tt            in     oper.tt%type          -- ��� ��������
, p_accrec        in     dpt_web.acc_rec
) return t_swift_dtls_type
is
  title     constant     varchar2(64) := $$PLSQL_UNIT||'.GET_SWIFT_DETAILS';
  t_swift_dtls           t_swift_dtls_type := t_swift_dtls_type();
  l_accrec               dpt_web.acc_rec;
  l_val                  operw.value%type;
  l_dpu_id               dpu_deal.dpu_id%type; -- ��. ������������ ��������
  l_num                  dpu_deal.nd%type;
  l_dat                  dpu_deal.datz%type;
  l_rnk                  dpu_deal.rnk%type;
  r_swtags               dpu_deal_swtags%rowtype;
  l_adr                  customer_address.address%type;
  l_city                 customer_address.locality%type;
  l_d_rec                oper.d_rec%type;
begin
  
  bars_audit.trace( '%s: Entry with ( p_dpuid=%s, p_tt=%s ).', title, to_char(p_dpuid), p_tt );
  
  begin
    select d.DPU_ID, d.ND, d.DATZ, d.RNK
      into l_dpu_id, l_num, l_dat, l_rnk
      from ( select DPU_ID, ND, DATZ, RNK
               from DPU_DEAL
              where DPU_ID = p_dpuid
                and DPU_GEN Is Null
              union
             select gd.DPU_ID, gd.ND, gd.DATZ, gd.RNK
               from DPU_DEAL sd
               join DPU_DEAL gd
                 on ( gd.DPU_ID = sd.DPU_GEN )
              where sd.DPU_ID = p_dpuid
                and sd.DPU_GEN Is Not Null
            ) d;
  exception
    when NO_DATA_FOUND then
      bars_error.raise_nerror( modcode, 'DPUID_NOT_FOUND', to_char(p_dpuid) );
  end;
  
  if ( p_accrec.ACC_NUM IS Null )
  then
    
    begin
      select ac.NLS
        into l_accrec.ACC_NUM
        from ACCOUNTS ac
        join DPU_ACCOUNTS da
          on ( da.ACCID = ac.ACC )
       where da.DPUID = l_dpu_id
         and ac.TIP = case p_tt when 'DU7' then 'DEN' else 'DEP' end;
    exception
      when NO_DATA_FOUND then
        l_accrec.ACC_NUM := null;
    end;
    
    begin
      select OKPO
        into l_accrec.CUST_IDCODE
        from CUSTOMER c
       where c.RNK = l_rnk;
    exception
      when NO_DATA_FOUND then
        l_accrec.CUST_IDCODE := null;
    end;
    
  else
    l_accrec := p_accrec;
  end if;
  
  begin
    select *
      into r_swtags
      from DPU_DEAL_SWTAGS
     where DPU_ID = p_dpuid;
  exception
    when NO_DATA_FOUND then
      bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�� ������ SWIFT �������� ��� �������!' );
  end;

  begin
    select BARS_SWIFT.STRVERIFY2( F_TRANSLATE_KMU( upper(LOCALITY) ), 'TRANS' )
         , BARS_SWIFT.STRVERIFY2( F_TRANSLATE_KMU( upper(ADDRESS ) ), 'TRANS' )
      into l_city
         , l_adr
      from CUSTOMER_ADDRESS
     where RNK     = l_rnk
       and TYPE_ID = 1;
  exception
    when NO_DATA_FOUND then
      l_city := '___';
      l_adr  := r_swtags.TAG59_ADR;
  end;

  for w in ( select r.TAG, r.USED4INPUT, r.OPT, r.VAL
                  , f.VSPO_CHAR
               from OP_RULES r
               join OP_FIELD f
                 on ( f.TAG = r.TAG )
              where r.TT = p_tt
                and r.TAG Not in ('DPTOP','ND   ') )
  loop
    
    if ( w.USED4INPUT = 1 )
    then
      
      l_val := case w.TAG
                 when '50F  ' -- �������� ��������
                 then '/' || l_accrec.ACC_NUM                       || chr(10) -- ����� ������� ��������
                          || SubStr('1/'||r_swtags.TAG59_NAME,1,35) || chr(10) -- ����� �������� (������.�볺���)
                          || SubStr('2/'    || l_adr         ,1,35) || chr(10) -- ������ ��������
                          || SubStr('3/UA/' || l_city        ,1,35) || chr(10) -- ��� ����� + ̳���
                          ||        '6/UA/' || l_accrec.CUST_IDCODE            -- ��� ����� + ��� ������ ��������
                 when '52A  ' -- SWIFT-��� ����� ��������
$if DPU_PARAMS.MMFO $then
                 then BRANCH_ATTRIBUTE_UTL.GET_VALUE('BICCODE')
$else
                 then GetGlobalOption('BICCODE')
$end
                 when '56A  ' -- SWIFT-��� ����� �����������
                 then r_swtags.TAG56_CODE
                 when '57A  ' -- SWIFT-��� ����� �����������
                 then '/' || r_swtags.TAG57_ACC || chr(10)
                          || r_swtags.TAG57_CODE
                 when '59   ' -- �������� ����������
                 then '/' || r_swtags.TAG59_ACC               || chr(10) -- ����� ������� ���������� 
                          || SubStr(r_swtags.TAG59_NAME,1,35) || chr(10) -- ����� ����������
                          || SubStr(r_swtags.TAG59_ADR ,1,35)            -- ������ ����������
                 when '70   ' -- ����������� �������
                 then SubStr(w.VAL,1,35)      || chr(10) ||
                      'IN ACCORD TO CONTRACT' || chr(10) ||
                      SubStr('N '||l_num,1,35)|| chr(10) ||
                      'OF ' || to_char(l_dat,'dd.mm.yyyy')
                 when 'KOD_B'
                 then nvl( w.VAL, '6' )
                 else
                   null
               end;
      
    else -- takes default value from configuration of the operation
      
      l_val := w.VAL;
      
    end if;
    
    if ( l_val Is Not Null )
    then
      
      t_swift_dtls.extend;
      t_swift_dtls(t_swift_dtls.last).TAG := w.TAG;
      t_swift_dtls(t_swift_dtls.last).VAL := l_val;
      
      if ( w.VSPO_CHAR Not in ('F','C','�') )
      then
        
        if ( w.VSPO_CHAR = 'f' )
        then -- ������� �������
          l_d_rec := '#' || w.VSPO_CHAR || l_val || l_d_rec;
        else -- ������� ������
          l_d_rec := l_d_rec || '#' || w.VSPO_CHAR || l_val;
        end if;
        
      end if;
      
    end if;
    
  end loop;
  
  if ( length(l_d_rec) > 0 )
  then
    
    t_swift_dtls.extend;
    t_swift_dtls(t_swift_dtls.last).TAG := 'D_REC';
    t_swift_dtls(t_swift_dtls.last).VAL := l_d_rec || '#';
    
  end if;
  
  return t_swift_dtls;
  
end GET_SWIFT_DETAILS;

--
--
--
function GET_SWT_DTL
( p_dpuid         in     dpu_deal.dpu_id%type  -- ��. ����������� ��������
, p_tt            in     oper.tt%type          -- 
) return varchar2
is
  title     constant     varchar2(64) := $$PLSQL_UNIT||'.GET_SWT_DTL';
  t_swift_dtls           t_swift_dtls_type;
  l_swift_dtls           varchar2(2048);
begin

  bars_audit.trace( '%s: Entry with ( p_dpuid=%s, p_tt=%s ).', title, to_char(p_dpuid), p_tt );

  begin

    t_swift_dtls := GET_SWIFT_DETAILS( p_dpuid, p_tt, null );

    if ( t_swift_dtls.count > 0 )
    then

      for r in t_swift_dtls.first .. t_swift_dtls.last
      loop
        l_swift_dtls := l_swift_dtls || chr(38) || 'reqv_' || trim(t_swift_dtls(r).TAG)
                                                || '='     || trim(t_swift_dtls(r).VAL);
      end loop;

      t_swift_dtls.delete();

    end if;

  exception
    when OTHERS then
      l_swift_dtls := null;
  end;

  bars_audit.trace( '%s: %s.', title, l_swift_dtls );

  return l_swift_dtls;

end GET_SWT_DTL;

--
-- iset_details() - �����.��������� ������������ ������ �������� ������� ������
--
-- ���������:
--    p_details - ����� �������� ������� ������
--    p_text    - ����������� ������
--
procedure iset_details (p_details in out varchar2, p_text in varchar2)
is
begin
  p_details := p_details || p_text || c_endline;
end iset_details;

--
-- get_penalty_ex() - ��������� ������� ���������� ������ � ����� ������ 
--                    ��� ��������� ����������� ����������� ��������
--
-- ���������:
--    p_dpuid          - �������� ����������� ��������
--    p_bdate          - ���� ���������� ����������� 
--    p_totalint_nom   - ����� ����������� %% (���) �� ������ ��������
--    p_totalint_eqv   - ����� ����������� %% (���) �� ������ ��������
--    p_penyaint_nom   - ����� ����������� %% (���) �� �������� ������
--    p_penyaint_eqv   - ����� ����������� %% (���) �� �������� ������
--    p_intpay_nom     - ����� ������ (���) ��� �������� � ����������� �����
--    p_intpay_eqv     - ����� ������ (���) ��� �������� � ����������� �����
--    p_dptpay_nom     - ����� ������ (���) ��� �������� � ����������� �����
--    p_dptpay_eqv     - ����� ������ (���) ��� �������� � ����������� �����
--    p_penya_rate     - �������� ������ 
--    p_tax_inc_ret    - ���� ���������� � ����������� %% ������� �� �������� � �� (��� ����������)
--    p_tax_mil_ret    - ���� ���������� � ����������� %% ���������� ����� � ��   (��� ����������)
--    p_tax_inc_pay    - ���� ������� �� �������� � �� (��� ������ � ���� ����������� %% �� ������� ������)
--    p_tax_mil_pay    - ���� ���������� ����� � ��   (��� ������ � ���� ����������� %% �� ������� ������)
--    p_details        - ����������� ������� ������
--
procedure get_penalty_ex
( p_dpuid         in   number,
  p_bdate         in   date,
  p_totalint_nom  out  number,
  p_totalint_eqv  out  number,
  p_penyaint_nom  out  number,
  p_penyaint_eqv  out  number,
  p_intpay_nom    out  number,
  p_intpay_eqv    out  number,
  p_dptpay_nom    out  number,
  p_dptpay_eqv    out  number,
  p_penya_rate    out  number,
  p_tax_inc_ret   out  number,
  p_tax_mil_ret   out  number,
  p_tax_inc_pay   out  number,
  p_tax_mil_pay   out  number,
  p_details       out  varchar2
) is
  -- constants
  c_title     constant varchar2(64)     := 'dpu.getpenalty:';
  c_baseval   constant tabval.kv%type   := gl.baseval;
  c_getintid  constant int_accn.id%type := 1;
  c_addintid  constant int_accn.id%type := 3;
  -- types
  type t_dealrec is record (dealnum     dpu_deal.nd%type,
                            dealdat     dpu_deal.datz%type,
                            gen_num     dpu_deal.nd%type,
                            datbeg      dpu_deal.dat_begin%type,
                            datend      dpu_deal.dat_end%type,
                            freq        dpu_deal.freqv%type,
                            stopid      dpu_deal.id_stop%type,
                            minsum      dpu_deal.min_sum%type,
                            depacc      accounts.acc%type,
                            depsal      accounts.ostc%type,
                            depflg      number(1),
                            blkd        accounts.blkd%type,
                            intacc      accounts.acc%type,
                            intsal      accounts.ostc%type,
                            intflg      number(1),
                            curid       tabval.kv%type,
                            curcode     tabval.lcv%type,
                            acrdat      int_accn.acr_dat%type,
                            rate        int_ratn.ir%type,
                            tax         number(1) );
  type t_stoprec is record (penya_type  dpt_stop_a.sh_proc%type,
                            penya_value dpt_stop_a.k_proc%type,
                            term_type   dpt_stop_a.sh_term%type,
                            term_value  dpt_stop_a.k_term%type);
  -- valiables
  l_dpu          t_dealrec;
  l_stopdtl      t_stoprec;
  l_stop         dpt_stop%rowtype;
  l_saldo        accounts.ostc%type;
  l_term_fact    number(38);
  l_term_plan    number(38);
  l_month_cnt    number;
  l_term         number;
  l_acrdat1      date;
  l_acrdat2      date;
  l_date_prol    date;
  --
  l_msgcode      msg_codes.msg_code%type;
  l_tax_income   oper.s%type;
  l_tax_military oper.s%type;
begin
  
  bars_audit.trace('%s entry with {%s, %s}', c_title, to_char(p_dpuid), to_char(p_bdate,'dd/mm/yyyy'));
  
  SAVEPOINT penalty;
  
  -- -------------------------------------------------------------------------
  --                                                                        --
  -- 1. ��������� ����������� �������� � �������� ������������ �����������  --
  --                                                                        --
  -- -------------------------------------------------------------------------

  begin
    select nvl2(d.dpu_gen, to_char(nvl(d.dpu_add, 0)), d.nd), 
           d.datz,
          (select g.nd from dpu_deal g where g.dpu_id = d.dpu_gen),
           d.dat_begin, 
$if DPU_PARAMS.SBER
$then
           d.datV, 
$else
           d.dat_end,
$end
           d.freqv, d.id_stop, d.min_sum, 
           a.acc, a.ostc, decode(a.ostc, a.ostb, 1, 0), a.blkd,
           p.acc, p.ostc, decode(p.ostc, p.ostb, 1, 0),
           t.kv, t.lcv, i.acr_dat, acrn.fproc(d.acc, p_bdate),
           case 
             when sed  = '91'  then 1
             when k050 = '910' then 1
             else 0
           end
      into l_dpu
      from DPU_DEAL d 
      join ACCOUNTS a on ( a.acc = d.acc ) 
      join INT_ACCN i on ( i.acc = a.acc and i.id = c_getintid )
      join ACCOUNTS p on ( p.acc = i.acra )
      join TABVAL   t on ( t.kv  = a.kv  )
      join CUSTOMER c on ( c.rnk = d.rnk )
     where d.dpu_id = p_dpuid;
  exception
    when no_data_found then
      bars_error.raise_nerror(modcode, 'DPUID_NOT_FOUND', to_char(p_dpuid));
  end;    

  -- ��������� ���� ������
  begin
    select * 
      into l_stop
      from BARS.DPT_STOP 
     where id = l_dpu.stopid;
  exception 
    when no_data_found then 
      -- �� ������� ��������� ������ � ...
      bars_error.raise_nerror( modcode, 'IDSTOP_PARAMS_NOT_FOUND', to_char(l_dpu.stopid) );
  end;

  if l_dpu.gen_num is not null 
  then -- ���.���������� � %s �� %s � �������� � %s (#...)
    iset_details( p_details, bars_msg.get_msg( modcode, 'COMMENT_NDADD_DATN', 
                                                        l_dpu.dealnum,
                                                        to_char(l_dpu.dealdat,'dd/mm/yyyy'),
                                                        l_dpu.gen_num, 
                                                        to_char(p_dpuid)));
  else -- ���������� ������� � .. �� .. (#...)
    iset_details( p_details, bars_msg.get_msg( modcode, 'COMMENT_ND_DATN', 
                                                        l_dpu.dealnum,
                                                        to_char(l_dpu.dealdat,'dd/mm/yyyy'), 
                                                        to_char(p_dpuid)));
  end if;
  
  if nvl(l_dpu.stopid, 0) = 0
  then -- ���������� ������� � ... - �� ������������� �����������
     bars_error.raise_nerror(modcode, 'DPUID_IDSTOP_0', to_char(p_dpuid));
  elsif nvl(l_dpu.stopid, 0) = �_IRVC_STPID
  then -- ���������� ���������� ��������� ����� ��� ������������ ��������
     bars_error.raise_nerror( modcode, 'DPUID_IDSTOP_IRREVOCABLE' );
  elsif l_dpu.datbeg >= p_bdate
  then -- ���������� ������� � ... - �� ������� � ����
     bars_error.raise_nerror(modcode, 'DPUID_NOT_BEGIN', to_char(p_dpuid));
  elsif l_dpu.datend is null
  then -- ���������� ������� � ... - ����������
     bars_error.raise_nerror(modcode, 'DPUID_DATO_IS_NULL', to_char(p_dpuid));
  elsif l_dpu.datend <= p_bdate
  then -- ���������� ������� � ... - ���������
     bars_error.raise_nerror(modcode, 'DPUID_END', to_char(p_dpuid));
  elsif l_dpu.depflg != 1
  then -- ���������� ������� � ... - ������� ���������.��������� �� ���.�����
     bars_error.raise_nerror(modcode, 'DEPACC_SALDO_MISMATCH', to_char(p_dpuid));
  elsif l_dpu.intflg != 1 
  then
     -- ���������� ������� � ... - ������� ���������.��������� �� ����.�����
     bars_error.raise_nerror(modcode, 'INTACC_SALDO_MISMATCH', to_char(p_dpuid));
  elsif l_dpu.acrdat < (p_bdate - 1) 
  then -- ��� ���������� ������ ��������� ������������ �������
    bars_error.raise_nerror( modcode, 'INTEREST_NOT_ACCRUED', to_char(p_dpuid));
  elsif l_dpu.blkd > 0 
  then -- ���������� ������� ������������ �� �����
    bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '���������� ������� ������������ �� ����� ' ||
                             '(��� ���������� = '|| to_char(l_dpu.blkd) || ')' );
  else -- 1. ��� ������ � ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT1_SHTRAFTYPE', to_char(l_stop.id), l_stop.name));
  end if;
  
  -- -------------------------------------------------------------------------
  --                                                                        --
  --      2. ����� ����� ����������� ��������� �� ����������� ��������      --
  --                                                                        --
  -- -------------------------------------------------------------------------
  
  begin
    -- ���� �� ��� ������� 䳿� / ����������� ��������
    select dateu
      into l_date_prol
      from DPU_DEAL_UPDATE
     where idu = ( select min(idu)
                     from DPU_DEAL_UPDATE u, 
                          DPU_DEAL        d 
                    where d.dpu_id    = p_dpuid
                      and d.dpu_id    = u.dpu_id
                      and d.dat_begin = u.dat_begin );
  exception
    when NO_DATA_FOUND then
      l_date_prol := l_dpu.datbeg;
  end;
  
  -- ����� ����� ����������� ���������
  select nvl(sum(p.s ),0)
       , nvl(sum(p.sq),0)
    into p_totalint_nom
       , p_totalint_eqv
    from opldok p, 
         oper o 
   where p.acc   = l_dpu.intacc
     and p.fdat >= l_dpu.datbeg
     and p.fdat <= p_bdate
     and p.sos   = 5
     and p.dk    = 1
     and p.ref   = o.ref
     and o.pdat  > l_date_prol;

  -- 2. ����� ����� ����������� ��������� �� ������ � ... �� ... ��������� ...
  iset_details( p_details, bars_msg.get_msg( modcode, 'COMMENT2_TITLE' ) );

  iset_details( p_details, bars_msg.get_msg( modcode, 'COMMENT2_SUMN',
                                                      to_char(l_dpu.datbeg, 'dd/mm/yyyy'),
                                                      to_char(l_dpu.acrdat, 'dd/mm/yyyy'),
                                                      trim(to_char(p_totalint_nom/100,'9999999999D99')),
                                                      l_dpu.curcode )
                 || ( case when l_dpu.curid != c_baseval 
                      then bars_msg.get_msg( modcode, 'COMMENT2_SUMEQV'
                                                    , trim(to_char(p_totalint_eqv/100,'9999999999D99')))
                      end ) );

  -- ������� �� �����
  l_saldo := nvl(FOST(l_dpu.depacc,p_bdate),0);
  
$if MAKE_INTEREST.G_USE_TAX_INC OR MAKE_INTEREST.G_USE_TAX_MIL
$then
  ----------------------------------------------------------------------------
  -- ���� ������� � ����������� �������                                  --
  -- 1) ������� �� �������� � ��                                            --
  -- 2) ���������� ����� � ��                                              --
  ----------------------------------------------------------------------------
  if ( l_dpu.tax = 1 )
  then
    
    begin
      SELECT sum(case when t.tt = '%15' then t.s else 0 end),
             sum(case when t.tt = 'MIL' then t.s else 0 end)
        INTO l_tax_income, l_tax_military
        FROM BARS.OPLDOK       t
        JOIN BARS.OPER         o on ( o.REF = t.REF )
        JOIN BARS.DPU_PAYMENTS p on ( p.REF = t.REF )  
       WHERE t.acc   = l_dpu.intacc
         AND t.fdat >= l_dpu.datbeg
         and t.fdat <= p_bdate
         AND t.dk    = 0 
         AND t.sos   = 5
         AND t.tt IN ( '%15', 'MIL' )
         AND o.PDAT   > l_date_prol
         AND p.DPU_ID = p_dpuid;
    exception
      when NO_DATA_FOUND then
        l_tax_income   := 0;
        l_tax_military := 0;
    end;
    
    bars_audit.trace( '%s tax_income=%s, tax_military=%s.', c_title, to_char(l_tax_income), to_char(l_tax_military) );

  else
    
    p_tax_inc_ret := 0;
    p_tax_mil_ret := 0;
    p_tax_inc_pay := 0;
    p_tax_mil_pay := 0;

  end if;
$end
  -- -------------------------------------------------------------------------
  --                                                                        --
  --     3. ���������� �������������� ������� ����� �������� ��������       --
  --                                                                        --
  -- -------------------------------------------------------------------------
  
  l_term_fact := p_bdate - l_dpu.datbeg + 1;
  l_term_plan := l_dpu.datend - l_dpu.datbeg + 1;
  l_month_cnt := months_between(p_bdate, l_dpu.datbeg);

  -- 3. ���������� �������������� ������� 
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT3_TITLE'));
  --       ���� �������� ��������: ... - ...
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT3_TERM', 
                                                     to_char(l_dpu.datbeg,'dd/mm/yyyy'),
                                                     to_char(l_dpu.datend,'dd/mm/yyyy'))); 
  --       �������� ���� = ... ��.
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT3_TERMPLAN',
                                                     to_char(l_term_plan)));
  --       ����������� ���� = ... ��.
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT3_TERMFACT',
                                                     to_char(l_term_fact)));

  -- ���� ������� �������� ������ 1 ������, �� %% �� �����������
  if (l_stop.sh_proc = 1 and trunc(l_month_cnt) < 1) 
  then
     -- ���� �������� ������ 1 ������ 
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT3_TERM1MONTHS'));
     p_penya_rate    := 0;
     p_penyaint_nom  := 0;
     p_penyaint_eqv  := 0;
     p_dptpay_nom    := greatest ((p_totalint_nom - p_penyaint_nom) - l_dpu.intsal, 0);
     p_intpay_nom    := (p_totalint_nom - p_penyaint_nom) - p_dptpay_nom;
     p_dptpay_eqv    := round(  (p_totalint_eqv - p_penyaint_eqv) 
                              / (p_totalint_nom - p_penyaint_nom) 
                              *  p_dptpay_nom);
     p_intpay_eqv    := (p_totalint_eqv - p_penyaint_eqv) - p_dptpay_eqv;

     bars_audit.trace('%s exit with rate %s, totalint %s/%s, penyaint %s/%s', 
                      c_title,              to_char(p_penya_rate),
                      to_char(p_totalint_nom), to_char(p_totalint_eqv),
                      to_char(p_penyaint_nom), to_char(p_penyaint_eqv));
     bars_audit.trace('%s exit with intpay %s/%s, dptpay %s/%s, details %s', 
                      c_title, 
                      to_char(p_intpay_nom), to_char(p_intpay_eqv),
                      to_char(p_dptpay_nom), to_char(p_dptpay_eqv),
                      p_details);
     return;
  end if;

  -- ������������� ������ ������ � ������� ���������
  if l_stop.fl = 0 then     -- ���� ����� � %%
     l_term    := trunc((l_term_fact / l_term_plan) * 100); 
     l_msgcode := 'COMMENT3_TERM_IN_PROC';
  elsif l_stop.fl = 1 then  -- ���� ����� � ���. 
     l_term    := round(l_month_cnt, 2);                       
     l_msgcode := 'COMMENT3_TERM_IN_MONTHS';
  else                      -- ���� ����� � ����  
     l_term    := p_bdate - l_dpu.datbeg + 1;
     l_msgcode := 'COMMENT3_TERM_IN_DAY';
  end if;
  -- => �� = ... %%/���/����
  iset_details (p_details, bars_msg.get_msg(modcode, l_msgcode, to_char(l_term)));

  -- -------------------------------------------------------------------------
  --                                                                        --
  --        4. ������ ���� � �������� ������ ��� ������� �������            --
  --                                                                        --
  -- -------------------------------------------------------------------------

  -- 4. ������ �������� ������ ��� ������� �������
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHTRAF'));
  
  begin
    select s.sh_proc, s.k_proc,  s.sh_term, s.k_term 
      into l_stopdtl
      from dpt_stop_a s
     where s.id     = l_stop.id 
       and s.k_srok = (select max(t.k_srok) 
                         from dpt_stop_a t
                        where t.id      = s.id 
                          and t.k_srok <= l_term
                          and t.k_srok <= (select min(k_srok) 
                                             from dpt_stop_a 
                                            where id = s.id 
                                              and k_srok > l_term));
  exception 
    when no_data_found then
      -- ����� �� �������� �����������
      iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHTRAF_OUT')); 
      p_penya_rate   := l_dpu.rate; 
      p_penyaint_nom := p_totalint_nom;
      p_penyaint_eqv := round( gl.p_icurval( l_dpu.curid, p_penyaint_nom, p_bdate ) );
      p_dptpay_nom   := greatest ((p_totalint_nom - p_penyaint_nom) - l_dpu.intsal, 0);
      p_intpay_nom   := (p_totalint_nom - p_penyaint_nom) - p_dptpay_nom;
      p_dptpay_eqv   := round( gl.p_icurval( l_dpu.curid, p_dptpay_nom, p_bdate ) );
      p_intpay_eqv   := (p_totalint_eqv - p_penyaint_eqv) - p_dptpay_eqv;
      
      bars_audit.trace('%s exit with rate %s, totalint %s/%s, penyaint %s/%s', 
                       c_title,              to_char(p_penya_rate),
                       to_char(p_totalint_nom), to_char(p_totalint_eqv),
                       to_char(p_penyaint_nom), to_char(p_penyaint_eqv));
      bars_audit.trace('%s exit with intpay %s/%s, dptpay %s/%s, details %s', 
                       c_title, 
                       to_char(p_intpay_nom), to_char(p_intpay_eqv),
                       to_char(p_dptpay_nom), to_char(p_dptpay_eqv),
                       p_details);
      return;
  end;

  -- �������� ���.���������� �������� ��� ������� �������� ���������
  delete from int_accn where acc = l_dpu.depacc and id = c_addintid;
  insert into int_accn (acc, id, basey, metr, io, freq, tt, acra, acrb)
  select acc, c_addintid, basey, metr, io, freq, tt, acra, acrb 
    from int_accn 
   where acc = l_dpu.depacc and id = c_getintid;

  -- -------------------------------------------------------------------------
  --                                                                        --
  --       4�. ������ ������ ��� ���������� �������� ���������              --
  --   � ���������� ������� ��������� ������ ��� ���.���������� ��������    --
  --                                                                        --
  -- -------------------------------------------------------------------------

  -- ������� ����� (������� �� ���� ������, ����������� �� ��������)
  if l_stopdtl.penya_type = 1 then

     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHTYPE1', 
                                                        to_char(l_stopdtl.penya_value)) );
     for r in (select bdat, 
                      acrn.fproc(acc, bdat) nomrate, 
                      acrn.fproc(acc, bdat) * (1 - l_stopdtl.penya_value/100) penrate
                 from int_ratn 
                where acc   = l_dpu.depacc 
                  and bdat <= p_bdate
                order by bdat) 
     loop

         p_penya_rate := r.penrate;
         
         insert into int_ratn (acc, id, bdat, ir) 
         values (l_dpu.depacc, c_addintid, r.bdat, r.penrate);
         
         -- �� ... ������� ������  = ... => �������� ������ = ...
         iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_CURRATE', 
                                                            to_char(r.bdat,'dd/mm/yyyy'),
                                                            to_char(r.nomrate))); 
         iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHRATE',
                                                            to_char(r.penrate)));
     end loop;

  end if;

  -- ������ ����� (������� �� ���������� ������ �� ��������)
  if l_stopdtl.penya_type = 2 then
     
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHTYPE2'));

     if l_dpu.rate is null then
       -- ���������� ��������� ����������� ���������� ������ �� ������
       bars_error.raise_nerror(modcode, 'ACTUALRATE_IS_NULL');
     end if;

     p_penya_rate := (1 - l_stopdtl.penya_value/100) * l_dpu.rate;

     insert into int_ratn (acc, id, bdat, ir) 
     values (l_dpu.depacc, c_addintid, l_dpu.datbeg, p_penya_rate);

     -- �� ... ������� ������ = ... => �������� ������ = ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_CURRATE', 
                                                        to_char(p_bdate, 'dd/mm/yyyy'),
                                                        to_char(l_dpu.rate))); 
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHRATE',
                                                        to_char(p_penya_rate)));
  end if;

  -- ������������� ������� ������
  if l_stopdtl.penya_type = 3 then

     p_penya_rate := l_stopdtl.penya_value;

     insert into int_ratn (acc, id, bdat, ir) 
     values (l_dpu.depacc, c_addintid, l_dpu.datbeg, p_penya_rate);
     
     -- ������������� ������� ������ => �������� ������ = ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHTYPE3'));
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHRATE', 
                                                        to_char(l_stopdtl.penya_value)));
  end if;

  -- ����� �� ��������� ������� ���������� ������
  if l_stopdtl.penya_type = 5 then

     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHTYPE5', 
                                                        to_char(l_stopdtl.penya_value)));

     begin
       p_penya_rate := getbrat(p_bdate, l_stopdtl.penya_value, l_dpu.curid, l_saldo);
     exception 
       when others then
         -- ���������� �������� �������� ������� ������ � ...
         bars_error.raise_nerror(modcode, 'SHPROC_NOT_FOUND', to_char(l_stopdtl.penya_value));
     end;    

     insert into int_ratn (acc, id, bdat, ir) 
     values (l_dpu.depacc, c_addintid, l_dpu.datbeg, p_penya_rate);

     -- => �������� ������ = ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT4_SHRATE', to_char(p_penya_rate)));

  end if;

  -- -------------------------------------------------------------------------
  --                                                                        --
  --          5. ������ ������� ��� ���������� �������� ���������           --
  --                                                                        --
  -- -------------------------------------------------------------------------

  -- 5. ������ ��������� �������
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT5_SHTERM'));

  if l_stopdtl.term_type = 2 then

     -- c��� ������ = ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT5_SHTERM2', 
                                                        to_char(l_stopdtl.term_value)));

     if l_stop.fl = 1 then -- ���� ����� � �������
        l_acrdat2 := add_months(p_bdate - 1, - nvl(l_stopdtl.term_value, 0));
     elsif l_stop.fl = 2 then -- ���� ����� � ����
        l_acrdat2 := p_bdate - 1 - nvl(l_stopdtl.term_value, 0);
     else
        -- ����������� ������ �����
        bars_error.raise_nerror(modcode, 'SH_IS_UNCORRECT');
     end if;

  elsif l_stopdtl.term_type = 1 then

     -- ����� �� ��������� ��������� ������ ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT5_SHTERM1', 
                                                        to_char(l_stopdtl.term_value)));

     l_acrdat2 := case 
                  when l_dpu.freq =   3 then l_dpu.datbeg + 7 * trunc((l_term_fact - 1)/7, 0)
                  when l_dpu.freq =   5 then add_months(l_dpu.datbeg, 1 * trunc(l_month_cnt, 0))
                  when l_dpu.freq =   7 then add_months(l_dpu.datbeg, 3 * trunc(l_month_cnt/3, 0))
                  when l_dpu.freq = 180 then add_months(l_dpu.datbeg, 6 * trunc(l_month_cnt/6, 0))
                  when l_dpu.freq = 360 then add_months(l_dpu.datbeg, 12 * trunc(l_month_cnt/12, 0))
                  when l_dpu.freq = 400 then l_dpu.datend
                  else                       l_dpu.datbeg 
                  end;

  else  -- l_stopdtl.term_type = 0

     l_acrdat2 := p_bdate - 1;

  end if;
  
  -- �������� �������� ����������� �� ...
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT5_SH_ARC_DAT',
                                                     to_char(l_acrdat2,'dd/mm/yyyy')));


  -- -------------------------------------------------------------------------
  --                                                                        --
  --          6. ������ ������� ��� ���������� �������� ���������           --
  --                                                                        --
  -- -------------------------------------------------------------------------
  
  -- 6. ��� ������� ��� ������� ������
  iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT6_OSTTYPE'));

  select nvl(min(fdat), l_dpu.datbeg) + 1 
    into l_acrdat1
    from saldoa 
   where acc   = l_dpu.depacc 
     and kos  >  0
     and fdat >= l_dpu.datbeg 
     and fdat <  p_bdate;

  if l_stop.sh_ost = 1 then
    
     l_saldo := fost (l_dpu.depacc, l_acrdat1);
      
     -- ����� �� ����� ���������� ������ = ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT6_SHOST1',
                                                        trim(to_char(l_saldo/100,'9999999999D99')),
                                                        l_dpu.curcode));
  
  elsif l_stop.sh_ost = 3 then
     
     l_saldo := l_saldo;
     
     -- ����� �� �������� ������� = ...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT6_SHOST3',
                                                        trim(to_char(l_saldo/100,'9999999999D99')),
                                                        l_dpu.curcode));

  elsif l_stop.sh_ost = 4 then

     l_saldo := nvl(l_dpu.minsum, 0);
     
     if l_saldo = 0 then
        -- �� ���������� ����������� �������
        bars_error.raise_nerror(modcode, 'MINSUM_0');
     end if;

     --  ����� �� ����������� ������� = '...
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT6_SHOST4',
                                                        trim(to_char(l_saldo/100,'9999999999D99')),
                                                        l_dpu.curcode));
  else

     l_acrdat1 := l_dpu.datbeg;
     l_saldo   := null;

     -- ����� �� ������� �������
     iset_details (p_details, bars_msg.get_msg(modcode, 'COMMENT6_SHOSTHIST'));

  end if;

  -- -------------------------------------------------------------------------
  --                                                                        --
  --  ������ ����� �������� ��������� �� �������� ����� �� �������� ������  --
  --                                                                        --
  -- -------------------------------------------------------------------------
  acrn.p_int( l_dpu.depacc, c_addintid, l_acrdat1, l_acrdat2, p_penyaint_nom, l_saldo, 0);
  
  bars_audit.trace('%s int for term %s-%s and amount %s = %s ', c_title, 
                                                                to_char(l_acrdat1,'dd/mm/yyyy'),
                                                                to_char(l_acrdat2,'dd/mm/yyyy'), 
                                                                to_char(l_saldo),
                                                                to_char(p_penyaint_nom));

  p_penyaint_nom := round(p_penyaint_nom);
  p_penyaint_eqv := round(gl.p_icurval( l_dpu.curid, p_penyaint_nom, p_bdate ) );
  p_dptpay_nom   := greatest ((p_totalint_nom - p_penyaint_nom) - l_dpu.intsal, 0);
  p_intpay_nom   := (p_totalint_nom - p_penyaint_nom) - p_dptpay_nom;
  /*
  p_dptpay_eqv   := round(  (p_totalint_eqv - p_penyaint_eqv) 
                          / (p_totalint_nom - p_penyaint_nom) 
                          *  p_dptpay_nom);
  */
  p_dptpay_eqv   := round(gl.p_icurval( l_dpu.curid, p_dptpay_nom, p_bdate ) );
  p_intpay_eqv   := (p_totalint_eqv - p_penyaint_eqv) - p_dptpay_eqv;
  
  if ( l_dpu.tax = 1 )
  then -- ������� � ��

    p_tax_inc_ret := l_tax_income;
    p_tax_mil_ret := l_tax_military;

    p_tax_inc_pay := round(p_penyaint_nom * MAKE_INTEREST.GET_TAX_RATE(p_bdate, 1));
    p_tax_mil_pay := round(p_penyaint_nom * MAKE_INTEREST.GET_TAX_RATE(p_bdate, 2));

    -- ���� ���������� � ����������� %% ������� �� �������� � �� (��� ����������)
    iset_details( p_details, 
                  bars_msg.get_msg( modcode, 'COMMENT6_TAX_INCOME_RET', to_char(p_tax_inc_ret/100,'FM9999990D09'), l_dpu.curcode ) );

    -- ���� ���������� � ����������� %% ���������� ����� � ��   (��� ����������)
    iset_details( p_details, 
                  bars_msg.get_msg( modcode, 'COMMENT6_TAX_MILITARY_RET', to_char(p_tax_mil_ret/100,'FM9999990D09'), l_dpu.curcode ) );

  end if;
  
  -- ����� ����������� %% �� �������� ������ = ...
  iset_details( p_details, 
                bars_msg.get_msg( modcode, 'COMMENT6_PENYASUM', to_char(p_penyaint_nom/100,'FM9999999999D99'), l_dpu.curcode ) ||
                case 
                  when l_dpu.curid != c_baseval 
                  then bars_msg.get_msg( modcode, 'COMMENT2_SUMEQV', to_char(p_penyaint_eqv/100,'FM9999999999D99') )
                end );
  
  if ( l_dpu.tax = 1 )
  then
    
    -- ���� ������� �� �������� � �� (��� ������ � ���� ����������� %% �� ������� ������)
    iset_details( p_details,
                  bars_msg.get_msg( modcode, 'COMMENT6_TAX_INCOME_PAY', to_char(p_tax_inc_pay/100,'FM9999990D09'), l_dpu.curcode ) );
    
    -- ���� ���������� ����� � ��   (��� ������ � ���� ����������� %% �� ������� ������)
    iset_details( p_details,
                  bars_msg.get_msg( modcode, 'COMMENT6_TAX_MILITARY_PAY', to_char(p_tax_mil_pay/100,'FM9999990D09'), l_dpu.curcode ) );
    
  end if;

  bars_audit.trace('%s Exit with rate %s, totalint %s/%s, penyaint %s/%s'
                  , c_title                , to_char(p_penya_rate)
                  , to_char(p_totalint_nom), to_char(p_totalint_eqv)
                  , to_char(p_penyaint_nom), to_char(p_penyaint_eqv) );

  bars_audit.trace('%s Exit with intpay %s/%s, dptpay %s/%s, details %s',
                   c_title,
                   to_char(p_intpay_nom), to_char(p_intpay_eqv),
                   to_char(p_dptpay_nom), to_char(p_dptpay_eqv),
                   p_details );

  rollback to penalty;

end get_penalty_ex;

--
--
--
procedure get_penalty
( p_dpuid         in   number,
  p_bdate         in   date,  
  p_totalint_nom  out  number,
  p_totalint_eqv  out  number,
  p_penyaint_nom  out  number,
  p_penyaint_eqv  out  number,
  p_intpay_nom    out  number,
  p_intpay_eqv    out  number,
  p_dptpay_nom    out  number,
  p_dptpay_eqv    out  number,
  p_penya_rate    out  number,
  p_details       out  varchar2
) is
  l_tax_inc_ret        number(38);
  l_tax_mil_ret        number(38);
  l_tax_inc_pay        number(38);
  l_tax_mil_pay        number(38);
begin
  get_penalty_ex( p_dpuid        => p_dpuid,
                  p_bdate        => p_bdate,
                  p_totalint_nom => p_totalint_nom,
                  p_totalint_eqv => p_totalint_eqv,
                  p_penyaint_nom => p_penyaint_nom,
                  p_penyaint_eqv => p_penyaint_eqv,
                  p_intpay_nom   => p_intpay_nom,
                  p_intpay_eqv   => p_intpay_eqv,
                  p_dptpay_nom   => p_dptpay_nom,
                  p_dptpay_eqv   => p_dptpay_eqv,
                  p_penya_rate   => p_penya_rate,
                  p_tax_inc_ret  => l_tax_inc_ret,
                  p_tax_mil_ret  => l_tax_mil_ret,
                  p_tax_inc_pay  => l_tax_inc_pay,
                  p_tax_mil_pay  => l_tax_mil_pay,
                  p_details      => p_details );
end get_penalty;

--
-- p_penalty() - (��������) ��������� ������� ���������� ������ � ����� ������ 
--               ��� ��������� ����������� ����������� ��������
--
-- ���������:
--    p_dpu_id     - �������� ����������� ��������
--    p_dat        - ���� ���������� ����������� 
--    p_fact_sum   - ����� ����� ����������� %% 
--    p_penyasum   - ����� ����������� %% �� �������� ������
--    p_penya_rate - �������� ������ 
--    p_comment    - ����������� ������� ������
--
procedure p_penalty (p_dpu_id     in  number,  
                     p_dat        in  date,    
                     p_fact_sum   out number,  
                     p_penyasum   out number,  
                     p_penya_rate out number,  
                     p_comment    out varchar2)
is
  l_total_eqv   number(38);
  l_penya_eqv   number(38);
  l_intpay_nom  number(38);
  l_intpay_eqv  number(38);
  l_dptpay_nom  number(38);
  l_dptpay_eqv  number(38);
begin
  get_penalty (p_dpuid         => p_dpu_id,     
               p_bdate         => p_dat,        
               p_totalint_nom  => p_fact_sum,   
               p_totalint_eqv  => l_total_eqv,  
               p_penyaint_nom  => p_penyasum,   
               p_penyaint_eqv  => l_penya_eqv,  
               p_intpay_nom    => l_intpay_nom,
               p_intpay_eqv    => l_intpay_eqv,
               p_dptpay_nom    => l_dptpay_nom,
               p_dptpay_eqv    => l_dptpay_eqv,
               p_penya_rate    => p_penya_rate, 
               p_details       => p_comment);   
end p_penalty;

--
-- close_deal() - ��������� �������� �������� ��� ���.����������
-- 
-- ���������:
--    p_dpuid   - �������� ����������� �������� ��� ���.����������
--
procedure close_deal (p_dpuid in dpu_deal.dpu_id%type)
is
  c_title     constant varchar2(60) := 'dpu.closedeal:';
  l_bdate     constant date         := GL.BD();
  l_gennum    dpu_deal.nd%type;
  l_gendat    dpu_deal.datz%type;
  l_agrnum    dpu_deal.dpu_add%type;
  l_agrdat    dpu_deal.datz%type;
  l_closed    dpu_deal.closed%type;
  l_acc       dpu_deal.acc%type;
  l_fullname  varchar2(200);
  l_actagrcnt number(38);
begin

  bars_audit.trace('%s entry, dpuid=>%s', c_title, to_char(p_dpuid));
  
  begin
    select g.nd, g.datz, d.dpu_add, d.datz, d.closed, d.acc
      into l_gennum, l_gendat, l_agrnum, l_agrdat, l_closed, l_acc
      from dpu_deal d, 
           dpu_deal g
     where g.dpu_id = nvl(d.dpu_gen, d.dpu_id) 
       and d.dpu_id = p_dpuid 
       for update of d.closed nowait;
  exception
    when no_data_found then
      bars_error.raise_nerror(modcode, 'DPUID_NOT_FOUND', to_char(p_dpuid));
  end;
  
  if ( l_agrnum > 0 )
  then
     -- ��������������� ���������� � %s �� %s � ��������  � %s �� %s
     l_fullname := substr(bars_msg.get_msg(modcode, 'NAZN_AGRGEN_DEAL', 
                                           to_char(l_agrnum), 
                                           to_char(l_agrdat, 'dd.mm.yyyy'), 
                                           l_gennum, 
                                           to_char(l_gendat, 'dd.mm.yyyy')), 1, 200);
  else
     -- �������� � %s �� %s
     l_fullname := substr(bars_msg.get_msg(modcode, 'NAZN_STND_DEAL', 
                                           l_gennum, 
                                           to_char(l_gendat, 'dd.mm.yyyy')), 1, 200);
  end if;
  
  bars_audit.trace('%s fullname = %s', c_title, l_fullname);
  
  if (l_closed = c_closdeal)
  then
    bars_error.raise_nerror(modcode, 'CLOSDEAL_DENIED_ISCLOSED', l_fullname);
  end if;
  
  if ( l_agrnum = 0 )
  then -- ���. ���.
    
    select count(*)
      into l_actagrcnt 
      from dpu_deal 
     where dpu_gen = p_dpuid 
       and closed  = c_opendeal;
    
    if l_actagrcnt > 0 
    then
      bars_error.raise_nerror( modcode, 'CLOSDEAL_DENIED_ACTAGR', l_fullname );
    end if;
    
  else -- ���������� �� ����������� %%
    
    begin
      
      select 1
        into l_actagrcnt 
        from BARS.INT_ACCN i
       where i.ACC = l_acc
         and i.ID  = 1
         and ( (i.ACR_DAT is null) or
               (i.ACR_DAT < least(l_bdate-1, nvl(i.STP_DAT,l_bdate-1)))
             )
         and 0 < ( select sum(KOS) -- ���� ����������� �� �������
                     from BARS.SALDOA
                    where ACC = l_acc
                      and FDAT between l_agrdat
                                   and l_bdate
                 );
      
      -- ���� %% ������������� ���������� �� ���� ���������� ���������
      if ( CHECK_PENALIZATION( p_dpuid, l_agrdat ) = 0 )
      then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�� �������� #'||to_char(p_dpuid)||' ������������� �������!' );
      end if;
      
    exception
      when NO_DATA_FOUND then
        null;
    end;
    
  end if;
  
  for acc in ( select a.acc, a.nls, a.kv, a.ostc, a.ostb, a.ostf, a.dazs,
                      (select max(s.fdat)
                         from saldoa s 
                        where s.acc = a.acc
                          and s.dos + s.kos > 0) dapp
                 from dpu_accounts d
                 join accounts     a
                   on ( a.acc = d.accid )
                where d.dpuid = p_dpuid
                  and a.dazs is null )
  loop
    
    bars_audit.trace('%s account %s (acc %s)...', c_title, acc.nls, to_char(acc.acc));
    
    case
      when ( acc.ostc != 0 or acc.ostb != 0 or acc.ostf != 0 ) 
      then bars_error.raise_nerror( modcode, 'CLOSDEAL_DENIED_SALDO', l_fullname, acc.nls, to_char(acc.kv) );
      when ( acc.dapp >= l_bdate ) 
      then bars_error.raise_nerror( modcode, 'CLOSDEAL_DENIED_TURNS', l_fullname, acc.nls, to_char(acc.kv) );
      else
        update accounts 
           set dazs = l_bdate
         where acc  = acc.acc;
        bars_audit.trace('%s acc %s/%s is closed', c_title, acc.nls, to_char(acc.kv));
    end case;
    
  end loop; -- acc
  
  update dpu_deal 
     set closed = c_closdeal 
   where dpu_id = p_dpuid;
  
  if ( sql%rowcount = 1 )
  then
    bars_audit.trace('%s deal � %s is closed', c_title, to_char(p_dpuid));
  else
    bars_error.raise_nerror (modcode, 'CLOSDEAL_FAILED', l_fullname);
  end if;
   
  bars_audit.trace('%s: exit.', c_title);
  
end close_deal;

--
--
--
procedure CLOSE_DEAL
( p_dpuid          in     dpu_deal.dpu_id%type
, p_errmsg         out    sec_audit.rec_message%type
) is
begin
  begin
    CLOSE_DEAL( p_dpuid );
    p_errmsg := null;
  exception
    when OTHERS then
      p_errmsg := SubStr( sqlerrm, 12 );
      if ( Instr(p_errmsg,'DPU-0') > 0 )
      then
        p_errmsg := SubStr( p_errmsg, 11 );
      end if;
  end;
end CLOSE_DEAL;

--
-- ��������� ������ ���Ͳ�Ͳ� �������� ����������� ������ ��
--
procedure PAY_DOC_EXT
( p_dpuid   in      dpu_deal.dpu_id%type,  -- ��. ����������� ��������
  p_bdat    in      oper.datd%type,
  p_acc_A   in      accounts.acc%type,
  p_mfo_B   in      oper.mfoB%type,
  p_nls_B   in      oper.nlsB%type,
  p_nms_B   in      oper.nam_b%type,
  p_okpo_B  in      oper.id_b%type,
  p_sum     in      oper.s%type,
  p_nazn    in      oper.nazn%type,
  p_ref     in out  oper.ref%type
)
is
  l_tt              oper.tt%type;         -- 
  l_acc             accounts.acc%type;    -- 
  l_nls8            accounts.nls%type;    -- 
  l_rec_A           dpt_web.acc_rec;      -- ��������� �������� ������ �
  l_rec_A8          dpt_web.acc_rec;      -- ��������� �������� ������ � (���.����� ���.��)
  l_mfo_B           oper.mfoB%type;
  l_nls_B           oper.nlsB%type;
  l_nms_B           oper.nam_b%type;
  l_okpo_B          oper.id_b%type;
  --
  -- ���������� SWIFT �������� ���������
  --
  procedure SET_SWIFT_DETAILS
  is
    t_swift_dtls           t_swift_dtls_type;
  begin
    
    t_swift_dtls := GET_SWIFT_DETAILS( p_dpuid, l_tt, l_rec_a );
    
    if ( t_swift_dtls.count > 0 )
    then
      
      for r in t_swift_dtls.first .. t_swift_dtls.last
      loop
        
        if ( t_swift_dtls(r).TAG = 'D_REC' )
        then
          
          update OPER
             set D_REC = t_swift_dtls(r).VAL
           where REF   = p_ref;
          
        else
          
          DPU.FILL_OPERW( p_ref, t_swift_dtls(r).TAG, t_swift_dtls(r).VAL );
          
        end if;
        
      end loop;
      
      t_swift_dtls.delete();
      
    end if;
    
  end SET_SWIFT_DETAILS;
  ---
begin
  
  l_rec_A := dpt_web.search_acc_params( p_acc_A );
  
  if (SubStr(l_rec_A.ACC_NUM,4,1) = '8') 
  then -- ������� �������
    l_tt := get_tt( 4, l_rec_A.acc_cur, p_mfo_B, null );
  else -- ��������� ��������
    l_tt := get_tt( 2, l_rec_A.acc_cur, p_mfo_B, null );
  end if;
  
  if ( p_mfo_B = gl.amfo )
  then -- ���� ������� �� �������� �������
    
    select acc
      into l_acc
      from accounts 
     where nls = p_nls_B
       and kv  = l_rec_A.acc_cur;
    
    PAY_DOC_INT( p_dpuid => p_dpuid,
                 p_tt    => l_tt,
                 p_dk    => 1,
                 p_bdat  => p_bdat,
                 p_acc_A => p_acc_A,
                 p_acc_B => l_acc,
                 p_sum_A => p_sum,
                 p_nazn  => p_nazn,
                 p_ref   => p_ref );
    
  else -- ������

$if DPU_PARAMS.SBER
$then
    if ( l_rec_A.acc_cur != GL.baseval and IS_OSCHADBANK( p_mfo_B ) = 0 )
    then
      l_mfo_B  := '300465';
      l_nls_B  := '191992';
      l_nms_B  := '��� ��� ��������';
      l_okpo_B := '00032129';
    else
      l_mfo_B  := p_mfo_B;
      l_nls_B  := p_nls_B;
      l_nms_B  := p_nms_B;
      l_okpo_B := p_okpo_B;
    end if;
$end

$if DPU_PARAMS.LINE8
$then
    if (SubStr(l_rec_A.acc_num, 1, 1) = '8' )
    then
      
      select gen_acc
        into l_acc
        from V_DPU_RELATION_ACC
       where dep_acc = p_acc_A;
    
      l_rec_A8 := l_rec_A;
      l_rec_A  := dpt_web.search_acc_params( l_acc );
      
    else
      l_acc := null;
    end if;
$end
    
    begin
      gl.ref( p_ref );
      gl.in_doc3( ref_    => p_ref,                           mfoa_   => gl.amfo,
                  tt_     => l_tt,                            nlsa_   => l_rec_A.acc_num,
                  vob_    => 6,                               kv_     => l_rec_A.acc_cur,
                  dk_     => 1,                               nam_a_  => l_rec_A.acc_name,
                  nd_     => SubStr(to_char(p_ref),-10),      id_a_   => l_rec_A.cust_idcode,
                  pdat_   => sysdate,                         s_      => p_sum,
                  vdat_   => p_bdat,                          mfob_   => l_mfo_B,
                  data_   => p_bdat,                          nlsb_   => l_nls_B,
                  datp_   => p_bdat,                          kv2_    => l_rec_A.acc_cur,
                  sk_     => null,                            nam_b_  => l_nms_B,
                  d_rec_  => null,                            id_b_   => nvl( l_okpo_B, l_rec_A.cust_idcode ),
                  id_o_   => null,                            s2_     => p_sum,
                  sign_   => null,                            nazn_   => p_nazn,
                  sos_    => null,                            uid_    => null,
                  prty_   => 0 );
      
      paytt( null, p_ref, p_bdat, l_tt, 1,
                   l_rec_A.acc_cur, l_rec_A.acc_num, p_sum,
                   l_rec_A.acc_cur, l_nls_B        , p_sum );
      
      -- ����� ������ ���. �������� � �������� �������� ��������
      fill_operw( p_ref, 'ND', to_char(p_dpuid) );
      
      -- ����� ���. ��������� � ������ ������� �� ��������
      fill_dpu_payments( p_dpuid, p_ref );
      
      if ( l_rec_A.acc_cur != gl.baseval and IS_OSCHADBANK( p_mfo_B ) = 0 )
      then -- ��� ������������ � ������� ���������� SWIFT ��������
        SET_SWIFT_DETAILS;
      end if;
      
$if DPU_PARAMS.LINE8
$then
      if ( l_acc is NOT NULL ) 
      then
        
        l_tt := 'DU8';
        l_nls8 := vkrzn( SubStr(gl.amfo, 1, 5), '86000000000000' );
        
        gl.payv(0, p_ref, p_bdat, l_tt, 1,
                   l_rec_A8.acc_cur, l_rec_A8.acc_num, p_sum,
                   l_rec_A8.acc_cur, l_nls8          , p_sum );
      end if;
      
$end
    exception
      when OTHERS then
        bars_error.raise_nerror('DPT', 'PAYDOC_ERROR', sqlerrm);  
    end;
  
  end if;

end PAY_DOC_EXT;

-- 
-- DEAL_PROLONGATION() - ��������� ���������� ���������� ���� ��.���
--
PROCEDURE DEAL_PROLONGATION
( p_bdat     in  date                  default null  -- ��������� ���� (��������)
, p_dpuid    in  dpu_deal.dpu_id%type  default 0     -- dpu_id ��������, ��� 0 ��� ������������������ ��������
, p_datend   in  dpu_deal.dat_end%type default null  -- ���� ���� ���������� �������� (����� ��� p_dpuid != 0)
, p_rate     in  int_ratn.ir%type      default null  -- ���� ������ �� �������� ���� �����������
, p_reopen   in  number                default 0     -- 1 - � ������������� ������� (�������)/ 0 - ���
)
is
  type t_dpurec  is record ( dpuid      dpu_deal.dpu_id%type,
                             nd         dpu_deal.nd%type,
                             acc        dpu_deal.acc%type,
                             datz       dpu_deal.datz%type,
                             datbeg     dpu_deal.dat_begin%type,
                             datend     dpu_deal.dat_end%type,
                             datv       dpu_deal.datv%type,
                             comproc    dpu_deal.comproc%type,
                             branch     dpu_deal.branch%type,
                             cntdubl    dpu_deal.cnt_dubl%type,
                             dpugen     dpu_deal.dpu_gen%type,
                             extend     dpu_vidd.fl_extend%type,
                             r020_dep   dpu_vidd.bsd%type
                            );
  type t_dpulist is table of t_dpurec;
  l_dpulist    t_dpulist;
  
  title        constant varchar2(60) := 'dpu.deal_prolongation: ';
  l_bdat       fdat.fdat%type;
  l_mindatend  dpu_deal.dat_end%type;
  l_maxdatend  dpu_deal.dat_end%type;
  l_datend     dpu_deal.dat_end%type;
  l_accP       int_accn.acra%type;
  l_acrdat     int_accn.acr_dat%type;
  l_stpdat     int_accn.stp_dat%type;
  l_errflg     boolean := false;
  l_rate       int_ratn.ir%type;
  
  --
  -- ������������� ������� �� ����������� �������
  --
  procedure accrual_interest( p_dpurec  in  t_dpurec )  -- �������� ��������
  is
    l_amount  number(38);
  begin
    insert 
      into int_queue 
      ( deal_id, deal_num, deal_dat,
        kf, branch, cust_id, int_id, acc_id, acc_num, acc_cur, acc_nbs,
        acc_name, acc_iso, acc_open, acc_amount, int_details, int_tt, mod_code )
    select p_dpurec.dpuid, p_dpurec.nd, p_dpurec.datbeg,
           a.kf, a.branch,
           a.rnk, 1, a.acc, a.nls, a.kv, a.nbs,
           substr(a.nms, 1, 38), t.lcv, a.daos, null,  null, 'DU%', 'DPU' 
      from BARS.ACCOUNTS      a
      join BARS.TABVAL$GLOBAL t
        on ( t.KV = a.KV )
     where a.ACC = p_dpurec.acc;
    
    make_int( p_dat2      => p_dpurec.datend,  -- �������� ���� ����������� �������
              p_runmode   => 1,                -- ����� ������� (0 - �����������, 1 - ������)
              p_runid     => 0,                -- ����� ������� (��� ����������� � DPT_JOBS_LIST)
              p_intamount => l_amount,         -- ���� ����������� �������
              p_errflg    => l_errflg );       -- ���� ������� ( ����� � sec_audit )
    
    if l_errflg 
    then
      bars_error.raise_nerror( modcode, 'PAYOUT_ERR', title );
    else
      bars_audit.trace('%s ���������� ������� = %s', title, to_char(l_amount));
    end if;
    
  end accrual_interest;
  
  --
  -- ������� ����������� �������
  --
  procedure payment_interest( p_dpurec in t_dpurec )  -- �������� ��������
  is
    type t_paydocRec is record
      ( mfoa     oper.mfoa%type      ,
        nlsa     oper.nlsa%type      ,
        kva      oper.kv%type        , 
        nama     oper.nam_a%type     ,
        ida      oper.id_a%type      ,
        sa       oper.s%type         ,
        brancha  branch.branch%type  ,
        mfob     oper.mfob%type      ,
        nlsb     oper.nlsb%type      ,
        kvb      oper.kv2%type       ,
        namb     oper.nam_b%type     ,
        idb      oper.id_b%type      ,
        sb       oper.s2%type        ,
        nmk      oper.nam_a%type     ,
        tt       oper.tt%type
      ); 
    l_docrecord t_paydocRec;
    
    l_ref     oper.ref%type;
    l_errmsg  varchar2(3000);
    
  begin
    
    select a.kf, a.nls, a.kv, substr(a.nms, 1, 38), c.okpo, a.ostB,
           decode(p_dpuid, 0, p_dpurec.branch, sys_context('bars_context','user_branch')),
           null,  null, a.kv,                 null, c.okpo, a.ostB,
           substr(nvl(c.nmkk, c.nmk), 1, 38), null
      into l_docrecord 
      from accounts a, 
           customer c
     where a.acc = l_accP
       and a.rnk = c.rnk
       for update of a.ostc nowait;
    
    bars_audit.trace('%s ������� �� ������� = %s', title, to_char(l_docrecord.sa));
    
    if ( l_docrecord.sa > 0 )
    then
      
      if ( p_dpurec.comproc = 1 )
      then -- ���� ����������� %%
        
        select a.kf, a.nls, substr(a.nms, 1, 38), 'DU1'
          into l_docrecord.mfob, l_docrecord.nlsb,
               l_docrecord.namb, l_docrecord.tt
          from accounts a
         where acc = p_dpurec.acc;
        
      else -- ������� %%
        
        select mfo_p, nls_p, nms_p, okpo_p,
               decode(mfo_p, l_docrecord.mfoa, 'DU1', decode(l_docrecord.kva, 980, 'DU2', 'DU7'))
          into l_docrecord.mfob, l_docrecord.nlsb,
               l_docrecord.namb, l_docrecord.idb, l_docrecord.tt
          from dpu_deal
         where dpu_id = p_dpurec.dpuid;
        
      end if;
      
      l_ref  := null;
      
      -- ������� �������
      PAY_DOC_EXT( p_dpuid   => p_dpuid,
                   p_bdat    => l_bdat,
                   p_acc_A   => l_accP,
                   p_mfo_B   => l_docrecord.mfob,
                   p_nls_B   => l_docrecord.nlsb,
                   p_nms_B   => l_docrecord.nmk,  -- l_docrecord.namb,
                   p_okpo_B  => l_docrecord.idb,
                   p_sum     => l_docrecord.sa,
                   p_nazn    => SubStr('³������ �� �������� ����� '||F_NAZN('U', p_dpuid), 1, 160),
                   p_ref     => l_ref );
    
      bars_audit.trace( '%s acc_A = %s, mfo_B = %s, nls_B = %s, ref = %s', title, 
                        to_char(l_accP), l_docrecord.mfob, l_docrecord.nlsb, to_char(l_ref) );
      
      if (l_ref is not null) 
      then
        
        update INT_ACCN 
           set APL_DAT = l_bdat 
         where acc = p_dpurec.acc
           and id  = 1;
        
        bars_audit.financial( title||'���������� �������� �� ������ ������� (ref =  '||to_char(l_ref)||')' );
        
      end if;
      
    end if;
    
  end payment_interest;
  
  --
  -- ������� ��������� ������ (� ��������� ������� ����� ����� ������)
  --
  procedure set_rate( p_acc  in int_ratn.acc%type,
                      p_id   in int_ratn.id%type,
                      p_bdat in int_ratn.bdat%type,
                      p_ir   in int_ratn.ir%type,
                      p_br   in int_ratn.br%type,
                      p_op   in int_ratn.op%type default NULL,
                      p_del  in number           default NULL
                    )
  is
  begin  
    
    case
      when p_del > 0 then
        -- �������� �� ������ � ����� ��� ����� �� ����
        delete from int_ratn where acc = p_acc and id = p_id and bdat > p_bdat;
      when p_del < 0 then
        -- �������� �� ������ � ����� ��� ����� �� ����
        delete from int_ratn where acc = p_acc and id = p_id and bdat < p_bdat;
      when p_del = 0 then
        -- �������� �� ������
        delete from int_ratn where acc = p_acc and id   = p_id;
      else
        -- ����� �� ���������
        null;
    end case;
    
    begin
      insert into int_ratn 
        (acc, id, bdat, ir, op, br)
      values 
        (p_acc, p_id, p_bdat, p_ir,  p_op, p_br);
    exception
      when dup_val_on_index then
        update int_ratn
           set ir   = p_ir,
               op   = p_op,
               br   = p_br
         where acc  = p_acc
           and id   = p_id
           and bdat = p_bdat;
    end;
    
    bars_audit.trace ('dpu.set_rate: exit. (acc => %s).', to_char(p_acc) );
    
  exception
    when OTHERS then
       bars_audit.error('dpu.set_rate: '||sqlerrm);
  end set_rate;
  
--------------------------------------------------------------------------------
BEGIN
  
  l_bdat      := nvl( p_bdat, GL.BD() );
  l_mindatend := dat_next_u(l_bdat, -1);  -- ��������� ���������� ����
  l_maxdatend := l_bdat;                  -- �������� ��������� ����
  
  bars_audit.trace( '%s entry (bdat = %s, dptid => %s, datend =%s, rate =%s)', title, 
                    to_char(p_bdat,  'dd.mm.yyyy'), to_char(p_dpuid),
                    to_char(p_datend,'dd.mm.yyyy'), to_char(p_rate) );

  if ( p_dpuid = 0 )
  then -- ��� ��������������� ��������
    select dpu_id, nd, acc, datz, dat_begin, dat_end, datv, d.comproc, 
           branch, nvl(cnt_dubl, 0), dpu_gen, v.FL_EXTEND, v.BSD
      bulk collect
      into l_dpulist
      from dpu_deal d
      join dpu_vidd v
        on ( v.vidd = d.vidd )
     where d.dat_end between l_mindatend and l_maxdatend
       and d.closed = 0
       and v.fl_autoextend = 1;
  else -- ��� ����� ���������� ��������
    select dpu_id, nd, acc, datz, dat_begin, dat_end, datv, d.comproc, 
           branch, nvl(cnt_dubl, 0), dpu_gen, v.FL_EXTEND, v.BSD
      bulk collect
      into l_dpulist
      from dpu_deal d
      join dpu_vidd v
        on ( v.vidd = d.vidd )
     where d.dpu_id = p_dpuid
       and d.closed = 0;
    
    l_rate := p_rate;
    
  end if;
  
  for i in l_dpulist.first .. l_dpulist.last
  loop
    begin
      
      savepoint sp_extend;
      
$if DPU_PARAMS.LINE8
$then
      -- �������� �� "�����" �� ��� ��
      If ( (l_dpulist(i).dpugen is NOT Null) AND (l_dpulist(i).extend = 2) AND
           (p_datend > dpu.get_datend_line(l_dpulist(i).dpugen)) )
      Then -- ���� ���������� ������ %s �������� ���� ���������� �� %s
        bars_error.raise_nerror( modcode, 'INVALID_DATEND_TRANCHE', to_char(p_datend, 'dd/mm/yyyy'),
                                 to_char(dpu.get_datend_line(l_dpulist(i).dpugen), 'dd/mm/yyyy') );
      End If;
      
      If ( l_dpulist(i).datbeg > l_bdat )
      Then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '������ ��� �������������!' );
      End If;
$end
      l_datend := null;
      
      -- ����²��� ����ղ����Ҳ �������.%% �� �� �������
      select i.acra, i.acr_dat, i.stp_dat 
        into l_accP, l_acrdat, l_stpdat 
        from INT_ACCN i
       where i.acc = l_dpulist(i).acc
         and i.id  = 1;
    
      -- �������� ����������� ���������� %% ������
$if DPU_PARAMS.SBER
$then
      if (l_stpdat != (l_dpulist(i).datv - 1))
$else
      if (l_stpdat != (l_dpulist(i).datend - 1))
$end
      then
        
        bars_audit.info( title||' �������� stp_dat ('||to_char(l_stpdat, 'dd.mm.yyyy')||' => ' ||to_char((l_dpulist(i).datend - 1), 'dd.mm.yyyy')||')' );

$if DPU_PARAMS.SBER
$then
        l_stpdat := (l_dpulist(i).datv - 1);
$else
        l_stpdat := (l_dpulist(i).datend - 1);
$end
        
        update int_accn
           set stp_dat = l_stpdat
         where acc = l_dpulist(i).acc
           and id  = 1;
      
      end if;
      
      -- ��� ����������� ����������� %%
      if ( l_acrdat < Nvl(l_stpdat, l_bdat) )
      then
        accrual_interest( l_dpulist(i) );
      end if;

$if DPU_PARAMS.SBER
$then
      --   
      -- ���� �� ������� ��������� %% ��� �����������
      --
$else
      -- �������� ��������� %% �� ��������
      payment_interest( l_dpulist(i) );
$end
        
      -- ���� ���� ���������� ��������
      if ((p_dpuid = 0) OR (p_datend is null))
      then
        if ( extract(DAY FROM l_dpulist(i).datbeg) = extract(DAY FROM l_dpulist(i).datend) )
        then
          -- �� �-�� ������ 䳿 ��������
          l_datend := ADD_MONTHS(l_dpulist(i).datend, Months_Between(l_dpulist(i).datend, l_dpulist(i).datbeg));
        else
          -- �� �-�� ��� 䳿 ��������
          l_datend := l_dpulist(i).datend + (l_dpulist(i).datend - l_dpulist(i).datbeg);
        end if;
      else
        l_datend := p_datend;
      end if;
        
      -- 2.1 ���� ������� 䳿 ��������
$if DPU_PARAMS.SBER
$then
      /* ��� ��������� ���� ���� ������� = ���� ���������� */
      l_dpulist(i).datbeg := l_dpulist(i).datv;
$else
      l_dpulist(i).datbeg := l_dpulist(i).datend;
$end
      
      -- 2.2 ���� ��������� 䳿 ��������
      l_dpulist(i).datend := l_datend;
      
      -- 2.3 ���� ���������� ��������
      if ( (l_dpulist(i).extend = 2) AND (l_dpulist(i).dpugen Is Null ) )
      then -- ��� ���. ���� ���� ���������� = ��� ���������
        l_dpulist(i).datv := l_dpulist(i).datend;
      else
$if DPU_PARAMS.SBER
$then
        /* ��� ��������� ���� ���������� = ���� ���������� + 1 ���� */
        l_datend := (l_datend + 1);
$end
        l_dpulist(i).datv := CorrectDate( 980, l_datend, l_datend+1);
        
      end if;
      
      -- �-�� �����������
      l_dpulist(i).cntdubl := (l_dpulist(i).cntdubl + 1);
      
      update DPU_DEAL
         set DAT_BEGIN = l_dpulist(i).datbeg
           , DAT_END   = l_dpulist(i).datend
           , DATV      = l_dpulist(i).datv
           , CNT_DUBL  = l_dpulist(i).cntdubl
$if DPU_PARAMS.SBER
$then
           , SUM       = FOST(l_dpulist(i).acc, l_bdat)
$end
       where dpu_id    = l_dpulist(i).dpuid;
           
      bars_audit.trace( '%s new dates -> %s-%s (cnt_dubl = %s)', title, to_char(l_dpulist(i).datbeg, 'dd.mm.yyyy'), 
                         to_char(l_dpulist(i).datend, 'dd.mm.yyyy'), to_char(l_dpulist(i).cntdubl) );

      -- ���� ���������
      update ACCOUNTS
$if DPU_PARAMS.SBER
$then
         set mdate = l_dpulist(i).datv
$else
         set mdate = l_dpulist(i).datend
$end
       where acc   = l_dpulist(i).acc;
      
      update ACCOUNTS
$if DPU_PARAMS.SBER
$then
         set mdate = l_dpulist(i).datv
$else
         set mdate = l_dpulist(i).datend
$end
       where acc   = l_accP;
      
      -- ����-���� ����������� �������
      update INT_ACCN
$if DPU_PARAMS.SBER
$then
         set stp_dat = l_dpulist(i).datv - 1
$else
         set stp_dat = l_dpulist(i).datend - 1
$end
       where acc = l_dpulist(i).acc
         and id = 1;

      -- ������������� �������
      fill_specparams( p_depaccid   => l_dpulist(i).acc
                     , p_depacctype => l_dpulist(i).r020_dep
                     , p_intaccid   => l_accP
                     , p_intacctype => SubStr(l_dpulist(i).r020_dep,1,3)||'8'
                     , p_d020       => case when l_dpulist(i).datz < l_dpulist(i).datbeg then '02' else '01' end
                     , p_begdate    => l_dpulist(i).datbeg );
      
      if (l_rate is NOT NULL)
      then -- p_dpuid != 0
        -- ������� ���� ������ �� ��������
        bars_audit.trace( '%s new interest rate on the deposit #%s = %s%', title,
                          to_char(p_rate), to_char(p_dpuid) );
        
        SET_RATE( p_acc  => l_dpulist(i).acc,
                  p_id   => 1,
                  p_bdat => l_dpulist(i).datbeg,
                  p_ir   => l_rate,
                  p_br   => null);
      else 
        null;
      end if;
      
      bars_audit.info( bars_msg.get_msg (modcode, 'UPDEAL_PROLONG_DONE', l_dpulist(i).nd, 
                       to_char(l_dpulist(i).datz, 'dd.mm.yyyy'), to_char(l_dpulist(i).dpuid) ) );
      
    exception
      when others then
        if ( p_dpuid = 0 )
        then
          bars_audit.info( title||'������� ��� ����������� �������� � '|| l_dpulist(i).nd ||
                           '(#'||to_char(l_dpulist(i).dpuid)||') => '|| SQLERRM );
          rollback to sp_extend;
        else

$if dbms_db_version.version >= 10
$then
          bars_audit.INFO( title || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
$else
          bars_audit.INFO( title || dbms_utility.format_error_stack() );
$end
          
          bars_error.raise_nerror( modcode, 'UPDEAL_PROLONG_FAILED', to_char(p_dpuid), SQLERRM );
          
        end if;
    end;
    
  end loop;
  
  bars_audit.trace( '%s exit', title );
  
END DEAL_PROLONGATION;
  
--
-- ��������� ������ ����в�Ͳ� �������� ����������� ������ ��
-- (�� ����������� ��� ������� ������ �� 8-�� ����)
--
procedure PAY_DOC_INT
( p_dpuid  in      dpu_deal.dpu_id%type,  -- ��. ����������� ��������
  p_tt     in      oper.tt%type,
  p_dk     in      oper.dk%type,
  p_bdat   in      oper.datd%type,
  p_acc_A  in      accounts.acc%type,
  p_acc_B  in      accounts.acc%type,
  p_sum_A  in      accounts.ostc%type,    -- ���� ��� p_acc_A (������ ������)
  p_nazn   in      oper.nazn%type,
  p_ref    in out  oper.ref%type,         --
  p_tax    in      oper.s%type default 0  -- ���� ������� � ����������� %% ���������� � ���. ���. ��������
)
is
  l_tt       oper.tt%type;
  l_ref      oper.ref%type;
  l_vob      oper.vob%type;
  l_sum_A    oper.s%type;
  l_sum_B    oper.s%type;
  l_sumQ     accounts.ostc%type;   -- ���� ���������� (��� �������������� ��������)
  l_rec_A    dpt_web.acc_rec;      -- ��������� �������� ������ �
  l_rec_B    dpt_web.acc_rec;      -- ��������� �������� ������ �
$if DPU_PARAMS.LINE8
$then
  l_rec_A8   dpt_web.acc_rec;      -- ��������� �������� ������ � (���.����� ���.��)
  l_rec_B8   dpt_web.acc_rec;      -- ��������� �������� ������ � (���.����� ���.��)
  l_acccA    accounts.accc%type;   -- acc ������� ������������ ��������
  l_acccB    accounts.accc%type;   -- acc ������� ������������ ��������
  
  --
  -- �-� ������� ������������ ��� �������� �� ������������� �������� 8-�� �����
  --
  function get_nls8(p_nls  in  accounts.nls%type)
    return accounts.nls%type
  is
    l_nls8  accounts.nls%type;
  begin
    If SubStr(p_nls, 1, 2) = '70'
    then
      l_nls8 := '80210000000000';
    Else
      l_nls8 := '86000000000000';
    End if;
    
    l_nls8 := vkrzn( substr(gl.amfo, 1, 5), l_nls8 );
    
    RETURN l_nls8;
  end get_nls8;
  -- 
$end
begin
  bars_audit.trace( 'DPU.PAY_DOC_INT: start with: (%s, %s, %ss, %s, %s, %s, %s)', 
                    p_tt, to_char(p_dk), to_char(p_bdat), to_char(p_acc_A), to_char(p_acc_B), to_char(p_sum_A), p_nazn );
  
  l_tt := p_tt;
  
  -- ��. ��������
  if p_dk = 1 then
    l_rec_A := dpt_web.search_acc_params( p_acc_A );
    l_rec_B := dpt_web.search_acc_params( p_acc_B );
    l_sum_A := p_sum_A;
    l_sum_B := round(gl.p_icurval(l_rec_A.acc_cur, p_sum_A, p_bdat));
$if DPU_PARAMS.LINE8
$then
    l_acccA := p_acc_A;
    l_acccB := p_acc_B;
$end
  
  -- ��. ��������
  elsif p_dk = 0 then
    l_rec_A := dpt_web.search_acc_params( p_acc_B );
    l_rec_B := dpt_web.search_acc_params( p_acc_A );
    l_sum_A := round(gl.p_icurval(l_rec_B.acc_cur, p_sum_A, p_bdat));
    l_sum_B := p_sum_A;
$if DPU_PARAMS.LINE8
$then
    l_acccA := p_acc_B;
    l_acccB := p_acc_A;
$end
  -- ������������ �� ������������
  else
    null;
    -- raise;
  end if;
  
  bars_audit.trace( 'DPU.PAY_DOC_INT: nls_A = %s, kv_A = %s, sum_A = %s, nls_B = %s, kv_B = %s, sum_B = %s',
                    to_char(l_rec_A.acc_num), to_char(l_rec_A.acc_cur), to_char(l_sum_A),
                    to_char(l_rec_B.acc_num), to_char(l_rec_B.acc_cur), to_char(l_sum_B) );
$if DPU_PARAMS.LINE8
$then
  
  -- ���� ������� � - ���.���.�����
  if SubStr(l_rec_A.acc_num, 1, 1) = '8'
  then
    
    select gen_acc
      into l_acccA
      from V_DPU_RELATION_ACC
     where dep_acc = l_acccA;
    
    l_rec_A8 := l_rec_A;
    l_rec_A  := dpt_web.search_acc_params( l_acccA );
    
  else
    l_acccA  := null;
  end if;
  
  -- ���� ������� � - ���.���.�����
  if SubStr(l_rec_B.acc_num, 1, 1) = '8'
  then
    
    select gen_acc
      into l_acccB
      from V_DPU_RELATION_ACC
     where dep_acc = l_acccB;
    
    l_rec_B8 := l_rec_B;
    l_rec_B  := dpt_web.search_acc_params( l_acccB );
    
  else
    l_acccB  := null;
  end if;
  
  bars_audit.trace( 'DPU.PAY_DOC_INT: acccA = %s, acccB = %s',
                    nvl(to_char(l_acccA),'null'), nvl(to_char(l_acccB),'null') );
  
  -- ���� ����� � ����� ������ ������� ���.�������� �� ����. ���� ����� �� ���. 8-�� �����
  if l_acccA = l_acccB
  then
    l_tt    := 'DU8';
    l_rec_A := l_rec_A8;
    l_rec_B := l_rec_B8;
  end if;
$end
  
  -- ���� �������������
  if ( l_rec_A.acc_cur != l_rec_B.acc_cur )
  then
    l_vob  := 16;
  else  
    l_vob  :=  6;
  end if;
  
  begin
    gl.ref(l_ref);
    gl.in_doc3 (ref_    => l_ref,                           mfoa_   => gl.amfo,
                tt_     => l_tt,                            nlsa_   => l_rec_A.acc_num,
                vob_    => l_vob,                           kv_     => l_rec_A.acc_cur,
                dk_     => 1,                               nam_a_  => l_rec_A.acc_name,
                nd_     => SubStr(to_char(l_ref),1,10),     id_a_   => l_rec_A.cust_idcode,
                pdat_   => sysdate,                         s_      => l_sum_A,
                vdat_   => p_bdat,                          mfob_   => gl.amfo,
                data_   => p_bdat,                          nlsb_   => l_rec_B.acc_num,
                datp_   => p_bdat,                          kv2_    => l_rec_B.acc_cur,
                sk_     => null,                            nam_b_  => l_rec_B.acc_name,
                d_rec_  => null,                            id_b_   => l_rec_B.cust_idcode,
                id_o_   => null,                            s2_     => l_sum_B,
                sign_   => null,                            nazn_   => p_nazn,
                sos_    => null,                            uid_    => null,
                prty_   => 0 );
    
    gl.payv( null, l_ref, p_bdat, l_tt, 1,
             l_rec_A.acc_cur, l_rec_A.acc_num, l_sum_A,
             l_rec_B.acc_cur, l_rec_B.acc_num, l_sum_B );
    
    -- ����� ������ ���. �������� � �������� �������� ��������
    fill_operw( l_ref, 'ND', to_char(p_dpuid) );
    
    -- ����� ���. ��������� � ������ ������� �� ��������
    fill_dpu_payments( p_dpuid, l_ref );
    
$if DPU_PARAMS.LINE8
$then
    if ((l_acccA is NOT NULL) OR (l_acccB is NOT NULL)) AND (nvl(l_acccA,0) != nvl(l_acccB,0)) 
    then
      
      if (l_acccA is NOT NULL) 
      then
        l_rec_B8.acc_cur := l_rec_A.acc_cur;
        l_rec_B8.acc_num := get_nls8(l_rec_B.acc_num);
      end if;
      
      if (l_acccB is NOT NULL) 
      then
        l_rec_A8.acc_cur := l_rec_B.acc_cur;
        l_rec_A8.acc_num := get_nls8(l_rec_A.acc_num);
      end if;
      
      bars_audit.trace( 'DPU.PAY_DOC_INT: kvA = %s, nlsA = %s, sum = %s, kvB = %s, nlsB = %s', 
                        to_char(l_rec_A8.acc_cur), to_char(l_rec_A8.acc_num), to_char(l_sum_A),
                        to_char(l_rec_B8.acc_cur), to_char(l_rec_B8.acc_num) );
      l_tt := 'DU8';
      
      If ( p_tt = 'DU%' AND p_tax > 0 )
      Then -- ��� �������� �� 
        l_sum_A := (p_sum_A - p_tax);
      Else
        l_sum_A := p_sum_A;
      End If;
      
      -- ����������� �������� �� ���������� ( � ��� �� ����� ����������� ������� )
      gl.payv( null, l_ref, p_bdat, l_tt, 1,
               l_rec_A8.acc_cur, l_rec_A8.acc_num, l_sum_A,
               l_rec_B8.acc_cur, l_rec_B8.acc_num, l_sum_A );
      
    end if;
$end
    
    -- ��'���� ��������� �� ���������
    if ( p_ref is NOT NULL ) 
    then
      update OPER
         set refl = l_ref
       where ref  = p_ref;
    end if;
    
    -- �������� ��������
    p_ref := l_ref;
    
  exception
    when OTHERS then
      bars_audit.error( 'DPU.PAY_DOC_INT: error => ' || dbms_utility.format_error_stack() ||chr(10)|| dbms_utility.format_error_backtrace() );
      bars_error.raise_nerror( 'DPT', 'PAYDOC_ERROR', sqlerrm );
  end;
  
end PAY_DOC_INT;


---
-- �������� ������� �� ����������� ��������
---
procedure PARTIAL_PAYMENT
( p_dpuid    in   dpu_deal.dpu_id%type,  -- �����. ����������� ��������
  p_amount   in   accounts.ostc%type,    -- ����� ���������� ������ (� ����� ��������)
  p_option   in   number,                -- ������ ����������� ������� ( 0 - ��� �������� ������� / 1 - / 2 - �� ������� ������ �������� )
  p_outmsg   out  varchar2               -- ������� ����������� ��� ������� ��� Null
) is
  type t_rec4payments is record ( acc_dep      dpu_deal.acc%type
                                , dat_beg      dpu_deal.dat_begin%type
                                , dat_end      dpu_deal.dat_end%type
                                , mfo_d        dpu_deal.mfo_d%type
                                , nls_d        dpu_deal.nls_d%type
                                , nms_d        dpu_deal.nms_d%type
                                , branch       dpu_deal.branch%type
                                , min_amnt     dpu_deal.min_sum%type
                                , min_summ     dpu_vidd.min_summ%type
                                , irrevocable  dpu_vidd.irvk%type
                                , nls_dep      accounts.nls%type
                                , ost_dep      accounts.ostc%type
                                , kv           accounts.kv%type
                                , nls_depG     accounts.nls%type
                                , nls_int      accounts.nls%type
                                , ost_int      accounts.ostc%type
                                , acr_dat      int_accn.acr_dat%type
                                , nls_intG     accounts.nls%type
                                , nls_exp      accounts.nls%type
                                , nms_exp      accounts.nms%type
                                , OKPO         customer.okpo%type
                                , nmk          customer.nmk%type
                                , tax_rqd_f    number(1) -- ����������� ��������� ������� � ����������� %%
                                );
  l_rec4pay  t_rec4payments;
  
  title      constant varchar2(30) := 'DPU.PARTIAL_PAYMENT: ';
  l_bdat     date;
  l_tt       oper.tt%type;
  l_dk       oper.dk%type;
  l_vob      oper.vob%type;
  l_ref      oper.ref%type;
  l_mfo      oper.mfoa%type;
  l_sum2ret  number(24);      -- ���� �������� �� �������
  l_int2ret  number;          -- ���� %% ��� �������� � ��� ��������
  l_penalty  number;          -- ���� ������
  l_sumQ     number;          -- ���� ���������� (��� �������������� ��������)                              
  -- l_errmsg   varchar2(3000);
  
  --
  -- INTERNAL PROCEDURES
  --
  procedure shtraf_amount
  is
    l_altintid   int_ratn.id%type := 5;
    l_penyarate  int_ratn.ir%type;
  begin
    -- �������� ������� ������ ������� � ��������� ������
    l_penyarate := dpt.f_shtraf_rate( p_dpuid, l_bdat, modcode );
    
    if ((l_penyarate is not null) OR (l_penyarate > 0)) then
      -- ��������� �������������� �������� ��������� �� �������� ��������
      -- ������ ���� ����������� ���������� � ����-���� ��� ���������� 
      begin
        insert into int_accn
              (acc,         id,           acr_dat,           stp_dat, metr, basey, freq, io, acra, acrb, tt)
        select acc, l_altintid, l_rec4pay.dat_beg, l_rec4pay.acr_dat, metr, basey,    1, io, acra, acrb, tt
          from int_accn
         where acc = l_rec4pay.acc_dep 
           and id  = 1;
      exception
        when dup_val_on_index then
          update INT_ACCN 
             set acr_dat = l_rec4pay.dat_beg, 
                 stp_dat = l_rec4pay.acr_dat
           where acc = l_rec4pay.acc_dep
             and id  = l_altintid;  
      end;
      
      -- ��������� �������� ������
      begin
        insert into int_ratn
          (acc, id, bdat, ir)
        values
          (l_rec4pay.acc_dep, l_altintid, l_rec4pay.dat_beg, l_penyarate);
      exception
        when DUP_VAL_ON_INDEX then
          null;
      end;
      
      acrN.p_int( acc_ => l_rec4pay.acc_dep, -- Account number
                   id_ => l_altintid,        -- Calc code
                  dt1_ => l_rec4pay.dat_beg, -- From date
                  dt2_ => l_rec4pay.acr_dat, -- To   date
                  int_ => l_penalty,         -- ���� ����������� �������
                  ost_ => l_sum2ret,         -- ���� ��� �����. (���� null �� �� �������)
                 mode_ => 0 );               -- Mode Play(0)/Real(1)
      
      delete from INT_RATN
       where acc = l_rec4pay.acc_dep and id = l_altintid;
      
    else
      l_penalty := 0;
    end if;
    
    p_outmsg := p_outmsg || c_endline ||' ������� ������ = '||to_char( l_penyarate, 'FM990D00' ) || ' %';
    
  end shtraf_amount;
  
/* ========================================================================== */
BEGIN
  
  l_bdat := GL.BD();
  l_mfo  := GL.KF();
  l_dk   := 1;
  
  bars_audit.info( title||'start with dpuid = '||to_char(p_dpuid)||', amount = '||', option = '||to_char(p_option)||
                   to_char(p_amount)||', bdat = '||to_char(l_bdat,'dd/mm/yyyy') );
  
  If p_option NOT IN ( 0, 1, 2 )
  then
    bars_error.raise_nerror( modcode, 'INVALID_PARTIAL_PAYMENT_OPTION', to_char(p_option) );
  End if;
  
  select d.ACC, d.DAT_BEGIN, d.DAT_END, d.mfo_d, d.nls_d, nms_d, d.branch, d.MIN_SUM, 
         v.MIN_SUMM,
         case when ( v.IRVK = 1 and d.ID_STOP = �_IRVC_STPID ) then 1 else 0 end,
         ad.nls, FOST( ad.acc, GL.BD() ), ad.kv,
         (select nls from accounts where acc = ad.accc),
         ai.nls, FOST( ai.acc, GL.BD() ), i.acr_dat,
         (select nls from accounts where acc = ai.accc),
         a7.nls, a7.nms
       , c.OKPO, nvl(c.NMKK, c.NMK)
       , case
           when ( c.SED = '91' and c.ISE in ('14200','14201','14100','14101') )
           then 1
           else 0
         end
    into l_rec4pay
    from BARS.DPU_DEAL d
    join BARS.ACCOUNTS ad
      on ( ad.ACC = d.ACC )
    join BARS.CUSTOMER c
      on ( c.RNK = d.RNK )
    join BARS.INT_ACCN i
      on ( i.ACC = d.ACC and i.ID = 1 )
    join BARS.ACCOUNTS ai
      on ( ai.ACC = i.ACRA )
    join BARS.ACCOUNTS a7
      on ( a7.ACC = i.ACRB )
    join BARS.DPU_VIDD v
      on ( v.VIDD = d.VIDD )
   where d.DPU_ID = p_dpuid;
  
  -- l_sum2ret := (p_amount * 100);
  l_sum2ret := p_amount;
  
  if ( l_rec4pay.ost_dep = 0 )
  then
    bars_error.raise_nerror( 'DPT', 'PENALTY_DENIED', to_char(p_dpuid), '������� �� ����������� ������� ����� ����!' );
  elsif ( l_sum2ret >= l_rec4pay.ost_dep )
  then
    bars_error.raise_nerror( 'DPT', 'PENALTY_DENIED', to_char(p_dpuid), '���� ������� ����� �� ������� �� ����������� �������!' );
  elsif ( (l_rec4pay.ost_dep - l_sum2ret) < l_rec4pay.min_amnt )
  then
    bars_error.raise_nerror( 'DPT', 'PENALTY_DENIED', to_char(p_dpuid), '������� ���� ������� ����� ��. ����������� (����� ��������)!' );
  elsif ( (l_rec4pay.ost_dep - l_sum2ret) < l_rec4pay.min_summ )
  then
    bars_error.raise_nerror( 'DPT', 'PENALTY_DENIED', to_char(p_dpuid), '������� ���� ������� ����� ��. ����������� (����� ��������)!' );
  elsif ( l_rec4pay.IRREVOCABLE = 1 and l_rec4pay.DAT_END <= l_bdat )
  then -- ��� ������������ ��������� �̲������ ���� ���� ���� ���������� ��������
    bars_error.raise_nerror( 'DPT', 'PENALTY_DENIED', to_char(p_dpuid), '���������� �������� ��������� ����� ��� ������������ ��������!' );
  else
    
    bars_context.subst_branch( l_rec4pay.branch );
    
    -- �������� ������� � ����������� ����������� �� ���� ������ �������
    If ( p_option > 0 )
    Then
      
      bars_audit.info( title||'deal params: acc_dep = '||to_char(l_rec4pay.acc_dep)||
                       ', dat_beg = '||to_char(l_rec4pay.dat_beg,'dd/mm/yyyy')||
                       ', acr_dat = '||to_char(l_rec4pay.acr_dat,'dd/mm/yyyy')||
                       ', ost_dep = '||to_char(l_rec4pay.ost_dep)||', ost_int = '||to_char(l_rec4pay.ost_int) );
      
      p_outmsg := '�������� ������� � ����������� ����������� �������:';
      
      -- ���������� ���� %% �� ��������� ����� �� ���� ������ 
      if ( p_option = 1 )
      then
        
        p_outmsg := p_outmsg || c_endline || ' �� ����� ������ ��������';
        
        acrN.p_int( acc_ => l_rec4pay.acc_dep, -- Account number
                     id_ => 1,                 -- Calc code
                    dt1_ => l_rec4pay.dat_beg, -- From date
                    dt2_ => l_rec4pay.acr_dat, -- To   date
                    int_ => l_penalty,         -- ���� ����������� �������
                    ost_ => l_sum2ret,         -- ���� ��� �����. (���� null �� �� �������)
                   mode_ => 0 );               -- Mode Play(0)/Real(1)
        
        
      else -- p_option = 2
        
        p_outmsg := p_outmsg || c_endline || ' �� ������� ������ ��������';
        
        SHTRAF_AMOUNT;
        
      end if;
      
      bars_audit.trace( title||'penalty = '||to_char(l_penalty)||', sum2ret = '||to_char(l_sum2ret) );
      
      l_penalty := round(l_penalty);
      
      p_outmsg := p_outmsg || c_endline ||' ���� ������ = '||to_char( l_penalty/100, 'FM999G999G990D00' );
      
      PENALTY_PAYMENT( p_dpuid       => p_dpuid,    -- ��. ����������� ��������
                       p_penalty     => l_penalty,  -- ���� ������ � �������
                       p_int_pay     => 0,          -- ���� ������� ����������� �� ������� ������
                       p_tax_inc_ret => case        -- ���� ������������ ������� �� ����������
                                          when ( l_rec4pay.tax_rqd_f = 1 )
                                          then round(l_penalty * MAKE_INTEREST.GET_TAX_RATE(l_bdat, 1))
                                          else 0
                                        end,
                       p_tax_mil_ret => case        -- ���� ���������� ������� �� ����������
                                          when ( l_rec4pay.tax_rqd_f = 1 )
                                          then round(l_penalty * MAKE_INTEREST.GET_TAX_RATE(l_bdat, 2))
                                          else 0
                                        end
                     );
      
    Else    /* p_option = 0 */
      bars_audit.info( title||'�������� ������� ��� ����������� ������� �� ��������!' );
    End if; /* p_option > 0 */
    
    -- ������� ��������
    PAY_DOC_EXT( p_dpuid   => p_dpuid,
                 p_bdat    => l_bdat,
                 p_acc_A   => l_rec4pay.acc_dep,
                 p_mfo_B   => l_rec4pay.mfo_d,
                 p_nls_B   => l_rec4pay.nls_d,
                 p_nms_B   => SubStr(l_rec4pay.nms_d, 1, 38),
                 p_okpo_B  => null,
                 p_sum     => l_sum2ret,
                 p_nazn    => SubStr('�������� ���������� �������� ����� '||F_NAZN('U', p_dpuid), 1, 160),
                 p_ref     => l_ref );
      
    bars_audit.trace( '%s tt = %s, ref = %s', title, l_tt, to_char(l_ref) );
    
  end if;
  
  bars_context.set_context;
  
exception
  when OTHERS then
    bars_context.set_context;
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
end PARTIAL_PAYMENT;


--
-- ��������� ����������� ����������� ������� 
-- ��� ��� %% ������ �� �������� ����� ������
--
procedure INTEREST_RECALCULATION ( p_dpuid   in  dpu_deal.dpu_id%type,
                                   p_outmsg  out varchar2 )
is
  title    constant varchar2(30) := 'DPU.INTEREST_RECALCULATION: ';
  l_bdat     date;
  l_acc      dpu_deal.acc%type;
  l_datbeg   dpu_deal.dat_begin%type;
  l_dateu    dpu_deal_update.dateu%type;  -- ���� ����������� ��������
  l_acrdat   int_accn.acr_dat%type;       -- ���� �� ��� ���������� %%
  l_acra     int_accn.acra%type;
  l_acrb     int_accn.acrb%type;
  l_sumdoc   oper.s%type;                 -- �������� ���� ��� �������� �����.%% �� �������
  l_sumint   oper.s%type;                 -- ���� �����.%% �� �������� � dat_begin �� acr_dat
  l_sum      oper.s%type;                 -- 
  l_tt       oper.tt%type;
  l_dk       oper.dk%type;
  l_vob      oper.vob%type;
  l_ref      oper.ref%type;
  l_nazn     oper.nazn%type;
  l_branch   branch.branch%type;
begin
  l_bdat := GL.BD();
  l_ref  := null;
   
  -- ����� ��������� ��������
  begin
    select   acc, dat_begin,  branch,   dateu
      into l_acc, l_datbeg, l_branch, l_dateu
      from DPU_DEAL_UPDATE
     where idu = (select min(idu)
                    from DPU_DEAL_UPDATE u, DPU_DEAL d 
                   where d.dpu_id    = p_dpuid
                     and d.dpu_id    = u.dpu_id
                     and d.dat_begin = u.dat_begin
                 );
  exception
    when NO_DATA_FOUND then
      bars_error.raise_nerror(modcode, 'DPUID_NOT_FOUND', to_char(p_dpuid));
  end;
  
  -- ����� ��������� %% ������
  begin
    select i.acr_dat, i.acra, i.acrb
      into  l_acrdat, l_acra, l_acrb
      from INT_ACCN i,
           ACCOUNTS a
     where i.acc = l_acc
       and i.id = 1
       and i.acra = a.acc;
    
  exception
    When NO_DATA_FOUND then
      bars_error.raise_nerror (modcode, 'UPDEAL_INTACC_NOT_FOUND', to_char(p_dpuid));
  end;   
  
  if l_acrdat > l_datbeg then
  -- �� �������� ���� �������� �����.%%
    
    -- ��������� ���� ��� �������� ����������� (�������� ����������������) %% �� ����������� ��������
    select sum(decode(p.dk,0,-1,1) * p.s)
      into l_sumdoc
      from opldok p, oper o
     where p.acc = l_acra
       and p.fdat >= l_datbeg
       and p.sos = 5
       and p.ref = o.ref
       and o.pdat > l_dateu
       and o.tt in ('DU%', 'DU$');
    
    bars_audit.info( title || '���� ��������� �� ����������� ������� = ' || to_char(l_sumdoc) );
    
    If l_sumdoc is null Then
      raise_application_error(-20000, '�� �������� ����� �������� ����������� %% �� ������ ��������!');
    End if;
    
    -- ����������� ������� �� ������� � dat_begin �� acr_dat
    acrN.p_int( acc_ => l_acc,      -- Account number
                 id_ => 1,          -- Calc code
                dt1_ => l_datbeg,   -- From date
                dt2_ => l_acrdat,   -- To   date
                int_ => l_sumint,   -- ���� ����������� �������
                ost_ => null,       -- ���� ��� �����. (���� null �� �� �������)
               mode_ => 0 );        -- Mode Play(0)/Real(1)
    
    bars_audit.info( title || '���� ����������� ������� = ' || to_char(l_sumint) );
    
    -- ���� �������� (������ �� l_sumint �� l_sumdoc)
    l_sum := l_sumint - l_sumdoc;
    
    if l_sum = 0 then
      p_outmsg := '����� ���������� ������ �� ������� ����������� ���� ����������� �������!';
    else
      p_outmsg := '�������� �������� �� ����: ' || to_char( l_sumdoc/100 ) || c_endline ||
                  '���������� �������:       ' || to_char( l_sumint/100 ) || c_endline ||
                  ' (�� ����� � ' || to_char(l_datbeg, 'dd/mm/yyyy')       ||
                  ' �� '           || to_char(l_acrdat, 'dd/mm/yyyy') ||')' || c_endline ||
                  'г����� � ��� �����.%% =   ' || to_char( l_sum/100 );
      
      if l_sum > 0 then
        l_tt   := 'DU%';
        l_dk   := 0;
        l_nazn := SubStr('������������ ������� �� �������� ����� '||F_NAZN('U', p_dpuid), 1 ,160);
      else -- l_sum < 0
        l_sum  := ABS(l_sum);
        l_tt   := 'DU$';
        l_dk   := 1;
        l_nazn := SubStr('�������� ���������������� ������� ����� '||F_NAZN('U', p_dpuid), 1, 160);
      end if;
      
      bars_context.subst_branch( l_branch );
      
      PAY_DOC_INT( p_dpuid => p_dpuid,
                   p_tt    => l_tt,
                   p_dk    => l_dk,
                   p_bdat  => l_bdat,
                   p_acc_A => l_acra,
                   p_acc_B => l_acrb,
                   p_sum_A => l_sum,
                   p_nazn  => l_nazn,
                   p_ref   => l_ref );
      
      p_outmsg := p_outmsg || c_endline || '�������� ��������� = ' || to_char( l_ref );
      
    end if;
  else
    p_outmsg := '�� ������ �������� �� �� ������������ �������� ����������� �������!';
  end if;
  
  bars_context.set_context;
  
exception
  when OTHERS then
    bars_context.set_context;
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
end INTEREST_RECALCULATION;


--
-- ��������� ������ ��� ������������ �������� ��������
--
procedure PENALTY_PAYMENT
( p_dpuid        in   dpu_deal.dpu_id%type,          -- ��. ����������� ��������
  p_penalty      in   accounts.ostc%type,            -- ���� ������ � �������
  p_int_pay      in   accounts.ostc%type,            -- ���� ������� ����������� �� ������� ������
  p_tax_inc_ret  in   accounts.ostc%type default 0,  -- ���� ���������� ���������� ������� �� �������� � ��
  p_tax_mil_ret  in   accounts.ostc%type default 0,  -- ���� ���������� ���������� ���������� �����   � ��
  p_tax_inc_pay  in   accounts.ostc%type default 0,  -- ���� ��������� ������� �� �������� � ��
  p_tax_mil_pay  in   accounts.ostc%type default 0   -- ���� ��������� ���������� �����   � ��
) is
  title               constant varchar2(30) := 'DPU.PENALTY_PAYMENT: ';
  l_bdat              date;
  l_ref               oper.ref%type;
  l_dep2ret           accounts.ostc%type;   -- ���� ������ ��� ���� ������� � ����������� �������
  l_int2ret           accounts.ostc%type;   -- ���� ������ ��� ���� ������� � ����������� �������
  l_acc               accounts.acc%type;
  l_acc_tax_ret       accounts.acc%type;    -- ��. ������� ���������� ���������� �������
  l_acc6              int_accn.acrb%type;
  l_acra              int_accn.acra%type;
  l_acrb              int_accn.acrb%type;
  l_acrdat            int_accn.acr_dat%type;
  l_branch            branch.branch%type;
  l_vidd              dpu_vidd.vidd%type;
$if MAKE_INTEREST.G_USE_TAX_INC OR MAKE_INTEREST.G_USE_TAX_MIL
$then
  ---
  l_tax_nls_pay       accounts.nls%type;
  l_tax_amt_eq        oper.s2%type;
  l_int_nls           accounts.nls%type;
  l_int_cur           accounts.kv%type;
$end
BEGIN
  
  bars_audit.trace( '%s start with: dpuid = %s, penalty = %s, int_pay = %s.', title, 
                    to_char(p_dpuid), to_char(p_penalty), to_char(p_int_pay) );
                    
  bars_audit.trace( '%s start with: tax_inc_ret=%s, tax_mil_ret=%s, tax_inc_pay=%s, tax_mil_pay=%s.', title, 
                    to_char(p_tax_inc_ret), to_char(p_tax_mil_ret), to_char(p_tax_inc_pay), to_char(p_tax_mil_pay) );
  
  -- l_bdat := gl.bd();
  l_bdat := GL.GBD();
  
  If ( p_penalty > 0 )
  Then
    
    select d.acc,  d.branch, d.vidd, 
$if MAKE_INTEREST.G_USE_TAX_INC OR MAKE_INTEREST.G_USE_TAX_MIL
$then
           a.nls,  a.kv,
$end
           i.acra, i.acrb,   i.acr_dat
      into l_acc,     l_branch, l_vidd,
$if MAKE_INTEREST.G_USE_TAX_INC OR MAKE_INTEREST.G_USE_TAX_MIL
$then
           l_int_nls, l_int_cur,
$end
           l_acra,    l_acrb,   l_acrdat
      from DPU_DEAL d
      join INT_ACCN i on ( i.acc = d.acc )
$if MAKE_INTEREST.G_USE_TAX_INC OR MAKE_INTEREST.G_USE_TAX_MIL
$then
      join ACCOUNTS a on ( a.acc = i.acra )
$end
     where d.DPU_ID = p_dpuid
       and i.ID     = 1;
    
    -- ����� ������� ��������� ������ 
    begin
      select acc
        into l_acc6
        from BARS.ACCOUNTS
       where (kf, nls, kv) in ( select kf, g67n, 980
                                  from BARS.PROC_DR$BASE r
                                  join BARS.DPU_VIDD     v
                                    on ( v.BSD = r.NBS and v.VIDD = r.REZID )
                                 where v.VIDD   = l_vidd 
                                   and r.BRANCH = l_branch
                                   and r.sour   = 4 )
         and dazs is null;
    exception
      when NO_DATA_FOUND then
        select min(a.acc)
          into l_acc6
          from accounts      a, 
               dpu_vidd_ob22 v
         where v.vidd   = l_vidd
           and a.nbs    = v.nbs_red
           and a.ob22   = v.ob22_red
$if DPU_PARAMS.SBER
$then
           and a.branch = SubStr(l_branch, 1, 15)
$else
           and a.branch = l_branch
$end
           and a.dazs is null;

        if (l_acc6 is Null) 
        then
          bars_error.raise_nerror( modcode, 'EXPENSACC_NOT_FOUND', to_char(l_vidd), l_branch, sqlerrm );
        end if;
    end; 
    
    -- ������� �� ���.%% �� ��������� ���� ����������� + ���� ����������� ������� 
    l_int2ret := fost(l_acra, l_bdat) + p_tax_inc_ret + p_tax_mil_ret;
    
    bars_context.subst_branch( l_branch );
    
    -- ���� ���� ������ ����� �� ������� �� ���.���.%%
    if ( p_penalty > l_int2ret )
    then
      l_dep2ret := (p_penalty - l_int2ret);
    else
      l_int2ret := p_penalty;
      l_dep2ret := 0;
    end if;
    
    -- ������ ���� ������ � ����������� �������
    l_ref := null;
    
    PAY_DOC_INT( p_dpuid => p_dpuid,
                 p_tt    => 'DUS',
                 p_dk    => 1,
                 p_bdat  => l_bdat,
                 p_acc_A => l_acra,
                 p_acc_B => l_acc6,
                 p_sum_A => l_int2ret,
                 p_nazn  => SubStr(bars_msg.get_msg(modcode, 'DOCDTL_TYPE5P', dpu.f_nazn('A', p_dpuid)), 1, 160),
                 p_ref   => l_ref );
    
    bars_audit.trace( '%s tt = DUS, ref = %s', title, to_char(l_ref) );
    
    if ( l_dep2ret > 0 )
    then -- ��������� ������ � ��� ��������
      
      l_ref := null;
      
      PAY_DOC_INT( p_dpuid => p_dpuid,
                   p_tt    => 'DUT',
                   p_dk    => 1,
                   p_bdat  => l_bdat,
                   p_acc_A => l_acc,
                   p_acc_B => l_acc6,
                   p_sum_A => l_dep2ret,
                   p_nazn  => SubStr('���������� ����������� %% ����� '||F_NAZN('U', p_dpuid), 1, 160),
                   p_ref   => l_ref );
      
      bars_audit.trace( '%s tt = DUT, ref = %s', title, to_char(l_ref) );
      
    end if;
    
$if MAKE_INTEREST.G_USE_TAX_INC
$then
    if ( p_tax_inc_ret > 0)
    then -- ���������� ���������� � ����������� %% ������� �� �������� � ��
      
      begin
        -- ����� ������� ��� ���������� ���������� ������� �� �������� � ��
        select ACC
          into l_acc_tax_ret
          from BARS.ACCOUNTS
$if DPU_PARAMS.SBER
$then
         where nls = nbs_ob22_null('3522', '29', l_branch)
$else
         where nls = GetGlobalOption('TAX_3522')
$end
           and kv  = gl.baseval
           and dazs is Null;
      exception
        when OTHERS then 
          l_acc_tax_ret := null;
          bars_error.raise_nerror( modcode, 'RET_INCOME_TAX_ACC_NOT_FOUND' );
      end;
      
      bars_audit.trace( '%s ������� ��� ���������� ���������� ������� �� �������� � �� = %s', title, to_char(l_acc_tax_ret) );
            
      l_ref := null;
      
      PAY_DOC_INT( p_dpuid => p_dpuid,
                   p_tt    => '%15',
                   p_dk    => 1,
                   p_bdat  => l_bdat,
                   p_acc_A => l_acc_tax_ret,
                   p_acc_B => l_acra,
                   p_sum_A => p_tax_inc_ret,
                   p_nazn  => SubStr('���������� ������� �� �������� � �� ��� ������������ �������� '||F_NAZN('U', p_dpuid), 1, 160),
                   p_ref   => l_ref );
      
      bars_audit.trace( '%s tt = %15, ref = %s', title, to_char(l_ref) );
      
    end if;
$end
    
    if ( p_tax_mil_ret > 0)
    then -- ���������� ���������� � ����������� %% ���������� ����� � ��
      
      begin
        -- ����� ������� ��� ���������� ���������� ���������� ����� � ��
        select a.acc 
          into l_acc_tax_ret
          from accounts a
         where a.nls = nbs_ob22_null('3522', '30', l_branch)
           and a.kv  = gl.baseval
           and a.dazs is Null;
      exception
        when OTHERS then 
          l_acc_tax_ret := null;
      end;
      
      bars_audit.trace('%s ������� ��� ���������� ���������� ���������� ����� � �� = %s', title, to_char(l_acc_tax_ret) );
      
      l_ref := null;
      
      PAY_DOC_INT( p_dpuid => p_dpuid,
                   p_tt    => 'MIL',
                   p_dk    => 1,
                   p_bdat  => l_bdat,
                   p_acc_A => l_acc_tax_ret,
                   p_acc_B => l_acra,
                   p_sum_A => p_tax_mil_ret,
                   p_nazn  => SubStr('���������� ���������� ����� � �� ��� ������������ �������� '||F_NAZN('U', p_dpuid), 1, 160),
                   p_ref   => l_ref );
      
      bars_audit.trace( '%s tt = MIL, ref = %s', title, to_char(l_ref) );
      
    end if;
    
    if ( p_int_pay > 0 )
    then -- ������� ������� ����������� �� ������� ������
      
      l_ref  := null;
      
      PAY_DOC_INT( p_dpuid  => p_dpuid,
                   p_tt     => 'DU%',
                   p_dk     => 0,
                   p_bdat   => l_bdat,
                   p_acc_A  => l_acra,
                   p_acc_B  => l_acrb,
                   p_sum_A  => p_int_pay,
                   p_nazn   => SubStr('����������� %% �� �������� ������� ����� '||F_NAZN('U', p_dpuid), 1, 160),
                   p_ref    => l_ref );
      
      bars_audit.trace( '%s tt = DU%, ref = %s', title, to_char(l_ref) );
      
$if MAKE_INTEREST.G_USE_TAX_INC
$then
      if ( p_tax_inc_pay > 0 )
      then -- ��������� ������� �� �������� � ��
        
        if ( l_int_cur <> gl.baseval )
        then
          l_tax_amt_eq := round(gl.p_icurval(l_int_cur, p_tax_inc_pay, l_bdat));
        else
          l_tax_amt_eq := p_tax_inc_pay;
        end if;
        
        l_tax_nls_pay := MAKE_INTEREST.GET_TAX_ACCOUNT( 1, 1, l_branch ).acc_num;
        
        bars_audit.trace( '%s tt = %15, tax_amt_eq = %s, tax_nls_pay = %s.', title, to_char(l_tax_amt_eq), l_tax_nls_pay );
        
        gl.payv( null, l_ref, l_bdat, '%15', 1,
                 l_int_cur,  l_int_nls,     p_tax_inc_pay,
                 gl.baseval, l_tax_nls_pay, l_tax_amt_eq );
      end if;
$end
      
$if MAKE_INTEREST.G_USE_TAX_MIL
$then
      if ( p_tax_mil_pay > 0 )
      then -- ��������� ���������� ����� � ��
        
        if ( l_int_cur <> gl.baseval )
        then
          l_tax_amt_eq := round(gl.p_icurval(l_int_cur, p_tax_mil_pay, l_bdat));
        else
          l_tax_amt_eq := p_tax_mil_pay;
        end if;
        
        l_tax_nls_pay := MAKE_INTEREST.GET_TAX_ACCOUNT( 2, 1, l_branch ).acc_num;
        
        gl.payv( null, l_ref, l_bdat, 'MIL', 1,
                 l_int_cur,  l_int_nls,     p_tax_mil_pay,
                 gl.baseval, l_tax_nls_pay, l_tax_amt_eq );
      end if;
$end
    
    end if;
    
    bars_context.set_context;
    
  Else -- p_penalty = 0
    bars_audit.info( title||'�������� ������� ��� ������������ �������� ������� �� ��������!' );
  End If;
  
EXCEPTION
  when OTHERS then
    bars_context.set_context;
    raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace());
end PENALTY_PAYMENT;
  
$if DPU_PARAMS.LINE8
$then
--
-- ����� �������������� ������� �� ���.���.���� ��� ������� �� ���.���.����
--
function GET_DISCREPANCY_BALANCES
( p_rpt_dt         in     date default null
) return varchar2
is
  l_ost_GEN   accounts.ostc%type;
  l_nls_GEN   varchar2(18);
  l_out_msg   varchar2(4000) := null;
  l_bnk_dt    date;
begin

  if ( sys_context('BARS_CONTEXT','USER_BRANCH') = '/' )
  then
    bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '����������� ��������� ��� /' );
  end if;

  l_bnk_dt := coalesce( p_rpt_dt, GL.BD(), GL.GBD() );
  
  for k in ( select GEN_ID, ACC_TIP
                  , sum( nvl( FOST( DEP_ACC, l_bnk_dt ), 0 ) ) as OST_ADD
               from ( select dd.DPU_GEN as GEN_ID
                           , da.ACCID   as DEP_ACC
                           , case
                             when ( da.ACCID = dd.ACC )
                             then 'NL8'
                             else 'DEN'
                             end as ACC_TIP
                        from DPU_ACCOUNTS da
                        join DPU_DEAL     dd
$if DPU_PARAMS.MMFO $then
                          on ( dd.KF = da.KF and dd.DPU_ID = da.DPUID )
$else
                          on ( dd.DPU_ID = da.DPUID )
$end
                       where dd.DPU_GEN Is Not Null
                         and dd.CLOSED = 0
                    )
             group by GEN_ID, ACC_TIP
           )
  loop

    select nvl( FOST( da.ACCID, l_bnk_dt ), 0 ) as OST_GEN
         , ac.NLS||'/'||to_char(ac.KV) as NLS_GEN
      into l_ost_GEN
         , l_nls_gen
      from DPU_ACCOUNTS da
      join DPU_DEAL     dd
$if DPU_PARAMS.MMFO $then
        on ( dd.KF = da.KF and dd.DPU_ID = da.DPUID )
$else
        on ( dd.DPU_ID = da.DPUID )
$end
      join ACCOUNTS     ac
        on ( ac.ACC = da.ACCID )
     where dd.DPU_ID = k.GEN_ID
       and ac.TIP    = k.ACC_TIP;
    
    -- ���� ������� �� ���.���.����� != ��� ���.�� ���.���.����
    if ( l_ost_GEN != k.OST_ADD )
    then

      l_out_msg :=  l_out_msg||'#'||to_char(k.GEN_ID)||': ������� '||to_char(l_ost_GEN/100,'FM999G999G999G990D00')||' �� ���.'||
                    l_nls_GEN||' <> ��� ������� '||to_char(k.OST_ADD/100,'FM999G999G999G990D00')||' �� ���.���.����!'||chr(10);

    end if;

  end loop;

  if ( web_utl.is_web_user = 1 )
  then -- ������ ��������� � WEB
    l_out_msg := replace(l_out_msg,chr(10),'<BR>');
  end if;

  RETURN l_out_msg;

end GET_DISCREPANCY_BALANCES;

--
-- ���������� ����� �������� � ��������� ���������� �� ���.���.���.���.��
--
procedure PAY_BACK
( p_ref    in  oper.ref%type
) is
  title      constant varchar2(60) := 'dpu.payback: ';
  l_dpuid      dpu_deal.dpu_id%type;
  doc_r        OPER%rowtype;
  l_ref        OPER.ref%type;
  l_tt         OPER.tt%type;
  l_nazn       OPER.nazn%type;
  l_bdate      fdat.fdat%type;
  l_errmsg     sec_audit.rec_message%type;
  error_       exception;
  err_lock     exception;
  pragma       exception_init(err_lock, -00054);
begin
  
  bars_audit.trace( '%s entry, ref => %s.', title, to_char(p_ref) );
  
  -- ����� ��������� ��������� � ��������� ����������
  begin
    
    select n.REF2, d.DPU_ID
      into l_ref, l_dpuid
      from BARS.NLK_REF n
      left 
      join BARS.DPU_DEAL d on ( d.ACC = n.ACC )
     where n.REF1 = p_ref
       for update of n.REF2 NOWAIT;
    
    case
      when ( l_ref is not Null)
      then
        l_errmsg := '����� �� ����������� ����� �� ���.������� ���.�� (���.' || to_char(p_ref) || ' ��� �����������.';
        raise error_;
      when ( l_dpuid is Null )
      then
        l_errmsg := '����� (���.' || to_char(p_ref) || ' �� �������� ������� ����������� ������� �������� �������� ��.';
        raise error_;
      else
        null;
    end case;
    
  exception
    when NO_DATA_FOUND then
      l_errmsg := '�� �������� �������� �������� �' || to_char(p_ref) || ' � ��������� ����������.';
      raise;
    when ERR_LOCK then 
      l_errmsg := '����� �� ����������� ����� �� ���.������� ���.�� (���.' || to_char(p_ref) || ' ����������� ����� ������������.';
      raise;
  end;
  
  begin
    
    select * 
      into doc_r
      from BARS.OPER
     where ref = p_ref;
    
    if ( doc_r.sos <> 5 )
    then -- DOCUMENT IS NOT PAID
      l_errmsg := '�������� �' || to_char(p_ref) || ' �� ���������.';
      raise error_;
    end if;
    
  exception
    when NO_DATA_FOUND then
      l_errmsg := '�� �������� �������� �������� �' || to_char(p_ref) || '.';
      raise;
  end;
  
  -- ���������� ��������� �� ���������� �����
  begin
    
    l_tt := case
              when doc_r.MFOA = gl.amfo 
              then 'DU3'
              else 'DU4'
            end;
    
    l_bdate := glb_bankdate;
    
    l_nazn := SubStr( '���������� �������� ����� �������� �� ���� ���. ' ||
                      F_NAZN('U', l_dpuid) ||
                      ' (������������ ���� ����������� ��� ���. ��������), ��� ���.', 1, 160 );
    
    gl.ref( l_ref );
  
    gl.in_doc3( ref_   => l_ref, 
                tt_    => l_tt,         dk_    => doc_r.dk,
                vob_   => 6,            nd_    => SubStr(to_char(l_ref),1,10),
                pdat_  => sysdate,      data_  => l_bdate,   
                vdat_  => l_bdate,      datp_  => l_bdate,     
                kv_    => doc_r.kv2,    kv2_   => doc_r.kv,
                s_     => doc_r.s,      s2_    => doc_r.s2,
                mfoa_  => doc_r.mfoB,   mfob_  => doc_r.mfoA,
                nlsa_  => doc_r.nlsB,   nlsb_  => doc_r.nlsA,
                nam_a_ => doc_r.nam_B,  nam_b_ => doc_r.nam_A, 
                id_a_  => doc_r.id_A,   id_b_  => doc_r.id_A,
                nazn_  => l_nazn,       uid_   => null,  
                d_rec_ => null,         sk_    => null,
                id_o_  => null,         sign_  => null,
                sos_   => null,         prty_  => null );
    
    paytt( null, l_ref, l_bdate, l_tt, doc_r.dk, 
           doc_r.kv2, doc_r.nlsB, doc_r.s, 
           doc_r.kv,  doc_r.nlsA, doc_r.s );
    
    bars_audit.financial( title || ' �������� � ' || to_char(l_ref) );
  
  exception
    when OTHERS then
      l_errmsg := SubStr( '������� ������ ���������: ' || dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 4000 );
      bars_audit.error( title || l_errmsg );
      raise;
  end;
  
  begin
  
    update BARS.NLK_REF
       set ref2 = l_ref 
     where ref1 = p_ref;
    
    if ( sql%rowcount = 0 )
    then
      l_errmsg := '������� ��������� ��������� �' || to_char(p_ref) ||' � ��������� ����������.';
      raise error_;
    end if;
    
  end;
  
  bars_audit.trace( '%s exit, ref => %s.', title, to_char(l_ref) );
  
exception
  when OTHERS then
    
    if ( l_errmsg Is Null)
    then
      l_errmsg := SubStr(dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace(), 1, 4000 );
    end if;
    
    rollback;
    
    bars_error.raise_error( modcode, 666, l_errmsg );
    
end PAY_BACK;
$end


--
--
--
function CHECK_RUNNING_TASK
( p_action   in   v$session.action%type
) return varchar2
is
  title  constant varchar2(64) :=  $$PLSQL_UNIT||'.CHECK_RUNNING_TASK';
  l_errmsg        varchar2(500);
  l_usr_mfo       varchar2(6);
begin
  
  -- task is already running
  
  l_usr_mfo := sys_context('BARS_CONTEXT','USER_MFO');
  
  bars_audit.info( title||': Start with ( p_action=>'||p_action||', l_usr_mfo='||l_usr_mfo||' ).' );

  if ( l_usr_mfo Is Null )
  then -- for all KF
    
    begin
      select case s.USERNAME
             when 'BARS_ACCESS_USER'
             then ( select VALUE
                      from V$GLOBALCONTEXT
                     where NAMESPACE = 'BARS_GLOBAL'
                       and ATTRIBUTE = 'USER_NAME'
                       and CLIENT_IDENTIFIER = s.CLIENT_IDENTIFIER
                  )
             else s.USERNAME
             end || ' (' || s.MACHINE || '/' || s.OSUSER || ')'
        into l_errmsg
        from V$SESSION s
       where s.TYPE   = 'USER'
         and s.STATUS = 'ACTIVE'
         and s.MODULE = 'DPU'
         and s.ACTION = p_action;
    exception
      when NO_DATA_FOUND then
        l_errmsg := null;
    end;
    
  else -- for one KF
    
    begin
      select case s.USERNAME
             when 'BARS_ACCESS_USER'
             then ( select VALUE
                      from V$GLOBALCONTEXT
                     where NAMESPACE = 'BARS_GLOBAL'
                       and ATTRIBUTE = 'USER_NAME'
                       and CLIENT_IDENTIFIER = s.CLIENT_IDENTIFIER
                  )
             else s.USERNAME
             end || ' (' || s.MACHINE || '/' || s.OSUSER || ')'
        into l_errmsg
        from V$SESSION s
       where s.TYPE   = 'USER'
         and s.STATUS = 'ACTIVE'
         and s.MODULE = 'DPU'
         and s.ACTION = p_action
         and exists ( select 1
                        from V$GLOBALCONTEXT c
                       where c.NAMESPACE = 'BARS_CONTEXT'
                         and c.ATTRIBUTE = 'USER_MFO'
                         and c.VALUE     = l_usr_mfo
                         and c.CLIENT_IDENTIFIER = s.CLIENT_IDENTIFIER );
    exception
      when NO_DATA_FOUND then
        l_errmsg := null;
    end;
    
  end if;

  bars_audit.trace( '%s: Exit with ( l_errmsg=>%s ).', title, l_errmsg );

  return l_errmsg;

end check_running_task;

--
-- ������� ³������ �� ��������� ��������
--
procedure AUTO_PAYOUT_INTEREST
( p_bdate  in  fdat.fdat%type
) is
  title        constant varchar2(64) := 'dpu.autopayoutinterest: ';
  l_runid      dpu_jobs_jrnl.run_id%type;       -- ������������� �������
  l_jobid      dpt_jobs_list.job_id%type;       -- ������������� ��������
  l_int_ref    oper.ref%type;                   -- �������� �������� ������� �������
  l_int_amnt   oper.s%type;                     -- ���� ������
  l_bdate      fdat.fdat%type;                  -- ��������� ����
  l_datret     dpu_deal.datv%type;              -- ���� ���������� ��������
  l_errflg     boolean;
  l_errmsg     sec_audit.rec_message%type;
  error_       exception;
begin

  bars_audit.trace( '%s start with: p_bdate=>%s.', title, to_char(p_bdate,'dd.mm.yyyy') );
  
  if ( sys_context('bars_context','policy_group') = 'FILIAL' )
  then
    
    if ( p_bdate is Null )
    then
      l_bdate := GL.GBD();
    else 
      l_bdate := p_bdate;
    end if;
    
    if ( l_bdate = DAT_NEXT_U( trunc(l_bdate,'MM'), 0 ) )
    then -- ������ ������� ���� ����� (������� %% �� ������ ��������)
      l_datret := null;
    else -- ������� ������� %% �� ��������� ��������
--    l_datret := dat_next_u(l_bdate, 1);
      l_datret := l_bdate;
    end if;
    
    l_errmsg := CHECK_RUNNING_TASK('AUTO_PAYOUT_INTEREST');
    
  else
    
    l_errmsg := '����������� ��������� ������������ ����� '||sys_context('bars_context','policy_group');
    
  end if;
  
  if (l_errmsg is Not Null)
  then
    BARS_ERROR.RAISE_NERROR( modcode, 'TASK_ALREADY_RUNNING', l_errmsg );
  else
    dbms_application_info.set_module(MODCODE, 'AUTO_PAYOUT_INTEREST');
    dbms_application_info.set_client_info( 'Start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') || 'with p_bdate=' || to_char(p_bdate, 'dd.mm.yyyy') );
  end if;
  
  l_jobid := 278;
  
  -- �������� ������ ��������� ������������� �������� � ������ ���������
  dpt_jobs_audit.p_start_job( p_modcode => modcode,
                              p_jobid   => l_jobid,
                              p_branch  => sys_context('bars_context','user_branch'),
                              p_bdate   => l_bdate,
                              p_run_id  => l_runid );
  
  bars_audit.trace( '%s start paying interest (runid = %s, datret = %s).', title, to_char(l_runid), to_char(l_datret,'dd.mm.yyyy') );
  
  for d in ( select d.dpu_id as dpt_id,     d.nd     as dpt_num,    d.datz  as dpt_dat
                  , d.rnk    as cust_id,    d.branch as dpt_branch, d.kf    as dpt_mfo
                  , i.id     as int_id,    'DU%'     as int_tt,     i.acr_dat
                  , nvl(i.stp_dat, l_bdate - 1) as stp_dat
                  , ad.nbs   as dpt_nbs,    ad.daos  as daos,       ad.nms  as dpt_acc_name, t.lcv
                  , ad.acc   as dpt_acc_id, ad.nls   as dpt_acc_nm, ad.kv   as dpt_cur_id,
                    ai.acc   as int_acc_id, ai.nls   as int_acc_nm, ai.kv   as int_cur_id,
                    d.mfo_p  as int_mfoB,   d.nls_p  as int_nlsB,   d.nms_p as int_namB, d.okpo_p as int_idB
               from DPU_DEAL  d
               join ACCOUNTS ad on ( ad.acc = d.acc  )
               join INT_ACCN  i on (  i.acc = d.acc AND i.id = 1 )
               join ACCOUNTS ai on ( ai.acc = i.acra )
               join CUSTOMER  c on (  c.rnk = d.rnk  )
               join TABVAL    t on ( ad.kv  = t.kv   )
              where l_datret is Not Null -- 
                and d.CLOSED = 0
                and nvl(d.DPU_ADD, 1) != 0
                and d.DATV   = l_datret
              union all
             select d.dpu_id as dpt_id,     d.nd     as dpt_num,    d.datz  as dpt_dat
                  , d.rnk    as cust_id,    d.branch as dpt_branch, d.kf    as dpt_mfo
                  , i.id     as int_id,     'DU%'    as int_tt,     i.acr_dat
                  , nvl(i.stp_dat, l_bdate - 1) as stp_dat
                  , ad.nbs   as dpt_nbs,    ad.daos  as daos,       ad.nms  as dpt_acc_name, t.lcv
                  , ad.acc   as dpt_acc_id, ad.nls   as dpt_acc_nm, ad.kv   as dpt_cur_id
                  , ai.acc   as int_acc_id, ai.nls   as int_acc_nm, ai.kv   as int_cur_id
                  , d.mfo_p  as int_mfoB,   d.nls_p  as int_nlsB,   d.nms_p as int_namB, d.okpo_p as int_idB
               from DPU_DEAL      d
               join ACCOUNTS     ad on ( ad.ACC = d.ACC  )
               join INT_ACCN      i on (  i.ACC = d.ACC and i.id = 1 )
               join ACCOUNTS     ai on ( ai.ACC = i.ACRA )
               join CUSTOMER      c on (  c.RNK = d.RNK  )
               join TABVAL$GLOBAL t on (  t.KV  = ad.KV  )
               join DPU_VIDD      v on ( v.VIDD = d.VIDD )
              where l_datret is Null     --
                and d.CLOSED = 0
                and nvl(d.DPU_ADD, 1) != 0
                and ai.OSTC = ai.OSTB
                and ai.OSTC > 0
                and trunc(l_bdate,'MM') >= case v.FREQ_V 
                                           when 5   -- ��� � �����
                                           then add_months(trunc(nvl(i.apl_dat, d.datz ),'MM'), 1 )
                                           when 7   -- ��� � �������
                                           then add_months(trunc(nvl(i.apl_dat, d.datz ),'MM'), 3 )
                                           when 180 -- ��� � �� ����
                                           then add_months(trunc(nvl(i.apl_dat, d.datz ),'MM'), 6 )
                                           when 360 -- ��� � ��
                                           then add_months(trunc(nvl(i.apl_dat, d.datz ),'MM'),12 )
                                           when 400 -- � ���� ������
                                           then d.DATV
                                           else null
                                           end
  ) loop
    
    begin
      
      bars_audit.trace('%s deposit � %s (%s)', title, d.dpt_num, to_char(d.dpt_id));
      
      SAVEPOINT SP_PAYOUT_INTEREST;
      
      l_errflg   := false;
      l_errmsg   := null;
      l_int_ref  := null;  
      l_int_amnt := null;
      
      if ( d.acr_dat < d.stp_dat and p_bdate is Not Null )
      then -- ����������� %% �� ��������
        
        insert 
          into INT_QUEUE
          ( mod_code, kf, branch, deal_id, deal_num, deal_dat, 
            acc_id, acc_num, acc_name, acc_cur, acc_iso, 
            acc_nbs, acc_open, cust_id, int_id, int_tt )
        values
          ( 'DPU', d.dpt_mfo, d.dpt_branch, d.dpt_id, d.dpt_num, d.dpt_dat, 
            d.dpt_acc_id, d.dpt_acc_nm, d.dpt_acc_name, d.dpt_cur_id, d.lcv, 
            d.dpt_nbs, d.daos, d.cust_id, d.int_id, d.int_tt );
                  
        make_int( p_dat2      => d.stp_dat,
                  p_runmode   => 1, 
                  p_runid     => 0,
                  p_intamount => l_int_amnt,
                  p_errflg    => l_errflg );

        if l_errflg 
        then
          
          l_errmsg := substr('������� ����������� %% �� �������� �'||d.dpt_num||' ('||to_char(d.dpt_id)||') '||sqlerrm, 1, 2000 );
          
          raise error_;
          
        else
          
          bars_audit.trace('%s interest amount = %s', title, to_char(l_int_amnt));
          
        end if;
        
      end if;
      
      if (d.int_mfoB is Not Null AND d.int_nlsB is Not Null) 
      then
        
        -- �������� ������� �� ����� ����������� ��������� (� ������ ���������� ���������� %%)
        begin
          select OSTB
            into l_int_amnt
            from ACCOUNTS
           where ACC = d.int_acc_id
             for update of OSTB nowait;
          bars_audit.trace( '%s account %s saldo = %s', title, d.int_acc_nm, to_char(l_int_amnt) );
        exception
          when others then
            l_errmsg := substr( '������ ���������� ����� '||d.int_acc_nm||': '||sqlerrm, 1, 2000 );
            raise error_;
        end;
        
        -- ������� ���������
        if ( l_int_amnt > 0 )
        then

          PAY_DOC_EXT( p_dpuid  => d.dpt_id,
                       p_bdat   => l_bdate,
                       p_acc_A  => d.int_acc_id,
                       p_mfo_B  => d.int_mfoB,
                       p_nls_B  => d.int_nlsB,
                       p_nms_B  => d.int_namB,
                       p_okpo_B => d.int_idB,
                       p_sum    => l_int_amnt,
                       p_nazn   => SubStr('³������ �� �������� ����� '||F_NAZN('U',d.dpt_id),1,160),
                       p_ref    => l_int_ref );
            
          update INT_ACCN i
             set i.APL_DAT = l_bdate 
           where i.ACC = d.int_acc_id
             and i.ID  = 1;
          
          bars_audit.financial( title||'���������� �������� �� ������� ������� (ref =  '||to_char(l_int_ref)||').' );
          
          dpt_jobs_audit.p_save2log( p_modcode => modcode,
                                     p_runid   => l_runid,
                                     p_dptid   => d.dpt_id,
                                     p_dealnum => d.dpt_num,
                                     p_branch  => d.dpt_branch,
                                     p_ref     => l_int_ref,
                                     p_rnk     => d.cust_id,
                                     p_nls     => d.int_acc_nm,
                                     p_kv      => d.int_cur_id,
                                     p_dptsum  => null,
                                     p_intsum  => l_int_amnt,
                                     p_status  => 1,
                                     p_errmsg  => null );
          
        else
          
          l_errmsg := '�� ������ ������� ��� ������� �������.';
          raise error_;
          
        end if;
        
      else
        
        l_errmsg := '�� ������ ������� ��� ������� �������.';
        raise error_;
        
      end if;
      
    exception
      when OTHERS then
        
        if (l_errmsg is Null)
        then 
          
          l_errmsg := SubStr(dbms_utility.format_error_stack(), 1, 3000);
          
          bars_audit.error( title||'������ ��� ������ %% �� ���.���. � '||d.dpt_num||'(#'||to_char(d.dpt_id)
                           ||') '||l_errmsg||chr(10)||dbms_utility.format_error_backtrace() );
          
        end if;
        
        dpt_jobs_audit.p_save2log( p_modcode => modcode,
                                   p_runid   => l_runid,
                                   p_dptid   => d.dpt_id,
                                   p_dealnum => d.dpt_num,
                                   p_branch  => d.dpt_branch,
                                   p_ref     => l_int_ref,
                                   p_rnk     => d.cust_id,
                                   p_nls     => d.int_acc_nm,
                                   p_kv      => d.int_cur_id,
                                   p_dptsum  => null,
                                   p_intsum  => l_int_amnt,
                                   p_status  => -1,
                                   p_errmsg  => l_errmsg );
        
        ROLLBACK TO SP_PAYOUT_INTEREST;
        
    end;
    
  end loop;
  
  -- �������� �������� ���������� ������������� �������� � ������
  dpt_jobs_audit.p_finish_job( modcode, l_runid );
  
  dbms_application_info.set_module(NULL, NULL);
  dbms_application_info.set_client_info(NULL);
  
  bars_audit.trace( '%s exit.', title );
  
  COMMIT;
  
exception
  when others then
    
    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()
                                    ||dbms_utility.format_error_backtrace() );
    
    if ( l_runid is Not Null )
    then -- �������� ���������� ������������� �������� � �������� � ������
      
      dpt_jobs_audit.p_finish_job( modcode, l_runid, SubStr(dbms_utility.format_error_stack(), 1, 3000) );
      
      dbms_application_info.set_module(NULL, NULL);
      dbms_application_info.set_client_info(NULL);
      
    else -- ��������� ����������� ��� ������� ���������
      
      bars_error.raise_error( modcode, 666, SubStr(dbms_utility.format_error_stack(), 1, 254) );
      
    end if;
    
    ROLLBACK;
    
end AUTO_PAYOUT_INTEREST;

--
-- ���������� �������� �� ��������� ��������
--
procedure AUTO_PAYOUT_DEPOSIT
( p_bdate  in  fdat.fdat%type
) is
  title        constant varchar2(60) := 'dpu.autopayoutdeposit: ';
  l_runid      dpu_jobs_jrnl.run_id%type;      -- ������������� �������
  l_jobid      dpt_jobs_list.job_id%type;      -- ������������� ��������
  l_dpt_ref    oper.ref%type;                  -- �������� �������� ������� ��������
  l_dpt_amnt   oper.s%type;                    -- ����
  l_bdate      fdat.fdat%type;                 -- ��������� ����
  l_datret     dpu_deal.datv%type;             -- ���� ���������� ��������
  l_errflg     boolean;
  l_errmsg     sec_audit.rec_message%type;
  error_       exception;
begin
  
  bars_audit.trace( '%s start with: p_bdate=>%s.', title, to_char(p_bdate,'dd.mm.yyyy') );
  
  l_errmsg := check_running_task('AUTO_PAYOUT_DEPOSIT');
  
  if (l_errmsg is Not Null)
  then
    bars_error.raise_nerror( modcode, 'TASK_ALREADY_RUNNING', l_errmsg );
  else
    dbms_application_info.set_module(MODCODE, 'AUTO_PAYOUT_DEPOSIT');
    dbms_application_info.set_client_info( 'Start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') || 'with p_bdate=' || to_char(p_bdate, 'dd.mm.yyyy') );
  end if;
  
  -- ��������� ����
  if (p_bdate is Null) 
  then
    l_bdate := glb_bankdate;
  else
    l_bdate := p_bdate;
  end if;
  
  l_jobid := 280;
  
  -- ���� ��������� (MATURITY DATE)
  l_datret := dat_next_u(l_bdate, 1);
  
  -- �������� ������ ��������� ������������� �������� � ������ ���������
  dpt_jobs_audit.p_start_job( p_modcode => modcode,
                              p_jobid   => l_jobid,
                              p_branch  => sys_context('bars_context','user_branch'),
                              p_bdate   => l_bdate,
                              p_run_id  => l_runid );
  
  bars_audit.trace( '%s start paying interest (runid = %s, acrdat = %s).', title, to_char(l_runid), to_char(l_datret,'dd.mm.yyyy') );
  
  for d in ( select d.dpu_id as dpt_id,     d.nd    as dpt_num,
                    d.branch as dpt_branch, d.rnk   as cust_id,
                    i.acr_dat,              nvl(i.stp_dat, l_bdate - 1)    as stp_dat,
                    ad.acc   as dpt_acc_id, ad.nls  as dpt_acc_nm, ad.kv   as dpt_cur_id, ad.blkd as dpt_acc_blkd,
                    ai.acc   as int_acc_id, ai.nls  as int_acc_nm, ai.kv   as int_cur_id, 
                    d.mfo_d  as dpt_mfoB,   d.nls_d as dpt_nlsB,   d.nms_d as dpt_namB,   c.okpo as dpt_idB
               from BARS.DPU_DEAL  d
               join BARS.ACCOUNTS ad on ( ad.acc = d.acc  )
               join BARS.INT_ACCN  i on (  i.acc = d.acc AND i.id = 1 )
               join BARS.ACCOUNTS ai on ( ai.acc = i.acra )
               join BARS.CUSTOMER  c on (  c.rnk = d.rnk  )
              where d.closed = 0
                and d.datV   = l_datret )
  loop
    
    begin
      
      bars_audit.trace('%s deposit � %s (%s)', title, d.dpt_num, to_char(d.dpt_id));
      
      SAVEPOINT SP_PAYOUT_DEPOSIT;
      
      l_errflg   := false;
      l_errmsg   := null;
      l_dpt_ref  := null;  
      l_dpt_amnt := null;
      
      If (d.dpt_mfoB is NOT null AND d.dpt_nlsB is NOT null) 
      Then
          
        -- �������� ������� �� ���������� ����� (� ������ ��������� ������������� %%)
        begin
          select OSTB
            into l_dpt_amnt 
            from BARS.ACCOUNTS 
           where acc = d.dpt_acc_id
             for update of OSTB nowait;
          bars_audit.trace('%s account %s saldo = %s', title, d.dpt_acc_nm, to_char(l_dpt_amnt));
        exception
          when others then
            l_errmsg := substr('������ ���������� ����� '||d.dpt_acc_nm||': '||sqlerrm, 1, 2000);
            raise error_;
        end;
        
        if (l_dpt_amnt > 0) 
        then -- ���������� ��������
$if DPU_PARAMS.SBER
$then
          
          if ( d.dpt_acc_blkd = �_blkd_ins )
          then -- ������ ���������� �� ����� ���. ��������� �������� ����
            update BARS.ACCOUNTS
               set BLKD = 0
             where ACC = d.dpt_acc_id;
          end if;
$end
          
          PAY_DOC_EXT( p_dpuid  => d.dpt_id,
                       p_bdat   => l_datret,
                       p_acc_A  => d.dpt_acc_id,
                       p_mfo_B  => d.dpt_mfoB,
                       p_nls_B  => d.dpt_nlsB,
                       p_nms_B  => d.dpt_namB,
                       p_okpo_B => d.dpt_idB,
                       p_sum    => l_dpt_amnt,
                       p_nazn   => SubStr('���������� �������� ����� '||F_NAZN('U', d.dpt_id), 1, 160),
                       p_ref    => l_dpt_ref );
          
          bars_audit.financial('���������� �������� �� ������� �������� (ref =  '||to_char(l_dpt_ref)||').' );
          
          dpt_jobs_audit.p_save2log( p_modcode => modcode,
                                   p_runid   => l_runid,
                                   p_dptid   => d.dpt_id,
                                   p_dealnum => d.dpt_num,
                                   p_branch  => d.dpt_branch,
                                   p_ref     => l_dpt_ref,
                                   p_rnk     => d.cust_id,
                                   p_nls     => d.dpt_acc_nm,
                                   p_kv      => d.dpt_cur_id,
                                   p_dptsum  => null,
                                   p_intsum  => l_dpt_amnt,
                                   p_status  => 1,
                                   p_errmsg  => null );
          
        end if;
        
      Else
        
        l_errmsg := '�� ������ ������� ��� ���������� ��������.';
        raise error_;
        
      End if;
      
    exception
      when OTHERS then
        
        if (l_errmsg is Null)
        then 
          
          l_errmsg := SubStr(dbms_utility.format_error_stack(), 1, 3000);
          
          bars_audit.error( title||'������ ���������� ����� �� ���.���. � '||d.dpt_num||'(#'||to_char(d.dpt_id)
                           ||') '||l_errmsg||chr(10)||dbms_utility.format_error_backtrace() );
          
        end if;
             
        dpt_jobs_audit.p_save2log( p_modcode => modcode,
                                   p_runid   => l_runid,
                                   p_dptid   => d.dpt_id,
                                   p_dealnum => d.dpt_num,
                                   p_branch  => d.dpt_branch,
                                   p_ref     => l_dpt_ref,
                                   p_rnk     => d.cust_id,
                                   p_nls     => d.dpt_acc_nm,
                                   p_kv      => d.dpt_cur_id,
                                   p_dptsum  => null,
                                   p_intsum  => l_dpt_amnt,
                                   p_status  => -1,
                                   p_errmsg  => l_errmsg );
        
        ROLLBACK TO SP_PAYOUT_DEPOSIT;
                
    end;
    
  end loop;
  
  -- �������� �������� ���������� ������������� �������� � ������
  dpt_jobs_audit.p_finish_job( modcode, l_runid );
  
  dbms_application_info.set_module(NULL, NULL);
  dbms_application_info.set_client_info(NULL);
  
  bars_audit.trace( '%s exit.', title );
  
exception
  when others then
    
    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace() );
    
    -- �������� ���������� ������������� �������� � �������� � ������
    dpt_jobs_audit.p_finish_job( modcode, l_runid, SubStr(dbms_utility.format_error_stack(), 1, 3000) );
    
    dbms_application_info.set_module(NULL, NULL);
    dbms_application_info.set_client_info(NULL);
    
    ROLLBACK;
    
end AUTO_PAYOUT_DEPOSIT;

--
-- ����������� �� ������� ³������ � ҳ�� �� ��������� ��������
--
procedure AUTO_MATURITY_PAYOFF
( p_dpuid  in  dpu_deal.dpu_id%type,
  p_bdate  in  fdat.fdat%type
) is
  title        constant varchar2(60) := 'dpu.automatpayoff: ';
  l_errflg     boolean;
  l_errmsg     sec_audit.rec_message%type;
  l_int_ref    oper.ref%type;                              -- �������� �������� ������� �������
  l_dpt_ref    oper.ref%type;                              -- �������� �������� ������� ��������
  l_int_amnt   oper.s%type;                                -- ���� 
  l_dpt_amnt   oper.s%type;                                -- ����
  l_vdat       oper.vdat%type := glb_bankdate;             -- ���� ����������� = ��������� ��������� ����
  l_bdate      fdat.fdat%type;                             -- ��������� ����
begin
  
  bars_audit.trace( '%s start with: p_bdate=>%s, p_dpuid=>%s.', title, to_char(p_bdate,'dd.mm.yyyy'), to_char(p_dpuid) );
  
  -- ��������� ���� ���������
  if (p_bdate is Null) 
  then
    l_bdate := glb_bankdate;
  else
    l_bdate := p_bdate;
  end if;
  
  if (p_dpuid = 0)
  then
    
    DPU.AUTO_PAYOUT_INTEREST( p_bdate => l_bdate );
    
    DPU.AUTO_PAYOUT_DEPOSIT( p_bdate  => l_bdate );
  
  else 
  
    for d in ( select d.dpu_id dptid, d.nd dptnum, d.datz dptdat, 
                      a.acc depaccid, b.acc intaccid,
                      c.rnk custid, c.okpo custcode, substr(c.nmk, 1, 38) custname, 
                      i.id intid, 'DU%' inttt, a.branch, a.nbs, a.daos, t.lcv, 
                      a.kf    depmfoa, a.nls   depnlsa, substr(a.nms,   1,38) depnama, a.kv depcurid,
                      b.kf    intmfoa, b.nls   intnlsa, substr(b.nms,   1,38) intnama, b.kv intcurid,            
                      d.mfo_d depmfob, d.nls_d depnlsb, substr(d.nms_d, 1,38) depnamb, c.okpo depidb,
                      d.mfo_p intmfob, d.nls_p intnlsb, substr(d.nms_p, 1,38) intnamb, nvl(d.okpo_p, c.okpo) intidb 
                 from BARS.DPU_DEAL d,
                      BARS.ACCOUNTS a, 
                      BARS.INT_ACCN i, 
                      BARS.accounts b, 
                      BARS.customer c,
                      BARS.tabval   t
                where d.closed = 0
                  and d.datv <= p_bdate
                  and d.dpu_id not in ( select DPU_ID from BARS.DPU_DEALW where TAG = 'NOT_RETURN' )
                  and d.acc  = a.acc
                  and i.acc  = a.acc
                  and i.id   = 1
                  and i.acra = b.acc
                  and d.rnk  = c.rnk
                  and a.kv   = t.kv
                  and a.ostc = a.ostb
                  and b.ostc = b.ostb
                  and ( (a.ostc > 0 AND d.mfo_d is not null AND d.nls_d is not null) or 
                        (b.ostc > 0 AND d.mfo_p is not null AND d.nls_p is not null) )
                order by 1 )
    loop
      
      bars_audit.trace('%s deposit � %s (%s)', title, d.dptnum, to_char(d.dptid));
        
      savepoint sp_maturity;
      
      l_errflg   := false;
      l_errmsg   := null;
      l_dpt_ref  := null;
      l_dpt_amnt := null;
      l_int_ref  := null;  
      l_int_amnt := null;
      
      -- ����������� ������� �� �������� ����
      insert into int_queue 
        ( mod_code, kf, branch, deal_id, deal_num, deal_dat, 
          acc_id, acc_num, acc_name, acc_cur, acc_iso, 
          acc_nbs, acc_open, cust_id, int_id, int_tt )
      values
        ( 'DPU', d.depmfoa, d.branch, d.dptid, d.dptnum, d.dptdat, 
          d.depaccid, d.depnlsa, d.depnama, d.depcurid, d.lcv, 
          d.nbs, d.daos, d.custid, d.intid, d.inttt );
                
      make_int( p_dat2      => p_bdate - 1, 
                p_runmode   => 1, 
                p_runid     => 0,
                p_intamount => l_int_amnt, 
                p_errflg    => l_errflg);

      if l_errflg 
      then
         l_errmsg := substr('������ ���������� %% �� �������� �'||d.dptnum||' ('||to_char(d.dptid)||') '||sqlerrm, 1, 2000 );
      else
         bars_audit.trace('%s interest amount = %s', title, to_char(l_int_amnt));
      end if;
      
      if (d.intmfoB is NOT null AND d.intnlsB is NOT null) 
      then
        
        -- �������� ������� �� ����� ����������� ��������� (� ������ ���������� ���������� %%)
        begin
          select ostb 
            into l_int_amnt 
            from accounts 
           where acc = d.intaccid
             for update of ostb nowait;
          bars_audit.trace('%s account %s saldo = %s', title, d.intnlsa, to_char(l_int_amnt));
        exception
          when others then
            l_errflg := true;
            l_errmsg := substr('������ ���������� ����� '||d.intnlsa||': '||sqlerrm, 1, 2000 );
            bars_audit.error( title||l_errmsg );   
        end;
   
        if (l_int_amnt > 0)
        then -- ������� �������

          dpt_web.paydoc( p_dptid      => d.dptid,
                          p_vdat       => l_vdat,
                          p_brancha    => d.branch,
                          p_nlsa       => d.intnlsa,
                          p_mfoa       => d.intmfoa,
                          p_nama       => d.intnama,
                          p_ida        => d.custcode,
                          p_kva        => d.intcurid, 
                          p_sa         => l_int_amnt,
                          p_branchb    => null,
                          p_nlsb       => nvl(d.intnlsb, d.depnlsb),
                          p_mfob       => nvl(d.intmfob, d.depmfob),
                          p_namb       => nvl(d.intnamb, d.depnamb),
                          p_idb        => nvl(d.intidb,  d.depidb),
                          p_kvb        => d.intcurid, 
                          p_sb         => l_int_amnt,
                          p_nazn       => null,
                          p_nmk        => d.custname, 
                          p_tt         => null,
                          p_vob        => null,
                          p_dk         => 1,
                          p_sk         => null,
                          p_userid     => null,
                          p_type       => 4,
                          p_ref        => l_int_ref,
                          p_err_flag   => l_errflg,
                          p_err_msg    => l_errmsg);

          if l_errflg
          then
            bars_audit.error( title||'������� ������: '||l_errmsg );
          else
            bars_audit.financial('����������� �������� �� ������� ���������. ref '||to_char(l_int_ref));
          end if;
          
        end if;
        
      end if;
  
      if (d.depmfoB is NOT null AND d.depnlsB is NOT null)
      then
          
        -- �������� ������� �� ���������� ����� (� ������ ��������� ������������� %%)
        begin
          select ostb 
            into l_dpt_amnt
            from accounts 
          where acc = d.depaccid
            for update of ostb nowait;
          bars_audit.trace( '%s account %s saldo = %s', title, d.depnlsa, to_char(l_dpt_amnt) );
        exception
          when others then
            l_errflg := true;
            l_errmsg := substr( '������ ���������� ����� '||d.depnlsa||': '||sqlerrm, 1, 2000 );
        end;
        
        If (l_dpt_amnt > 0)
        Then -- ������� ��������
          
          dpt_web.paydoc( p_dptid      => d.dptid,
                          p_vdat       => l_vdat,
                          p_brancha    => d.branch,
                          p_nlsa       => d.depnlsa,
                          p_mfoa       => d.depmfoa,
                          p_nama       => d.depnama,
                          p_ida        => d.custcode,
                          p_kva        => d.depcurid,
                          p_sa         => l_dpt_amnt,
                          p_branchb    => null,
                          p_nlsb       => d.depnlsb,
                          p_mfob       => d.depmfob,
                          p_namb       => d.depnamb,
                          p_idb        => d.depidb,
                          p_kvb        => d.depcurid,
                          p_sb         => l_dpt_amnt,
                          p_nazn       => null,
                          p_nmk        => d.custname,
                          p_tt         => null,
                          p_vob        => null,
                          p_dk         => 1,
                          p_sk         => null,
                          p_userid     => null,
                          p_type       => 2,
                          p_ref        => l_dpt_ref,
                          p_err_flag   => l_errflg,
                          p_err_msg    => l_errmsg );
        
          if l_errflg 
          then
            bars_audit.error( title||'������� ������: '||l_errmsg );
          else
            bars_audit.financial( '����������� �������� �� ������������ ����� ��������. ref '||to_char(l_dpt_ref));
          end if;
          
        End if;
          
      End if;
      
      if l_errflg 
      then 
        
        ROLLBACK TO sp_maturity;
        
        bars_error.raise_nerror( modcode, 'PAYOUT_ERR', title||l_errmsg );
        
      end if;
      
    end loop;
  
  end if;
  
  bars_audit.trace( '%s exit.', title );
  
exception
  when OTHERS then
    
    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace() );
    
end AUTO_MATURITY_PAYOFF;

--
-- ������������ ���������� �������� ���� ���������� ������ 䳿
--
procedure AUTO_MOVE2ARCHIVE
( p_bdate  in   fdat.fdat%type )
is
  title         constant varchar2(60)      := 'dpu.automove2arch: ';
  l_runid       dpu_jobs_jrnl.run_id%type;                  -- ������������� �������
  l_jobid       dpt_jobs_list.job_id%type;                  -- ������������� ��������
  l_errmsg      sec_audit.rec_message%type;                 -- 
  type t_dpurec is record ( dptid   dpu_deal.dpu_id%type,
                            dptnum  dpu_deal.nd%type,
                            custid  dpu_deal.rnk%type,
                            branch  dpu_deal.branch%type,
                            dpugen  dpu_deal.dpu_gen%type,
                            extend  dpu_vidd.fl_extend%type,
                            nls     accounts.nls%type, 
                            kv      accounts.kv%type );
  type t_dputab is table of t_dpurec;
  l_dpu         t_dputab;
  err_close     exception;
begin

  bars_audit.trace( '%s entry, bdate=>%s', title, to_char(p_bdate, 'dd.mm.yyyy') );
  
  l_errmsg := check_running_task('AUTO_MOVE2ARCHIVE');
  
  if (l_errmsg is Not Null)
  then
    bars_error.raise_nerror( modcode, 'TASK_ALREADY_RUNNING', l_errmsg );
  else
    dbms_application_info.set_module(MODCODE, 'AUTO_MOVE2ARCHIVE');
    dbms_application_info.set_client_info( 'Start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') || 'with p_bdate=' || to_char(p_bdate, 'dd.mm.yyyy') );
  end if;
  
  l_jobid := 279;
  
  -- �������� ������ ��������� ������������� �������� � ������ ���������
  dpt_jobs_audit.p_start_job( p_modcode => modcode,
                              p_jobid   => l_jobid,
                              p_branch  => sys_context('bars_context','user_branch'),
                              p_bdate   => p_bdate,
                              p_run_id  => l_runid );
  
  select d.dpu_id, d.nd, d.rnk, d.branch, d.dpu_gen, 
         v.fl_extend,
         a.nls, a.kv
    bulk collect 
    into l_dpu
    from dpu_deal d
    join bars.accounts a on ( a.acc  = d.acc  )
    join dpu_vidd      v on ( v.vidd = d.vidd )
   where d.datv < p_bdate
     and d.closed = 0;
   
  for i in 1..l_dpu.count 
  loop
    
    bars_audit.trace( '%s deposit � %s (%s).', title, to_char(l_dpu(i).dptid), l_dpu(i).dptnum );
    
    savepoint del_ok;
    
    l_errmsg := null;
    
    begin
    
      If ( l_dpu(i).extend = 2 AND l_dpu(i).dpugen is Null )
      Then
        
        l_errmsg := '����������� ������ ����� ���������� ����� ������!';
        raise err_close;
        
      Else
        
        CLOSE_DEAL( l_dpu(i).dptid );
        
        dpt_jobs_audit.p_save2log( p_modcode => modcode,
                                   p_runid   => l_runid,
                                   p_dptid   => l_dpu(i).dptid,
                                   p_dealnum => l_dpu(i).dptnum,
                                   p_branch  => l_dpu(i).branch,
                                   p_ref     => null,
                                   p_rnk     => l_dpu(i).custid,
                                   p_nls     => l_dpu(i).nls,
                                   p_kv      => l_dpu(i).kv,
                                   p_dptsum  => null,
                                   p_intsum  => null,
                                   p_status  => 1,
                                   p_errmsg  => null );
        
      End If;
      
    exception
      when OTHERS then
        
        if ( l_errmsg Is Null)
        then
          
          l_errmsg := SubStr(dbms_utility.format_error_stack(), 1, 3000);
          
          bars_audit.error( title||'������ ��� ������ ���.���. � '||l_dpu(i).dptnum||'(#'||to_char(l_dpu(i).dptid)
                           ||') '||l_errmsg||chr(10)||dbms_utility.format_error_backtrace() );
          
        end if;
        
        dpt_jobs_audit.p_save2log( p_modcode => modcode,
                                   p_runid   => l_runid,
                                   p_dptid   => l_dpu(i).dptid,
                                   p_dealnum => l_dpu(i).dptnum,
                                   p_branch  => l_dpu(i).branch,
                                   p_ref     => null,
                                   p_rnk     => l_dpu(i).custid,
                                   p_nls     => l_dpu(i).nls,
                                   p_kv      => l_dpu(i).kv,
                                   p_dptsum  => null,
                                   p_intsum  => null,
                                   p_status  => -1,
                                   p_errmsg  => l_errmsg );
        
        rollback to del_ok;
        
    end;
    
  end loop;
  
  -- �������� �������� ���������� ������������� �������� � ������
  dpt_jobs_audit.p_finish_job( modcode, l_runid );
  
  dbms_application_info.set_module(NULL, NULL);
  dbms_application_info.set_client_info(NULL);
  
  commit;
  
exception
  when TASK_ALREADY_RUNNING 
  then
    null;
    
  when OTHERS 
    then
    
    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace() );
    
    -- �������� ���������� ������������� �������� � �������� � ������
    dpt_jobs_audit.p_finish_job( modcode, l_runid, SubStr(dbms_utility.format_error_stack(), 1, 3000) );
    
    dbms_application_info.set_module(NULL, NULL);
    dbms_application_info.set_client_info(NULL);
    
    ROLLBACK;

end AUTO_MOVE2ARCHIVE;

--
-- ����������� ����������� %% �� ��������� ����� ���� ����������
--
procedure AUTO_MAKE_INT_FINALLY
( p_bdate  in  fdat.fdat%type                              -- ��������� ���� ������� �� ���������
) is
  title        constant varchar2(60) := 'dpu.automakeintfinal: ';
  l_runid      dpu_jobs_jrnl.run_id%type;                  -- ������������� �������
  l_jobid      dpt_jobs_list.job_id%type;                  -- ������������� ��������
  l_bdate      fdat.fdat%type;                             -- ��������� ����
  l_datret     dpu_deal.datv%type;                         -- ���� ���������� ��������
  l_acrdat     int_accn.acr_dat%type;                      -- 
  l_amount     oper.s%type;                                -- ����
  l_errflg     boolean;                                    --
  l_errmsg     sec_audit.rec_message%type;
begin
  
  bars_audit.trace( '%s start with: p_bdate=>%s.', title, to_char(p_bdate,'dd.mm.yyyy') );
  
  l_errmsg := check_running_task('AUTO_MAKE_INT_FINALLY');
  
  if (l_errmsg is Not Null)
  then
    bars_error.raise_nerror( modcode, 'TASK_ALREADY_RUNNING', l_errmsg );
  else
    dbms_application_info.set_module(MODCODE, 'AUTO_MAKE_INT_FINALLY');
    dbms_application_info.set_client_info( 'Start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') || 'with p_bdate=' || to_char(p_bdate, 'dd.mm.yyyy') );
  end if;
  
  if (p_bdate is Null) 
  then
    l_bdate := glb_bankdate;
  else
    l_bdate := p_bdate;
  end if;
  
  l_datret := BARS.DAT_NEXT_U(p_bdate, 1);
  l_acrdat := l_datret - 1;
  
  l_jobid := 277;
  
  -- �������� ������ ��������� ������������� �������� � ������ ���������
  bars.dpt_jobs_audit.p_start_job( p_modcode => modcode
                                 , p_jobid   => l_jobid
                                 , p_branch  => sys_context('bars_context','user_branch')
                                 , p_bdate   => l_bdate
                                 , p_run_id  => l_runid );
  
  bars_audit.trace( '%s start accrual interest (runid = %s, acrdat = %s).'
                  , title, to_char(l_runid), to_char(l_acrdat,'dd.mm.yyyy') );
  
  insert 
    into BARS.INT_QUEUE
    ( kf, branch, deal_id, deal_num, deal_dat, cust_id, int_id,  
      acc_id, acc_num, acc_cur, acc_nbs, acc_name, acc_iso,  
      acc_open, acc_amount, int_details, int_tt, mod_code )
  select /*+ ORDERED INDEX(a) INDEX(i)*/  
         a.kf, a.branch, d.dpu_id, d.nd, d.datz, d.rnk, i.id,  
         a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,  
         a.daos, null, null, 'DU%', 'DPU'  
    from BARS.DPU_DEAL d
    join BARS.ACCOUNTS a on ( a.acc = d.acc )
    join BARS.INT_ACCN i on ( i.acc = d.acc AND i.id = 1 )
    join BARS.TABVAL   t on ( t.kv  = a.kv  )
   where d.CLOSED = 0
     and d.datV   = l_datret;
  
  BARS.MAKE_INT( p_dat2      => l_acrdat
               , p_runmode   => 1
               , p_runid     => l_runid
               , p_intamount => l_amount
               , p_errflg    => l_errflg );
  
  -- �������� �������� ���������� ������������� �������� � ������
  bars.dpt_jobs_audit.p_finish_job( modcode, l_runid );
  
  dbms_application_info.set_module(NULL, NULL);
  dbms_application_info.set_client_info(NULL);
  
  bars_audit.trace( '%s exit.', title );
  
exception
  when TASK_ALREADY_RUNNING
  then
    null;
    
  when OTHERS
  then
    
    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()
                           ||chr(10)||dbms_utility.format_error_backtrace() );
    
    -- �������� ���������� ������������� �������� � �������� � ������
    dpt_jobs_audit.p_finish_job( modcode, l_runid, SubStr(dbms_utility.format_error_stack(), 1, 3000) );
    
    dbms_application_info.set_module(NULL, NULL);
    dbms_application_info.set_client_info(NULL);
    
    ROLLBACK;
    
end AUTO_MAKE_INT_FINALLY;

-- 
-- ����������� �������: 
-- ----------------------------------------------------------------------------
-- ���� (p_dpuid = 0)         - �� ������ �������� ��������
--      (p_bdate Is Null)     - �������� ����������� � ���� �����
--      (p_bdate Is Not Null) - ������� ����������� �� ������� ��������� ����
-- ----------------------------------------------------------------------------
-- ���� (p_dpuid > 0)         - �� �������� [p_dpuid] �� ���� [p_bdate]
-- ----------------------------------------------------------------------------
procedure AUTO_MAKE_INTEREST
( p_dpuid  in  dpu_deal.dpu_id%type,                       -- ������������� ���. ��������
  p_bdate  in  fdat.fdat%type                              -- ���� ����������� %% (��� p_dpuid > 0)
) is
  title        constant varchar2(60) := 'dpu.automakeinterest:';
  l_runid      dpu_jobs_jrnl.run_id%type;                  -- ������������� �������
  l_jobid      dpt_jobs_list.job_id%type;                  -- ������������� ��������
  l_bdate      date;                                       -- ��������� ����
  l_acrdate    date;                                       -- 
  l_datret     date;                                       -- ���� ���������� ��������
  l_amount     number;
  l_error      boolean;
  l_errmsg     sec_audit.rec_message%type;
begin
  
  bars_audit.trace( '%s p_bdate=%s, p_dpuid=%s', title, to_char(p_bdate,'dd.mm.yyyy'), to_char(p_dpuid) );

  if ( p_dpuid = 0 )
  then -- ����������� �� ������ ��������
    
    -- bars_audit.info( bars_msg.get_msg( modcode, 'AUTOMAKEINTMNTH_ENTRY' ) );
    bars_audit.info( '����� ����������� ������� �� ����������� �������� ��' );
    
    if (p_bdate is Null)
    then
      l_bdate := GL.GBD();
    else
      l_bdate := p_bdate;
    end if;
    
    if ( l_bdate = DAT_NEXT_U( last_day(l_bdate)+1, -1 ) )
    then -- ������� ������� ���� ����� (����������� %% �� ������ ��������)
      l_acrdate := last_day(l_bdate);
      l_datret  := null;
    else -- ������� ����������� %% �� ��������� ��������
      l_acrdate := l_bdate - 1;
      l_datret  := l_bdate;
    end if;
    
    l_errmsg := check_running_task('AUTO_MAKE_INTEREST');
    
    if (l_errmsg is Not Null)
    then
      bars_error.raise_nerror( modcode, 'TASK_ALREADY_RUNNING', l_errmsg );
    else
      dbms_application_info.set_module(MODCODE, 'AUTO_MAKE_INTEREST');
      dbms_application_info.set_client_info( 'Start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') || 'with p_bdate=' || to_char(p_bdate, 'dd.mm.yyyy') );
    end if;
    
    l_jobid := 277;
    
    -- �������� ������ ��������� ������������� �������� � ������ ���������
    dpt_jobs_audit.p_start_job( p_modcode => modcode,
                                p_jobid   => l_jobid,
                                p_branch  => sys_context('bars_context','user_branch'),
                                p_bdate   => l_bdate,
                                p_run_id  => l_runid );
  
    bars_audit.trace( '%s runid = %s', title, to_char(l_runid) );
    
    insert into INT_QUEUE
      ( KF, BRANCH, DEAL_ID, DEAL_NUM, DEAL_DAT, CUST_ID, INT_ID,
        ACC_ID, ACC_NUM, ACC_CUR, ACC_NBS, ACC_NAME, ACC_ISO,
        ACC_OPEN, ACC_AMOUNT, INT_DETAILS, INT_TT, MOD_CODE )
    select a.kf, a.branch, d.dpu_id, d.nd, d.datz, d.rnk, i.id,
           a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,
           a.daos, null, null, 'DU%', 'DPU'
      from DPU_DEAL      d
      join ACCOUNTS      a on ( a.ACC = d.ACC )
      join INT_ACCN      i on ( i.ACC = d.ACC and i.ID = 1 )
      join TABVAL$GLOBAL t on ( t.kv  = a.kv )
     where l_datret is Not Null -- �������
       and d.CLOSED = 0
       and nvl(d.DPU_ADD, 1) != 0
       and d.DATV = l_datret
       and lnnvl( i.acr_dat >= l_acrdate )
       and lnnvl( i.acr_dat >= i.stp_dat )
     union all
    select a.kf, a.branch, d.dpu_id, d.nd, d.datz, d.rnk, i.id,
           a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,
           a.daos, null, null, 'DU%', 'DPU'
      from DPU_DEAL      d
      join ACCOUNTS      a on ( a.ACC = d.ACC )
      join INT_ACCN      i on ( i.ACC = d.ACC and i.ID = 1 )
      join TABVAL$GLOBAL t on ( t.kv  = a.kv )
     where l_datret is Null     -- ��������
       and d.CLOSED = 0
       and nvl(d.DPU_ADD, 1) != 0
       and lnnvl( i.acr_dat >= l_acrdate )
       and lnnvl( i.acr_dat >= i.stp_dat  )
    ;
    
  else -- ��������� ����������� �������� 
    
    l_bdate   := nvl(p_bdate, GL.BD() );
    
    l_acrdate := l_bdate;
    
    insert into int_queue
      ( kf, branch, deal_id, deal_num, deal_dat, cust_id, int_id,
        acc_id, acc_num, acc_cur, acc_nbs, acc_name, acc_iso,
        acc_open, acc_amount, int_details, int_tt, mod_code )
    select a.kf, a.branch, d.dpu_id, d.nd, d.datz, d.rnk, i.id,
           a.acc, a.nls, a.kv, a.nbs, substr(a.nms, 1, 38), t.lcv,
           a.daos, null, null, 'DU%', 'DPU'
    from BARS.DPU_DEAL      d,
         BARS.ACCOUNTS      a,
         BARS.INT_ACCN      i,
         BARS.TABVAL$GLOBAL t
   where d.dpu_id = p_dpuid
     and d.acc = a.acc
     and d.acc = i.acc
     and i.id  = 1
     and a.kv  = t.kv
     and ( (i.acr_dat is null) or
           (i.acr_dat < l_acrdate and i.stp_dat is null) or
           (i.acr_dat < l_acrdate and i.stp_dat > i.acr_dat) );
    
  end if;
  
  make_int( p_dat2      => l_acrdate,  -- �������� ���� ����������� �������
            p_runmode   => 1,          -- ����� ������� (0 - �����������, 1 - ������)   
            p_runid     => l_runid,    -- ����� ������� (��� ����������� � DPU_JOBS_LIST)
            p_intamount => l_amount,   -- ���� ����������� �������
            p_errflg    => l_error);   -- ������ �������
  
  if ( p_dpuid = 0 )
  then
    
    -- �������� �������� ���������� ������������� �������� � ������
    dpt_jobs_audit.p_finish_job( modcode, l_runid );
    
    dbms_application_info.set_module(NULL, NULL);
    dbms_application_info.set_client_info(NULL);
    
    -- bars_audit.info( bars_msg.get_msg( 'DPT', 'AUTOMAKEINTMNTH_DONE' ) );
    bars_audit.info( '��������� ����������� ������� �� ����������� �������� ��' );    
    
    commit;
    
  else
    
    if l_error 
    then
      bars_error.raise_nerror( modcode, 'PAYOUT_ERR', title||sqlerrm );
    else
      bars_audit.trace( '%s ���������� ������� = %s', title, to_char(l_amount) );
    end if;
    
  end if;
  
exception
  when others then
    
    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()
                           ||chr(10)||dbms_utility.format_error_backtrace() );
    
    If ( p_dpuid = 0 AND l_runid is Not Null)
    Then
      -- �������� ���������� ������������� �������� � �������� � ������
      dpt_jobs_audit.p_finish_job( modcode, l_runid, SubStr( dbms_utility.format_error_stack(), 1, 3000 ) );
      
      dbms_application_info.set_module(NULL, NULL);
      dbms_application_info.set_client_info(NULL);
      
    Else
      -- ��������� ����������� ��� ������� ���������
      bars_error.raise_error( modcode, 999, SubStr( dbms_utility.format_error_stack(), 1, 254 ) );  
    End If;
    
    ROLLBACK;
    
end AUTO_MAKE_INTEREST;

--
-- ��������������� ���������� �������� ��
--
procedure AUTO_EXTENSION
( p_bdate  in   fdat.fdat%type )
is
  title         constant varchar2(60)      := 'dpu.auto_extension: ';
  l_runid       dpu_jobs_jrnl.run_id%type;    -- ������������� �������
  l_jobid       dpt_jobs_list.job_id%type;    -- ������������� ��������
  l_bdate       fdat.fdat%type;               -- ��������� ����
  l_mindatend   dpu_deal.dat_end%type;        -- ��������� ���������� ����
  l_maxdatend   dpu_deal.dat_end%type;        -- �������� ��������� ����
  l_errmsg      sec_audit.rec_message%type;   -- 
begin
  
  bars_audit.trace( '%s start with: p_bdate=>%s.', title, to_char(p_bdate,'dd.mm.yyyy') );
  
  l_errmsg := check_running_task('AUTO_EXTENSION');
  
  if (l_errmsg is Not Null)
  then
    bars_error.raise_nerror( modcode, 'TASK_ALREADY_RUNNING', l_errmsg );
  else
    dbms_application_info.set_module(MODCODE, 'AUTO_EXTENSION');
    dbms_application_info.set_client_info( 'Start at '||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') || 'with p_bdate=' || to_char(p_bdate, 'dd.mm.yyyy') );
  end if;
  
  -- ��������� ����
  if (p_bdate is Null) 
  then
    l_bdate := glb_bankdate;
  else
    l_bdate := p_bdate;
  end if;
  
  l_mindatend := dat_next_u(l_bdate, -1);
  l_maxdatend := l_bdate;

  l_jobid := 281;
  
  -- �������� ������ ��������� ������������� �������� � ������ ���������
  dpt_jobs_audit.p_start_job( p_modcode => modcode,
                              p_jobid   => l_jobid,
                              p_branch  => sys_context('bars_context','user_branch'),
                              p_bdate   => l_bdate,
                              p_run_id  => l_runid );
  
  for d in 
  ( select d.DPU_ID, d.ND as DPU_NUM, d.RNK as CUST_ID, d.BRANCH, d.DAT_BEGIN
         , a.NLS as ACC_NUM, a.KV as CUR_ID, a.OSTC, a.OSTB, a.BLKD
         , g.END_DATE, g.RATE
      from BARS.DPU_DEAL d
      join BARS.DPU_VIDD v
        on ( v.VIDD = d.VIDD )
      join BARS.ACCOUNTS a
        on ( a.ACC = d.ACC )
      join BARS.DPU_AGREEMENTS g
$if DPU_PARAMS.SBER
$then
        on ( g.DPU_ID = d.DPU_ID and g.BEGIN_DATE = d.DATV ) -- ��� ��������� ���� ���� ������� = ���� ����������
     where d.DATV    between l_mindatend and l_maxdatend
$else
        on ( g.DPU_ID = d.DPU_ID and g.BEGIN_DATE = d.DAT_END )
     where d.DAT_END between l_mindatend and l_maxdatend
$end
       and d.CLOSED = 0
       and v.FL_AUTOEXTEND = 0       -- ������� ��� ���� ��������
       and g.AGRMNT_TYPE   = 7       -- ������ �� ��� ��������
       and g.AGRMNT_STATE  = 1       -- ������� ��
       and g.DUE_DATE     <= l_bdate -- 
     UNION ALL
    select d.dpu_id, d.nd, d.rnk, d.branch, d.DAT_BEGIN
         , a.NLS as ACC_NUM, a.KV as CUR_ID, a.OSTC, a.OSTB, a.BLKD
         , null, null
      from BARS.DPU_DEAL d
      join BARS.DPU_VIDD v
        on ( v.VIDD = d.VIDD )
      join BARS.ACCOUNTS a
        on ( a.ACC = d.ACC )
     where d.DAT_END between l_mindatend and l_maxdatend
       and d.CLOSED = 0
       and v.FL_AUTOEXTEND = 1 -- ������� � ���� ���������
  )
  loop
    
    begin
      
      bars_audit.trace('%s deposit � %s (%s)', title, d.dpu_num, to_char(d.dpu_id));
      
      SAVEPOINT SP_EXTENSION;
      
      l_errmsg := null;
      
      case
        when ( CHECK_PENALIZATION( d.dpu_id, d.dat_begin ) > 0 )
        then -- �������� ������� ����������� ��������
          l_errmsg := '���������� ����������� �������� ���� �����������!';
        when ( d.OSTC = 0 )
        then
          l_errmsg := '���������� ����������� �������� � ��������� �������� ����� ����!';
        when ( d.OSTB = 0 )
        then
          l_errmsg := '���������� ����������� �������� � �������� �������� ����� ����!';
          -- l_errmsg := '���������� ����������� �������� � ��������� �������� ����� ����!';
        when ( d.BLKD != 0 )
        then -- ??? ������� ��������� �������� �� �������� ���������
          Null;
          -- l_errmsg := '���������� ����������� �������� � �������� �������� ����� ����!';
        else
          DEAL_PROLONGATION( p_bdat   => l_bdate
                           , p_dpuid  => d.dpu_id
                           , p_datend => d.END_DATE
                           , p_rate   => d.RATE );
      end case;
      
    exception
      when OTHERS then
        
        l_errmsg := SubStr(dbms_utility.format_error_stack(), 1, 3000);
        
        bars_audit.error( title||'������ ��� �������� ���.���. � '||d.dpu_num||'(#'||to_char(d.dpu_id)
                         ||') '||l_errmsg||chr(10)||dbms_utility.format_error_backtrace() );
                
        ROLLBACK TO SP_EXTENSION;
        
    end;
    
        dpt_jobs_audit.p_save2log( p_modcode => modcode
                                 , p_runid   => l_runid
                                 , p_dptid   => d.dpu_id
                                 , p_dealnum => d.dpu_num
                                 , p_branch  => d.branch
                                 , p_ref     => null -- l_int_ref
                                 , p_rnk     => d.CUST_ID
                                 , p_nls     => d.ACC_NUM
                                 , p_kv      => d.CUR_ID
                                 , p_dptsum  => null
                                 , p_intsum  => null -- l_int_amnt
                                 , p_status  => (case when l_errmsg is Not Null then -1 else 1 end)
                                 , p_errmsg  => l_errmsg
                                 , p_rateval => d.rate );
    
  end loop;
  
  -- �������� �������� ���������� ������������� �������� � ������
  dpt_jobs_audit.p_finish_job( modcode, l_runid );
  
  dbms_application_info.set_module(NULL, NULL);
  dbms_application_info.set_client_info(NULL);
  
  bars_audit.trace( '%s exit.', title );
  
exception
  when others then
    
    bars_audit.error( title||chr(10)||dbms_utility.format_error_stack()||dbms_utility.format_error_backtrace() );
    
    -- �������� ���������� ������������� �������� � �������� � ������
    dpt_jobs_audit.p_finish_job( modcode, l_runid, SubStr(dbms_utility.format_error_stack(), 1, 3000) );
    
    dbms_application_info.set_module(NULL, NULL);
    dbms_application_info.set_client_info(NULL);
    
    ROLLBACK;
    
end AUTO_EXTENSION;

--
--
--
function get_parameters
( p_dpuid    dpu_dealw.dpu_id%type,  -- ��. ����������� ��������
  p_tag      dpu_dealw.tag%type      -- ��� ����������� ���������
) return     dpu_dealw.value%type
is
  l_retval   dpu_dealw.value%type;
begin
  begin
    select value
      into l_retval
      from BARS.DPU_DEALW
     where dpu_id = p_dpuid
       and tag    = p_tag;
  exception
    when NO_DATA_FOUND then
      l_retval := null;
  end;
  
  RETURN l_retval;
  
end;

--
-- ���������� ���������� ��������� ��������
--
procedure set_parameters
( p_dpuid    in  dpu_dealw.dpu_id%type,  -- ��. ����������� ��������
  p_tag      in  dpu_dealw.tag%type,     -- ��� ����������� ���������
  p_value    in  dpu_dealw.value%type    -- �������� ����������� ���������
) is
begin
  
  bars_audit.trace( '%s.SET_PARAMETERS start with: DPU_ID = %s, TAG = %s, VALUE = %s.', 
                    modcode, to_char(p_dpuid), p_tag, p_value );
  
  If (p_value Is Null) 
  Then
    delete from BARS.DPU_DEALW
     where dpu_id = p_dpuid
       and tag    = p_tag;
  Else
    -- 
    begin
      insert into BARS.DPU_DEALW
        ( dpu_id, tag, value )
      values
        ( p_dpuid, p_tag, p_value );
    exception
      when DUP_VAL_ON_INDEX then
        update BARS.DPU_DEALW
           set value  = p_value
         where dpu_id = p_dpuid
           and tag    = p_tag;
    end;
    
  End If;
  
end set_parameters;

--
-- ���������� �������� �� ������� �������� �� ���������� ��������
--
procedure BLOCK_CONTRACT
( p_dpuid    in  dpu_deal.dpu_id%type,  -- ��. ����������� ��������
  p_nd       in  cc_deal.nd%type,       -- ��. ����������  �������� (���� NULL - ������������� ������)
  p_errmsg  out  varchar2               -- ����������� ��� ������� ��� NULL
) is
  l_genid        dpu_deal.dpu_gen%type;
  l_datend       dpu_deal.dat_end%type;
  l_amount       dpu_deal.sum%type;
  l_wdate        cc_deal.wdate%type;
  l_acc          accounts.acc%type;
  l_kv           accounts.kv%type;
  l_ostc         accounts.ostc%type;
  l_lim          accounts.lim%type;
  l_blk          accounts.blkd%type;
  l_ost_CRD      accounts.ostc%type;
  
  ERRORS         exception;

begin
  
  bars_audit.trace( '%s.BLOCK_CONTRACT start with: dpu_id = %s, nd = %s.', 
                    modcode, to_char(p_dpuid), nvl(to_char(p_nd),'null') );
  
  -- ��� ���������� �������� �� ������� ��� �� ��������� � �������
  If (p_nd > 0) Then
    
    p_errmsg := dpu.get_parameters( p_dpuid, 'IS_PLEDGE' );
    
    If (p_errmsg Is Not Null) 
    Then    
      p_errmsg := '���������� ������ '|| to_char(p_dpuid) ||' � �������� �� ������� #'|| p_errmsg;
      raise ERRORS;
    End If;
    
  End If;
  
  begin
    select d.acc, d.dat_end, d.dpu_gen, d.sum, a.ostc, a.kv
      into l_acc,  l_datend,   l_genid, l_amount, l_ostc, l_kv
      from BARS.DPU_DEAL d,
           BARS.ACCOUNTS a
     where d.dpu_id = p_dpuid
       and d.closed = 0
       and nvl(d.DPU_ADD,1) > 0  -- ������� ��� ����� �� 
       and a.acc = d.acc
       and a.dazs is null;
     
    bars_audit.trace( '%s.BLOCK_CONTRACT DPT acc = %s, dat_end = %s, dpu_gen = %s, ostc = %s, kv = %s.',
                      modcode, to_char(l_acc), to_char(l_datend,'dd.mm.yyyy'), to_char(l_genid), to_char(l_ostc), to_char(l_kv) );
    
  exception
    when NO_DATA_FOUND then
      p_errmsg := '���������� ������ #'|| to_char(p_dpuid) ||' �� ����, �������� ��� � ���!';
      raise ERRORS;
  end;
    
  If (p_nd > 0) 
  Then
    -- ���������� ��������
    l_blk := 101;
    
    -- ����� ���������� ��������
    begin
      
      select d.wdate, Sum(a.ostc)
        into l_wdate, l_ost_CRD
        from BARS.CC_DEAL  d,
             BARS.ACCOUNTS a,
             BARS.ND_ACC   n
       where d.nd  = p_nd
         and d.sos in ( 10, 11, 13 )
         and n.nd  = d.nd
         and n.acc = a.acc 
         and a.tip = 'SS '
         and a.nls like '2%'
         and a.kv = l_kv
         and a.dazs is null
       group by d.wdate;
      
      bars_audit.trace( '%s.BLOCK_CONTRACT CRD wdate = %s, ostc = %s/%s.',
                        modcode, to_char(l_wdate,'dd.mm.yyyy'), to_char(l_ost_CRD), to_char(l_kv) );
      
    exception
      when NO_DATA_FOUND then
        begin
          
          select o.DATD2, a.LIM
            into l_wdate, l_ost_CRD
            from ACC_OVER o
           inner join ACCOUNTS a on ( a.acc = o.acc )
           where o.ACC = o.acco
             and o.ND  = p_nd
             and o.DATD2 > GL.BD()
             and a.KV = l_kv
             and a.DAZS is null;
          
          bars_audit.trace( '%s.BLOCK_CONTRACT OVR wdate = %s, ostc = %s/%s.',
                            modcode, to_char(l_wdate,'dd.mm.yyyy'), to_char(l_ost_CRD), to_char(l_kv) );
          
        exception
          when NO_DATA_FOUND then
            p_errmsg := '�� �������� ��� �������� ������ ���������� �������� #'|| to_char(p_nd) ||' � ����� ��������!';
            raise ERRORS;
        end;
    end;
    
    -- ���� ���� ���t������ ����.���. ����� �� ���� ���������� ���.���.
    If (l_wdate > l_datend)
    Then
      p_errmsg := '���� ���������� ���������� �������� '|| to_char(l_wdate , 'dd.mm.yyyy') ||
                  ' ����� �� ���� ���������� �������� '|| to_char(l_datend, 'dd.mm.yyyy') ;
      raise ERRORS;
    End If;
    
  Else
    -- ������������� ��������
    l_blk := 0;
  End if;

  -- ����������/������������� ������� �������� / ������ ���.��    
  update BARS.ACCOUNTS 
     set BLKD = l_blk
   where ACC  = l_acc;
  
  If (p_nd > 0)
  Then
    accreg.setAccountSob( l_acc, null, gl.aUID, GL.BD(), '����������� -> ������� �� ���������� �������� #'||to_char(p_nd) );
  Else
    accreg.setAccountSob( l_acc, null, gl.aUID, GL.BD(), '������������ -> ���������� �������� '||to_char(p_dpuid)||' ����� �� � ��������' );
    l_ostc := -l_ostc;
  End if;
  
  -- ��� ���������� ���
  If (l_genid is Not Null) 
  then
    
    -- ����� ���. ���. ���. (��)
    select   acc
      into l_acc
      from BARS.DPU_DEAL
     where dpu_id = l_genid;
    
    -- ������������/������ ��������������� ������� �� ���.�� � ��� ������
    update BARS.ACCOUNTS 
       set LIM = (LIM - l_ostc)
     where ACC = l_acc
       and DAZS is null
 returning LIM 
      into l_lim;
    
    bars_audit.trace( '%s.BLOCK_CONTRACT account (#%s) new limit = %s.', modcode, to_char(l_acc), to_char(l_lim) );
    
    If (p_nd > 0) 
    Then
      accreg.setAccountSob( l_acc, null, gl.aUID, GL.BD(), '�������������� ������� -> ������� �� ���������� �������� #' ||
                             to_char(p_nd) || ' � ��� ' || to_char((l_ostc/100),'FM999999990D00') );
    Else
      accreg.setAccountSob( l_acc, null, gl.aUID, GL.BD(), '���������� �������� '||to_char(p_dpuid)||' � ��� '||
                            to_char((l_ostc/-100),'FM999999990D00')||' ����� �� � ��������' );
    End If;
    
  End If;
  
  -- �������� ��.������� � ���������� ��������
  dpu.set_parameters( p_dpuid, 'IS_PLEDGE', to_char(p_nd) );
  
  bars_audit.trace( '%s.BLOCK_CONTRACT exit with: blkd = %s.', modcode, to_char(l_blk) );
  
exception
  when ERRORS then 
    null;
  when OTHERS then
    p_errmsg := sqlerrm || dbms_utility.format_error_backtrace();
end BLOCK_CONTRACT;


---
-- ��������� ���������� ����� �� ������� �������� ���������� � �������
---
procedure REPAYMENT_PLEDGE
( p_dpuid    in   dpu_deal.dpu_id%type,  -- ��. ����������� ��������
  p_errmsg  out   varchar2               -- ����������� ��� ������� ��� NULL
) is              
  l_errflg        boolean;
  l_errmsg        varchar2(2000);  
  l_mfo           banks.mfo%type  := GL.KF();
  l_bdate         fdat.fdat%type  := GL.BD();
  -----
  l_ref           oper.ref%type;
  l_amount        oper.s%type;
  l_dpu_row       dpu_deal%rowtype;
  l_dpu_cur       accounts.kv%type;      -- ������ ��������
  l_acc_int       accounts.acc%type;
  l_acr_dat       int_accn.acr_dat%type; -- 
  -----           
  l_crd_prod      varchar2(3);           -- ��� ���������� �������� (������ / ���������)
  l_nd            cc_deal.nd%type;       -- ��. �������� ���������� ��������
  l_crd_num       cc_deal.cc_id%type;    -- ����� ����.���.
  l_crd_dat       cc_deal.sdate%type;    -- ���� ���������� ����.���.
  l_crd_acc       accounts.acc%type;
  l_crd_nls       accounts.nls%type;
  l_crd_kv        accounts.kv%type;
  l_crd_nms       accounts.nms%type;
  l_crd_sum       accounts.ostc%type;
  -----           
  l_nTmp          number;
  l_sTmp          varchar2(3000);
  l_penya         number(38);
  l_intpay        number(38);
  l_dptpay        number(38);
  -----
  l_tax_inc_ret   number(38);
  l_tax_mil_ret   number(38);
  l_tax_inc_pay   number(38);
  l_tax_mil_pay   number(38);
begin
  
  bars_audit.trace( '%s.REPAYMENT_PLEDGE start with: dpu_id = %s.', modcode, to_char(p_dpuid) );
  
  l_crd_sum := 0;
  
  l_nd      := to_number(nvl(dpu.get_parameters( p_dpuid, 'IS_PLEDGE' ),'0'));
  
  if ( l_nd > 0) then
    
    -- ����� ����������� ��������
    begin
      
      select d.*
        into l_dpu_row
        from dpu_deal d
       where d.dpu_id = p_dpuid
         and d.closed = 0;
         
      select a.kv, i.acrA
        into l_dpu_cur, l_acc_int
        from ACCOUNTS a
        join INT_ACCN i on (i.acc = a.acc and i.id = 1)
       where a.acc = l_dpu_row.acc;
      
    exception
      when NO_DATA_FOUND then
        raise_application_error( -20203, '�� �������� ��� �������� ���������� ������ #'|| to_char(p_dpuid), TRUE );
    end;
    
    -- ����� ���������� ��������
    begin
      
      select 'CRD',      c.cc_id,   c.sdate
        into l_crd_prod, l_crd_num, l_crd_dat
        from BARS.CC_DEAL c
       where c.nd = l_nd
         and c.sos < 14;
      
      bars_audit.trace( '%s.REPAYMENT_PLEDGE: �������� ��������� ������ � %s �� %s.', modcode, l_crd_num, to_char(l_crd_dat,'dd.mm.yyyy') );
            
      For k in ( select a.TIP, a.ACC, a.NLS, a.KV, a.NMS, a.OSTB
                   from ACCOUNTS a
                  where a.ACC in ( select n.acc from ND_ACC n where n.nd = l_nd )
                    and a.TIP in ('SG', 'SS', 'SN', 'SP', 'SPN')
                    and a.dazs is null )
      Loop
        
        If (k.TIP in ('SS', 'SN', 'SP', 'SPN'))
        Then
          
          -- ���� ����� �� ��������� ��������
          l_crd_sum := l_crd_sum + k.OSTB;
          
          -- ���������� �� ����������� �� %% �� ����.���.
          select case
                   when EXISTS( select 1 from INT_ACCN i
                                 where i.acc = k.ACC
                                   and i.id  = 0 -- in ( 0, 2 )
                                   and i.acr_dat < (l_bdate-1) ) 
                   then c_endline || '�������������� %% �� ���.� ' || k.NLS
                   else ''
                 end
            into l_sTmp
            from dual;
          
          l_errmsg := l_errmsg || l_sTmp;
          
        Else -- k.TIP = 'SG'
          
          If (k.KV = l_dpu_cur)
          Then
            -- ������� ��������� ����� � ����� ��������
            l_crd_acc := k.ACC;
            l_crd_nls := k.NLS;
            l_crd_kv  := k.KV;
            l_crd_nms := k.NMS;
          End If;
          
        End If;
        
      End Loop;
      
      If (l_errmsg is null) 
      Then         
        bars_audit.trace( '%s.REPAYMENT_PLEDGE: ���� ����� �� ���������� �������� # %s ��������� %s.', modcode, to_char(l_nd), to_char(l_crd_sum) );
      Else        
        raise_application_error( -20203, l_errmsg, TRUE );        
      End if;
      
    EXCEPTION
      when NO_DATA_FOUND then
        
        raise_application_error( -20203, '�� �������� ��� �������� ������ ������� #'|| to_char(l_nd), TRUE );
        
        -- ����� �������� ����������
        -- begin
        --   
        --   select 'OVR', o.ndoc, o.datd , a.acc, a.nls, a.kv, a.nms
        --     into l_crd_prod, l_crd_num, l_crd_dat, l_crd_acc, l_crd_nls, l_crd_kv, l_crd_nms
        --     from ACC_OVER o
        --     join ACCOUNTS a on ( a.acc = o.acc )
        --    where o.ND  = l_nd
        --      and o.acc = o.acco
        --      and a.dazs is Null;
        --   
        --   bars_audit.trace( '%s.REPAYMENT_PLEDGE: �������� ������ ���������� � %s �� %s (���� ����� = %s).', 
        --                     modcode, l_crd_num, to_char(l_crd_dat,'dd.mm.yyyy'), to_char(l_crd_sum) );
        --   
        --   -- ����� ���� ������������� ����� 
        --   select sum(a.OSTB)
        --     into l_crd_sum
        --     from OVR_ACCOUNTS oa
        --     join ACCOUNTS      a on (a.acc = oa.accid)
        --    where oa.OVRID = l_nd
        --      and a.NBS in ('2063','2068')
        --      and a.TIP in ( 'SP ','SPN' )
        --      and a.DAZS is Null;
        --   
        --   bars_audit.trace( '%s.REPAYMENT_PLEDGE: ���� ����� �� �������� ���������� # %s ��������� %s.', modcode, to_char(l_nd), to_char(l_crd_sum) );
        --  
        -- exception
        --   when NO_DATA_FOUND then
        --     raise_application_error( -20203, '�� �������� ��� �������� ������ ������� / ���������� #'|| to_char(l_nd), TRUE );
        -- end;
    end;
    
  else
    raise_application_error( -20203, '���������� ������ #'|| to_char(p_dpuid) ||' �� � ��������!', TRUE );
  end if;  
  
  if (l_crd_sum < 0)
  then
    l_crd_sum := abs(l_crd_sum);
  else
    raise_application_error( -20203, '³������ ������������� �� ���������� �������� #' || to_char(l_nd), TRUE );
  end if;
  
  -- ������������� ��������
  BLOCK_CONTRACT( p_dpuid  => p_dpuid,
                  p_nd     => null,
                  p_errmsg => l_errmsg);
  
  If (l_errmsg is null) 
  then
    bars_audit.trace( '%s.REPAYMENT_PLEDGE: ����� ���������� � ��������.', modcode, to_char(p_dpuid) );
  else
    raise_application_error( -20203, l_errmsg, TRUE );
  end if;
  
  -- ���� ���������� ������ �� �� ���������� 
  If (l_dpu_row.dat_end > l_bdate) 
  Then
    
    -- ������������� %% (�� �����������)
    If (l_acr_dat < (l_bdate - 1))
    Then
      DPU.AUTO_MAKE_INTEREST( p_dpuid, (l_bdate - 1) );
    End If;
    
    -- ���������� ���� ������ ��� ����������� ��������� ��������
    get_penalty_ex( p_dpuid        => p_dpuid,        -- �������� ����������� ��������
                    p_bdate        => l_bdate,        -- ���� ���������� ����������� 
                    p_totalint_nom => l_nTmp,         -- ����� ����������� %% (���) �� ������ ��������
                    p_totalint_eqv => l_nTmp,         -- ����� ����������� %% (���) �� ������ ��������
                    p_penyaint_nom => l_penya,        -- ����� ����������� %% (���) �� �������� ������
                    p_penyaint_eqv => l_nTmp,         -- ����� ����������� %% (���) �� �������� ������
                    p_intpay_nom   => l_intpay,       -- ����� ������ (���) ��� �������� � ����������� �����
                    p_intpay_eqv   => l_nTmp,         -- ����� ������ (���) ��� �������� � ����������� �����
                    p_dptpay_nom   => l_dptpay,       -- ����� ������ (���) ��� �������� � ����������� �����
                    p_dptpay_eqv   => l_nTmp,         -- ����� ������ (���) ��� �������� � ����������� �����
                    p_penya_rate   => l_nTmp,         -- ������� ������ 
                    p_tax_inc_ret  => l_tax_inc_ret,  -- ���� ���������� ���������� ������� �� �������� � ��
                    p_tax_mil_ret  => l_tax_mil_ret,  -- ���� ���������� ���������� ���������� �����   � ��
                    p_tax_inc_pay  => l_tax_inc_pay,  -- ���� ��������� ������� �� �������� � ��
                    p_tax_mil_pay  => l_tax_mil_pay,  -- ���� ��������� ���������� �����   � ��
                    p_details      => l_sTmp );       -- ����������� ������� ������
    
    bars_audit.trace( '%s.REPAYMENT_PLEDGE: %s', modcode, l_sTmp );
    
    -- ��������� ������ ��� ������������ �������� ��������
    PENALTY_PAYMENT( p_dpuid       => p_dpuid,
                     p_penalty     => (l_intpay + l_dptpay),   -- ���� ������ � �������
                     p_int_pay     => 0, -- l_penya,
                     p_tax_inc_ret => (l_tax_inc_ret - l_tax_inc_pay),
                     p_tax_mil_ret => (l_tax_mil_ret - l_tax_mil_pay),
                     p_tax_inc_pay => 0,
                     p_tax_mil_pay => 0 );
    
    bars_audit.trace( '%s.REPAYMENT_PLEDGE: �������� ����� � �������� � ��� %s.', modcode, to_char(l_intpay + l_dptpay) );
    
  End If;
  
  -- ������� �� ������� �����. ������� (���� �����������)
  begin
    
    select ostb 
      into l_amount
      from accounts 
     where acc = l_acc_int
       for update of ostb nowait;
    
    bars_audit.trace('%s.REPAYMENT_PLEDGE acc_int=%s, amount=%s', modcode, to_char(l_acc_int), to_char(l_amount));
    
  exception
    when others then
      l_errflg := true;
      l_errmsg := substr('������ ���������� ����� '||to_char(l_acc_int)||': '||sqlerrm, 1, 2000);
  end;
  
  -- ������� ������� 
  If (l_amount > 0) 
  Then
    
    l_ref := null;
        
    PAY_DOC_EXT( p_dpuid  => p_dpuid,
                 p_bdat   => l_bdate,
                 p_acc_A  => l_acc_int,
                 p_mfo_B  => l_mfo,         -- l_dpu_row.MFO_P,
                 p_nls_B  => l_crd_nls,     -- l_dpu_row.NLS_P,
                 p_nms_B  => l_crd_nms,     -- l_dpu_row.NMS_P,
                 p_okpo_B => null,          -- l_dpu_row.OKPO_P,
                 p_sum    => l_amount,
                 p_nazn   => SubStr('³������ �� �������� ����� '||F_NAZN('U', p_dpuid), 1, 160),
                 p_ref    => l_ref );
    
    gl.pay(2, l_ref, l_bdate);
    
  End if;
  
  -- ������� �� ����������� ������� (���� �����������)
  begin
    
    select ostb 
      into l_amount
      from accounts 
     where acc = l_dpu_row.acc
       for update of ostb nowait;
    
    bars_audit.trace('%s.REPAYMENT_PLEDGE acc_dep=%s, amount=%s.', modcode, to_char(l_dpu_row.acc), to_char(l_amount));
    
  exception
    when others then
      l_errflg := true;
      l_errmsg := SubStr('������� ���������� ������� #'||to_char(l_dpu_row.acc)||': '||sqlerrm, 1, 2000);
  end;
  
  /* --------------------------------------------- */
  begin 
    
    select LIM
      into l_nTmp
      from BARS.DPU_DEAL d,
           BARS.ACCOUNTS a
     where d.dpu_id = l_dpu_row.dpu_gen
       and d.acc = a.acc;
    
    bars_audit.trace( '%s.REPAYMENT_PLEDGE: gen_id = %s, gen_acc_lim = %s.', modcode, to_char(l_dpu_row.dpu_gen), to_char(l_nTmp) );    
    
  exception
    when NO_DATA_FOUND then
      null;
  end;
  /* --------------------------------------------- */
  -- ������� ��������
  if (l_amount > 0) 
  then
    
    l_ref := null;
    
    PAY_DOC_EXT( p_dpuid   => p_dpuid,
                 p_bdat    => l_bdate,
                 p_acc_A   => l_dpu_row.acc,
                 p_mfo_B   => l_mfo,
                 p_nls_B   => l_crd_nls,
                 p_nms_B   => l_crd_nms,
                 p_okpo_B  => null,
                 p_sum     => l_amount,   -- least(l_crd_sum, l_amount),
                 p_nazn    => '������������� ����� ��� ��������� �����`������ �� ���������� �������� � ___ �� ' || to_char(l_crd_dat,'dd.mm.yyyy'), -- SubStr('���������� �������� ����� '||F_NAZN('U', p_dpuid), 1, 160),
                 p_ref     => l_ref );
    
    gl.pay(2, l_ref, l_bdate);
    
  end if;
  
  -- ���� ������ �� ��������� ��������� ������� ���������
  If (l_crd_prod = 'CRD') 
  Then
    
    CCK.CC_ASG( -l_nd );
    
    bars_audit.trace( '%s.REPAYMENT_PLEDGE: �������� ��������� ������� ��������� ����.���.#%s.', modcode, to_char(l_nd) );
    
  Else
    
    OVR.P_OVR8z( 33, l_crd_acc );
    
    bars_audit.trace( '%s.REPAYMENT_PLEDGE: �������� ��������� ������������� �� ���.�����.#%s.', modcode, to_char(l_nd) );
    
  End If;
  
  p_errmsg := l_errmsg;
  
exception
  when OTHERS then
    
    if (l_errmsg is Null)
    then
      p_errmsg := sqlerrm || dbms_utility.format_error_backtrace();
      -- bars_audit.error( dbms_utility.format_error_stack()||chr(10)|| dbms_utility.format_error_backtrace() );
    else
      p_errmsg := l_errmsg;
    end if;
    
end repayment_pledge;


--
-- �������� �������� ����� ����������� �������� � ��������� �����
--
function CHECK_PENALIZATION
( p_dpu_id     dpu_deal.dpu_id%type
, p_begin_dt   dpu_deal.dat_begin%type
) return number
is
  /**
  <b>CHECK_PENALIZATION</b> - �-� �������� �������� ����� ����������� �������� � ��������� �����
  %param p_dpu_id   - ������������� ����������� ��������
  %param p_begin_dt - ���� ������� 䳿 ����������� ��������
  
  %version 1.0
  %usage   ���������� �������� �������� ��������� ������ � ��������
  */
  title    constant  varchar2(60) := 'dpu.check_penalization';
  l_retval           number;
  l_date             date;
begin
  
  bars_audit.trace( '%s: entry with (p_dpu_id=%s, p_begin_dt=%s).', 
                    title, to_char(p_dpu_id), to_char(p_begin_dt,'dd/mm/yyyy') );
  
  if ( nvl(p_dpu_id,0) = 0 )
  then
    bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '³����� �������� ������� ���������!' );
  end if;
  
  l_date := greatest( trunc(SYSDATE), GL.BD() );
  
  if ( p_begin_dt is Null )
  then
    select count( o.REF )
      into l_retval
      from BARS.DPU_DEAL d
      join BARS.DPU_ACCOUNTS da on ( da.DPUID  =  d.DPU_ID )
      join BARS.DPU_PAYMENTS dp on ( dp.DPU_ID =  d.DPU_ID )
      join BARS.OPER   o        on (  o.REF    = dp.REF    )
      join BARS.OPLDOK t        on (  t.REF    = dp.REF AND t.ACC = da.ACCID )
     where d.DPU_ID = p_dpu_id
       and o.TT IN ( 'DUS', 'DUT' )
       and t.FDAT between d.DAT_BEGIN and l_date
       and t.DK = 0
       and t.SOS > 0;
  else
    select count( o.REF )
      into l_retval
      from BARS.OPLDOK t
      join BARS.OPER   o        on (  o.REF    = t.REF )
      join BARS.DPU_ACCOUNTS da on ( da.ACCID  = t.ACC )
      join BARS.DPU_PAYMENTS dp on ( dp.DPU_ID = da.DPUID AND dp.REF = t.REF )  
     where dp.DPU_ID = p_dpu_id
       and o.TT IN ( 'DUS', 'DUT' )
       and t.FDAT between p_begin_dt AND l_date
       and t.DK = 0 
       and t.SOS > 0;
  end if;
  
  bars_audit.trace( '%s: exit with %s.', title, to_char(l_retval) );
  
  RETURN l_retval;
  
end CHECK_PENALIZATION;

BEGIN
  NULL;
END DPU;
/

show err

-- exec sys.utl_recomp.recomp_serial('BARS');

grant EXECUTE on DPU to BARS_ACCESS_DEFROLE;
