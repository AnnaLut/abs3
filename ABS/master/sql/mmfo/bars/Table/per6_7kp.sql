

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PER6_7KP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PER6_7KP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PER6_7KP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PER6_7KP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''PER6_7KP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PER6_7KP ***
begin 
  execute immediate '
  CREATE TABLE BARS.PER6_7KP 
   (	NLS VARCHAR2(15), 
	KV NUMBER, 
	DOS NUMBER, 
	KOS NUMBER, 
	OSTF NUMBER, 
	NLSB VARCHAR2(15), 
	NAZN VARCHAR2(160), 
	TXT VARCHAR2(70), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	TOBO VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PER6_7KP ***
 exec bpa.alter_policies('PER6_7KP');


COMMENT ON TABLE BARS.PER6_7KP IS 'Довiдник перекриття 6,7 класiв на 5040';
COMMENT ON COLUMN BARS.PER6_7KP.NLS IS '';
COMMENT ON COLUMN BARS.PER6_7KP.KV IS '';
COMMENT ON COLUMN BARS.PER6_7KP.DOS IS '';
COMMENT ON COLUMN BARS.PER6_7KP.KOS IS '';
COMMENT ON COLUMN BARS.PER6_7KP.OSTF IS '';
COMMENT ON COLUMN BARS.PER6_7KP.NLSB IS '';
COMMENT ON COLUMN BARS.PER6_7KP.NAZN IS '';
COMMENT ON COLUMN BARS.PER6_7KP.TXT IS '';
COMMENT ON COLUMN BARS.PER6_7KP.KF IS '';
COMMENT ON COLUMN BARS.PER6_7KP.TOBO IS '';




PROMPT *** Create  constraint SYS_C006157 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PER6_7KP MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006158 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PER6_7KP MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PER67KP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PER6_7KP MODIFY (KF CONSTRAINT CC_PER67KP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PER6_7KP ***
begin   
 execute immediate '
  ALTER TABLE BARS.PER6_7KP ADD CONSTRAINT XPK_PER6_7KP PRIMARY KEY (NLS, KV, NLSB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PER6_7KP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PER6_7KP ON BARS.PER6_7KP (NLS, KV, NLSB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PER6_7KP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PER6_7KP        to ABS_ADMIN;
grant SELECT                                                                 on PER6_7KP        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PER6_7KP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PER6_7KP        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on PER6_7KP        to PER6_7KP;
grant DELETE,INSERT,SELECT,UPDATE                                            on PER6_7KP        to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PER6_7KP        to START1;
grant SELECT                                                                 on PER6_7KP        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PER6_7KP        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PER6_7KP        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PER6_7KP.sql =========*** End *** ====
PROMPT ===================================================================================== 
