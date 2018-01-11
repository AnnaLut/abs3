

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_LIMIT_QUERY.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_LIMIT_QUERY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_LIMIT_QUERY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_LIMIT_QUERY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_LIMIT_QUERY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_LIMIT_QUERY ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_LIMIT_QUERY 
   (	LIMIT_ID NUMBER(*,0), 
	MFO VARCHAR2(6), 
	OPERDATE DATE, 
	CURRENCY NUMBER(*,0), 
	ID_CART VARCHAR2(64), 
	ACCOUNT VARCHAR2(14), 
	SUMA NUMBER, 
	LNAME VARCHAR2(64), 
	FNAME VARCHAR2(64), 
	SNAME VARCHAR2(64), 
	BLOCK NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_LIMIT_QUERY ***
 exec bpa.alter_policies('DPT_LIMIT_QUERY');


COMMENT ON TABLE BARS.DPT_LIMIT_QUERY IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.LIMIT_ID IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.MFO IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.OPERDATE IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.CURRENCY IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.ID_CART IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.ACCOUNT IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.SUMA IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.LNAME IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.FNAME IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.SNAME IS '';
COMMENT ON COLUMN BARS.DPT_LIMIT_QUERY.BLOCK IS '';




PROMPT *** Create  constraint XPK_DPT_LIMIT_QUERY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LIMIT_QUERY ADD CONSTRAINT XPK_DPT_LIMIT_QUERY PRIMARY KEY (LIMIT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_LIM_Q_OPERDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LIMIT_QUERY MODIFY (OPERDATE CONSTRAINT CC_DPT_LIM_Q_OPERDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_LIM_Q_CURRENCY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LIMIT_QUERY MODIFY (CURRENCY CONSTRAINT CC_DPT_LIM_Q_CURRENCY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_LIM_Q_ACCOUNT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LIMIT_QUERY MODIFY (ACCOUNT CONSTRAINT CC_DPT_LIM_Q_ACCOUNT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_LIM_Q_SUMA ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LIMIT_QUERY MODIFY (SUMA CONSTRAINT CC_DPT_LIM_Q_SUMA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPT_LIM_Q_BLOCK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_LIMIT_QUERY MODIFY (BLOCK CONSTRAINT CC_DPT_LIM_Q_BLOCK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_DPT_LIMIT_QUERY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_DPT_LIMIT_QUERY ON BARS.DPT_LIMIT_QUERY (LIMIT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_LIMIT_QUERY ***
grant SELECT                                                                 on DPT_LIMIT_QUERY to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_LIMIT_QUERY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_LIMIT_QUERY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_LIMIT_QUERY to START1;
grant SELECT                                                                 on DPT_LIMIT_QUERY to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_LIMIT_QUERY.sql =========*** End *
PROMPT ===================================================================================== 
