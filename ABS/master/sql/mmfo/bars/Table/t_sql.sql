

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/T_SQL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to T_SQL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''T_SQL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''T_SQL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''T_SQL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table T_SQL ***
begin 
  execute immediate '
  CREATE TABLE BARS.T_SQL 
   (	KODZ NUMBER(*,0), 
	NAME VARCHAR2(30), 
	TXT1 VARCHAR2(100), 
	TXT2 VARCHAR2(100), 
	TXT3 VARCHAR2(100), 
	TXT4 VARCHAR2(100)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to T_SQL ***
 exec bpa.alter_policies('T_SQL');


COMMENT ON TABLE BARS.T_SQL IS '';
COMMENT ON COLUMN BARS.T_SQL.KODZ IS '';
COMMENT ON COLUMN BARS.T_SQL.NAME IS '';
COMMENT ON COLUMN BARS.T_SQL.TXT1 IS '';
COMMENT ON COLUMN BARS.T_SQL.TXT2 IS '';
COMMENT ON COLUMN BARS.T_SQL.TXT3 IS '';
COMMENT ON COLUMN BARS.T_SQL.TXT4 IS '';



PROMPT *** Create  grants  T_SQL ***
grant SELECT                                                                 on T_SQL           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T_SQL           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on T_SQL           to START1;
grant SELECT                                                                 on T_SQL           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/T_SQL.sql =========*** End *** =======
PROMPT ===================================================================================== 
