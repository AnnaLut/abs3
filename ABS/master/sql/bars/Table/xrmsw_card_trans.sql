

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XRMSW_CARD_TRANS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XRMSW_CARD_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XRMSW_CARD_TRANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XRMSW_CARD_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XRMSW_CARD_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XRMSW_CARD_TRANS 
   (	TRANSACTIONID VARCHAR2(30), 
	ND NUMBER(38,0), 
	ACC NUMBER(38,0), 
	NLS VARCHAR2(15), 
	DAOS DATE, 
	DATE_BEGIN DATE, 
	STATUS NUMBER(5,0), 
	BLKD NUMBER(3,0), 
	BLKK NUMBER(3,0), 
	DKBO_NUM VARCHAR2(50), 
	DKBO_IN DATE, 
	DKBO_OUT DATE, 
	STATUSCODE NUMBER, 
	ERRORMESSAGE VARCHAR2(2000),
	kf               VARCHAR2(6) default sys_context(''bars_context'',''user_mfo'')	
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin
    execute immediate 'ALTER TABLE BARS.XRMSW_CARD_TRANS add(kf VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''))';
   exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if;
end;
/


PROMPT *** ALTER_POLICIES to XRMSW_CARD_TRANS ***
 exec bpa.alter_policies('XRMSW_CARD_TRANS');


COMMENT ON TABLE BARS.XRMSW_CARD_TRANS IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.DAOS IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.DATE_BEGIN IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.STATUS IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.BLKD IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.BLKK IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.DKBO_NUM IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.DKBO_IN IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.DKBO_OUT IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.STATUSCODE IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.ERRORMESSAGE IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.TRANSACTIONID IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.ND IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.ACC IS '';
COMMENT ON COLUMN BARS.XRMSW_CARD_TRANS.NLS IS '';




PROMPT *** Create  constraint FK_XCT_TRANSACTIONID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XRMSW_CARD_TRANS ADD CONSTRAINT FK_XCT_TRANSACTIONID FOREIGN KEY (TRANSACTIONID)
	  REFERENCES BARS.XRMSW_AUDIT (TRANSACTIONID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XRMSW_CARD_TRANS ***
grant SELECT                                                                 on XRMSW_CARD_TRANS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XRMSW_CARD_TRANS.sql =========*** End 
PROMPT ===================================================================================== 
