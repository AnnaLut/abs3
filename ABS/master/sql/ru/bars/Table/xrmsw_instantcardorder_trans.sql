

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_INSTANTCARDORDER_TRANS.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_INSTANTCARDORDER_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_INSTANTCARDORDER_TRANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_INSTANTCARDORDER_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_INSTANTCARDORDER_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_INSTANTCARDORDER_TRANS 
   (	TRANSACTIONID VARCHAR2(30), 
	CARDCODE VARCHAR2(100), 
	BRANCH VARCHAR2(40), 
	CARDCOUNT NUMBER(*,0), 
	STATUSCODE NUMBER, 
	ERRORMESSAGE VARCHAR2(2000),
	kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'ALTER TABLE BARS.XRMSW_INSTANTCARDORDER_TRANS add(kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/


PROMPT *** ALTER_POLICIES to XRMSW_INSTANTCARDORDER_TRANS ***
 exec bpa.alter_policies('XRMSW_INSTANTCARDORDER_TRANS');


COMMENT ON TABLE BARS.XRMSW_INSTANTCARDORDER_TRANS IS '';
COMMENT ON COLUMN BARS.XRMSW_INSTANTCARDORDER_TRANS.TRANSACTIONID IS '';
COMMENT ON COLUMN BARS.XRMSW_INSTANTCARDORDER_TRANS.CARDCODE IS '';
COMMENT ON COLUMN BARS.XRMSW_INSTANTCARDORDER_TRANS.BRANCH IS '';
COMMENT ON COLUMN BARS.XRMSW_INSTANTCARDORDER_TRANS.CARDCOUNT IS '';
COMMENT ON COLUMN BARS.XRMSW_INSTANTCARDORDER_TRANS.STATUSCODE IS '';
COMMENT ON COLUMN BARS.XRMSW_INSTANTCARDORDER_TRANS.ERRORMESSAGE IS '';




PROMPT *** Create  constraint FK_XCIOT_TRANSACTIONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_INSTANTCARDORDER_TRANS ADD CONSTRAINT FK_XCIOT_TRANSACTIONID FOREIGN KEY (TRANSACTIONID)
	  REFERENCES BARS.XRMSW_AUDIT (TRANSACTIONID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_INSTANTCARDORDER_TRANS ***
grant SELECT                                                                 on XRMSW_INSTANTCARDORDER_TRANS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_INSTANTCARDORDER_TRANS.sql =====
PROMPT ===================================================================================== 
