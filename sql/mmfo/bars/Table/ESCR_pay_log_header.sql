

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ESCR_pay_log_header.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ESCR_pay_log_header ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ESCR_pay_log_header'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ESCR_pay_log_header'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ESCR_pay_log_header ***
begin 
  execute immediate '
  CREATE TABLE BARS.ESCR_pay_log_header 
   (  ID NUMBER, 
  total_DEAL_COUNT NUMBER, 
  succes_DEAL_COUNT  NUMBER,
  ERROR_DEAL_COUNT NUMBER, 
  OPER_DATE DATE default sysdate, 
  KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ESCR_pay_log_header ***
 exec bpa.alter_policies('ESCR_pay_log_header');


COMMENT ON TABLE BARS.ESCR_pay_log_header IS 'Журнал виконання зарахування компенсацій по енергозберігаючій програмі';





PROMPT *** Create  constraint PK_PAY_HEAD_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.ESCR_pay_log_header ADD CONSTRAINT PK_PAY_HEAD_ID PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  index PK_PAY_HEAD_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAY_HEAD_ID ON BARS.ESCR_pay_log_header (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ESCR_pay_log_header ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ESCR_pay_log_header to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ESCR_pay_log_header.sql =========*** End 
PROMPT ===================================================================================== 
