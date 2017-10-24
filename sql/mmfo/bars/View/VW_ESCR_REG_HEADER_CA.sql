CREATE OR REPLACE VIEW VW_ESCR_REG_HEADER_CA AS
SELECT rh.customer_id
      ,rh.customer_name
      ,rh.customer_okpo
      ,rh.customer_region
      ,rh.customer_full_address
      ,NULL                     customer_type
      ,rh.subs_numb
      ,rh.subs_date
      ,rh.subs_doc_type
      ,rh.deal_id
      ,rh.deal_number
      ,rh.deal_date_from
      ,rh.deal_date_to
      ,rh.deal_term
      ,rh.deal_product
      ,rh.deal_state
      ,NULL                     deal_type_code
      ,NULL                     deal_type_name
      ,case when rh.new_deal_sum is null then trim(to_char(rh.deal_sum,'99999999D99'))
       when  rh.new_deal_sum is not  null then trim(to_char(rh.new_deal_sum,'99999999D99'))
        end deal_sum
     ,rstate.status_id         credit_status_id
      ,rstate.status_name       credit_status_name
      ,rstate.status_code       credit_status_code
      ,rstate.status_comment    credit_comment
      ,NULL                     state_for_ui
      ,case when rh.new_good_cost is null then rh.good_cost
      when  rh.new_good_cost is not  null then to_char(rh.new_good_cost)
       end good_cost
      ,rh.nls
      ,NULL                     AS acc
      ,rh.doc_date
      ,NULL                     money_date
      ,case when rh.new_comp_sum is null then rh.comp_sum
      when  rh.new_comp_sum is not  null then rh.new_comp_sum
        end comp_sum
       ,1                        valid_status --�� ����� �������� ��������� �� ��
      ,rh.branch_code
      ,rh.branch_name
      ,rh.mfo
      ,rh.user_id
      ,rh.user_name
      ,tt.reg_type_id
      ,tt.reg_kind_id
      ,tt.id reg_id
      ,tt.create_date
      ,tt.date_from
      ,tt.date_to
      ,1                        AS credit_count
      ,ek.code                  reg_kind_code
      ,et.code                  reg_type_code
      ,ek.name                  reg_kind_name
      ,et.name                  reg_type_name
      ,rh.payment_ref
      ,tt.outer_number
      ,trim(to_char(rh.new_good_cost,'99999999D99')) new_good_cost
      ,trim(to_char(rh.new_deal_sum,'99999999D999')) new_deal_sum
      ,trim(to_char(rh.new_comp_sum,'99999999D99'))new_comp_sum
      /*,rh.new_good_cost
      ,rh.new_deal_sum
      ,rh.new_comp_sum*/
  FROM (SELECT LEVEL         lev_id
              ,a.out_doc_id  deal_id
              ,t.reg_type_id
              ,t.reg_kind_id
              , CONNECT_BY_ROOT a.in_doc_id id
              ,t.create_date
              ,t.date_from
              ,t.date_to
              ,t.outer_number
          FROM escr_reg_mapping a
          JOIN escr_register t
            ON t.id = a.in_doc_id
         START WITH a.in_doc_id = t.id
        CONNECT BY PRIOR a.out_doc_id = a.in_doc_id ) tt
  JOIN escr_reg_header rh
    ON rh.deal_id = tt.deal_id
  JOIN (SELECT rs.obj_id
              ,rs.id
              ,rs.status_id
              ,s.code            AS status_code
              ,s.name            AS status_name
              ,rs.status_comment
          FROM escr_reg_obj_state rs
          JOIN escr_reg_status s
            ON s.id = rs.status_id
         WHERE rs.id = (SELECT MAX(id)
                          FROM escr_reg_obj_state
                         WHERE obj_id = rs.obj_id)
           AND rs.status_id = s.id) rstate
    ON tt.deal_id = rstate.obj_id
  JOIN escr_reg_kind ek
    ON tt.reg_kind_id = ek.id
  JOIN escr_reg_types et
    ON tt.reg_type_id = et.id
;
comment on table VW_ESCR_REG_HEADER_CA is '������� ��������,������� � �����';
comment on column VW_ESCR_REG_HEADER_CA.CUSTOMER_ID is '������������ �����  ������ ��������';
comment on column VW_ESCR_REG_HEADER_CA.CUSTOMER_NAME is '�������, ���,  ��-������� ������� �����-������������';
comment on column VW_ESCR_REG_HEADER_CA.CUSTOMER_OKPO is '��� �����-������������ ��� ��� �������� ';
comment on column VW_ESCR_REG_HEADER_CA.CUSTOMER_REGION is '�볺�� ������ ���������� (�������)';
comment on column VW_ESCR_REG_HEADER_CA.CUSTOMER_FULL_ADDRESS is '�볺�� ����� ������ ����������';
comment on column VW_ESCR_REG_HEADER_CA.CUSTOMER_TYPE is '��� �볺��� (��������)';
comment on column VW_ESCR_REG_HEADER_CA.SUBS_NUMB is '����� �����䳿 (��������)';
comment on column VW_ESCR_REG_HEADER_CA.SUBS_DATE is '���� �����䳿 (��������)';
comment on column VW_ESCR_REG_HEADER_CA.SUBS_DOC_TYPE is '�������� ��� �������';
comment on column VW_ESCR_REG_HEADER_CA.DEAL_ID is 'ID ���������� �������� (��������)';
comment on column VW_ESCR_REG_HEADER_CA.DEAL_NUMBER is '����� ���������� ��������';
comment on column VW_ESCR_REG_HEADER_CA.DEAL_DATE_FROM is '���� ������� 䳿 ���������� ��������';
comment on column VW_ESCR_REG_HEADER_CA.DEAL_DATE_TO is '���� ��������� 䳿 ���������� �������� (��������)';
comment on column VW_ESCR_REG_HEADER_CA.DEAL_TERM is '����� 䳿 (� ������)';
comment on column VW_ESCR_REG_HEADER_CA.DEAL_PRODUCT is '������� (��������)';
comment on column VW_ESCR_REG_HEADER_CA.DEAL_SUM is '���� ���������� ��������';
comment on column VW_ESCR_REG_HEADER_CA.GOOD_COST is '�������� ������� ���������� ����������������� ���������� ��/��� �������� �� ��������� ���� � �� ������������ (� �������)';
comment on column VW_ESCR_REG_HEADER_CA.NLS is '������� ���������� ��������';
comment on column VW_ESCR_REG_HEADER_CA.DOC_DATE is '���� ��������� ������������� ���������';
comment on column VW_ESCR_REG_HEADER_CA.MONEY_DATE is '���� ��������� �����������';
comment on column VW_ESCR_REG_HEADER_CA.COMP_SUM is '���� ����������� (��������)';
comment on column VW_ESCR_REG_HEADER_CA.USER_NAME is '³����������� ���������,���� ������� �����';
