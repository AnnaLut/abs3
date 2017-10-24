

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_MF.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_MF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_MF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KAS_MF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KAS_MF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_MF ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_MF 
   (	ID NUMBER(*,0), 
	IDM NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_MF ***
 exec bpa.alter_policies('KAS_MF');


COMMENT ON TABLE BARS.KAS_MF IS 'Iнкасатори та їх маршрути';
COMMENT ON COLUMN BARS.KAS_MF.ID IS 'Код~Iнкасатора';
COMMENT ON COLUMN BARS.KAS_MF.IDM IS 'Код~Маршруту';




PROMPT *** Create  constraint PK_KASMF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_MF ADD CONSTRAINT PK_KASMF_ID PRIMARY KEY (ID, IDM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASMF_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_MF ADD CONSTRAINT FK_KASMF_ID FOREIGN KEY (ID)
	  REFERENCES BARS.KAS_F (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KASMF_IDM ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_MF ADD CONSTRAINT FK_KASMF_IDM FOREIGN KEY (IDM)
	  REFERENCES BARS.KAS_M (IDM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASMF_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASMF_ID ON BARS.KAS_MF (ID, IDM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_MF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_MF          to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_MF          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_MF          to PYOD001;
grant FLASHBACK,SELECT                                                       on KAS_MF          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_MF.sql =========*** End *** ======
PROMPT ===================================================================================== 
