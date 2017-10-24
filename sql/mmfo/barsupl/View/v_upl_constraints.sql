

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_CONSTRAINTS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_CONSTRAINTS ***

  CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_CONSTRAINTS ("FILE_ID", "FILENAME", "ISACTIVE", "CONSTR_TYPE", "CONSTR_NAME", "KEY_FIELDS", "REF_FILEID", "REF_FILENAME", "REF_KEYFIELDS") AS 
  WITH t
        AS (SELECT a.file_id,
                   f.filename_prfx filename,
                   'PK' constr_type,
                   isactive,
                   n1
                   || CASE
                         WHEN n2 IS NOT NULL
                         THEN
                            ',' || n2
                            || (CASE
                                   WHEN n3 IS NOT NULL
                                   THEN
                                      ',' || n3
                                      || (CASE
                                             WHEN n4 IS NOT NULL
                                             THEN
                                                ',' || n4
                                             ELSE
                                                ''
                                          END)
                                   ELSE
                                      ''
                                END)
                         ELSE
                            ''
                      END
                      AS key_fields
              FROM (SELECT file_id,
                           "'1'" n1,
                           "'2'" n2,
                           "'3'" n3,
                           "'4'" n4
                      FROM (SELECT file_id,
                                   col_name,
                                   ROW_NUMBER ()
                                   OVER (PARTITION BY file_id
                                         ORDER BY file_id, pk_constr_id)
                                      n
                              FROM upl_columns
                             WHERE pk_constr = 'Y') PIVOT (MAX (col_name)
                                                    FOR n
                                                    IN ('1', '2', '3', '4'))) a,
                   upl_files f
             WHERE a.file_id = f.file_id AND f.isactive = 1)
   SELECT file_id,
          filename,
          isactive,
          constr_type,
          filename || '(' || key_fields || ')' constr_name,
          key_fields,
          NULL ref_fileid,
          NULL ref_filename,
          NULL ref_keyfields
     FROM t
   UNION ALL
   SELECT a.file_id,
          f.filename_prfx,
          f.isactive,
          'FK' constr_type,
          constr_name,
          a.key_fields,
          fk_fileid,
          t.filename,
          t.key_fields
     FROM (SELECT file_id,
                  constr_name,
                  fk_fileid,
                  n1
                  || CASE
                        WHEN n2 IS NOT NULL
                        THEN
                           ',' || n2
                           || (CASE
                                  WHEN n3 IS NOT NULL
                                  THEN
                                     ',' || n3
                                     || (CASE
                                            WHEN n4 IS NOT NULL
                                            THEN
                                               ',' || n4
                                            ELSE
                                               ''
                                         END)
                                  ELSE
                                     ''
                               END)
                        ELSE
                           ''
                     END
                     key_fields
             FROM (SELECT file_id,
                          constr_name,
                          fk_fileid,
                          "'1'" n1,
                          "'2'" n2,
                          "'3'" n3,
                          "'4'" n4
                     FROM (SELECT c.file_id,
                                  c.constr_name,
                                  fk_fileid,
                                  ROW_NUMBER ()
                                  OVER (
                                     PARTITION BY c.file_id,
                                                  c.constr_name,
                                                  fk_fileid
                                     ORDER BY
                                        c.file_id, c.constr_name, fk_colid)
                                     n,
                                  fk_colname
                             FROM upl_constraints c, upl_cons_columns cc
                            WHERE c.constr_name = cc.constr_name) PIVOT (MAX (
                                                                            fk_colname)
                                                                  FOR n
                                                                  IN  ('1',
                                                                      '2',
                                                                      '3',
                                                                      '4')))) a,
          t,
          upl_files f
    WHERE a.fk_fileid = t.file_id AND a.file_id = f.file_id;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_CONSTRAINTS.sql =========*** E
PROMPT ===================================================================================== 
