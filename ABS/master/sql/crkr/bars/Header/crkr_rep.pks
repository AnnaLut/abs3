CREATE OR REPLACE PACKAGE crkr_rep AS

  -- Public constant declarations
  g_header_version constant varchar2(120) := 'Version Header 1.03 17.11.2016 00:00';
  
  
  /**********************************************************************************
   REVISIONS:
   
   Ver        Date        Author               Description
   ---------  ----------  ---------------      ------------------------------------
   1.3        17.11.2016  viktor.nakonechnyi   1. ������� ���� BRANCH, BRANCH_ACT, OB22
                                                  ������� �������� �� ������   

  
  
  **********************************************************************************/
  
  type t_col_actul_portf
       is record(             id           COMPEN_PORTFOLIO.id%type,
                              dat_actul    DATE,
                              dat_bur      DATE,
                              rnk          number,
                              ACT_DEP      number,  -- �������������
                              ACT_BUR      number,  -- ������� �� �����
                              PAY_DEP      number,  -- ������� �����������
                              PAY_BUR      number,  --  ������� ���������
                              PAY_0        number,  -- ������ �� 0 
							  sum_PAY_0    number,  -- ������ �� 0   sum 
                              ostf         number,  -- ������� �� ����� ���� ��������
                              ostd         number,  -- ������� �� ����� ����
                              ost          number,  -- ������� �� ������� ����
                              BRANCH_act   VARCHAR2(30), -- ����� �����������
							  BRANCH       VARCHAR2(30), -- ����� �����������
							  ob22         varchar2(2),
                              KF           VARCHAR2(6)   -- ��� ����������� 
                );

  TYPE t_actul_portf iS TABLE OF t_col_actul_portf;

 
FUNCTION f_actual_portfolio (
                              p_sFdat1 date,
                              p_sFdat2 date,
                              p_branch varchar2 default '%' ,  
							  p_act    varchar2 default '0'  
                            )   RETURN t_actul_portf PIPELINED PARALLEL_ENABLE;
                            
 -- Public function and procedure declarations
  function header_version return varchar2;
  function body_version return varchar2;
                            

END;
/