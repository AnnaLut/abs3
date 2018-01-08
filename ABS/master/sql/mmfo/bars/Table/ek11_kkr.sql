

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK11_KKR.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK11_KKR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK11_KKR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK11_KKR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK11_KKR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK11_KKR ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK11_KKR 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK11_KKR ***
 exec bpa.alter_policies('EK11_KKR');


COMMENT ON TABLE BARS.EK11_KKR IS '';
COMMENT ON COLUMN BARS.EK11_KKR.NBS IS '';
COMMENT ON COLUMN BARS.EK11_KKR.NAME IS '';
COMMENT ON COLUMN BARS.EK11_KKR.PAP IS '';




PROMPT *** Create  constraint XPK_EK11_KKR ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK11_KKR ADD CONSTRAINT XPK_EK11_KKR PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010029 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK11_KKR MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK11_KKR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK11_KKR ON BARS.EK11_KKR (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK11_KKR ***
grant SELECT                                                                 on EK11_KKR        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK11_KKR        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK11_KKR        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK11_KKR        to EK11_KKR;
grant SELECT                                                                 on EK11_KKR        to UPLD;
grant FLASHBACK,SELECT                                                       on EK11_KKR        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK11_KKR.sql =========*** End *** ====
PROMPT ===================================================================================== 
