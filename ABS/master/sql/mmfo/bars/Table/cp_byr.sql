

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_BYR.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_BYR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_BYR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_BYR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_BYR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_BYR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_BYR 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_BYR ***
 exec bpa.alter_policies('CP_BYR');


COMMENT ON TABLE BARS.CP_BYR IS 'Довiдник бiрж';
COMMENT ON COLUMN BARS.CP_BYR.ID IS 'Внутр. код бiржi';
COMMENT ON COLUMN BARS.CP_BYR.NAME IS 'Назва бiржi';




PROMPT *** Create  constraint XPK_BYR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_BYR ADD CONSTRAINT XPK_BYR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005825 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_BYR MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BYR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BYR ON BARS.CP_BYR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_BYR ***
grant SELECT                                                                 on CP_BYR          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_BYR          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_BYR          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_BYR          to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_BYR          to START1;
grant SELECT                                                                 on CP_BYR          to UPLD;
grant FLASHBACK,SELECT                                                       on CP_BYR          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_BYR.sql =========*** End *** ======
PROMPT ===================================================================================== 
