

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_VR.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_VR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_VR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_VR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_VR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_VR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_VR 
   (	VR NUMBER, 
	NAME VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_VR ***
 exec bpa.alter_policies('CP_VR');


COMMENT ON TABLE BARS.CP_VR IS 'Види обл_кової вартост_';
COMMENT ON COLUMN BARS.CP_VR.VR IS 'Код обл_кової вартост_';
COMMENT ON COLUMN BARS.CP_VR.NAME IS 'Вид обл_кової вартост_';




PROMPT *** Create  constraint SYS_C008696 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VR MODIFY (VR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_CP_VR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_VR ADD CONSTRAINT XPK_CP_VR PRIMARY KEY (VR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_VR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_VR ON BARS.CP_VR (VR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_VR ***
grant SELECT                                                                 on CP_VR           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CP_VR           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_VR           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_VR           to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_VR           to START1;
grant SELECT                                                                 on CP_VR           to UPLD;
grant FLASHBACK,SELECT                                                       on CP_VR           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_VR.sql =========*** End *** =======
PROMPT ===================================================================================== 
