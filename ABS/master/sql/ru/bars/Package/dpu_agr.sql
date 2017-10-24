
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/dpu_agr.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DPU_AGR 
is
  g_header_version  constant varchar2(64)  := 'version 1.03 09.12.2015';
  g_header_awk_defs constant varchar2(512) := '';

  --
  -- types
  --
  type r_tax_nls_type is record ( acc_id   accounts.acc%type,
                                  acc_num  accounts.nls%type );

  --
  -- ������� ������� (����� ������)
  --
  function header_version return varchar2;
  function body_version   return varchar2;


  --
  -- ��������� ��������� �����
  --
  --   p_dpu_id      - ��. ����������� ��������
  --   p_agrmnt_type - ��� ��
  --   p_agrmnt_num  - ���������� ����� ��
  --   p_amount      - ���� ��������
  --   p_rate        - ��������� ������
  --   p_freq        - ����������� ������� �������
  --   p_begin_date  - ���� �������
  --   p_end_date    - ���� ����������
  --   p_stop_id     - ��. ������
  --   p_agrmnt_id   - ��. ��������� �����
  --
  procedure create_agreement
  ( p_dpu_id       in   dpu_agreements.dpu_id%type,
    p_agrmnt_type  in   dpu_agreements.agrmnt_type%type,
    p_agrmnt_num   in   dpu_agreements.agrmnt_num%type,
    p_due_date     in   dpu_agreements.due_date%type,
    p_amount       in   dpu_agreements.amount%type,
    p_rate         in   dpu_agreements.rate%type,
    p_freq         in   dpu_agreements.freq%type,
    p_begin_date   in   dpu_agreements.begin_date%type,
    p_end_date     in   dpu_agreements.end_date%type,
    p_stop_id      in   dpu_agreements.stop_id%type,
    p_payment_dtl  in   dpu_agreements.payment_details%type,
    p_agrmnt_id    out  dpu_agreements.agrmnt_id%type
  );


  --
  -- ���������� ��������� ��
  --
  --   p_agrmnt_id - ������������� ��������� �����
  --
  procedure confirm_agreement
  ( p_agrmnt_id    in   dpu_agreements.agrmnt_id%type
  );


  --
  -- ³����� � ��������� ��
  --
  --   p_agrmnt_id - ������������� ��������� �����
  --   p_comment   - �������� (������� ������)
  --
  procedure refuse_agreement
  ( p_agrmnt_id    in   dpu_agreements.agrmnt_id%type
  , p_comment      in   dpu_agreements.comments%type
  );

  --
  -- ���������� ���������� ����
  --   p_agrmnt_id - ������������� ��������� �����
  --   p_dpu_id �  - ������������ ����������� ��������
  --
  procedure revoke_agreement
  ( p_agrmnt_id    in   dpu_agreements.agrmnt_id%type
  , p_dpu_id       in   dpu_agreements.dpu_id%type
  );


