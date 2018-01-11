

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CDB_DEAL_COMMENT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CDB_DEAL_COMMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CDB_DEAL_COMMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CDB_DEAL_COMMENT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CDB_DEAL_COMMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CDB_DEAL_COMMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CDB_DEAL_COMMENT 
   (	ND NUMBER(38,0), 
	COMMENT_DATE DATE DEFAULT sysdate, 
	COMMENT_MESSAGE VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CDB_DEAL_COMMENT ***
 exec bpa.alter_policies('CDB_DEAL_COMMENT');


COMMENT ON TABLE BARS.CDB_DEAL_COMMENT IS '';
COMMENT ON COLUMN BARS.CDB_DEAL_COMMENT.ND IS '';
COMMENT ON COLUMN BARS.CDB_DEAL_COMMENT.COMMENT_DATE IS '';
COMMENT ON COLUMN BARS.CDB_DEAL_COMMENT.COMMENT_MESSAGE IS '';




PROMPT *** Create  constraint CC_CDB_DEAL_COMM_ND_NOT_NULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CDB_DEAL_COMMENT MODIFY (ND CONSTRAINT CC_CDB_DEAL_COMM_ND_NOT_NULL NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CDB_DEAL_COMM_DATE_NOT_NULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CDB_DEAL_COMMENT MODIFY (COMMENT_DATE CONSTRAINT CC_CDB_DEAL_COMM_DATE_NOT_NULL NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CDB_DEAL_COMMENT_NOT_NULL ***
begin   
 execute immediate '
  ALTER TABLE BARS.CDB_DEAL_COMMENT MODIFY (COMMENT_MESSAGE CONSTRAINT CC_CDB_DEAL_COMMENT_NOT_NULL NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CDB_DEAL_COMMENT_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.CDB_DEAL_COMMENT_IDX ON BARS.CDB_DEAL_COMMENT (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CDB_DEAL_COMMENT ***
grant SELECT                                                                 on CDB_DEAL_COMMENT to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CDB_DEAL_COMMENT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CDB_DEAL_COMMENT to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CDB_DEAL_COMMENT to START1;
grant SELECT                                                                 on CDB_DEAL_COMMENT to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CDB_DEAL_COMMENT.sql =========*** End 
PROMPT ===================================================================================== 
