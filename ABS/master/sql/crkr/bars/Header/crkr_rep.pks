CREATE OR REPLACE PACKAGE crkr_rep AS

  -- Public constant declarations
  g_header_version constant varchar2(120) := 'Version Header 1.03 17.11.2016 00:00';
  
  
  /**********************************************************************************
   REVISIONS:
   
   Ver        Date        Author               Description
   ---------  ----------  ---------------      ------------------------------------
   1.3        17.11.2016  viktor.nakonechnyi   1. Добавив поля BRANCH, BRANCH_ACT, OB22
                                                  Функція відображає всі вклади   

  
  
  **********************************************************************************/
  
  type t_col_actul_portf
       is record(             id           COMPEN_PORTFOLIO.id%type,
                              dat_actul    DATE,
                              dat_bur      DATE,
                              rnk          number,
                              ACT_DEP      number,  -- актцалізований
                              ACT_BUR      number,  -- актуаліз на похов
                              PAY_DEP      number,  -- виплата компенсації
                              PAY_BUR      number,  --  виплата поховання
                              PAY_0        number,  -- закриті під 0 
							  sum_PAY_0    number,  -- закриті під 0   sum 
                              ostf         number,  -- залишок на звітну дату входящий
                              ostd         number,  -- залишок на звітну дату
                              ost          number,  -- залишок на поточну дату
                              BRANCH_act   VARCHAR2(30), -- бранч актуалізації
							  BRANCH       VARCHAR2(30), -- бранч актуалізації
							  ob22         varchar2(2),
                              KF           VARCHAR2(6)   -- МФО актуалізації 
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