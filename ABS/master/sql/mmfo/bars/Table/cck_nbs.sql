

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_NBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_NBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_NBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_NBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_NBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_NBS 
   (	IDP NUMBER, 
	IDT NUMBER, 
	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_NBS ***
 exec bpa.alter_policies('CCK_NBS');


COMMENT ON TABLE BARS.CCK_NBS IS '';
COMMENT ON COLUMN BARS.CCK_NBS.IDP IS '';
COMMENT ON COLUMN BARS.CCK_NBS.IDT IS '';
COMMENT ON COLUMN BARS.CCK_NBS.NBS IS '';




PROMPT *** Create  constraint XPK_CCK_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS ADD CONSTRAINT XPK_CCK_NBS PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCK_NBS_IDP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS ADD CONSTRAINT FK_CCK_NBS_IDP FOREIGN KEY (IDP)
	  REFERENCES BARS.CCK_TIP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCK_NBS_IDT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS ADD CONSTRAINT FK_CCK_NBS_IDT FOREIGN KEY (IDT)
	  REFERENCES BARS.CCK_TERM (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCK_NBS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS ADD CONSTRAINT FK_CCK_NBS_NBS FOREIGN KEY (NBS)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CCK_NBS_NBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_NBS MODIFY (NBS CONSTRAINT NK_CCK_NBS_NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CCK_NBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CCK_NBS ON BARS.CCK_NBS (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_NBS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_NBS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_NBS         to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CCK_NBS         to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_NBS         to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CCK_NBS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
