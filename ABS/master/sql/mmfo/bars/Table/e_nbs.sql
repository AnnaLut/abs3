

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/E_NBS.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to E_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''E_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''E_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''E_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table E_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.E_NBS 
   (	NBS NUMBER(4,0), 
	FL VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to E_NBS ***
 exec bpa.alter_policies('E_NBS');


COMMENT ON TABLE BARS.E_NBS IS '';
COMMENT ON COLUMN BARS.E_NBS.NBS IS '';
COMMENT ON COLUMN BARS.E_NBS.FL IS '';




PROMPT *** Create  constraint XPK_ENBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_NBS ADD CONSTRAINT XPK_ENBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006238 ***
begin   
 execute immediate '
  ALTER TABLE BARS.E_NBS MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ENBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ENBS ON BARS.E_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  E_NBS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on E_NBS           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on E_NBS           to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_NBS           to ELT;
grant DELETE,INSERT,SELECT,UPDATE                                            on E_NBS           to START1;
grant FLASHBACK,SELECT                                                       on E_NBS           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/E_NBS.sql =========*** End *** =======
PROMPT ===================================================================================== 
