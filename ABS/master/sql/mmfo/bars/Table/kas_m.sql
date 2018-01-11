

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_M.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_M ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_M'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KAS_M'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KAS_M'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_M ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_M 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	IDM NUMBER(38,0), 
	NAME VARCHAR2(100), 
	NLS_1007 VARCHAR2(15), 
	NLS_1107 VARCHAR2(15)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_M ***
 exec bpa.alter_policies('KAS_M');


COMMENT ON TABLE BARS.KAS_M IS 'Маршрути iнкасацiй';
COMMENT ON COLUMN BARS.KAS_M.KF IS 'Код МФО';
COMMENT ON COLUMN BARS.KAS_M.IDM IS 'Код~Маршруту';
COMMENT ON COLUMN BARS.KAS_M.NAME IS 'Назва~Маршруту';
COMMENT ON COLUMN BARS.KAS_M.NLS_1007 IS '';
COMMENT ON COLUMN BARS.KAS_M.NLS_1107 IS '';




PROMPT *** Create  constraint PK_KASM_IDM ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_M ADD CONSTRAINT PK_KASM_IDM PRIMARY KEY (IDM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KASM_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_M MODIFY (KF CONSTRAINT CC_KASM_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007136 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_M MODIFY (IDM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KASM_IDM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KASM_IDM ON BARS.KAS_M (IDM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_M ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_M           to ABS_ADMIN;
grant SELECT                                                                 on KAS_M           to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_M           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_M           to PYOD001;
grant SELECT                                                                 on KAS_M           to UPLD;
grant FLASHBACK,SELECT                                                       on KAS_M           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_M.sql =========*** End *** =======
PROMPT ===================================================================================== 
