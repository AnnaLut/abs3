
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_pay_log_header.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_pay_log_header ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_pay_log_body'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ESCR_pay_log_body'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/


PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_pay_log_body.sql =========*** Run 
PROMPT ===================================================================================== 

PROMPT *** Create  table ESCR_pay_log_body ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_pay_log_body 
   ( ID_log NUMBER,
  deal_id NUMBER, 
  succes_DEAL_COUNT  NUMBER,
  err_code NUMBER, 
  comments varchar2(4000) 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




COMMENT ON TABLE BARS.ESCR_pay_log_body IS 'Журнал виконання зарахування компенсацій по енергозберігаючій програмі (специфікація)';


PROMPT *** Create  index PK_PAY_BODY_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAY_HEAD_ID ON BARS.ESCR_pay_log_body (ID_LOG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_pay_log_body ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_pay_log_body to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_pay_log_body.sql =========*** End 
PROMPT ===================================================================================== 
