create or replace package msp_const is

  -- msp_requests.act_type
  req_PAYMENT_DATA     constant number := 1;
  req_DATA_STATE       constant number := 3;
  req_VALIDATION_STATE constant number := 4;
  req_PAYMENT_STATE    constant number := 5;

  -- msp_requests.state
  st_req_NEW_REQUEST             constant number := -1; -- ����� �����
  st_req_PARSED                  constant number :=  0; -- ����������� ������
  st_req_ERROR_ECP_REQUEST       constant number :=  1; -- ������� ��� ��� ��������
  st_req_ERROR_DECRYPT_ENVELOPE  constant number :=  2; -- ������� ������������� ����� ��������
  st_req_ERROR_XML_ENVELOPE      constant number :=  3; -- ������� � �������� xml
  st_req_ERROR_UNPACK_ENVELOPE   constant number :=  4; -- ������� ��� ������������� �����
  st_req_ERROR_UNIQUE_ENVELOPE   constant number :=  5; -- ������� ���������� ��������

  -- msp_envelopes.state
  st_env_ENVLIST_PROCESSING      constant number := -2; -- ������� � ������ �������������
  st_env_ENVLIST_RECEIVED        constant number := -1; -- ����� �������
  st_env_PARSED                  constant number :=  0; -- ������� ���������
  st_env_ERROR_ECP_ENVELOPE      constant number :=  1; -- ������� ��� ��� �����
  st_env_ERROR_DECRYPT_ENVELOPE  constant number :=  2; -- ������� ������������� ����� ��������
  st_env_ERROR_XML_ENVELOPE      constant number :=  3; -- ������� � �������� xml
  st_env_ERROR_UNPACK_ENVELOPE   constant number :=  4; -- ������� ��� ������������� �����
  st_env_MATCH1_PROCESSING       constant number :=  9; -- ��������� 1 � ������ ����������
  st_env_MATCH2_PROCESSING       constant number :=  10; -- ��������� 2 � ������ ����������
  st_env_MATCH1_CREATED          constant number :=  11; -- ��������� 1 ����������
  st_env_MATCH1_SIGN_WAIT        constant number :=  12; -- ������� ��������� 1 ������� �� ���������
  st_env_MATCH1_CREATE_ERROR     constant number :=  13; -- ������� ���������� ��������� 1
  st_env_MATCH1_SEND             constant number :=  14; -- ��������� 1 ����������
  st_env_MATCH1_ENV_CREATE_ERROR constant number :=  15; -- ������� ���������� �������� ��������� 1
  st_env_MATCH2_CREATED          constant number :=  16; -- ��������� 2 ����������
  st_env_MATCH2_SIGN_WAIT        constant number :=  17; -- ������� ��������� 2 ������� �� ���������
  st_env_MATCH2_CREATE_ERROR     constant number :=  18; -- ������� ���������� ��������� 2
  st_env_MATCH2_SEND             constant number :=  19; -- ��������� 2 ����������
  st_env_MATCH2_ENV_CREATE_ERROR constant number :=  20; -- ������� ���������� �������� ��������� 2

end msp_const;
/
