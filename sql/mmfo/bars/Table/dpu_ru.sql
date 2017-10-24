

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_RU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_RU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_RU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_RU 
   (	NAME VARCHAR2(27), 
	KF NUMBER(9,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_RU ***
 exec bpa.alter_policies('DPU_RU');


COMMENT ON TABLE BARS.DPU_RU IS '';
COMMENT ON COLUMN BARS.DPU_RU.NAME IS '';
COMMENT ON COLUMN BARS.DPU_RU.KF IS '';




PROMPT *** Create  constraint DPU_RU_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_RU ADD CONSTRAINT DPU_RU_PK PRIMARY KEY (KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DPU_RU_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DPU_RU_PK ON BARS.DPU_RU (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_RU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_RU          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_RU          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_RU          to RPBN001;
grant SELECT                                                                 on DPU_RU          to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_RU          to WR_ALL_RIGHTS;
grant SELECT                                                                 on DPU_RU          to WR_CREPORTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_RU.sql =========*** End *** ======
PROMPT ===================================================================================== 
