

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPA_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_NBS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPA_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPA_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPA_NBS 
   (	TYPE VARCHAR2(3), 
	NBS CHAR(4), 
	TAXOTYPE CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPA_NBS ***
 exec bpa.alter_policies('DPA_NBS');


COMMENT ON TABLE BARS.DPA_NBS IS '';
COMMENT ON COLUMN BARS.DPA_NBS.TYPE IS '';
COMMENT ON COLUMN BARS.DPA_NBS.NBS IS '';
COMMENT ON COLUMN BARS.DPA_NBS.TAXOTYPE IS '';




PROMPT *** Create  constraint PK_DPANBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_NBS ADD CONSTRAINT PK_DPANBS PRIMARY KEY (TYPE, NBS, TAXOTYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPANBS_TAXOTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPA_NBS ADD CONSTRAINT CC_DPANBS_TAXOTYPE CHECK (taxotype in (1,3,5,6)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPANBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPANBS ON BARS.DPA_NBS (TYPE, NBS, TAXOTYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPA_NBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_NBS         to ABS_ADMIN;
grant SELECT                                                                 on DPA_NBS         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_NBS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPA_NBS         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_NBS         to DPA_NBS;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPA_NBS         to RPBN002;
grant SELECT                                                                 on DPA_NBS         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPA_NBS         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPA_NBS         to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPA_NBS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPA_NBS FOR BARS.DPA_NBS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