end DPU_AGR;
/
CREATE OR REPLACE PACKAGE BODY BARS.DPU_AGR 
is
  --
  -- constants
  --
  g_body_version             constant varchar2(64)  := 'version 1.05 09.12.2015';
  modcode                    constant varchar2(3)   := 'DPU';

  --
  -- types
  --

  --
  -- variables
  --
  l_mfo                      varchar2(6);
  l_baseval                  number(3);  -- tabval$global%type;

  --
  -- ������� ����� ��������� ������
  --
  function header_version
    return varchar2
  is
  begin
    return 'Package DPU_AGR header '||g_header_version||'.'||chr(10)||
           'AWK definition: '||chr(10)||g_header_awk_defs;
  end header_version;

  --
  -- ������� ����� ��� ������
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package DPU_AGR body ' || g_body_version || '.';
  end body_version;

  --
  -- ��������� ��������� �����
  --
  procedure create_agreement
  ( p_dpu_id       in   dpu_agreements.dpu_id%type,
    p_agrmnt_type  in   dpu_agreements.agrmnt_type%type,
    p_agrmnt_num   in   dpu_agreements.agrmnt_num%type,
    p_due_date     in   dpu_agreements.due_date%type, -- not null
    p_amount       in   dpu_agreements.amount%type,
    p_rate         in   dpu_agreements.rate%type,
    p_freq         in   dpu_agreements.freq%type,
    p_begin_date   in   dpu_agreements.begin_date%type,
    p_end_date     in   dpu_agreements.end_date%type,
    p_stop_id      in   dpu_agreements.stop_id%type,
    p_payment_dtl  in   dpu_agreements.payment_details%type,
    p_agrmnt_id    out  dpu_agreements.agrmnt_id%type
  ) is
    title     constant  varchar2(60) := 'dpu_agr.create_agreement';
    l_bdate             dpu_agreements.agrmnt_bdate%type  := gl.bdate;
    l_userid            dpu_agreements.agrmnt_cruser%type := gl.auid;
    l_active            dpu_agreement_types.active%type;
    l_confirm           dpu_agreement_types.confirm%type;
  begin

    bars_audit.trace( '%s: entry.', title );

    begin
      select t.ACTIVE, t.CONFIRM
        into l_active, l_confirm
        from BARS.DPU_AGREEMENT_TYPES t
       where t.ID = p_agrmnt_type;
    exception
      when NO_DATA_FOUND then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�������� ��������� ��� �� � � ' || to_char(p_agrmnt_type) );
    end;

    If ( l_active = 0 )
    Then -- �������� ��� �� �� ��������
      bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�������� ��� �� � ' || to_char(p_agrmnt_type) || ' �� ��������!' );
    Else

      case
        when ( p_agrmnt_type = 5 )
        then -- �� ��� ���� ������ ��������
          -- �������� �� ����� �� ��� ����������� ����� �������� ������
          null;
        when ( p_agrmnt_type = 7 )
        then -- �� ��� ����������� ��������

          if ( p_begin_date Is Null OR p_end_date Is Null )
          then -- �������� ��� (������� �� ���������� 䳿 �������� ���� �����������)
            bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '��� �� � ' || to_char(p_agrmnt_type) || ' �� �������: ' ||
                                     case when p_end_date Is Null
                                     then '���� ���� ������� 䳿 ��������!'
                                     else '���� ���� ���������� 䳿 ��������!' end );
          end if;

        else
          null;
      end case;

    End If;

    begin

      insert into BARS.DPU_AGREEMENTS
        ( AGRMNT_TYPE, AGRMNT_NUM, AGRMNT_STATE, AGRMNT_BDATE, AGRMNT_CRDATE, AGRMNT_CRUSER,
          DPU_ID, DUE_DATE, AMOUNT, RATE, FREQ, BEGIN_DATE, END_DATE, STOP_ID, PAYMENT_DETAILS )
      values
        ( p_agrmnt_type, p_agrmnt_num, 0, l_bdate, sysdate, l_userid,
          p_dpu_id, p_due_date, p_amount, p_rate, p_freq, p_begin_date, p_end_date, p_stop_id, p_payment_dtl )
      returning AGRMNT_ID
           into p_agrmnt_id;

    exception
      when OTHERS then

        bars_audit.trace( '%s exit with ERROR: %s', title,
$if dbms_db_version.version >= 10
$then
                          dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace() );
$else
                          SQLERRM ); --  ��� ���. ����� 10
