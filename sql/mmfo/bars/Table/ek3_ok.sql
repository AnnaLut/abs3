

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK3_OK.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK3_OK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK3_OK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK3_OK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK3_OK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK3_OK ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK3_OK 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK3_OK ***
 exec bpa.alter_policies('EK3_OK');


COMMENT ON TABLE BARS.EK3_OK IS 'Классификатор перечня счетов Основного капиталла (EK3_OK)';
COMMENT ON COLUMN BARS.EK3_OK.NBS IS '';
COMMENT ON COLUMN BARS.EK3_OK.NAME IS '';
COMMENT ON COLUMN BARS.EK3_OK.PAP IS '';




PROMPT *** Create  constraint XPK_EK3_OK ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK3_OK ADD CONSTRAINT XPK_EK3_OK PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007689 ***
begin   
 execute immediate '
  ALTER TABLE BARS.EK3_OK MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_EK3_OK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_EK3_OK ON BARS.EK3_OK (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EK3_OK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EK3_OK          to ABS_ADMIN;
grant SELECT                                                                 on EK3_OK          to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK3_OK          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK3_OK          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK3_OK          to EK3_OK;
grant SELECT                                                                 on EK3_OK          to RPBN002;
grant SELECT                                                                 on EK3_OK          to START1;
grant SELECT                                                                 on EK3_OK          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK3_OK          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on EK3_OK          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK3_OK.sql =========*** End *** ======
PROMPT ===================================================================================== 
