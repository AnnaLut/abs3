

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_USER.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_USER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_USER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_USER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_USER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_USER 
   (	ID NUMBER(*,0), 
	NLS VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_USER ***
 exec bpa.alter_policies('CASH_USER');


COMMENT ON TABLE BARS.CASH_USER IS '';
COMMENT ON COLUMN BARS.CASH_USER.ID IS '';
COMMENT ON COLUMN BARS.CASH_USER.NLS IS '';




PROMPT *** Create  constraint XPK_CASH_USER ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_USER ADD CONSTRAINT XPK_CASH_USER PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASH_USER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CASH_USER ON BARS.CASH_USER (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_USER ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASH_USER       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_USER       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CASH_USER       to PYOD001;
grant FLASHBACK,SELECT                                                       on CASH_USER       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_USER.sql =========*** End *** ===
PROMPT ===================================================================================== 
