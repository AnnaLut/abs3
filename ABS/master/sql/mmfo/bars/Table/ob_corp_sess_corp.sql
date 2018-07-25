

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORP_SESS_CORP.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORP_SESS_CORP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORP_SESS_CORP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORP_SESS_CORP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORP_SESS_CORP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORP_SESS_CORP 
   (	SESS_ID NUMBER, 
	KF VARCHAR2(6), 
	CORP_ID NUMBER, 
	IS_LAST NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORP_SESS_CORP ***
 exec bpa.alter_policies('OB_CORP_SESS_CORP');


COMMENT ON TABLE BARS.OB_CORP_SESS_CORP IS 'Перелій корперацій переданих в сесії';
COMMENT ON COLUMN BARS.OB_CORP_SESS_CORP.SESS_ID IS 'ID сесії';
COMMENT ON COLUMN BARS.OB_CORP_SESS_CORP.KF IS 'МФО';
COMMENT ON COLUMN BARS.OB_CORP_SESS_CORP.CORP_ID IS 'ID корпорації';
COMMENT ON COLUMN BARS.OB_CORP_SESS_CORP.IS_LAST IS 'Признак останьої сесії на дату для корпорації(1-останя, 0 - не остання)';




PROMPT *** Create  constraint PK_OB_CORP_SESS_CORP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS_CORP ADD CONSTRAINT PK_OB_CORP_SESS_CORP PRIMARY KEY (SESS_ID, KF, CORP_ID, IS_LAST)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OB_CORP_SESS_CORP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS_CORP ADD CONSTRAINT CC_OB_CORP_SESS_CORP CHECK (is_last in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OB_CORP_SESS_CORP_LAST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORP_SESS_CORP ADD CONSTRAINT CC_OB_CORP_SESS_CORP_LAST_NN CHECK (is_last is not null) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OB_CORP_SESS_CORP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OB_CORP_SESS_CORP ON BARS.OB_CORP_SESS_CORP (SESS_ID, KF, CORP_ID, IS_LAST) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORP_SESS_CORP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OB_CORP_SESS_CORP to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORP_SESS_CORP.sql =========*** End
PROMPT ===================================================================================== 

