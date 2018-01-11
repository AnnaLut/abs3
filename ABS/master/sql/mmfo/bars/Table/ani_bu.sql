

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_BU.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_BU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_BU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_BU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_BU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_BU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_BU 
   (	BRANCH VARCHAR2(30), 
	ID NUMBER(*,0), 
	D6 NUMBER, 
	D7 NUMBER, 
	S6 NUMBER, 
	S7 NUMBER, 
	K6 NUMBER, 
	K7 NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_BU ***
 exec bpa.alter_policies('ANI_BU');


COMMENT ON TABLE BARS.ANI_BU IS '';
COMMENT ON COLUMN BARS.ANI_BU.BRANCH IS '';
COMMENT ON COLUMN BARS.ANI_BU.ID IS '';
COMMENT ON COLUMN BARS.ANI_BU.D6 IS '';
COMMENT ON COLUMN BARS.ANI_BU.D7 IS '';
COMMENT ON COLUMN BARS.ANI_BU.S6 IS '';
COMMENT ON COLUMN BARS.ANI_BU.S7 IS '';
COMMENT ON COLUMN BARS.ANI_BU.K6 IS '';
COMMENT ON COLUMN BARS.ANI_BU.K7 IS '';



PROMPT *** Create  grants  ANI_BU ***
grant SELECT                                                                 on ANI_BU          to ABS_ADMIN;
grant SELECT                                                                 on ANI_BU          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI_BU          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_BU          to BARS_DM;
grant SELECT                                                                 on ANI_BU          to START1;
grant SELECT                                                                 on ANI_BU          to UPLD;
grant SELECT                                                                 on ANI_BU          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_BU.sql =========*** End *** ======
PROMPT ===================================================================================== 
