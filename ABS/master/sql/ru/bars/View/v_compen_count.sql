

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_COMPEN_COUNT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_COMPEN_COUNT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_COMPEN_COUNT ("TVBV", "BRANCH", "NAME", "RU_VKL", "RU_BEN", "RU_MOT", "CRKR_VKL", "CRKR_BEN", "CRKR_MOT") AS 
  SELECT f.fff tvbv,
          f.branch,
          f.name,
          f.cid ru_vkl,
          (SELECT COUNT (*)
             FROM asvo_compen_benef
            WHERE id_compen IN
                     (SELECT id
                        FROM asvo_compen
                       WHERE tvbv = f.fff AND kf = SUBSTR (f.branch, 2, 6)))
             ru_ben,
          (SELECT COUNT (*)
             FROM asvo_compen_motion
            WHERE id_compen IN
                     (SELECT id
                        FROM asvo_compen
                       WHERE tvbv = f.fff AND kf = SUBSTR (f.branch, 2, 6)))
             ru_mot,
          migraas.compen_count ('C', f.fff, SUBSTR (f.branch, 2, 6)) crkr_vkl,
          migraas.compen_count ('B', f.fff, SUBSTR (f.branch, 2, 6)) crkr_ben,
          migraas.compen_count ('M', f.fff, SUBSTR (f.branch, 2, 6)) crkr_mot
     FROM (  SELECT f.fff,
                    f.branch,
                    b.name,
                    COUNT (c.id) cid
               FROM asvo_fff_branch f, branch b, asvo_compen c
              WHERE     b.branch = f.branch
                    AND c.tvbv = f.fff
                    AND c.branch = f.branch
           GROUP BY f.fff, f.branch, b.name
           ORDER BY 1, 2) f;

PROMPT *** Create  grants  V_COMPEN_COUNT ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_COMPEN_COUNT  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_COMPEN_COUNT.sql =========*** End ***
PROMPT ===================================================================================== 
