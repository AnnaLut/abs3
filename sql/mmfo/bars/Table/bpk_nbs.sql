

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BPK_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BPK_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BPK_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BPK_NBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BPK_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BPK_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BPK_NBS 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	CUSTTYPE NUMBER(1,0), 
	TIP CHAR(3)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BPK_NBS ***
 exec bpa.alter_policies('BPK_NBS');


COMMENT ON TABLE BARS.BPK_NBS IS '¡œ . ƒÓÔÛÒÚËÏ≥ ¡–';
COMMENT ON COLUMN BARS.BPK_NBS.NBS IS '¡–';
COMMENT ON COLUMN BARS.BPK_NBS.OB22 IS 'Œ¡22';
COMMENT ON COLUMN BARS.BPK_NBS.CUSTTYPE IS '“ËÔ ÍÎ≥∫ÌÚ‡ (1-‘Œ, 2-ﬁŒ)';
COMMENT ON COLUMN BARS.BPK_NBS.TIP IS '“ËÔ ‡ıÛÌÍÛ';




PROMPT *** Create  constraint PK_BPKNBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS ADD CONSTRAINT PK_BPKNBS PRIMARY KEY (NBS, OB22)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKNBS_CUSTTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS ADD CONSTRAINT CC_BPKNBS_CUSTTYPE CHECK (custtype in (1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKNBS_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS MODIFY (NBS CONSTRAINT CC_BPKNBS_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKNBS_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS MODIFY (OB22 CONSTRAINT CC_BPKNBS_OB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKNBS_CUSTTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS MODIFY (CUSTTYPE CONSTRAINT CC_BPKNBS_CUSTTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BPKNBS_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BPK_NBS MODIFY (TIP CONSTRAINT CC_BPKNBS_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BPKNBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BPKNBS ON BARS.BPK_NBS (NBS, OB22) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BPK_NBS ***
grant SELECT                                                                 on BPK_NBS         to BARSREADER_ROLE;
grant SELECT                                                                 on BPK_NBS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BPK_NBS         to BARS_DM;
grant SELECT                                                                 on BPK_NBS         to OBPC;
grant SELECT                                                                 on BPK_NBS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BPK_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
