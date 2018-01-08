

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RKO_NBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''RKO_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_NBS 
   (	NBS CHAR(4), 
	 CONSTRAINT PK_RKO_NBS PRIMARY KEY (NBS) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_NBS ***
 exec bpa.alter_policies('RKO_NBS');


COMMENT ON TABLE BARS.RKO_NBS IS 'Балансовые счета для взымания платы за РКО';
COMMENT ON COLUMN BARS.RKO_NBS.NBS IS 'Номер балансового счета';




PROMPT *** Create  constraint PK_RKO_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_NBS ADD CONSTRAINT PK_RKO_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_RKO_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_RKO_NBS ON BARS.RKO_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_NBS ***
grant SELECT                                                                 on RKO_NBS         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RKO_NBS         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on RKO_NBS         to RKO;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on RKO_NBS         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on RKO_NBS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
