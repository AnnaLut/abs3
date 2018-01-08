

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU4.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU4 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU4'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU4'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU4'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU4 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU4 
   (	TYPE CHAR(10), 
	R020 CHAR(7), 
	OB22 CHAR(5), 
	TXT VARCHAR2(172)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU4 ***
 exec bpa.alter_policies('STRU4');


COMMENT ON TABLE BARS.STRU4 IS '';
COMMENT ON COLUMN BARS.STRU4.TYPE IS '';
COMMENT ON COLUMN BARS.STRU4.R020 IS '';
COMMENT ON COLUMN BARS.STRU4.OB22 IS '';
COMMENT ON COLUMN BARS.STRU4.TXT IS '';



PROMPT *** Create  grants  STRU4 ***
grant SELECT                                                                 on STRU4           to BARSREADER_ROLE;
grant SELECT                                                                 on STRU4           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STRU4           to BARS_DM;
grant SELECT                                                                 on STRU4           to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU4           to STRU4;
grant SELECT                                                                 on STRU4           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STRU4           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU4.sql =========*** End *** =======
PROMPT ===================================================================================== 
