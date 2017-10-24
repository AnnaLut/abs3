

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/W4_NBS_OB22.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to W4_NBS_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''W4_NBS_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''W4_NBS_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table W4_NBS_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.W4_NBS_OB22 
   (	NBS CHAR(4), 
	OB22 CHAR(2), 
	OB_9129 CHAR(2), 
	OB_OVR CHAR(2), 
	OB_2207 CHAR(2), 
	OB_2208 CHAR(2), 
	OB_2209 CHAR(2), 
	OB_3570 CHAR(2), 
	OB_3579 CHAR(2), 
	TIP CHAR(3), 
	OB_2627 CHAR(2), 
	OB_2625X CHAR(2), 
	OB_2627X CHAR(2), 
	OB_2625D CHAR(2), 
	OB_2628 CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to W4_NBS_OB22 ***
 exec bpa.alter_policies('W4_NBS_OB22');


COMMENT ON TABLE BARS.W4_NBS_OB22 IS 'W4. ���i���� ��22 � �������i ���';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2627 IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.NBS IS '���.���.���.(2625)';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB22 IS '��22 �� ���.���.���.';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_9129 IS '��22 �� 9129';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_OVR IS '��22 �� 2202';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2207 IS '��22 �� 2207';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2208 IS '��22 �� 2208';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2209 IS '��22 �� 2209';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_3570 IS '��22 �� 3570';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_3579 IS '��22 �� 3579';
COMMENT ON COLUMN BARS.W4_NBS_OB22.TIP IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2625X IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2627X IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2625D IS '';
COMMENT ON COLUMN BARS.W4_NBS_OB22.OB_2628 IS '';




PROMPT *** Create  constraint FK_W4NBSOB22_SBOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 ADD CONSTRAINT FK_W4NBSOB22_SBOB22 FOREIGN KEY (NBS, OB22)
	  REFERENCES BARS.SB_OB22 (R020, OB22) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_W4NBSOB22_W4TIPS ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 ADD CONSTRAINT FK_W4NBSOB22_W4TIPS FOREIGN KEY (TIP)
	  REFERENCES BARS.W4_TIPS (TIP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4NBSOB22_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 MODIFY (TIP CONSTRAINT CC_W4NBSOB22_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4NBSOB22_OB22_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 MODIFY (OB22 CONSTRAINT CC_W4NBSOB22_OB22_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_W4NBSOB22_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 MODIFY (NBS CONSTRAINT CC_W4NBSOB22_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_W4NBSOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.W4_NBS_OB22 ADD CONSTRAINT PK_W4NBSOB22 PRIMARY KEY (NBS, OB22, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_W4NBSOB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_W4NBSOB22 ON BARS.W4_NBS_OB22 (NBS, OB22, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  W4_NBS_OB22 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on W4_NBS_OB22     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on W4_NBS_OB22     to OW;
grant FLASHBACK,SELECT                                                       on W4_NBS_OB22     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/W4_NBS_OB22.sql =========*** End *** =
PROMPT ===================================================================================== 