$end

        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '������� ��������� ��: ' || SQLERRM );

    end;

    If ( l_confirm = 1 )
    Then -- ���� ��� �� ��������� ����������
      null;
    Else

      dbms_application_info.set_module( modcode, 'CREATE_AGREEMENT' );

      dbms_application_info.set_client_info( dbms_transaction.LOCAL_TRANSACTION_ID );

      confirm_agreement( p_agrmnt_id );

    End If;

    bars_audit.trace( '%s: exit with %s.', title, to_char(p_agrmnt_id) );

  end create_agreement;

  --
  -- ���������� ��������� ��
  --
  procedure confirm_agreement
  ( p_agrmnt_id    in   dpu_agreements.agrmnt_id%type
  ) is
    title     constant  varchar2(60) := 'dpu_agr.confirm_agreement';
    l_userid            dpu_agreements.agrmnt_prcuser%type    := gl.auid;
    r_agrmnt            dpu_agreements%rowtype;
    r_dpu               dpu_deal%rowtype;
    l_dataxml           XMLTYPE;
    ---
    l_ref               oper.ref%type;
    l_msg               varchar2(1000);
    ---
    function get_data_from_xml
    ( p_node varchar2
    ) return varchar2
    is
      l_value varchar2(38);
    begin

      IF (l_dataxml.extract(p_node) IS Not Null)
      THEN
        l_value := l_dataxml.extract(p_node).getStringVal();
      ELSE
        l_value := Null;
      END IF;

      RETURN l_value;

    end get_data_from_xml;
    ---
    -- ������� ������ ����������� �������� ��
    -- ������� !!!!
    --  ������ ���� ��������� ���� ���� ������������ � �������� ���� ��
    --  ����� ��������� ��������� �� ����� ��� �� �������.
    ---
    function get_confirm_flag
    ( p_agrmnt_type   dpu_agreement_types.id%type
    ) return signtype
    is
      l_confirm       dpu_agreement_types.confirm%type;
    begin

      begin
        select t.CONFIRM
          into l_confirm
          from BARS.DPU_AGREEMENT_TYPES t
         where t.ID = p_agrmnt_type;
      exception
        when NO_DATA_FOUND then
          l_confirm := -1;
      end;

      RETURN l_confirm;

    end get_confirm_flag;
    ---
  begin

    bars_audit.trace( '%s: entry with %s.', title, to_char(p_agrmnt_id) );

    begin
      select *
        into r_agrmnt
        from BARS.DPU_AGREEMENTS
       where AGRMNT_ID = p_agrmnt_id;
    exception
      when NO_DATA_FOUND then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�� �������� �� � ��������������� # ' || to_char(p_agrmnt_id) );
    end;

    -- ��������
    Case
      When ( r_agrmnt.AGRMNT_STATE = 1 )
      Then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�� � ��������������� # ' || to_char(p_agrmnt_id) || ' ��� �����������!' );

      When ( r_agrmnt.AGRMNT_CRUSER = l_userid AND get_confirm_flag(r_agrmnt.AGRMNT_TYPE) = 1 )
      Then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '����������� ���� ��� �� ���������� �� ��������!' );

      When ( r_agrmnt.AGRMNT_CRUSER = l_userid AND nvl(dbms_transaction.LOCAL_TRANSACTION_ID,'AAA') <> nvl(sys_context('userenv','client_info'),'XXX') )
      Then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '����������, �� ������� �� ���� ����� �� �� ��������!' );

      Else
        dbms_application_info.set_module( modcode, 'CONFIRM_AGREEMENT' );
        dbms_application_info.set_client_info(NULL);

    End Case;

    begin
      select *
        into r_dpu
        from BARS.DPU_DEAL
       where dpu_id = r_agrmnt.DPU_ID;
    exception
      when NO_DATA_FOUND then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�� �������� ���������� ������ # ' || to_char(r_agrmnt.DPU_ID) );
    end;

    Case
      When ( r_dpu.CLOSED = 1 )
      Then -- ������� ��������
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '���������� ������ # ' || to_char(r_agrmnt.DPU_ID) || ' ��������!' );
      When ( BARS.FOST(r_dpu.ACC,gl.bdate) = 0 )
      Then -- ������� �� ���������
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '³������ ������� ����� �� ����������� �������� # ' || to_char(r_agrmnt.DPU_ID) || '!' );
      When ( DPU.CHECK_PENALIZATION( r_dpu.DPU_ID, r_dpu.DAT_BEGIN ) > 0 )
      Then -- ������� �����������
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '���������� ������ # ' || to_char(r_agrmnt.DPU_ID) || ' ���������!' );
      When ( r_dpu.DAT_END Is Null AND r_agrmnt.AGRMNT_TYPE = 7 )
      Then -- �� ��� ����������� ��������
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�������� # ' || to_char(r_agrmnt.DPU_ID) || ' � ��������� "�� ������"!' );
      Else
        Null;
    End Case;

    case
      when ( r_agrmnt.AGRMNT_TYPE = 1 )
      then -- �� ��� ���� ���� ��������

        if ( (r_agrmnt.AMOUNT < r_dpu.SUM) AND (fost(r_dpu.ACC, glb_bankdate) > 0) )
        then -- �������� �� ��������� ���� ��������

          DPU.PARTIAL_PAYMENT( p_dpuid  => r_dpu.DPU_ID,                  -- ��. ����������� ��������
                               p_amount => (r_dpu.SUM - r_agrmnt.AMOUNT), -- ����� ����.������
                               p_option => case when ( r_dpu.DAT_END <= glb_bankdate )
                                                then 0 -- �������� ������� ��� �������� �������
                                                else 1 -- �������� ������� � ����������� ����������� %% �� ���� ������
                                           end,
                               p_outmsg => l_msg );

        end if;

        r_dpu.SUM := r_agrmnt.AMOUNT;

      when ( r_agrmnt.AGRMNT_TYPE = 2 )
      then -- �� ��� ���� ��������� ������ �� ��������

        if ( r_agrmnt.DUE_DATE is Null )
        then
          r_agrmnt.DUE_DATE := glb_bankdate;
        end if;

        begin
          insert into BARS.INT_RATN
            ( acc, id, bdat, ir )
          values
            ( r_dpu.ACC, 1, r_agrmnt.DUE_DATE, r_agrmnt.RATE );
        exception
          when DUP_VAL_ON_INDEX then
            update BARS.INT_RATN
               set ir   = r_agrmnt.RATE
             where acc  = r_dpu.ACC
               and id   = 1
               and bdat = r_agrmnt.DUE_DATE;
        end;

      when ( r_agrmnt.AGRMNT_TYPE = 3 )
      then -- �� ��� ���� ����������� ������� �������
        r_dpu.FREQV := r_agrmnt.FREQ;

      when ( r_agrmnt.AGRMNT_TYPE = 4 )
      then -- �� ��� ���� ������� ���������� �������� �� ����������� �������
        begin

          l_dataxml := XMLTYPE(r_agrmnt.payment_details);

          r_dpu.MFO_D := get_data_from_xml( '/details/dep/mfo/text()' );
          r_dpu.NLS_D := get_data_from_xml( '/details/dep/nls/text()' );
          r_dpu.NMS_D := get_data_from_xml( '/details/dep/nmk/text()' );

          if ( l_dataxml.existsNode('/details/int') > 0 )
          then
            r_dpu.MFO_P  := get_data_from_xml( '/details/int/mfo/text()' );
            r_dpu.NLS_P  := get_data_from_xml( '/details/int/nls/text()' );
            r_dpu.NMS_P  := get_data_from_xml( '/details/int/nmk/text()' );
          end if;

        end;

      when ( r_agrmnt.AGRMNT_TYPE = 5 )
      then -- �� ��� ���� ������ ��������
        begin

          r_dpu.DAT_END := r_agrmnt.END_DATE;
          r_dpu.DATV    := DAT_NEXT_U( r_dpu.DAT_END, 1 );
          -- r_dpu.DATV    := CorrectDate( 980, r_dpu.DAT_END, r_dpu.DAT_END+1 );

        end;

      when ( r_agrmnt.AGRMNT_TYPE = 6 )
      then -- �� ��� ���� ���� ������������ ���������� �����
        r_dpu.ID_STOP := r_agrmnt.STOP_ID;

      when ( r_agrmnt.AGRMNT_TYPE = 7 )
      then -- �� ��� ����������� ��������

        if ( r_agrmnt.DUE_DATE <= gl.bdate AND r_dpu.DAT_END <= r_agrmnt.DUE_DATE )
        then -- ������ ��������� ��������

          DPU.DEAL_PROLONGATION
          ( p_bdat   => gl.bdate,           -- ��������� ���� (��������)
            p_dpuid  => r_agrmnt.DPU_ID,    -- id ��������
            p_datend => r_agrmnt.END_DATE,  -- ���� ���������� �������� ���� �����������
            p_rate   => r_agrmnt.RATE );    -- % ������        �������� ���� �����������

        else -- ������ ���� ��������� �� ��� ��������� �����.��������
          bars_audit.info( title || '������ � ' || r_dpu.ND || '(#' || to_char(r_dpu.DPU_ID ) ||') ���� ��������� �� ��� ��������� �����.��������' );
        end if;

      else -- �� ������� �������
        null;
    end case;

    update BARS.DPU_DEAL
       set ROW = r_dpu
     where DPU_ID = r_agrmnt.DPU_ID;

    /*
    DPU.UPD_DEALPARAMS( p_dealid  => r_dpu.dpu_id,
                        p_dealnum => r_dpu.nd,
                        p_dealsum => r_dpu.sum,
                        p_minsum  => r_dpu.min_sum,
                        p_freqid  => r_dpu.freqv,
                        p_stopid  => r_dpu.id_stop,
                        p_datreg  => r_dpu.datz,
                        p_datbeg  => r_dpu.dat_begin,
                        p_datend  => r_dpu.dat_end,
                        p_datret  => r_dpu.datv,
                        p_depmfo  => r_dpu.mfo_d,
                        p_depnls  => r_dpu.nls_d,
                        p_depnms  => r_dpu.nms_d,
                        p_intmfo  => r_dpu.mfo_p,
                        p_intnls  => r_dpu.nls_p,
                        p_intnms  => r_dpu.nms_p,
                        p_intokpo => r_dpu.okpo_p,
                        p_indrate => r_agrmnt.RATE,     -- �������������� ������
                        p_ratedat => r_agrmnt.DUE_DATE, -- ���� ��������� ������
                        p_operid  => r_dpu.op,
                        p_basrate => r_dpu.br,
                        p_branch  => r_dpu.branch,
                        p_trustid => r_dpu.trustee_id,
                        p_comment => r_dpu.comments );
    */

    if ( r_agrmnt.AGRMNT_TYPE in ( 2, 3, 4, 5, 6 ) )
    then -- ���������� ���������� �� ������ � ����

      update BARS.DPU_AGREEMENTS
         set UNDO_ID = p_agrmnt_id,
             AGRMNT_STATE = -1
       where DPU_ID       = r_agrmnt.DPU_ID
         and AGRMNT_TYPE  = r_agrmnt.AGRMNT_TYPE
         and AGRMNT_STATE = 1;

    end if;

    r_agrmnt.AGRMNT_STATE   := 1;
    r_agrmnt.AGRMNT_PRCDATE := sysdate;
    r_agrmnt.AGRMNT_PRCUSER := l_userid;

    update BARS.DPU_AGREEMENTS
       set ROW = r_agrmnt
     where AGRMNT_ID = p_agrmnt_id;

    dbms_application_info.set_module(NULL, NULL);

    bars_audit.trace( '%s: exit.', title );

  end confirm_agreement;

  --
  -- ³����� � ��������� ��
  --
  procedure refuse_agreement
  ( p_agrmnt_id    in   dpu_agreements.agrmnt_id%type,
    p_comment      in   dpu_agreements.comments%type
  ) is
    title     constant  varchar2(60) := 'dpu_agr.refuse_agreement';
    l_userid            dpu_agreements.agrmnt_prcuser%type    := gl.auid;
  begin

    bars_audit.trace( '%s: entry with (agrmnt_id=%s).', title, to_char(p_agrmnt_id) );

    case

      when ( p_comment is Null )
      then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�������� �� ������ ������� ������!' );

      when ( length(p_comment) < 15 )
      then
        bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '�������� ����������� �������!' );

      Else
        null;

    end case;

    update BARS.DPU_AGREEMENTS
       set AGRMNT_STATE   = -1,
           AGRMNT_PRCDATE = sysdate,
           AGRMNT_PRCUSER = l_userid
     where AGRMNT_ID    = p_agrmnt_id
       and AGRMNT_STATE = 0;

    bars_audit.trace( '%s: exit.', title );

  end refuse_agreement;

  --
  -- ���������� ��
  --
  procedure revoke_agreement
  ( p_agrmnt_id    in   dpu_agreements.agrmnt_id%type
  , p_dpu_id       in   dpu_agreements.dpu_id%type
  ) is
  /**
  <b>REVOKE_AGREEMENT</b> - ��������� ���������� ���������� ����
  %param p_agrmnt_id - ������������� ��������� �����
  %param p_dpu_id    - ������������� ����������� ��������

  %version 1.0
  %usage   ����������� �������� ��.
  */
    title     constant  varchar2(60) := 'dpu_agr.refuse_agreement';
    l_userid            dpu_agreements.agrmnt_prcuser%type    := gl.auid;
  begin

    bars_audit.trace( '%s: entry with (agrmnt_id=%s, p_dpu_id=%s).', title, to_char(p_agrmnt_id), to_char(p_dpu_id) );

    if ( nvl(p_agrmnt_id,0) + nvl(p_dpu_id,0) = 0 )
    then
      bars_error.raise_nerror( modcode, 'GENERAL_ERROR_CODE', '³����� �������� ������� ���������!' );
    else
      null;
    end if;

    if ( nvl(p_agrmnt_id,0) > 0 )
    then -- ������� ��
      update BARS.DPU_AGREEMENTS
         set AGRMNT_STATE   = -2,
             AGRMNT_PRCDATE = sysdate,
             AGRMNT_PRCUSER = l_userid
       where AGRMNT_ID    = p_agrmnt_id
         and AGRMNT_STATE = 1;

    else -- �� ������ �� ��������
      update BARS.DPU_AGREEMENTS
         set AGRMNT_STATE   = -2,
             AGRMNT_PRCDATE = sysdate,
             AGRMNT_PRCUSER = l_userid
       where DPU_ID       = p_dpu_id
         and AGRMNT_STATE = 1
         and DUE_DATE    >= bars.gl.gbd;
    end if;

    bars_audit.trace( '%s: exit.', title );

  end revoke_agreement;


BEGIN

  l_mfo     := gl.amfo;
  l_baseval := gl.baseval;

end DPU_AGR;
/
 show err;
 
PROMPT *** Create  grants  DPU_AGR ***
grant EXECUTE                                                                on DPU_AGR         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DPU_AGR         to DPT_ROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/dpu_agr.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 