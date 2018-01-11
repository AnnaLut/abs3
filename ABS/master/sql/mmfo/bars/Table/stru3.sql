

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU3.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU3 
   (	TYPE CHAR(8), 
	R020 CHAR(8), 
	OB22 CHAR(6), 
	TXT VARCHAR2(182)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU3 ***
 exec bpa.alter_policies('STRU3');


COMMENT ON TABLE BARS.STRU3 IS '';
COMMENT ON COLUMN BARS.STRU3.TYPE IS '';
COMMENT ON COLUMN BARS.STRU3.R020 IS '';
COMMENT ON COLUMN BARS.STRU3.OB22 IS '';
COMMENT ON COLUMN BARS.STRU3.TXT IS '';



PROMPT *** Create  grants  STRU3 ***
grant SELECT                                                                 on STRU3           to BARSREADER_ROLE;
grant SELECT                                                                 on STRU3           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STRU3           to BARS_DM;
grant SELECT                                                                 on STRU3           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU3           to STRU3;
grant SELECT                                                                 on STRU3           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STRU3           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU3.sql =========*** End *** =======
PROMPT ===================================================================================== 
