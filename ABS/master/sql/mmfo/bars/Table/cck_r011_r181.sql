

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_R011_R181.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_R011_R181 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_R011_R181'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CCK_R011_R181'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CCK_R011_R181'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_R011_R181 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_R011_R181 
   (	SS CHAR(4), 
	SN CHAR(4), 
	R011_SN CHAR(1), 
	S181_SN CHAR(1), 
	SP CHAR(4), 
	R011_SP CHAR(1), 
	S181_SP CHAR(1), 
	SPN CHAR(4), 
	R011_SPN CHAR(1), 
	S181_SPN CHAR(1), 
	SL CHAR(4), 
	R011_SL CHAR(1), 
	S181_SL CHAR(1), 
	SLN CHAR(4), 
	R011_SLN CHAR(1), 
	S181_SLN CHAR(1), 
	AIM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_R011_R181 ***
 exec bpa.alter_policies('CCK_R011_R181');


COMMENT ON TABLE BARS.CCK_R011_R181 IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.SS IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.SN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.R011_SN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.S181_SN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.SP IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.R011_SP IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.S181_SP IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.SPN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.R011_SPN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.S181_SPN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.SL IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.R011_SL IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.S181_SL IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.SLN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.R011_SLN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.S181_SLN IS '';
COMMENT ON COLUMN BARS.CCK_R011_R181.AIM IS '';




PROMPT *** Create  constraint XPK_CCK_R011_R181 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_R011_R181 ADD CONSTRAINT XPK_CCK_R011_R181 PRIMARY KEY (SS, AIM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CCK_R011_R181 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CCK_R011_R181 ON BARS.CCK_R011_R181 (SS, AIM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_R011_R181 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_R011_R181   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_R011_R181   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_R011_R181   to RCC_DEAL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CCK_R011_R181   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CCK_R011_R181   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_R011_R181.sql =========*** End ***
PROMPT ===================================================================================== 
